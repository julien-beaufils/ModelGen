package  
{
    import avmplus.FileSystem;
    import avmplus.System;
	/**
     * ...
     * @author Julien BEAUFILS
     */
    public class DataClassCreator
    {
        private var tplXMl:XML;
        private var numMembers:int;
        private var className:String;
        private var packageName:String;
        public function DataClassCreator(argv:Array) 
        {
            XML.ignoreWhitespace = false;
            XML.prettyPrinting = false;
            var file:String;
            var splitExp:RegExp = new RegExp("\\" + FileSystem.separators.join("|"), "g");
            var baseSeparator:String = FileSystem.separators[0];
            if (argv.length == 0)
            {
                trace("Fichier de model ?");
                argv[0] = readLine();
            }
            if (argv[1] == "dev") file = "bin/data-tpl.xml";
            else
            {
                var filePath:Array = System.programFilename.split(splitExp);
                filePath.pop();
                if (filePath.length == 0) filePath = ['.*'];
                file = filePath.join(baseSeparator) + baseSeparator + "data-tpl.xml";
            }
            if (FileSystem.exists(file)) tplXMl = new XML(FileSystem.read(file));
            else trace("TPL non trouvé:", file);
            file = argv[0];
            if (!FileSystem.exists(file)) trace("fichier passé en argument non trouvé :", file );
            else
            {
                var fileString:String = FileSystem.read(file);
                var tab:Vector.<String> = Vector.<String>(fileString.split(/\n/gm));
                for each (var item:String in tab) 
                {
                   var tab2:Vector.<String> = Vector.<String>(item.split(" "));
                   if (hasOwnProperty(tab2[0] + "Func")) this[tab2[0] + "Func"](tab2[1]);
                   else varFunc(tab2[0], tab2[1]);
                }
                for (var i:int = 0; i < numMembers; i++) 
                {
                    var hasComma:String = ",\n";
                    if(i == numMembers-1) hasComma = ""
                     tplXMl.data.vectors.appendChild(tplXMl.repeated.vectors.toString().replace(/#\{hasComma\}/gm, hasComma).replace("<", "&lt;").replace(">", "&gt"));
                }
                filePath = file.split(splitExp);
                filePath.pop();
                var directory:String = filePath.join(baseSeparator) + baseSeparator;
                FileSystem.write(directory + className + "Data.as", getResult(tplXMl.data));
                if (!FileSystem.exists(directory + className + ".as"))FileSystem.write(directory + className + ".as", getResult(tplXMl.control));
            }
        }
        public function getResult(xml:XMLList):String
        {
            return xml.children().toString()
                .replace(/#\{package\}/gm, packageName)
                .replace(/#\{class\}/gm, className)
                .replace(/#\{numMembers\}/gm, numMembers)
                .replace(/<\/?.*?>/gm, "")
                .replace(/&(amp;)?lt;?/gm, "<")
                .replace(/&(amp;)?gt;?/gm, ">");
        }
        
        public function classFunc(value:String):void
        {
            var tab:Array = value.split("::");
            packageName = tab[0];
            className = tab[1];
        }
        public function importFunc(value:String):void
        {
            tplXMl.data.imports.appendChild(tplXMl.repeated.imports.toString().replace(/#\{import\}/gm, value));
        }
        public function varFunc(memberName:String, memberType:String ):void
        {
            var tabName:Vector.<String> = Vector.<String>(memberName.split('_'));
            var constName:String = memberName.toUpperCase();
            var upperName:String = "";
            for each (var part:String in tabName) 
            {
                upperName += part.charAt(0).toUpperCase() + part.substr(1);
            }
            var lowerName:String = upperName.charAt(0).toLowerCase() + upperName.substr(1);
            var memberTpl:String = tplXMl.repeated.members.toString();
            memberTpl = memberTpl
                .replace(/#\{constName\}/gm, constName)
                .replace(/#\{upperName\}/gm, upperName)
                .replace(/#\{lowerName\}/gm, lowerName)
                .replace(/#\{number\}/gm, numMembers)
                .replace(/#\{type\}/gm, memberType);
            numMembers++;
            
            tplXMl.data.members.appendChild(memberTpl);
        }
    }

}