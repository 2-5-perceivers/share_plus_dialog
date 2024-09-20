import 'package:flutter/widgets.dart';
import 'package:share_plus_dialog/src/share_platform.dart';
import 'package:share_plus_dialog/src/socials_icons_icons.dart';

/// Share platform Facebook
class FacebookSharePlatform extends SharePlatform {
  @override
  Color? get color => const Color(0xff0165E1);

  @override
  Widget icon(BuildContext context) => const Icon(SocialsIcons.facebook);

  @override
  String get name => 'Facebook';

  @override
  String launchUrl({required String body, required String subject}) =>
      'https://www.facebook.com/sharer/sharer.php?u=$subject\n$body';
}
