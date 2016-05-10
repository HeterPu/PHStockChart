PHStockChart
==============

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYKit/master/LICENSE)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status]()]()


Encapsulate all kinds of stock chart in only one view, supply easy interface .


* [ShiZilayer](https://github.com/HeterPu/PHStockChart) — A layer to draw SHIZI line and support gesture .
* [GuPiaoView](https://github.com/HeterPu/PHStockChart) — Main view to draw StockChart.


Demo Project
==============
See `PHStockChart/PHStockChart.xcodeproj`

<img src="https://raw.github.com/HeterPu/PHStockChart/master/PHStockChart/demo/snapshot/fenshi.png" width="320"><br/>
<img src="https://raw.github.com/HeterPu/PHStockChart/master/PHStockChart/demo/snapshot/lazhutu.png" width="320">


Installation
==============

### CocoaPods

1. Add `pod 'PHStockChart'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import \"GuPiaoView.h\".


### Carthage

1. Add `github "PHStockChart"` to your Cartfile.
2. Run `carthage update --platform ios` and add the framework to your project.
4. Notice: carthage framework doesn't include webp component, if you want to support webp, use CocoaPods or install manually.



Documentation
==============
You can also install documentation locally using [appledoc](https://github.com/tomaz/appledoc).


Requirements
==============
This library requires `iOS 4.0+` and `Xcode 6.0+`.


License
==============
YYKit is provided under the MIT license. See LICENSE file for details.





