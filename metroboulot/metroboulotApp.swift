//
//  metroboulotApp.swift
//  metroboulot
//
//  Created by Bruno Deguil on 18/04/2021.
//

import SwiftUI

@main
struct metroboulotApp: App {
    @StateObject private var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
