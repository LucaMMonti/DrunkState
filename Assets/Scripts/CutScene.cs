using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CutScene : MonoBehaviour
{
    public GameObject pJ;
    public GameObject pJDrunk;
    public bool cam1;
    public GameObject dummy1;
    public GameObject dummy2;

    public void Awake()
    {
        if (cam1)
        {
            dummy1.SetActive(true);

        }
        else
        {
            dummy2.SetActive(true);

        }
    }

    public void startGame()
    {
        dummy1.SetActive(false);
        pJ.SetActive(true);
        Destroy(this.gameObject);
    }

    public void changeToNight()
    {
        dummy2.SetActive(false);
        pJDrunk.SetActive(true);
        pJDrunk.GetComponentInChildren<ButtonSelector>().WaitToChangeButtons();
        Destroy(this.gameObject);
    }
}
