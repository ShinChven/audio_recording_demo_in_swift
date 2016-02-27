//
//  RecordingViewController.swift
//  AudoRecord
//
//  Created by ShinChven Zhang on 16/2/27.
//  Copyright © 2016年 atlassc. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController, AVAudioRecorderDelegate {
    
        var audioRecorder:AVAudioRecorder?
        var audioPlayer:AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 准备回话和初始化Recorder
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
                settings: prepareRecorderSettings())
            audioRecorder?.delegate = self
            audioRecorder!.prepareToRecord()
        } catch {
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * 创建Recorder 配置
     */
    func prepareRecorderSettings() -> [String:AnyObject] {
        
        let recordSettings = [
            AVSampleRateKey : NSNumber(float: Float(44100.0)),
            AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
            AVNumberOfChannelsKey : NSNumber(int: 1),
            AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))
        ]
        
        
        return recordSettings
        
    }
    
    /**
     * 创建文件夹和存储位置
     */
    func directoryURL() -> NSURL? {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent("sound.m4a")
        return soundURL
    }
    
    @IBAction func startRecording(sender: UIButton) {
        if !audioRecorder!.recording {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                audioRecorder!.record()
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
    @IBAction func playAudio(sender: UIButton) {
        
        if (!audioRecorder!.recording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder!.url)
                audioPlayer!.play()
            } catch {
            }
        }
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("recording finished")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
