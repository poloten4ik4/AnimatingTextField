//
//  LoadingTextField.swift
//  UITextField+LoadingIndicator
//
//  Created by Mikhail Zaslavskiy on 26.03.17.
//  Copyright © 2017 Mikhail Zaslavskiy. All rights reserved.
//

import Foundation
import UIKit

class LoadingTextField: UITextField {
    
    lazy var spinningLoader: SpinningView = {
        let clearButtonFrame = self.clearButtonRect(forBounds: self.bounds)
        let spinningView = SpinningView(frame: clearButtonFrame)
        self.addSubview(spinningView)
        spinningView.alpha = 0
        return spinningView
    }()
    
    //The speed of indicator. Default is 100. Minimum is 0.
    var loadingIndicatorSpeed: UInt? {
        didSet {
            spinningLoader.speed = self.loadingIndicatorSpeed
        }
    }
    
    //Color of spinning view
    var loadingIndicatorColor: UIColor? {
        didSet {
            spinningLoader.color = self.loadingIndicatorColor
        }
    }
    
    //Width of spinning view. Default is 1.0
    var loadingIndicatorWidth: CGFloat? {
        didSet {
            spinningLoader.lineWidth = self.loadingIndicatorWidth
        }
    }
    
    func startAnimating() {
        self.spinningLoader.alpha = 1;
    }
    
    func startAnimating(animationBlock:(UIView)->()) {
        animationBlock(self.spinningLoader)
    }
    
    func stopAnimating() {
        self.spinningLoader.alpha = 0;
    }
    
    func stopAnimating(animationBlock:(UIView)->()) {
        animationBlock(self.spinningLoader)
    }
}
