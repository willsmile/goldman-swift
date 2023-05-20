enum ArgumentError: Error {
  case notEnoughArguments
  case invalidDay
  case invalidDateFormat
  case invalidDateRange
}

enum ConfigurationError: Error {
  case emptyConfigPath
  case invalidConfigFile
}
