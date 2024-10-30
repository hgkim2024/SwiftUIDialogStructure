//
//  NavigationStackView.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import SwiftUI

struct NavigationStackView<T: View>: View {
    
    let contents: T
    
    init(@ViewBuilder _ contents: () -> T) {
        self.contents = contents()
    }
    
    var body: some View {
        ZStack {
            contents
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStackView() {
        ZStack {
            // add View
        }
    }
}
