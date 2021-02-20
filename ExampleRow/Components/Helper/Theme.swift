//
//  Theme.swift
//  ExampleRow
//
//  Created by Andrew Harris on 20/02/2021.
//

import UIKit

struct ForegroundColour {
   let primary: UIColor
   let secondary: UIColor
}

struct TextColour {
   let primary: UIColor
   let secondary: UIColor
}

struct AccentColour {
    let primary: UIColor
    let secondary: UIColor
}

struct EventColour {
    let success: UIColor
    let danger: UIColor
}

protocol Themeable {
    var background: UIColor {get}
    var foreground: ForegroundColour {get}
    var accent: AccentColour {get}
    var text: TextColour {get}
    var events: EventColour {get}
}

struct LightTheme: Themeable {
    var background: UIColor = UIColor(hex: "FFFFFF")
    var foreground: ForegroundColour = ForegroundColour(
        primary: UIColor(hex: "F9F9F9"),
        secondary: UIColor(hex: "F4F2F7")
    )
    var accent: AccentColour = AccentColour(
        primary: UIColor(hex: "EF2787"),
        secondary: UIColor(hex: "A41459")
    )
    var text: TextColour = TextColour(
        primary: UIColor(hex: "000000"),
        secondary: UIColor(hex: "C5C7C8")
    )
    var events: EventColour = EventColour(
        success: UIColor(hex: "68C899"),
        danger: UIColor(hex: "F2385D")
    )
}

struct Theme {
    static let current: Themeable = LightTheme()
}

extension UIColor {
    public convenience init(hex: String, alpha: Double = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        assert(cString.count == 6, "invalid range")
        assert(alpha >= 0.0 && alpha <= 1.0, "alpha not in range")

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
