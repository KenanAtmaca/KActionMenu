//
//  Created by Kenan Atmaca on 19.08.2019.
//  Copyright © 2019 Kenan Atmaca. All rights reserved.
//

import UIKit

public enum KActionAnimationStyle {
    case scale
    case size
}

public enum KActionMenuStyle {
    case light
    case dark
}

public protocol KActionDelegate: class {
    func touchItem(name:String, index:Int)
}

public protocol KActionScreenDelegate: class {
    func didCloseScreen()
}

open class KActionMenu {
    
    public var view = KActionMenuView()
    private var rootView:UIView!
    
    public init(rootView: UIView) {
        self.rootView = rootView
        view.rootView = rootView
    }
    
    public func show(items: [(String, UIImage?)],position: CGPoint, animation: KActionAnimationStyle? = nil) {
        if !view.isShowView && items.count > 0 {
            view.table.items = items
            view.animationStyle = animation
            view.setup()
            view.setContentPosition(point: position)
            view.isShowView = true
            rootView.addSubview(view)
        }
    }
    
    public func setMenuStyle(_ style: KActionMenuStyle) {
         view.menuStyle = style
    }
}

