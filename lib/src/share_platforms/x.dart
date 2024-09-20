import 'package:flutter/widgets.dart';
import 'package:share_plus_dialog/src/share_platform.dart';
import 'package:share_plus_dialog/src/socials_icons_icons.dart';

/// Share platform X
class XSharePlatform extends SharePlatform {
  @override
  Color? get color => null;

  @override
  Widget icon(BuildContext context) => const Icon(SocialsIcons.twitter);

  @override
  String get name => 'X (Twitter)';

  @override
  String launchUrl({required String body, required String subject}) =>
      'http://x.com/share?text=$subject\n$body';
}
