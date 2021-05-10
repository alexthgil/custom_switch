//
//  CustomSwitch.swift
//  CustomSwitch
//
//  Created by Alex on 1/16/21.
//

import UIKit

class CustomRectSwitch: UIControl, CAAnimationDelegate {

    private let controlItemPadding: CGFloat = 2.0
    private let animationDuration = 0.2
    private var animation: CABasicAnimation?
    private let animationKey = "KEY_Animation_controlPath"
    private let backgroundLayer = CALayer()
    private let controlShapeLayer = CAShapeLayer()
    
    private let onStateColorFill = CGColor(srgbRed: 0, green: 1.0, blue: 0, alpha: 1)
    private let offStateColorFill = CGColor(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    
    var isOn = false {
        didSet {
            updateDisplayingState()
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.addSublayer(backgroundLayer)
        self.layer.addSublayer(controlShapeLayer)
        backgroundLayer.backgroundColor = UIColor.blue.cgColor
        controlShapeLayer.fillColor = isOn ? onStateColorFill : offStateColorFill
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = self.bounds
        controlShapeLayer.frame = self.bounds
        controlShapeLayer.path = calculateControlRect(for: isOn)
    }
    
    private func calculateControlRect(for state: Bool) -> CGPath {
        let x = state ? (self.bounds.size.width - calculateControlWidth() - controlItemPadding) : controlItemPadding
        let y = controlItemPadding
        let w = calculateControlWidth()
        let h = calculateControlHeight()
        return CGPath(rect: CGRect(x: x, y: y, width: w, height: h), transform: nil)
    }
    
    private func updateDisplayingState() {
        
        if isOn == false {
            controlShapeLayer.fillColor = offStateColorFill
        }
        
        let newAnimation = CABasicAnimation(keyPath: "path")
        let oldPath = calculateControlRect(for: (isOn == false))
        let newPath = calculateControlRect(for: isOn)
        newAnimation.duration = animationDuration
        newAnimation.fromValue = oldPath
        newAnimation.toValue = newPath
        newAnimation.delegate = self
        newAnimation.fillMode = .forwards
        newAnimation.isRemovedOnCompletion = false
        newAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: "easeInEaseOut"))
        animation = newAnimation
        controlShapeLayer.add(newAnimation, forKey: animationKey)
    }
    
    private func calculateControlWidth() -> CGFloat {
        return self.bounds.width * 0.5 - 2 * controlItemPadding
    }
    
    private func calculateControlHeight() -> CGFloat {
        return self.bounds.height - 2 * controlItemPadding
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isOn = (isOn == false)
        sendActions(for: .valueChanged)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag && (controlShapeLayer.animation(forKey: animationKey) === anim) {
            controlShapeLayer.fillColor = isOn ? onStateColorFill : offStateColorFill
        }
    }
}
