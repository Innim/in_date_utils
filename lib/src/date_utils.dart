import 'package:date_utils/date_utils.dart';

/// Утилиты работы с датами.
///
/// См. также [Utils].
class DateUtils {
  /// Возвращает дату, соответствующую началу дня (00:00:00).
  /// (2020, 4, 9, 16, 50) -> (2020, 4, 9, 0, 0)
  static DateTime startOfDay(DateTime dateTime) => dateTime.subtract(Duration(
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
      microseconds: dateTime.microsecond));

  /// Возвращает дату, соответствующую началу следующего дня (00:00:00).
  /// (2020, 4, 9, 16, 50) -> (2020, 4, 10, 0, 0)
  static DateTime startOfNextDay(DateTime dateTime) =>
      dateTime.subtract(Duration(
          days: -1,
          hours: dateTime.hour,
          minutes: dateTime.minute,
          seconds: dateTime.second,
          milliseconds: dateTime.millisecond,
          microseconds: dateTime.microsecond));

  /// Возвращает дату, соответствующую началу сегодняшнего дня (00:00:00).
  static DateTime startOfToday() => startOfDay(DateTime.now());

  /// Возвращает объект даты с установленным временем.
  static DateTime setTime(DateTime date, int hours, int minutes,
          [int seconds = 0, int milliseconds = 0, int microseconds = 0]) =>
      DateTime(date.year, date.month, date.day, hours, minutes, seconds,
          milliseconds, microseconds);

  /// Возвращает объект даты, с замененными переданными значениями.
  static DateTime copyWith(DateTime date,
          {int year,
          int month,
          int day,
          int hour,
          int minute,
          int second,
          int millisecond,
          int microsecond}) =>
      DateTime(
          year ?? date.year,
          month ?? date.month,
          day ?? date.day,
          hour ?? date.hour,
          minute ?? date.minute,
          second ?? date.second,
          millisecond ?? date.millisecond,
          microsecond ?? date.microsecond);

  /// Возвращает номер следующего месяца.
  static int nextMonth(DateTime date) {
    var month = date.month;
    return month == DateTime.monthsPerYear ? 1 : month + 1;
  }

  /// Возвращает кол-во недель в заданном году.
  static int getWeeksInYear(int year) {
    var lastDayOfYear = DateTime(year, DateTime.december, 31);
    var dayOfYear = getDaysInYear(year);
    return ((dayOfYear - lastDayOfYear.weekday + 10) / 7).floor();
  }

  /// Возвращает кол-во дней в заданном году.
  static int getDaysInYear(int year) {
    var lastDayOfYear = DateTime(year, DateTime.december, 31);
    var lastDayOfPrevYear = DateTime(year - 1, DateTime.december, 31);
    var duration = lastDayOfYear.difference(lastDayOfPrevYear);
    return duration.inDays;
  }

  /// Проверяет является ли заданная дата первым днём недели.
  ///
  /// За первый день недели берется понедельник.
  static bool isFirstDayOfWeek(DateTime day) {
    return Utils.isSameDay(firstDayOfWeek(day), day);
  }

  /// Проверяет является ли заданная дата последним днём недели.
  ///
  /// За последний день недели берется воскресенье.
  static bool isLastDayOfWeek(DateTime day) {
    return Utils.isSameDay(lastDayOfWeek(day), day);
  }

  /// Возращает начало первого дня недели указанной даты.
  ///
  /// За первый день недели берется понедельник.
  /// Например: (2020, 4, 9, 15, 16) -> (2020, 4, 6, 0, 0, 0, 0).
  static DateTime firstDayOfWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(
        days: dateTime.weekday - 1,
        hours: dateTime.hour,
        minutes: dateTime.minute,
        seconds: dateTime.second,
        milliseconds: dateTime.millisecond,
        microseconds: dateTime.microsecond));
  }

  /// Возращает начало первого дня следующей недели указанной даты.
  ///
  /// За первый день недели берется понедельник.
  /// Например: (2020, 4, 9, 15, 16) -> (2020, 4, 13, 0, 0, 0, 0).
  static DateTime firstDayOfNextWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(
        days: dateTime.weekday - DateTime.daysPerWeek - 1,
        hours: dateTime.hour,
        minutes: dateTime.minute,
        seconds: dateTime.second,
        milliseconds: dateTime.millisecond,
        microseconds: dateTime.microsecond));
  }

  /// Возращает начало последнего дня недели указанной даты.
  ///
  /// За последний день недели берется воскресенье.
  /// Например: (2020, 4, 9, 15, 16) -> (2020, 4, 12, 0, 0, 0, 0).
  static DateTime lastDayOfWeek(DateTime dateTime) {
    return dateTime.add(Duration(
        days: DateTime.daysPerWeek - dateTime.weekday,
        hours: -dateTime.hour,
        minutes: -dateTime.minute,
        seconds: -dateTime.second,
        milliseconds: -dateTime.millisecond,
        microseconds: -dateTime.microsecond));
  }

  /// Возращает начало первого дня месяца указанной даты.
  /// Например: (2020, 4, 9, 15, 16) -> (2020, 4, 1, 0, 0, 0, 0).
  static DateTime firstDayOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month);
  }

  /// Возращает начало первого дня следующего месяца указанной даты.
  /// Например: (2020, 4, 9, 15, 16) -> (2020, 5, 1, 0, 0, 0, 0).
  static DateTime firstDayOfNextMonth(DateTime dateTime) {
    final month = dateTime.month;
    final year = dateTime.year;
    final nextMonthStart = (month < DateTime.monthsPerYear)
        ? DateTime(year, month + 1, 1)
        : DateTime(year + 1, 1, 1);
    return nextMonthStart;
  }

  /// Возращает начало первого дня месяца указанной даты.
  /// Например: (2020, 4, 9, 15, 16) -> (2020, 4, 30, 0, 0, 0, 0).
  static DateTime lastDayOfMonth(DateTime dateTime) {
    return firstDayOfNextMonth(dateTime).subtract(Duration(days: 1));
  }

  /// Возвращает начало первого дня года указанной даты.
  /// Например: (2020, 3, 9, 15, 16) -> (2020, 1, 1, 0, 0, 0, 0).
  static DateTime firstDayOfYear(DateTime dateTime) {
    return DateTime(dateTime.year, 1, 1);
  }

  /// Возвращает начало первого дня следующего года указанной даты.
  /// Например: (2020, 3, 9, 15, 16) -> (2021, 1, 1, 0, 0, 0, 0).
  static DateTime firstDayOfNextYear(DateTime dateTime) {
    return DateTime(dateTime.year + 1, 1, 1);
  }

  /// Возращает начало последнего дня года указанной даты.
  /// Например: (2020, 4, 9, 15, 16) -> (2020, 12, 31, 0, 0, 0, 0).
  static DateTime lastDayOfYear(DateTime dateTime) {
    return DateTime(dateTime.year, DateTime.december, 31);
  }

  /// Проверяет является ли заданная дата текущей.
  static bool isCurrentDate(DateTime date) {
    final now = DateTime.now();
    return Utils.isSameDay(date, now);
  }

  /// Возвращает кол-во дней в месяце
  static int getDaysInMonth(int year, int monthNum) {
    assert(monthNum > 0);
    assert(monthNum <= 12);
    return DateTime(year, monthNum, 0).day;
  }

  /// Получить следующий день.
  static DateTime nextDay(DateTime d) {
    return d.add(Duration(days: 1));
  }

  /// Получить предидущий день.
  static DateTime previousDay(DateTime d) {
    return d.subtract(Duration(days: 1));
  }

  /// Получить следующий год.
  static DateTime nextYear(DateTime d) {
    return DateTime(d.year + 1, d.month, d.day);
  }

  /// Получить предидущий год.
  static DateTime previousYear(DateTime d) {
    return DateTime(d.year - 1, d.month, d.day);
  }

  DateUtils._();
}
