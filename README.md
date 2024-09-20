# Share Plus Dialog

<div align="center">

  [![GitHub stars][github_stars_badge]][github_stars_link]
  [![Package: share_plus_dialog][package_badge]][package_link]
  [![Language: Dart][language_badge]][language_link]
  [![License: MIT][license_badge]][license_link]

</div>

[github_stars_badge]: https://img.shields.io/github/stars/2-5-perceivers/share_plus_dialog?style=flat&color=yellow
[github_stars_link]: https://github.com/2-5-perceivers/share_plus_dialog/stargazers
[package_badge]: https://img.shields.io/pub/v/share_plus_dialog?color=green
[package_link]: https://pub.dev/packages/share_plus_dialog
[language_badge]: https://img.shields.io/badge/language-Dart-blue
[language_link]: https://dart.dev
[license_badge]: https://img.shields.io/github/license/2-5-perceivers/share_plus_dialog
[license_link]: https://opensource.org/licenses/MIT

A Flutter package that wraps share_plus to create sharing dialogs when share_plus is not available.

![Screeshot](https://github.com/2-5-perceivers/share_plus_dialog/raw/main/images/dialog.png?raw=true)

## Features

Supported sharing platform:
* Email
* Telegram
* Whatsapp
* Reddit
* Facebook
* X (Twitter)

  Pull request adding more are very welcome.

## Installation

To use this package, add share_plus_dialog as a dependency using:
```
flutter pub add share_plus_dialog
```

## Usage
Import the library.

```dart
import 'package:share_plus_dialog/share_plus_dialog.dart';
```

Then invoke the static  `share`  method anywhere in your Dart code.

```dart
ShareDialog.share(context, body: 'https://pub.dev/', platforms:  SharePlatform.defaults);
```
On desktop platforms and web it will open a dialog to choose where to share. On mobile platforms it keeps the functionality from the 	`share_plus` plugin.