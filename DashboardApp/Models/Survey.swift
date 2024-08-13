//
//  Survey.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 13/06/2024.
//

import Foundation


struct Survey: Identifiable, Codable {
    var id: Int?
    var happy: Int
    var stressed: Int
    var fun: Int
    var understandingObjective: Int
    
    
    static let test = Survey(id: 90, happy: 5, stressed: 3, fun: 7, understandingObjective: 2)
}
