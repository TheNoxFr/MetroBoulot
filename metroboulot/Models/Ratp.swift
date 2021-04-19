//
//  Ratp.swift
//  metroboulot
//
//  Created by Bruno Deguil on 19/04/2021.
//

import Foundation

struct Ratp: Decodable {
    var result: Result
}

extension Ratp {
    static var data: Ratp {
        Ratp(result: Result(schedules: [Schedule(message: "1 mn", destination: "Gare Montparnasse"),
        Schedule(message: "2 mn", destination: "Gare Montparnasse")]))
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
