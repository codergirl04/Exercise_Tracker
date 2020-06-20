//
//  MuscleCellTableViewCell.swift
//  ExerciseTracker
//
//  Created by Maya Itty on 6/11/20.
//  Copyright © 2020 Maya Itty. All rights reserved.
//

import UIKit

class MuscleCellTableViewCell: UITableViewCell {

    @IBOutlet var muscleName: UILabel!
    
    @IBOutlet var muscleSelected: UISwitch!
    
    var musclesExercised: AddExerciseScreen.MusclesExercised? = nil
    
    @IBAction func muscleSwitchToggle(_ sender: UISwitch) {
        musclesExercised?.setMuscleExercised(muscle: self.muscleName.text!, value: self.muscleSelected.isOn)
    }
    
    func setMuscle(name: String) {
        self.muscleName.text = name
    }
    
    func setMuscleGroupsReference(musclesExercised: AddExerciseScreen.MusclesExercised) {
        self.musclesExercised = musclesExercised
    }
}
