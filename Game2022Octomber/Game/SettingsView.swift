//
//  SettingsView.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//


import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var gameSetting : GameSetting
    @State var bgOnOffButton : Bool = false
    
    var body: some View {
        ZStack {
            Color.yellow
            VStack(alignment: .center, spacing: 50) {
                Text("TO Do somting ")
                
                bgButton()
                Image(gameSetting.nameBackground)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
extension SettingsView {
    
    @ViewBuilder
    func bgButton() -> some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.linearGradient(colors: [.white.opacity(0.6), .purple.opacity(0.2), .white.opacity(0.6)], startPoint: .topLeading, endPoint: .topTrailing))
            RoundedRectangle(cornerRadius: 15, style:  .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.6), .clear, .purple.opacity(0.2), .white.opacity(0.6)], startPoint: .topLeading, endPoint: .topTrailing), lineWidth: 1.5)
            Text(" bg ")
                .fontWeight(.bold)
                .padding(8)
                .padding(.horizontal, 4)
                .font(.caption)
                .background{
                    Color.white.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
                }
                .foregroundColor(.white)
            
        }.frame(width: 75, height: 50)
        .onTapGesture {
         //   print("pause \( gameSetting.PauseButton)")
            gameSetting.OnOffBackground.toggle()
            if  gameSetting.OnOffBackground {
                gameSetting.nameBackground = "city"
            }else{
                gameSetting.nameBackground = "BG"
            }
           
        }
    }
}
