package 
{
    import avmplus.FileSystem;
    import avmplus.System;
    import C.stdlib.getenv;
    import C.unistd.*;
    
    /**
     * ...
     * @author Julien BEAUFILS
     */
    public class modelGen 
    {
        private static var creator:DataClassCreator;
        static public function main(argv:Array) 
        {
            try { creator = new DataClassCreator(argv); }
            catch (e:*) { trace(e); readLine(); };
        }
        
        
        
    }
}

