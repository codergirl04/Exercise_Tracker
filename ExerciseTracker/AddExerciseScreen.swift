//
//  AddExerciseScreen.swift
//  ExerciseTracker
//
//  Created by Maya Itty on 6/11/20.
//  Copyright © 2020 Maya Itty. All rights reserved.
//

import UIKit

class AddExerciseScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {

    class MusclesExercised: CustomStringConvertible, Codable {
        // Couldn't pass and save the reference to a dictionary in MuscleCellTableViewCell because dictionaries are passed as values so I put it inside a class so I can pass the reference to the object
        var musclesExercised: [String: Bool] = [:]
        var description: String {
            return musclesExercised.description
        }
        init(muscles: [String]) {
            for muscle in muscles {
                self.musclesExercised[muscle] = false
            }
        }
        func setMuscleExercised(muscle: String, value: Bool) {
            self.musclesExercised[muscle] = value
        }
    }
    
    var muscles: [String] = ["Neck", "Shoulders", "Upper back", "Lower back", "Biceps", "Triceps", "Forearms", "Abs", "Glutes", "Hamstrings", "Quads", "Calves", "Deltoids", "Trapezius"]
    
    var musclesExercised: MusclesExercised
    required init?(coder: NSCoder) {
        self.musclesExercised=MusclesExercised(muscles: self.muscles)
        super.init(coder: coder)
    }

    @IBOutlet var tableView: UITableView!
    
    
    @IBAction func saveWorkout(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("exercises").appendingPathExtension("plist")
        var exerciseLog : [ExerciseLog]
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedData = try? Data(contentsOf: archiveURL),
            let log = try? propertyListDecoder.decode(Array<ExerciseLog>.self, from: retrievedData){
            exerciseLog = log
        } else {
            exerciseLog = []
        }
        let newLog = ExerciseLog(date: Date(), musclesExercised: self.musclesExercised.musclesExercised)
        exerciseLog.insert(newLog, at: 0)
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedLogs = try? propertyListEncoder.encode(exerciseLog)

        try? encodedLogs?.write(to: archiveURL, options: .noFileProtection)
        //Test reading and printing
        if let retrievedData = try? Data(contentsOf: archiveURL),
            let log = try? propertyListDecoder.decode(Array<ExerciseLog>.self, from: retrievedData){
            exerciseLog = log
        } else {
            exerciseLog = []
        }
        print(exerciseLog)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return muscles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let muscle = muscles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuscleCell") as! MuscleCellTableViewCell
        
        cell.setMuscle(name: muscle)
        
        cell.setMuscleGroupsReference(musclesExercised: musclesExercised)
        
        return cell
        
    }
}

