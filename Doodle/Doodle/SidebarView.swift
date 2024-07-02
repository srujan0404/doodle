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
                
            }) {
                Text("Place Panel")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12) 
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 2)
            )

            Button(action: {
                
            }) {
                Text("Show Panels")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12) 
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.green, lineWidth: 2) 
            )
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(16) 
        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
