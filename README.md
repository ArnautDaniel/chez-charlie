# chez-charlie
Work towards a general binding generator for Chez Scheme

Supporting C libraries only at the moment.  

# Note
This is the one repo I have that people keep staring (which I would imagine is out of excite or curiosity) and then unstarring when they realize I haven't continued working on it.  It's not that many people,  but I figure why not write out an article for fun.

--

Racket-on-Chez really took the steam out of my proverbial sails.  I really can't see any reason to continue with Chez unless you're you're studying compiler theory and implementation.  Which is a shame because Chez is REALLY awesome but Matt Flatt played his hand perfectly by deciding to integrate into Chez as the new backend.  Genius!  I have to admire that even though I really find racket annoying.  (Their version of OOP drives me up a wall vs using CLOS).  In fact you can thank Mr. Flatt for bringing support for passing structs into the Chez FFI (which is really quite helpful).  By no means am I thinking little of people who continue to use Chez,  it's still fantastic.

There is a growing trend in the Scheme ecosystem that perhaps we should merge good backends with advanced frontends,  and so we see efforts like Gerbil where you get some really cool macro systems built off the infamous Gambit compiler.  I wouldn't be surprised (especially in Racket's case) if scheme saw a ressurgence because of this new trend.

And that is all to say I don't see much point in writing a ffi-generator when racket will provide a better "userland" of sorts with an entirely incompatible ffi.  Racket has the package manager,  Chez has attempts at one.

Scheme is alot like Forth in it's natural predisposition against any form of unity.  Which to me reveals the irony of something that captures the essence of a thing so well that everyone wants to add their own little incompatible ideas ontop of it.  Common Lisp was the conglomeration of incompatible ideas brought together into a big ball of mud that would end up driving the development of future blub languages without even knowing it.  Scheme has yet to do this.  

--  At this point it's really just useless ranting (I should really be programming right now instead of ranting) --

I started programming a long time ago when I first picked up a Visual Basic book.  The simplified history of my infatuation with programming languages is pretty much like the golden goose machine from Charlie and the Chocolate factory.  Crap.  Good! Crap.  And shorlty thereafter, Basic, Java, Python, and Perl were all thrown in the garbage shute.  There was something missing, and it wasn't till much later that I realized these languages are essentially DSL's of the mind.  They are little mazes some designer has seen fit to put us in so that we are forced to think like him, and our solutions become guided by the watchful eye of someone we've never met.  For companies, this is a fantastic property, since it invariably leads to cogwheel programmers who can be switched out like replacement parts.  

But young me at the time didn't realize this.  Against all frustration with "how dumb programming was" I kept on in search of the "perfect language".  The good news is it exists,  the bad news is it isn't here right now.  So for awhile I stuck with trusty C.  I did strange and impotent things with C.  I found C cumbersome yet lovable in it's simplicity.  And then one day I got sick of C.  I started hearing quotes from Stallman and Larry Wall about some "path to enlightenment" but...

And at this point I'll interupt the flow of everything to say you should stop reading this.  This type of sincerity will probably only leave a footpath for critics,  and I can't blame them.

Anyway, then I discovered...not Lisp but Haskell.  I only spent a few days going through Haskell material before some small part of my brain unlocked and I realized programming didn't have to be dumb,  but could rather become an extremely high expression of thought, and more importantly MY THOUGHTS.  Haskell still felt like a bit of a chain,  but compared to the C-Family I finally felt free.  You're telling me I can think how I normally think and express that in a pretty close correspondance with Haskell?  (And ever since then I've been an insuferrable apologist for functional programming)

The important lesson from this is the type of programming that makes sense to me is not the kind shackled only to your understanding of the languages semantics and syntax.  There must exist some property by which the state of my mind can translate to communication with a computer.  And if this property does exist then it is improving my mind (and it's order) that translates to better programs, not necessarily understanding the language better.  I would argue this is different from the enlightenment that "languages don't matter, problems do", simply becauase the thought can be replaced with "problems don't matter,  how you solve them does".  Which leaves us with the question of,  does the language let us modify it to a point where translating the solution is the trivial part?  Because if a language does let us modify itself then the language really has no static existence.  It exists only as a bridge between our mind and the perfect solution.  Languages that set us up with ridged walls can still express the perfect solution,  but at what cost?  (I do think C is a special case that dodges this problem).

But I'm getting ahead of myself because I haven't mentioned Lisp yet.

I don't remember how I discovered Lisp.  I just knew it was mentioned there alongside Haskell and I liked Haskell.  Yet my departure from the C family of languages only strengthed my resolve that perfect language must exist.  On queue, Prolog, Lisp, Scheme, Standard ML, and Forth were introduced to my world.

It turns out the perfect language still doesn't exist,  because it simply can't.  Although it is somewhere in the intersection of Forth and Lisp.  That much is certain.  If the most important property of a language is to act as a bridge (or isomorphism in geek-speak) between human and computer than what languages contain such a variable?

Well Forth prides itself on living in as few kilobytes as possible while also transitioning into whatever language is appropriate for the problem.

And Lisp prides itself on having a standard simplistic syntax based on mathematical logic along with the marriage of meta-programming into it's  base.

While this whole article is irrelevent,  I don't think these revelations are.  I just haven't learned how to express them perfectly.  Languages should exist only as bridges into DSL's and those DSL's should only exist as adequate representations of our mind.  It doesn't matter if the language is small and mallaeable (Scheme and Forth) or a big ball of mud sitting on stone foundation (Common Lisp).  All that matters is what's in your head.  Do you solve the problem in the best way possible, and is the language prohibiting you from doing that elegantly?

People say you should first learn that "all programming languages have their domain" and secondly learn that you should "use the right tool for the specific job" but I think these are just cop outs for impotent languages. If the language requires you to jump over immense hurdles to reach the mystical DSL land,  then arguing over "turing completeness" is really quite useless.  I instead offer that "only some programming languages properly allow the ability to transition from a general theory to a specific domain".  And when I say proper I take into account the time and effort necessary to perform this transition.

All programming problems are simply the result of languages being conformed into the proper domain so the programmer can solve them on his own terms.  

Meanwhile, I don't claim to be some super programmer.  I just sometimes wonder why my friends look like blacksmiths trying to hammer their language with chopsticks hoping it'll turn into something fancy.  Clay is a much more comfortable tool for the artist.
