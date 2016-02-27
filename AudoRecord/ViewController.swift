//
//  ViewController.swift
//  AudoRecord
//
//  Created by ShinChven Zhang on 16/2/27.
//  Copyright © 2016年 atlassc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var audioRecorder:AVAudioRecorder?

    
    @IBAction func record(sender: UIButton) {
        if !audioRecorder!.recording {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                audioRecorder!.record()
            } catch {
            }
        }
        
        
    }
    
    

    var audioPlayer:AVAudioPlayer?
    
    @IBAction func play(sender: UIButton) {
        
        if (!audioRecorder!.recording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder!.url)
                audioPlayer!.play()
            } catch {
            }
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorder!.stop()
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(false)
        } catch {
            
        }
    
    }
    
    func prepareRecorderSettings() -> [String:AnyObject] {
        
        let recordSettings = [
            AVSampleRateKey : NSNumber(float: Float(44100.0)),
            AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
            AVNumberOfChannelsKey : NSNumber(int: 1),
            AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))
        ]
        
        
        return recordSettings
        
    }
    
    func directoryURL() -> NSURL? {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent("sound.m4a")
        return soundURL
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
                settings: prepareRecorderSettings())
            audioRecorder!.prepareToRecord()
        } catch {
            
        }
        
        
    }
    
    var recorder:AVAudioRecorder?
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}

