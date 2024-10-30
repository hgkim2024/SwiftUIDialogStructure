//
//  SwiftUIDialogStructureApp.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import SwiftUI

@main
struct SwiftUIDialogStructureApp: App {
    
    @StateObject var dialogData = DialogData.shared
    @StateObject var navigationData = NavigationData.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dialogData)
                .environmentObject(navigationData)
        }
    }
}
