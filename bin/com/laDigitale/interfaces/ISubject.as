package com.laDigitale.interfaces 
{
    
    /**
     * ...
     * @author Julien BEAUFILS
     */
    public interface ISubject 
    {
        function add(addedListeners:Vector.<IUpdate>, types:Vector.<int>):void
        function remove(addedListeners:Vector.<IUpdate>, types:Vector.<int>):void
        function getEmptyExecutableVector():Vector.<Vector.<IExe>>;
    }
    
}