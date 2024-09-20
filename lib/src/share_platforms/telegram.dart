import 'package:flutter/widgets.dart';
import 'package:share_plus_dialog/src/share_platform.dart';
import 'package:share_plus_dialog/src/socials_icons_icons.dart';

/// Share platform Telegram
class TelegramSharePlatform extends SharePlatform {
  @override
  Color? get color => const Color(0xff27A7E7);

  @override
  Widget icon(BuildContext context) => const Icon(SocialsIcons.telegram_plane);

  @override
  String get name => 'Telegram';

  @override
  String launchUrl({required String body, required String subject}) =>
      'https://t.me/share?url=$body&text=$subject';
}
