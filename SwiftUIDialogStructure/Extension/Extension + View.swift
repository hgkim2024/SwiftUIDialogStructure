//
//  Extension + View.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import Foundation
import SwiftUI

extension View {
    
    func asuFont(_ asuFont: AsuFont) -> some View {
        self.modifier(AsuFontModifier(asuFont: asuFont))
    }
    
    func commonAnimation<V>(value: V) -> some View where V : Equatable {
        self.animation(.smooth, value: value)
    }
    
    func foregroundColor(asu: AsuColor) -> some View {
        self.foregroundColor(asu.color)
    }
    
    func background(asu: AsuColor) -> some View {
        self.background(asu.color)
    }
}

extension Text {
    func foregroundColor(asu: AsuColor?) -> Text {
        self.foregroundColor(asu?.color)
    }
}


private struct AsuFontModifier: ViewModifier {
    let asuFont: AsuFont
    func body(content: Content) -> some View {
        let uiFont = UIFont(name: asuFont.pretendard.rawValue, size: asuFont.size) ?? UIFont.systemFont(ofSize: asuFont.size)
        let lineSpacing = asuFont.lineHeight - uiFont.lineHeight
        
        return content
            .font(.pretendard(asuFont.pretendard, size: asuFont.size))
            .lineSpacing(lineSpacing)
            .tracking(asuFont.letterSpacing)
            .padding(.vertical, lineSpacing / 2)
            .padding(.trailing, asuFont.paragraphSpacing)
    }
}

extension Font {
    static func pretendard(_ type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.rawValue, size: size)
    }
}

extension Color {
    init(hex: String) {
        var cleanHex = hex
        while cleanHex.hasPrefix("#") {
            cleanHex.removeFirst()
        }
        
        let scanner = Scanner(string: cleanHex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r, g, b, a: Double
        
        if cleanHex.count == 8 { // #AARRGGBB
            a = Double((rgb >> 24) & 0xFF) / 255.0
            r = Double((rgb >> 16) & 0xFF) / 255.0
            g = Double((rgb >>  8) & 0xFF) / 255.0
            b = Double((rgb >>  0) & 0xFF) / 255.0
        } else if cleanHex.count == 6 { // #RRGGBB
            a = 1.0
            r = Double((rgb >> 16) & 0xFF) / 255.0
            g = Double((rgb >>  8) & 0xFF) / 255.0
            b = Double((rgb >>  0) & 0xFF) / 255.0
        } else {
            // Handle invalid hex string
            r = 0.0
            g = 0.0
            b = 0.0
            a = 1.0
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    init(asu: AsuColor) {
        self.init(hex: asu.hex)
    }
}

extension ButtonStyle {
    func isInsideButton(endLocation: CGPoint, buttonFrame: CGRect) -> Bool {
//        Log.tag(.POINT).d("endLocation: \(endLocation), buttonFrame: \(buttonFrame)")
        let threshold: CGFloat = 16
        var xCheck = -threshold <= endLocation.x && endLocation.x <= buttonFrame.size.width + threshold
        if buttonFrame.size.width < buttonFrame.size.height {
            xCheck = true
        }
        if xCheck
            && (-threshold <= endLocation.y && endLocation.y <= buttonFrame.size.height + threshold) {
            return true
        } else {
            return false
        }
    }
}

extension Image {
    init(_ asuImage: AsuImage) {
        self.init(asuImage.rawValue)
    }
    
    init(asu: AsuImage) {
        self.init(asu.rawValue)
    }
}
