//
//  Time_ClaculatorApp.swift
//  Time Claculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

@main
struct Time_ClaculatorApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()  // Show Main App
            } else {
                AuthView()  // Show Login/Signup
            }
        }
    }
}
