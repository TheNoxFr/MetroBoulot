//
//  AllerView.swift
//  metroboulot
//
//  Created by Bruno Deguil on 19/04/2021.
//

import SwiftUI

struct AllerView: View {
    @ObservedObject var viewModel: ViewModel
    
    //@State private var scheds96: [Schedule] = Ratp.data.result.schedules
    //[StopMonitoringDeliveryResponse] = Stif.data.Siri.ServiceDelivery.StopMonitoringDelivery
    /*
    func loadData() {
        guard let url = URL(string: "https://aaaaprim.iledefrance-mobilites.fr/marketplace/stop-monitoring?MonitoringRef=STIF%3AStopPoint%3AQ%3A37590%3A") else {
                print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("35GWLKumxE84rKWmf12XWQ9h4SlGL2Kc", forHTTPHeaderField: "apikey")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Stif.self, from: data) {
                    DispatchQueue.main.async {
                        let dateFormaterResponse = DateFormatter()
                        dateFormaterResponse.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                        let dateFormaterPassage = DateFormatter()
                        dateFormaterPassage.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        
                        let responseTimestamp = dateFormaterResponse.date(from:  decodedResponse.Siri.ServiceDelivery.ResponseTimestamp)
                        let monitoredStopVisit = decodedResponse.Siri.ServiceDelivery.StopMonitoringDelivery[0].MonitoredStopVisit
                        
                        let dest1 = monitoredStopVisit[0].MonitoredVehicleJourney.MonitoredCall.DestinationDisplay[0].value
                        
                        let time1 = dateFormaterPassage.date(from:  monitoredStopVisit[0].MonitoredVehicleJourney.MonitoredCall.ExpectedDepartureTime)
                        
                        let attente1 = time1!.timeIntervalSince(responseTimestamp!)
                        
                        let dest2 = monitoredStopVisit[1].MonitoredVehicleJourney.MonitoredCall.DestinationDisplay[0].value
                        
                        let time2 = dateFormaterPassage.date(from:  monitoredStopVisit[1].MonitoredVehicleJourney.MonitoredCall.ExpectedDepartureTime)
                        let attente2 = time2!.timeIntervalSince(responseTimestamp!)
                        
                        self.scheds96 = [Schedule(message: String(Int(attente1/60)), destination: dest1), Schedule(message: String(Int(attente2/60)), destination: dest2)]
                        //self.scheds96 = decodedResponse.Siri.ServiceDelivery.StopMonitoringDelivery
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
    */
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
