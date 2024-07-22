import Combine
import CoreBluetooth
import CoreBluetoothTestable
import MirrorDiffKit


public class SpyPeripheral: PeripheralProtocol {
    public var identifier: UUID { inherited.identifier }
    public var name: String? { inherited.name }
    public var state: CBPeripheralState { inherited.state }
    public var services: [any CoreBluetoothTestable.ServiceProtocol]? { inherited.services }
    public var canSendWriteWithoutResponse: Bool { inherited.canSendWriteWithoutResponse }
    
    
    public var inherited: any PeripheralProtocol
    public private(set) var callArgs = [CallArg]()
    
    
    public init(inheriting inherited: any PeripheralProtocol) {
        self.inherited = inherited
    }
    
    
    public func readRSSI() {
        self.callArgs.append(.readRSSI)
    }
    
    public func discoverServices(_ serviceUUIDs: [CBUUID]?) {
        self.callArgs.append(.discoverServices(serviceUUIDs: serviceUUIDs))
    }
    
    public func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: any ServiceProtocol) {
        self.callArgs.append(.discoverIncludedServices(includedServiceUUIDs: includedServiceUUIDs, service: service))
    }
    
    public func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: any ServiceProtocol) {
        self.callArgs.append(.discoverCharacteristics(characteristicUUIDs: characteristicUUIDs, service: service))
    }
    
    public func readValue(for characteristic: any CharacteristicProtocol) {
        self.callArgs.append(.readValueCharacteristic(characteristic))
    }
    
    public func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        self.callArgs.append(.maximumWriteValueLength(type: type))
        return inherited.maximumWriteValueLength(for: type)
    }
    
    public func writeValue(_ data: Data, for characteristic: any CharacteristicProtocol, type: CBCharacteristicWriteType) {
        self.callArgs.append(.writeValueCharacteristic(data: data, characteristic: characteristic, type: type))
    }
    
    public func setNotifyValue(_ enabled: Bool, for characteristic: any CharacteristicProtocol) {
        self.callArgs.append(.setNotifyValue(enabled: enabled, characteristic: characteristic))
    }
    
    public func discoverDescriptors(for characteristic: any CharacteristicProtocol) {
        self.callArgs.append(.discoverDescriptors(characteristic: characteristic))
    }
    
    public func readValue(for descriptor: any DescriptorProtocol) {
        self.callArgs.append(.readValueDescriptor(descriptor))
    }
    
    public func writeValue(_ data: Data, for descriptor: any DescriptorProtocol) {
        self.callArgs.append(.writeValueDescriptor(data: data, descriptor: descriptor))
    }
    
    public func openL2CAPChannel(_ psm: CBL2CAPPSM) {
        self.callArgs.append(.openL2CAPChannel(psm: psm))
    }
    
    public var didUpdateName: AnyPublisher<String?, Never> { inherited.didUpdateName }
    
    public var didModifyServices: AnyPublisher<[any CoreBluetoothTestable.ServiceProtocol], Never> { inherited.didModifyServices }
    
    public var didUpdateRSSI: AnyPublisher<(rssi: NSNumber?, error: (any Error)?), Never> { inherited.didUpdateRSSI }
    
    public var didReadRSSI: AnyPublisher<(rssi: NSNumber?, error: (any Error)?), Never> { inherited.didReadRSSI }
    
    public var didDiscoverServices: AnyPublisher<(services: [any CoreBluetoothTestable.ServiceProtocol]?, error: (any Error)?), Never> { inherited.didDiscoverServices }
    
    public var didDiscoverIncludedServicesForService: AnyPublisher<(services: [any CoreBluetoothTestable.ServiceProtocol]?, service: any CoreBluetoothTestable.ServiceProtocol, error: (any Error)?), Never> { inherited.didDiscoverIncludedServicesForService }
    
    public var didDiscoverCharacteristicsForService: AnyPublisher<(characteristics: [any CoreBluetoothTestable.CharacteristicProtocol]?, service: any CoreBluetoothTestable.ServiceProtocol, error: (any Error)?), Never> { inherited.didDiscoverCharacteristicsForService }
    
    public var didUpdateValueForCharacteristic: AnyPublisher<(characteristic: any CoreBluetoothTestable.CharacteristicProtocol, error: (any Error)?), Never> { inherited.didUpdateValueForCharacteristic }
    
    public var didWriteValueForCharacteristic: AnyPublisher<(characteristic: any CoreBluetoothTestable.CharacteristicProtocol, error: (any Error)?), Never> { inherited.didWriteValueForCharacteristic }
    
    public var didUpdateNotificationStateForCharacteristic: AnyPublisher<(characteristic: any CoreBluetoothTestable.CharacteristicProtocol, error: (any Error)?), Never> {
        inherited.didUpdateNotificationStateForCharacteristic
    }
    
    public var didDiscoverDescriptorsForCharacteristic: AnyPublisher<(descriptors: [any CoreBluetoothTestable.DescriptorProtocol]?, characteristic: any CoreBluetoothTestable.CharacteristicProtocol, error: (any Error)?), Never> {
        inherited.didDiscoverDescriptorsForCharacteristic
    }
    
    public var didUpdateValueForDescriptor: AnyPublisher<(descriptor: any CoreBluetoothTestable.DescriptorProtocol, error: (any Error)?), Never> {
        inherited.didUpdateValueForDescriptor
    }
    
    public var isReadyToSendWriteWithoutResponse: AnyPublisher<Bool, Never> {
        inherited.isReadyToSendWriteWithoutResponse
    }
    
    public var didOpenL2CAPChannel: AnyPublisher<(channel: CBL2CAPChannel?, error: (any Error)?), Never> {
        inherited.didOpenL2CAPChannel
    }
    
    public var _wrapped: CBPeripheral? { inherited._wrapped }
    
    
    public enum CallArg {
        case readRSSI
        case discoverServices(serviceUUIDs: [CBUUID]?)
        case discoverIncludedServices(includedServiceUUIDs: [CBUUID]?, service: any ServiceProtocol)
        case discoverCharacteristics(characteristicUUIDs: [CBUUID]?, service: any ServiceProtocol)
        case readValueCharacteristic(any CharacteristicProtocol)
        case maximumWriteValueLength(type: CBCharacteristicWriteType)
        case writeValueCharacteristic(data: Data, characteristic: any CharacteristicProtocol, type: CBCharacteristicWriteType)
        case setNotifyValue(enabled: Bool, characteristic: any CharacteristicProtocol)
        case discoverDescriptors(characteristic: any CharacteristicProtocol)
        case readValueDescriptor(any DescriptorProtocol)
        case writeValueDescriptor(data: Data, descriptor: any DescriptorProtocol)
        case openL2CAPChannel(psm: CBL2CAPPSM)
    }
}


extension SpyPeripheral.CallArg: Equatable {
    public static func == (lhs: SpyPeripheral.CallArg, rhs: SpyPeripheral.CallArg) -> Bool {
        switch (lhs, rhs) {
        case (.readRSSI, .readRSSI):
            return true
        case (.discoverServices(serviceUUIDs: let l), .discoverServices(serviceUUIDs: let r)):
            return l == r
        case (.discoverIncludedServices(includedServiceUUIDs: let l, service: let ls),
              .discoverIncludedServices(includedServiceUUIDs: let r, service: let rs)):
            return l == r && ls == rs
        case (.discoverCharacteristics(characteristicUUIDs: let l, service: let ls),
              .discoverCharacteristics(characteristicUUIDs: let r, service: let rs)):
            return l == r && ls == rs
        case (.readValueCharacteristic(let l), .readValueCharacteristic(let r)):
            return l == r
        case (.maximumWriteValueLength(type: let l), .maximumWriteValueLength(type: let r)):
            return l == r
        case (.writeValueCharacteristic(data: let ld, characteristic: let lc, type: let lt),
              .writeValueCharacteristic(data: let rd, characteristic: let rc, type: let rt)):
            return ld == rd && lc == rc && lt == rt
        case (.setNotifyValue(enabled: let le, characteristic: let lc),
              .setNotifyValue(enabled: let re, characteristic: let rc)):
            return le == re && lc == rc
        case (.discoverDescriptors(characteristic: let l), .discoverDescriptors(characteristic: let r)):
            return l == r
        case (.readValueDescriptor(let l), .readValueDescriptor(let r)):
            return l == r
        case (.writeValueDescriptor(data: let l1, descriptor: let l2),
              .writeValueDescriptor(data: let r1, descriptor: let r2)):
            return l1 == r1 && l2 == r2
        case (.openL2CAPChannel(psm: let l), .openL2CAPChannel(psm: let r)):
            return l == r
        default:
            return false
        }
    }
}
