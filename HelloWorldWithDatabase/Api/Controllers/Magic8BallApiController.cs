using Api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Api.Controllers
{
    [Route("Magic8BallApi")]
    public class Magic8BallApiController : ApiController
    {
        static Random r = new Random();
        private EightBallAnswers answers = new EightBallAnswers();

        public string Get()
        {
            int rInt = r.Next(0, answers.Count() - 1);
            return answers[rInt];
        }

        public string Get(int id)
        {
            return answers[Math.Min(Math.Max(0, id), answers.Count() - 1)];
        }

        // POST api/values
        public void Post([FromBody]string value)
        {
            throw new NotImplementedException("The all Mighty Crazy 8 Ball already has all the answers.");
        }

        // PUT api/values/5
        public void Put(int id, [FromBody]string value)
        {
            throw new NotImplementedException("You think you're worthy of submitting answers to the all Mighty Crazy 8 Ball.");
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
            throw new NotImplementedException("No one may delete answers from the all Mighty Crazy 8 Ball.");
        }
    }
}
