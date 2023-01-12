//
//  View+Alert.swift
//  TCA0492Demo
//
//  Created by Lee Danatech on 2023/1/12.
//

import SwiftUI

private extension UInt32 {
    static let gray900: UInt32 = 0x141414
    static let gray800: UInt32 = 0x1F1F1F
    static let gray700: UInt32 = 0x333333
    static let gray600: UInt32 = 0x545454
    static let gray500: UInt32 = 0x757575
    static let gray400: UInt32 = 0xAFAFAF
    static let gray300: UInt32 = 0xCBCBCB
    static let gray200: UInt32 = 0xE2E2E2
    static let gray100: UInt32 = 0xEEEEEE
    static let gray50: UInt32 = 0xF6F6F6
    static let indigo400: UInt32 = 0x0D93BF
    static let red900: UInt32 = 0xE11900
    static let red800: UInt32 = 0xFF5731
    static let systemGray01: UInt32 = 0x0F0D15
    static let platinum800: UInt32 = 0x142328
}

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let red: Double = Double((hex & 0xff0000) >> 16) / 255.0
        let green: Double = Double((hex & 0x00ff00) >> 8) / 255.0
        let blue: Double = Double((hex & 0x0000ff) >> 0) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}

public extension Color {
    static let gray900 = Color(hex: .gray900)
    static let gray800 = Color(hex: .gray800)
    static let gray700 = Color(hex: .gray700)
    static let gray600 = Color(hex: .gray600)
    static let gray500 = Color(hex: .gray500)
    static let gray400 = Color(hex: .gray400)
    static let gray300 = Color(hex: .gray300)
    static let gray200 = Color(hex: .gray200)
    static let gray100 = Color(hex: .gray100)
    static let gray50 = Color(hex: .gray50)
    static let indigo400 = Color(hex: .indigo400)
    static let red900 = Color(hex: .red900)
    static let red800 = Color(hex: .red800)
    static let systemGray01 = Color(hex: .systemGray01)
    static let platinum800 = Color(hex: .platinum800)
}

extension View {
    
    @ViewBuilder
    func retakeDocImagesAlert(isPresented: Binding<Bool>, cancel: (() -> Void)? = nil, confirm: (() -> Void)?) -> some View {
        scnMessageAlert(isPresented: isPresented,
                        title: "Title",
                        message: "Tip tip click",
                        actions: [.init(style: .cancel, title: "Sure", action: confirm),
                                  .init(style: .default, title: "Cancel", action: cancel)])
    }
    
    @ViewBuilder
    func scnMessageAlert(isPresented: Binding<Bool>,
                         title: String? = nil,
                         message: String? = nil,
                         actionsLayout: MessageAlertView.ActionsLayout = .hortical,
                         actions: [MessageAlertView.Action] = []) -> some View {
        modifier(SCNAlertView(isPresented: isPresented, content: {
            SCNAlertViewWrapper(isPresented: isPresented) {
                MessageAlertView(title: title, message: message, actionsLayout: actionsLayout, actions: actions)
            }
        }))
//        SCNAlertView(isPresented: isPresented, presentingView: self) {
//
//        }
    }
}
