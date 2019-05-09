# Keyboard Layout Switcher

Keyboard Layout Switcher is command-line application for macOS that allows to see enabled keyboard layouts and select one as current.


## How to Use

To see a list of enabled keyboard layouts run the application without arguments:

    > kblswitcher
    Enabled keyboard layouts:
              1. ABC
    (current) 2. English - Ilya Birman Typography
              3. Russian - Ilya Birman Typography

    Run the application with a number above passed as an argument to select a layout as current.

To select a keyboard layout as current run the application with a number of the layout:

    > kblswitcher 3

(In example above layout named “Russian - Ilya Birman Typography” will be selected as current.)


## Swift and Objective-C

Actual version of the application is written on Swift, but you still may [see earlier (and simplier) version written on Objective-C](https://github.com/porqz/Keyboard-Layout-Switcher/blob/1d525456924d71cd4d7b18390c7baf1b690aab9b/Input%20Source%20Switcher/main.m).
