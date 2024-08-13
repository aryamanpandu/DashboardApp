import SwiftUI

struct SurveyView: View {
    @StateObject private var viewModel = SurveyListViewModel()
    @State private var showingAddSurvey = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List {
                        ForEach(viewModel.surveys) { survey in
                            SurveyRowView(survey: survey, viewModel: viewModel)
                                .padding(.bottom)
                        }
                        .onDelete(perform: deleteSurveys)
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("Surveys")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddSurvey.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .task {
                await viewModel.getSurveys()
            }
            .sheet(isPresented: $showingAddSurvey) {
                AddSurveyView(viewModel: viewModel)
            }
        }
    }

    private func deleteSurveys(at offsets: IndexSet) {
        for index in offsets {
            let survey = viewModel.surveys[index]
            Task {
                await viewModel.deleteSurvey(id: survey.id!)
            }
        }
    }
}

struct SurveyRowView: View {
    var survey: Survey
    @State private var showingEditSurvey = false
    @ObservedObject var viewModel: SurveyListViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("ID: \(survey.id ?? -1)")
                .font(.headline)
            Text("Happy: \(survey.happy)")
                .font(.subheadline)
            Text("Stressed: \(survey.stressed)")
                .font(.subheadline)
            Text("Fun: \(survey.fun)")
                .font(.subheadline)
            Text("Understanding Objective: \(survey.understandingObjective)")
                .font(.subheadline)
        }
        .onTapGesture {
            showingEditSurvey.toggle()
        }
        .sheet(isPresented: $showingEditSurvey) {
            EditSurveyView(survey: survey, viewModel: viewModel)
        }
    }
}

#Preview {
    SurveyView()
}
