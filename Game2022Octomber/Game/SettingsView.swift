//
//  SettingsView.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//


import SwiftUI
import SpriteKit

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var gameSetting : GameSetting
    @State var bgOnOffButton : Bool = false
    
    var width =  UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    // gameSetting.nameBackground = "BG"
    var body: some View {
        ZStack(alignment: .top) {
            Image(gameSetting.nameTransparency.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height, alignment: .center)
        
               
            VStack(alignment: .center, spacing: 50) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Back")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .background(Color.red)
                            .padding(.horizontal, 20)
                    })

                    Spacer()
                }
             
                    
                    HStack{
                        ForEach(BGSetting.allCases, id: \ .id) { img in
                            if gameSetting.nameTransparency != img {
                                Image(img.rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height:100)
                                    .padding(.horizontal, 20)
                                    .onTapGesture {
                                        gameSetting.nameTransparency = img
                                    }
                            }

                        }
                    }
                    .background(Color.red)
                    .padding()
                
                
                Toggle(isOn: $gameSetting.soundOn) {
                    Text("sound off/on")
                }
                .padding()
                .background(Color.red)
                .padding()
                
                VStack{
                    Text("[Tottal: \(gameSetting.tapCount)] score: \(gameSetting.score)")
                    Button {
                        gameSetting.tapCount = gameSetting.tapCount + gameSetting.score
                        UserDefaults.standard.set(gameSetting.tapCount, forKey: "Tap")
                        gameSetting.score = 0
                    } label: {
                        Text("Add scote to Tottal")
                            .padding()
                            .foregroundColor(.white)
                            .background(.red)
                    }

                }
                
                VStack{
                    pickerView()
                      
                }

          
            }.padding(.top, 100)
        }
        .frame(width: width, height: height, alignment: .top)
        .ignoresSafeArea()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    func arda(name: String) -> String{
        if name == "AA" {
            return "aa1"
        }
        if name == "CC" {
            return "cc1"
        }
        if name == "DD" {
            return "dd1"
        }
        if name == "EE" {
            return "ee1"
        }
        if name == "FF" {
            return "ff1"
        }
        return "mm1"
    }
    
    func pickerView() -> some View {
      
         HStack {
                ForEach(gameSetting.atlases, id:\.self) { value in
                  
                    Image(arda(name: value))
                        .resizable()
                        .frame(width: 50, height: 60)
                        .padding(.horizontal, 5)
                      
                        .background((value ==  gameSetting.nameAtlas) ? Color.red : Color.gray)
                      
                        .onTapGesture {
                            gameSetting.nameAtlas = value
                        }
                      
                }
            }
         
          
    }
}

