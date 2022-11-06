#!/bin/bash

# Installer/uninstaller script for Mike McCauley's C library for Broadcom
# BCM 2835 as used in Raspberry Pi (https://www.airspayce.com/mikem/bcm2835/)


set -euf -o pipefail

current_working_dir="$(pwd)"
script_dir="$(dirname "$(realpath "$0")")"
build_dir="${script_dir}/build"

bcm_lib_version='1.71'
bcm_dir_name="bcm2835-${bcm_lib_version}"
bcm_dir="${build_dir}/${bcm_dir_name}"
bcm_archive_name="${bcm_dir_name}.tar.gz"
bcm_archive="${build_dir}/${bcm_dir_name}.tar.gz"
bcm_lib_url="http://www.airspayce.com/mikem/bcm2835/${bcm_archive_name}"


download_bcm_lib()
{
    if [[ -s "${bcm_archive}" ]]
    then
        return
    fi

    wget                                        \
        "--directory-prefix=${build_dir}/"      \
        "--output-document=${bcm_archive_name}" \
        "${bcm_lib_url}"
}

extract_bcm_lib()
{
    if [[ -d "${bcm_dir}" ]]
    then
        return
    fi

    tar -xvzf "${build_dir}/${bcm_archive_name}" -C "${build_dir}"
}

install_bcm_lib()
{
    cd "${bcm_dir}"

    ./configure

    make

    if ((EUID == 0))
    then
        make check

        make install
    else
        sudo make check

        sudo make install
    fi

    cd "${current_working_dir}"
}

uninstall_bcm_lib()
{
    cd "${bcm_dir}"

    if ((EUID == 0))
    then
        make uninstall
    else
        sudo make uninstall
    fi

    cd "${current_working_dir}"
}

cleanup_build_dir()
{
    find "${build_dir}"                \
        -not -name '.gitkeep'          \
        -a                             \
        -not -wholename "${build_dir}" \
        -delete
}

usage()
{
    printf '%s\n'                                                              \
        'Usage: ./setup.sh -c | -h | -i | -u'                                  \
        'Install or uninstall the bcm2835 C library for the Raspberry Pi.'     \
        ''                                                                     \
        'Options:'                                                             \
        "  -c  Clean-up the '${build_dir}' directory."                         \
        '  -h  Print this help.'                                               \
        '  -i  Install (actually download, compile and install) the bcm2835'   \
        '      library on your Raspberry Pi.'                                  \
        '  -u  Uninstall the bcm2835 library from your Raspberry Pi which was' \
        '      installed using this script.'                                   \
        ''                                                                     \
        'Please note that you must specify exactly one option at a time.'
}


if (($# != 1)) || [[ "$1" != '-'* ]]
then
    printf '%s\n' 'No or invalid (number of) option(s) specified.' >&2

    usage

    exit 1
fi

while getopts 'chiu' option
do
    case "${option}"
    in
        'c')
            cleanup_build_dir
            ;;
        'h')
            usage
            ;;
        'i')
            download_bcm_lib
            extract_bcm_lib
            install_bcm_lib
            ;;
        'u')
            uninstall_bcm_lib
            ;;
        \?)
            printf '%s\n' 'Invalid option!' >&2

            usage

            exit 1
            ;;
    esac
done
