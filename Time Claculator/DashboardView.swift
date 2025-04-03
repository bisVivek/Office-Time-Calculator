//
//  DashboardView.swift
//  TimeCalculator
//
//  Created by Ftechiz on 04/04/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
            
            Text("Analytics and reports will be shown here!")
                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    DashboardView()
}
