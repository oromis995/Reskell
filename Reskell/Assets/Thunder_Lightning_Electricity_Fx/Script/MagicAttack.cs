using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MagicAttack : MonoBehaviour
{
    public Animator anim;
    public GameObject cam;
    public GameObject attackFx;
    public GameObject lightningBuff;
    public ParticleSystem onBodyFx;
    public Transform spawnPoint;
    public AudioSource castSound;
    public AudioSource eSparkSound;

    public GameObject basemesh;
    public Material fresnelMat;
    SkinnedMeshRenderer mesh;

    Animator camAnim;
    // Start is called before the first frame update
    void Start()
    {
        anim = this.GetComponent<Animator>();
        camAnim = cam.GetComponent<Animator>();
        mesh = basemesh.GetComponent<SkinnedMeshRenderer>();
        onBodyFx = lightningBuff.GetComponent<ParticleSystem>();
        lightningBuff.SetActive(false);
        camAnim.SetBool("isShake", false);
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Return))
        {
            anim.SetTrigger("isAttack");
        }
        
    }
    public void spawnAttackFx()
    {
        castSound.Play();
        camAnim.SetBool("isShake", true);
        mesh.material = fresnelMat;
        GameObject effect = Instantiate(attackFx, spawnPoint.transform.position, Quaternion.identity);
        Destroy(effect, 5f);
    }

    public void spawnFxOnBody()
    {
        eSparkSound.Play();
        lightningBuff.SetActive(true);
        onBodyFx.Play();
    }
}
