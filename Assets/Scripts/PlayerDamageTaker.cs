using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerDamageTaker : MonoBehaviour
{
    public float health;
    public float inmmunityTime;
    float inmmunityTimer;
    public PlayerSpawner pSscript;
    bool inmmunityOn;
    public SkinnedMeshRenderer[] mrenderers;


    private void Update()
    {
        if(inmmunityOn)
        {
            InmmunityTimerLogic();
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.layer == 7 && !inmmunityOn)
        {
            TakeDamage();
        }
    }

    void TakeDamage()
    {
        health--;
        if(health > 0)
        {
            pSscript.RespawnPlayer();
            StartInmmunity();
            if (GetComponent<ButtonSelector>() != null)
            {
                GetComponent<ButtonSelector>().WaitToChangeButtons();
            }
        }
        else
        {
            SceneManager.LoadScene(3);
        }
    }

    void StartInmmunity()
    {
        inmmunityOn = true;
        Debug.Log("inmmunityOn");

    }
    void InmmunityTimerLogic()
    {
        if (inmmunityTimer < inmmunityTime)
        {
            inmmunityTimer += Time.deltaTime;
            DoFlicker();
        }
        else
        {
            inmmunityTimer = 0;
            inmmunityOn = false;
            Debug.Log("inmmunityOff");
            ResetFlicker();
        }
    }

    void DoFlicker()
    {
        int state = Random.Range(0, 2);

        foreach (SkinnedMeshRenderer mr in mrenderers)
        {
            if (state == 1) { mr.enabled = false; }
            else { mr.enabled = true; }
        }
    }

    void ResetFlicker()
    {
        foreach (SkinnedMeshRenderer mr in mrenderers)
        {
            mr.enabled = true;
        }
    }

}
