//
//  Color.swift
//  NeomorpicView
//
//  Created by Sergii Kryvoblotskyi on 2/6/20.
//  Copyright © 2020 Sergii Kryvoblotskyi. All rights reserved.
//

import Cocoa

public extension NSColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(displayP3Red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension NSColor {

    func lighter(amount : CGFloat = 0.25, alphaAmount: CGFloat) -> NSColor {
        return hueColorWithBrightnessAmount(amount: 1 + amount)
    }

    func darker(amount : CGFloat = 0.25, alphaAmount: CGFloat) -> NSColor {
        return hueColorWithBrightnessAmount(amount: 1 - amount, alphaAmount: alphaAmount)
    }

    private func hueColorWithBrightnessAmount(amount: CGFloat, alphaAmount: CGFloat = 1.0) -> NSColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return NSColor(deviceHue: hue, saturation: saturation, brightness: brightness * amount, alpha: alpha * alphaAmount)
    }
}
