# in_date_utils

[![pub package](https://img.shields.io/pub/v/in_date_utils)](https://pub.dartlang.org/packages/in_date_utils)
![Tests](https://github.com/Innim/in_date_utils/workflows/Tests/badge.svg?branch=main)

Another utils for `DateTime`.

## Usage

To use this plugin, add `in_date_utils` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

### Example

``` dart
import 'package:in_date_utils/in_date_utils.dart';

void main() {
  final now = DTU.now();
  
  print(now);
  // 2020-10-22 18:18:27.125878

  print(DTU.startOfDay(now));
  // 2020-10-22 00:00:00.000
  
  print(DTU.isFirstDayOfWeek(now));
  // false
  
  print(DTU.lastDayOfMonth(now));
  // 2020-10-31 00:00:00.000
  
  print(DTU.getDaysInYear(2020));
  // 366
  
  print(DTU.getWeeksInYear(2020));
  // 53
}
```

## Methods classifier

### Basic

* `now()` - returns current `DateTime`. 

### Comparison

#### Is in same period

* `isSameDay()` - checks if two `DateTime` instances are on the same day.

#### Max/min

* `max()` - returns the latest of two dates.
* `min()` - returns the earliest of two dates.

#### Is in range

* `isExpired()` - checks if provided `DateTime` is in the past. You can provide optional `Duration` to check if it is before specific period.

### Checks

#### Week 

* `isFirstDayOfWeek()` - checks if provided `DateTime` is in the first day of a week (Monday).
* `isLastDayOfWeek()` - checks if provided `DateTime` is in the last day of a week (Sunday).

#### Month

* `isFirstDayOfMonth()` - Checks if `DateTime` is in the first day of a month.
* `isLastDayOfMonth()` - Checks if `DateTime` is in the last day of a month.

### Transformation

#### Next/prev

* `nextDay()`/`previousDay()` - returns same time in the next/previous day.
* `nextYear()`/`previousYear()` - returns same date and time in the next/previous year.

#### Start/end

* `startOfDay()` - returns `DateTime` for the beginning of the day (00:00:00).
* `startOfNextDay()` - returns `DateTime` for the beginning of the next day (00:00:00).
* `startOfToday()` - returns `DateTime` for the beginning of today (00:00:00).
* `firstDayOfWeek()` - returns `DateTime` for the beginning of the first day of the week for specified date.
* `firstDayOfNextWeek()` - returns `DateTime` for the beginning of the first day of the next week for specified date.
* `lastDayOfWeek()` - returns `DateTime` for the beginning of the last day of the week for specified date.
* `firstDayOfFirstWeek()` - returns start of the first day of the first week in year.

#### Adding

* `addDays()`  - Returns the `DateTime` resulting from adding the given number of months to this `DateTime`.
* `addWeeks()` - Returns the `DateTime` resulting from adding the given number of weeks to this `DateTime`.
* `addMonth()` - Returns the `DateTime` resulting from adding the given number of days to this `DateTime`.
* `addYears()` - Returns the `DateTime` resulting from adding the given number of years to this `DateTime`.

### Information

* `getDaysInMonth()` - returns number of days in the month of the year.
* `getDayNumberInYear()` - returns number of the day in year.
* `getDayNumberInWeek()` - returns number of the day in week.
* `getWeekNumber()` - returns number of the week in year.
* `getLastWeekNumber()` - returns number of the last week in year.

### Difference

* `getDaysDifference()` - returns count of days between two dates.
* `getMonthsDifference()` - returns count of months between two dates.

### Generation

* `generateWithDayStep()` - returns an iterable of `DateTime` in given range with 1 day step.
