import SwiftUI

struct ContentView: View {
    @State private var selectedMonth: String = "April"
    @State private var dailyHours: [String] = []
    @State private var totalHours: String = "0:00:00"

    let months = ["January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Time Calculator")
                    .font(.largeTitle)
                    .padding()

                // Month Picker
                Picker("Select Month", selection: $selectedMonth) {
                    ForEach(months, id: \.self) { month in
                        Text(month)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedMonth) { _ in
                    loadHours()
                }
                .padding()

                // List of Days (Dynamic)
                List(0..<dailyHours.count, id: \.self) { index in
                    HStack {
                        Text("Day \(index + 1):")
                        TextField("hh:mm:ss", text: $dailyHours[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numbersAndPunctuation)
                            .onChange(of: dailyHours) { _ in
                                saveHours()
                            }
                    }
                }
                .frame(height: 400)

                Button(action: calculateTotalTime) {
                    Text("Calculate Total Hours")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Text("Total Hours: \(totalHours)")
                    .font(.title)
                    .padding()

                Spacer()
            }
            .navigationTitle("Time Calculator")
            .onAppear {
                loadHours()
            }
        }
    }

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
    ContentView()
}
