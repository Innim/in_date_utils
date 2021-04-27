## [1.0.1+1] - 2020-04-27

* **Fixed:** Methods `startOfDay()`, `startOfNextDay()`, `firstDayOfNextWeek()`, `firstDayOfWeek()` and `lastDayOfWeek()` returns invalid value for daylight saving changeover.

## [1.0.1] - 2020-03-18

* Migrated to null safety.
* **Removed** Deprecated method `getWeeksInYear()`.
* Add `innim_lint` dependency. Refactor project.

## [0.2.2] - 2020-12-11

* Method `addMonths()` - Returns the `DateTime` resulting from adding the given number of months to this `DateTime`.
* Fix `getDaysInMonth()` - For some dates it will return incorrect results, like for `DateTime(2020, 3)`.

## [0.2.1] - 2020-11-26

* Method `isFirstDayOfMonth()` - Checks if `DateTime` is in the first day of a month.
* Method `isLastDayOfMonth()` - Checks if `DateTime` is in the last day of a month.

## [0.2.0] - 2020-11-18

* Support for the defining start of the week in methods, working with weeks.
* Method `getDayNumberInYear()` - returns number of the day in year.
* Method `getDayNumberInWeek()` - returns number of the day in week.
* Method `firstDayOfFirstWeek()` - returns start of the first day of the first week in year.
* Method `getWeekNumber()` - returns number of the week in year.
* Method `getDaysDifference()` - returns count of days between two dates.
* Method `getLastWeekNumber()` - returns number of the last week in year.
* **Deprecation.** Method `getWeeksInYear()` deprecated. It returns confused value.

## [0.1.2] - 2020-11-02

* `generateWithDayStep()` - returns an interable of `DateTime` in given range with 1 day step.

## [0.1.1+1] - 2020-10-27

* Some docs translations.
* Readme: Added methods classifier.

## [0.1.1] - 2020-10-26

* Method `isSameDay()` - checks if two `DateTime` instances in the same day.
* Removed `date_utils` dependency.

## [0.1.0] - 2020-10-22

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
