//
//  HealthData.swift
//  Kango
//
//  Created by Yusaku Eigen on 2018/05/09.
//  Copyright © 2018年 Yusaku Eigen. All rights reserved.
//

import Foundation

class HealthKitData
{
    // Property
    var activeEnergy: HealthKitQuantity!
    var basalEnergy: HealthKitQuantity!
    var stepCount: HealthKitQuantity!
    var distanceWalkingRunnig: HealthKitQuantity!
    var flightsClimbed: HealthKitQuantity!
    var heartRate: HealthKitQuantity!
    var walkingHeartRateAverage: HealthKitQuantity!
    var restingHeartRate: HealthKitQuantity!
    
    // init
    init()
    {
        self.activeEnergy = HealthKitQuantity(identifier: .activeEnergyBurned, options: .cumulativeSum, unit: "kcal")
        self.basalEnergy = HealthKitQuantity(identifier: .basalEnergyBurned, options: .cumulativeSum, unit: "kcal")
        self.stepCount = HealthKitQuantity(identifier: .stepCount, options: .cumulativeSum, unit: "count")
        self.distanceWalkingRunnig = HealthKitQuantity(identifier: .distanceWalkingRunning, options: .cumulativeSum, unit: "km")
        self.flightsClimbed = HealthKitQuantity(identifier: .flightsClimbed, options: .cumulativeSum, unit: "count")
        self.heartRate = HealthKitQuantity(identifier: .heartRate, options: .discreteAverage, unit: "count/min")
        self.walkingHeartRateAverage = HealthKitQuantity(identifier: .walkingHeartRateAverage, options: .discreteAverage, unit: "count/min")
        self.restingHeartRate = HealthKitQuantity(identifier: .restingHeartRate, options: .discreteAverage, unit: "count/min")
    }
}
