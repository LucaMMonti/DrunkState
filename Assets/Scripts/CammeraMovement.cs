using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CammeraMovement : MonoBehaviour
{
    public float speed;
    float initialSpeed;
    public float maxDist;
    public GameObject player;
    bool canMove = true;

    private void Awake()
    {
        initialSpeed = speed;
    }

    private void Update()
    {
        if(GetPlayerDistance() >= maxDist)
        {
            speed = player.GetComponent<Movement>().speed;
        }
        else { speed = initialSpeed; }

        Movement();

        //Debug.Log(GetPlayerDistance());
    }
    float GetPlayerDistance()
    {
        Vector3 playerPos = new Vector3(player.transform.position.x, 0, 0);
        Vector3 cameraPos = new Vector3(transform.position.x, 0, 0);

        return (playerPos - cameraPos).magnitude;
    }

    void Movement()
    {
        if (canMove) { transform.position += transform.forward * speed * Time.deltaTime; }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.layer == 9)
        {
            canMove = false;
            Destroy(other.gameObject);
        }
    }
}
