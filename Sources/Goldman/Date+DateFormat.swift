import Foundation

extension Date  {
  var dayOfWeekNumber: Int {
    let calendar = Calendar(identifier: .gregorian)
    let comps: DateComponents = calendar.dateComponents([.weekday], from: self)
    return comps.weekday!
  }

  var dayOfWeek: String {
    var name: String
    switch self.dayOfWeekNumber {
    case 1:
      name = "Sunday"
    case 2:
      name = "Monday"
    case 3:
      name = "Tuesday"
    case 4:
      name = "Wednesday"
    case 5:
      name = "Thursday"
    case 6:
      name = "Friday"
    case 7:
      name = "Saturday"
    default:
      fatalError("For the day of week, the number should always be the one between 1 to 7 but got \(self.dayOfWeekNumber)")
    }

    return name
  }

  var yyyyMMdd: String {
    let formatter: DateFormatter = Date.defaultFormatter()
    return formatter.string(from: self)
  }

  func dateToString(format dateFormat: String) -> String {
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = dateFormat
    let string: String = formatter.string(from: self)

    return string
  }

  static func defaultFormatter() -> DateFormatter {
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = "yyyy'-'MM'-'dd"
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.timeZone = TimeZone(identifier: "UTC")

    return formatter
  }

  static func dateFromString(_ dateString: String) throws -> Date {
    let formatter: DateFormatter = Date.defaultFormatter()
    let date: Date = try formatter.date(from: dateString) ?? {
      throw ArgumentError.invalidDateFormat
    }()

    return date
  }
}
