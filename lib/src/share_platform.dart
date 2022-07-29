import 'package:flutter/material.dart';

/// A web sharing platform that also represents how the widget is build
/// To create your own use the constructor as this example:
///
/// ```dart
/// SharePlatform(
///     'Email',
///     urlSchema: 'mailto:?body=|body|&subject=|subject|',
///     icon: Icons.email,
/// );
/// ```
///
/// You are free to expand this class and override the getUrl function
class SharePlatform {
  /// Creates a new sharing platform
  const SharePlatform(
    this.name, {
    required this.urlSchema,
    required this.icon,
    this.color,
  });

  /// The name of the platform
  final String name;

  /// The icon of the platform that is shown in the dialog
  final IconData icon;

  /// A background color that is show behind the icon. Note: this color will be
  /// harmonized
  final MaterialColor? color;

  /// A schema to create the url to be opened for sharing. Use `|body|` and
  /// `|subject|` to insert variables. Example:
  ///
  /// `mailto:?body=|body|&subject=|subject|`
  final String urlSchema;

  /// Get's the procesed schema. If `isUrl` is true than the function will
  /// encode the body as a url
  String getUrl(String body, String? subject, {bool isUrl = false}) {
    subject ??= '';
    if (isUrl) {
      body = Uri.encodeComponent(body);
    }
    String url = urlSchema;
    url = url.replaceAll('|body|', body).replaceAll('|subject|', subject);
    return url;
  }

  /// Share platform Email - body and subject have the same definition as in an
  /// email
  static SharePlatform get email => const SharePlatform(
        'Email',
        urlSchema: 'mailto:?body=|body|&subject=|subject|',
        icon: Icons.email,
      );

  /// Share platform Telegram - here body is used for a link and subject as the
  /// text below the link.
  static SharePlatform get telegram => const SharePlatform(
        'Telegram',
        urlSchema: 'https://t.me/share?url=|body|&text=|subject|',
        icon: Icons.telegram,
        color: Colors.blue,
      );

  /// Share platform Whatsapp - here subject is ignored
  static SharePlatform get whatsapp => const SharePlatform(
        'Whatsapp',
        urlSchema: 'https://api.whatsapp.com/send/?text=|body|',
        icon: Icons.whatsapp,
        color: Colors.green,
      );

  /// Share platform Reddit
  static SharePlatform get reddit => const SharePlatform(
        'Reddit',
        urlSchema: 'https://www.reddit.com/submit?text=|body|&title=|subject|',
        icon: Icons.reddit,
        color: Colors.red,
      );

  /// A list of all default platforms
  static List<SharePlatform> get defaults => <SharePlatform>[
        email,
        telegram,
        whatsapp,
        reddit,
      ];
}
