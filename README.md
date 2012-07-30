# A Web Application for Uncle Bob
Inspired by [Bob Martin's](http://cleancoders.com) impressive keynote at Ruby Midwest 2011, entitled [Architecture the Lost Years](http://support.iawriter.com/help/kb/frequently-asked-questions-in-general/markdown-syntax-reference-guide), I undertook to develop some web applications in the style of Ivar Jacobson's Object Oriented Software Engineering: A Use Case Driven Approach, and Eric Evans' Domain-Driven Design: Tackling Complexity in the Heart of Software [Hardcover] Eric Evans. 

# The Application
The Application is a simple Url-shortener.  As conceived, it will maintain an initially seeded list of shortcuts and corresponding locators, permit you to modify and add new records, and to redirect shortcut urls to the corresponding locators.  Users may sign up and login with passwords to obtain access to that functionality.

# Structure of the Application
The application adopts Jacobson's nomenclature, amended by Uncle Bob, using Entities, Interactors and Boundaries, and without reference to web and persistence frameworks, such as Rails and Sinatra.  These objects are defined in the top level directory folders bearing those names.  The Use Cases, so implemented are directly defined and tested in isolation, using a memory-based persistence application implementing the Repository boundary interface.

The application is then packaged with various web frameworks to demonstrate how this can be done.  In the next iteration, it will be bundled with flat file, SQL and NoSql persistence solutions.

# Other Inspiration

I acknowledge and draw inspiration from many sources. I am grateful to the works of [Corey Haines](http://coreyhaines.com), [Gary Bernhardt](https://www.destroyallsoftware.com) and [Avdi Grimm](http://devblog.avdi.org) who got me on this path.  As mentioned, Uncle Bob's prolific writing, lecturing and advocacy has been a particular inspiriation.  [Clean Code](http://cleancoders.com)

Two particular experiments in this area informed my thoughts and work:

* [Jason Roelofs' **Raidit**](https://github.com/jasonroelofs/raidit)
  
Raidit is a reasonably complex application built within a rails app, adding an interactors folder and placing entities in the Rails model directory.  Entities are built out in some cases as ActiveModel objects.
    
* ** [Piotr 'Qertoip' Włodarek's **Guru Watch**](https://github.com/qertoip/guru_watch)
  
The application is more modest than Raidit, but the extraction from rails is a tour de force.  He uses UseCases in lieu of Interactors, and some other terminology, but the application builds nicely in rails and runs in memory as well.  He retains ActiveSupport and also uses ActiveModel (actually ActiveAttr) in his mainline.  Also expressly separates pieces of rails, using ActiveRecord on the repository side, and ActionPack on the "Web" side.  He seems to be building up a more elaborate persistence framework akin to a full DDD repository.

Please, please, please, communicate if you are interested in this approach -- its time we started organizing our thoughts to see if this makes any sense at all.  I'm emotionally committed to this approach as, at least in Greenfield, the initial app development (and TDD!) goes SOOOOO smoothly.

Andrew Greenberg (wizardwerdna@gmail.com)

# What's Here?

The application directory structure includes the following:

* boundaries

These objects represent interface objects with which non-application entties may interact.  One example is
Repository, which holds objects for persisting various entities.  The application knows only that objects
stored here from outside.  Boundaries do not depend on any non-application objects.

* entities

These are the non-application-specific business objects.  Entities do not depend on any non-application objects.

* interactors

These are the application-specific busines objects, particularly, but not exclusively operators on entities. Intractors do not depend on any non-application objects.

* require files 

boundaries.rb, entities.rb and interactors.rb will include the contents of their respective directories.  application.rb will include the foregoing as well.

* lib

These are support objects used by boundaries, entities and interactors, but do not include web and persistence frameworks.  The latter would be packaged up with the application, frameworks and application interface implementations and wired up for a deployed build.  Notice that the application will not depend upon the latter pieces, and so can be rebuilt, redeployed, plugged in and so forth without change to the application.

* docs

Assorted notes and use case definitions live here

* repositories

Non-application impelementations of the persistence interface.  Implementations are anticipated for in-memory persistence, SQL, NoSQL and flat files.

* z_[web application_frameworks] and corresponding Z...ru files

Non-application implementations of the web communications framework and mainline code.  All based directly or indirectly on rack for interfacing with a web framework using the application boundaries, interactors and entities.

Other support files include Gemfiles and the like.
