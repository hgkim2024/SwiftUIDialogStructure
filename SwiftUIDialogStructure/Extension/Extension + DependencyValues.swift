//
//  Extension + DependencyValues.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import Foundation
import Dependencies

extension DependencyValues {
    
    var dialogData: DialogData {
        get { DialogData.shared }
    }

    var navigationData: NavigationData {
        get { NavigationData.shared }
    }
    
}
