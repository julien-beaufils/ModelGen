COMPILATION :

This project can be compiled with the help of Redtamarin : http://code.google.com/p/redtamarin/

EXAMPLE USAGE : 

In the bin folder, launch "modelGen.exe" with "model.txt" as an argument to see the result.

two class are generated: "Slider" and "SliderData":
- Dont code in "SliderData" (or "EveryThingYouWantData")
- In the example (as with other models), the class SliderData will be regenarated each time you recall modelGen.exe
- The "Slider" class will note be erased because this is the place were logic musr be put.
- Changing data-tpl.xml is not recomanded.

PERSONNAL USAGE :
- create a package for a module in an AS project 
- put a file named "model.txt" in it
- generate classes for the module with modelGen.exe