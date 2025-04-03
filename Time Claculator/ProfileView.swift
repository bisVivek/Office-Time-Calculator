//
//  ProfileView.swift
//  TimeCalculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = true

    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .padding()

            Button(action: logout) {
                Text("Logout")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
    }

    func logout() {
        isLoggedIn = false  // Redirect to AuthView
    }
}

#Preview {
    ProfileView()
}
