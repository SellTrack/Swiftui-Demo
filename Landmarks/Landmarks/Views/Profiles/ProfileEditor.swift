//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by Selman Orhan on 12.12.2024.
//

import SwiftUI


struct ProfileEditor: View {
    @Binding var profile: Profile
    @State private var age = 20.0
    @State private var isEditing = false


    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }
    
    var body: some View {
        List {
            HStack {
                Text("Username")
                Spacer()
                TextField("Username", text: $profile.username)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications")
            }
            
            Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
                      ForEach(Profile.Season.allCases) { season in
                          Text(season.rawValue).tag(season)
                      }
                  }
            
            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                         Text("Goal Date")
                     }
            Slider(
                value: $age,
                        in: 0...100,
                step: 1,
                
                onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
            Text("\(Int(age))")
                        .foregroundColor(isEditing ? .red : .blue)
            Gauge(value: age, in: 0...100) {
                Text("Age in Gauge")
            }
            ProgressView(value: age/100){
                Text("Age in Progress Bar")
            }
            Stepper(value: $age, in: 0...100) {
                Text("Age in Stepper")
            }
        }
    }
}


#Preview {
    ProfileEditor(profile: .constant(.default))
}
