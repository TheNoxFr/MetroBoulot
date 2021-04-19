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
            ForEach(scheds96) { sched in
                Text("Attente : \(sched.message)")
                Text("Destination : \(sched.destination)")
            }
        }
        .onAppear(perform: loadData)
    }
}

struct AllerView_Previews: PreviewProvider {
    static var previews: some View {
        AllerView()
    }
}
