# appygram_ios

[![CI Status](http://img.shields.io/travis/GoGoCarl/appygram_ios.svg?style=flat)](https://travis-ci.org/GoGoCarl/appygram_ios)
[![Version](https://img.shields.io/cocoapods/v/appygram_ios.svg?style=flat)](http://cocoapods.org/pods/appygram_ios)
[![License](https://img.shields.io/cocoapods/l/appygram_ios.svg?style=flat)](http://cocoapods.org/pods/appygram_ios)
[![Platform](https://img.shields.io/cocoapods/p/appygram_ios.svg?style=flat)](http://cocoapods.org/pods/appygram_ios)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

appygram_ios is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "appygram_ios"
```

## Getting Started

One you introduce appygram_ios into your project dependencies, 
the key component to sending Appygrams is to create an instance
of <code>AppygramMessenger</code>.  This object will allow you
to send Appygram messages as well as retrieve a list of topics.  

<code>AppygramMessenger</code> is bound to a given API key, so 
you'll need to configure your messenger with properties via
<code>AppygramConfig</code>. 
You can do this one of two ways:

### Using a Global AppygramMessenger

If your application will only use one API key for the entire
application, 
you can quickly configure a static, global messenger instance by calling 
<code>Appygram.configure</code>. The configuration call takes an 
<code>AppygramConfig</code> object, described below.  From there, you 
can access the <code>AppygramMessenger</code> object from anywhere in 
your code simply by calling <code>Appygram.Global()</code>.

### Create specific AppygramMessage instance(s).

If your application may have muliple API keys, or you prefer not to use 
static objects, you can create a specific instance of 
<code>AppygramMessenger</code> by calling <code>Appygram.instance</code>. 
This call takes an <code>AppygramConfig</code> object, described below, 
and returns the <code>AppygramMessenger</code>.  Use this 
object to send messages in your application.


Whichever method you choose to setup your AppygramMessenger, you'll need 
to pass in AppygramConfig, which allows you to set the following
properties:

*   key (required) - your Appygram API key.
*   topic - the default topic for all Appygrams (default null)
*   url - the URL of the Appygram endpoints (defaults to current)
*   platform - add'l information about your platform
*   software - add'l information about your software

AppygramConfig can also take a <code>Dictionary<String, String></code> 
object in the constructor. The following properties are supported, and 
correspond to the aforementioned properties above, in order:

*   com.appygram.java.key (required)
*   com.appygram.java.topic
*   com.appygram.java.url
*   com.appygram.java.platform
*   com.appygram.java.software

Create this object, set the appropriate information.  Then, to configure
a Global AppygramMessenger:

```swift
Appygram.configure(AppygramConfig(api_key: "my-API-key"))
```

Or, to create an instance of AppygramMessenger:

```swift
AppygramMessenger messenger = Appygram.instance(AppygramConfig(api_key: "my-API-key"))
```

Now you are ready to create Appygrams.  For simplicity, the examples 
below will assume you are using the Global AppygramMessenger, but the 
same methods will work if you are using a specific instance as well.

### Sending Appygram Messages

To create an AppygramMessage object, you can simply call:

```swift
var message : AppygramMessage = Appygram.Global().create()
```

This will generate a new message, pre-filled with any defaults you 
specified in your configuration earlier.  From there, you can set 
the following fields:

*   topic - of principal importance in message routing
*   subject
*   message
*   name
*   email
*   phone
*   platform
*   software
*   app_json - Any object assigned to this field will be serialized 
    into JSON.  You can supply a Dictionary of <String, AnyObject> that will 
    allow you to address objects later by key.  It is null by default.

The AppygramMessage object can be extended to allow you to provide 
your own custom implementation for ease of development.

Once you have your message set, simply call:

```swift
Appygram.Global().send(message)
```

This will send Appygram information to your specified endpoint, 
and you're done.

### Listen for Appygrams

If you want to be notified in code when an Appygram has been sent, 
you can create a class that implements
<code>AppygramEventHandler</code>. 
This protocol has a single function, <code>afterSend</code> that takes 
an AppygramEvent containing the message that was sent, a success
boolean, 
and the response message, if available.  To set, call:

```swift
Appygram.Global().addAfterSendHandler(handler);
```

### Appygram Topics

To get a listing of all the topic information that you have set up on 
Appygram.com, you can call:

```swift
Appygram.Global().topics() { (topics : Array<AppygramTopic>) in
  println(topics)
} 
```

This will yield a list of all your topics, which you can present to 
your client using the id and name variables on AppygramTopic.

## Author

Carl Scott, carl.scott@solertium.com

## License

appygram_ios is available under the MIT license. See the LICENSE file for more info.
