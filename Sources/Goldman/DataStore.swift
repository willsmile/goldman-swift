import Foundation

struct DataStore {
  var store: DataSet

  func Generate(_ drg: DateRange) -> [Schedule] {
    var result: [Schedule] = []
    let list = drg.DateList()

    for date: Date in list {
      let data = sortByStartHour(selectByDate(date))
      for d: String in data {
        let s: Schedule = Schedule(date: date, option: d)
        result.append(s)
      }
    }

    return result
  }

  func selectByDate(_ date: Date) -> [String] {
    var result: [String] = []
    let wday: String = date.dayOfWeek
    if self.store.keys.contains(wday) {
      result.append(contentsOf: self.store[wday]!)
    }
    if self.store.keys.contains("Everyday") {
      result.append(contentsOf: self.store["Everyday"]!)
    }
    if Calendar.current.isDateInWeekend(date) {
      if self.store.keys.contains("Weekend") {
        result.append(contentsOf: self.store["Weekend"]!)
      }
    } else {
      if self.store.keys.contains("Weekday") {
        result.append(contentsOf: self.store["Weekday"]!)
      }
    }

    return result
  }

  func sortByStartHour(_ options: [String]) -> [String] {
    var targets = options
    targets.sort(by: {
      hourOfTime($0) < hourOfTime($1)
    })

    return targets
  }

  func hourOfTime(_ s: String) -> Int {
    let hourStr = s.split(separator: ":")[0]
    let hour = Int(hourStr)!
    return hour
  }
}
