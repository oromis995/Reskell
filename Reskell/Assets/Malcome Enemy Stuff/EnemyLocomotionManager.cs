using System.Collections;
using System.Collections.Generic;
using UnityEngine;


    public class EnemyLocomotionManager : MonoBehaviour
    {
        EnemyManager enemyManager;

        LayerMask detectionLayer;

        private void Awake()
        {
            enemyManager = GetComponent<EnemyManager>();
        }


        // Start is called before the first frame update
        public void HandleDetection()
        {
           /* Collider[] colliders = Physics.OverlapSphere(transform.positon, enemyManager.detectionRadius, detectionLayer);

                for(int i = 0; i < colliders.Length; i++)
                

  
             */   
        }

    }
