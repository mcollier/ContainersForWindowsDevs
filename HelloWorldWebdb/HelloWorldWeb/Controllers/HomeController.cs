using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HelloWorldWeb.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [ActionName("About")]
        public async System.Threading.Tasks.Task<ActionResult> AboutAsync()
        {
            ViewBag.Message = "Your application description page.";
            string connectionString = Environment.GetEnvironmentVariable("CONNECTION_STRING") ??
                                        ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection sqlConn = new SqlConnection(connectionString))
            {
                try
                {
                    sqlConn.Open();

                    using (SqlCommand sqlCmd = new SqlCommand("SELECT Top 1 (ColA) FROM dbo.Table01", sqlConn))
                    {
                        var result = await sqlCmd.ExecuteScalarAsync() as string;

                        ViewData["result"] = result;
                    }
                }
                finally
                {
                    if (sqlConn != null)
                    {
                        sqlConn.Close();
                    }
                }
            }

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}