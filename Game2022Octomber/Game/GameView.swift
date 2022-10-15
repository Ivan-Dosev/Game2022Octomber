//
//  GameView.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//


import SwiftUI
import SpriteKit

struct GameView: View {
    
    @EnvironmentObject var gameSetting : GameSetting
    @StateObject       var motionManager = MotionManager()
    @State private     var onOpacity : Bool = false
    @State private     var onPlay : Bool = true
    
    var width =  UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    
    var scene : SKScene {
        
        let scene = Game_Scene(pauseButton: $gameSetting.PauseButton, nameBG: $gameSetting.nameBackground, score: $gameSetting.score, reclama: $gameSetting.reclama, soundOn: $gameSetting.soundOn)
        scene.size = CGSize(width: width  * 1.5, height: height)
        scene.scaleMode = .aspectFit
        scene.anchorPoint = CGPoint(x: 0, y: 0)

        return scene
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom ) {
            GeometryReader(){ geo in
                
         //       SpriteView(scene: scene)
         //           .scaledToFill()
         //
//
         //       HStack(alignment: .center, spacing: 30) {
//
         //               pauseButton()
         //               .sheet(isPresented: $gameSetting.reclama) {
         //                   ReclamaView()
         //               }
         //
         //               settingButton()
         //               .disabled(!gameSetting.PauseButton)
         //               .opacity(!gameSetting.PauseButton ? 0 : 1)
         //
         //               scoreGame()
         //       }
         //       .padding(.bottom, 20)
                
                Image(gameSetting.nameTransparency.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(self.onOpacity ? 1 : 0.5)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.interactiveSpring(), value: motionManager.xValue)
                    .offset(x: -geo.size.height / 1.5)
                    .offset(x: -motionManager.xValue * 95 )
                  
                
            SpriteView(scene: scene, options: [.allowsTransparency])
                 //   .offset(x:  -motionManager.xValue * 95)
                //    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .frame(width: width * 1.5, height: height, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                    .padding( -50)
                    .sheet(isPresented:$gameSetting.reclama) {
                        ReclamaView()
                    }
                
                bottomShape(color: "ColorA")
                    .frame(width: geo.size.width, height: shapeHeight(), alignment: .center)
                    .offset(y: geo.size.height - shapeHeight())
                if onPlay {
                    RectangleTopElipse()
                        // .stroke(Color.black, lineWidth: 1)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(gameSetting.nameTransparency.lineY()), Color(gameSetting.nameTransparency.lineX())]), startPoint: .top, endPoint: .bottom))
                         .frame(width: geo.size.width, height: shapeHeight(), alignment: .center)
                         .offset(y:  UIDevice.current.userInterfaceIdiom == .pad ? 0 : -shapeHeight() )
                         .overlay(
                           HStack{
                               Spacer()
                               Button("Setting") {
                                   withAnimation(.easeInOut){
                                       gameSetting.settingButton.toggle()
                                   }
                               }
                               .frame(width: buttonSize(), height: buttonSize())
                               .font(.system(size: buttonSize() / 4))
                               .foregroundColor(.red)
                                 .background(.white)
                                 .clipShape(Circle())
                                
                              
                           }
                            .offset(y:  UIDevice.current.userInterfaceIdiom == .pad ? buttonSize() : 0  )
                            .padding(.horizontal, buttonSize() / 5)
                               .padding(.bottom, buttonSize() * 0.5 )
                           )
                }

            }

        }
        .frame( maxWidth: .infinity,  maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(){ motionManager.detectMotion() }
        .onDisappear(){ motionManager.stopMotionUpdate() }
        .sheet(isPresented: $gameSetting.settingButton)  {
            SettingsView()
        }
        
    }
    
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}


extension GameView {
    
    @ViewBuilder
    func pauseButton() -> some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.linearGradient(colors: [.white.opacity(0.6), .purple.opacity(0.2), .white.opacity(0.6)], startPoint: .topLeading, endPoint: .topTrailing))
            RoundedRectangle(cornerRadius: 15, style:  .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.6), .clear, .purple.opacity(0.2), .white.opacity(0.6)], startPoint: .topLeading, endPoint: .topTrailing), lineWidth: 1.5)
            Text(gameSetting.PauseButton ? "play" : "pause")
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
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1)){
                gameSetting.PauseButton.toggle()
            }
         
        }
    }
}

extension GameView {
    
    @ViewBuilder
    func settingButton() -> some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.linearGradient(colors: [.white.opacity(0.6), .purple.opacity(0.2), .white.opacity(0.6)], startPoint: .topLeading, endPoint: .topTrailing))
            RoundedRectangle(cornerRadius: 15, style:  .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.6), .clear, .purple.opacity(0.2), .white.opacity(0.6)], startPoint: .topLeading, endPoint: .topTrailing), lineWidth: 1.5)
            Text(" set ")
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
            gameSetting.settingButton.toggle()
        }
    }
}

extension GameView {
    
    @ViewBuilder
    func scoreGame() -> some View {
        ZStack{
            Text("score = \(gameSetting.score)")

                .fontWeight(.bold)
                .padding(8)
                .padding(.horizontal, 4)
                .font(.system(size: buttonSize() / 5))
                .background{
                    Color.white.opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))
                }
                .foregroundColor(.white)
                .onChange(of: gameSetting.score) { score in
                    withAnimation(.spring()) {
                                 self.onOpacity.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                 self.onOpacity.toggle()
                        }
                    }
                }
            
        }.frame(width: 250, height: 40)
           

    }
}

extension GameView {
    
    func shapeHeight() -> CGFloat {
         if UIDevice.current.userInterfaceIdiom == .pad {
            return  70
         } else {
             return  40
         }
     }
     func buttonSize() -> CGFloat {
          if UIDevice.current.userInterfaceIdiom == .pad {
             return  130
          } else {
              return  70
          }
      }
}


extension GameView {
    
    func overlayOffset() -> CGFloat {
        let offset = motionManager.xValue * 7
        if offset > 0 {
            print(( offset > 8 ) ? 8 : offset)
            return( offset > 8 ) ? 8 : offset
        }
        print(( -offset > 8 ) ? -8 : offset)
        return ( -offset > 8 ) ? -8 : offset
    }
    
 
    func bottomShape(color: String) -> some View {
        
        
        ZStack{

            LinearGradient(gradient: Gradient(colors: [Color(gameSetting.nameTransparency.lineX()), Color(gameSetting.nameTransparency.lineY())]), startPoint: .top, endPoint: .bottom)
              .clipShape(   RectangleElipse())
              .overlay(
                HStack{
                    scoreGame()
                        .padding(.top, buttonSize() / 15)
                    Spacer()
                    Button(gameSetting.PauseButton ? "play" : "pause") {
                        withAnimation(.easeInOut){
                            gameSetting.PauseButton.toggle()
                            if !gameSetting.PauseButton {
                                onPlay = false
                            }else{
                                onPlay = true
                            }
                        }
                    }
                    .frame(width: buttonSize(), height: buttonSize())
                    .font(.system(size: buttonSize() / 4))
                    .foregroundColor(.red)
                      .background(.white)
                      .clipShape(Circle())
                     
                   
                }.padding(.horizontal, buttonSize() / 5)
                    .padding(.bottom, buttonSize() * 0.8 )
                )
        }
    }
    
    func topShape(color: String) -> some View {
        
        ZStack{

            LinearGradient(gradient: Gradient(colors: [Color("ColorB"), Color("ColorA")]), startPoint: .top, endPoint: .bottom)
              .clipShape(   RectangleTopElipse())
        }
    }
}
