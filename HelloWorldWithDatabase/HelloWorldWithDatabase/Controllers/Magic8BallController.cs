using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace HelloWorldWithDatabase.Controllers
{

    // NOTE: Derived from Steve Lasker's sample at https://github.com/SteveLasker/AspNetCoreMultiProject

    public class Magic8BallController : Controller
    {
        private readonly string Magic8BallApiUrl = "http://api/Magic8BallApi";

        // GET: Magic8Ball
        public async Task<ActionResult> Index()
        {
            HttpResponseMessage response = null;

            try
            {
                using (var httpClient = new HttpClient())
                {
                    var request = new HttpRequestMessage(HttpMethod.Get, Magic8BallApiUrl);
                    response = await httpClient.SendAsync(request);
                }
            }
            catch (Exception)
            {
                // TODO: yeah . . . this is bad.

                throw;
            }

            if (response != null && response.IsSuccessStatusCode)
            {
                var responseElements = new List<Dictionary<string, string>>();
                var responseString = await response.Content.ReadAsStringAsync();

                ViewData["Answer"] = responseString;
            }

            return View();
        }
    }
}