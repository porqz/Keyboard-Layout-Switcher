//
//  main.swift
//  Keyboard-Layout-Switcher
//
//  Created by Alexander Belov on 09.05.2019.
//  Copyright © 2019 Alexander Belov. All rights reserved.
//

import Foundation
import Carbon

let inputSources = TISCreateInputSourceList(nil, false).takeRetainedValue() as! [TISInputSource]

let keyboardLayouts = inputSources.map({ inputSource in WrappedInputSource(inputSource) }).filter { wrappedInputSource in
    // I’m not sure that both conditions are necessary
    wrappedInputSource.category == WrappedInputSourceCategory.keyboard &&
    wrappedInputSource.type == WrappedInputSourceType.keyboardLayout
}

if CommandLine.arguments.count > 1 {
    let wantedKeyboardLayoutIndex = Int(CommandLine.arguments[1]) ?? 0

    if (1...keyboardLayouts.count).contains(wantedKeyboardLayoutIndex) {
        keyboardLayouts[wantedKeyboardLayoutIndex - 1].select()
    } else {
        print("There is no keyboard layout with the index!\n")
    }
}

print("Enabled keyboard layouts:")

for (keyboardLayoutIndex, keyboardLayout) in keyboardLayouts.enumerated() {
    let keyboardLayoutSelectedMark = keyboardLayout.isSelected ? "(current)" : "         "

    // @TODO: print the string really formatted
    print("\(keyboardLayoutSelectedMark) \(keyboardLayoutIndex + 1). \(keyboardLayout.name)")
}

print("\nRun the application with a number above passed as an argument to select a layout as current.")
