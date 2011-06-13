package com.laDigitale
{
    import com.laDigitale.interfaces.*;
	/**
     * ...
     * @author Julien BEAUFILS
     */
    public class UpdateLinker implements IUpdate
    {
        protected var subject:ISubject;
        private var identifiedCommands:Vector.<Vector.<IExe>>;
        private var commandsList:Vector.<Vector.<IExe>>;
        private var commandIds:Vector.<int>;
        private var updateVect:Vector.<IUpdate>;
       public function UpdateLinker(subject:ISubject = null) 
        {
            init(subject);
        }
        
        public function setSubject(subject:ISubject = null):void
        {
            if (this.subject != null) this.subject.remove(updateVect, commandIds);
            this.subject = subject;
            setCommands(commandIds, commandsList);
        }
        
        public function getSubject():ISubject{return subject;}
        
        private function init(subject:ISubject):void
        {
            this.subject = subject;
            updateVect = new<IUpdate>[this];
        }
                
        public function setCommands(commandIds:Vector.<int>, ...args):void
        {
            var commands:Vector.<Vector.<IExe>> = Vector.<Vector.<IExe>>(args);
            if(subject!=null) subject.remove(updateVect, this.commandIds);
            this.commandsList = commands;
            this.commandIds = commandIds;
            if (subject == null || commands==null || commandIds == null) return;
            this.identifiedCommands = subject.getEmptyExecutableVector();
            var l:int = commandIds.length;
            for (var i:int = 0; i < l; i++) this.identifiedCommands[commandIds[i]] =  commands[i];
            subject.add(updateVect, commandIds);
            for (i = 0; i < l; i++) 
            {
                var id:int = commandIds[i];
                var cmdVect:Vector.<IExe> = this.identifiedCommands[id];
                update(id);
            }
        }
        public function addCommand(commandId:int, command:IExe):void
        {
            if (command == null) return;
            if (this.commandIds == null) this.commandIds = new Vector.<int>();
            if(this.identifiedCommands == null)this.identifiedCommands = subject.getEmptyExecutableVector();
            subject.remove(updateVect, this.commandIds);
            var cmdIdIndex:int = this.commandIds.indexOf(commandId)
            if (cmdIdIndex == -1) 
            {
                cmdIdIndex = this.commandIds.length;
                this.commandIds[cmdIdIndex] = commandId;
            }
            if (this.identifiedCommands[cmdIdIndex] == null) this.identifiedCommands[cmdIdIndex] = new Vector.<IExe>();
            var cmds:Vector.<IExe> = this.identifiedCommands[cmdIdIndex];
            cmds[cmds.length] = command;
            subject.add(updateVect, this.commandIds);
            command.exe();
        }
        public function removeCommand(commandId:int, command:IExe):void
        {
            if (command == null) return;
            if (this.commandIds == null) this.commandIds = new Vector.<int>();
            subject.remove(updateVect, this.commandIds);
            var cmdIdIndex:int = this.commandIds.indexOf(commandId)
            if (cmdIdIndex != -1) 
            {
                var cmds:Vector.<IExe> = this.identifiedCommands[cmdIdIndex];
                var cmdIndex:int = cmds.indexOf(command);
                if (cmdIndex != -1)
                {
                    cmds.splice(cmdIndex, 1)
                    trace(cmds);
                }
                subject.add(updateVect, this.commandIds);
            }
        }
        
        /* INTERFACE interfaces.IUpdate */
        
        public function update(id:int):void 
        {
            var cmdVect:Vector.<IExe> = identifiedCommands[id];
            for each(var cmd:IExe in cmdVect)
            {
                if (cmd == null) continue;
                cmd.exe();
            }
        }
        
        public function destroy():void
        {
            subject.remove(updateVect, commandIds);
        }
    }

}