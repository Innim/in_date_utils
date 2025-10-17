/// Defines the strategy used to calculate week numbers.
enum WeekNumbering {
  /// Strict ISO 8601 week numbering:
  ///
  /// - Weeks start on Monday.
  /// - Week 1 is the week with the starting year's first Thursday in it
  ///   (equivalently, the week that contains January 4).
  /// - Week 1 may start in the previous year.
  /// Ignores [firstWeekday].
  iso,

  /// Week numbering with a configurable start day.
  ///
  /// - Week 1 is the first week that contains at least 4 days of the current year.
  /// - Follows similar logic to ISO 8601 but allows custom [firstWeekday].
  ///
  /// Useful for calendars where weeks start on Sunday or Saturday.
  isoWithFirstWeekday,

  /// Simple rule: Week 1 always contains January 1.
  ///
  /// - Week boundaries are defined by [firstWeekday].
  /// - Week 1 always starts on the week that includes **January 1**, regardless of
  ///   how many days of that week fall in the previous year.
  /// - **December 31** and other dates at the end of the year always belong to
  ///   the week numbering of *their own calendar year*, even if that week mostly
  ///   belongs to the next year.
  /// - As a result, the same calendar week may appear as "Week 53" in the current
  ///   year and "Week 1" in the next year (overlapping week numbers across years).
  ///
  /// This approach is intuitive for most users and matches the behavior of many
  /// US‑style calendars (e.g., Outlook, Windows Calendar, Google Calendar).
  jan1AsFirstWeek,
}
