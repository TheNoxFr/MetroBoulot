//
//  AllerView.swift
//  metroboulot
//
//  Created by Bruno Deguil on 19/04/2021.
//

import SwiftUI

struct AllerView: View {
    @State private var scheds96: [Schedule] = Ratp.data.result.schedules
    
    func loadData() {
        guard let url = URL(string: "https://api-ratp.pierre-grimaud.fr/v4/schedules/buses/96/Maison+des+metallos/R") else {
                print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Ratp.self, from: data) {
                    DispatchQueue.main.async {
                        self.scheds96 = decodedResponse.result.schedules
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
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
                ForEach(scheds96) { sched in
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
            .onAppear(perform: loadData)
            Button(action: {
                loadData()
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
        AllerView()
    }
}
