Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B641132C21B
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377906AbhCCW4u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:56:50 -0500
Received: from netrider.rowland.org ([192.131.102.5]:45335 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1388007AbhCCUX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 15:23:28 -0500
Received: (qmail 1584406 invoked by uid 1000); 3 Mar 2021 15:22:46 -0500
Date:   Wed, 3 Mar 2021 15:22:46 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210303202246.GC1582185@rowland.harvard.edu>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303174022.GD2696@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 09:40:22AM -0800, Paul E. McKenney wrote:
> On Wed, Mar 03, 2021 at 12:12:21PM -0500, Alan Stern wrote:

> > Local variables absolutely should be treated just like CPU registers, if 
> > possible.  In fact, the compiler has the option of keeping local 
> > variables stored in registers.
> > 
> > (Of course, things may get complicated if anyone writes a litmus test 
> > that uses a pointer to a local variable,  Especially if the pointer 
> > could hold the address of a local variable in one execution and a 
> > shared variable in another!  Or if the pointer is itself a shared 
> > variable and is dereferenced in another thread!)
> 
> Good point!  I did miss this complication.  ;-)

I suspect it wouldn't be so bad if herd7 disallowed taking addresses of 
local variables.

> As you say, when its address is taken, the "local" variable needs to be
> treated as is it were shared.  There are exceptions where the pointed-to
> local is still used only by its process.  Are any of these exceptions
> problematic?

Easiest just to rule out the whole can of worms.

> > But even if local variables are treated as non-shared storage locations, 
> > we should still handle this correctly.  Part of the problem seems to lie 
> > in the definition of the to-r dependency relation; the relevant portion 
> > is:
> > 
> > 	(dep ; [Marked] ; rfi)
> > 
> > Here dep is the control dependency from the READ_ONCE to the 
> > local-variable store, and the rfi refers to the following load of the 
> > local variable.  The problem is that the store to the local variable 
> > doesn't go in the Marked class, because it is notated as a plain C 
> > assignment.  (And likewise for the following load.)
> > 
> > Should we change the model to make loads from and stores to local 
> > variables always count as Marked?
> 
> As long as the initial (possibly unmarked) load would be properly
> complained about.

Sorry, I don't understand what you mean.

>  And I cannot immediately think of a situation where
> this approach would break that would not result in a data race being
> flagged.  Or is this yet another failure of my imagination?

By definition, an access to a local variable cannot participate in a 
data race because all such accesses are confined to a single thread.

However, there are other aspects to consider, in particular, the 
ordering relations on local-variable accesses.  But if, as Luc says, 
local variables are treated just like registers then perhaps the issue 
doesn't arise.

> > What should have happened if the local variable were instead a shared 
> > variable which the other thread didn't access at all?  It seems like a 
> > weak point of the memory model that it treats these two things 
> > differently.
> 
> But is this really any different than the situation where a global
> variable is only accessed by a single thread?

Indeed; it is the _same_ situation.  Which leads to some interesting 
questions, such as: What does READ_ONCE(r) mean when r is a local 
variable?  Should it be allowed at all?  In what way is it different 
from a plain read of r?

One difference is that the LKMM doesn't allow dependencies to originate 
from a plain load.  Of course, when you're dealing with a local 
variable, what matters is not the load from that variable but rather the 
earlier loads which determined the value that had been stored there.  
Which brings us back to the case of the

	dep ; rfi

dependency relation, where the accesses in the middle are plain and 
non-racy.  Should the LKMM be changed to allow this?

There are other differences to consider.  For example:

	r = READ_ONCE(x);
	smp_wmb();
	WRITE_ONCE(y, 1);

If the write to r were treated as a marked store, the smp_wmb would 
order it (and consequently the READ_ONCE) before the WRITE_ONCE.  
However we don't want to do this when r is a local variable.  Indeed, a 
plain store wouldn't be ordered this way because the compiler might 
optimize the store away entirely, leaving the smp_wmb nothing to act on.

So overall the situation is rather puzzling.  Treating local variables 
as registers is probably the best answer.

Alan
