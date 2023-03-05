# AngleGradientView
UIKit's CAGradientLayer has enhanced itself! 📈

### How to use

You can use the `AngleGradientView` like so:

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

### Example

<p style="text-align:center;"><img src="https://github.com/stateman92/AngleGradientView/blob/main/Resources/screenrecording.gif?raw=true" width="50%" alt="Example"></p>
