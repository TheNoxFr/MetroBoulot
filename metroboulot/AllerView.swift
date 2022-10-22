//
//  AllerView.swift
//  metroboulot
//
//  Created by Bruno Deguil on 19/04/2021.
//

import SwiftUI

struct AllerView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Image("Bus96")
            List {
                HStack {
                    Text("Terminus")
                        .font(.headline)
                    Spacer()
                    Text("Temps d'attente")
                        .font(.headline)
                }
                
                ForEach(viewModel.scheds96) { sched in
                    HStack {
                        Text("\(sched.destination)")
                        Spacer()
                        Text("\(sched.message) min")
                            .font(.headline)
                            .foregroundColor(Color.yellow)
                            .padding(.all)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                    }
                }
            }
            .padding()
            .onAppear(perform: {viewModel.load(line: "96")})
            Button(action: {
                viewModel.load(line: "96")
            }) {
                Image(systemName: "arrow.2.circlepath")
                    .resizable()
            }
            .frame(width: 60, height: 60)
            .padding()
        }
    }
}

struct AllerView_Previews: PreviewProvider {
    static var previews: some View {
        AllerView(viewModel: ViewModel.init())
    }
}
