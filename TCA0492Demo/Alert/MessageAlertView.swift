//
//  MessageAlertView.swift
//  TCA0492Demo
//
//  Created by Lee Danatech on 2023/1/12.
//

import SwiftUI

struct MessageAlertView: View {
    enum ActionsLayout {
        case hortical
        case vertical
    }
    
    struct Action: Identifiable {
        var id = UUID()
        
        enum Style: Equatable {
            case cancel
            case `default`
            case close
        }
        let style: Style
        let title: String
        let action: (() -> Void)?
    }
    
    let title: String?
    let message: String?
    let actionsLayout: ActionsLayout
    let actions: [Action]
    
    init(title: String? = nil,
         message: String? = nil,
         actionsLayout: MessageAlertView.ActionsLayout = .hortical,
         actions: [MessageAlertView.Action]) {
        self.title = title
        self.message = message
        self.actionsLayout = actionsLayout
        self.actions = actions
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.5))
            ZStack {
                VStack(spacing: 0) {
                    if let title = title {
                        Text(title)
                            .font(.system(size: 16, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .foregroundColor(.gray800)
                            .padding(.horizontal, titleHPadding)
                            .padding(.top, 20)
                    }
                    if let message = message {
                        Text(message)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray500)
                            .lineLimit(nil)
                            .padding(.horizontal, messageHPadding)
                            .padding(.top, messageTopPadding)
                    }
                    switch actionsLayout {
                    case .hortical:
                        HStack(spacing: 15) {
                            ForEach(layoutActions) { element in
                                switch element.style {
                                case .cancel:
                                    NegativeButton(title: element.title, font: .system(size: 15, weight: .semibold)) {
                                        element.action?()
                                    }.frame(width: hButtonSize.width, height: hButtonSize.height, alignment: .center)
                                case .`default`:
                                    PositiveButton(title: element.title, font: .system(size: 15, weight: .semibold)) {
                                        element.action?()
                                    }.frame(width: hButtonSize.width, height: hButtonSize.height, alignment: .center)
                                default:
                                    EmptyView()
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    case .vertical:
                        VStack(spacing: 20) {
                            ForEach(layoutActions) { element in
                                switch element.style {
                                case .cancel:
                                    NegativeButton(title: element.title, font: .system(size: 15, weight: .semibold)) {
                                        element.action?()
                                    }.frame(width: vButtonSize.width, height: vButtonSize.height, alignment: .center)
                                case .`default`:
                                    PositiveButton(title: element.title, font: .system(size: 15, weight: .semibold)) {
                                        element.action?()
                                    }.frame(width: vButtonSize.width, height: vButtonSize.height, alignment: .center)
                                default:
                                    EmptyView()
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    }
                }
            }
            .frame(minHeight: 156)
            .frame(width: 275)
            .background(Color.white)
            .cornerRadius(12)
        }
        .ignoresSafeArea(.all, edges: .all)
    }
    
    var titleHPadding: CGFloat {
        if actions.contains(where: { $0.style == .close }) {
            return 42
        }
        return 25
    }
    var messageHPadding: CGFloat {
        if title == nil, actions.contains(where: { $0.style == .close }) {
            return 42
        }
        return 25
    }
    var messageTopPadding: CGFloat {
        if title == nil {
            return 20
        }
        return 10
    }
    var isOneAction: Bool {
        return actions.compactMap { $0.style != .close }.count == 1
    }
    var hButtonSize: CGSize {
        return isOneAction ? CGSize(width: 120, height: 40) : CGSize(width: 110, height: 40)
    }
    var vButtonSize: CGSize {
        return CGSize(width: 235, height: 40)
    }
    
    var layoutActions: [Action] {
        return actions.compactMap { $0.style != .close ? $0 : nil }
    }
    var closeAction: Action? {
        return actions.first(where: { $0.style == .close })
    }
}


struct NegativeButton: View {
    
    @State private var title: String
    @State private var cornerRadius: CGFloat
    @State private var font: Font
    private var disable: Bool
    let action: () -> Void
    
    init(title: String, disable: Bool = false,
         cornerRadius: CGFloat = 4,
         font: Font = .system(size: 14, weight: .semibold),
         action: @escaping () -> Void) {
        self._title = .init(initialValue: title)
        self._cornerRadius = .init(initialValue: cornerRadius)
        self._font = .init(initialValue: font)
        self.disable = disable
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.indigo400.opacity(disable ? 0.2 : 1))
                Text(title)
                    .font(font)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.indigo400)
            }
            .overlay(overView)
        }.allowsHitTesting(!disable)
    }
    
    var overView: some View {
        Group {
            if disable {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.white.opacity(0.8))
            } else {
                EmptyView()
            }
        }
    }
}

struct PositiveButton: View {
    private let title: String
    @State private var cornerRadius: CGFloat
    @State private var font: Font
    private var disable: Bool
    let action: () -> Void
    
    init(title: String, disable: Bool = false,
         cornerRadius: CGFloat = 4,
         font: Font = .system(size: 14, weight: .semibold),
         action: @escaping () -> Void) {
        self.title = title
        self._cornerRadius = .init(initialValue: cornerRadius)
        self._font = .init(initialValue: font)
        self.disable = disable
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.indigo400)
                Text(title)
                    .font(font)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
            }.overlay(overView)
        }.allowsHitTesting(!disable)
    }
    
    var overView: some View {
        Group {
            if disable {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.white.opacity(0.8))
            } else {
                EmptyView()
            }
        }
    }
}
