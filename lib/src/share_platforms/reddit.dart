import 'package:flutter/widgets.dart';
import 'package:share_plus_dialog/src/share_platform.dart';
import 'package:share_plus_dialog/src/socials_icons_icons.dart';

/// Share platform Reddit
class RedditSharePlatform extends SharePlatform {
  @override
  Color? get color => const Color(0xffFF4500);

  @override
  Widget icon(BuildContext context) => const Icon(SocialsIcons.reddit_alien);

  @override
  String get name => 'Reddit';

  @override
  String launchUrl({required String body, required String subject}) =>
      'https://www.reddit.com/submit?text=$body&title=$subject';
}
