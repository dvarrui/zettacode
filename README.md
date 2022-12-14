
```
 _____    _   _           ____          _      
|__  /___| |_| |_ __ _   / ___|___   __| | ___
  / // _ \ __| __/ _` | | |   / _ \ / _` |/ _ \
 / /|  __/ |_| || (_| | | |__| (_) | (_| |  __/
/____\___|\__|\__\__,_|  \____\___/ \__,_|\___|
```

# Zettacode

This repository has two sections:
1. `zettacode` app source code
2. [Repository of processed files](files.zettacode) usign `zettacode`. Every time, I use it, I will save outputs into `files.zettacode` folder.

# 1. Application

`zettacode` is an application that helps us perform various tasks with files from the [rosettacode.org](https://rosettacode.org/wiki/Rosetta_Code) website.

Features:

* Free license
* Multiplatform
* Command Application

## 1.1 Installation

* Install Ruby on your host.
* `ruby -v`, check current Ruby version. _Version >= 2.7.0 required_.
* `gem install zettacode`, to install "zettacode" gem.
* `zettacode -v`, show current version.

## 1.2 Usage

**Parse local XML files:**

* Goto [RosettaCode](https://rosettacode.org/wiki/Special:Export) export page.
* Add 1 page manually and export.
* `zettacode --parse PATH/TO/XML/FILE`, execute Zettacode to parse XML file into code files.
* The files are created in the `files.zettacode` folder.

## 1.3 Functions

| Command            | Description |
| ------------------ | ----------- |
| `zettacode --help` | show command help.
| `zcode`            | Is an alias of `zettacode` command |
| `zettacode --parse FILE` | Parse local XML file |

> `zettacode --scrap`, Remote web page will be scrapped directly on **future versions**

## 1.4 Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dvarrui/zettacode.
