//
//  EditSurveyView.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 17/06/2024.
//

import SwiftUI

struct EditSurveyView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var survey: Survey = Survey(happy: 0, stressed: 0, fun: 0, understandingObjective: 0)
    @ObservedObject var viewModel: SurveyListViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("How Happy are you?")
                    .font(.headline)) {
                    TextField("Happy", value: $survey.happy, formatter: NumberFormatter())
                }
                Section(header: Text("How stressed are you?")
                    .font(.headline)) {
                    TextField("Stressed", value: $survey.stressed, formatter: NumberFormatter())
                }
                Section(header: Text("Do you understand the objective?")
                    .font(.headline)) {
                    TextField("Understanding Objective", value: $survey.understandingObjective, formatter: NumberFormatter())
                }
                Section(header: Text("How much fun are you having?")
                    .font(.headline)) {
                    TextField("Fun", value: $survey.fun, formatter: NumberFormatter())
                }
            }
            .navigationTitle("Edit Survey")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await viewModel.updateSurvey(survey)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EditSurveyView(survey: Survey(id: 1, happy: 5, stressed: 3, fun: 7, understandingObjective: 6), viewModel: SurveyListViewModel())
}
