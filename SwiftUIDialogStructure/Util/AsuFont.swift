//
//  CustomColor.swift
//
//  Created by 김현구 on 9/9/24.
//

import Foundation
import UIKit

enum AsuFont {
    case extraTitle, title1, title2, title3, subtitle1, subtitle2
    case body1, body2
    case caption1, caption2, caption3, caption4
    case buttonS, buttonM, buttonL
    case inputS, inputM, inputL, inputCaption
    
    var uiFont: UIFont {
        return UIFont(name: pretendard.rawValue, size: size)!
    }
    
    var pretendard: Pretendard {
        switch self {
        case .extraTitle, .title1, .title2, .title3, .caption4, .buttonS, .buttonM, .buttonL:
            return .bold
        case .caption2:
            return .semibold
        case .subtitle1, .subtitle2, .caption1:
            return .medium
        case .body1, .body2, .caption3, .inputS, .inputM, .inputL, .inputCaption:
            return .regular
        }
    }

    var size: CGFloat {
        switch self {
        case .extraTitle:
            return 24
        case .title1:
            return 20
        case .title2, .buttonL, .inputL:
            return 18
        case .title3, .subtitle1, .body1, .buttonM, .inputM:
            return 16
        case .subtitle2, .body2, .buttonS, .inputS:
            return 14
        case .caption1, .caption4, .inputCaption:
            return 12
        case .caption2, .caption3:
            return 10
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .extraTitle, .title1, .title2, .title3, .subtitle1, .subtitle2:
            return size * 1.2
        case .body1, .body2, .caption1, .caption2, .caption3, .caption4:
            return size * 1.3
        case .buttonS:
            return size
        case .buttonM:
            return size * 1.2
        case .buttonL:
            return size * 1.25
        case .inputS, .inputM, .inputL, .inputCaption:
            return size * 1.5
        }
    }
    
    var letterSpacing: CGFloat {
        switch self {
        case .title1, .title2, .title3, .subtitle1, .subtitle2, .body1, .body2:
            return -0.02
        default:
            return 0
        }
    }
    
    var paragraphSpacing: CGFloat {
        switch self {
        case .inputS, .inputM, .inputL, .inputCaption:
            return 16
        default:
            return 0
        }
    }
}

enum Pretendard: String {
    case bold     = "Pretendard-Bold"
    case semibold = "Pretendard-SemiBold"
    case regular  = "Pretendard-Regular"
    case medium   = "Pretendard-Medium"
}
