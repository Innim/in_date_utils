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

## Methods classifier

### Comparison

#### Is in same period

* `isSameDay()` - checks if two `DateTime` instances are on the same day.

### Checks

#### Week 

* `isFirstDayOfWeek()` - checks if provided `DateTime` is in the first day of a week (Monday).
* `isLastDayOfWeek()` - checks if provided `DateTime` is in the last day of a week (Sunday).

### Transformation

#### Next/prev

* `nextDay()`/`previousDay()` - returns same time in the next/previous day.
* `nextYear()`/`previousYear()` - returns same date in the next/previous year.

#### Start/end

* `startOfDay()` - returns `DateTime` for the beginning of the day (00:00:00).
* `startOfNextDay()` - returns `DateTime` for the beginning of the next day (00:00:00).
* `startOfToday()` - returns `DateTime` for the beginning of today (00:00:00).
* `firstDayOfWeek()` - returns `DateTime` for the beginning of the first day of the week for specified date.
* `firstDayOfNextWeek()` - returns `DateTime` for the beginning of the first day of the next week for specified date.
* `lastDayOfWeek()` - returns `DateTime` for the beginning of the last day of the week for specified date.
* `firstDayOfFirstWeek()` - returns start of the first day of the first week in year.

### Information

* `getDaysInMonth()` - returns number of days in the month of the year.
* `getDayNumberInYear()` - returns number of the day in year.
* `getDayNumberInWeek()` - returns number of the day in week.
* `getWeekNumber()` - returns number of the week in year.
* `getLastWeekNumber()` - returns number of the last week in year.
* `getDaysDifference()` - returns count of days between two dates.

### Generation

* `generateWithDayStep()` - returns an iterable of `DateTime` in given range with 1 day step.