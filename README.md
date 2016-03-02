# UIView+Border

## Demo

```swift
let rectangle = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 60))
rectangle.backgroundColor = UIColor.grayColor()
view.addSubview(rectangle)

rectangle.borderTop = Border(size: 3, color: UIColor.orangeColor(), offset: UIEdgeInsets(top: 0, left: -10, bottom: 0, right: -5))
rectangle.borderBottom = Border(size: 6, color: UIColor.redColor(), offset: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0))
rectangle.borderLeft = Border(size: 2, color: UIColor.blueColor(), offset: UIEdgeInsets(top: 10, left: -10, bottom: 0, right: 0))
rectangle.borderRight = Border(size: 2, color: UIColor.greenColor(), offset: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
```
![Demo](http://i.imgur.com/XVGJAk8.jpg)

Remove border
```swift
rectangle.borderTop = nil
```

## Install
Drag `UIView+Border.swift` to your xcode project.
