//
//  GameSetting.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import SwiftUI

class GameSetting : ObservableObject {
    
    @Published var PauseButton     : Bool = true
    @Published var settingButton   : Bool = false
    @Published var nameBackground   : String = "BG"
    @Published var OnOffBackground   : Bool = false
    @Published var score : Int = 0
    @Published var reclama : Bool = false
    
}
