# in_date_utils

[![pub package](https://img.shields.io/pub/v/in_date_utils)](https://pub.dartlang.org/packages/in_date_utils)
![Tests](https://github.com/Innim/in_date_utils/workflows/Tests/badge.svg?branch=main)

Another utils for `DateTime`.

## Usage

To use this plugin, add `in_date_utils` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

Than add `import 'package:in_date_utils/in_date_utils.dart';` to the file for use extension methods.

### Example

``` dart
import 'package:list_ext/list_ext.dart';

void main() {
  final now = DateTime.now();
  
  print(now);
  // 2020-10-22 18:18:27.125878

  print(DateUtils.startOfDay(now));
  // 2020-10-22 00:00:00.000
  
  print(DateUtils.isFirstDayOfWeek(now));
  // false
  
  print(DateUtils.lastDayOfMonth(now));
  // 2020-10-31 00:00:00.000
  
  print(DateUtils.getDaysInYear(2020));
  // 366
  
  print(DateUtils.getWeeksInYear(2020));
  // 53
}
```