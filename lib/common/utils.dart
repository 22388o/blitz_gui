library sendmany.utils;

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Translates a string with the given [key] and the [args].
String tr(String key, [Map<String, dynamic> args = const <String, dynamic>{}]) {
  return translate(key, args: args);
}

/// Plurally translates a string with the given [key] and the [value].
String trp(String key, dynamic value) {
  return translatePlural(key, value);
}

/// Returns the full language name of the provided language code
LanguageDisplayData getLanguageCodeDisplayData(String code) {
  switch (code) {
    case 'de':
      return LanguageDisplayData(
        'German',
        Image.asset('assets/flags/de.png'),
      );
    case 'en':
      return LanguageDisplayData(
        'English',
        Image.asset('assets/flags/gb.png'),
      );
    case 'nb':
      return LanguageDisplayData(
        'Norwegian Bokmål',
        Image.asset('assets/flags/no.png'),
      );
    default:
      throw UnsupportedError('Language "$code" is not yet supported.');
  }
}

class LanguageDisplayData {
  final String name;
  final Image flag;

  LanguageDisplayData(this.name, this.flag);
}

/// Updates the time ago library with the current language
void updateTimeAgoLib(String lang) {
  if (lang == 'de') {
    timeago.setLocaleMessages(lang, timeago.DeMessages());
  } else if (lang == 'nb') {
    timeago.setLocaleMessages('nb', timeago.NbNoMessages());
  } else {
    timeago.setLocaleMessages(lang, timeago.EnMessages());
  }
}

int? forceInt(dynamic source) {
  if (source is int) {
    return source;
  } else if (source is double) {
    return source.floor();
  } else if (source is String) {
    return int.tryParse(source);
  }
}

double? forceDouble(dynamic source) {
  if (source is double) {
    return source;
  } else if (source is int) {
    return source.toDouble();
  } else if (source is String) {
    return double.tryParse(source);
  }
}
