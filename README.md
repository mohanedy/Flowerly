<p align="center">
  <a href="https://flutter.io/">
    <img src="https://i.imgur.com/SR3h5GG.png" alt="Logo" width=250 height=250>
  </a>
  <h3 align="center">Flowerly</h3>
  <h5 align="center">If you like the project, please give it a star ⭐ It will show the creator your appreciation and help others to discover the repo.</h5>
  <p align="center">
    Know More About Your Flowers 🌸
    <br>
   Flowerly is iOS App that uses CoreML to predict image name and information  
    <br>
    <br>
    <a href="https://github.com/Mohanedy98/Flowerly/issues/new">Report bug</a>
    ·
    <a href="https://github.com/Mohanedy98/Flowerly/issues/new">Request feature</a>
<br>

[![Platform](https://img.shields.io/badge/platform-iOS-yellow.svg)]()
[![Language](https://img.shields.io/badge/language-Swift_5.0-orange.svg)]()
[![Framework](https://img.shields.io/badge/framework-CoreML-purple.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()
  </p>
</p>

## ✍️Quick start
This app require .mlmodel file in order to run and I couldn't upload this file because of the size 😥
but you can generate it with python 2.7 & [Coremltools](https://github.com/apple/coremltools) to convert the ML Model from .caffemodel to .mlmodel.

* Download the .caffemodel (~230Mb) [here](), and run the following python script:
```
import coremltools

coreml_model = coremltools.converters.caffe.convert(('oxford102.caffemodel','deploy.prototxt'),class_labels='flower-labels.txt',image_input_names='data')

coreml_model.save('FlowerlyClassifier.mlmodel')
```
Drag the FlowerlyClassifier.mlmodel into the Xcode project and you can run it!

This Model from [Oxford 102 Flowers Dataset](https://www.robots.ox.ac.uk/~vgg/data/flowers/102/)

## 🌟 This App Uses
  |                   🌟 Uses                      |
| :---------------------------------------------------- |
| Delegate Design Pattern  |
| CoreML Framework | 
| Alamofire to get flower information from [Wikipedia Api](https://www.mediawiki.org/wiki/API:Main_page)|
| [Chameleon Framework](https://github.com/viccalexander/Chameleon)|
| [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) to parse the json response from the API|

and a lot more 😊 ...


## 📱 Screenshots
 <img src="https://i.imgur.com/E5xUsyl.gif" alt="Preview"  height=350> &nbsp;<img src="https://i.imgur.com/Y48oPjS.png" alt="Home Screen"  height=350> &nbsp; <img src="https://i.imgur.com/RGlgyG0.png" alt="Flower1"  height=350> &nbsp;<img src="https://i.imgur.com/rIN8GYa.png" alt="Flower2"  height=350> &nbsp;

## ✔️ Requirements
* iOS 10.0+
* Xcode 11.3.1
* Python 2.7


## ℹ Creator
[**Mohaned Yossry**](https://github.com/Mohanedy98)


## 🛡️ Copyright and license

Code and documentation copyright 2020 the authors. Code released under the MIT License.

Enjoy
