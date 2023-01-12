//
//  SCNAlertView.swift
//  TCA0492Demo
//
//  Created by Lee Danatech on 2023/1/12.
//

import SwiftUI

struct SCNAlertView<PresentingView: View, Content: View>: View {
    @Binding var isPresented: Bool
    let presentingView: PresentingView
    let content: () -> SCNAlertViewWrapper<Content>

    var body: some View {
        ZStack {
            if isPresented {
                content()
            }
            presentingView
        }
    }
}

struct SCNAlertViewWrapper<Content: View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = SCNAlertViewController<Content>
    let alertContent: Content
    @Binding var isPresented: Bool
    let modalTransitionStyle: UIModalTransitionStyle
    let uiStyle: SCNAlertViewController<Content>.SCNUIStyle

    init(isPresented: Binding<Bool>,
         modalTransitionStyle: UIModalTransitionStyle = .crossDissolve,
         uiStyle: SCNAlertViewController<Content>.SCNUIStyle = .default,
         @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.alertContent = content()
        self.modalTransitionStyle = modalTransitionStyle
        self.uiStyle = uiStyle
    }

    func makeUIViewController(context: Context) -> SCNAlertViewController<Content> {
        let vc = SCNAlertViewController(modalTransitionStyle: modalTransitionStyle, uiStyle: uiStyle, content: alertContent)
        return vc
    }

    func updateUIViewController(_ uiViewController: SCNAlertViewController<Content>, context: Context) {
        if !isPresented, uiViewController.hostingVC.presentingViewController != nil, !uiViewController.isDimissing {
            let animated: Bool = !(modalTransitionStyle == .crossDissolve)
            uiViewController.isDimissing = true
            switch uiStyle {
            case .noTransition:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    uiViewController.hostingVC.dismiss(animated: false) {
                        uiViewController.isDimissing = false
                    }
                }
            default:
                uiViewController.hostingVC.dismiss(animated: animated) {
                    uiViewController.isDimissing = false
                }
            }
        }
        uiViewController.hostingVC.rootView = alertContent
        uiViewController.hostingVC.view.setNeedsUpdateConstraints()
    }
}
