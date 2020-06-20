//
//  ExerciseLog.swift
//  ExerciseTracker
//
//  Created by Maya Itty on 6/13/20.
//  Copyright © 2020 Maya Itty. All rights reserved.
//

import Foundation
class ExerciseLog: Codable, CustomStringConvertible {
    var date: Date
    var musclesExercised: [String: Bool]
    init(date: Date, musclesExercised: [String: Bool]) {
        self.date = date
        self.musclesExercised = musclesExercised
    }
    var description: String {
        return "Date: \(date) \nMuscles: \n \(musclesExercised.description)"
    }
}
