//
//  ContentView.swift
//  Landmarks
//
//  Created by Selman Orhan on 2.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            MapView()
                .frame(height: 300)
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            VStack(alignment: .leading) {
                Text("Tree")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.leading)
                HStack {                    Text("Kocaeli Park")
                    Spacer()
                    Text("Kocaeli")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Divider()
                
                    Text("About Turtle rock")
                        .font(.title2)
                    Text("Descriptive text goes here")
                
                .padding()
            }
            
            Spacer()
        }
            
    }
}

#Preview {
    ContentView()
}
