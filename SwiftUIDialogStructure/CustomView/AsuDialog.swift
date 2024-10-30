//
//  AddScheduleDetailView.swift
//  DStop
//
//  Created by DEV IOS on 2024/04/05.
//

import SwiftUI

struct AsuDialog: View {
    
    @EnvironmentObject var dialogData: DialogData
    
    @State var title: String
    @State var contents: String = ""
    @State var highlightTexts: [String]
    @State var cancelBtnTitle: String
    @State var okBtnTitle: String
    private var dissmissCallback: ((String?) -> Void)?
    var isCancel: Bool = false
    var model: DialogModel
    
    init(model: DialogModel) {
        self.title = model.title
        self.contents = model.contents
        self.highlightTexts = model.highlightTexts
        self.cancelBtnTitle = model.cancelBtnTitle
        self.okBtnTitle = model.okBtnTitle
        self.dissmissCallback = model.dissmissCallback
        self.isCancel = model.cancel
        self.model = model
        
        assert(!self.okBtnTitle.isEmpty)
    }
    
    var body: some View {
        ZStack {
            Color(asu: .backgroundDimmed).ignoresSafeArea()
                .onTapGesture {
                    if isCancel {
                        Task { dialogData.show = false }
                    }
                }
            
            VStack(spacing: 0) {
                
                // MARK: - Title
                if !title.isEmpty {
                    Text(title)
                        .foregroundColor(asu: .textStrong)
                        .asuFont(.title3)
                        .padding(.bottom, 12)
                }
                
                // MARK: - Text
                if !contents.isEmpty {
                    HighlightedText(fullText: contents, highlightedTexts: highlightTexts)
                        .asuFont(.body2)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                }
                
                
                HStack(spacing: 10) {
                    
                    // MARK: - cancel Button
                    if !cancelBtnTitle.isEmpty {
                        PrimaryLineButton(title: cancelBtnTitle,
                                          size: .middle,
                                          actionType: .constant(.default),
                                          iconType: .none,
                                          action: {
                            if let dissmissCallback = dissmissCallback {
                                dissmissCallback(nil)
                            } else {
                                Task { dialogData.show = false }
                            }
                        })
                    }
                    
                    // MARK: - confirm Button
                    PrimaryButton(title: okBtnTitle,
                                  size: .middle,
                                  actionType: .constant(.default),
                                  iconType: .none,
                                  action: {
                        if let dissmissCallback = dissmissCallback {
                            dissmissCallback(okBtnTitle)
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
