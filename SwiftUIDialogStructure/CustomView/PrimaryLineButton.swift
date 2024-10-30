//
//  PrimaryLineButton.swift
//  SwiftUIDialogStructure
//
//  Created by 김현구 on 10/29/24.
//

import SwiftUI

struct PrimaryLineButton: View {

    let title: String
    var image: Image? = nil
    let size: ButtonSizeType
    @Binding var actionType: ButtonActionType
    let iconType: ButtonIconType
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(title) {
//                action()
            }
            .disabled(actionType == .disabled ? true : false)
            .buttonStyle(DStopButtoPrimaryLineStyle(title: title,
                                                    image: image,
                                                    size: size,
                                                    action: action,
                                                    actionType: $actionType,
                                                    buttonType: actionType,
                                                    iconType: iconType))
        }
    }
}

private struct DStopButtoPrimaryLineStyle: ButtonStyle {

    let title: String
    let image: Image?
    let size: ButtonSizeType
    let action: () -> Void
    @Binding var actionType: ButtonActionType
    @State var buttonType: ButtonActionType
    let iconType: ButtonIconType
    
    @State private var buttonFrame: CGRect = .zero
    
    func makeBody(configuration: Configuration) -> some View {
        
        RoundedRectangle(cornerRadius: size.radius)
            .stroke(anotherColor.color, lineWidth: 1)
            .foregroundColor(asu: backgroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .overlay {
                ZStack {
                    let edgeInserts = EdgeInsets(top: 2.99, leading: 4.84, bottom: 2.76, trailing: 6.19)
                    RoundedRectangle(cornerRadius: size.radius)
                        .foregroundColor(asu: backgroundColor)
                    HStack(spacing: 0) {
                        if iconType == .left {
                            if image == nil {
                                Image(.left_chevron)
                                    .foregroundColor(asu: anotherColor)
                                    .padding(edgeInserts)
                                    .padding(.trailing, 4)
                            } else {
                                image
                                    .foregroundColor(asu: anotherColor)
                                    .padding(edgeInserts)
                                    .padding(.trailing, 4)
                            }
                        }
                        configuration.label
                            .asuFont(size.font)
                            .foregroundColor(asu: anotherColor)
                        
                        if iconType == .right {
                            if image == nil {
                                Image(.right_chevron)
                                    .foregroundColor(asu: anotherColor)
                                    .padding(edgeInserts)
                                    .padding(.leading, 4)
                            } else {
                                image
                                    .foregroundColor(asu: anotherColor)
                                    .padding(edgeInserts)
                                    .padding(.leading, 4)
                            }
                        }
                    }
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    buttonFrame = geometry.frame(in: .global)
                                }
                            }
                    }
                } // : ZS
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if actionType == .default {
                            buttonType = .pressed
                        }
                    }
                    .onEnded { value in
                        if buttonType == .pressed {
                            DispatchQueue.main.asyncAfter(deadline: .now() + buttonType.clickDelay) {
                                buttonType = .default
                                if isInsideButton(endLocation: value.location, buttonFrame: buttonFrame) {
                                    action()
                                }
                            }
                        }
                    }
            )
            .commonAnimation(value: buttonType)
            .commonAnimation(value: actionType)
            .onChange(of: actionType) { newValue in
                buttonType = newValue
            }
    }
}

private extension DStopButtoPrimaryLineStyle {
    
    var backgroundColor: AsuColor {
        switch buttonType {
        case .`default`:
            return .white
        case .disabled:
            return .white
        case .pressed:
            return .primaryBackground
        }
    }
    
    var anotherColor: AsuColor {
        switch buttonType {
        case .`default`:
            return .primaryNormal
        case .disabled:
            return .primaryAlternative
        case .pressed:
            return .primarySupport
        }
    }
}

#Preview {
    ScrollView (showsIndicators: false) {
        VStack(alignment: .leading) {
            Text("Large")
                .font(.largeTitle)
            PrimaryLineButton(
                title: "확인",
                size: .large,
                actionType: .constant(.default),
                iconType: .left,
                action: {})
            
            Text("Middle")
                .font(.largeTitle)
            PrimaryLineButton(
                title: "확인",
                size: .middle,
                actionType: .constant(.default),
                iconType: .none,
                action: {})
            
            Text("Small")
                .font(.largeTitle)
            PrimaryLineButton(
                title: "확인",
                size: .small,
                actionType: .constant(.disabled),
                iconType: .right,
                action: {})
        }
        .padding(.horizontal, 32)
    }
    
}
