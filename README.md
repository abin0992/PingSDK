# PingSDK
PingSDK sends log to the server
## Features
Sends a log to the server from the client iOS app with the following
- User location
- Timestamp
- Comment

## Installation
PingSDK can be installed through swift package manager.

## Usage
Note - The app should ask permission for user location before using SDK. [The steps are explained here ](https://betterprogramming.pub/handling-location-permissions-in-ios-14-2cdd411d3cca). This has to be done be done before calling the `log` function. 

#### PingSDK Instance
In order to be able to log data you have to create an instance first.
```swift
let pingLogger = PingTracker()
```
You can either pass around this instance, or add an extension to the `PingTracker` class and add a shared instance property.

```Swift
extension PingTracker {
    static let shared: PingTracker = PingTracker()
}
```
#### Logging

`log()` function takes an optional parameter of `PingEvent` object. Add explicit timestamp or comment to this event object

```Swift
let event = PingEvent(timestamp: Double?, comment: String?)
```
then call the function
```Swift
PingTracker.shared.log(event)
```
When no parameter is passed the current timestamp is send to server.

## To do
- Add Cocoapods and carthage support
- Add more tests and run in CI

