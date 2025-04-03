//
//  Time_ClaculatorApp.swift
//  Time Claculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

@main
struct Time_CalculatorApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false  // Track login state

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()  // Show main app if logged in
            } else {
                AuthView()  // Show login/signup if not logged in
            }
        }
    }
}
