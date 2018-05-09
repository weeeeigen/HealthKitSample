//
//  ViewController.swift
//  Kango
//
//  Created by Yusaku Eigen on 2018/05/08.
//  Copyright © 2018年 Yusaku Eigen. All rights reserved.
//

import UIKit

enum Row: Int {
    case activeEnergy
    case basalEnergy
    case stepCount
    case distanceWalkingRunnig
    case flightsClimbed
    case heartRate
    case walkingHeartRateAverage
    case restingHeartRate
    case numOfRows
    
    func description() -> String {
        switch self {
        case .activeEnergy: return "Active Energy"
        case .basalEnergy: return "Resting Energy"
        case .stepCount: return "Steps"
        case .distanceWalkingRunnig: return "Walking + Running"
        case .flightsClimbed: return "Flights Climbed"
        case .heartRate: return "Heart Rate"
        case .walkingHeartRateAverage: return "Walking Heart Rate Average"
        case .restingHeartRate: return "Resting Heart Rate"
        case .numOfRows: return ""
        }
    }
}

class ViewController: UIViewController
{
    // Property
    var healthKitData = HealthKitData()
    
    // Outlet
    @IBOutlet weak var healthTableView: UITableView!
    
    override func viewDidLoad()
    {
        // Invoke super
        super.viewDidLoad()
        
        // Authorize HealthKit
        HealthKitManager.shared.requestAuthorization(identifiers: [.activeEnergyBurned, .basalEnergyBurned, .stepCount, .distanceWalkingRunning, .flightsClimbed, .heartRate, .walkingHeartRateAverage, .restingHeartRate]) { (success) in
            // For error
            guard success else { return }
            
            // Set start and end
            let calender = NSCalendar.current
            let now = Date()
            let start = calender.startOfDay(for: now)
            let end = now
            
            // Read active energy
            HealthKitManager.shared.requestReading(quantity: self.healthKitData.activeEnergy, start: start, end: end) { (activeEnergy) in
                self.healthKitData.activeEnergy.value = activeEnergy
                DispatchQueue.main.async {
                    self.healthTableView.reloadRows(at: [IndexPath(row: Row.activeEnergy.rawValue, section: 0) ], with: .automatic)
                }
            }
            
            // Read active energy
            HealthKitManager.shared.requestReading(quantity: self.healthKitData.basalEnergy, start: start, end: end) { (basalEnergy) in
                self.healthKitData.basalEnergy.value = basalEnergy
                DispatchQueue.main.async {
                    self.healthTableView.reloadRows(at: [IndexPath(row: Row.basalEnergy.rawValue, section: 0) ], with: .automatic)
                }
            }
            
            // Read active energy
            HealthKitManager.shared.requestReading(quantity: self.healthKitData.stepCount, start: start, end: end) { (stepCount) in
                self.healthKitData.stepCount.value = stepCount
                DispatchQueue.main.async {
                    self.healthTableView.reloadRows(at: [IndexPath(row: Row.stepCount.rawValue, section: 0) ], with: .automatic)
                }
            }

            // Read active energy
            HealthKitManager.shared.requestReading(quantity: self.healthKitData.distanceWalkingRunnig, start: start, end: end) { (distanceWalkingRunnig) in
                self.healthKitData.distanceWalkingRunnig.value = distanceWalkingRunnig
                DispatchQueue.main.async {
                    self.healthTableView.reloadRows(at: [IndexPath(row: Row.distanceWalkingRunnig.rawValue, section: 0) ], with: .automatic)
                }
            }

            // Read active energy
            HealthKitManager.shared.requestReading(quantity: self.healthKitData.flightsClimbed, start: start, end: end) { (flightsClimbed) in
                self.healthKitData.flightsClimbed.value = flightsClimbed
                DispatchQueue.main.async {
                    self.healthTableView.reloadRows(at: [IndexPath(row: Row.flightsClimbed.rawValue, section: 0) ], with: .automatic)
                }
            }
            
            // Read heart rate
            HealthKitManager.shared.requestReading(quantity: self.healthKitData.heartRate, start: start, end: end) { (heartRate) in
                self.healthKitData.heartRate.value = heartRate
                DispatchQueue.main.async {
                    self.healthTableView.reloadRows(at: [IndexPath(row: Row.heartRate.rawValue, section: 0) ], with: .automatic)
                }
            }

            // Read active energy
            HealthKitManager.shared.requestReading(quantity: self.healthKitData.walkingHeartRateAverage, start: start, end: end) { (walkingHeartRateAverage) in
                self.healthKitData.walkingHeartRateAverage.value = walkingHeartRateAverage
                DispatchQueue.main.async {
                    self.healthTableView.reloadRows(at: [IndexPath(row: Row.walkingHeartRateAverage.rawValue, section: 0) ], with: .automatic)
                }
            }

            // Read active energy
            HealthKitManager.shared.requestReading(quantity: self.healthKitData.restingHeartRate, start: start, end: end) { (restingHeartRate) in
                self.healthKitData.restingHeartRate.value = restingHeartRate
                DispatchQueue.main.async {
                    self.healthTableView.reloadRows(at: [IndexPath(row: Row.restingHeartRate.rawValue, section: 0) ], with: .automatic)
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Get health data properis
        return Row.numOfRows.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Dequeue cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") else { return UITableViewCell() }
        
        // Get health data
        guard let healthData = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        
        // Set cell description
        cell.textLabel?.text = healthData.description()
        cell.detailTextLabel?.text = ""
        
        switch healthData {
        case .activeEnergy:
            // Set active energy
            guard let activeEnergy = healthKitData.activeEnergy.value else { return cell }
            cell.detailTextLabel?.text = String(activeEnergy) + " kcal"
        case .basalEnergy:
            guard let basalEnergy = healthKitData.basalEnergy.value else { return cell }
            cell.detailTextLabel?.text = String(basalEnergy) + " kcal"
        case .distanceWalkingRunnig:
            guard let distanceWalkingRunnig = healthKitData.distanceWalkingRunnig.value else { return cell }
            cell.detailTextLabel?.text = String(distanceWalkingRunnig) + " km"
        case .flightsClimbed:
            guard let flightsClimbed = healthKitData.flightsClimbed.value else { return cell }
            cell.detailTextLabel?.text = String(flightsClimbed) + " floors"
        case .heartRate:
            guard let heartRate = healthKitData.heartRate.value else { return cell }
            cell.detailTextLabel?.text = String(heartRate) + " bpm"
        case .restingHeartRate:
            guard let restingHeartRate = healthKitData.restingHeartRate.value else { return cell }
            cell.detailTextLabel?.text = String(restingHeartRate) + " bpm"
        case .stepCount:
            guard let stepCount = healthKitData.stepCount.value else { return cell }
            cell.detailTextLabel?.text = String(stepCount) + " steps"
        case .walkingHeartRateAverage:
            guard let walkingHeartRateAverage = healthKitData.walkingHeartRateAverage.value else { return cell }
            cell.detailTextLabel?.text = String(walkingHeartRateAverage) + " bpm"
        case .numOfRows: break
        }
        
        return cell
    }
}

