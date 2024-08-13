//
//  SurveyService.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 13/06/2024.
//

import Foundation

final class SurveyService {
    
    static let urlString = "https://ioslearningsandbox.azurewebsites.net/api/Surveysapi"
    
    static func fetchSurveys() async throws -> [Survey]{
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Survey].self, from: data)
        }
        catch {
            throw ErrorCases.invalidData
        }
    }

    
    static func createSurvey(_ survey: Survey) async throws {
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(survey)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
            throw ErrorCases.invalidResponse
        }
    }
    
    static func updateSurvey(_ survey: Survey) async throws {
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(survey)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        guard let response = response as? HTTPURLResponse, response.statusCode == 204 else {
            throw ErrorCases.invalidResponse
        }
    }
    
    static func deleteSurvey(id: Int) async throws {
        guard let url = URL(string: "\(urlString)/\(id)") else {
            throw ErrorCases.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorCases.invalidResponse
        }
    }
}
