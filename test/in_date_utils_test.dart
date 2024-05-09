import 'package:in_date_utils/in_date_utils.dart';
import 'package:test/test.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

void main() {
  tz.initializeTimeZones();
  const regionLisbon = 'Europe/Lisbon';

  void testDaylight(
      DateTime date, DateTime expected, DateTime Function(DateTime date) act) {
    final res = act(_createInTimezone(date, regionLisbon));
    final resTz = _createInTimezone(res, regionLisbon);
    final expectedTz = _createInTimezone(expected, regionLisbon);

    expect(resTz, expectedTz);
  }

  group('getDaysInMonth()', () {
    test('should return correct days', () {
      expect(DTU.getDaysInMonth(2020, 2), 29);
      expect(DTU.getDaysInMonth(2021, 1), 31);
      expect(DTU.getDaysInMonth(2021, 2), 28);
      expect(DTU.getDaysInMonth(2021, 3), 31);
      expect(DTU.getDaysInMonth(2021, 4), 30);
      expect(DTU.getDaysInMonth(2021, 5), 31);
      expect(DTU.getDaysInMonth(2021, 6), 30);
      expect(DTU.getDaysInMonth(2021, 7), 31);
      expect(DTU.getDaysInMonth(2021, 8), 31);
      expect(DTU.getDaysInMonth(2021, 9), 30);
      expect(DTU.getDaysInMonth(2021, 10), 31);
      expect(DTU.getDaysInMonth(2021, 11), 30);
      expect(DTU.getDaysInMonth(2021, 12), 31);
    });
  });

  group('addMonths()', () {
    [
      Tuple3(DateTime(2020, 12, 31), DateTime(2021, 2, 28), 2),
      Tuple3(DateTime(2020, 12, 31), DateTime(2021, 1, 31), 1),
      Tuple3(DateTime(2021, 3, 31), DateTime(2021, 6, 30), 3),
      Tuple3(DateTime(2021, 3, 31), DateTime(2022, 6, 30), 15),
      Tuple3(DateTime(2021, 1, 31), DateTime(2020, 12, 31), -1),
      Tuple3(DateTime(2020, 2, 29), DateTime(2019, 2, 28), -12),
      Tuple3(DateTime(2020, 2, 29), DateTime(2024, 2, 29), 48)
    ].forEach((item) {
      final date = item.item1;
      final months = item.item3;
      final expected = item.item2;

      test('should return $expected for $date and $months', () {
        expect(DTU.addMonths(date, months), expected);
      });
    });
  });

  group('startOfDay()', () {
    test('should return correct date', () {
      final date = DateTime(2019, 12, 3, 18, 10, 30);
      final res = DTU.startOfDay(date);

      expect(res, DateTime(2019, 12, 3));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2019, 12, 3, 18, 10, 30);
      final res = DTU.startOfDay(date);

      expect(res, DateTime.utc(2019, 12, 3));
    });

    group('should consider daylight saving', () {
      test(
          'when contains changeover',
          () => testDaylight(DateTime(2021, 3, 28, 10, 20),
              DateTime(2021, 3, 28), DTU.startOfDay));

      test(
          'when does not contains changeover',
          () => testDaylight(DateTime(2021, 4, 1, 10, 20), DateTime(2021, 4, 1),
              DTU.startOfDay));
    });
  });

  group('startOfNextDay()', () {
    test('should return correct date', () {
      final date = DateTime(2019, 12, 3, 18, 10, 30);
      final res = DTU.startOfNextDay(date);

      expect(res, DateTime(2019, 12, 4));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2019, 12, 3, 18, 10, 30);
      final res = DTU.startOfNextDay(date);

      expect(res, DateTime.utc(2019, 12, 4));
    });

    group('should consider daylight saving', () {
      test(
          'when contains forward changeover',
          () => testDaylight(DateTime(2021, 3, 28, 00, 30),
              DateTime(2021, 3, 29), DTU.startOfNextDay));

      test(
          'when contains backward changeover',
          () => testDaylight(DateTime(2021, 10, 30, 01, 30),
              DateTime(2021, 10, 31), DTU.startOfNextDay));
    });
  });

  group('startOfToday()', () {
    test('should return correct date', () {
      final date = DateTime.now();
      final res = DTU.startOfToday();

      expect(res, DateTime(date.year, date.month, date.day));
    });
  });

  group('setTime()', () {
    test('should change time', () {
      final date = DateTime(2019, 12, 3, 18, 10, 30);

      expect(DTU.setTime(date, 12, 10).hour, 12);
      expect(DTU.setTime(date, 12, 10).second, 0);
      expect(DTU.setTime(date, 12, 10, 30).minute, 10);
      expect(DTU.setTime(date, 12, 10, 30).second, 30);
      expect(DTU.setTime(date, 12, 10, 30).millisecond, 0);
      expect(DTU.setTime(date, 12, 10, 30, 13).millisecond, 13);
      expect(DTU.setTime(date, 12, 10, 30).microsecond, 0);
      expect(DTU.setTime(date, 12, 10, 30, 13).microsecond, 0);
      expect(DTU.setTime(date, 12, 10, 30, 13, 66).microsecond, 66);
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2019, 12, 3, 18, 10, 30);
      final res = DTU.setTime(date, 12, 45);

      expect(res, DateTime.utc(2019, 12, 3, 12, 45));
    });
  });

  group('copyWith()', () {
    test('should replace only passed values', () {
      final date = DateTime(2019, 12, 3, 18, 10, 30, 55, 66);

      expect(DTU.copyWith(date, year: 2020),
          DateTime(2020, 12, 3, 18, 10, 30, 55, 66));
      expect(DTU.copyWith(date, month: 9),
          DateTime(2019, 9, 3, 18, 10, 30, 55, 66));
      expect(DTU.copyWith(date, day: 12),
          DateTime(2019, 12, 12, 18, 10, 30, 55, 66));
      expect(DTU.copyWith(date, hour: 23),
          DateTime(2019, 12, 3, 23, 10, 30, 55, 66));
      expect(DTU.copyWith(date, minute: 32),
          DateTime(2019, 12, 3, 18, 32, 30, 55, 66));
      expect(DTU.copyWith(date, second: 44),
          DateTime(2019, 12, 3, 18, 10, 44, 55, 66));
      expect(DTU.copyWith(date, millisecond: 99),
          DateTime(2019, 12, 3, 18, 10, 30, 99, 66));
      expect(DTU.copyWith(date, microsecond: 43),
          DateTime(2019, 12, 3, 18, 10, 30, 55, 43));
      expect(DTU.copyWith(date, year: 2018, month: 4, hour: 10),
          DateTime(2018, 4, 3, 10, 10, 30, 55, 66));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2019, 12, 3, 18, 10, 30, 55, 66);
      final res = DTU.copyWith(date, day: 12);

      expect(res, DateTime.utc(2019, 12, 12, 18, 10, 30, 55, 66));
    });
  });

  group('nextMonth()', () {
    test('nextMonth should return correct month number', () {
      expect(DTU.nextMonth(DateTime(2019, 1)), 2);
      expect(DTU.nextMonth(DateTime(2019, 12)), 1);
      expect(DTU.nextMonth(DateTime(2019, 13)), 2);
      expect(DTU.nextMonth(DateTime(2018, 6)), 7);
    });
  });

  group('nextDay()', () {
    test('should return same time in the next day', () {
      expect(
        DTU.nextDay(DateTime(2021, 6, 29, 18, 21, 34, 123, 456)),
        DateTime(2021, 6, 30, 18, 21, 34, 123, 456),
      );
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2021, 6, 29, 18, 21, 34, 123, 456);
      final res = DTU.nextDay(date);

      expect(res, DateTime.utc(2021, 6, 30, 18, 21, 34, 123, 456));
    });

    group('should consider daylight saving', () {
      test(
          'when contains forward changeover',
          () => testDaylight(DateTime(2021, 3, 28, 00, 30),
              DateTime(2021, 3, 29, 00, 30), DTU.nextDay));

      test(
          'when contains backward changeover',
          () => testDaylight(DateTime(2021, 10, 30, 02, 30),
              DateTime(2021, 10, 31, 02, 30), DTU.nextDay));
    });
  });

  group('previousDay()', () {
    test('should return same time in the previous day', () {
      expect(
        DTU.previousDay(DateTime(2021, 6, 29, 18, 21, 34, 123, 456)),
        DateTime(2021, 6, 28, 18, 21, 34, 123, 456),
      );
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2021, 6, 29, 18, 21, 34, 123, 456);
      final res = DTU.previousDay(date);

      expect(res, DateTime.utc(2021, 6, 28, 18, 21, 34, 123, 456));
    });

    group('should consider daylight saving', () {
      test(
          'when contains forward changeover',
          () => testDaylight(DateTime(2021, 3, 29, 00, 30),
              DateTime(2021, 3, 28, 00, 30), DTU.previousDay));

      test(
          'when contains backward changeover',
          () => testDaylight(DateTime(2021, 10, 31, 01, 30),
              DateTime(2021, 10, 30, 01, 30), DTU.previousDay));
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
        DTU.firstDayOfWeek(date1),
        DateTime(2018, 12, 31, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date2),
        DateTime(2020, 4, 6, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date3),
        DateTime(2020, 12, 21, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date4),
        DateTime(2020, 11, 16, 0, 0, 0, 0, 0),
      );
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2019, 1, 6, 23, 59, 59, 999, 999);
      final res = DTU.firstDayOfWeek(date);

      expect(res, DateTime.utc(2018, 12, 31, 0, 0, 0, 0, 0));
    });

    test('should use Monday as a first week day by default', () {
      expect(
        DTU.firstDayOfWeek(date1),
        DTU.firstDayOfWeek(date1, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.firstDayOfWeek(date2),
        DTU.firstDayOfWeek(date2, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.firstDayOfWeek(date3),
        DTU.firstDayOfWeek(date3, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.firstDayOfWeek(date4),
        DTU.firstDayOfWeek(date4, firstWeekday: DateTime.monday),
      );
    });

    test('should return correct value for a Sunday as a first week day', () {
      const firstWeekday = DateTime.sunday;
      expect(
        DTU.firstDayOfWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 6, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 5, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 12, 27, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 15, 0, 0, 0, 0, 0),
      );
    });

    group('should consider daylight saving', () {
      test(
          'when does not contains changeover',
          () => testDaylight(DateTime(2021, 3, 1), DateTime(2021, 2, 28),
              (d) => DTU.firstDayOfWeek(d, firstWeekday: DateTime.sunday)));

      test(
          'when contains changeover',
          () => testDaylight(DateTime(2021, 4, 1), DateTime(2021, 3, 28),
              (d) => DTU.firstDayOfWeek(d, firstWeekday: DateTime.sunday)));
    });

    test('should return correct value for a Thursday as a first week day', () {
      const firstWeekday = DateTime.thursday;
      expect(
        DTU.firstDayOfWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 3, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 9, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 12, 24, 0, 0, 0, 0, 0),
      );
      expect(
        DTU.firstDayOfWeek(date4, firstWeekday: firstWeekday),
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
        DTU.firstDayOfNextWeek(date1),
        DateTime(2019, 1, 07),
      );
      expect(
        DTU.firstDayOfNextWeek(date2),
        DateTime(2020, 4, 13),
      );
      expect(
        DTU.firstDayOfNextWeek(date3),
        DateTime(2020, 4, 13),
      );
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2020, 4, 9, 15);
      final res = DTU.firstDayOfNextWeek(date);

      expect(res, DateTime.utc(2020, 4, 13));
    });

    test('should use Monday as a first week day by default', () {
      expect(
        DTU.firstDayOfNextWeek(date1),
        DTU.firstDayOfNextWeek(date1, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.firstDayOfNextWeek(date2),
        DTU.firstDayOfNextWeek(date2, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.firstDayOfNextWeek(date3),
        DTU.firstDayOfNextWeek(date3, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.firstDayOfNextWeek(date4),
        DTU.firstDayOfNextWeek(date4, firstWeekday: DateTime.monday),
      );
    });

    test('should return correct value for a Sunday as a first week day', () {
      const firstWeekday = DateTime.sunday;
      expect(
        DTU.firstDayOfNextWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 6),
      );
      expect(
        DTU.firstDayOfNextWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 12),
      );
      expect(
        DTU.firstDayOfNextWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 4, 19),
      );
      expect(
        DTU.firstDayOfNextWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 22),
      );
    });

    test('should return correct value for a Thursday as a first week day', () {
      const firstWeekday = DateTime.thursday;
      expect(
        DTU.firstDayOfNextWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 3),
      );
      expect(
        DTU.firstDayOfNextWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 16),
      );
      expect(
        DTU.firstDayOfNextWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 4, 16),
      );
      expect(
        DTU.firstDayOfNextWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 19),
      );
    });
    group('should consider daylight saving', () {
      test(
          'when contains forward changeover',
          () => testDaylight(
              DateTime(2021, 3, 27, 10, 20),
              DateTime(2021, 4, 3),
              (d) =>
                  DTU.firstDayOfNextWeek(d, firstWeekday: DateTime.saturday)));

      test(
          'when contains backward changeover',
          () => testDaylight(
              DateTime(2021, 10, 30, 10, 20),
              DateTime(2021, 11, 6),
              (d) =>
                  DTU.firstDayOfNextWeek(d, firstWeekday: DateTime.saturday)));
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
        DTU.lastDayOfWeek(date1),
        DateTime(2019, 1, 6),
      );
      expect(
        DTU.lastDayOfWeek(date2),
        DateTime(2020, 4, 12),
      );
      expect(
        DTU.lastDayOfWeek(date3),
        DateTime(2020, 4, 12),
      );
      expect(
        DTU.lastDayOfWeek(date4),
        DateTime(2020, 11, 22),
      );
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2020, 4, 9, 15);
      final res = DTU.lastDayOfWeek(date);

      expect(res, DateTime.utc(2020, 4, 12));
    });

    test('should use Monday as a first week day by default', () {
      expect(
        DTU.lastDayOfWeek(date1),
        DTU.lastDayOfWeek(date1, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.lastDayOfWeek(date2),
        DTU.lastDayOfWeek(date2, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.lastDayOfWeek(date3),
        DTU.lastDayOfWeek(date3, firstWeekday: DateTime.monday),
      );
      expect(
        DTU.lastDayOfWeek(date4),
        DTU.lastDayOfWeek(date4, firstWeekday: DateTime.monday),
      );
    });

    test('should return correct value for a Sunday as a first week day', () {
      const firstWeekday = DateTime.sunday;
      expect(
        DTU.lastDayOfWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 5),
      );
      expect(
        DTU.lastDayOfWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 11),
      );
      expect(
        DTU.lastDayOfWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 4, 18),
      );
      expect(
        DTU.lastDayOfWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 21),
      );
    });

    test('should return correct value for a Thursday as a first week day', () {
      const firstWeekday = DateTime.thursday;
      expect(
        DTU.lastDayOfWeek(date1, firstWeekday: firstWeekday),
        DateTime(2019, 1, 2),
      );
      expect(
        DTU.lastDayOfWeek(date2, firstWeekday: firstWeekday),
        DateTime(2020, 4, 15),
      );
      expect(
        DTU.lastDayOfWeek(date3, firstWeekday: firstWeekday),
        DateTime(2020, 4, 15),
      );
      expect(
        DTU.lastDayOfWeek(date4, firstWeekday: firstWeekday),
        DateTime(2020, 11, 18),
      );
    });

    group('should consider daylight saving', () {
      test(
          'when contains forward changeover',
          () => testDaylight(
              DateTime(2020, 3, 28, 10, 20),
              DateTime(2020, 4, 3),
              (d) => DTU.lastDayOfWeek(d, firstWeekday: DateTime.saturday)));

      test(
          'when contains backward changeover',
          () => testDaylight(
              DateTime(2021, 10, 30, 10, 20),
              DateTime(2021, 11, 5),
              (d) => DTU.lastDayOfWeek(d, firstWeekday: DateTime.saturday)));
    });
  });

  group('firstDayOfMonth()', () {
    test('should return correct date time', () {
      expect(DTU.firstDayOfMonth(DateTime(2019, 1, 6, 23, 59, 59, 999, 999)),
          DateTime(2019, 1, 1, 0, 0, 0, 0, 0));
      expect(DTU.firstDayOfMonth(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 4, 1, 0, 0, 0, 0, 0));
      expect(DTU.firstDayOfMonth(DateTime(2020, 12, 27, 23, 59, 59, 999, 999)),
          DateTime(2020, 12, 1, 0, 0, 0, 0, 0));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2020, 4, 9, 15, 16);
      final res = DTU.firstDayOfMonth(date);

      expect(res, DateTime.utc(2020, 4, 1));
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
        expect(DTU.firstDayOfFirstWeek(year), expectedDefault[i]);
      });

      test('should return correct date for $year, monday', () {
        expect(
          DTU.firstDayOfFirstWeek(year, firstWeekday: DateTime.monday),
          expectedMonday[i],
        );
      });

      test('should return correct date for $year, sunday', () {
        expect(
          DTU.firstDayOfFirstWeek(year, firstWeekday: DateTime.sunday),
          expectedSunday[i],
        );
      });

      test('should return correct date for $year, saturday', () {
        expect(
          DTU.firstDayOfFirstWeek(year, firstWeekday: DateTime.saturday),
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
        DTU.isFirstDayOfWeek(monday),
        true,
      );
      expect(
        DTU.isFirstDayOfWeek(monday, firstWeekday: DateTime.monday),
        true,
      );
      expect(
        DTU.isFirstDayOfWeek(thursday, firstWeekday: DateTime.thursday),
        true,
      );
      expect(
        DTU.isFirstDayOfWeek(sunday, firstWeekday: DateTime.sunday),
        true,
      );
    });

    test('should ignore time', () {
      expect(
        DTU.isFirstDayOfWeek(mondayWithTime),
        true,
      );
    });

    test('should return false if this is not a first day of a week', () {
      expect(
        DTU.isFirstDayOfWeek(thursday),
        false,
      );
      expect(
        DTU.isFirstDayOfWeek(sunday),
        false,
      );
      expect(
        DTU.isFirstDayOfWeek(thursday, firstWeekday: DateTime.monday),
        false,
      );
      expect(
        DTU.isFirstDayOfWeek(monday, firstWeekday: DateTime.sunday),
        false,
      );
      expect(
        DTU.isFirstDayOfWeek(monday, firstWeekday: DateTime.thursday),
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
        DTU.isLastDayOfWeek(sunday),
        true,
      );
      expect(
        DTU.isLastDayOfWeek(sunday, firstWeekday: DateTime.monday),
        true,
      );
      expect(
        DTU.isLastDayOfWeek(thursday, firstWeekday: DateTime.friday),
        true,
      );
      expect(
        DTU.isLastDayOfWeek(saturday, firstWeekday: DateTime.sunday),
        true,
      );
    });

    test('should ignore time', () {
      expect(
        DTU.isLastDayOfWeek(sundayWithTime),
        true,
      );
    });

    test('should return false if this is not a last day of a week', () {
      expect(
        DTU.isLastDayOfWeek(thursday),
        false,
      );
      expect(
        DTU.isLastDayOfWeek(monday),
        false,
      );
      expect(
        DTU.isLastDayOfWeek(thursday, firstWeekday: DateTime.monday),
        false,
      );
      expect(
        DTU.isLastDayOfWeek(monday, firstWeekday: DateTime.sunday),
        false,
      );
      expect(
        DTU.isLastDayOfWeek(sunday, firstWeekday: DateTime.sunday),
        false,
      );
      expect(
        DTU.isLastDayOfWeek(monday, firstWeekday: DateTime.thursday),
        false,
      );
    });
  });

  group('isFirstDayOfMonth()', () {
    // TODO: refactor this in groups
    test('should return true if this is a first day of a month', () {
      expect(
        DTU.isFirstDayOfMonth(DateTime(2020, 11, 1)),
        true,
      );
      expect(
        DTU.isFirstDayOfMonth(DateTime(2019, 1, 1)),
        true,
      );
      expect(
        DTU.isFirstDayOfMonth(DateTime(2018, 12, 1)),
        true,
      );
      expect(
        DTU.isFirstDayOfMonth(DateTime(2017, 10, 32)),
        true,
      );
    });

    test('should ignore time', () {
      expect(
        DTU.isFirstDayOfMonth(DateTime(2020, 11, 1, 12, 13, 14)),
        true,
      );
    });

    test('should return false if this is not a first day of a month', () {
      expect(
        DTU.isFirstDayOfMonth(DateTime(2020, 11, 2)),
        false,
      );
      expect(
        DTU.isFirstDayOfMonth(DateTime(2019, 1, 5)),
        false,
      );
      expect(
        DTU.isFirstDayOfMonth(DateTime(2018, 12, 31)),
        false,
      );
      expect(
        DTU.isFirstDayOfMonth(DateTime(2017, 10, 0)),
        false,
      );
    });
  });

  group('isLastDayOfMonth()', () {
    group('should return true', () {
      [
        DateTime(2020, 11, 30),
        DateTime(2019, 1, 31),
        DateTime(2018, 12, 31),
        DateTime(2017, 10, 0),
        DateTime(2020, 2, 29),
        DateTime(2019, 2, 28),
      ].forEach((date) {
        test('for $date', () {
          expect(
            DTU.isLastDayOfMonth(date),
            true,
          );
        });
      });
    });

    test('should ignore time', () {
      expect(
        DTU.isLastDayOfMonth(DateTime(2020, 11, 30, 23, 59, 59, 999, 999)),
        true,
      );
    });

    group('should return false', () {
      [
        DateTime(2020, 11, 1),
        DateTime(2019, 1, 5),
        DateTime(2018, 12, 30),
        DateTime(2017, 10, 32),
        DateTime(2020, 2, 28),
        DateTime(2019, 2, 29),
      ].forEach((date) {
        test('for $date', () {
          expect(
            DTU.isLastDayOfMonth(date),
            false,
          );
        });
      });
    });

    group('should consider daylight saving', () {
      test('when contains forward changeover for last month day', () {
        final date =
            _createInTimezone(DateTime(2002, 3, 31, 00, 30), regionLisbon);

        final res = DTU.isLastDayOfMonth(date);
        expect(res, true);
      });

      test('when contains forward changeover for not last month day', () {
        final date =
            _createInTimezone(DateTime(2002, 3, 30, 23, 30), regionLisbon);

        final res = DTU.isLastDayOfMonth(date);
        expect(res, false);
      });

      test('when contains backward changeover for last month day', () {
        final date =
            _createInTimezone(DateTime(2021, 10, 31, 0, 30), regionLisbon);

        final res = DTU.isLastDayOfMonth(date);
        expect(res, true);
      });

      test('when contains backward changeover for not last month day', () {
        final date =
            _createInTimezone(DateTime(2021, 10, 30, 23, 30), regionLisbon);

        final res = DTU.isLastDayOfMonth(date);
        expect(res, false);
      });
    });
  });

  group('firstDayOfNextMonth()', () {
    test('should return correct date time', () {
      expect(DTU.firstDayOfNextMonth(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 5, 1, 0, 0, 0, 0, 0));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2020, 4, 9, 15, 16);
      final res = DTU.firstDayOfNextMonth(date);

      expect(res, DateTime.utc(2020, 5, 1));
    });
  });

  group('lastDayOfMonth()', () {
    test('should return correct date time', () {
      expect(DTU.lastDayOfMonth(DateTime(2019, 1, 6, 23, 59, 59, 999, 999)),
          DateTime(2019, 1, 31, 0, 0, 0, 0, 0));
      expect(DTU.lastDayOfMonth(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 4, 30, 0, 0, 0, 0, 0));
      expect(DTU.lastDayOfMonth(DateTime(2020, 12, 27, 23, 59, 59, 999, 999)),
          DateTime(2020, 12, 31, 0, 0, 0, 0, 0));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2019, 1, 6, 23, 59);
      final res = DTU.lastDayOfMonth(date);

      expect(res, DateTime.utc(2019, 1, 31));
    });

    group('should consider daylight saving', () {
      test(
          'when contains forward changeover for last month day',
          () => testDaylight(DateTime(2002, 3, 31, 00, 30),
              DateTime(2002, 3, 31), DTU.lastDayOfMonth));

      test(
          'when contains forward changeover for not last month day',
          () => testDaylight(DateTime(2002, 3, 30, 23, 30),
              DateTime(2002, 3, 31), DTU.lastDayOfMonth));

      test(
          'when contains backward changeover for last month day',
          () => testDaylight(DateTime(2021, 10, 31, 0, 30),
              DateTime(2021, 10, 31), DTU.lastDayOfMonth));

      test(
          'when contains backward changeover for not last month day',
          () => testDaylight(DateTime(2021, 10, 30, 23, 30),
              DateTime(2021, 10, 31), DTU.lastDayOfMonth));
    });
  });

  group('firstDayOfYear()', () {
    test('should return correct date time', () {
      expect(DTU.firstDayOfYear(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 1, 1, 0, 0, 0, 0, 0));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2020, 4, 9, 15, 16);
      final res = DTU.firstDayOfYear(date);

      expect(res, DateTime.utc(2020, 1, 1));
    });
  });

  group('firstDayOfNextYear()', () {
    test('should return correct date time', () {
      expect(DTU.firstDayOfNextYear(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2021, 1, 1, 0, 0, 0, 0, 0));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2020, 4, 9, 15, 16);
      final res = DTU.firstDayOfNextYear(date);

      expect(res, DateTime.utc(2021, 1, 1));
    });
  });

  group('Years', () {
    group('nextYear()', () {
      test('should return correct date', () {
        final date = DateTime(2020, 06, 15);
        expect(
          DTU.nextYear(date),
          DateTime(2021, 06, 15),
        );
      });

      test('should save time', () {
        final date = DateTime(2021, 05, 21, 14, 35, 45, 123, 456);
        expect(
          DTU.nextYear(date),
          DateTime(2022, 05, 21, 14, 35, 45, 123, 456),
        );
      });

      test('should save month', () {
        final date = DateTime(2020, 02, 29);
        expect(
          DTU.nextYear(date),
          DateTime(2021, 02, 28),
        );
      });

      test('should return utc if input is utc', () {
        final date = DateTime.utc(2020, 4, 9, 15, 16);
        expect(
          DTU.nextYear(date),
          DateTime.utc(2021, 4, 9, 15, 16),
        );
      });

      // TODO: test for daylight change
    });

    group('previousYear()', () {
      test('should return correct date', () {
        final date = DateTime(2020, 06, 15);
        expect(
          DTU.previousYear(date),
          DateTime(2019, 06, 15),
        );
      });

      test('should save time', () {
        final date = DateTime(2021, 05, 21, 14, 35, 45, 123, 456);
        expect(
          DTU.previousYear(date),
          DateTime(2020, 05, 21, 14, 35, 45, 123, 456),
        );
      });

      test('should save month', () {
        final date = DateTime(2020, 02, 29);
        expect(
          DTU.previousYear(date),
          DateTime(2019, 02, 28),
        );
      });

      test('should return utc if input is utc', () {
        final date = DateTime.utc(2020, 4, 9, 15, 16);
        expect(
          DTU.previousYear(date),
          DateTime.utc(2019, 4, 9, 15, 16),
        );
      });

      // TODO: test for daylight change
    });

    group('addYears()', () {
      [
        Tuple3(DateTime(2020, 06, 15), 1, DateTime(2021, 06, 15)),
        Tuple3(DateTime(2020, 06, 15), 13, DateTime(2033, 06, 15)),
        Tuple3(DateTime(2020, 06, 15), -5, DateTime(2015, 06, 15)),
        Tuple3(DateTime(2020, 02, 29), 13, DateTime(2033, 02, 28)),
        Tuple3(DateTime(2020, 02, 29), -4, DateTime(2016, 02, 29)),
        Tuple3(DateTime(2020, 02, 29), -5, DateTime(2015, 02, 28)),
        Tuple3(DateTime(2021, 05, 21, 14, 35, 45, 123, 456), 4,
            DateTime(2025, 05, 21, 14, 35, 45, 123, 456)),
        Tuple3(DateTime(2021, 06, 15), 0, DateTime(2021, 06, 15)),
      ].forEach((data) {
        final date = data.item1;
        final count = data.item2;
        final expected = data.item3;

        test('should return correct date and time ($date, $count)', () {
          expect(DTU.addYears(date, count), expected);
        });
      });

      test('should return utc if input is utc', () {
        final date = DateTime.utc(2020, 4, 9, 15, 16);
        expect(
          DTU.addYears(date, 3),
          DateTime.utc(2023, 4, 9, 15, 16),
        );
      });

      // TODO: test for daylight change
    });
  });

  group('lastDayOfYear()', () {
    test('should return correct date time', () {
      expect(DTU.lastDayOfYear(DateTime(2020, 4, 9, 15, 16)),
          DateTime(2020, 12, 31, 0, 0, 0, 0, 0));
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2020, 4, 9, 15, 16);
      final res = DTU.lastDayOfYear(date);

      expect(res, DateTime.utc(2020, 12, 31));
    });
  });

  group('isSameDay()', () {
    test('should return true if in the same day', () {
      final d1 = DateTime(2020, 10, 26, 18, 02, 59);
      final d2 = DateTime(2020, 10, 26, 10, 02, 59);
      final d3 = DateTime(2020, 10, 26, 18, 03, 59);
      final d4 = DateTime(2020, 10, 26, 18, 02, 10);
      final d5 = DateTime(2020, 10, 26);

      expect(DTU.isSameDay(d1, d2), true);
      expect(DTU.isSameDay(d1, d3), true);
      expect(DTU.isSameDay(d1, d4), true);
      expect(DTU.isSameDay(d1, d5), true);
    });

    test('should return false if not in the same day', () {
      final d1 = DateTime(2020, 10, 26, 18, 02, 59);
      final d2 = DateTime(2021, 10, 26, 18, 02, 59);
      final d3 = DateTime(2020, 11, 25, 18, 02, 59);

      expect(DTU.isSameDay(d1, d2), false);
      expect(DTU.isSameDay(d1, d3), false);
    });
  });

  group('max()', () {
    test('should return second date if it is after the first', () {
      final d1 = DateTime(2020, 10, 26, 10, 02, 58, 123, 456);
      final d2 = DateTime(2020, 10, 26, 10, 02, 58, 123, 457);
      final d3 = DateTime(2020, 10, 26, 10, 02, 58, 124, 456);
      final d4 = DateTime(2020, 10, 26, 10, 02, 59, 123, 456);
      final d5 = DateTime(2020, 10, 26, 10, 03, 57, 123, 456);
      final d6 = DateTime(2020, 10, 26, 18, 02, 10, 123, 456);
      final d7 = DateTime(2020, 10, 27, 10, 02, 58, 123, 456);
      final d8 = DateTime(2020, 11, 26, 10, 02, 58, 123, 456);
      final d9 = DateTime(2021, 10, 26, 10, 02, 58, 123, 456);

      expect(DTU.max(d1, d2), d2);
      expect(DTU.max(d1, d3), d3);
      expect(DTU.max(d1, d4), d4);
      expect(DTU.max(d1, d5), d5);
      expect(DTU.max(d1, d6), d6);
      expect(DTU.max(d1, d7), d7);
      expect(DTU.max(d1, d8), d8);
      expect(DTU.max(d1, d9), d9);
    });

    test('should return first date if it is after the second', () {
      final d1 = DateTime(2020, 10, 26, 10, 02, 58, 123, 456);
      final d2 = DateTime(2020, 10, 26, 10, 02, 58, 123, 455);
      final d3 = DateTime(2020, 10, 26, 10, 02, 58, 122, 456);
      final d4 = DateTime(2020, 10, 26, 10, 02, 57, 123, 456);
      final d5 = DateTime(2020, 10, 26, 10, 01, 59, 123, 456);
      final d6 = DateTime(2020, 10, 26, 08, 02, 58, 123, 456);
      final d7 = DateTime(2020, 10, 25, 10, 02, 58, 123, 456);
      final d8 = DateTime(2020, 09, 26, 10, 02, 58, 123, 456);
      final d9 = DateTime(2019, 10, 26, 10, 02, 58, 123, 456);

      expect(DTU.max(d1, d2), d1);
      expect(DTU.max(d1, d3), d1);
      expect(DTU.max(d1, d4), d1);
      expect(DTU.max(d1, d5), d1);
      expect(DTU.max(d1, d6), d1);
      expect(DTU.max(d1, d7), d1);
      expect(DTU.max(d1, d8), d1);
      expect(DTU.max(d1, d9), d1);
    });

    test('should return either first or second date if they equals', () {
      final d1 = DateTime(2020, 10, 26, 18, 02, 59, 123, 456);
      final d2 = DateTime(2020, 10, 26, 18, 02, 59, 123, 456);

      final res = DTU.max(d1, d2);

      expect(res == d1, true);
      expect(res == d2, true);
    });
  });

  group('min()', () {
    test('should return second date if it is before the first', () {
      final d1 = DateTime(2020, 10, 26, 10, 02, 58, 123, 456);
      final d2 = DateTime(2020, 10, 26, 10, 02, 58, 123, 455);
      final d3 = DateTime(2020, 10, 26, 10, 02, 58, 122, 456);
      final d4 = DateTime(2020, 10, 26, 10, 02, 57, 123, 456);
      final d5 = DateTime(2020, 10, 26, 10, 01, 59, 123, 456);
      final d6 = DateTime(2020, 10, 26, 08, 02, 58, 123, 456);
      final d7 = DateTime(2020, 10, 25, 10, 02, 58, 123, 456);
      final d8 = DateTime(2020, 09, 26, 10, 02, 58, 123, 456);
      final d9 = DateTime(2019, 10, 26, 10, 02, 58, 123, 456);

      expect(DTU.min(d1, d2), d2);
      expect(DTU.min(d1, d3), d3);
      expect(DTU.min(d1, d4), d4);
      expect(DTU.min(d1, d5), d5);
      expect(DTU.min(d1, d6), d6);
      expect(DTU.min(d1, d7), d7);
      expect(DTU.min(d1, d8), d8);
      expect(DTU.min(d1, d9), d9);
    });

    test('should return first date if it is before the second', () {
      final d1 = DateTime(2020, 10, 26, 10, 02, 58, 123, 456);
      final d2 = DateTime(2020, 10, 26, 10, 02, 58, 123, 457);
      final d3 = DateTime(2020, 10, 26, 10, 02, 58, 124, 456);
      final d4 = DateTime(2020, 10, 26, 10, 02, 59, 123, 456);
      final d5 = DateTime(2020, 10, 26, 10, 03, 57, 123, 456);
      final d6 = DateTime(2020, 10, 26, 18, 02, 10, 123, 456);
      final d7 = DateTime(2020, 10, 27, 10, 02, 58, 123, 456);
      final d8 = DateTime(2020, 11, 26, 10, 02, 58, 123, 456);
      final d9 = DateTime(2021, 10, 26, 10, 02, 58, 123, 456);

      expect(DTU.min(d1, d2), d1);
      expect(DTU.min(d1, d3), d1);
      expect(DTU.min(d1, d4), d1);
      expect(DTU.min(d1, d5), d1);
      expect(DTU.min(d1, d6), d1);
      expect(DTU.min(d1, d7), d1);
      expect(DTU.min(d1, d8), d1);
      expect(DTU.min(d1, d9), d1);
    });

    test('should return either first or second date if they equals', () {
      final d1 = DateTime(2020, 10, 26, 18, 02, 59, 123, 456);
      final d2 = DateTime(2020, 10, 26, 18, 02, 59, 123, 456);

      final res = DTU.min(d1, d2);

      expect(res == d1, true);
      expect(res == d2, true);
    });
  });

  group('getDayNumberInYear()', () {
    test('should return 1 for the 1 jan', () {
      expect(DTU.getDayNumberInYear(DateTime(2020, 1, 1)), 1);
      expect(DTU.getDayNumberInYear(DateTime(2019, 1, 1, 15)), 1);
      expect(
        DTU.getDayNumberInYear(
            DateTime(2008, 1, 2).subtract(const Duration(microseconds: 1))),
        1,
      );
    });

    test('should return 2 for the 2 jan', () {
      expect(DTU.getDayNumberInYear(DateTime(2020, 1, 2)), 2);
      expect(
        DTU.getDayNumberInYear(
            DateTime(2020, 1, 2).add(const Duration(microseconds: 1))),
        2,
      );
      expect(
        DTU.getDayNumberInYear(
            DateTime(2020, 1, 3).subtract(const Duration(microseconds: 1))),
        2,
      );
    });

    test('should return 35 for the 4 feb', () {
      expect(DTU.getDayNumberInYear(DateTime(2020, 2, 4)), 35);
      expect(DTU.getDayNumberInYear(DateTime(2019, 2, 4, 15)), 35);
    });

    test('should return 62 for the 3 mar of non leap year', () {
      expect(DTU.getDayNumberInYear(DateTime(2019, 3, 3)), 62);
      expect(DTU.getDayNumberInYear(DateTime(2015, 3, 3, 15)), 62);
    });

    test('should return 63 for the 3 mar of leap year', () {
      expect(DTU.getDayNumberInYear(DateTime(2020, 3, 3)), 63);
      expect(DTU.getDayNumberInYear(DateTime(2008, 3, 3, 15)), 63);
    });

    test('should return 365 for the 31 dec of non leap year', () {
      expect(DTU.getDayNumberInYear(DateTime(2019, 12, 31)), 365);
      expect(DTU.getDayNumberInYear(DateTime(2015, 12, 31, 15)), 365);
    });

    test('should return 63 for the 31 dec of leap year', () {
      expect(DTU.getDayNumberInYear(DateTime(2020, 12, 31)), 366);
      expect(DTU.getDayNumberInYear(DateTime(2008, 12, 31, 15)), 366);
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
      expect(DTU.getDayNumberInWeek(monday), 1);
      expect(DTU.getDayNumberInWeek(tuesday), 2);
      expect(DTU.getDayNumberInWeek(wednesday), 3);
      expect(DTU.getDayNumberInWeek(thursday), 4);
      expect(DTU.getDayNumberInWeek(friday), 5);
      expect(DTU.getDayNumberInWeek(saturday), 6);
      expect(DTU.getDayNumberInWeek(sunday), 7);
    });

    test('should return week day with Monday as a first week day', () {
      const first = DateTime.monday;
      expect(DTU.getDayNumberInWeek(monday, firstWeekday: first), 1);
      expect(DTU.getDayNumberInWeek(tuesday, firstWeekday: first), 2);
      expect(DTU.getDayNumberInWeek(wednesday, firstWeekday: first), 3);
      expect(DTU.getDayNumberInWeek(thursday, firstWeekday: first), 4);
      expect(DTU.getDayNumberInWeek(friday, firstWeekday: first), 5);
      expect(DTU.getDayNumberInWeek(saturday, firstWeekday: first), 6);
      expect(DTU.getDayNumberInWeek(sunday, firstWeekday: first), 7);
    });

    test('should return correct value with Sunday as a first week day', () {
      const first = DateTime.sunday;
      expect(DTU.getDayNumberInWeek(monday, firstWeekday: first), 2);
      expect(DTU.getDayNumberInWeek(tuesday, firstWeekday: first), 3);
      expect(DTU.getDayNumberInWeek(wednesday, firstWeekday: first), 4);
      expect(DTU.getDayNumberInWeek(thursday, firstWeekday: first), 5);
      expect(DTU.getDayNumberInWeek(friday, firstWeekday: first), 6);
      expect(DTU.getDayNumberInWeek(saturday, firstWeekday: first), 7);
      expect(DTU.getDayNumberInWeek(sunday, firstWeekday: first), 1);
    });

    test('should return correct value with Saturday as a first week day', () {
      const first = DateTime.saturday;
      expect(DTU.getDayNumberInWeek(monday, firstWeekday: first), 3);
      expect(DTU.getDayNumberInWeek(tuesday, firstWeekday: first), 4);
      expect(DTU.getDayNumberInWeek(wednesday, firstWeekday: first), 5);
      expect(DTU.getDayNumberInWeek(thursday, firstWeekday: first), 6);
      expect(DTU.getDayNumberInWeek(friday, firstWeekday: first), 7);
      expect(DTU.getDayNumberInWeek(saturday, firstWeekday: first), 1);
      expect(DTU.getDayNumberInWeek(sunday, firstWeekday: first), 2);
    });
  });

  group('getDaysInYear()', () {
    [2009, 2015, 2017, 2018, 2019, 2021].forEach((year) {
      test('should return 365 for $year year', () {
        expect(DTU.getDaysInYear(year), 365);
      });
    });

    [2008, 2012, 2016, 2020].forEach((year) {
      test('should return 366 for the leap year $year', () {
        expect(DTU.getDaysInYear(year), 366);
      });
    });
  });

  group('getDaysDifference()', () {
    [
      Tuple3(DateTime(2020, 11, 18, 16, 50), DateTime(2020, 11, 19, 10, 0), 1),
      Tuple3(DateTime(2020, 11, 19, 10, 0), DateTime(2020, 11, 18, 16, 50), 1),
      Tuple3(DateTime(2020, 11, 19),
          DateTime(2020, 11, 21).subtract(const Duration(microseconds: 1)), 1),
      Tuple3(DateTime(2010), DateTime(2011), 365),
      Tuple3(DateTime(2011), DateTime(2012), 365),
      Tuple3(DateTime(2012), DateTime(2013), 366),
      Tuple3(DateTime(2013), DateTime(2014), 365),
      Tuple3(DateTime(2020), DateTime(2021), 366),
    ].forEach((item) {
      final a = item.item1;
      final b = item.item2;
      final expected = item.item3;
      test('should return $expected for $a and $b', () {
        expect(DTU.getDaysDifference(a, b), expected);
      });
    });
  });

  group('getWeekNumber()', () {
    [2008, 2009, 2013, 2014, 2015, 2018, 2019, 2020].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 1 weeks for 1 jan $year', () {
        expect(DTU.getWeekNumber(jan1), 1);
      });
    });

    [2008, 2013, 2014, 2018, 2019, 2020].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 1 weeks for 1 jan $year, sunday start', () {
        expect(DTU.getWeekNumber(jan1, firstWeekday: DateTime.sunday), 1);
      });
    });

    [2009, 2015].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 53 weeks for 1 jan $year, sunday start', () {
        expect(
          DTU.getWeekNumber(jan1, firstWeekday: DateTime.sunday),
          53,
        );
      });
    });

    [2010, 2016].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 53 weeks for 1 jan $year', () {
        expect(DTU.getWeekNumber(jan1), 53);
      });
    });

    [2011, 2012, 2017].forEach((year) {
      final jan1 = DateTime(year, 1, 1);
      test('should return 52 weeks for 1 jan $year', () {
        expect(DTU.getWeekNumber(jan1), 52);
      });
    });

    [Tuple2(2016, 9), Tuple2(2020, 10)].forEach((item) {
      final year = item.item1;
      final expected = item.item2;
      final date = DateTime(year, 3, 3);
      test('should return $expected weeks for $date', () {
        expect(DTU.getWeekNumber(date), expected);
      });
    });
  });

  group('getLastWeekNumber()', () {
    [2009, 2015].forEach((year) {
      test('should return 53 weeks for $year', () {
        expect(DTU.getLastWeekNumber(year), 53);
      });
    });

    [2008, 2012, 2013, 2014, 2016, 2017].forEach((year) {
      test('should return 52 weeks for $year', () {
        expect(DTU.getLastWeekNumber(year), 52);
      });
    });

    [2010, 2011, 2012, 2013, 2015, 2016, 2017, 2018, 2019].forEach((year) {
      test('should return 52 weeks for $year, week from sunday', () {
        expect(
          DTU.getLastWeekNumber(year, firstWeekday: DateTime.sunday),
          52,
        );
      });
    });

    [2008, 2014, 2020].forEach((year) {
      test('should return 53 weeks for $year, week from sunday', () {
        expect(
          DTU.getLastWeekNumber(year, firstWeekday: DateTime.sunday),
          53,
        );
      });
    });
  });

  group('generateWithDayStep()', () {
    test('should include start date and exclude end', () {
      final start = DateTime(2020, 11, 02, 18, 7);
      final end = DateTime(2020, 11, 03, 17, 3);

      final res = DTU.generateWithDayStep(start, end);
      expect(res, [DateTime(2020, 11, 02, 18, 7)]);
    });

    test('should return start if end equals start', () {
      final start = DateTime(2020, 11, 02, 18, 7);
      final end = start;

      final res = DTU.generateWithDayStep(start, end);
      expect(res, [DateTime(2020, 11, 02, 18, 7)]);
    });

    test('should include dates with step 1 day', () {
      final start = DateTime(2020, 11, 02, 18, 7);
      final end = DateTime(2020, 11, 04, 19, 3);

      final res = DTU.generateWithDayStep(start, end);
      expect(res, [
        DateTime(2020, 11, 02, 18, 7),
        DateTime(2020, 11, 03, 18, 7),
        DateTime(2020, 11, 04, 18, 7),
      ]);
    });

    test('should handle timezone', () {
      final start = DateTime(2020, 11, 02, 18, 7).toUtc();
      final end = DateTime(2020, 11, 04, 17, 3);

      final res = DTU.generateWithDayStep(start, end);
      expect(res, [
        DateTime(2020, 11, 02, 18, 7).toUtc(),
        DateTime(2020, 11, 03, 18, 7).toUtc(),
      ]);
    });

    test('should return empty iterable if end less than start', () {
      final start = DateTime(2020, 11, 02, 18, 7);
      final end = DateTime(2020, 11, 01, 17, 3);

      final res = DTU.generateWithDayStep(start, end);
      expect(res, <DateTime>[]);
    });

    group('should consider daylight saving', () {
      void testDaylightSaving(
          DateTime start, DateTime end, List<DateTime> expected) {
        DateTime tz(DateTime d) => _createInTimezone(d, regionLisbon);
        final res = DTU.generateWithDayStep(tz(start), tz(end));
        final resTz = res.map(tz);
        final expectedTz = expected.map(tz);

        expect(resTz, expectedTz);
      }

      test(
          'when contains forward changeover',
          () => testDaylightSaving(
                DateTime(2002, 3, 29, 01, 30),
                DateTime(2002, 4, 2, 02, 30),
                [
                  DateTime(2002, 3, 29, 01, 30),
                  DateTime(2002, 3, 30, 01, 30),
                  DateTime(2002, 3, 31, 01, 30),
                  DateTime(2002, 4, 01, 01, 30),
                  DateTime(2002, 4, 02, 01, 30),
                ],
              ));

      test(
          'when contains backward changeover',
          () => testDaylightSaving(
                DateTime(2021, 10, 30, 01, 30),
                DateTime(2021, 11, 2, 02, 30),
                [
                  DateTime(2021, 10, 30, 01, 30),
                  DateTime(2021, 10, 31, 01, 30),
                  DateTime(2021, 11, 01, 01, 30),
                  DateTime(2021, 11, 02, 01, 30),
                ],
              ));
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
      expect(DTU.isWeekInYear(sunday, 2020, DateTime.monday), false);
    });

    test('should return false for $sunday, 2019, monday', () {
      expect(DTU.isWeekInYear(sunday, 2019, DateTime.monday), true);
    });

    days.sublist(1).forEach((date) {
      test('should return false for $date, 2019, monday', () {
        expect(DTU.isWeekInYear(date, 2019, DateTime.monday), false);
      });

      test('should return true for $date, 2020, monday', () {
        expect(DTU.isWeekInYear(date, 2020, DateTime.monday), true);
      });
    });

    days.forEach((date) {
      test('should return false for $date, 2019, sunday', () {
        expect(DTU.isWeekInYear(date, 2019, DateTime.sunday), false);
      });

      test('should return true for $date, 2020, sunday', () {
        expect(DTU.isWeekInYear(date, 2020, DateTime.sunday), true);
      });

      test('should return false for $date, 2020, saturday', () {
        expect(DTU.isWeekInYear(date, 2020, DateTime.saturday), false);
      });

      test('should return true for $date, 2019, saturday', () {
        expect(DTU.isWeekInYear(date, 2019, DateTime.saturday), true);
      });
    });
  });

  group('addDays()', () {
    [
      Tuple3(DateTime(2022, 12, 31), DateTime(2023, 1, 14), 14),
      Tuple3(DateTime(2022, 12, 31), DateTime(2023, 1, 31), 31),
      Tuple3(DateTime(2022, 12, 31), DateTime(2023, 2, 1), 32),
      Tuple3(DateTime(2022, 2, 15), DateTime(2022, 3, 1), 14),
      Tuple3(DateTime(2022, 1, 31), DateTime(2021, 12, 31), -31),
      Tuple3(DateTime(2020, 2, 15), DateTime(2020, 2, 29), 14),
      Tuple3(DateTime(2022, 12, 31), DateTime(2024, 1, 1), 366)
    ].forEach((item) {
      final date = item.item1;
      final days = item.item3;
      final expected = item.item2;

      test('should return $expected for $date and $days', () {
        expect(DTU.addDays(date, days), expected);
      });
    });
  });

  group('addWeeks()', () {
    [
      Tuple3(DateTime(2020, 12, 31), 1, DateTime(2021, 01, 07)),
      Tuple3(DateTime(2020, 12, 31), 14, DateTime(2021, 04, 08)),
      Tuple3(DateTime(2020, 01, 01), 104, DateTime(2021, 12, 29)),
      Tuple3(DateTime(2020, 06, 15), -5, DateTime(2020, 05, 11)),
      Tuple3(DateTime(2021, 05, 21, 14, 35, 45, 123, 456), 2,
          DateTime(2021, 06, 04, 14, 35, 45, 123, 456)),
      Tuple3(DateTime(2021, 06, 15), 0, DateTime(2021, 06, 15)),
    ].forEach((data) {
      final date = data.item1;
      final count = data.item2;
      final expected = data.item3;

      test('should return correct date and time ($date, $count)', () {
        expect(DTU.addWeeks(date, count), expected);
      });
    });

    test('should return utc if input is utc', () {
      final date = DateTime.utc(2020, 4, 9, 15, 16);
      expect(
        DTU.addWeeks(date, 3),
        DateTime.utc(2020, 4, 30, 15, 16),
      );
    });

    // TODO: test for daylight change
  });
}

/// [locationName] should be value from the database represents
/// a national region where all clocks keeping local time have agreed since 1970.
/// TZ database https://www.iana.org/time-zones
/// You can find a list at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
DateTime _createInTimezone(DateTime date, String locationName) {
  final location = tz.getLocation(locationName);
  final tzDate = tz.TZDateTime(location, date.year, date.month, date.day,
      date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  return tzDate;
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}

class Tuple3<T1, T2, T3> {
  final T1 item1;
  final T2 item2;
  final T3 item3;

  Tuple3(this.item1, this.item2, this.item3);
}
