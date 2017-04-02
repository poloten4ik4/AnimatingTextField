//
//  ViewController.swift
//  UITextField+LoadingIndicator
//
//  Created by Mikhail Zaslavskiy on 26.03.17.
//  Copyright © 2017 Mikhail Zaslavskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var speedValueLabel: UILabel!
    @IBOutlet weak var exampleTextField: LoadingTextField!
    
    private var delayTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        exampleTextField.startAnimating()
        exampleTextField.loadingIndicatorWidth = 1.2
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.loadingTextField2.stopAnimating()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.loadingTextField2.startAnimating()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            self.loadingTextField2.stopAnimating(animationBlock: { (spinningView) in
                UIView.animate(withDuration: 0.5, animations: {
                    spinningView.alpha = 0
                })
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) {
            self.loadingTextField2.startAnimating(animationBlock: { (spinningView) in
                UIView.animate(withDuration: 0.5, animations: {
                    spinningView.alpha = 1
                })
            })
        }
        */
    }
    
    @IBAction func speedValueChanged(_ sender: UISlider) {
        let speed = Int(sender.value)
        speedValueLabel.text = "Speed: \(speed)"
        
        self.delayTimer?.invalidate()
        self.delayTimer = nil
        self.delayTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in 
            self.exampleTextField.loadingIndicatorSpeed = UInt(speed)
        })
        
    }
    
    @IBAction func colorSelected(_ sender: UITapGestureRecognizer) {
        exampleTextField.loadingIndicatorColor = sender.view?.backgroundColor
    }
}

