# Goldman

Goldman is a tool for [g]enerating [o]ption [l]ist of sche[d]ule. And goldman-swift is its swift
implementation.

## Installation
### Preparation
Please download and install [Swift](https://www.swift.org/getting-started/)

### Compiling from source
```
$ git clone https://github.com/willsmile/goldman-swift
$ cd goldman-swift
```

### Build the tool
```
$ swift build -c release
$ cd .build/release
$ ./goldman-swift help
```

## Setup and configuration
Please create a configuration file (`*.yml`) and use the environment variable `GOLDMAN_SWIFT_PATH` to set up the file's path.
You can also use `--config` argument to set up the path each time you run the tool.

Please define the data of schedule options are described in the configuration file as follows.
The available data keys are `Everyday`, `Weekday`, `Weekend`, and the day of the week.

```yml:config.yml
data:
  Everyday:
    - "10:00~11:00"
  Weekday:
    - "12:00~13:00"
  Weekend:
    - "20:00~21:00"
  Monday: 
    - "16:00~17:00"
  Wednesday:
    - "16:00~17:00"
  Thursday:
    - "16:00~17:00"
```

You can customize the format to display each schedule option by setting them up in the configuration file. If it is not customized, the tool uses the default one.

```yml:config.yml
format:
  date: "yyyy'-'MM'-'dd"
  wday:
    Monday: "月"
    Tuesday: "火"
    Wednesday: "水"
    Thursday: "木"
    Friday: "金"
    Saturday: "土"
    Sunday: "日"
```

## Usage
The start date will always be today if it is not specified.

```sh
# Load configuration from the specified path（`g` represents `generate`）
./goldman-swift g -c hogehoge/config.yml

# Generate schedule options in a week (`g` can be left out due to it is default command)
./goldman-swift g

# Generate schedule options starting from today (assume 2023-04-25) and ending to 2023-04-30
./goldman-swift -e 2023-04-30

# Generate schedule options starting from 2023-05-08 and ending to 2023-04-30
./goldman-swift -s 2023-05-08 -e 2023-05-12

# Generate schedule options in three weeks
./goldman-swift -w 3

# Generate schedule options in eight days
./goldman-swift -d 8
```

The example of generated schedule options is as follows.

```sh
❯ ./goldman-swift -d 5
2023/04/25(Tue) 12:00~13:00
2023/04/26(Wed) 12:00~13:00
2023/04/26(Wed) 16:00~17:00
2023/04/27(Thu) 12:00~13:00
2023/04/27(Thu) 16:00~17:00
2023/04/28(Fri) 12:00~13:00
```
