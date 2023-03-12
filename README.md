# AngleGradientView
UIKit's CAGradientLayer has enhanced itself! 📈

## Details

Animation in UIKit is easy. Making some custom animations are relatively simple. However, making a custom animatable property can be quite challenging.

In this repository I wrote not just a simple approach to the latter one, but if you need to create a custom animatable property, this code can come to your rescue: the `GradientLayer` class has everything you need for your own solution.

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/VibrancyEffectView", exact: .init(0, 0, 1))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
let gradientView = GradientView(colors: [.red, .blue, .black])
gradientView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(gradientView)
gradientView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

UIView.animate(withDuration: 5) {
    gradientView.angle = .radians(.pi)
}

gradientView.angleDidUpdateHook = {
    print($0.degrees)
}
```

For details see the Example app.

## Example

<p style="text-align:center;"><img src="https://github.com/stateman92/AngleGradientView/blob/main/Resources/screenrecording.gif?raw=true" width="50%" alt="Example"></p>
