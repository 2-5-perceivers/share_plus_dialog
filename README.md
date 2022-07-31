# share_plus_dialog

[![pub package](https://img.shields.io/pub/v/share_plus_dialog?color=green)](https://pub.dartlang.org/packages/share_plus_dialog)

This package extends the share_plus experience on the desktop and web, by opening a dialog to select  
a web platform to send to.

![Screeshot](https://github.com/2-5-perceivers/share_plus_dialog/raw/main/images/Screenshot%20from%202022-07-30%2000-57-10.png)
![Screenshot 2](https://github.com/2-5-perceivers/share_plus_dialog/raw/main/images/Screenshot%20from%202022-07-30%2000-58-21.png)

## Features

Supported sharing platform:
* Email
* Telegram
* Whatsapp
* Reddit

  Pull request adding more are very welcome.

## Getting started

Install the package as a dependency using pub or git.

## Usage
Import the library.

```dart
import 'package:share_plus_dialog/share_plus_dialog.dart';
```

Then invoke the static  `share`  method anywhere in your Dart code.

```dart
ShareDialog.share(context, 'https://pub.dev/', platforms:  SharePlatform.defaults, isUrl: true);
```
On desktop platforms and web it will open a dialog to choose where to share. On mobile platforms it keeps the functionality from the 	`share_plus` plugin.


## Additional information

If you want to contribute a platform, setup a static SharePlatform getter inside the class and then add it to the  `defaults` list getter.
