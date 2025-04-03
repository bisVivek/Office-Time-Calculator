//
//  HomeView.swift
//  TimeCalculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedMonth: String = "April"
    @State private var dailyHours: [String] = []
    @State private var totalHours: String = "00:00:00"

    let months = ["January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December"]

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Title
                Text("Time Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                // Month Picker (Styled)
                VStack {
                    Text("Select Month")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Picker("Select Month", selection: $selectedMonth) {
                        ForEach(months, id: \.self) { month in
                            Text(month)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 180)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .onChange(of: selectedMonth) { _ in
                        loadHours()
                    }
                }

                // Time Input List (Card UI)
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(0..<dailyHours.count, id: \.self) { index in
                            HStack {
                                Text("Day \(index + 1):")
                                    .fontWeight(.medium)
                                TextField("hh:mm:ss", text: $dailyHours[index])
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                                    .keyboardType(.numbersAndPunctuation)
                                    .onChange(of: dailyHours) { _ in
                                        saveHours()
                                    }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
                .frame(height: 300)

                // Calculate Button
                Button(action: calculateTotalTime) {
                    Text("Calculate Total Hours")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Display Total Hours
                Text("Total Hours: \(totalHours)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .onAppear {
                loadHours()
            }
        }
    }

    // MARK: - Calculation Methods
    func calculateTotalTime() {
        var totalSeconds = 0

        for time in dailyHours {
            let components = time.split(separator: ":").map { Int($0) ?? 0 }
            if components.count == 3 {
                let (h, m, s) = (components[0], components[1], components[2])
                totalSeconds += (h * 3600) + (m * 60) + s
            }
        }

        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        totalHours = String(format: "%02d:%02d:%02d", hours, minutes, seconds)

        // Store data in UserDefaults for Dashboard
        var storedData = UserDefaults.standard.dictionary(forKey: "monthlyTotals") as? [String: String] ?? [:]
        storedData[selectedMonth] = totalHours
        UserDefaults.standard.set(storedData, forKey: "monthlyTotals")
    }


    func saveHours() {
        UserDefaults.standard.set(dailyHours, forKey: "hours_\(selectedMonth)")
    }

    func loadHours() {
        let days = daysInMonth(selectedMonth)
        if let savedHours = UserDefaults.standard.array(forKey: "hours_\(selectedMonth)") as? [String], savedHours.count == days {
            dailyHours = savedHours
        } else {
            dailyHours = Array(repeating: "", count: days)
        }
    }

    func daysInMonth(_ month: String) -> Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        
        switch month {
        case "February":
            return isLeapYear(currentYear) ? 29 : 28
        case "April", "June", "September", "November":
            return 30
        default:
            return 31
        }
    }

    func isLeapYear(_ year: Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
}

#Preview {
    HomeView()
}
