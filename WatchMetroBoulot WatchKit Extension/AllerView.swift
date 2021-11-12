//
//  AllerView.swift
//  WatchMetroBoulot WatchKit Extension
//
//  Created by Bruno Deguil on 11/11/2021.
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
                .resizable()
            ForEach(scheds96) { sched in
                HStack {
                    Text("\(String(sched.destination.prefix(4)))")
                    Spacer()
                    Text("\(sched.message)")
                        .font(.headline)
                        .foregroundColor(Color.yellow)
                        .padding(.all)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                }
            }
            .padding()
            .onAppear(perform: loadData)
        }
    }
}

struct AllerView_Previews: PreviewProvider {
    static var previews: some View {
        AllerView()
    }
}
