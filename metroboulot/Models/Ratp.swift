//
//  Ratp.swift
//  metroboulot
//
//  Created by Bruno Deguil on 19/04/2021.
//

import Foundation

struct Stif: Decodable {
    var Siri: SiriResponse
}

struct SiriResponse: Decodable {
    var ServiceDelivery: ServiceDeliveryResponse
}

struct ServiceDeliveryResponse: Decodable {
    var ResponseTimestamp: String
    var ProducerRef: String
    var ResponseMessageIdentifier: String
    var StopMonitoringDelivery: [StopMonitoringDeliveryResponse]
}

struct StopMonitoringDeliveryResponse: Identifiable {
    let id: UUID
    var ResponseTimestamp: String
    var Version: String
    var Status: String
    var MonitoredStopVisit: [MonitoredStopVisitResponse]
    
    enum CodingKeys: String, CodingKey {
        case ResponseTimestamp
        case Version
        case Status
        case MonitoredStopVisit
    }
    
    init(id: UUID = UUID(), ResponseTimestamp: String, Version: String, Status: String, MonitoredStopVisit:[MonitoredStopVisitResponse]) {
        self.id = id
        self.ResponseTimestamp = ResponseTimestamp
        self.Version = Version
        self.Status = Status
        self.MonitoredStopVisit = MonitoredStopVisit
    }
}

extension StopMonitoringDeliveryResponse: Decodable {
    init(from decoder: Decoder) throws {
        id = UUID()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ResponseTimestamp = try values.decode(String.self, forKey: .ResponseTimestamp)
        Version = try values.decode(String.self, forKey: .Version)
        Status = try values.decode(String.self, forKey: .Status)
        MonitoredStopVisit = try values.decode([MonitoredStopVisitResponse].self, forKey: .MonitoredStopVisit)
    }
}

struct MonitoredStopVisitResponse: Decodable {
    var RecordedAtTime: String
    var ItemIdentifier: String
    var MonitoringRef: ValueResponse
    var MonitoredVehicleJourney: MonitoredVehicleJourneyResponse
}

struct MonitoredVehicleJourneyResponse: Decodable {
    var LineRef: ValueResponse
    var OperatorRef: ValueResponse
    var FramedVehicleJourneyRef: FramedVehicleJourneyRefResponse
    var DirectionName: [ValueResponse]
    var DestinationRef: ValueResponse
    var DestinationName: [ValueResponse]
    var JourneyNote: [ValueResponse]
    var MonitoredCall: MonitoredCallResponse
}

struct MonitoredCallResponse: Decodable {
    var StopPointName: [ValueResponse]
    var VehicleAtStop: Bool
    var DestinationDisplay: [ValueResponse]
    var ExpectedDepartureTime: String
    var DepartureStatus: String
}

struct FramedVehicleJourneyRefResponse: Decodable {
    var DataFrameRef: ValueResponse
    var DatedVehicleJourneyRef: String
}

struct ValueResponse: Decodable {
    var value: String
}

struct Ratp: Decodable {
    var result: Result
}

extension Stif {
    static var data: Stif {
        Stif(Siri: SiriResponse(ServiceDelivery: ServiceDeliveryResponse(ResponseTimestamp: "2022-12-16T14:00:00Z", ProducerRef: "", ResponseMessageIdentifier: "", StopMonitoringDelivery: [StopMonitoringDeliveryResponse(ResponseTimestamp: "2022-12-16T14:00:00Z", Version: "", Status: "", MonitoredStopVisit: [MonitoredStopVisitResponse(RecordedAtTime: "", ItemIdentifier: "", MonitoringRef: ValueResponse(value: ""), MonitoredVehicleJourney: MonitoredVehicleJourneyResponse(LineRef: ValueResponse(value: ""), OperatorRef: ValueResponse(value: ""), FramedVehicleJourneyRef: FramedVehicleJourneyRefResponse(DataFrameRef: ValueResponse( value: ""), DatedVehicleJourneyRef: ""), DirectionName: [ValueResponse(value: "")], DestinationRef: ValueResponse(value: ""), DestinationName: [ValueResponse(value: "")], JourneyNote: [ValueResponse(value: "")], MonitoredCall: MonitoredCallResponse(StopPointName: [ValueResponse(value: "")], VehicleAtStop: false, DestinationDisplay: [ValueResponse(value: "Dest 1")], ExpectedDepartureTime: "2022-12-16T14:01:00Z", DepartureStatus: "")))]),StopMonitoringDeliveryResponse(ResponseTimestamp: "2022-12-16T14:00:00Z", Version: "", Status: "", MonitoredStopVisit: [MonitoredStopVisitResponse(RecordedAtTime: "", ItemIdentifier: "", MonitoringRef: ValueResponse(value: ""), MonitoredVehicleJourney: MonitoredVehicleJourneyResponse(LineRef: ValueResponse(value: ""), OperatorRef: ValueResponse(value: ""), FramedVehicleJourneyRef: FramedVehicleJourneyRefResponse(DataFrameRef: ValueResponse( value: ""), DatedVehicleJourneyRef: ""), DirectionName: [ValueResponse(value: "")], DestinationRef: ValueResponse(value: ""), DestinationName: [ValueResponse(value: "")], JourneyNote: [ValueResponse(value: "")], MonitoredCall: MonitoredCallResponse(StopPointName: [ValueResponse(value: "")], VehicleAtStop: false, DestinationDisplay: [ValueResponse(value: "Dest 2")], ExpectedDepartureTime: "2022-12-16T14:02:00Z", DepartureStatus: "")))])])))
    }
}

extension Ratp {
    static var data: Ratp {
        Ratp(result: Result(schedules: [Schedule(message: "1", destination: "Destination 1"),
        Schedule(message: "2", destination: "Destination 2")]))
    }
}

extension Ratp {
    struct Data {
        var result: Result
    }
    
    var data: Data {
        return Data(result: result)
    }
}

struct Result: Decodable {
    var schedules: [Schedule]
}

extension Result {
    struct Data {
        var schedules: [Schedule] = []
    }
    
    var data: Data {
        return Data(schedules: schedules)
    }
}

struct Schedule: Identifiable {
    let id: UUID
    var message: String
    var destination: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case destination
    }

    init(id: UUID = UUID(), message: String, destination: String) {
        self.id = id
        self.message = message
        self.destination = destination
    }
}

extension Schedule: Decodable {
    init(from decoder: Decoder) throws {
        id = UUID()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decode(String.self, forKey: .message)
        destination = try values.decode(String.self, forKey: .destination)
    }
}
