using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BarCollider : MonoBehaviour
{
    public Image fadeImage;
    float fadeAmount;
    public bool hasToFadeOut;
    public bool hasToFadeIn;
    public CanvasGroup fadeGroup;
    public LevelChanger levelChanger;
    public GameObject pJ;
    public GameObject cameraNight;

    private void Update()
    {
        if (hasToFadeOut) FadeOut();
        else if (hasToFadeIn) FadeIn(); 
    }

    public void FadeOut()
    {
        if (fadeImage.color.a < 1.5f)
        {
            fadeAmount += 0.5f * Time.deltaTime;
            fadeImage.color = new Color(fadeImage.color.r, fadeImage.color.g, fadeImage.color.b, fadeAmount);
            fadeGroup.alpha = fadeAmount - 0.5f;
        }
        else
        {
            hasToFadeIn = true;
            hasToFadeOut = false;
            levelChanger.ChangeToNight();
            pJ.SetActive(false);
            cameraNight.SetActive(true);
        }
    }

    public void FadeIn()
    {
        if (fadeImage.color.a >= 0)
        {
            fadeAmount -= 0.5f * Time.deltaTime;
            fadeImage.color = new Color(fadeImage.color.r, fadeImage.color.g, fadeImage.color.b, fadeAmount);
            fadeGroup.alpha = fadeAmount + 0.5f;
        }
        else
        {
            fadeGroup.alpha = 0;
            hasToFadeIn = false;
            Destroy(this.gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.GetComponentInParent<Movement>())
        {
            pJ.GetComponentInChildren<Movement>().cannotInteract = true;
            hasToFadeOut = true;
        }
    }
}
