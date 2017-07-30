//
//  HLoading.swift
//  HLoading
//
//  Created by Huy Nguyen on 7/30/17.
//  Copyright © 2017 HuyNguyen. All rights reserved.
//

import UIKit

let screenSize = UIScreen.main.bounds.size
let HLoading = HLoadingView.self

final class HLoadingView: UIView {
    
    // MARK: - Property
    var centerView: UIView!
    let durationTime: CGFloat = 3
    let circleShape = CAShapeLayer()
    static let hLoadingView = HLoadingView()
    
    // MARK: - init
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        
        backgroundColor = UIColor.clear
        layer.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privates
    fileprivate func setup() {
        
        let sizeCenterView = (100 / 320) * screenSize.width
        centerView = UIView(frame: CGRect(x: (screenSize.width / 2) - (sizeCenterView / 2),
                                          y: (screenSize.height / 2) - (sizeCenterView / 2),
                                          width: sizeCenterView, height: sizeCenterView))
        centerView.backgroundColor = UIColor.white
        centerView.layer.cornerRadius = 10
        addSubview(centerView)
        
        let center = CGPoint(x: (screenSize.width / 2),
                             y: (screenSize.height / 2))
        // Make a circle shape.
        let radius = sizeCenterView / 4
        let bezierPath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: 0,
                                      endAngle: (2 * CGFloat.pi),
                                      clockwise: true)
        circleShape.path = bezierPath.cgPath
        
        // Configure the appearance of the circle.
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.strokeColor = UIColor.lightGray.cgColor
        circleShape.lineWidth = 2.0
        
        // Add LoadingView on Parent View
        circleShape.frame = frame
        layer.addSublayer(circleShape)
        
        // Configure the animation
        animateGroup()
    }
    
    fileprivate func animateStrokeStart() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = CFTimeInterval(durationTime / 2.0)
        animation.duration = CFTimeInterval(durationTime / 2.0)
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
    
    fileprivate func animateStrokeEnd() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = 0
        animation.duration = CFTimeInterval(durationTime / 2.0)
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animation
    }
    
    fileprivate func animateRotation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = Float.infinity
        animation.duration = CFTimeInterval(durationTime / 2.0)
        
        return animation
    }
    
    fileprivate func animateGroup() {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animateStrokeEnd(), animateStrokeStart(), animateRotation()]
        animationGroup.duration = CFTimeInterval(durationTime)
        animationGroup.fillMode = kCAFillModeBoth
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = Float.infinity
        
        circleShape.add(animationGroup, forKey: "loading")
    }
    
    // MARK: - Public
    class func show() {
        guard let window = UIApplication.shared.windows.first else { return }
        window.addSubview(hLoadingView)
    }
    
    class func dismiss() {
        hLoadingView.removeFromSuperview()
    }
}
