//
//  SCNAlertViewController.swift
//  TCA0492Demo
//
//  Created by Lee Danatech on 2023/1/12.
//

import SwiftUI
import UIKit

final public class SCNAlertViewController<Content: View>: UIViewController {
    enum SCNUIStyle: Equatable {
        case `default`
        case noTransition
        case navigationStack
    }

    let hostingVC: UIHostingController<Content>
    let uiStyle: SCNUIStyle
    var isDimissing: Bool = false

    init(modalTransitionStyle: UIModalTransitionStyle = .crossDissolve,
         uiStyle: SCNUIStyle = .default,
         content: Content) {
        hostingVC = UIHostingController(rootView: content)
        self.uiStyle = uiStyle
        super.init(nibName: nil, bundle: nil)
        hostingVC.view.backgroundColor = UIColor.clear
        hostingVC.modalTransitionStyle = modalTransitionStyle
        hostingVC.modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlertVC()
    }

    private func showAlertVC() {
        switch uiStyle {
        case .`default`:
            present(hostingVC, animated: true)
        case .noTransition:
            present(hostingVC, animated: false)
        case .navigationStack:
            let nav = UINavigationController(rootViewController: hostingVC)
            nav.modalTransitionStyle = hostingVC.modalTransitionStyle
            nav.modalPresentationStyle = hostingVC.modalPresentationStyle
            present(nav, animated: true)
        }
    }
}

