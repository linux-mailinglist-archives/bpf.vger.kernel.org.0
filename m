Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1CD32DCB2
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 23:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhCDWGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 17:06:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241291AbhCDWGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 17:06:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AFE364FE4;
        Thu,  4 Mar 2021 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614895530;
        bh=suBm0AczXfyXCs3/V7HzIWZ/odWc295qpMNQ8Wvt/jU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IGCHvZtMqr9FWLNaUf3U3CLqpuMkFZmqx9pzimcS24Un+XK1z+RP8IlHZI0VsCMsm
         UsADwtFH8pXcjSha+vSakj937JdgrFTpv5zE9AtP7h2wsRYIvkQk8uZpikyUQM2Wq5
         A0yUX+fq102C4k5bBJ7nbnAguFaVyLg2d9U6fe+af2Da7ocP73VGWXDa7ItfJrmz6c
         uL9CCDbdtxUFAzmI/Gysu3q864E9Rkkee8PwaixZ1M0bX7uRz6u75pP+4eyfuvtOq1
         /9dBNUamy3lW1n3aGHX+J5+ZneXzOGcHNbUTMMuOp0Wvf8VWl+jjpbfDAEP1EHJbMY
         wbFt1OgbApewg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EC2953522B62; Thu,  4 Mar 2021 14:05:29 -0800 (PST)
Date:   Thu, 4 Mar 2021 14:05:29 -0800
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
Message-ID: <20210304220529.GW2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <20210303220348.GL2696@paulmck-ThinkPad-P72>
 <20210304032101.GB1594980@rowland.harvard.edu>
 <20210304050407.GN2696@paulmck-ThinkPad-P72>
 <20210304153524.GA1612307@rowland.harvard.edu>
 <20210304190515.GS2696@paulmck-ThinkPad-P72>
 <20210304212753.GB14408@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304212753.GB14408@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 04, 2021 at 04:27:53PM -0500, Alan Stern wrote:
> On Thu, Mar 04, 2021 at 11:05:15AM -0800, Paul E. McKenney wrote:
> > On Thu, Mar 04, 2021 at 10:35:24AM -0500, Alan Stern wrote:
> > > On Wed, Mar 03, 2021 at 09:04:07PM -0800, Paul E. McKenney wrote:
> > > > On Wed, Mar 03, 2021 at 10:21:01PM -0500, Alan Stern wrote:
> > > > > On Wed, Mar 03, 2021 at 02:03:48PM -0800, Paul E. McKenney wrote:
> > > > > > On Wed, Mar 03, 2021 at 03:22:46PM -0500, Alan Stern wrote:
> > > 
> > > > > > > >  And I cannot immediately think of a situation where
> > > > > > > > this approach would break that would not result in a data race being
> > > > > > > > flagged.  Or is this yet another failure of my imagination?
> > > > > > > 
> > > > > > > By definition, an access to a local variable cannot participate in a 
> > > > > > > data race because all such accesses are confined to a single thread.
> > > > > > 
> > > > > > True, but its value might have come from a load from a shared variable.
> > > > > 
> > > > > Then that load could have participated in a data race.  But the store to 
> > > > > the local variable cannot.
> > > > 
> > > > Agreed.  My thought was that if the ordering from the initial (non-local)
> > > > load mattered, then that initial load must have participated in a
> > > > data race.  Is that true, or am I failing to perceive some corner case?
> > > 
> > > Ordering can matter even when no data race is involved.  Just think
> > > about how much of the memory model is concerned with ordering of
> > > marked accesses, which don't participate in data races unless there is
> > > a conflicting plain access somewhere.
> > 
> > Fair point.  Should I have instead said "then that initial load must
> > have run concurrently with a store to that same variable"?
> 
> I'm losing track of the point you were originally trying to make.
> 
> Does ordering matter when there are no conflicting accesses?  Sure.  
> Consider this:
> 
> 	A: r1 = READ_ONCE(x);
> 	B: WRITE_ONCE(y, r1);
> 	   smp_wmb();
> 	C: WRITE_ONCE(z, 1);
> 
> Even if there are no other accesses to y at all (let alone any 
> conflicting ones), the mere existence of B forces A to be ordered before 
> C, and this is easily detectable by a litmus test.

Given that herd7 treats all local variables as registers (including
forbidding taking their addresses), and given that we are not thinking of
treating local-variable accesses as if they were marked, this is likely
all moot.

But just in case...

I was trying to figure out if there was a litmus test of the following
form where it might make a difference if local-variable accesses were
treated as if they were marked.  So is there something like this:

	r1 = x;
	if (r1)
	   	WRITE_ONCE(y, 1);

where implicitly treating the accesses to r1 as marked would make a
difference.  I was thinking that any such example would have to result
in LKMM flagging the load from x as a data race.  However, your example
inserting the smp_wmb() does shed some doubt on that theory.

This of course is moot unless we come back to treating local-variable
accesses as if they were marked.

							Thanx, Paul
