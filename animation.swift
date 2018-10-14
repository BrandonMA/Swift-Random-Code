//
//  View.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 19/12/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

class View: SFView {
    
    var animator: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.8) {
            self.blurView.isUserInteractionEnabled.toggle()
            self.blurView.effect = self.blurView.effect == nil ? UIBlurEffect(style: .dark) : nil
            self.layoutIfNeeded()
        }
    }
    
    private var animationProgress: CGFloat = 0
    
    lazy var redView: SFView = {
        let view = SFView(automaticallyAdjustsColorStyle: false)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPopView)))
        view.backgroundColor = .red
        return view
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePopView(gesture:))))
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var popView: SFView = {
        let view = SFView()
        view.layer.cornerRadius = 16
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(hidePopView(gesture:))))
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    required init(automaticallyAdjustsColorStyle: Bool = true) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        addSubview(redView)
        redView.size(width: SFDimension(type: .point, value: 200), height: SFDimension(type: .point, value: 200))
        redView.center()
        
        addSubview(blurView)
        blurView.clipEdges()
        
        addSubview(popView)
        popView.size()
        popView.clipTop(to: .bottom)
        popView.clipRight(to: .right)
        popView.clipLeft(to: .left)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showPopView() {
        
        popView.remove(constraintType: .top)
        popView.clipTop(to: .top, margin: 30)
    
        animator.startAnimation()
    }
    
    var newAnimator: UIViewPropertyAnimator!
    
    @objc func hidePopView(gesture: UIGestureRecognizer) {
        
        popView.remove(constraintType: .top)
        popView.clipTop(to: .bottom)
        
        if let gesture = gesture as? UIPanGestureRecognizer {

            if gesture.state == .began {
                newAnimator = animator
                newAnimator.startAnimation()
                newAnimator.pauseAnimation()
            } else if gesture.state == .changed {
                newAnimator.fractionComplete = gesture.translation(in: self).y / popView.bounds.height
            } else if gesture.state == .ended {
                newAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
            
        } else {
            animator.startAnimation()
        }
    }
}
























