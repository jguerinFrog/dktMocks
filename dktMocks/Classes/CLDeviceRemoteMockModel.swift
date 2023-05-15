//
//  CLDeviceRemoteMockModel.swift
//  
//
//  Created by Julien GUERIN on 26/04/2023.
//

import Foundation

public enum CLDeviceRemoteError: Error {
    case DeviceLocationError
    case DeviceAddressError
    case DeviceBatteryLevelError
    case DeviceStateError
    case DeviceConnectionStateError
}

struct CLDeviceRemoteMockData: Codable {
    let deviceId: String
    let timestamp: String
    let latitude: String
    let longitude: String
    let elevation: String
    let deviceAddress: String
    let batteryLevel: String
    let deviceState: String
    let deviceConnectionState: String
}

public struct CLDeviceLocation {
    var deviceId: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var elevation: Double = 0
    var date: Date = Date()

    static func initFromMockData(data: CLDeviceRemoteMockData) -> CLDeviceLocation {
        var location = CLDeviceLocation()
        location.deviceId = data.deviceId
        if let latitude = Double(data.latitude) { location.latitude = latitude }
        if let longitude = Double(data.longitude) { location.longitude = longitude }
        if let elevation = Double(data.elevation) { location.elevation = elevation }
        return location
    }
}

public struct CLDeviceAddress {
    var deviceId: String = ""
    var address: String = ""
    var date: Date = Date()

    static func initFromMockData(data: CLDeviceRemoteMockData) -> CLDeviceAddress {
        var address = CLDeviceAddress()
        address.deviceId = data.deviceId
        address.address = data.deviceAddress
        return address
    }
}

public struct CLDeviceBatteryLevel {
    var deviceId: String = ""
    var percentage: Int = 0
    var date: Date = Date()

    static func initFromMockData(data: CLDeviceRemoteMockData) -> CLDeviceBatteryLevel {
        var batteryLevel = CLDeviceBatteryLevel()
        batteryLevel.deviceId = data.deviceId
        if let percentage = Int(data.batteryLevel) { batteryLevel.percentage = percentage }
        return batteryLevel
    }
}

public struct CLDeviceState {
    var deviceId: String = ""
    var deviceState: DeviceState = .unknown
    var date: Date = Date()

    static func initFromMockData(data: CLDeviceRemoteMockData) -> CLDeviceState {
        var deviceState = CLDeviceState()
        deviceState.deviceId = data.deviceId
        deviceState.deviceState = .moving
        return deviceState
    }
}
public enum DeviceState {
    case unknown
    case stopped
    case moved
    case moving
    case stolen
}

public enum DeviceConnectionState {
    case offline
    case online
    case unknown
}

public struct CLDeviceConnectionState {
    var deviceId: String = ""
    var state: DeviceConnectionState = .unknown
    var date: Date = Date()

    static func initFromMockData(data: CLDeviceRemoteMockData) -> CLDeviceConnectionState {
        var deviceConnectionState = CLDeviceConnectionState()
        deviceConnectionState.deviceId = data.deviceId
        deviceConnectionState.state = .online
        return deviceConnectionState
    }
}
