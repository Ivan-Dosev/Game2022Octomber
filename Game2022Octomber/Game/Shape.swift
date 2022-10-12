//
//  Shape.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import Foundation
import SwiftUI

struct RectangleElipse: Shape {

    func path(in rect: CGRect) -> Path {
        
        return Path { path in

            let topRadius = ((rect.maxX / 6) * 3 )

            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX - topRadius, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - topRadius, y: -topRadius),
                        radius: topRadius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 0),
                        clockwise: true)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxX ))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
  
        }
    }
}

struct RectangleTopElipse: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in

            let topRadius = ((rect.maxX / 6) * 3 )
           
         
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY + topRadius))
            path.addArc(center: CGPoint(x: rect.maxX - topRadius , y:rect.maxY + topRadius ),
                       radius: topRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: -90),
                        clockwise: true)

            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY ))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.closeSubpath()
  
        }
    }
}
