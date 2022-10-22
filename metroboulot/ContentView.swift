//
//  ContentView.swift
//  metroboulot
//
//  Created by Bruno Deguil on 18/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var tabSelection = 1
    
    var body: some View {
        TabView (selection: $tabSelection) {
            AllerView(viewModel: viewModel)
                .tabItem {
                    Label("Aller", systemImage: "car")
                }
                .tag(1)
            RetourView(viewModel: viewModel)
                .tabItem {
                    Label("Retour", systemImage: "tram")
                }
                .tag(2)
        }
        .padding()
        .onAppear() {
            let now = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: now)
            if hour >= 13 {
                tabSelection = 2
            } else {
                tabSelection = 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel.init())
    }
}
