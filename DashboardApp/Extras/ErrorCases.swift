//
//  ErrorCases.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 14/06/2024.
//

import Foundation

enum ErrorCases: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL found."
        case .invalidResponse:
            return "Invalid Response found."
        case .invalidData:
            return "Invalid Data retrieved."
        }
    
    }
}
