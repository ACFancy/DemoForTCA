//
//  TCA0492DemoApp.swift
//  TCA0492Demo
//
//  Created by Lee Danatech on 2023/1/12.
//

import SwiftUI

@main
struct TCA0492DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: .init(initialState: .init(), reducer: ContentReducer()))
        }
    }
}
