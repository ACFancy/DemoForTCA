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
    @ObservedObject var viewStore: ViewStoreOf<ContentReducer>
    init(store: StoreOf<ContentReducer>) {
        self.store = store
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
                    viewStore.send(.onAlertShow)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationViewStyle(.stack)
        .retakeDocImagesAlert(isPresented: viewStore.binding(\.$isAlertVisible)) {
            viewStore.send(.onAlertCancel)
        } confirm: {
            viewStore.send(.onAlertSure)
        }
    }
}

