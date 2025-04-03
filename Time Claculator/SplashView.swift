//
//  SplashView.swift
//  TimeCalculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        if isActive {
            if isLoggedIn {
                ContentView() // Redirect to Home if logged in
            } else {
                AuthView() // Redirect to Login/Signup if not logged in
            }
        } else {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack {
                    Image(systemName: "clock.fill") // Replace with your app logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)

                    Text("Time Calculator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2-second delay
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
