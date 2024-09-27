using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ElectricLine : MonoBehaviour
{
    private LineRenderer line;
    public Transform startPoint;
    public Transform endPoint;
    public Material electricMat;
    public int pointCount;
    public float randomValue;
    private float timer;
    private float timerTimeout = 0.05f;
    Vector3 step;
    Vector3 currentPoint;
    public float scrollSpeed = 0.5f;
    // Start is called before the first frame update
    void Start()
    {
        line = gameObject.AddComponent<LineRenderer>();
        line.widthMultiplier = 0.1f;
        line.positionCount = pointCount;
        line.material = electricMat;
        
        step = (startPoint.transform.position - endPoint.transform.position) / pointCount;
        
    }

    // Update is called once per frame
    void Update()
    {
        line.SetPosition(0, startPoint.transform.position);
        line.SetPosition(pointCount - 1, endPoint.transform.position);
        float offset = Time.time * scrollSpeed;
        electricMat.SetTextureOffset("_MainTex", new Vector2(offset, 0));
        timer += Time.deltaTime;
        if(timer > timerTimeout)
        {
            timer = 0;
            currentPoint = startPoint.transform.position;
            for (int i = 1; i < pointCount - 1; i++)
            {
                currentPoint.x += Random.Range(-randomValue, randomValue);
                currentPoint.y += Random.Range(-randomValue, randomValue);
                currentPoint.z += Random.Range(-randomValue, randomValue);
                line.SetPosition(i, currentPoint);
                currentPoint -= step;
            }
        }
        
    }
}
