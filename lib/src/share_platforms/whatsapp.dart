import 'package:flutter/widgets.dart';
import 'package:share_plus_dialog/src/share_platform.dart';
import 'package:share_plus_dialog/src/socials_icons_icons.dart';

/// Share platform WhatsApp
class WhatsAppSharePlatform extends SharePlatform {
  @override
  Color? get color => const Color(0xff5FFC7B);

  @override
  Widget icon(BuildContext context) => const Icon(SocialsIcons.whatsapp);

  @override
  String get name => 'WhatsApp';

  @override
  String launchUrl({required String body, required String subject}) =>
      'https://api.whatsapp.com/send/?text=$subject\n$body';
}
