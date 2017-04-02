//
//  SpinningView.swift
//  Loading Text Field
//
//  Created by Mikhail Zaslavskiy on 10.03.17.
//  Copyright © 2017 Mikhail Zaslavskiy. All rights reserved.
//

import Foundation
import UIKit

class SpinningView: UIView {
    
    var lineWidth: CGFloat? {
        didSet {
            circleLayer.lineWidth = lineWidth!
        }
    }
    
    var speed: UInt? {
        didSet {
            guard let speed = speed else {
                return
            }
            
            self.animating = false
            
            circleLayer.strokeColor = self.color?.cgColor ?? tintColor.cgColor
            rotationAnimation.duration = (4.0 * 100.0)/Double(speed)
            
            let groupDuration = (2.5 * 100.0)/Double(speed)
            let animationDuration = (2.0 * 100.0)/Double(speed)
            
            //stroke end animation configuration
            let strokeEndGroup = strokeEndAnimation as! CAAnimationGroup
            strokeEndGroup.duration = groupDuration
            strokeEndGroup.animations?.first?.duration = animationDuration
            
            //stroke start animation configuration
            let strokeStartGroup = strokeStartAnimation as! CAAnimationGroup
            
            strokeStartGroup.duration = groupDuration
            strokeStartGroup.animations?.first?.duration = animationDuration
            strokeStartGroup.animations?.first?.beginTime = groupDuration - animationDuration
            
            self.animating = true
        }
    }
    
    var color: UIColor? {
        didSet {
            circleLayer.strokeColor = self.color?.cgColor ?? tintColor.cgColor
        }
    }
    
    var animating: Bool = true {
        didSet {
            updateAnimationState()
        }
    }
    
    let circleLayer = CAShapeLayer()
    
    var rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.duration = 4
        animation.repeatCount = MAXFLOAT
        return animation
    }()
    
    var strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    var strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        circleLayer.lineWidth = lineWidth ?? 1
        circleLayer.fillColor = nil
        circleLayer.strokeColor = self.color?.cgColor ?? tintColor.cgColor
        layer.addSublayer(circleLayer)
        updateAnimationState()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth/2
        
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = startAngle + CGFloat(M_PI * 2)
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.position = center
        circleLayer.path = path.cgPath
    }
    
    func updateAnimationState() {
        if animating {
            circleLayer.add(strokeEndAnimation, forKey: "strokeEnd")
            circleLayer.add(strokeStartAnimation, forKey: "strokeStart")
            circleLayer.add(rotationAnimation, forKey: "rotation")
        }
        else {
            circleLayer.removeAnimation(forKey: "strokeEnd")
            circleLayer.removeAnimation(forKey: "strokeStart")
            circleLayer.removeAnimation(forKey: "rotation")
        }
    }

}
