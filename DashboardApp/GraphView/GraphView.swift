//
//  GraphView.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 19/06/2024.
//

import SwiftUI
import Charts

struct GraphView: View {
    @StateObject private var viewModel = SurveyListViewModel()
    @State private var meanGraph = true
    @State private var individualGraph = false
    
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    GroupBox {
                        if viewModel.isLoading {
                            ProgressView("Loading...")
                        }
                        else if let errorMessage = viewModel.errorMessage {
                            Text("Error: \(errorMessage)")
                        }
                        else {
                            if (meanGraph) {
                                Text("Mean Graph")
                                    .font(.title)
                                
                                Chart {
                                    
                                    BarMark(x: .value("Happy", "happy"),
                                            y: .value("Count", viewModel.meanHappy)
                                    )
                                    .foregroundStyle(Color.blue.gradient)
                                    
                                    BarMark(x: .value("Stressed", "Stressed"),
                                            y: .value("Count", viewModel.meanStressed)
                                    )
                                    .foregroundStyle(Color.red.gradient)
                                    
                                    BarMark(x: .value("Fun", "Fun"),
                                            y: .value("Count", viewModel.meanFun)
                                    )
                                    .foregroundStyle(Color.green.gradient)
                                    
                                    BarMark(x: .value("Objective", "Objective"),
                                            y: .value("Count", viewModel.meanUnderstanding)
                                    )
                                    .foregroundStyle(Color.teal.gradient)
                                }
                                .aspectRatio(contentMode: .fit)
                                .chartYScale(domain: 0...10)
                                .frame(height: 400)
                                .cornerRadius(1.5)
                            }
                            
                            if (individualGraph) {
                                Text("Normal Graph")
                                    .font(.title)
                                
                                Chart {
                                    ForEach(viewModel.happyArr.indices, id: \.self) { index in
                                        BarMark(x: .value("Category", "Happy"),
                                                y: .value("Value", viewModel.happyArr[index])
                                        )
                                        .foregroundStyle(Color.blue.gradient)
                                        
                                    }
                                    
                                    ForEach(viewModel.stressedArr.indices, id: \.self) { index in
                                        BarMark(x: .value("Category", "Stressed"),
                                                y: .value("Value", viewModel.stressedArr[index])
                                        )
                                        .foregroundStyle(Color.red.gradient)
                                        
                                    }
                                    
                                    ForEach(viewModel.funArr.indices, id: \.self) { index in
                                        BarMark(x: .value("Category", "Fun"),
                                                y: .value("Value", viewModel.funArr[index])
                                        )
                                        .foregroundStyle(Color.green.gradient)
                                        
                                    }
                                    
                                    ForEach(viewModel.understandingObjArr.indices, id: \.self) { index in
                                        BarMark(x: .value("Category", "Objective"),
                                                y: .value("Value", viewModel.understandingObjArr[index])
                                        )
                                        .foregroundStyle(Color.teal.gradient)
                                        
                                    }
                                }
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 400)
                                .cornerRadius(1.5)
                                
                            }
                            
                        }
                        
                    }
                    .backgroundStyle(Color.white)
                    .shadow(radius: 5.0, x: 2.0, y: 2.0)
                    .padding()
                    
                    HStack {
                        Button(action: {meanGraph = true; individualGraph = false}) {
                            Text("Mean Graph")
                        }
                        .buttonStyle(.bordered)
                        Button(action: {individualGraph = true; meanGraph = false}) {
                            Text("Normal Graph")
                        }
                        .buttonStyle(.bordered)
                    }
                    
                }
            }
            .navigationTitle("Graphs")
        
            
        }
        .task {
            await viewModel.getSurveys()
        }
    }
}

#Preview {
    GraphView()
}
