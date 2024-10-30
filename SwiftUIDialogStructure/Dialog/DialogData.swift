//
//  DialogData.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import Foundation
import SwiftUI

class DialogData: ObservableObject {
    static let shared = DialogData()
    static let mock = DialogData()
    private init() { }
    
    @Published var show: Bool = false
    
    @Published var dialogModel: DialogModel? {
        didSet {
            if let _ = dialogModel {
                show = true
            }
        }
    }
}

struct DialogModel {
    let title: String
    let contents: String
    let highlightTexts: [String]
    let cancelBtnTitle: String
    let okBtnTitle: String
    let cancel: Bool
    let dissmissCallback: ((String?) -> Void)?
    let uuid = UUID().uuidString
    
    init(title: String, 
         contents: String,
         highlightTexts: [String] = [],
         cancelBtnTitle: String = "",
         okBtnTitle: String,
         cancel: Bool = true,
         dissmissCallback: ((String?) -> Void)? = nil) {
        
        self.title = title
        self.contents = contents
        self.highlightTexts = highlightTexts
        self.cancelBtnTitle = cancelBtnTitle
        self.okBtnTitle = okBtnTitle
        self.dissmissCallback = dissmissCallback
        self.cancel = cancel
    }
    
    static var mock: Self {
        return DialogModel(
            title: "안녕하세요?",
            contents: "테스트 다이얼로그입니다.?",
            highlightTexts: ["테스트 다이얼로그"] ,
            cancelBtnTitle: "취소",
            okBtnTitle: "확인")
    }
}
