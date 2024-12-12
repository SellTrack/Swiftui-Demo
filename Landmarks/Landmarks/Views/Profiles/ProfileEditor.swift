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
    @State private var sayi = 1

    @State private var isEditing = false
    @State private var animationStep = 0
    @State private var current = 67.0
    @State private var minValue = 0.0
    @State private var maxValue = 170.0
    @State private var isShowingPopover = false
    @State private var isBlue = true
    @State private var selected = "Elma"
    let fruits = [
        "Elma", "Armut", "Muz", "Çilek", "Kiraz", "Karpuz", "Kavun", "Portakal",
        "Mandalina", "Üzüm", "Şeftali", "Kayısı", "Erik", "Nar", "Ananas",
        "Hindistan Cevizi", "Kivi", "Limon", "Avokado", "Mango", "Papaya",
        "Passion Fruit", "Yaban Mersini", "Ahududu", "Böğürtlen", "Karadut",
        "Trabzon Hurması", "Greyfurt", "Ayva", "Kızılcık", "Aronya",
        "Goji Berry", "Liçi", "Rambutan", "Durian", "Tamarind", "Jackfruit"
    ]



    struct FileItem: Hashable, Identifiable, CustomStringConvertible {
        var id: Self { self }
        var name: String
        var children: [FileItem]? = nil
        var description: String {
            switch children {
            case nil:
                return "📄 \(name)"
            case .some(let children):
                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
            }
        }
    }

    let data =
      FileItem(name: "users", children:
        [FileItem(name: "user1234", children:
          [FileItem(name: "Photos", children:
            [FileItem(name: "photo001.jpg"),
             FileItem(name: "photo002.jpg")]),
           FileItem(name: "Movies", children:
             [FileItem(name: "movie001.mp4")]),
              FileItem(name: "Documents", children: [])
          ]),
         FileItem(name: "newuser", children:
           [FileItem(name: "Documents", children: [])
           ])
        ])

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
            
            Picker("Meyve Seç", selection: $selected) {
                        ForEach(fruits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
            
            Text("Sayı: \(sayi)")
            .font(.largeTitle)
            .foregroundColor(isBlue ? .blue : .red)
            .transition(.moveAndFade)
            Button("Arttır"){
                sayi += 1
                isBlue.toggle()
            }
            .textCase(.uppercase)

            
            OutlineGroup(data, children: \.children) { item in
                Text("\(item.description)")
            }
            
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                
            }
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
            Text("Rotation by passing an angle in degrees")
                .frame(height: 120.0)
                .rotation3DEffect(
                    .degrees(45),
                    axis: (x: 0.2, y: 0.2, z: -0.1),
                    anchor: .center,
                    anchorZ: 4,
                    perspective: 4)
                .border(Color(hue: 1.0, saturation: 0.031, brightness: 0.989))
            
            Button("Show Popover") {
                       self.isShowingPopover = true
                   }
                   .popover(
                       isPresented: $isShowingPopover, arrowEdge: .bottom
                   ) {
                       Text("Popover Content")
                           .padding()
                   }
                   .safeAreaInset(edge: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/) {
                        /*@START_MENU_TOKEN@*/Text("Bottom Safe Area Inset")/*@END_MENU_TOKEN@*/
                   }

        }
    }
}


#Preview {
    ProfileEditor(profile: .constant(.default))
}
