import 'package:in_date_utils/in_date_utils.dart';
import 'package:test/test.dart';

void main() {
  group('startOfDay()', () {
    test('should return correct date', () {
      final date = DateTime(2019, 12, 3, 18, 10, 30);
      final res = DateUtils.startOfDay(date);

      expect(res, DateTime(2019, 12, 3));
    });
  });

  group('startOfNextDay()', () {
    test('should return correct date', () {
      final date = DateTime(2019, 12, 3, 18, 10, 30);
      final res = DateUtils.startOfNextDay(date);

      expect(res, DateTime(2019, 12, 4));
    });
  });

  group('startOfToday()', () {
    test('should return correct date', () {
      final date = DateTime.now();
      final res = DateUtils.startOfToday();

      expect(res, DateTime(date.year, date.month, date.day));
    });
  });

  group('setTime()', () {
    test('should change time', () {
      final date = DateTime(2019, 12, 3, 18, 10, 30);

      expect(DateUtils.setTime(date, 12, 10).hour, 12);
      expect(DateUtils.setTime(date, 12, 10).second, 0);
      expect(DateUtils.setTime(date, 12, 10, 30).minute, 10);
      expect(DateUtils.setTime(date, 12, 10, 30).second, 30);
      expect(DateUtils.setTime(date, 12, 10, 30).millisecond, 0);
      expect(DateUtils.setTime(date, 12, 10, 30, 13).millisecond, 13);
      expect(DateUtils.setTime(date, 12, 10, 30).microsecond, 0);
      expect(DateUtils.setTime(date, 12, 10, 30, 13).microsecond, 0);
      expect(DateUtils.setTime(date, 12, 10, 30, 13, 66).microsecond, 66);
    });
  });

  group('copyWith()', () {
    test('should replace only passed values', () {
      final date = DateTime(2019, 12, 3, 18, 10, 30, 55, 66);

      expect(DateUtils.copyWith(date, year: 2020),
          DateTime(2020, 12, 3, 18, 10, 30, 55, 66));
      expect(DateUtils.copyWith(date, month: 9),
          DateTime(2019, 9, 3, 18, 10, 30, 55, 66));
      expect(DateUtils.copyWith(date, day: 12),
          DateTime(2019, 12, 12, 18, 10, 30, 55, 66));
      expect(DateUtils.copyWith(date, hour: 23),
          DateTime(2019, 12, 3, 23, 10, 30, 55, 66));
      expect(DateUtils.copyWith(date, minute: 32),
          DateTime(2019, 12, 3, 18, 32, 30, 55, 66));
      expect(DateUtils.copyWith(date, second: 44),
          DateTime(2019, 12, 3, 18, 10, 44, 55, 66));
      expect(DateUtils.copyWith(date, millisecond: 99),
          DateTime(2019, 12, 3, 18, 10, 30, 99, 66));
      expect(DateUtils.copyWith(date, microsecond: 43),
          DateTime(2019, 12, 3, 18, 10, 30, 55, 43));
      expect(DateUtils.copyWith(date, year: 2018, month: 4, hour: 10),
          DateTime(2018, 4, 3, 10, 10, 30, 55, 66));
    });
  });

  group('nextMonth()', () {
    test('nextMonth should return correct month number', () {
      expect(DateUtils.nextMonth(DateTime(2019, 1)), 2);
      expect(DateUtils.nextMonth(DateTime(2019, 12)), 1);
      expect(DateUtils.nextMonth(DateTime(2019, 13)), 2);
      expect(DateUtils.nextMonth(DateTime(2018, 6)), 7);
    });
  });

  group('firstDayOfWeek()', () {
    // sunday
    final date1 = DateTime(2019, 1, 6, 23, 59, 59, 999, 999);
    // thursday
    final date2 = DateTime(2020, 4, 9, 15);
    // sunday
    final date3 = DateTime(2020, 12, 27, 23, 59, 59, 999, 999);
    // monday
    final date4 = DateTime(2020, 11, 16, 11);

    test('should return correct date time', () {
      expect(
        DateUtils.firstDayOfWeek(date1),
        DateTime(2018, 12, 31, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date2),
        DateTime(2020, 4, 6, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date3),
        DateTime(2020, 12, 21, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date4),
        DateTime(2020, 11, 16, 0, 0, 0, 0, 0),
      );
    });

    test('should use Monday as a first week day by default', () {
      expect(
        DateUtils.firstDayOfWeek(date1),
        DateUtils.firstDayOfWeek(date1, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.firstDayOfWeek(date2),
        DateUtils.firstDayOfWeek(date2, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.firstDayOfWeek(date3),
        DateUtils.firstDayOfWeek(date3, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.firstDayOfWeek(date4),
        DateUtils.firstDayOfWeek(date4, firstWeekday: DateTime.monday),
      );
    });

    test('should return correct value for a Sunday as a first week day', () {
      final firstWeekday = DateTime.sunday;
      expect(
        DateUtils.firstDayOfWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 6, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 5, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 12, 27, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 15, 0, 0, 0, 0, 0),
      );
    });

    test('should return correct value for a Thursday as a first week day', () {
      final firstWeekday = DateTime.thursday;
      expect(
        DateUtils.firstDayOfWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 3, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 9, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 12, 24, 0, 0, 0, 0, 0),
      );
      expect(
        DateUtils.firstDayOfWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 12, 0, 0, 0, 0, 0),
      );
    });
  });

  group('firstDayOfNextWeek()', () {
    // monday
    final date1 = DateTime(2018, 12, 31, 0, 0, 0, 0, 0);
    // thursday
    final date2 = DateTime(2020, 4, 9, 15);
    // sunday
    final date3 = DateTime(2020, 4, 12, 23, 59, 59, 999, 999);
    // monday
    final date4 = DateTime(2020, 11, 16, 11);

    test('should return correct date time', () {
      expect(
        DateUtils.firstDayOfNextWeek(date1),
        DateTime(2019, 1, 07),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date2),
        DateTime(2020, 4, 13),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date3),
        DateTime(2020, 4, 13),
      );
    });

    test('should use Monday as a first week day by default', () {
      expect(
        DateUtils.firstDayOfNextWeek(date1),
        DateUtils.firstDayOfNextWeek(date1, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date2),
        DateUtils.firstDayOfNextWeek(date2, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date3),
        DateUtils.firstDayOfNextWeek(date3, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date4),
        DateUtils.firstDayOfNextWeek(date4, firstWeekday: DateTime.monday),
      );
    });

    test('should return correct value for a Sunday as a first week day', () {
      final firstWeekday = DateTime.sunday;
      expect(
        DateUtils.firstDayOfNextWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 6),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 12),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 4, 19),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 22),
      );
    });

    test('should return correct value for a Thursday as a first week day', () {
      final firstWeekday = DateTime.thursday;
      expect(
        DateUtils.firstDayOfNextWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 3),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 16),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 4, 16),
      );
      expect(
        DateUtils.firstDayOfNextWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 19),
      );
    });
  });

  group('lastDayOfWeek()', () {
    // monday
    final date1 = DateTime(2018, 12, 31, 0, 0, 0, 0, 0);
    // thursday
    final date2 = DateTime(2020, 4, 9, 15);
    // sunday
    final date3 = DateTime(2020, 4, 12, 23, 59, 59, 999, 999);
    // monday
    final date4 = DateTime(2020, 11, 16, 11);

    test('should return correct date time', () {
      expect(
        DateUtils.lastDayOfWeek(date1),
        DateTime(2019, 1, 6),
      );
      expect(
        DateUtils.lastDayOfWeek(date2),
        DateTime(2020, 4, 12),
      );
      expect(
        DateUtils.lastDayOfWeek(date3),
        DateTime(2020, 4, 12),
      );
      expect(
        DateUtils.lastDayOfWeek(date4),
        DateTime(2020, 11, 22),
      );
    });

    test('should use Monday as a first week day by default', () {
      expect(
        DateUtils.lastDayOfWeek(date1),
        DateUtils.lastDayOfWeek(date1, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.lastDayOfWeek(date2),
        DateUtils.lastDayOfWeek(date2, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.lastDayOfWeek(date3),
        DateUtils.lastDayOfWeek(date3, firstWeekday: DateTime.monday),
      );
      expect(
        DateUtils.lastDayOfWeek(date4),
        DateUtils.lastDayOfWeek(date4, firstWeekday: DateTime.monday),
      );
    });

    test('should return correct value for a Sunday as a first week day', () {
      final firstWeekday = DateTime.sunday;
      expect(
        DateUtils.lastDayOfWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 5),
      );
      expect(
        DateUtils.lastDayOfWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 11),
      );
      expect(
        DateUtils.lastDayOfWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 4, 18),
      );
      expect(
        DateUtils.lastDayOfWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 21),
      );
    });

    test('should return correct value for a Thursday as a first week day', () {
      final firstWeekday = DateTime.thursday;
      expect(
        DateUtils.lastDayOfWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 2),
      );
      expect(
        DateUtils.lastDayOfWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 15),
      );
      expect(
        DateUtils.lastDayOfWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 4, 15),
      );
      expect(
        DateUtils.lastDayOfWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 18),
      );
    });
  });

  group('firstDayOfMonth()', () {
    test('should return correct date time', () {
      expect(
          DateUtils.firstDayOfMonth(DateTime(2019, 1, 6, 23, 59, 59, 999, 999)),
          DateTime(2019, 1, 1, 0, 0, 0, 0, 0));
      expect(DateUtils.firstDayOfMonth(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 4, 1, 0, 0, 0, 0, 0));
      expect(
          DateUtils.firstDayOfMonth(
              DateTime(2020, 12, 27, 23, 59, 59, 999, 999)),
          DateTime(2020, 12, 1, 0, 0, 0, 0, 0));
    });
  });

  group('isFirstDayOfWeek()', () {
    // monday
    final monday = DateTime(2018, 12, 31);
    // monday
    final mondayWithTime = DateTime(2018, 12, 31, 14, 11);
    // thursday
    final thursday = DateTime(2020, 4, 9, 15);
    // sunday
    final sunday = DateTime(2020, 4, 12, 23, 59, 59, 999, 999);

    test('should return true if this is a first day of a week', () {
      expect(
        DateUtils.isFirstDayOfWeek(monday),
        true,
      );
      expect(
        DateUtils.isFirstDayOfWeek(monday, firstWeekday: DateTime.monday),
        true,
      );
      expect(
        DateUtils.isFirstDayOfWeek(thursday, firstWeekday: DateTime.thursday),
        true,
      );
      expect(
        DateUtils.isFirstDayOfWeek(sunday, firstWeekday: DateTime.sunday),
        true,
      );
    });

    test('should ignore time', () {
      expect(
        DateUtils.isFirstDayOfWeek(mondayWithTime),
        true,
      );
    });

    test('should return false if this is not a first day of a week', () {
      expect(
        DateUtils.isFirstDayOfWeek(thursday),
        false,
      );
      expect(
        DateUtils.isFirstDayOfWeek(sunday),
        false,
      );
      expect(
        DateUtils.isFirstDayOfWeek(thursday, firstWeekday: DateTime.monday),
        false,
      );
      expect(
        DateUtils.isFirstDayOfWeek(monday, firstWeekday: DateTime.sunday),
        false,
      );
      expect(
        DateUtils.isFirstDayOfWeek(monday, firstWeekday: DateTime.thursday),
        false,
      );
    });
  });

  group('isLastDayOfWeek()', () {
    // monday
    final monday = DateTime(2018, 12, 31);
    // thursday
    final thursday = DateTime(2020, 4, 9, 15);
    // saturday
    final saturday = DateTime(2020, 4, 11);
    // sunday
    final sunday = DateTime(2020, 4, 12);
    final sundayWithTime = DateTime(2020, 4, 12, 23, 59, 59, 999, 999);

    test('should return true if this is a last day of a week', () {
      expect(
        DateUtils.isLastDayOfWeek(sunday),
        true,
      );
      expect(
        DateUtils.isLastDayOfWeek(sunday, firstWeekday: DateTime.monday),
        true,
      );
      expect(
        DateUtils.isLastDayOfWeek(thursday, firstWeekday: DateTime.friday),
        true,
      );
      expect(
        DateUtils.isLastDayOfWeek(saturday, firstWeekday: DateTime.sunday),
        true,
      );
    });

    test('should ignore time', () {
      expect(
        DateUtils.isLastDayOfWeek(sundayWithTime),
        true,
      );
    });

    test('should return false if this is not a last day of a week', () {
      expect(
        DateUtils.isLastDayOfWeek(thursday),
        false,
      );
      expect(
        DateUtils.isLastDayOfWeek(monday),
        false,
      );
      expect(
        DateUtils.isLastDayOfWeek(thursday, firstWeekday: DateTime.monday),
        false,
      );
      expect(
        DateUtils.isLastDayOfWeek(monday, firstWeekday: DateTime.sunday),
        false,
      );
      expect(
        DateUtils.isLastDayOfWeek(sunday, firstWeekday: DateTime.sunday),
        false,
      );
      expect(
        DateUtils.isLastDayOfWeek(monday, firstWeekday: DateTime.thursday),
        false,
      );
    });
  });

  group('firstDayOfNextMonth()', () {
    test('should return correct date time', () {
      expect(DateUtils.firstDayOfNextMonth(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 5, 1, 0, 0, 0, 0, 0));
    });
  });

  group('lastDayOfMonth()', () {
    test('should return correct date time', () {
      expect(
          DateUtils.lastDayOfMonth(DateTime(2019, 1, 6, 23, 59, 59, 999, 999)),
          DateTime(2019, 1, 31, 0, 0, 0, 0, 0));
      expect(DateUtils.lastDayOfMonth(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 4, 30, 0, 0, 0, 0, 0));
      expect(
          DateUtils.lastDayOfMonth(
              DateTime(2020, 12, 27, 23, 59, 59, 999, 999)),
          DateTime(2020, 12, 31, 0, 0, 0, 0, 0));
    });
  });

  group('firstDayOfYear()', () {
    test('should return correct date time', () {
      expect(DateUtils.firstDayOfYear(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 1, 1, 0, 0, 0, 0, 0));
    });
  });

  group('firstDayOfNextYear()', () {
    test('should return correct date time', () {
      expect(DateUtils.firstDayOfNextYear(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2021, 1, 1, 0, 0, 0, 0, 0));
    });
  });

  group('lastDayOfYear()', () {
    test('should return correct date time', () {
      expect(DateUtils.lastDayOfYear(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 12, 31, 0, 0, 0, 0, 0));
    });
  });

  group('isSameDay()', () {
    test('should return true if in the same day', () {
      final d1 = DateTime(2020, 10, 26, 18, 02, 59);
      final d2 = DateTime(2020, 10, 26, 10, 02, 59);
      final d3 = DateTime(2020, 10, 26, 18, 03, 59);
      final d4 = DateTime(2020, 10, 26, 18, 02, 10);
      final d5 = DateTime(2020, 10, 26);

      expect(DateUtils.isSameDay(d1, d2), true);
      expect(DateUtils.isSameDay(d1, d3), true);
      expect(DateUtils.isSameDay(d1, d4), true);
      expect(DateUtils.isSameDay(d1, d5), true);
    });

    test('should return false if not in the same day', () {
      final d1 = DateTime(2020, 10, 26, 18, 02, 59);
      final d2 = DateTime(2021, 10, 26, 18, 02, 59);
      final d3 = DateTime(2020, 11, 25, 18, 02, 59);

      expect(DateUtils.isSameDay(d1, d2), false);
      expect(DateUtils.isSameDay(d1, d3), false);
    });
  });

  group('generateWithDayStep()', () {
    test('should include start date and exclude end', () {
      final start = DateTime(2020, 11, 02, 18, 7);
      final end = DateTime(2020, 11, 03, 17, 3);

      final res = DateUtils.generateWithDayStep(start, end);
      expect(res, [DateTime(2020, 11, 02, 18, 7)]);
    });

    test('should return start if end equals start', () {
      final start = DateTime(2020, 11, 02, 18, 7);
      final end = start;

      final res = DateUtils.generateWithDayStep(start, end);
      expect(res, [DateTime(2020, 11, 02, 18, 7)]);
    });

    test('should include dates with step 1 day', () {
      final start = DateTime(2020, 11, 02, 18, 7);
      final end = DateTime(2020, 11, 04, 19, 3);

      final res = DateUtils.generateWithDayStep(start, end);
      expect(res, [
        DateTime(2020, 11, 02, 18, 7),
        DateTime(2020, 11, 03, 18, 7),
        DateTime(2020, 11, 04, 18, 7),
      ]);
    });

    test('should handle timezone', () {
      final start = DateTime(2020, 11, 02, 18, 7).toUtc();
      final end = DateTime(2020, 11, 04, 17, 3);

      final res = DateUtils.generateWithDayStep(start, end);
      expect(res, [
        DateTime(2020, 11, 02, 18, 7).toUtc(),
        DateTime(2020, 11, 03, 18, 7).toUtc(),
      ]);
    });

    test('should return empty iterable if end less than start', () {
      final start = DateTime(2020, 11, 02, 18, 7);
      final end = DateTime(2020, 11, 01, 17, 3);

      final res = DateUtils.generateWithDayStep(start, end);
      expect(res, []);
    });
  });
}
