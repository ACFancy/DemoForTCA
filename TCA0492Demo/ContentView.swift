//
//  ContentView.swift
//  TCA0492Demo
//
//  Created by Lee Danatech on 2023/1/12.
//

import SwiftUI
import ComposableArchitecture

struct ContentReducer: ReducerProtocol {
    struct State: Equatable {
        @BindableState var isAlertVisible: Bool = false
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAlertShow
        case onAlertSure
        case onAlertCancel
    }

    var body: some ReducerProtocol<State, Action> {
        core
    }

    @ReducerBuilder<State, Action>
    var core: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAlertShow:
                state.isAlertVisible = true
            case .onAlertSure, .onAlertCancel:
                state.isAlertVisible = false
            default: break
            }
            return .none
        }
    }
}


struct ContentView: View {

    let store: StoreOf<ContentReducer>
    @Binding private var isVisible: Bool
    @ObservedObject var viewStore: ViewStoreOf<ContentReducer>
    init(store: StoreOf<ContentReducer>, isVisible: Binding<Bool>) {
        self.store = store
        _isVisible = isVisible
        viewStore = ViewStoreOf<ContentReducer>(store)
    }

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                Button("Alert Show") {
                    isVisible = true
//                    viewStore.send(.onAlertShow)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationViewStyle(.stack)
        .retakeDocImagesAlert(isPresented: $isVisible) {
            isVisible = false
//            viewStore.send(.onAlertCancel)
        } confirm: {
            isVisible = false
//            viewStore.send(.onAlertSure)
        }
    }
}

