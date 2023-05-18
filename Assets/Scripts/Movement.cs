using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{
    public float speed;
    public float jumpForce;
    public string forward;
    public string backwards;
    public string right;
    public string left;
    Rigidbody rb;
    public bool grounded;
    Animator animator;
    bool canWalk = true;
    bool canMove = true;
    public bool cannotInteract;

    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
    }
    private void Update()
    {
        if (!cannotInteract)
        {
            Inputs();
        }
    }

    void Inputs()
    {
        if (Input.GetKey(forward) && canMove) { Move(transform.forward); if (canWalk) { animator.Play("NormalWalk"); } }
        else if (Input.GetKey(backwards) && canMove) { Move(-transform.forward); if (canWalk) { animator.Play("NormalWalkBackwards"); } }
        else if (Input.GetKey(right) && canMove) { Move(transform.right); if (canWalk) { animator.Play("NormalSideWalkRight"); } }
        else if (Input.GetKey(left) && canMove) { Move(-transform.right); if (canWalk) { animator.Play("NormalSideWalkLeft"); } }
        else { animator.SetTrigger("StopAnim"); }

        if (Input.GetKeyDown(KeyCode.Space) && !grounded) { animator.Play("Jump"); canWalk = false; canMove = false; }

    }

    void Move(Vector3 dir)
    {
        transform.position += dir * speed * Time.deltaTime;
    }

    public void Jump()
    {
        rb.AddForce(Vector3.up * jumpForce, ForceMode.Impulse);
        grounded = true;
        canMove = true;
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.layer == 6)
        {
            grounded = false;
            canWalk = true;

            Debug.Log("piso");
        }
    }

}
