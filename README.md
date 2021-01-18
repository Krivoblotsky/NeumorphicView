# NeumorphicView

NeumoprhicView is a simple `NSView` subclass that demonstrates the way of creation neumorphic-like views on macOS.

### Requirements

* macOS 10.12+

### Installation

`NeumorphicView` is available via Swift Package Manager.

```swift
dependencies: [
    .package(url: "https://github.com/Krivoblotsky/NeumorphicView.git", .upToNextMajor(from: "1.0.0"))
]
```
Or you can use Xcode 11+: Project -> Swift Packages -> "+".

### Usage

```swift
//Import Module
import NeumorphicView

//Add to your superview or use Interface Builder 
let neumorphicView = NeumorphicView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
self.view.addSubview(neumorphicView)
```

### Setup

`NeumorphicView` has several basic inspectable properties to play with.

```swift

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

```

### Demo

See `NeumorphicView.xcodeproj` for the demo. 

### Screenshots

<p float="center">
  <img src="/Screenshots/Screenshot1.png"/>
  <img src="/Screenshots/Screenshot2.png"/> 
  <img src="/Screenshots/Screenshot3.png"/>
</p>
