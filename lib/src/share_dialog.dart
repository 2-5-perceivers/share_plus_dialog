import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:share_plus_dialog/src/share_platform.dart';
import 'package:url_launcher/url_launcher.dart';

/// The dialog that displays all sharing options
class ShareDialog extends StatelessWidget {
  /// Default constructor for [ShareDialog]
  const ShareDialog({
    required this.sharePlatforms,
    required this.body,
    this.subject,
    super.key,
    this.dialogTitle,
    this.dialogIcon,
    this.showCopyToClipboard = true,
    this.showDialogIcon = true,
    this.showShareBody = true,
    this.showShareSubject = true,
  });

  /// The title of the dialog.
  /// Defaults to [MaterialLocalizations.shareButtonLabel]
  final String? dialogTitle;

  /// The icon of the dialog.
  /// Defaults to Icons.adaptive.share
  final Widget? dialogIcon;

  /// Whether to show the copy to clipboard button
  final bool showCopyToClipboard;

  /// Whether to show the dialog icon
  final bool showDialogIcon;

  /// Whether to show the body of the message
  final bool showShareBody;

  /// Whether to show the subject of the message
  final bool showShareSubject;

  /// The text of the message to be shared
  final String body;

  /// The optional subject of the message
  final String? subject;

  /// A list of which platforms to be displayed
  final List<SharePlatform> sharePlatforms;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = MaterialLocalizations.of(context);

    return AlertDialog(
      icon: showDialogIcon ? (dialogIcon ?? Icon(Icons.adaptive.share)) : null,
      title: Text(dialogTitle ?? localizations.shareButtonLabel),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (showShareSubject && (subject?.isEmpty ?? false))
              Tooltip(
                message: 'Subject',
                child: Text(
                  subject!,
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            if (showShareBody && body.isNotEmpty)
              Tooltip(
                message: 'Body',
                child: Text(
                  body,
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            if (showCopyToClipboard)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: body));

                      if (!context.mounted) return;

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied to clipboard'),
                        ),
                      );
                    },
                    label: const Text('Copy to clipboard'), // TODO: Localize
                    icon: const Icon(Icons.copy_rounded),
                  ),
                ),
              ),
            Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: sharePlatforms
                    .map(
                      (sharePlatform) => FloatingActionButton(
                        tooltip: sharePlatform.name,
                        heroTag: sharePlatform.name,
                        foregroundColor: _calculateForegroundColor(
                          colorScheme,
                          sharePlatform.color,
                        ),
                        backgroundColor: sharePlatform.color ??
                            colorScheme.surfaceContainerHigh,
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(
                              sharePlatform.launchUrl(
                                body: body,
                                subject: subject ?? '',
                              ),
                            ),
                          );
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        },
                        child: Builder(
                          builder: sharePlatform.icon,
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// On dektop and web it opens the share dialog and on mobile it opens the
  /// native share dialog/modal sheet. If `isUrl` is true than the function will
  /// encode the body as a url. You can use [SharePlatform.defaults] instead of
  /// providing your own list of platforms
  static Future<void> share(
    BuildContext context, {
    required List<SharePlatform> platforms,
    required String body,
    String? subject,
    Rect? sharePositionOrigin,
    String? dialogTitle,
    Widget? dialogIcon,
    bool showCopyToClipboard = true,
    bool showDialogIcon = true,
    bool showShareBody = true,
    bool showShareSubject = true,
  }) async {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.linux ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        kIsWeb) {
      showDialog<void>(
        context: context,
        builder: (context) => ShareDialog(
          body: body,
          subject: subject,
          sharePlatforms: platforms,
          dialogIcon: dialogIcon,
          dialogTitle: dialogTitle,
          showCopyToClipboard: showCopyToClipboard,
          showDialogIcon: showDialogIcon,
          showShareBody: showShareBody,
          showShareSubject: showShareSubject,
        ),
      );
    } else {
      Share.share(
        body,
        subject: subject,
        sharePositionOrigin: sharePositionOrigin,
      );
    }
  }

  Color _calculateForegroundColor(ColorScheme colorScheme, Color? color) {
    if (color == null) return colorScheme.onSurface;

    final colorBrightness =
        color.computeLuminance() < 0.5 ? Brightness.dark : Brightness.light;
    final schemeBrightness = colorScheme.brightness;

    if (colorBrightness == schemeBrightness) {
      return colorScheme.onSurface;
    } else {
      return colorScheme.onInverseSurface;
    }
  }
}
