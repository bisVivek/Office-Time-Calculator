//
//  DashboardView.swift
//  TimeCalculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

struct DashboardView: View {
    @State private var storedData: [String: String] = [:] // Month -> Total Time
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Dashboard Analytics")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top)
                
                List(storedData.keys.sorted(), id: \.self) { month in
                    HStack {
                        Text(month)
                            .fontWeight(.medium)
                        Spacer()
                        Text(storedData[month] ?? "00:00:00")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    .padding()
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                loadStoredData()
            }
            .navigationTitle("Dashboard")
        }
    }

    // MARK: - Load Stored Data
    func loadStoredData() {
        if let savedData = UserDefaults.standard.dictionary(forKey: "monthlyTotals") as? [String: String] {
            storedData = savedData
        }
    }
}

#Preview {
    DashboardView()
}
