# easy-install-bcm2835

An easy-to-use “installer/uninstaller” for [Mike McCauley's bcm2835 C library for the Raspberry Pi](https://www.airspayce.com/mikem/bcm2835/).

## Contents

* [About](#about)
* [License](#license)
* [Prerequisites](#prerequisites)
* [Usage](#usage)

### About

This project only provides an easy-to-use installer and uninstaller script for [Mike McCauley's bcm2835 C library for the Raspberry Pi](https://www.airspayce.com/mikem/bcm2835/).

This project is meant to be used on [Raspberry Pi OS (32 or 64 bit)](https://www.raspberrypi.com/software/). It may work on other distributions but it is not guaranteed to do so.

### License

This project is licensed under the MIT License. For the full license, please see [`LICENSE`](LICENSE).

_Please note that this license does not apply to the mentioned bcm2835 C library, it only applies to this repository as it is when you acquired it._

## Prerequisites

* Bash shell.
* `build-essential` metapackage.[^1]
* The following commands to run the installer/uninstaller script:

  | Command        | Software                            |
  |----------------|-------------------------------------|
  | __`dirname`__  | [GNU Coreutils][gnu-coreutils-link] |
  | __`find`__     | [GNU Findutils][gnu-findutils-link] |
  | __`printf`__   | [GNU Coreutils][gnu-coreutils-link] |
  | __`pwd`__      | [GNU Coreutils][gnu-coreutils-link] |
  | __`realpath`__ | [GNU Coreutils][gnu-coreutils-link] |
  | __`tar`__      | [GNU Tar][gnu-tar-link]             |
  | __`wget`__     | [GNU Wget][gnu-wget-link]           |

[gnu-coreutils-link]: https://www.gnu.org/software/coreutils/
[gnu-findutils-link]: https://www.gnu.org/software/findutils/
[gnu-tar-link]:       https://www.gnu.org/software/tar/
[gnu-wget-link]:      https://www.gnu.org/software/wget/

You can install the necessary packages with the following commands on Raspberry Pi OS:

```bash
sudo apt-get update && \
sudo apt-get install -y build-essential coreutils findutils tar wget
```

[^1]: The `build-essential` package is a metapackage. It does not install anything by itself but rather depends on several other packages instead. These dependencies, which contain everything required to compile basic software written in C and C++, will be installed when the `build-essential` metapackage is installed.

### Usage

Clone or download this repository and run the following commands to get help, install/uninstall the bcm2835 library, or cleanup the bcm2835 library build directory.

_Please note that some commands need `root` privileges, therefore you will need to run the script either with the `root` user or with a user which is a member of the `sudo` group._

* Get help for using the script:

  ```bash
  ./setup.sh -h
  ```

* Install (download, compile and install) the bcm2835 library:

  ```bash
  ./setup.sh -i
  ```

* Uninstall the bcm2835 library:

  ```bash
  ./setup.sh -u
  ```

* Cleanup the downloaded and compiled bcm2835 library's build directory:

  ```bash
  ./setup.sh -c
  ```

  _Please note that if you want to uninstall the bcm2835 library at some point, you will need to keep the contents of the build directory. If you cleanup the build directory, you will not be able to uninstall the library with this script._
