//
//  AuthView.swift
//  TimeCalculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

struct AuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignup: Bool = false  // Toggle between Login/Signup
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false  // Check login status

    var body: some View {
        VStack(spacing: 20) {
            Text(isSignup ? "Sign Up" : "Login")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                isSignup ? signupUser() : loginUser()
            }) {
                Text(isSignup ? "Sign Up" : "Login")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Button(action: { isSignup.toggle() }) {
                Text(isSignup ? "Already have an account? Login" : "Don't have an account? Sign Up")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }

    // MARK: - Authentication Logic
    func signupUser() {
        guard !email.isEmpty, !password.isEmpty else { return }
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        isLoggedIn = true
    }

    func loginUser() {
        let savedEmail = UserDefaults.standard.string(forKey: "userEmail")
        let savedPassword = UserDefaults.standard.string(forKey: "userPassword")

        if email == savedEmail && password == savedPassword {
            isLoggedIn = true
        } else {
            print("Invalid credentials")
        }
    }
}

#Preview {
    AuthView()
}
