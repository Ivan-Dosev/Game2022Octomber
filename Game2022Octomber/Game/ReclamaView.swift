//
//  ReclamaView.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import SwiftUI

struct ReclamaView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject               var gameSetting : GameSetting
   
    
    var body: some View {
        ZStack {
            Image("BGReclama")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .rotationEffect(.degrees(90))
                .opacity(0.5)
            qestionShape()
                .fill(Color.red)
            //   .stroke(Color.yellow, lineWidth: 1)
               .frame(width: 350, height: 350)
               .shadow(color: Color.white, radius: 20, x: -5, y: -5)
               .overlay(
                ZStack{
                    if  gameSetting.score < 3 {
                        oneButton
                    }else{
                        twoButtons
                    }
                }
               )
              
               .foregroundColor(.white)
             //  .blur(radius: 3)
               .padding(.top, 30)
              // .background(.ultraThinMaterial)
          //  Text("reclama")
        }
    }
}

struct ReclamaView_Previews: PreviewProvider {
    static var previews: some View {
        ReclamaView()
    }
}

extension ReclamaView {
    @ViewBuilder
    var oneButton : some View {
        VStack(alignment: .center, spacing: 10){
            Text("Your hero died")
            Text("try again")
          
            HStack(alignment: .center, spacing: 50){

                Button("Ok") {
                    gameSetting.score = 0
                    presentationMode.wrappedValue.dismiss()
                    
                }.padding()
                    .font(.caption)
                    .frame(width: 120, height: 50)
                    .background{
                        Color.white.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
                    }
            }
            .padding(.bottom, 100)
        }
    }
    
    @ViewBuilder
    var twoButtons : some View {
        VStack(alignment: .center, spacing: 10){
            Text("Your hero died")
            Text("you can start over")
            Text("To save your points please watch this")
            HStack(alignment: .center, spacing: 50){
                Button("Cancel") {
                    
                    presentationMode.wrappedValue.dismiss()
                    gameSetting.score = 0
                    
                }.padding()
                    .font(.caption)
                    .frame(width: 120, height: 50)
                    .background{
                        Color.white.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
                    }
                Button("Ok") {
                    
                    gameSetting.tapCount = gameSetting.tapCount + gameSetting.score
                    UserDefaults.standard.set(gameSetting.tapCount, forKey: "Tap")
                    gameSetting.score = 0
                    presentationMode.wrappedValue.dismiss()
                    
                }.padding()
                    .font(.caption)
                    .frame(width: 120, height: 50)
                    .background{
                        Color.white.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
                    }
            }
            .padding(.bottom, 100)
        }
    }
}



