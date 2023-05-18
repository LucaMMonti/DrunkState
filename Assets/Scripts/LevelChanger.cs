using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelChanger : MonoBehaviour
{
    public GameObject[] lamps;
    public GameObject[] bulbs;
    public GameObject[] dayPeople;
    public GameObject[] nightpeople;
    public GameObject lightDay;
    public GameObject lightNight;
    public Material emisiveMat;
    public Material normalMat;
    public GameObject cameraStopperNight;
    public GameObject levelEnder;
    public GameObject obsDIA;
    public GameObject obsNOCHE;
    public GameObject soundsDia;
    public GameObject soundsNight;

    //public Material nightSkybox;


    public void ChangeToNight()
    {
        foreach (GameObject l in bulbs)
        {
            l.SetActive(true);
        }
        foreach (GameObject l in lamps)
        {
            l.GetComponent<MeshRenderer>().material = emisiveMat;
            l.GetComponentInChildren<Light>().enabled = true;
        }
        foreach(GameObject l in dayPeople)
        {
            l.SetActive(false);
        }
        foreach( GameObject l in nightpeople)
        {
            l.SetActive(true);
        }
        lightDay.SetActive(false);
        lightNight.SetActive(true);
        cameraStopperNight.SetActive(true);
        levelEnder.SetActive(true);
        obsDIA.SetActive(false);
        obsNOCHE.SetActive(true);
        soundsDia.SetActive(false);
        soundsNight.SetActive(true);



        //RenderSettings.skybox = nightSkybox;
    }
}
