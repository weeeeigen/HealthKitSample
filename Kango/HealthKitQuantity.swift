//
//  HealthKitQuantity.swift
//  Kango
//
//  Created by Yusaku Eigen on 2018/05/09.
//  Copyright © 2018年 Yusaku Eigen. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitQuantity
{
    var identifier: HKQuantityTypeIdentifier!
    var options: HKStatisticsOptions!
    var unit: String!
    var value: Double?
    
    init(identifier: HKQuantityTypeIdentifier, options: HKStatisticsOptions, unit: String)
    {
        self.identifier = identifier
        self.options = options
        self.unit = unit
        self.value = nil
    }
}
