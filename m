Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3531732C1DA
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449650AbhCCWxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234665AbhCCSxa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 13:53:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28EE660202;
        Wed,  3 Mar 2021 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614793223;
        bh=rDStRwmXAve0oQTG5k7PfaMiDSDFC27uP7nYrXqgo3o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=b+JGlPDUkGXhKIeRKVvV2gFkS5Dk4zndAPHSXAQ9FXADV14ZIL3rhHpOAowpJfGvq
         +iEIoe7MZ6/9iP7vmnJ3jCM2WOGoFHO0pkqMpQX3zj/e3JbBayZwfuCikZ6C6OiEEN
         xMS7iBV9zv8021pav27dRLdFqcRzi2zZ6mMEMiogOPwfAoaDWaHkv1bZS2grQVi1M8
         b8/fQzpFt50kKYDXt2C/zQSkN9o72kNBJm35FIlziHvNuzKj6HqqHjGgtd1QsenZTE
         QfuYCGUgI81fu2plL0IGFT8J6KJp6PgNFxFidEGl3aRohVVaU55nXJZlRLUdBwl0AY
         2JW9UKfL2zrYQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D930835237A1; Wed,  3 Mar 2021 09:40:22 -0800 (PST)
Date:   Wed, 3 Mar 2021 09:40:22 -0800
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
Message-ID: <20210303174022.GD2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303171221.GA1574518@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 12:12:21PM -0500, Alan Stern wrote:
> On Tue, Mar 02, 2021 at 03:50:19PM -0800, Paul E. McKenney wrote:
> > On Tue, Mar 02, 2021 at 04:14:46PM -0500, Alan Stern wrote:
> 
> > > This result is wrong, apparently because of a bug in herd7.  There 
> > > should be control dependencies from each of the two loads in P0 to each 
> > > of the two stores, but herd7 doesn't detect them.
> > > 
> > > Maybe Luc can find some time to check whether this really is a bug and 
> > > if it is, fix it.
> > 
> > I agree that herd7's control dependency tracking could be improved.
> > 
> > But sadly, it is currently doing exactly what I asked Luc to make it do,
> > which is to confine the control dependency to its "if" statement.  But as
> > usual I wasn't thinking globally enough.  And I am not exactly sure what
> > to ask for.  Here a store to a local was control-dependency ordered after
> > a read, and so that should propagate to a read from that local variable.
> > Maybe treat local variables as if they were registers, so that from
> > herd7's viewpoint the READ_ONCE()s are able to head control-dependency
> > chains in multiple "if" statements?
> > 
> > Thoughts?
> 
> Local variables absolutely should be treated just like CPU registers, if 
> possible.  In fact, the compiler has the option of keeping local 
> variables stored in registers.
> 
> (Of course, things may get complicated if anyone writes a litmus test 
> that uses a pointer to a local variable,  Especially if the pointer 
> could hold the address of a local variable in one execution and a 
> shared variable in another!  Or if the pointer is itself a shared 
> variable and is dereferenced in another thread!)

Good point!  I did miss this complication.  ;-)

As you say, when its address is taken, the "local" variable needs to be
treated as is it were shared.  There are exceptions where the pointed-to
local is still used only by its process.  Are any of these exceptions
problematic?

> But even if local variables are treated as non-shared storage locations, 
> we should still handle this correctly.  Part of the problem seems to lie 
> in the definition of the to-r dependency relation; the relevant portion 
> is:
> 
> 	(dep ; [Marked] ; rfi)
> 
> Here dep is the control dependency from the READ_ONCE to the 
> local-variable store, and the rfi refers to the following load of the 
> local variable.  The problem is that the store to the local variable 
> doesn't go in the Marked class, because it is notated as a plain C 
> assignment.  (And likewise for the following load.)
> 
> Should we change the model to make loads from and stores to local 
> variables always count as Marked?

As long as the initial (possibly unmarked) load would be properly
complained about.  And I cannot immediately think of a situation where
this approach would break that would not result in a data race being
flagged.  Or is this yet another failure of my imagination?

> What should have happened if the local variable were instead a shared 
> variable which the other thread didn't access at all?  It seems like a 
> weak point of the memory model that it treats these two things 
> differently.

But is this really any different than the situation where a global
variable is only accessed by a single thread?

							Thanx, Paul
