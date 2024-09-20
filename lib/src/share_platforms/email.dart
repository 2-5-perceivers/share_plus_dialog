import 'package:flutter/material.dart';
import 'package:share_plus_dialog/src/share_platform.dart';

/// Share platform Email
class EmailSharePlatform extends SharePlatform {
  @override
  Color? get color => null;

  @override
  Widget icon(BuildContext context) => const Icon(Icons.email_rounded);

  @override
  String get name => 'Email';

  @override
  String launchUrl({required String body, required String subject}) =>
      'mailto:?body=$body&subject=$subject';
}
