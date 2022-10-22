//
//  AllerView.swift
//  WatchMetroBoulot WatchKit Extension
//
//  Created by Bruno Deguil on 11/11/2021.
//

import SwiftUI

struct AllerView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack {
            Image("Bus96")
                .resizable()
            ForEach(viewModel.scheds96) { sched in
                HStack {
                    Text("\(String(sched.destination.prefix(5)))")
                    Spacer()
                    Text("\(sched.message) min")
                        .font(.headline)
                        .foregroundColor(Color.yellow)
                        .padding(.all)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                }
            }
            .padding()
            .onAppear(perform: {viewModel.load(line: "96")})
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                viewModel.load(line: "96")
            }
        }
    }
}

struct AllerView_Previews: PreviewProvider {
    static var previews: some View {
        AllerView(viewModel: ViewModel.init())
    }
}
