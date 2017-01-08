using System;

namespace HelloWorld
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("**********************************");
            Console.WriteLine($"Hello! I am running at {Environment.MachineName}.");

            for (int x = 0; x <= 5; x++)
                Console.WriteLine("**");

            // insert message here
            Console.WriteLine($"*****    Hello {args[0]}!");

            for (int x = 0; x <= 5; x++)
                Console.WriteLine("**");
            Console.WriteLine("**********************************");

            // Just pause for a bit
            Console.ReadLine();
        }
    }
}
