//
//  SurveyListViewModel.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 14/06/2024.
//

import Foundation

@MainActor
final class SurveyListViewModel: ObservableObject {
    @Published var surveys: [Survey] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var happyArr: [Int] = []
    @Published var funArr: [Int] = []
    @Published var understandingObjArr: [Int] = []
    @Published var stressedArr: [Int] = []
    @Published var meanHappy = 0.0
    @Published var meanFun = 0.0
    @Published var meanStressed = 0.0
    @Published var meanUnderstanding = 0.0
    
    func getSurveys() async {
        self.isLoading = true
        self.errorMessage = nil
        do {
            let surveys = try await SurveyService.fetchSurveys()
            self.surveys = surveys
            self.populateArrays()
            self.calculateMeans()
            self.isLoading = false
            
        }
        catch (let error){
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func createSurvey(_ survey: Survey) async {
        do {
            try await SurveyService.createSurvey(survey)
            await getSurveys()
        }
        catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func updateSurvey(_ survey: Survey) async {
        do {
            try await SurveyService.updateSurvey(survey)
            await getSurveys()
        }
        catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func deleteSurvey(id: Int) async {
        do {
            try await SurveyService.deleteSurvey(id: id)
            await getSurveys()
        }
        catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    private func populateArrays() {
        happyArr = surveys.map { $0.happy }
        funArr = surveys.map { $0.fun }
        understandingObjArr = surveys.map { $0.understandingObjective }
        stressedArr = surveys.map { $0.stressed }
    }

    private func calculateMeans() {
        meanHappy = calculateMean(from: happyArr)
        meanFun = calculateMean(from: funArr)
        meanUnderstanding = calculateMean(from: understandingObjArr)
        meanStressed = calculateMean(from: stressedArr)
    }

    private func calculateMean(from array: [Int]) -> Double {
        guard !array.isEmpty else { return 0 }
        let sum = array.reduce(0, +)
        return Double(sum) / Double(array.count)
    }
    
}
