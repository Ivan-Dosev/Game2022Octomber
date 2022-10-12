//
//  Game2022OctomberApp.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import SwiftUI

@main
struct Game2022OctomberApp: App {
    
    @StateObject  var game =  GameSetting()
    
    var body: some Scene {
        
        WindowGroup {
            
            GameView()
                .environmentObject(game)
                .preferredColorScheme(.dark)
            
        }
    }
}
