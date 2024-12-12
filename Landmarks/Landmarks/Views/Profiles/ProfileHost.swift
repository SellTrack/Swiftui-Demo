//
//  SwiftUIView.swift
//  Landmarks
//
//  Created by Selman Orhan on 12.12.2024.
//

import SwiftUI


struct ProfileHost: View {
    @State private var draftProfile = Profile.default


    var body: some View {
        Text("Profile for: \(draftProfile.username)")
    }
}


#Preview {
    ProfileHost()
}
