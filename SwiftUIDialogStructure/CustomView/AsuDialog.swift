//
//  AddScheduleDetailView.swift
//  DStop
//
//  Created by DEV IOS on 2024/04/05.
//

import SwiftUI

struct AsuDialog: View {
    
    @EnvironmentObject var dialogData: DialogData
    var model: DialogModel
    
    init(model: DialogModel) {
        self.model = model
        
        assert(!self.model.okBtnTitle.isEmpty)
    }
    
    var body: some View {
        ZStack {
            Color(asu: .backgroundDimmed).ignoresSafeArea()
                .onTapGesture {
                    if model.cancelable {
                        Task { dialogData.show = false }
                    }
                }
            
            VStack(spacing: 0) {
                
                // MARK: - Title
                if !model.title.isEmpty {
                    Text(model.title)
                        .foregroundColor(asu: .textStrong)
                        .asuFont(.title3)
                        .padding(.bottom, 12)
                }
                
                // MARK: - Text
                if !model.contents.isEmpty {
                    HighlightedText(fullText: model.contents,
                                    highlightedTexts: model.highlightTexts)
                        .asuFont(.body2)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                }
                
                
                HStack(spacing: 10) {
                    
                    // MARK: - cancel Button
                    if !model.cancelBtnTitle.isEmpty {
                        PrimaryLineButton(title: model.cancelBtnTitle,
                                          size: .middle,
                                          actionType: .constant(.default),
                                          iconType: .none,
                                          action: {
                            if let dissmissCallback = model.dissmissCallback {
                                dissmissCallback(nil)
                            } else {
                                Task { dialogData.show = false }
                            }
                        })
                    }
                    
                    // MARK: - confirm Button
                    PrimaryButton(title: model.okBtnTitle,
                                  size: .middle,
                                  actionType: .constant(.default),
                                  iconType: .none,
                                  action: {
                        if let dissmissCallback = model.dissmissCallback {
                            dissmissCallback(model.okBtnTitle)
                        } else {
                            Task { dialogData.show = false }
                        }
                    })
                } // : HS
            } // : VS
            .frame(width: 300)
            .padding(.vertical, 32)
            .padding(.horizontal, 24)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(asu: .white)
            }
            .padding(.horizontal, 16)
        } // : ZS
    }
}

#Preview {
    AsuDialog(model: DialogModel.mock)
    .environmentObject(DialogData.mock)
}
