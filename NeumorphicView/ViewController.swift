//
//  ViewController.swift
//  NemorphicView
//
//  Created by Sergii Kryvoblotskyi on 2/6/20.
//  Copyright © 2020 Sergii Kryvoblotskyi. All rights reserved.
//

import Cocoa

final class ViewController: NSViewController {
    
    @IBOutlet private weak var neumorphicView: NeumorphicView!
    @IBOutlet private weak var backgroundBox: NSBox!
    
    @IBOutlet private weak var cornerRadiusLabel: NSTextField!
    @IBOutlet private weak var cornerRadiusSlider: NSSlider!
    
    @IBOutlet private weak var distanceLabel: NSTextField!
    @IBOutlet private weak var distanceSlider: NSSlider!
    
    @IBOutlet private weak var blurRadiusLabel: NSTextField!
    @IBOutlet private weak var blurRadiusSlider: NSSlider!
    @IBOutlet private weak var convexSlider: NSSlider!
    
    @IBOutlet private weak var colorWell: NSColorWell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        backgroundBox.fillColor = NSColor(hexString: "EFEEEE")
    }
    
    @IBAction func radiousSliderValueChanged(_ sender: Any) {
        updateView()
    }
    
    @IBAction func distanceSliderValueChanged(_ sender: Any) {
        updateView()
    }
    
    @IBAction func blurRadiusSliderValueChanged(_ sender: Any) {
        updateView()
    }
    
    @IBAction func colorWellValueChanged(_ sender: Any) {
        updateView()
    }
    
    @IBAction func convexSliderValueChanged(_ sender: Any) {
        updateView()
        
        let neumorphicView = NeumorphicView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
        self.view.addSubview(neumorphicView)
    }
}


private extension ViewController {
    
    func updateView() {
        neumorphicView.cornerRadius = CGFloat(cornerRadiusSlider.floatValue)
        neumorphicView.shadowDistance = CGFloat(distanceSlider.floatValue)
        neumorphicView.blurRadius = CGFloat(blurRadiusSlider.floatValue)
        neumorphicView.convex = (CGFloat(convexSlider.floatValue) / 100)
        neumorphicView.bevelColor = colorWell.color
        backgroundBox.fillColor = colorWell.color
        
        cornerRadiusLabel.stringValue = "Corner radius: \(cornerRadiusSlider.intValue) px"
        distanceLabel.stringValue = "Shadow distance: \(distanceSlider.intValue) px"
        blurRadiusLabel.stringValue = "Blur radius: \(blurRadiusSlider.intValue) px"
    }
}
