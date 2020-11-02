import 'package:in_date_utils/in_date_utils.dart';
import 'package:test/test.dart';

void main() {
  test('startOfDay should return correct date', () {
    final date = DateTime(2019, 12, 3, 18, 10, 30);
    final res = DateUtils.startOfDay(date);

    expect(res, DateTime(2019, 12, 3));
  });

  test('startOfNextDay should return correct date', () {
    final date = DateTime(2019, 12, 3, 18, 10, 30);
    final res = DateUtils.startOfNextDay(date);

    expect(res, DateTime(2019, 12, 4));
  });

  test('startOfToday should return correct date', () {
    final date = DateTime.now();
    final res = DateUtils.startOfToday();

    expect(res, DateTime(date.year, date.month, date.day));
  });

  test('setTime should change time', () {
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

  test('copyWith should replace only passed values', () {
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

  test('nextMonth should return correct month number', () {
    expect(DateUtils.nextMonth(DateTime(2019, 1)), 2);
    expect(DateUtils.nextMonth(DateTime(2019, 12)), 1);
    expect(DateUtils.nextMonth(DateTime(2019, 13)), 2);
    expect(DateUtils.nextMonth(DateTime(2018, 6)), 7);
  });

  test('firstDayOfWeek should return correct date time', () {
    expect(DateUtils.firstDayOfWeek(DateTime(2019, 1, 6, 23, 59, 59, 999, 999)),
        DateTime(2018, 12, 31, 0, 0, 0, 0, 0));
    expect(DateUtils.firstDayOfWeek(DateTime(2020, 4, 9, 15)),
        DateTime(2020, 4, 6, 0, 0, 0, 0, 0));
    expect(
        DateUtils.firstDayOfWeek(DateTime(2020, 12, 27, 23, 59, 59, 999, 999)),
        DateTime(2020, 12, 21, 0, 0, 0, 0, 0));
  });

  test('firstDayOfNextWeek should return correct date time', () {
    expect(DateUtils.firstDayOfNextWeek(DateTime(2018, 12, 31, 0, 0, 0, 0, 0)),
        DateTime(2019, 1, 07, 0, 0, 0, 0, 0));
    expect(DateUtils.firstDayOfNextWeek(DateTime(2020, 4, 9, 15)),
        DateTime(2020, 4, 13, 0, 0, 0, 0, 0));
    expect(
        DateUtils.firstDayOfNextWeek(
            DateTime(2020, 4, 12, 23, 59, 59, 999, 999)),
        DateTime(2020, 4, 13, 0, 0, 0, 0, 0));
  });

  test('lastDayOfWeek should return correct date time', () {
    expect(DateUtils.lastDayOfWeek(DateTime(2018, 12, 31, 0, 0, 0, 0, 0)),
        DateTime(2019, 1, 06, 0, 0, 0, 0, 0));
    expect(DateUtils.lastDayOfWeek(DateTime(2020, 4, 9, 15)),
        DateTime(2020, 4, 12, 0, 0, 0, 0, 0));
    expect(DateUtils.lastDayOfWeek(DateTime(2020, 4, 12, 23, 59, 59, 999, 999)),
        DateTime(2020, 4, 12, 0, 0, 0, 0, 0));
  });

  test('firstDayOfMonth should return correct date time', () {
    expect(
        DateUtils.firstDayOfMonth(DateTime(2019, 1, 6, 23, 59, 59, 999, 999)),
        DateTime(2019, 1, 1, 0, 0, 0, 0, 0));
    expect(DateUtils.firstDayOfMonth(DateTime(2020, 4, 9, 15, 16)),
        DateTime(2020, 4, 1, 0, 0, 0, 0, 0));
    expect(
        DateUtils.firstDayOfMonth(DateTime(2020, 12, 27, 23, 59, 59, 999, 999)),
        DateTime(2020, 12, 1, 0, 0, 0, 0, 0));
  });

  test('firstDayOfNextMonth should return correct date time', () {
    expect(DateUtils.firstDayOfNextMonth(DateTime(2020, 4, 9, 15, 16)),
        DateTime(2020, 5, 1, 0, 0, 0, 0, 0));
  });

  test('lastDayOfMonth should return correct date time', () {
    expect(DateUtils.lastDayOfMonth(DateTime(2019, 1, 6, 23, 59, 59, 999, 999)),
        DateTime(2019, 1, 31, 0, 0, 0, 0, 0));
    expect(DateUtils.lastDayOfMonth(DateTime(2020, 4, 9, 15, 16)),
        DateTime(2020, 4, 30, 0, 0, 0, 0, 0));
    expect(
        DateUtils.lastDayOfMonth(DateTime(2020, 12, 27, 23, 59, 59, 999, 999)),
        DateTime(2020, 12, 31, 0, 0, 0, 0, 0));
  });

  test('firstDayOfYear should return correct date time', () {
    expect(DateUtils.firstDayOfYear(DateTime(2020, 4, 9, 15, 16)),
        DateTime(2020, 1, 1, 0, 0, 0, 0, 0));
  });

  test('firstDayOfNextYear should return correct date time', () {
    expect(DateUtils.firstDayOfNextYear(DateTime(2020, 4, 9, 15, 16)),
        DateTime(2021, 1, 1, 0, 0, 0, 0, 0));
  });

  test('lastDayOfYear should return correct date time', () {
    expect(DateUtils.lastDayOfYear(DateTime(2020, 4, 9, 15, 16)),
        DateTime(2020, 12, 31, 0, 0, 0, 0, 0));
  });

  group('isSameDay', () {
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

  group('generateWithDayStep', () {
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
