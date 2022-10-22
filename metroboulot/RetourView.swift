//
//  RetourView.swift
//  metroboulot
//
//  Created by Bruno Deguil on 19/04/2021.
//

import SwiftUI

struct RetourView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Image("Metro4")
                .resizable()
                .frame(width: 40, height: 40)
            List {
                HStack {
                    Text("Terminus")
                        .font(.headline)
                    Spacer()
                    Text("Temps d'attente")
                        .font(.headline)
                }
                ForEach(viewModel.scheds4) { sched in
                    HStack {
                        Text("\(sched.destination)")
                        Spacer()
                        Text("\(sched.message)")
                            .foregroundColor(Color.yellow)
                            .padding(.all)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                    }
                }
            }
            .padding()
            Image("Metro11")
                .resizable()
                .frame(width: 40, height: 40)
            List {
                HStack {
                    Text("Terminus")
                        .font(.headline)
                    Spacer()
                    Text("Temps d'attente")
                        .font(.headline)
                }
                ForEach(viewModel.scheds11) { sched in
                    HStack {
                        Text("\(sched.destination)")
                        Spacer()
                        Text("\(sched.message)")
                            .foregroundColor(Color.yellow)
                            .padding(.all)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                    }
                }
            }
            .padding()
            
            Button(action: {
                viewModel.load(line: "4")
                viewModel.load(line: "11")
            }) {
                Image(systemName: "arrow.2.circlepath")
                    .resizable()
            }
            .frame(width: 60, height: 60)
            .padding()
        }
        .onAppear() {
            viewModel.load(line: "4")
            viewModel.load(line: "11")
        }
    }
}

struct RetourView_Previews: PreviewProvider {
    static var previews: some View {
        RetourView(viewModel: ViewModel.init())
    }
}
