# DQPopup
A lightweight library for presenting custom view as a popup
![Show](https://github.com/QiuDaniel/DQPopup/blob/master/snap.gif)


# Features

- Support several popup show types
    - [x] Fade In
    - [x] Spring In
    - [x] Drop In
    - [x] Slide In from top, bottom, left, right
    - [ ] Support custom

- Support several popup dismiss types
    - [x] Fade Out
    - [x] Spring Out
    - [x] Drop Out
    - [x] Slide Out to top, bottom, left, right
    - [ ] Support custom

# Installation

There are two ways to use `DQPopup` in your project:

- Installation with `CocoaPods`
- `Manually` install

### CocoaPods
The easiest way of installing DQPopup is via [CocoaPods](http://cocoapods.org/). 

```
pod 'DQPopup'
```

### Manually

Alternatively you can directly add the `DQPopup` source files to your project.

- Download the [latest code version]() or add the repository as a git submodule to your git-tracked project.
- Open your project in Xcode, then drag and drop `DQPopup` folder onto your project (use the `"Product Navigator view"`). Make sure to select `Copy items` when asked if you extracted the code archive outside of your project.

# Usage

In a UIViewController, the code below will show a custom view as a popup:

```  Swift
let view = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
dq.present(view, animation: DQPopupAnimationFade())
```

Included is a demo project showing how to fully use it.


# Customization

## DQPopupAnimationType

Animation transition for presenting contentView. Controlled how the popup will be presented. If you think that these four animations can't meet your needs, you can extend it yourself. You only need to implement the protocol DQPopupAnimationType in the custom class and rewrite the corresponding two methods.

```Swift
    func show(_ popupView: UIView, overlayView: UIView)
    func dismss(_ popupView: UIView, overlayView: UIView, completion: @escaping CompletionHandler)
```

# License

DQPopup is licensed under the terms of the MIT License. Please see the [LICENSE](LICENSE.md) file for full details.
