//
//  PingEvent.swift
//  PinkSDK
//
//  Created by Abin Baby on 08/03/21.
//

import CoreLocation
import Foundation


/// Represents contents of log that is send to server
public struct PingEvent {
    /// the geo location of user
    let latitude: Double
    let longitude: Double

    /// the timestamp that has to be send to server. the value represents epoch timestamp in seconds.
    let timeStamp: Double

    /// the note or comment that has to be added with log
    let comment: String?

    public init(timestamp: Double?, comment: String?) {
        let locManager = CLLocationManager()
        var location: CLLocation = CLLocation(latitude: 0, longitude: 0)
        locManager.requestWhenInUseAuthorization()

        switch locManager.authorizationStatus {
        case .restricted, .denied:
            let logger: Logger = DefaultLogger(minLevel: .warning)
            logger.warning("User has not allowed to access location")
        default:
            if let currentLocation = locManager.location {
                location = currentLocation
            }
        }
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.timeStamp = timestamp ?? NSDate().timeIntervalSince1970
        self.comment = comment
    }
}
