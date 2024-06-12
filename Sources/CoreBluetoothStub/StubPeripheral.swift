import Foundation
import Combine
import CoreBluetooth
import CoreBluetoothTestable


public class StubPeripheral: PeripheralProtocol {
    // MARK: - Properties from CBPeer
    public var identifier: UUID
    
    // MARK: - Properties from CBPeripheral
    public var name: String?
    public var state: CBPeripheralState
    public var services: [any ServiceProtocol]?
    public var canSendWriteWithoutResponse: Bool
    
    // MARK: - Publishers from CBPeripheralDelegate
    public let didUpdateNameSubject: PassthroughSubject<String?, Never>
    public let didUpdateName: AnyPublisher<String?, Never>
    
    public let didModifyServicesSubject: PassthroughSubject<[any ServiceProtocol], Never>
    public let didModifyServices: AnyPublisher<[any ServiceProtocol], Never>
    
    public let didUpdateRSSISubject: PassthroughSubject<(rssi: NSNumber?, error: (any Error)?), Never>
    public let didUpdateRSSI: AnyPublisher<(rssi: NSNumber?, error: (any Error)?), Never>
    
    public let didReadRSSISubject: PassthroughSubject<(rssi: NSNumber?, error: (any Error)?), Never>
    public let didReadRSSI: AnyPublisher<(rssi: NSNumber?, error: (any Error)?), Never>
    
    public let didDiscoverServicesSubject: PassthroughSubject<(services: [any ServiceProtocol]?, error: (any Error)?), Never>
    public let didDiscoverServices: AnyPublisher<(services: [any ServiceProtocol]?, error: (any Error)?), Never>
    
    public let didDiscoverIncludedServicesForServiceSubject: PassthroughSubject<(services: [any ServiceProtocol]?, service: any ServiceProtocol, error: (any Error)?), Never>
    public let didDiscoverIncludedServicesForService: AnyPublisher<(services: [any ServiceProtocol]?, service: any ServiceProtocol, error: (any Error)?), Never>
    
    public let didDiscoverCharacteristicsForServiceSubject: PassthroughSubject<(characteristics: [any CharacteristicProtocol]?, service: any ServiceProtocol, error: (any Error)?), Never>
    public let didDiscoverCharacteristicsForService: AnyPublisher<(characteristics: [any CharacteristicProtocol]?, service: any ServiceProtocol, error: (any Error)?), Never>
    
    public let didUpdateValueForCharacteristicSubject: PassthroughSubject<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>
    public let didUpdateValueForCharacteristic: AnyPublisher<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>
    
    public let didWriteValueForCharacteristicSubject: PassthroughSubject<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>
    public let didWriteValueForCharacteristic: AnyPublisher<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>
    
    public let didUpdateNotificationStateForCharacteristicSubject: PassthroughSubject<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>
    public let didUpdateNotificationStateForCharacteristic: AnyPublisher<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>
    
    public let didDiscoverDescriptorsForCharacteristicSubject: PassthroughSubject<(descriptors: [any DescriptorProtocol]?, characteristic: any CharacteristicProtocol, error: (any Error)?), Never>
    public let didDiscoverDescriptorsForCharacteristic: AnyPublisher<(descriptors: [any DescriptorProtocol]?, characteristic: any CharacteristicProtocol, error: (any Error)?), Never>
    
    public let didUpdateValueForDescriptorSubject: PassthroughSubject<(descriptor: any DescriptorProtocol, error: (any Error)?), Never>
    public let didUpdateValueForDescriptor: AnyPublisher<(descriptor: any DescriptorProtocol, error: (any Error)?), Never>
    
    public let isReadyToSendWriteWithoutResponseSubject: PassthroughSubject<Bool, Never>
    public let isReadyToSendWriteWithoutResponse: AnyPublisher<Bool, Never>
    
    public let didOpenL2CAPChannelSubject: PassthroughSubject<(channel: CBL2CAPPSM, error: (any Error)?), Never>
    public let didOpenL2CAPChannel: AnyPublisher<(channel: CBL2CAPPSM, error: (any Error)?), Never>
    
    
    // MARK: - Properties for Internal Use
    public var _wrapped: CBPeripheral? = nil
    
    public var maximumWriteValueLengthResult: Int


    // MARK: - Initializers
    private init(
        identifier: UUID,
        name: String?,
        state: CBPeripheralState,
        services: [any ServiceProtocol]?,
        canSendWriteWithoutResponse: Bool,
        maximumWriteValueLengthResult: Int
    ) {
        self.identifier = identifier
        self.name = name
        self.state = state
        self.services = services
        self.canSendWriteWithoutResponse = canSendWriteWithoutResponse
        
        self.maximumWriteValueLengthResult = maximumWriteValueLengthResult
        
        let didUpdateNameSubject = PassthroughSubject<String?, Never>()
        self.didUpdateNameSubject = didUpdateNameSubject
        self.didUpdateName = didUpdateNameSubject.eraseToAnyPublisher()
        
        let didModifyServicesSubject = PassthroughSubject<[any ServiceProtocol], Never>()
        self.didModifyServicesSubject = didModifyServicesSubject
        self.didModifyServices = didModifyServicesSubject.eraseToAnyPublisher()
        
        let didUpdateRSSISubject = PassthroughSubject<(rssi: NSNumber?, error: (any Error)?), Never>()
        self.didUpdateRSSISubject = didUpdateRSSISubject
        self.didUpdateRSSI = didUpdateRSSISubject.eraseToAnyPublisher()
        
        let didReadRSSISubject = PassthroughSubject<(rssi: NSNumber?, error: (any Error)?), Never>()
        self.didReadRSSISubject = didReadRSSISubject
        self.didReadRSSI = didReadRSSISubject.eraseToAnyPublisher()
        
        let didDiscoverServicesSubject = PassthroughSubject<(services: [any ServiceProtocol]?, error: (any Error)?), Never>()
        self.didDiscoverServicesSubject = didDiscoverServicesSubject
        self.didDiscoverServices = didDiscoverServicesSubject.eraseToAnyPublisher()
        
        let didDiscoverIncludedServicesForServiceSubject = PassthroughSubject<(services: [any ServiceProtocol]?, service: any ServiceProtocol, error: (any Error)?), Never>()
        self.didDiscoverIncludedServicesForServiceSubject = didDiscoverIncludedServicesForServiceSubject
        self.didDiscoverIncludedServicesForService = didDiscoverIncludedServicesForServiceSubject.eraseToAnyPublisher()
        
        let didDiscoverCharacteristicsForServiceSubject = PassthroughSubject<(characteristics: [any CharacteristicProtocol]?, service: any ServiceProtocol, error: (any Error)?), Never>()
        self.didDiscoverCharacteristicsForServiceSubject = didDiscoverCharacteristicsForServiceSubject
        self.didDiscoverCharacteristicsForService = didDiscoverCharacteristicsForServiceSubject.eraseToAnyPublisher()
        
        let didUpdateValueForCharacteristicSubject = PassthroughSubject<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>()
        self.didUpdateValueForCharacteristicSubject = didUpdateValueForCharacteristicSubject
        self.didUpdateValueForCharacteristic = didUpdateValueForCharacteristicSubject.eraseToAnyPublisher()
        
        let didWriteValueForCharacteristicSubject = PassthroughSubject<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>()
        self.didWriteValueForCharacteristicSubject = didWriteValueForCharacteristicSubject
        self.didWriteValueForCharacteristic = didWriteValueForCharacteristicSubject.eraseToAnyPublisher()
        
        let didUpdateNotificationStateForCharacteristicSubject = PassthroughSubject<(characteristic: any CharacteristicProtocol, error: (any Error)?), Never>()
        self.didUpdateNotificationStateForCharacteristicSubject = didUpdateNotificationStateForCharacteristicSubject
        self.didUpdateNotificationStateForCharacteristic = didUpdateNotificationStateForCharacteristicSubject.eraseToAnyPublisher()
        
        let didDiscoverDescriptorsForCharacteristicSubject = PassthroughSubject<(descriptors: [any DescriptorProtocol]?, characteristic: any CharacteristicProtocol, error: (any Error)?), Never>()
        self.didDiscoverDescriptorsForCharacteristicSubject = didDiscoverDescriptorsForCharacteristicSubject
        self.didDiscoverDescriptorsForCharacteristic = didDiscoverDescriptorsForCharacteristicSubject.eraseToAnyPublisher()
        
        let didUpdateValueForDescriptorSubject = PassthroughSubject<(descriptor: any DescriptorProtocol, error: (any Error)?), Never>()
        self.didUpdateValueForDescriptorSubject = didUpdateValueForDescriptorSubject
        self.didUpdateValueForDescriptor = didUpdateValueForDescriptorSubject.eraseToAnyPublisher()
        
        let isReadyToSendWriteWithoutResponseSubject = PassthroughSubject<Bool, Never>()
        self.isReadyToSendWriteWithoutResponseSubject = isReadyToSendWriteWithoutResponseSubject
        self.isReadyToSendWriteWithoutResponse = isReadyToSendWriteWithoutResponseSubject.eraseToAnyPublisher()
        
        let didOpenL2CAPChannelSubject = PassthroughSubject<(channel: CBL2CAPPSM, error: (any Error)?), Never>()
        self.didOpenL2CAPChannelSubject = didOpenL2CAPChannelSubject
        self.didOpenL2CAPChannel = didOpenL2CAPChannelSubject.eraseToAnyPublisher()
    }
    
    
    // MARK: - Methods from CBPeripheral
    public func readRSSI() {
    }
    
    
    public func discoverServices(_ serviceUUIDs: [CBUUID]?) {
    }
    
    
    public func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: any ServiceProtocol) {
    }
    
    
    public func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: any ServiceProtocol) {
    }
    
    
    public func readValue(for characteristic: any CharacteristicProtocol) {
    }
    
    
    public func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        return self.maximumWriteValueLengthResult
    }
    
    
    public func writeValue(_ data: Data, for characteristic: any CharacteristicProtocol, type: CBCharacteristicWriteType) {
    }
    
    
    public func setNotifyValue(_ enabled: Bool, for characteristic: any CharacteristicProtocol) {
    }
    
    
    public func discoverDescriptors(for characteristic: any CharacteristicProtocol) {
    }
    
    
    public func readValue(for descriptor: any DescriptorProtocol) {
    }
    
    
    public func writeValue(_ data: Data, for descriptor: any DescriptorProtocol) {
    }
    
    
    public func openL2CAPChannel(_ psm: CBL2CAPPSM) {
    }
}
