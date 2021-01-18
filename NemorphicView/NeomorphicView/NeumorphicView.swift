//
//  NeomorphicView.swift
//  NeomorpicView
//
//  Created by Sergii Kryvoblotskyi on 2/6/20.
//  Copyright © 2020 Sergii Kryvoblotskyi. All rights reserved.
//

import Cocoa

@IBDesignable
final class NeumorphicView: NSView {

    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet { updateCornerRadius() }
    }
    
    @IBInspectable var blurRadius: CGFloat = 1 {
        didSet { updateBlurRadius() }
    }
    
    @IBInspectable var shadowDistance: CGFloat = 10 {
        didSet { updatePositions() }
    }
    
    @IBInspectable var bevelColor: NSColor = NSColor(hexString: "EFEEEE") {
        didSet { updateColors() }
    }
    
    @IBInspectable var convex: CGFloat = 0.0 {
        didSet { updateColors() }
    }
    
    private let rootLayer = CALayer()
    private let bevelLayer = CAGradientLayer()
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layout() {
        super.layout()
        updatePositions()
    }
}

extension NeumorphicView {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
}

private extension NeumorphicView {
    
    func updateCornerRadius() {
        gradientLayer.cornerRadius = cornerRadius
        bevelLayer.cornerRadius = cornerRadius
    }
    
    func updateBlurRadius() {
        gradientLayer.setValue(blurRadius, forKeyPath: #keyPath(CALayer.filters) + "." + CIFilterName.gaussianBlur + "." + "inputRadius")
    }
    
    func updatePositions() {
        bevelLayer.frame = bounds
        gradientLayer.frame = bounds.insetBy(dx: -shadowDistance, dy: -shadowDistance)
    }
    
    func updateColors() {
        let startColor = bevelColor.lighter(amount: 0.05, alphaAmount: 1.0)
        let endColor = bevelColor.darker(amount: 0.05, alphaAmount: 1.0)
        gradientLayer.colors = [
                  startColor.cgColor,
                  startColor.cgColor,
                  endColor.cgColor,
                  endColor.cgColor]
        let bevelStartColor = bevelColor.lighter(amount: 0.00 + convex, alphaAmount: 1.0)
        let bevelEndColor = bevelColor.darker(amount: 0.00 + convex, alphaAmount: 1.0)
        bevelLayer.colors = [bevelStartColor.cgColor, bevelEndColor.cgColor]
    }
}

private extension NeumorphicView {
    
    func commonInit() {
        setupRootLayer()
        setupShadowLayer()
        setupBevelLayer()
        updateCornerRadius()
        updateBlurRadius()
        updatePositions()
        updateColors()
    }
    
    func setupRootLayer() {
        wantsLayer = true
        layer = rootLayer
        rootLayer.masksToBounds = false
    }
    
    func setupShadowLayer() {
        gradientLayer.masksToBounds = false
        gradientLayer.locations = [0, 0.45, 0.55, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.actions = [
            "cornerRadius": NSNull(),
            "frame": NSNull(),
            "bounds": NSNull(),
            "position": NSNull(),
            "colors": NSNull()
        ]
        rootLayer.addSublayer(gradientLayer)
        if let filter = CIFilter(name:"CIGaussianBlur") {
            filter.name = .gaussianBlur
            gradientLayer.filters = [filter]
        }
    }
    
    func setupBevelLayer() {
        bevelLayer.cornerRadius = cornerRadius
        bevelLayer.locations = [0, 1.0]
        bevelLayer.actions = [
            "cornerRadius": NSNull(),
            "frame": NSNull(),
            "bounds": NSNull(),
            "position": NSNull(),
            "backgroundColor": NSNull(),
            "startPoint": NSNull(),
            "endPoint": NSNull(),
            "colors": NSNull()
        ]
        bevelLayer.endPoint = NSPoint(x: 0.15, y: 1.0)
        bevelLayer.startPoint = NSPoint(x: 0.85, y: 0.0)
        rootLayer.addSublayer(bevelLayer)
    }
}

private typealias CIFilterName = String
private extension CIFilterName {
    
    static let gaussianBlur = "gaussianBlur"
}
