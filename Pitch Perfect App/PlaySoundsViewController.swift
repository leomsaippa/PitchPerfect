//
//  PlaySoundsViewController.swift
//  Pitch Perfect App
//
//  Created by Leonardo Saippa on 09/12/20.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    

    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
          case .slow:
              playSound(rate: 0.5)
          case .fast:
              playSound(rate: 1.5)
          case .chipmunk:
              playSound(pitch: 1000)
          case .vader:
              playSound(pitch: -1000)
          case .echo:
              playSound(echo: true)
          case .reverb:
              playSound(reverb: true)
          }

          configureUI(.playing)
        print("Play Sound Button Pressed")
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
        configureUI(.notPlaying)
        print("Stop Audio Button Pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        setupButtons()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        stopAudio()
    }
    
    func setupButtons(){

        snailButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        chipmunkButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        rabbitButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        vaderButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        stopButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }

}


