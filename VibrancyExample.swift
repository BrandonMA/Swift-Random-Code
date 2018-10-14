//
//  View.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 19/12/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

class View: SFView {
    
    let effect = UIBlurEffect(style: .dark)
    
    lazy var redView: SFView = {
        let view = SFView(automaticallyAdjustsColorStyle: false)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPopView)))
        view.backgroundColor = .red
        return view
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePopView)))
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var popView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.effect = UIVibrancyEffect(blurEffect: effect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var text: UILabel = {
        let label = UILabel()
        label.text = "Hola"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init(automaticallyAdjustsColorStyle: Bool = true) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        
        addSubview(redView)
        redView.size(width: SFDimension(type: .point, value: 200), height: SFDimension(type: .point, value: 200))
        redView.center()
        
        addSubview(blurView)
        blurView.clipEdges()
        
        blurView.contentView.addSubview(popView)
        popView.size()
        popView.clipTop(to: .bottom)
        popView.clipRight(to: .right)
        popView.clipLeft(to: .left)
        
        popView.contentView.addSubview(text)
        text.center()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showPopView() {
        
        blurView.isUserInteractionEnabled = true
        
        popView.remove(constraintType: .top)
        popView.clipTop(to: .top, margin: 30)
        
        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.7) {
            self.blurView.effect = self.effect
            self.layoutIfNeeded()
        }

        animator.startAnimation()
    }
    
    @objc func hidePopView() {
        
        blurView.isUserInteractionEnabled = false
        
        popView.remove(constraintType: .top)
        popView.clipTop(to: .bottom)
        
        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.7) {
            self.blurView.effect = nil
            self.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
}
























