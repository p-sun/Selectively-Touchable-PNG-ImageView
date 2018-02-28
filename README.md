# Selectively-Touchable-PNG-ImageView
A UImageView that ignores touches at the points where the image is clear.

![IslandDemo][islandDemo]

[islandDemo]: https://github.com/p-sun/Selectively-Touchable-PNG-ImageView/blob/master/islandDemo.gif

## How to Use
Copy the `IgnoreClearPixelsView` folder into your project.

Add a gesture recognizer onto the `IgnoreClearPixelsImageView`. The gesture recognizer will only respond to locations where the image has an alpha greater than 0.

```Swift
let islandImageView = IgnoreClearPixelsImageView()
let islandImage = #imageLiteral(resourceName: "island")
islandImageView.image = islandImage
islandImageView.isUserInteractionEnabled = true

let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(islandTapped))
islandImageView.addGestureRecognizer(tapRecognizer)
```
