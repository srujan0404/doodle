//
//  SidebarView.swift
//  Doodle
//
//  Created by Venkatesh Alampally on 14/06/24.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        VStack {
            Button(action: {
                // code to place panel
            }) {
                Text("Place Panel")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Button(action: {
                // code to show panels
            }) {
                Text("Show Panels")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}
