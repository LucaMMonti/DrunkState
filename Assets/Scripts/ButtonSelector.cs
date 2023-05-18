using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonSelector : MonoBehaviour
{
    public string[] forwardList;
    public string[] backwarsList;
    public string[] rightList;
    public string[] leftList;
    public List<string> allKeys;
    Movement movementScript;
    public Text forwardTxt;
    public Text backwardsTxt;
    public Text rightTxt;
    public Text leftTxt;
    public Image arrowsTurn;
    public GameObject arrows;
    public GameObject keys;


    public void ChangeButtons()
    {
        movementScript = GetComponent<Movement>();
        movementScript.forward = GetRandomLetter();//forwardList[Random.Range(0,forwardList.Length)];
        movementScript.backwards = GetRandomLetter();//backwarsList[Random.Range(0,backwarsList.Length)];
        movementScript.right = GetRandomLetter();//rightList[Random.Range(0,rightList.Length)];
        movementScript.left = GetRandomLetter();//leftList[Random.Range(0,leftList.Length)];

        forwardTxt.text = movementScript.forward.ToUpper();
        backwardsTxt.text = movementScript.backwards.ToUpper();
        rightTxt.text = movementScript.right.ToUpper();
        leftTxt.text = movementScript.left.ToUpper();
    }

    string GetRandomLetter()
    {
        int letterToGiveNumber = Random.Range(0, allKeys.Count);
        string letterToGive = allKeys[letterToGiveNumber];
        allKeys.Remove(allKeys[letterToGiveNumber]);

        return letterToGive;
    }

    IEnumerator NewKeys()
    {
        arrows.gameObject.SetActive(false);
        keys.gameObject.SetActive(false);
        arrowsTurn.gameObject.SetActive(true);
        yield return new WaitForSeconds(.7f);
        arrows.gameObject.SetActive(true);
        keys.gameObject.SetActive(true);
        arrowsTurn.gameObject.SetActive(false);
        ChangeButtons();
        yield return null;
    }

    public void WaitToChangeButtons()
    {
        StartCoroutine(NewKeys());
    }
}
