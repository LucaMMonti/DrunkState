using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerSpawner : MonoBehaviour
{
    public GameObject player;
    public Transform spawnPoint;

    private void Awake()
    {
        spawnPoint.position = player.transform.position;
    }

    public void RespawnPlayer()
    {
        player.transform.position = spawnPoint.transform.position;
    }
}
