//
//  HighlightedText.swift
//  DStop
//
//  Created by 김현구 on 8/6/24.
//

import SwiftUI

struct HighlightedText: View {
    let fullText: String
    let highlightedTexts: [String]
    var highlightColor: AsuColor = .primaryNormal
    var highlightColors: [AsuColor] = []
    var font: AsuFont? = nil
    var defaultColor: Color = Color(asu: .textAlternative)
    
    var body: some View {
        var attributedString = AttributedString(fullText)
        let fullText = NSString(string: fullText)
        
        if highlightedTexts.count == highlightColors.count && !highlightedTexts.isEmpty {
            for idx in highlightedTexts.indices {
                let highlightedText = highlightedTexts[idx]
                let highlightColor = highlightColors[idx]
                attributedString = settingText(fullText: fullText, highlightedText: highlightedText, attributedString: attributedString, highlightColor: highlightColor)
            }
        } else {
            for highlightedText in highlightedTexts {
                attributedString = settingText(fullText: fullText, highlightedText: highlightedText, attributedString: attributedString, highlightColor: highlightColor)
            }
        }

        return Text(attributedString)
            .foregroundColor(defaultColor)
    }

    func settingText(fullText: NSString, highlightedText: String, attributedString: AttributedString, highlightColor: AsuColor) -> AttributedString {
        var attributedString = attributedString
        var searchRange = NSRange(location: 0, length: fullText.length)
        while searchRange.location != NSNotFound {
            searchRange = fullText.range(of: highlightedText, options: [], range: searchRange)
            if searchRange.location != NSNotFound {
                if let range = strRangeToAttRange(stringRange: Range(searchRange, in: self.fullText)!) {
                    attributedString[range].foregroundColor = highlightColor.color
                    if let font = font {
                        attributedString[range].font = UIFont(name: font.pretendard.rawValue, size: font.size)
                    }
                    searchRange = NSRange(location: searchRange.location + searchRange.length, length: fullText.length - (searchRange.location + searchRange.length))
                }
            }
        }
        return attributedString
    }
    
    func strRangeToAttRange(stringRange: Range<String.Index>) -> Range<AttributedString.Index>? {
        let attributedString = AttributedString(fullText)
        if let attributedStartIndex = AttributedString.Index(stringRange.lowerBound, within: attributedString),
           let attributedEndIndex = AttributedString.Index(stringRange.upperBound, within: attributedString) {
            return attributedStartIndex..<attributedEndIndex
        }
        return nil
    }
    
}


#Preview {
    VStack {
        HighlightedText(
            fullText: "This is a sample text with some highlighted parts.",
            highlightedTexts: ["text", "highlighted", "This is"]
        )
        .padding()
        
        HighlightedText(
            fullText: "This is a sample text with some highlighted parts.",
            highlightedTexts: ["text", "highlighted", "This is"],
            highlightColors: [.primaryNormal,
                              .primaryNormal,
                              .orange],
            font: .title1
        )
        .padding()
        
        HighlightedText(
            fullText: "Test Test Test Test 123 123 123 456 456 456",
            highlightedTexts: ["Test", "123", "456"],
            highlightColors: [.primaryNormal,
                              .primaryNormal,
                              .orange],
            font: .title1
        )
        .padding()
    }
}

extension Text {
    var stringValue: String {
        let mirror = Mirror(reflecting: self)
        let attributeText = mirror.children.first(where: { $0.label == "storage" })?.value
        let storageMirror = Mirror(reflecting: attributeText!)
        let contentText = storageMirror.children.first(where: { $0.label == "anyTextStorage" })?.value
        let contentTextMirror = Mirror(reflecting: contentText!)
        return contentTextMirror.children.first(where: { $0.label == "rawText" })?.value as? String ?? ""
    }
}
