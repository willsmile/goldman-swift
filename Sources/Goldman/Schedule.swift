import Foundation

struct Schedule {
  var date: Date
  var option: String

  func Format(_ f: Format) -> String {
    let dateString = date.dateToString(format: f.dateFormat())
    let wday = f.formattedWday(wday: date.dayOfWeek)
    return "\(dateString)(\(wday)) \(option)"
  }
}
