<p align="center">
  <img src="https://crunchbase-production-res.cloudinary.com/image/upload/c_pad,h_98,w_98/v1413092159/tdbsauyud0ukogknylzu.svg" alt="Nodes"/>
</p>


This repository is a collection of extensions, snippets and tweaks we commonly use at [Nodes](http://nodesagency.com).

![Plaforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/Serializable/blob/master/LICENSE)

## 📝 Requirements

* iOS 8.0+
* Swift 2.0+

## 📦 Installation

### Carthage
~~~
github "nodes-ios/Nodes" 
~~~

## 🔧 Setup

1. Add the framework to your project
2. Put it inside the `Embedded Binaries` section on your target settings

## 💻 Usage

### Default Unwrapper

This framework contains an unwrapper to be used with [Serializable](https://github.com/nodes-ios/Serializable)'s extension for Alamofire. It then automatically extracts data from the response using the same pattern we commonly use in our API's.

You however need to manually set this unwrapper on the Parser inside Serializable. Best place to do this is in your `AppDelegate`.

```swift
import Serializable
import Nodes

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
// ...
Parser.defaultUnwrapper = unwrapper()
// ...
}
```

### Paginated Response

To have easier access to pagination information from the API we provide a `PaginatedResponse` struct, which can be used instead Alamofire's native `Response`. Implementation is simple:

```swift
func fetchInformationFromAPI(completion: PaginatedResponse<Information, NSError> -> Void) {}
```

You can then access the pagination information in the callback like this:

```swift
// ...

fetchInformationFromAPI(completion: { response in 
	switch response.result {
	case .Success(let object):
		print(object.data) // Your model, in this case `Information`
		print(object.meta.pagination) // The meta (pagination) data
		break
	default: break
	}
})

// ...
```


## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

## 📄 License
**Nodes** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Nodes/blob/master/LICENSE) file for more info.
