//
//  ContentView.swift
//  metroboulot
//
//  Created by Bruno Deguil on 18/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    // 96 : https://api-ratp.pierre-grimaud.fr/v4/schedules/buses/96/Maison%20des%20m%C3%A9tallos/R
    // 4 : https://api-ratp.pierre-grimaud.fr/v4/schedules/metros/4/montparnasse+bienvenue/R
    var body: some View {
        TabView (selection: $tabSelection) {
            AllerView()
                .tabItem {
                    Label("Aller", systemImage: "car")
                }
                .tag(1)
            RetourView()
                .tabItem {
                    Label("Retour", systemImage: "tram")
                }
                .tag(2)
        }
        .padding()
        .onAppear() {
            tabSelection = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
