# A Web Application for Uncle Bob
Inspired by Bob Martin's impressive keynote at Ruby Midwest 2011, entitled [Architecture the Lost Years][http://support.iawriter.com/help/kb/frequently-asked-questions-in-general/markdown-syntax-reference-guide], I undertook to develop some web applications in the style of Ivar Jacobson's Object Oriented Software Engineering: A Use Case Driven Approach.

# The Application
The Application is a simple Url-shortener.  As conceived, it will maintain an initially seeded list of shortcuts and corresponding locators, permit you to modify and add new records, and to redirect shortcut urls to the corresponding locators.  Users may sign up and login with passwords to obtain access to that functionality.

# Structure of the Application
The application adopts Jacobson's nomenclature, amended by Uncle Bob, using Entities, Interactors and Boundaries, and without reference to web and persistence frameworks, such as Rails and Sinatra.  These objects are defined in the top level directory folders bearing those names.  The Use Cases, so implemented are directly defined and tested in isolation, using a memory-based persistence application implementing the Repository boundary interface.

The application is then packaged with various web frameworks to demonstrate how this can be done.  In the next iteration, it will be bundled with flat file, SQL and NoSql persistence solutions.

# Other Inspiration

I acknowledge and draw inspiration from two particular experiments in this area:

* **Jason Roelofs' Raidit (https://github.com/jasonroelofs/raidit)**
  
Raidit is a reasonably complex application built within a rails app, adding an interactors folder and placing entities in the Rails model directory.  Entities are built out in some cases as ActiveModel objects.
    
* **Piotr 'Qertoip' Włodarek (https://github.com/qertoip/guru_watch)**
  
The application is more modest than Raidit, but the extraction from rails is a tour de force.  He uses UseCases in lieu of Interactors, and some other terminology, but the application builds nicely in rails and runs in memory as well.  He retains ActiveSupport and also uses ActiveModel (actually ActiveAttr) in his mainline.  Also expressly separates pieces of rails, using ActiveRecord on the repository side, and ActionPack on the "Web" side.  He seems to be building up a more elaborate persistence framework akin to a full DDD repository.

Please, please, please, communicate if you are interested in this approach -- its time we started organizing our thoughts to see if this makes any sense at all.  I'm emotionally committed to this approach as, at least in Greenfield, the initial app development (and TDD!) goes SOOOOO smoothly.

Andrew Greenberg (wizardwerdna@gmail.com)
