using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

// <summary>
// Splash screen.cs
// Bj Thomas
// 8/6/2018
// <summary>

[RequireComponent(typeof(AudioSource))]                               //Add audio source when attaching the script

public class SplashScreen : MonoBehaviour {

    public Texture2D _splashScreenBackground;                        //Creates slot in inspector to assign splash screen background image
    public Texture2D _splashScreenText;                              //Creates slot in inpector to assign splash screen text

    private AudioSource _splashScreenAudio;                          //Defines naming convention for audio source component
    public AudioClip _splashScreenMusic;                             //Creates slot in inspector to assign splash screen music

    private float _splashScreenFadeValue;                            //Defines fade value
    private float _splashScreenFadeSpeed = 0.15f;                    //Defines fade speed

    private SplashScreenController _splashScreenController;         //Defines naming convention for splash screen controller

    private enum SplashScreenController {                           //Defines states for splash screen
        SplashScreenFadeIn = 0,
        SplashScreenFadeOut = 1
    }

    private void Awake(){
        _splashScreenFadeValue = 0;                                 //Fade value equals zero on start up
    }

    // Use this for initialization
    void Start() {
        Cursor.visible = false;                                     //Set the cursor visable state to false
        Cursor.lockState = CursorLockMode.Locked;                   //and lock the cursor

        _splashScreenAudio = GetComponent<AudioSource>();           //Splash screen audio equals the audio source

        _splashScreenAudio.volume = 0;                              //Audio volume equals zero on startup
        _splashScreenAudio.clip = _splashScreenMusic;               //Audio clip equals splash screen music
        _splashScreenAudio.loop = true;                             //Set audio to loop
        _splashScreenAudio.Play();                                  //Play audio

        _splashScreenController =                                   //State equals
           SplashScreen.SplashScreenController.SplashScreenFadeIn;  //fade in on start up

        StartCoroutine("SplashScreenManager");                     //Start SplashScreenManager function
    }

    // Update is called once per frame
    void Update() {

    }

    private IEnumerator SplashScreenManager(){
        while (true) {
            switch(_splashScreenController)
            {
                case SplashScreenController.SplashScreenFadeIn:
                    SplashScreenFadeIn();
                    break;
                case SplashScreenController.SplashScreenFadeOut:
                    SplashScreenFadeOut();
                    break;
            }
            yield return null;
        }
    }

    private void SplashScreenFadeIn(){
        Debug.Log("SplashScreenFadeIn");

        _splashScreenAudio.volume += _splashScreenFadeSpeed * Time.deltaTime; //Increase volume by fade speed
        _splashScreenFadeValue += _splashScreenFadeSpeed * Time.deltaTime;   //Increase volume by fade value

        if (_splashScreenFadeValue > 1)                                       //if fade value is greater than one
            _splashScreenFadeValue = 1;                                       //Then set fade value to one

        if (_splashScreenFadeValue == 1)                                      //if fade value equals one
            _splashScreenController =                                         //set splash screen controller to equal
                SplashScreen.SplashScreenController.SplashScreenFadeOut;      //Splash screen fade out
    }

    private void SplashScreenFadeOut(){
        Debug.Log("SplashScreenFadeOut");

        _splashScreenAudio.volume -= _splashScreenFadeSpeed * Time.deltaTime; //Decrease volume by fade speed
        _splashScreenFadeValue -= _splashScreenFadeSpeed * Time.deltaTime;   //Decrease volume by fade value

        if (_splashScreenFadeValue < 0)                                       //if fade value is less than zero
            _splashScreenFadeValue = 0;                                       //Then set fade value to zero

        if (_splashScreenFadeValue == 0)                                      //if fade value equals zero
            SceneManager.LoadScene("ControllerWarning");                      //load scene ControllerWarning
    }

    private void OnGUI(){
        GUI.DrawTexture(new Rect(0, 0                                        //Draw texture starting at 0/0
            , Screen.width, Screen.height),                                  //by the screen width and height
            _splashScreenBackground);                                       //and draw the background texture

        GUI.color = new Color(1, 1, 1, _splashScreenFadeValue);             //GUI color is equal to (1, 1, 1) plus the fade value

        GUI.DrawTexture(new Rect(0, 0                                       //Draw texture starting at 0/0
            , Screen.width, Screen.height),                                 //by the screen width and height
            _splashScreenBackground);                                       //and draw the background texture
    }
}