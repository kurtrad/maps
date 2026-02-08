<%@ WebHandler Language="C#" Class="EbirdProxy" %>

using System;
using System.Web;
using System.Net;
using System.IO;

public class EbirdProxy : IHttpHandler
{
    // Store API key securely on server-side only
    private const string EBIRD_API_KEY = "npobnnr5u7fo";
    
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        
        // Enable CORS if needed
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        context.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        context.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type");
        
        if (context.Request.HttpMethod == "OPTIONS")
        {
            context.Response.StatusCode = 200;
            return;
        }
        
        try
        {
            // Get the eBird URL from query parameter
            string ebirdUrl = context.Request.QueryString["url"];
            
            if (string.IsNullOrEmpty(ebirdUrl))
            {
                context.Response.StatusCode = 400;
                context.Response.Write("{\"error\":\"Missing url parameter\"}");
                return;
            }
            
            // Validate URL is from eBird domain
            if (!ebirdUrl.StartsWith("https://ebird.org/", StringComparison.OrdinalIgnoreCase) && 
                !ebirdUrl.StartsWith("https://api.ebird.org/", StringComparison.OrdinalIgnoreCase))
            {
                context.Response.StatusCode = 403;
                context.Response.Write("{\"error\":\"Invalid domain: " + ebirdUrl + "\"}");
                return;
            }
            
            // Create request to eBird API
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(ebirdUrl);
            request.Method = "GET";
            request.Headers.Add("X-eBirdApiToken", EBIRD_API_KEY);
            
            // Get response
            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            {
                string result = reader.ReadToEnd();
                context.Response.Write(result);
            }
        }
        catch (WebException ex)
        {
            context.Response.StatusCode = 500;
            if (ex.Response != null)
            {
                using (StreamReader reader = new StreamReader(ex.Response.GetResponseStream()))
                {
                    context.Response.Write(reader.ReadToEnd());
                }
            }
            else
            {
                context.Response.Write("{\"error\":\"" + ex.Message.Replace("\"", "\\\"") + "\"}");
            }
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.Write("{\"error\":\"" + ex.Message.Replace("\"", "\\\"") + "\"}");
        }
    }
    
    public bool IsReusable
    {
        get { return true; }
    }
}
