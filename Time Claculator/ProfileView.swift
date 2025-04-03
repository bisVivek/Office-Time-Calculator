//
//  ProfileView.swift
//  TimeCalculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = true
    @State private var userName: String = ""
    @State private var userEmail: String = ""

    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("Name: \(userName)")
                    .font(.title2)
                    .fontWeight(.medium)

                Text("Email: \(userEmail)")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)

            Spacer()

            // Logout Button
            Button(action: logout) {
                Text("Logout")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            loadUserData()
        }
    }

    // Load user data from UserDefaults
    func loadUserData() {
        userName = UserDefaults.standard.string(forKey: "userName") ?? "Unknown"
        userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? "No Email"
    }

    // Logout function
    func logout() {
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userPassword")
    }
}

#Preview {
    ProfileView()
}
