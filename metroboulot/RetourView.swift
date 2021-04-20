//
//  RetourView.swift
//  metroboulot
//
//  Created by Bruno Deguil on 19/04/2021.
//

import SwiftUI

struct RetourView: View {
    @State private var scheds4: [Schedule] = Ratp.data.result.schedules
    @State private var scheds11: [Schedule] = Ratp.data.result.schedules
    
    func loadData() {
        guard let url4 = URL(string: "https://api-ratp.pierre-grimaud.fr/v4/schedules/metros/4/montparnasse+bienvenue/R") else {
                print("Invalid URL")
            return
        }
        guard let url11 = URL(string: "https://api-ratp.pierre-grimaud.fr/v4/schedules/metros/11/chatelet/R") else {
                print("Invalid URL")
            return
        }
        let request4 = URLRequest(url: url4)
        let request11 = URLRequest(url: url11)
        URLSession.shared.dataTask(with: request4) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Ratp.self, from: data) {
                    DispatchQueue.main.async {
                        self.scheds4 = decodedResponse.result.schedules
                    }
                    return
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
        
        URLSession.shared.dataTask(with: request11) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Ratp.self, from: data) {
                    DispatchQueue.main.async {
                        self.scheds11 = decodedResponse.result.schedules
                    }
                    return
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
    
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
                ForEach(scheds4) { sched in
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
                ForEach(scheds11) { sched in
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
                loadData()
            }) {
                Image(systemName: "arrow.2.circlepath")
                    .resizable()
            }
            .frame(width: 60, height: 60)
            .padding()
        }
        .onAppear() {
            loadData()
        }
    }
}

struct RetourView_Previews: PreviewProvider {
    static var previews: some View {
        RetourView()
    }
}
