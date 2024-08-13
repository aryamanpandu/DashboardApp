//
//  AddSurveyView.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 17/06/2024.
//

import SwiftUI

struct AddSurveyView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var survey: Survey = Survey(happy: 0, stressed: 0, fun: 0, understandingObjective: 0)
    @ObservedObject var viewModel: SurveyListViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("How Happy are you?")) {
                    TextField("Happy", value: $survey.happy, formatter: NumberFormatter())
                }
                Section(header: Text("How stressed are you?")) {
                    TextField("Stressed", value: $survey.stressed, formatter: NumberFormatter())
                }
                Section(header: Text("Do you understand the objective?")) {
                    TextField("Understanding Objective", value: $survey.understandingObjective, formatter: NumberFormatter())
                }
                Section(header: Text("How much fun are you having?")) {
                    TextField("Fun", value: $survey.fun, formatter: NumberFormatter())
                }
            }
            
            .navigationTitle("New Survey")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await viewModel.createSurvey(survey)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    AddSurveyView(viewModel: SurveyListViewModel())
}
