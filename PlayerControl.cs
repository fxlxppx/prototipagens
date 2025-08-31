using UnityEngine;

public class PlayerControl : MonoBehaviour
{
    public float moveSpeed = 5f;
    private Rigidbody2D rb;
    private SpriteRenderer spriteRenderer;
    private InputSystem_Actions controls;

    private float moveInput;

    void Awake()
    {
        rb = GetComponent<Rigidbody2D>();
        spriteRenderer = GetComponentInChildren<SpriteRenderer>();

        controls = new InputSystem_Actions();

        // Liga os callbacks
        controls.Player.move.performed += ctx => moveInput = ctx.ReadValue<float>();
        controls.Player.move.canceled += ctx => moveInput = 0f;

        controls.Player.flip_gravity.performed += ctx => FlipGravity();
    }

    void OnEnable() => controls.Enable();
    void OnDisable() => controls.Disable();

    void FixedUpdate()
    {
        rb.linearVelocity = new Vector2(moveInput * moveSpeed, rb.linearVelocity.y);

        if (moveInput > 0.1f)
            spriteRenderer.flipX = false;
        else if (moveInput < -0.1f)
            spriteRenderer.flipX = true;
    }

    private void FlipGravity()
    {
        rb.gravityScale *= -1;
        Vector3 scale = transform.localScale;
        scale.y *= -1;
        transform.localScale = scale;
    }
}
