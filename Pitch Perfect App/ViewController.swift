//
//  RecordSoundsViewController.swift
//  Pitch Perfect App
//
//  Created by Leonardo Saippa on 07/12/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate{
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    let stopRecordingSegue = "stopRecording"
    
    
    @IBAction func recordAudio(_ sender: Any) {
        print("OnRecord click")
        configureUI(isRecording: true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                          .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func stopRecording(_ sender: Any) {
        print ("stop Recording")
        configureUI(isRecording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func configureUI(isRecording: Bool) {
        stopRecordButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
        recordingLabel.text = !isRecording ? "Tap to Record" : "Recording in Progress"
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            
            
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else {
            print("Falhou")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == stopRecordingSegue {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudio = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudio
        }
    }
    
}

