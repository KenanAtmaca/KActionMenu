# KActionMenu

<br><p align="center">
<img src="https://user-images.githubusercontent.com/16580898/63414218-0f78d080-c404-11e9-93e7-9e88ddd182ca.gif" width="35%"/>
<img src="https://user-images.githubusercontent.com/16580898/63414255-23bccd80-c404-11e9-8cd3-2ab41d01e9d1.gif" width="35%"/>
</p>

<p align="center">
  <img alt="MIT Licance" src="https://img.shields.io/github/license/KenanAtmaca/KActionMenu"/>
  <img alt="Pod" src="https://img.shields.io/cocoapods/p/KActionMenu"/>
  <img alt="Swift" src="https://img.shields.io/badge/Swift-4.2%2B-orange"/>
</p>

## Requirements

- Xcode 9.0 +
- iOS 11.0 or greater

## Installation

### CocoaPods

1. Install [CocoaPods](http://cocoapods.org)
2. Add this repo to your `Podfile`

```ruby
platform :ios, '11.0'

target 'ProjectName' do
  use_frameworks!
  pod 'KActionMenu'
end
```

3. Run `pod install`
4. Open up the new `.xcworkspace` that CocoaPods generated
5. Whenever you want to use the library: `import KActionMenu`

### Manually

1. Simply download the `KActionMenu` source files and import them into your project.

## Usage

```Swift
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    var menu:KActionMenu!

    override func viewDidLoad() {
        super.viewDidLoad()
        bgImageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressAction)))
        
        menu = KActionMenu(rootView: self.view) // 1.
        menu.view.table.actionDelegate = self
        menu.view.screenDelegate = self
        menu.setMenuStyle(.light) // .light, .dark
    }
    
    @objc func longPressAction(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: bgImageView)
        
        menu.show(items: [("Follow", UIImage(named: "add")), ("Camera", UIImage(named: "cam")), ("Share", UIImage(named: "share")), ("Like", UIImage(named: "like"))], position: CGPoint(x: location.x, y: location.y), animation: .scale) // 2.
    }
}

extension ViewController: KActionDelegate, KActionScreenDelegate {
    func didCloseScreen() {
        print(" - Closed - ")
    }
    
    func touchItem(name: String, index: Int) {
        print(name, index)
        self.menu.view.close()
    }
}
```

## License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.
