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
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()  // Show Splash Screen first
            } else {
                if isLoggedIn {
                    ContentView()  // Show Main App
                } else {
                    AuthView()  // Show Login/Signup
                }
            }
        }
    }
}
