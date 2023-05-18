using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Car : MonoBehaviour
{
    public MeshRenderer mR;
    public float forwardSpeed;
    public bool isStatic;

    GameObject ambient;

    public GameObject smoke;

    private void Awake()
    {
        Color color = new Color(Random.Range(0f, 1f), Random.Range(0f, 1f), Random.Range(0f, 1f));
        mR.material.SetColor("_Car", color);
        smoke.SetActive(false);
    }

    private void Update()
    {
        if (!isStatic)
        {
            transform.position += -transform.right * Time.deltaTime * forwardSpeed;
            smoke.SetActive(true); 
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        
    }
}
