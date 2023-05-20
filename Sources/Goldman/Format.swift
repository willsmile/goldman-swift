import Foundation

enum DefaultFormat {
  static let date: String = "yyyy'-'MM'-'dd"
  static let wday: [String: String] = [
      "Monday":    "Mon",
		  "Tuesday":   "Tue",
		  "Wednesday": "Wed",
		  "Thursday":  "Thu",
		  "Friday":    "Fri",
		  "Saturday":  "Sat",
		  "Sunday":    "Sun",
    ]
}

struct Format: Codable {
  var date: String?
  var wday: [String: String]?

  func dateFormat() -> String {
    if let date = self.date {
      return date
    } else {
      return DefaultFormat.date
    }
  }

  func wdayAlias() -> [String: String] {
    if let wday = self.wday {
      return wday
    } else {
      return DefaultFormat.wday
    }
  }

  func formattedWday(wday: String) -> String {
    return wdayAlias()[wday]!
  }
}
