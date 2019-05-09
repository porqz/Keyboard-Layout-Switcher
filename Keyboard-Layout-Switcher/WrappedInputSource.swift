//
//  WrappedInputSource.swift
//  Keyboard-Layout-Switcher
//
//  Created by Alexander Belov on 09.05.2019.
//  Copyright © 2019 Alexander Belov. All rights reserved.
//

import Foundation
import Carbon

enum WrappedInputSourceCategory: String {
    case keyboard
    case palette
    case ink
    case unknown

    static func fromTIS(_ category: CFString) -> WrappedInputSourceCategory {
        switch category {
        case kTISCategoryKeyboardInputSource:
            return .keyboard
        case kTISCategoryPaletteInputSource:
            return .palette
        case kTISCategoryInkInputSource:
            return .ink
        default:
            return .unknown
        }
    }
}

enum WrappedInputSourceType: String {
    case keyboardInputMethodWithoutModes
    case keyboardInputMethodModeEnabled
    case keyboardInputMode
    case keyboardLayout
    case keyboardViewer
    case characterPalette
    case ink
    case unknown

    static func fromTIS(_ type: CFString) -> WrappedInputSourceType {
        switch type {
        case kTISTypeKeyboardInputMethodWithoutModes:
            return .keyboardInputMethodWithoutModes
        case kTISTypeKeyboardInputMethodModeEnabled:
            return .keyboardInputMethodModeEnabled
        case kTISTypeKeyboardInputMode:
            return .keyboardInputMode
        case kTISTypeKeyboardLayout:
            return .keyboardLayout
        case kTISTypeKeyboardViewer:
            return .keyboardViewer
        case kTISTypeCharacterPalette:
            return .characterPalette
        case kTISTypeInk:
            return .ink
        default:
            return .unknown
        }
    }
}

class WrappedInputSource {
    private static func getTISProperty<T>(of inputSource: TISInputSource, key: CFString, type: T.Type?) -> T? {
        let propertyValuePointer = TISGetInputSourceProperty(inputSource, key)

        if type == Bool.self {
            return unsafeBitCast(propertyValuePointer, to: CFBoolean.self) as? T
        }

        if type == CFString.self || type == String.self {
            return unsafeBitCast(propertyValuePointer, to: CFString.self) as? T
        }

        return nil
    }

    private var inputSource: TISInputSource

    var name: String {
        get {
            return WrappedInputSource.getTISProperty(of: inputSource, key: kTISPropertyLocalizedName, type: String.self)!
        }
    }

    var category: WrappedInputSourceCategory {
        get {
            let inputSourceCategory = WrappedInputSource.getTISProperty(of: inputSource, key: kTISPropertyInputSourceCategory, type: CFString.self)!

            return WrappedInputSourceCategory.fromTIS(inputSourceCategory)
        }
    }

    var type: WrappedInputSourceType {
        get {
            let inputSourceType = WrappedInputSource.getTISProperty(of: inputSource, key: kTISPropertyInputSourceType, type: CFString.self)!

            return WrappedInputSourceType.fromTIS(inputSourceType)
        }
    }

    var isSelected: Bool {
        get {
            return WrappedInputSource.getTISProperty(of: inputSource, key: kTISPropertyInputSourceIsSelected, type: Bool.self)!
        }
    }

    init(_ inputSource: TISInputSource) {
        self.inputSource = inputSource
    }

    func select() -> Void {
        TISSelectInputSource(inputSource)
    }
}
