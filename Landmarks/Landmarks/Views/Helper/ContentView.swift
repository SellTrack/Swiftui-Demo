//
//  ContentView.swift
//  Landmarks
//
//  Created by Selman Orhan on 2.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
        
    }
}


#Preview {
    ContentView()
        .environment(ModelData())

}
