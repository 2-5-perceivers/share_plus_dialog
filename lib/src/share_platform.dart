import 'package:flutter/material.dart';
import 'package:share_plus_dialog/src/share_platforms/email.dart';
import 'package:share_plus_dialog/src/share_platforms/facebook.dart';
import 'package:share_plus_dialog/src/share_platforms/reddit.dart';
import 'package:share_plus_dialog/src/share_platforms/telegram.dart';
import 'package:share_plus_dialog/src/share_platforms/whatsapp.dart';
import 'package:share_plus_dialog/src/share_platforms/x.dart';

/// Share platform. Define the basic information for a share platform.
abstract class SharePlatform {
  /// The name of the platform
  String get name;

  /// The brand color of the platform
  Color? get color;

  //// Method to build the share url
  String launchUrl({required String body, required String subject});

  /// The icon of the platform
  Widget icon(BuildContext context);

  /// The default share platforms
  static List<SharePlatform> get defaults => [
        EmailSharePlatform(),
        FacebookSharePlatform(),
        RedditSharePlatform(),
        TelegramSharePlatform(),
        WhatsAppSharePlatform(),
        XSharePlatform(),
      ];
}
