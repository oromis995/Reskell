using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameOverScreen : MonoBehaviour
{

    public void RestartButton()
    {
        SceneManager.LoadScene("Intro2");
    }


    public void ExitButton()
    {
        SceneManager.LoadScene("MainMenu");
    }

}
