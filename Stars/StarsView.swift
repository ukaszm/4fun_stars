//
//  StarsView.swift
//  Stars
//
//  Created by Łukasz Majchrzak on 30/12/2016.
//  Copyright © 2016 Łukasz Majchrzak. All rights reserved.
//

import UIKit

struct Star {
    var x: CGFloat
    var y: CGFloat
    var z: Int
    var pz: Int
    var lineWidth: CGFloat
    var color: UIColor
    init(x: CGFloat, y: CGFloat, z: Int) {
        self.x = x
        self.y = y
        self.z = z
        let r = Float(200 + arc4random_uniform(800)) / 1000
        let g = Float(200 + arc4random_uniform(800)) / 1000
        let b = Float(200 + arc4random_uniform(800)) / 1000
        self.color = UIColor(colorLiteralRed: r, green: g, blue: b, alpha: 1.0)
        pz = z
        lineWidth = 1 + CGFloat(arc4random_uniform(50)) / 100
    }
}

class StarsView: UIView {
    let starsNumber = 300
    static let maxDistance = 1024
    static let starSpeed = 50
    var stars = [Star]()
    
    var updateView = false

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.black.setFill()
        path.fill()
        
        let halfWidth  = bounds.size.width  / 2
        let halfHeight = bounds.size.height / 2
        for star in stars {
            let line = UIBezierPath()
            star.color.setStroke()
            line.lineWidth = star.lineWidth
            let x  = (star.x - halfWidth)  * bounds.size.width  / CGFloat(star.z)  + halfWidth
            let y  = (star.y - halfHeight) * bounds.size.height / CGFloat(star.z)  + halfHeight
            let px = (star.x - halfWidth)  * bounds.size.width  / CGFloat(star.pz) + halfWidth
            let py = (star.y - halfHeight) * bounds.size.height / CGFloat(star.pz) + halfHeight
            line.move(to: CGPoint(x: x, y: y))
            line.addLine(to: CGPoint(x: px, y: py))
            line.stroke()
        }
    }
    
    func start() {
        updateView = true
        for _ in 0..<starsNumber {
            stars.append(newStar())
        }
        update()
    }
    func stop() {
        updateView = false
        stars = []
    }
    
    func newStar() -> Star {
        let x = CGFloat(arc4random_uniform(UInt32(bounds.width)))
        let y = CGFloat(arc4random_uniform(UInt32(bounds.height)))
        let z = Int(arc4random_uniform(UInt32(StarsView.maxDistance-1)))+1
        return Star(x: x, y: y, z: z)
    }
    
    func update() {
        guard updateView else { return }
        
        for i in 0..<stars.count {
            stars[i].pz = stars[i].z
            stars[i].z -= StarsView.starSpeed
            if stars[i].z <= 0 {
                stars[i] = newStar()
            }
        }
        setNeedsDisplay()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(33)) { [weak self] in
            self?.update()
        }
    }
    
}
