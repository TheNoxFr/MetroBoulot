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
            HStack {
                Image("Metro4")
                    .resizable()
                    .frame(width: 16, height: 16)
                List {
                    ForEach(viewModel.scheds4) { sched in
                        HStack {
                            Text("\(String(sched.destination.prefix(5)))")
                                .frame(height: 12)
                            Spacer()
                                .frame(height: 12)
                            Text("\(String(sched.message.prefix(10)))")
                                .foregroundColor(Color.yellow)
                                .padding(.all)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                                .frame(height: 12)
                        }
                        .padding()
                    }
                }
                .environment(\.defaultMinListRowHeight, 10)
                .listStyle(PlainListStyle())
                //.padding()
            }
            HStack {
                Image("Metro11")
                    .resizable()
                    .frame(width: 16, height: 16)
                List {
                    ForEach(viewModel.scheds11) { sched in
                        HStack {
                            Text("\(String(sched.destination.prefix(5)))")
                                .frame(height: 12)
                            Spacer()
                                .frame(height: 12)
                            Text("\(String(sched.message.prefix(6)))")
                                .foregroundColor(Color.yellow)
                                .padding(.all)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                                .frame(height: 12)
                        }
                        .padding()
                    }
                }
                .environment(\.defaultMinListRowHeight, 10)
                .listStyle(PlainListStyle())
                //.padding()
            }
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
