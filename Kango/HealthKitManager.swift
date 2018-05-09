//
//  HealthKitManager.swift
//  Kango
//
//  Created by Yusaku Eigen on 2018/05/08.
//  Copyright © 2018年 Yusaku Eigen. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager
{
    // Propery
    typealias authoriziationCompletionHandler = (_ success: Bool) -> Void
    typealias requestReadingCompletionHandler = (_ average: Double?) -> Void
    typealias readCompletionHandler = (_ average: Double?) -> Void
    
    //------------------------------------------------------------//
    // MARK: -- Initialize --
    //------------------------------------------------------------//
    
    class var shared: HealthKitManager {
        struct singleton {
            static let instance: HealthKitManager = HealthKitManager()
        }
        return singleton.instance
    }
    
    //------------------------------------------------------------//
    // MARK: -- Authorize --
    //------------------------------------------------------------//
    
    func requestAuthorization(identifiers: [HKQuantityTypeIdentifier], completion: @escaping authoriziationCompletionHandler)
    {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }
        
        let healthStore = HKHealthStore()
        let types = identifiers.compactMap({ HKObjectType.quantityType(forIdentifier: $0) })
        let typeSets = Set(types)
        
        healthStore.requestAuthorization(toShare: nil, read: typeSets) { (success, error) in
            if !success {
                completion(false)
            }
            completion(true)
        }
    }
    
    //------------------------------------------------------------//
    // MARK: -- Read --
    //------------------------------------------------------------//
    
    func requestReading(quantity: HealthKitQuantity, start: Date, end: Date, completion: @escaping requestReadingCompletionHandler)
    {
        guard let type = HKObjectType.quantityType(forIdentifier: quantity.identifier) else {
            completion(nil)
            return
        }
        let healthStore = HKHealthStore()
        let authorizedStatus = healthStore.authorizationStatus(for: type)
        
        // For authorized
        if authorizedStatus == .sharingAuthorized {
            read(type: type, options: quantity.options, unitString: quantity.unit, start: start, end: end) { (average) in
                completion(average)
            }
        }
        // For not authorized
        else {
            requestAuthorization(identifiers: [quantity.identifier]) { (success) in
                guard success else { return }
                self.read(type: type, options: quantity.options, unitString: quantity.unit, start: start, end: end){ (average) in
                    completion(average)
                }
            }
        }
    }
    
    private func read(type: HKQuantityType, options: HKStatisticsOptions, unitString: String, start: Date, end: Date, completion: @escaping readCompletionHandler)
    {
        let healthStore = HKHealthStore()
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: options) { (query, statistics, error) in
            guard let statistics = statistics, error == nil else {
                completion(nil)
                return
            }
            
            let unit = HKUnit(from: unitString)
            switch options {
            case .discreteAverage:
                guard let ave = statistics.averageQuantity() else {
                    completion(nil)
                    return
                }
                completion(ave.doubleValue(for: unit))
            case .cumulativeSum:
                guard let sum = statistics.sumQuantity() else {
                    completion(nil)
                    return
                }
                completion(sum.doubleValue(for: unit))
            case .discreteMax:
                guard let max = statistics.maximumQuantity() else {
                    completion(nil)
                    return
                }
                completion(max.doubleValue(for: unit))
            default : completion(nil)
            }
        }
        healthStore.execute(query)
    }
}
