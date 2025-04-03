//
//  AuthView.swift
//  TimeCalculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

struct AuthView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignup: Bool = false
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text(isSignup ? "Sign Up" : "Login")
                .font(.largeTitle)
                .fontWeight(.bold)

            if isSignup {
                TextField("Full Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.words)
                    .padding()
            }

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()

            // SecureField with Show Password Feature
            ZStack(alignment: .trailing) {
                if showPassword {
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                } else {
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                }

                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 15)
                }
            }

            Button(action: {
                if isSignup {
                    signupUser()
                } else {
                    loginUser()
                }
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("🧐"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // MARK: - Authentication Logic with Alerts
    func signupUser() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            showAlert(message: "All fields are required!")
            return
        }

        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        isLoggedIn = true
        showAlert(message: "Signup successful! You can now log in.")
    }

    func loginUser() {
        let savedEmail = UserDefaults.standard.string(forKey: "userEmail")
        let savedPassword = UserDefaults.standard.string(forKey: "userPassword")

        if email.isEmpty || password.isEmpty {
            showAlert(message: "Please enter both email and password.")
        } else if email == savedEmail && password == savedPassword {
            isLoggedIn = true
            showAlert(message: "Login successful!")
        } else {
            showAlert(message: "Invalid email or password!")
        }
    }

    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    AuthView()
}
