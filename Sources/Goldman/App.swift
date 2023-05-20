import Foundation
import ArgumentParser

@main
struct GoldmanSwift: ParsableCommand {
  static var configuration = CommandConfiguration(
      abstract: "GoldmanSwift 0.0.1",
      subcommands: [Generate.self],
      defaultSubcommand: Generate.self
  )

  @Flag(name: .shortAndLong, help: "Show help information.")
  var help = false

  mutating func run() throws {
    guard !help else {
      print(GoldmanSwift.helpMessage())
      GoldmanSwift.exit()
    }
  }
}

struct Generate: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "g",
    abstract: "Generate list of schedule options"
  )

  @Option(name: .shortAndLong, help: "Set start date from `DATE`.")
  var startDate: String = Date().yyyyMMdd

  @Option(name: .shortAndLong, help: "Set end date from `DATE`.")
  var endDate: String?

  @Option(name: .shortAndLong, help: "Set day interval from start date from `INTEGER`.")
  var day: Int = 7

  @Option(name: .shortAndLong, help: "Set week interval from start date from `INTEGER`.")
  var week: Int?

  @Option(name: .shortAndLong, help: "Load configuration file from `URL`.")
  var configPath: String?

  mutating func run() throws {
    let defaultConfigFileURL = ProcessInfo.processInfo.environment["GOLDMAN_SWIFT_PATH"]
    var config: Config

    if configPath != nil {
      config = try Config.LoadConfig(configPath)
    } else {
      config = try Config.LoadConfig(defaultConfigFileURL)
    }

    let store = DataStore(store: config.data)
    let dateRange: DateRange = try DateRange(
      start: startDate,
      end: endDate,
      day: day,
      week: week
    )
    let schedules = store.Generate(dateRange)

    for s: Schedule in schedules {
      print(s.Format(config.format))
    }
  }
}
