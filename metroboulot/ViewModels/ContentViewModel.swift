//
//  ContentViewModel.swift
//  metroboulot
//
//  Created by Bruno Deguil on 20/10/2022.
//

import Foundation
import SwiftUI

class ViewModel : ObservableObject {
    @Published var scheds96: [Schedule] = []
    @Published var scheds4: [Schedule] = []
    @Published var scheds11: [Schedule] = []
    
    init() {
        self.scheds96 = Ratp.data.result.schedules
        self.scheds4 = Ratp.data.result.schedules
        self.scheds11 = Ratp.data.result.schedules
    }
    
    func load(line: String) {
        var stringurl: String
        switch line {
        case "96": stringurl = "https://prim.iledefrance-mobilites.fr/marketplace/stop-monitoring?MonitoringRef=STIF%3AStopPoint%3AQ%3A37590%3A"
        case "4": stringurl = "https://prim.iledefrance-mobilites.fr/marketplace/stop-monitoring?MonitoringRef=STIF%3AStopPoint%3AQ%3A462996%3A"
        case "11": stringurl = "https://prim.iledefrance-mobilites.fr/marketplace/stop-monitoring?MonitoringRef=STIF%3AStopPoint%3AQ%3A463079%3A"
        default:
            stringurl = ""
        }
        guard let url = URL(string: stringurl) else {
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
                            
                        //let responseTimestamp = dateFormaterResponse.date(from:  decodedResponse.Siri.ServiceDelivery.ResponseTimestamp)
                        let responseTimestamp = dateFormaterResponse.date(from: ISO8601DateFormatter().string(from: Date.now))
                        
                        let monitoredStopVisit = decodedResponse.Siri.ServiceDelivery.StopMonitoringDelivery[0].MonitoredStopVisit
                            
                        var dest1: String = ""
                        var attente1: Double = 0.0
                        if (!monitoredStopVisit.isEmpty) {
                            dest1 = monitoredStopVisit[0].MonitoredVehicleJourney.MonitoredCall.DestinationDisplay[0].value
                            
                            let time1 = dateFormaterPassage.date(from:  monitoredStopVisit[0].MonitoredVehicleJourney.MonitoredCall.ExpectedDepartureTime)
                            
                            attente1 = time1!.timeIntervalSince(responseTimestamp!)
                        }
                            
                        var dest2: String = ""
                        var attente2: Double = 0.0
                        if (monitoredStopVisit.count > 1) {
                            dest2 = monitoredStopVisit[1].MonitoredVehicleJourney.MonitoredCall.DestinationDisplay[0].value
                            
                            let time2 = dateFormaterPassage.date(from:  monitoredStopVisit[1].MonitoredVehicleJourney.MonitoredCall.ExpectedDepartureTime)
                            attente2 = time2!.timeIntervalSince(responseTimestamp!)
                            
                        }
                            
                        switch line {
                        case "96" :
                            self.scheds96 = [Schedule(message: String(Int(attente1/60)), destination: dest1), Schedule(message: String(Int(attente2/60)), destination: dest2)]
                        case "4" :
                            self.scheds4 = [Schedule(message: String(Int(attente1/60)), destination: dest1), Schedule(message: String(Int(attente2/60)), destination: dest2)]
                        case "11":
                            self.scheds11 = [Schedule(message: String(Int(attente1/60)), destination: dest1), Schedule(message: String(Int(attente2/60)), destination: dest2)]
                        default:
                            return
                        }
                        
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
}
