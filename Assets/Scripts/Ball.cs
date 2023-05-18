using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball : MonoBehaviour
{
    public bool isBall;
    public bool isNPC;
    public GameObject ball;
    public float speed;
    public Vector2 randomRange;
    float count;
    float timeToSpawn;

    private void Awake()
    {
        count = Random.Range(1, 5);
    }

    private void Update()
    {
        if(isBall)
        {
            transform.position += -transform.right * Time.deltaTime * speed;
        }
        else if (isNPC)
        {
            transform.position += transform.forward * Time.deltaTime * speed;
        
        }
        else
        {
            if(timeToSpawn >= count)
            {
                GameObject balls = GameObject.Instantiate(ball);
                balls.transform.position = transform.position;
                balls.transform.forward = transform.forward;
                balls.transform.parent = transform;
                timeToSpawn = 0;
                count = Random.Range(randomRange.x, randomRange.y);
            }            
            else
            {
                timeToSpawn += Time.deltaTime; 
            }
        }
    }


}
