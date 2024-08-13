//
//  CustomJSONDecoder+.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 13/06/2024.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    public static let customDateFormatting = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = dateFormatter.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}

extension JSONEncoder.DateEncodingStrategy {
    public static let customDateFormatting = custom {
        var container = $1.singleValueContainer()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        try container.encode(dateFormatter.string(from: $0))
    }
}
