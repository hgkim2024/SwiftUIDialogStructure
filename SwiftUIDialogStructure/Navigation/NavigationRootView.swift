//
//  NavigationRootView.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import SwiftUI

struct NavigationRootView<T: View>: View {
    
    @EnvironmentObject var dialogData: DialogData
    @State var isShow = false
    
    let contents: T
    
    init(@ViewBuilder _ contents: () -> T) {
        self.contents = contents()
    }

    var body: some View {
        ZStack {
            
            ZStack {
                contents
            } // : ZS
            
            ZStack {
                if isShow {
                    if dialogData.show,
                       let dialogModel = dialogData.dialogModel {
                        AsuDialog(model: dialogModel)
                            .id(dialogModel.uuid)
                    }

                }
            } // : ZS
            .ignoresSafeArea()
        } // : ZS
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear {
            isShow = true
        }
        .onDisappear {
            isShow = false
        }
    }
}

#Preview {
    NavigationRootView() {
        ZStack {
            // add View
        }
    }
    .environmentObject(DialogData.mock)
}
