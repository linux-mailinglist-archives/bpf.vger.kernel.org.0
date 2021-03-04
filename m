Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B012832CBB8
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 06:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCDFEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 00:04:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCDFEs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 00:04:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8507C64EDF;
        Thu,  4 Mar 2021 05:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614834247;
        bh=n/FJ5Ej7z9LFFSAb4luZ8Y9JEPqogDVcunu/yI2101E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FKt9DSodqml3rcOgnWYKBA1KWT3ERXDWCJD3oYpbtLdxbbkDyD/XTcYjrDiKxkEyK
         VkyfQETjUg+We0BRgjDNnBBfkg9oyuTjbTLMqxJDFchCFFCRAmBHCw7+BCXfYf5HAK
         gTI2IsuS7CZxg6/8tsukp/cctUbTFgtyDAnaovohJbXRBJeM7t2u1YN9MePT8PyH66
         KvKdF38WtjdCgHc+L/VA3RJkug2+2H5B+YngtZrK7X1j2hW7N3NwUpVMGBG35ARbVc
         +P5nX1Uk+kis/8c91MVm/LoMLQy23zdMynsN9gpglpR0VvruR/ahjmDxT6LUGWPGge
         ZyVk+Ef6CYsEg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5142A352274A; Wed,  3 Mar 2021 21:04:07 -0800 (PST)
Date:   Wed, 3 Mar 2021 21:04:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20210304050407.GN2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <20210303220348.GL2696@paulmck-ThinkPad-P72>
 <20210304032101.GB1594980@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304032101.GB1594980@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 10:21:01PM -0500, Alan Stern wrote:
> On Wed, Mar 03, 2021 at 02:03:48PM -0800, Paul E. McKenney wrote:
> > On Wed, Mar 03, 2021 at 03:22:46PM -0500, Alan Stern wrote:
> > > On Wed, Mar 03, 2021 at 09:40:22AM -0800, Paul E. McKenney wrote:
> > > > On Wed, Mar 03, 2021 at 12:12:21PM -0500, Alan Stern wrote:
> > > 
> > > > > Local variables absolutely should be treated just like CPU registers, if 
> > > > > possible.  In fact, the compiler has the option of keeping local 
> > > > > variables stored in registers.
> > > > > 
> > > > > (Of course, things may get complicated if anyone writes a litmus test 
> > > > > that uses a pointer to a local variable,  Especially if the pointer 
> > > > > could hold the address of a local variable in one execution and a 
> > > > > shared variable in another!  Or if the pointer is itself a shared 
> > > > > variable and is dereferenced in another thread!)
> > > > 
> > > > Good point!  I did miss this complication.  ;-)
> > > 
> > > I suspect it wouldn't be so bad if herd7 disallowed taking addresses of 
> > > local variables.
> > > 
> > > > As you say, when its address is taken, the "local" variable needs to be
> > > > treated as is it were shared.  There are exceptions where the pointed-to
> > > > local is still used only by its process.  Are any of these exceptions
> > > > problematic?
> > > 
> > > Easiest just to rule out the whole can of worms.
> > 
> > Good point, given that a global can be used instead of a local for
> > any case where an address must be taken.
> 
> Another thing to consider: Almost all marked accesses involve using the 
> address of the storage location (for example, smp_load_acquire's first 
> argument must be a pointer).  As far as I can remember at the moment, 
> the only ones that don't are READ_ONCE and WRITE_ONCE.  So although we 
> might or might not want to allow READ_ONCE or WRITE_ONCE on a local 
> variable, we won't have to worry about any of the other kinds of marked 
> accesses.

Good point!

> > > > > But even if local variables are treated as non-shared storage locations, 
> > > > > we should still handle this correctly.  Part of the problem seems to lie 
> > > > > in the definition of the to-r dependency relation; the relevant portion 
> > > > > is:
> > > > > 
> > > > > 	(dep ; [Marked] ; rfi)
> > > > > 
> > > > > Here dep is the control dependency from the READ_ONCE to the 
> > > > > local-variable store, and the rfi refers to the following load of the 
> > > > > local variable.  The problem is that the store to the local variable 
> > > > > doesn't go in the Marked class, because it is notated as a plain C 
> > > > > assignment.  (And likewise for the following load.)
> > > > > 
> > > > > Should we change the model to make loads from and stores to local 
> > > > > variables always count as Marked?
> > > > 
> > > > As long as the initial (possibly unmarked) load would be properly
> > > > complained about.
> > > 
> > > Sorry, I don't understand what you mean.
> > 
> > I was thinking in terms of something like this in one of the processes:
> > 
> > 	p = gp; // Unmarked!
> > 	r1 = p;
> > 	q = r1; // Implicitly marked now?
> > 	if (q)
> > 		WRITE_ONCE(x, 1); // ctrl dep from gp???
> 
> I hope we won't have to worry about this!  :-)  Treating local variable 
> accesses as if they are always marked looks wrong.

Good, that is where I was also heading.  ;-)

> > > >  And I cannot immediately think of a situation where
> > > > this approach would break that would not result in a data race being
> > > > flagged.  Or is this yet another failure of my imagination?
> > > 
> > > By definition, an access to a local variable cannot participate in a 
> > > data race because all such accesses are confined to a single thread.
> > 
> > True, but its value might have come from a load from a shared variable.
> 
> Then that load could have participated in a data race.  But the store to 
> the local variable cannot.

Agreed.  My thought was that if the ordering from the initial (non-local)
load mattered, then that initial load must have participated in a
data race.  Is that true, or am I failing to perceive some corner case?

> > > However, there are other aspects to consider, in particular, the 
> > > ordering relations on local-variable accesses.  But if, as Luc says, 
> > > local variables are treated just like registers then perhaps the issue 
> > > doesn't arise.
> > 
> > Here is hoping!
> > 
> > > > > What should have happened if the local variable were instead a shared 
> > > > > variable which the other thread didn't access at all?  It seems like a 
> > > > > weak point of the memory model that it treats these two things 
> > > > > differently.
> > > > 
> > > > But is this really any different than the situation where a global
> > > > variable is only accessed by a single thread?
> > > 
> > > Indeed; it is the _same_ situation.  Which leads to some interesting 
> > > questions, such as: What does READ_ONCE(r) mean when r is a local 
> > > variable?  Should it be allowed at all?  In what way is it different 
> > > from a plain read of r?
> > > 
> > > One difference is that the LKMM doesn't allow dependencies to originate 
> > > from a plain load.  Of course, when you're dealing with a local 
> > > variable, what matters is not the load from that variable but rather the 
> > > earlier loads which determined the value that had been stored there.  
> > > Which brings us back to the case of the
> > > 
> > > 	dep ; rfi
> > > 
> > > dependency relation, where the accesses in the middle are plain and 
> > > non-racy.  Should the LKMM be changed to allow this?
> > 
> > It would be nice, give or take the potential side effects.  ;-)
> > As in it would be nice, but might not be worthwhile.
> 
> Treating local variables like registers will automatically bring this 
> behavior.  So I think we'll be good.

Sounds good.

> > > There are other differences to consider.  For example:
> > > 
> > > 	r = READ_ONCE(x);
> > > 	smp_wmb();
> > > 	WRITE_ONCE(y, 1);
> > > 
> > > If the write to r were treated as a marked store, the smp_wmb would 
> > > order it (and consequently the READ_ONCE) before the WRITE_ONCE.  
> > > However we don't want to do this when r is a local variable.  Indeed, a 
> > > plain store wouldn't be ordered this way because the compiler might 
> > > optimize the store away entirely, leaving the smp_wmb nothing to act on.
> > 
> > Agreed, having smp_wmb() order things due to a write to a local variable
> > would not be what we want.
> > 
> > > So overall the situation is rather puzzling.  Treating local variables 
> > > as registers is probably the best answer.
> > 
> > That is sounding quite appealing at the moment.
> 
> Agreed.

							Thanx, Paul
