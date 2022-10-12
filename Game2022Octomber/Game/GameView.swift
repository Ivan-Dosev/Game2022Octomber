//
//  GameView.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameSetting : GameSetting
    
    var body: some View {
        
        
        Text("Game")
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
