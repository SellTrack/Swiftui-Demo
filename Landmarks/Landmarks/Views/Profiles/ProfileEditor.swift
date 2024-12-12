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
    @State private var animationStep = 0
    @State private var current = 67.0
    @State private var minValue = 0.0
    @State private var maxValue = 170.0


    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }
    
    enum AnimationPhase: CaseIterable {
        case start, middle, end
    }
    
    struct ToggleStates {
        var oneIsOn: Bool = false
        var twoIsOn: Bool = true
    }
    @State private var toggleStates = ToggleStates()
    @State private var topExpanded: Bool = true

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
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .animation(.ripple(index: Int(age)))
            ProgressView(value: age/100){
                Text("Age in Progress Bar")
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .blur(radius: age/10 )

            Stepper(value: $age, in: 0...100) {
                Text("Age in Stepper")
            }
            .shadow(color: .black, radius: age/10)
            .phaseAnimator(AnimationPhase.allCases, trigger: animationStep) { content, phase in
                        content
                            .blur(radius: phase == .start ? 0 : 10)
                            .scaleEffect(phase == .middle ? 3 : 1)
                    }

            
            DisclosureGroup("Items", isExpanded: $topExpanded) {
                  Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                  Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                  DisclosureGroup("Sub-items") {
                      Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                      Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                      DisclosureGroup("Sub-items") {
                          Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                          Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                          DisclosureGroup("Sub-items") {
                              Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                              Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                              DisclosureGroup("Sub-items") {
                                  Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                                  Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                                  DisclosureGroup("Sub-items") {
                                      Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                                      Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                                      DisclosureGroup("Sub-items") {
                                          Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                                          Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                                          DisclosureGroup("Sub-items") {
                                              Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                                              Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                                              DisclosureGroup("Sub-items") {
                                                  Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                                                  Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                                                  DisclosureGroup("Sub-items") {
                                                      Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                                                      Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                                                      DisclosureGroup("Sub-items") {
                                                          Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                                                          Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                                                          DisclosureGroup("Sub-items") {
                                                              Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                                                              Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                                                              }
                                                          }
                                                      }
                                                  }
                                              }
                                          }
                                      }
                                  }
                              }
                        }
                  }
              }
            
        }
    }
}


#Preview {
    ProfileEditor(profile: .constant(.default))
}
