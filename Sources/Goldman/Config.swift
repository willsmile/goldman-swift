import Foundation
import Yams

typealias DataSet = [String: [String]]

struct Config: Codable {
  var data: DataSet
  var format: Format

  static func LoadConfig(_ url: String?) throws -> Config {
    let url = try Config.fileURL(string: url)
    let config = Config.loadYml(fileURL: url)
    if config != nil {
      return config!
    } else {
      throw ConfigurationError.invalidConfigFile
    }
  }

  static func fileURL(string: String?) throws -> URL {
    guard
      let url = string 
    else {
      throw ConfigurationError.emptyConfigPath
    }

    return URL(fileURLWithPath: url)
  }

  static func loadYml(fileURL: URL) -> Config? {
    let decoder = YAMLDecoder()
    guard
      let data = try? Data(contentsOf: fileURL),
      let config = try? decoder.decode(Config.self, from: data)
    else {
      return nil
    }
    
    return config
  }
}
