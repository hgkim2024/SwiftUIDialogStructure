//
//  CustomColor.swift
//
//  Created by 김현구 on 9/9/24.
//

import SwiftUI

enum AsuColor {
    // MARK: - Primary
    case primaryNormal
    case primarySupport
    case primaryAlternative
    case primaryAssistive
    case primaryBackground
    case primaryGradientLight
    case primaryGradientDark
    case primaryGradient

    // MARK: - Text
    case textStrong
    case textNormal
    case textSupport
    case textAlternative
    case textAssistive
    case textCaption
    case textWhite
    
    // MARK: - UI
    case blue
    case blueLight
    case red
    case redLight
    case orange
    case orangeLight
    case yellow
    case yellowLight
    case green
    case greenLight
    case purple
    case purpleLight
    case disabled
    case disabledLight
    case gray
    
    // MARK: - Background
    case backgroundNormal
    case backgroundAssistive
    case backgroundDimmed
    case backgroundLightDimmed
    case backgroundLightDimmedStart
    case backgroundLightDimmedEnd
    
    // MARK: - Black & White
    case black
    case white
    
    // MARK: - Line
    case lineOnWhite
    case lineOnColor
    
    var color: Color {
        return Color(asu: self)
    }

    var hex: String {
        switch self {
        case .primaryNormal: return "2A81B7"
        case .primarySupport: return "37197D"
        case .primaryAlternative: return "C4E9F5"
        case .primaryAssistive: return "EEF9FB"
        case .primaryBackground: return "EEFBFB"
        case .primaryGradientLight: return "26A6CC"
        case .primaryGradientDark: return "37197D"
        case .primaryGradient: return AsuColor.primaryNormal.hex
            
        case .textStrong: return "101219"
        case .textNormal: return "2E3142"
        case .textSupport: return "535968"
        case .textAlternative: return "787E8B"
        case .textAssistive: return "9AA1AB"
        case .textCaption: return "C4C7CE"
        case .textWhite: return "FFFFFF"
            
        case .blue: return "3181F5"
        case .blueLight: return "EFF8FF"
        case .red: return "F86754"
        case .redLight: return "FEF0EE"
        case .orange: return "FB9E7D"
        case .orangeLight: return "FEEFE8"
        case .yellow: return "FFBB1E"
        case .yellowLight: return "FFFADD"
        case .green: return "2BC96B"
        case .greenLight: return "EDFCF4"
        case .purple: return "7F5CEB"
        case .purpleLight: return "F4F2FE"
        case .disabled: return "BDBDBD"
        case .disabledLight: return "E8E8EB"
        case .gray: return "EDF0F4"
            
        case .backgroundNormal: return "FFFFFF"
        case .backgroundAssistive: return "F5F9FB"
        case .backgroundDimmed: return "#b2344854"
        case .backgroundLightDimmed: return "#20000000"
        case .backgroundLightDimmedStart: return "#00686868"
        case .backgroundLightDimmedEnd: return "#88282c2f"
            
        case .black: return "000000"
        case .white: return "FFFFFF"
            
        case .lineOnWhite: return "E8E9ED"
        case .lineOnColor: return "E3EDEE"
        }
    }
    
    var gradient: LinearGradient {
        return switch self {
        case .backgroundLightDimmed:
            LinearGradient(
                colors: self.gradientColors,
                startPoint: .top,
                endPoint: .bottom
            )
            
        case .primaryGradient :
            LinearGradient(
                colors: self.gradientColors,
                startPoint: .top,
                endPoint: .bottom
            )
            
        default:
            LinearGradient(colors: [], startPoint: .top, endPoint: .bottom)
        }
    }
    
    var invertGradient: LinearGradient {
        return switch self {
        case .primaryGradient:
            LinearGradient(
                colors: self.invertGradientColors,
                startPoint: .top,
                endPoint: .bottom
            )
        default:
            LinearGradient(colors: [], startPoint: .top, endPoint: .bottom)
        }
    }
    
    var gradientColors: [Color] {
        return switch self {
        case .backgroundLightDimmed:
            [Color(asu: .backgroundLightDimmedStart), Color(asu: .backgroundLightDimmedEnd)]
            
        case .primaryGradient:
            [Color(asu: .primaryGradientLight), Color(asu: .primaryGradientDark)]
            
        default:
            []
        }
    }
    
    var invertGradientColors: [Color] {
        return switch self {
        case .primaryGradient:
            [Color(asu: .primaryGradientDark), Color(asu: .primaryGradientLight)]
            
        default:
            []
        }
    }

}
