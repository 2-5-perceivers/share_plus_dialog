import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:share_plus_dialog/src/share_platform.dart';
import 'package:url_launcher/url_launcher.dart';

/// The dialog that displays all sharing options
class ShareDialog extends StatelessWidget {
  /// Default constructor for [ShareDialog]
  const ShareDialog(
    this.text, {
    required this.sharePlatforms,
    this.subject,
    this.isUrl = false,
    Key? key,
  }) : super(key: key);

  /// The text of the message to be shared
  final String text;

  /// The option subject of the message
  final String? subject;

  /// A list of which platforms to be displayed
  final List<SharePlatform> sharePlatforms;

  /// Indicates if the text containts an Url, so it can be coded
  final bool isUrl;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      //icon: const Icon(Icons.share), //TODO: add this back as icon gets to stable
      title: const Text('Share'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '${subject ?? ''} $text',
            style: theme.textTheme.bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: text));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                label: const Text('Copy to clipboard'),
                icon: const Icon(Icons.copy),
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 60 * 5),
            child: SingleChildScrollView(
              child: Wrap(
                children: sharePlatforms
                    .map(
                      (SharePlatform e) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            launchUrl(Uri.parse(
                                    e.getUrl(text, subject, isUrl: isUrl)))
                                .then(
                              (_) => Navigator.of(context).pop(),
                            );
                          },
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: e.color?.harmonizeWith(
                                    theme.colorScheme.primary) ??
                                theme.colorScheme.surface,
                            child: Icon(
                              e.icon,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// On dektop and web it opens the share dialog and on mobile it opens the
  /// native share dialog/modal sheet. If `isUrl` is true than the function will
  /// encode the body as a url. You can use [SharePlatform.defaults] instead of
  /// providing your own list of platforms
  static Future<void> share(
    BuildContext context,
    String text, {
    required List<SharePlatform> platforms,
    String? subject,
    bool isUrl = false,
    Rect? sharePositionOrigin,
  }) async {
    final TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.linux ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        kIsWeb) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) => ShareDialog(
          text,
          subject: subject,
          sharePlatforms: platforms,
          isUrl: isUrl,
        ),
      );
    } else {
      Share.share(
        text,
        subject: subject,
        sharePositionOrigin: sharePositionOrigin,
      );
    }
  }
}
