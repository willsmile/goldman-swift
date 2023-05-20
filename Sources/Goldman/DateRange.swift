import Foundation

struct DateRange {
  let startDate: Date
  let endDate: Date

  init(start: String, end: String) throws {
    let startDate: Date = try Date.dateFromString(start)
    let endDate: Date = try Date.dateFromString(end)
    
    if startDate > endDate {
      throw ArgumentError.invalidDateRange
    }

    self.startDate = startDate
    self.endDate = endDate
  }

  init(start: String, day: Int) throws {
    guard day > 0 else {
        throw ArgumentError.invalidDay
    }

    self.startDate = try Date.dateFromString(start)
    self.endDate = Calendar.current.date(byAdding: .day, value: day, to: self.startDate)!
  }

  init(start: String, week: Int) throws {
    guard week > 0 else {
        throw ArgumentError.invalidDay
    }

    try self.init(start: start, day: week * 7 - 1)
  }

  init(start: String?, end: String?, day: Int?, week: Int?) throws {
    if start == nil {
      throw ArgumentError.notEnoughArguments
    }

    if end != nil {
      try self.init(start: start!, end: end!)
    } else if day != nil {
      try self.init(start: start!, day: day!)
    } else if week != nil {
      try self.init(start: start!, week: week!)
    } else {
      throw ArgumentError.notEnoughArguments
    }
  }

  func DateList() -> [Date] {
    var list: [Date] = []
    var date: Date = self.startDate
    
    while date <= self.endDate {
      list.append(date)
      date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }

    return list
  }
}
