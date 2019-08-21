//
//  Created by Kenan Atmaca on 19.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

open class KActionMenuView: UIView {
    
    private var menuContentView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
     public var table:KActionTable = {
       let table = KActionTable()
       table.backgroundColor = .clear
       return table
    }()
    
    private var blurView:UIVisualEffectView!
    private var blurEffect:UIBlurEffect!
    weak public var screenDelegate:KActionScreenDelegate?
    
    var rootView:UIView!
    var isShowView:Bool = false
    var animationStyle:KActionAnimationStyle?
    var menuStyle:KActionMenuStyle?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        self.frame = rootView.bounds
        self.alpha = 1
        setupBlurView()
        addSubview(blurView)
        addSubview(menuContentView)
        menuContentView.addSubview(table)
        menuContentView.frame.size = CGSize(width: self.frame.width * 0.7, height: CGFloat(table.items.count) * 60.0)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: menuContentView.topAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: menuContentView.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: menuContentView.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: menuContentView.bottomAnchor).isActive = true
        
        setShowAnimation()
    }
    
    private func setShowAnimation() {
        guard let animation = animationStyle else { return }
        switch (animation) {
        case .scale:
            self.blurView.alpha = 0
            self.menuContentView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
                self.blurView.alpha = 1
                self.menuContentView.transform = CGAffineTransform.identity
            }, completion: nil)
        case .size:
            self.blurView.alpha = 0
            self.menuContentView.frame.size.height = 0
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveEaseIn], animations: {
                self.blurView.alpha = 1
                self.menuContentView.frame.size.height = CGFloat(self.table.items.count) * 60.0
            }, completion: nil)
        }
    }
    
    func setContentPosition(point: CGPoint) {
        menuContentView.center.x = self.frame.width / 2
        let spacing = self.frame.height - self.frame.height * 0.8
        if point.y >= self.frame.height * 0.8 {
            menuContentView.center.y = point.y - spacing
        } else if point.y <= self.frame.height * 0.15 {
            menuContentView.center.y = point.y + spacing
        } else {
           menuContentView.center.y = point.y
        }
    }
    
    private func setupBlurView() {
        if let menuStyle = menuStyle {
            switch (menuStyle) {
            case .light:
                menuContentView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
                blurEffect = UIBlurEffect(style: .light)
            case .dark:
                menuContentView.backgroundColor = UIColor.white
                blurEffect = UIBlurEffect(style: .dark)
            }
        } else {
            menuContentView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            blurEffect = UIBlurEffect(style: .light)
        }
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = true
        blurView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @objc public func close() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (_) in
            self.blurView.removeFromSuperview()
            self.removeFromSuperview()
            self.isShowView = false
            self.screenDelegate?.didCloseScreen()
        }
    }
}
