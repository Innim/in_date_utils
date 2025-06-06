## [1.2.3]

* Method `getMonthsDifference()` - returns count of months between two dates.

## [1.2.2]

* Method `isExpired()` - checks if provided `DateTime` is in the past. You can provide optional `Duration` to check if it is before specific period.

## [1.2.1]

* Method `max()` - returns the latest of two dates.
* Method `min()` - returns the earliest of two dates.

## [1.2.0+2]

* Add export `clock` package.

## [1.2.0+1]

* Remove deprecated `DateUtils`.

## [1.2.0]

* Add `clock` dependency.
* Method `now()` - returns current time.
* **BREAKING**: `DateTime.now()` changed to `clock.now()`.

## [1.1.0]

* Rename `DateUtils` to `DateTimeUtils` (to avoid conflicts with Flutter [DateUtils](https://api.flutter.dev/flutter/material/DateUtils-class.html)).
* Min Dart SDK 2.16.
* **BREAKING**: `nextYear()`/`previousYear()` now saves time and month (!).
* Method `addYears()` - Returns the `DateTime` resulting from adding the given number of years to this `DateTime`.
* Method `addWeeks()` - Returns the `DateTime` resulting from adding the given number of weeks to this `DateTime`.

## [1.0.3]

* Method `addDays()` - Returns the `DateTime` resulting from adding the given number of days to this `DateTime`.

## [1.0.2]

* All methods return result in UTC if input argument was UTC.
* **Fixed:** Method `generateWithDayStep()` returns invalid value for daylight saving changeover.
* Changed implementation of `firstDayOfFirstWeek()`. No side effects.

## [1.0.1+3]

* **Fixed:** Methods `isLastDayOfMonth()`/`lastDayOfMonth()` returns invalid value for daylight saving changeover.

## [1.0.1+2]

* **Fixed:** Methods `nextDay()`/`previousDay()` returns invalid value for daylight saving changeover.

## [1.0.1+1]

* **Fixed:** Methods `startOfDay()`, `startOfNextDay()`, `firstDayOfNextWeek()`, `firstDayOfWeek()` and `lastDayOfWeek()` returns invalid value for daylight saving changeover.

## [1.0.1]

* Migrated to null safety.
* **Removed** Deprecated method `getWeeksInYear()`.
* Add `innim_lint` dependency. Refactor project.

## [0.2.2]

* Method `addMonths()` - Returns the `DateTime` resulting from adding the given number of months to this `DateTime`.
* Fix `getDaysInMonth()` - For some dates it will return incorrect results, like for `DateTime(2020, 3)`.

## [0.2.1]

* Method `isFirstDayOfMonth()` - Checks if `DateTime` is in the first day of a month.
* Method `isLastDayOfMonth()` - Checks if `DateTime` is in the last day of a month.

## [0.2.0]

* Support for the defining start of the week in methods, working with weeks.
* Method `getDayNumberInYear()` - returns number of the day in year.
* Method `getDayNumberInWeek()` - returns number of the day in week.
* Method `firstDayOfFirstWeek()` - returns start of the first day of the first week in year.
* Method `getWeekNumber()` - returns number of the week in year.
* Method `getDaysDifference()` - returns count of days between two dates.
* Method `getLastWeekNumber()` - returns number of the last week in year.
* **Deprecation.** Method `getWeeksInYear()` deprecated. It returns confused value.

## [0.1.2]

* `generateWithDayStep()` - returns an iterable of `DateTime` in given range with 1 day step.

## [0.1.1+1]

* Some docs translations.
* Readme: Added methods classifier.

## [0.1.1]

* Method `isSameDay()` - checks if two `DateTime` instances in the same day.
* Removed `date_utils` dependency.

## [0.1.0]

* Methods to get start of the day, next day, today.
* Method to set time to date.
* Method to copy date with replace some values.
* Method to get next month number.
* Methods to get numbers of weeks and number of the days in the year.
* Methods to check for the first/last date of the week or if the current date.
* Methods to get first day of the week, next week, month, next month, year and next year.
* Methods to get last day of the week, month, next month and year.
* Method to get numbers of days in the month. 
* Methods to change date: next/previous day, next/previous year.
