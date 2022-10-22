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
                .frame(width: 16, height: 16)
            List {
                ForEach(viewModel.scheds4) { sched in
                    HStack {
                        Text("\(String(sched.destination.prefix(5)))")
                        Spacer()
                        Text("\(String(sched.message.prefix(10)))")
                            .foregroundColor(Color.yellow)
                            .padding(.all)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                    }
                }
            }
            .padding()
            Image("Metro11")
                .resizable()
                .frame(width: 16, height: 16)
            List {
                ForEach(viewModel.scheds11) { sched in
                    HStack {
                        Text("\(String(sched.destination.prefix(5)))")
                        Spacer()
                        Text("\(String(sched.message.prefix(10)))")
                            .foregroundColor(Color.yellow)
                            .padding(.all)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                    }
                }
            }
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
