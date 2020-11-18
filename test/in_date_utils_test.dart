import 'package:in_date_utils/in_date_utils.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

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

  group('firstDayOfFirstWeek()', () {
    final years = [2020, 2018, 2016];
    final expectedMonday = [
      DateTime(2019, 12, 30),
      DateTime(2018, 1, 1),
      DateTime(2016, 1, 4),
    ];
    final expectedSunday = [
      DateTime(2019, 12, 29),
      DateTime(2017, 12, 31),
      DateTime(2016, 1, 3),
    ];
    final expectedSaturday = [
      DateTime(2020, 1, 4),
      DateTime(2017, 12, 30),
      DateTime(2016, 1, 2),
    ];
    final expectedDefault = expectedMonday;

    for (var i = 0; i < years.length; i++) {
      final year = years[i];
      test('should return correct date for $year, default', () {
        expect(DateUtils.firstDayOfFirstWeek(year), expectedDefault[i]);
      });

      test('should return correct date for $year, monday', () {
        expect(
          DateUtils.firstDayOfFirstWeek(year, firstWeekday: DateTime.monday),
          expectedMonday[i],
        );
      });

      test('should return correct date for $year, sunday', () {
        expect(
          DateUtils.firstDayOfFirstWeek(year, firstWeekday: DateTime.sunday),
          expectedSunday[i],
        );
      });

      test('should return correct date for $year, saturday', () {
        expect(
          DateUtils.firstDayOfFirstWeek(year, firstWeekday: DateTime.saturday),
          expectedSaturday[i],
        );
      });
    }
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

  group('getDayNumberInYear()', () {
    test('should return 1 for the 1 jan', () {
      expect(DateUtils.getDayNumberInYear(DateTime(2020, 1, 1)), 1);
      expect(DateUtils.getDayNumberInYear(DateTime(2019, 1, 1, 15)), 1);
      expect(
        DateUtils.getDayNumberInYear(
            DateTime(2008, 1, 2).subtract(const Duration(microseconds: 1))),
        1,
      );
    });

    test('should return 2 for the 2 jan', () {
      expect(DateUtils.getDayNumberInYear(DateTime(2020, 1, 2)), 2);
      expect(
        DateUtils.getDayNumberInYear(
            DateTime(2020, 1, 2).add(const Duration(microseconds: 1))),
        2,
      );
      expect(
        DateUtils.getDayNumberInYear(
            DateTime(2020, 1, 3).subtract(const Duration(microseconds: 1))),
        2,
      );
    });

    test('should return 35 for the 4 feb', () {
      expect(DateUtils.getDayNumberInYear(DateTime(2020, 2, 4)), 35);
      expect(DateUtils.getDayNumberInYear(DateTime(2019, 2, 4, 15)), 35);
    });

    test('should return 62 for the 3 mar of non leap year', () {
      expect(DateUtils.getDayNumberInYear(DateTime(2019, 3, 3)), 62);
      expect(DateUtils.getDayNumberInYear(DateTime(2015, 3, 3, 15)), 62);
    });

    test('should return 63 for the 3 mar of leap year', () {
      expect(DateUtils.getDayNumberInYear(DateTime(2020, 3, 3)), 63);
      expect(DateUtils.getDayNumberInYear(DateTime(2008, 3, 3, 15)), 63);
    });

    test('should return 365 for the 31 dec of non leap year', () {
      expect(DateUtils.getDayNumberInYear(DateTime(2019, 12, 31)), 365);
      expect(DateUtils.getDayNumberInYear(DateTime(2015, 12, 31, 15)), 365);
    });

    test('should return 63 for the 31 dec of leap year', () {
      expect(DateUtils.getDayNumberInYear(DateTime(2020, 12, 31)), 366);
      expect(DateUtils.getDayNumberInYear(DateTime(2008, 12, 31, 15)), 366);
    });
  });

  group('getDayNumberInWeek()', () {
    final monday = DateTime(2020, 11, 2);
    final tuesday = DateTime(2020, 11, 3);
    final wednesday = DateTime(2020, 11, 4);
    final thursday = DateTime(2020, 11, 5);
    final friday = DateTime(2020, 11, 6);
    final saturday = DateTime(2020, 11, 7);
    final sunday = DateTime(2020, 11, 8);

    test('should return week day by default', () {
      expect(DateUtils.getDayNumberInWeek(monday), 1);
      expect(DateUtils.getDayNumberInWeek(tuesday), 2);
      expect(DateUtils.getDayNumberInWeek(wednesday), 3);
      expect(DateUtils.getDayNumberInWeek(thursday), 4);
      expect(DateUtils.getDayNumberInWeek(friday), 5);
      expect(DateUtils.getDayNumberInWeek(saturday), 6);
      expect(DateUtils.getDayNumberInWeek(sunday), 7);
    });

    test('should return week day with Monday as a first week day', () {
      final first = DateTime.monday;
      expect(DateUtils.getDayNumberInWeek(monday, firstWeekday: first), 1);
      expect(DateUtils.getDayNumberInWeek(tuesday, firstWeekday: first), 2);
      expect(DateUtils.getDayNumberInWeek(wednesday, firstWeekday: first), 3);
      expect(DateUtils.getDayNumberInWeek(thursday, firstWeekday: first), 4);
      expect(DateUtils.getDayNumberInWeek(friday, firstWeekday: first), 5);
      expect(DateUtils.getDayNumberInWeek(saturday, firstWeekday: first), 6);
      expect(DateUtils.getDayNumberInWeek(sunday, firstWeekday: first), 7);
    });

    test('should return correct value with Sunday as a first week day', () {
      final first = DateTime.sunday;
      expect(DateUtils.getDayNumberInWeek(monday, firstWeekday: first), 2);
      expect(DateUtils.getDayNumberInWeek(tuesday, firstWeekday: first), 3);
      expect(DateUtils.getDayNumberInWeek(wednesday, firstWeekday: first), 4);
      expect(DateUtils.getDayNumberInWeek(thursday, firstWeekday: first), 5);
      expect(DateUtils.getDayNumberInWeek(friday, firstWeekday: first), 6);
      expect(DateUtils.getDayNumberInWeek(saturday, firstWeekday: first), 7);
      expect(DateUtils.getDayNumberInWeek(sunday, firstWeekday: first), 1);
    });

    test('should return correct value with Saturday as a first week day', () {
      final first = DateTime.saturday;
      expect(DateUtils.getDayNumberInWeek(monday, firstWeekday: first), 3);
      expect(DateUtils.getDayNumberInWeek(tuesday, firstWeekday: first), 4);
      expect(DateUtils.getDayNumberInWeek(wednesday, firstWeekday: first), 5);
      expect(DateUtils.getDayNumberInWeek(thursday, firstWeekday: first), 6);
      expect(DateUtils.getDayNumberInWeek(friday, firstWeekday: first), 7);
      expect(DateUtils.getDayNumberInWeek(saturday, firstWeekday: first), 1);
      expect(DateUtils.getDayNumberInWeek(sunday, firstWeekday: first), 2);
    });
  });

  group('getDaysInYear()', () {
    [2009, 2015, 2017, 2018, 2019, 2021].forEach((year) {
      test('should return 365 for $year year', () {
        expect(DateUtils.getDaysInYear(year), 365);
      });
    });

    [2008, 2012, 2016, 2020].forEach((year) {
      test('should return 366 for the leap year $year', () {
        expect(DateUtils.getDaysInYear(year), 366);
      });
    });
  });

  group('getWeekNumber', () {
    [2008, 2009, 2013, 2014, 2015, 2018, 2019, 2020].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 1 weeks for 1 jan $year', () {
        expect(DateUtils.getWeekNumber(jan1), 1);
      });
    });

    [2008, 2013, 2014, 2018, 2019, 2020].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 1 weeks for 1 jan $year, sunday start', () {
        expect(DateUtils.getWeekNumber(jan1, firstWeekday: DateTime.sunday), 1);
      });
    });

    [2009, 2015].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 53 weeks for 1 jan $year, sunday start', () {
        expect(
          DateUtils.getWeekNumber(jan1, firstWeekday: DateTime.sunday),
          53,
        );
      });
    });

    [2010, 2016].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 53 weeks for 1 jan $year', () {
        expect(DateUtils.getWeekNumber(jan1), 53);
      });
    });

    [2011, 2012, 2017].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 52 weeks for 1 jan $year', () {
        expect(DateUtils.getWeekNumber(jan1), 52);
      });
    });

    [Tuple2(2016, 9), Tuple2(2020, 10)].forEach((item) {
      final year = item.item1;
      final expected = item.item2;
      final date = DateTime(year, 3, 3);
      test('should return $expected weeks for $date', () {
        expect(DateUtils.getWeekNumber(date), expected);
      });
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

  group('isWeekInYear()', () {
    final sunday = DateTime(2019, 12, 29);
    final monday = DateTime(2019, 12, 30);
    final tuesday = DateTime(2019, 12, 31);
    final wednesday = DateTime(2020, 1, 1);
    final thursday = DateTime(2020, 1, 2);
    final days = [sunday, monday, tuesday, wednesday, thursday];

    test('should return false for $sunday, 2020, monday', () {
      expect(DateUtils.isWeekInYear(sunday, 2020, DateTime.monday), false);
    });

    test('should return false for $sunday, 2019, monday', () {
      expect(DateUtils.isWeekInYear(sunday, 2019, DateTime.monday), true);
    });

    days.sublist(1).forEach((date) {
      test('should return false for $date, 2019, monday', () {
        expect(DateUtils.isWeekInYear(date, 2019, DateTime.monday), false);
      });

      test('should return true for $date, 2020, monday', () {
        expect(DateUtils.isWeekInYear(date, 2020, DateTime.monday), true);
      });
    });

    days.forEach((date) {
      test('should return false for $date, 2019, sunday', () {
        expect(DateUtils.isWeekInYear(date, 2019, DateTime.sunday), false);
      });

      test('should return true for $date, 2020, sunday', () {
        expect(DateUtils.isWeekInYear(date, 2020, DateTime.sunday), true);
      });

      test('should return false for $date, 2020, saturday', () {
        expect(DateUtils.isWeekInYear(date, 2020, DateTime.saturday), false);
      });

      test('should return true for $date, 2019, saturday', () {
        expect(DateUtils.isWeekInYear(date, 2019, DateTime.saturday), true);
      });
    });
  });
}
