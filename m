Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC4532EFD2
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCEQPa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 11:15:30 -0500
Received: from netrider.rowland.org ([192.131.102.5]:56353 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231216AbhCEQPS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 11:15:18 -0500
Received: (qmail 41907 invoked by uid 1000); 5 Mar 2021 11:15:17 -0500
Date:   Fri, 5 Mar 2021 11:15:17 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210305161517.GF38200@rowland.harvard.edu>
References: <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <YEA3RwYixQPt6gul@boqun-archlinux>
 <20210304031322.GA1594980@rowland.harvard.edu>
 <YEB/PGHs94W2l6hA@boqun-archlinux>
 <20210304161142.GB1612307@rowland.harvard.edu>
 <YEGFfjmOYfbuir9o@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEGFfjmOYfbuir9o@boqun-archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 05, 2021 at 09:12:30AM +0800, Boqun Feng wrote:
> On Thu, Mar 04, 2021 at 11:11:42AM -0500, Alan Stern wrote:

> > Forget about local variables for the time being and just consider
> > 
> > 	dep ; [Plain] ; rfi
> > 
> > For example:
> > 
> > 	A: r1 = READ_ONCE(x);
> > 	   y = r1;
> > 	B: r2 = READ_ONCE(y);
> > 
> > Should B be ordered after A?  I don't see how any CPU could hope to 
> > excute B before A, but maybe I'm missing something.
> > 
> 
> Agreed.
> 
> > There's another twist, connected with the fact that herd7 can't detect 
> > control dependencies caused by unexecuted code.  If we have:
> > 
> > 	A: r1 = READ_ONCE(x);
> > 	if (r1)
> > 		WRITE_ONCE(y, 5);
> > 	r2 = READ_ONCE(y);
> > 	B: WRITE_ONCE(z, r2);
> > 
> > then in executions where x == 0, herd7 doesn't see any control 
> > dependency.  But CPUs do see control dependencies whenever there is a 
> > conditional branch, whether the branch is taken or not, and so they will 
> > never reorder B before A.
> > 
> 
> Right, because B in this example is a write, what if B is a read that
> depends on r2, like in my example? Let y be a pointer to a memory
> location, and initialized as a valid value (pointing to a valid memory
> location) you example changed to:
> 
> 	A: r1 = READ_ONCE(x);
> 	if (r1)
> 		WRITE_ONCE(y, 5);
> 	C: r2 = READ_ONCE(y);
> 	B: r3 = READ_ONCE(*r2);
> 
> , then A don't have the control dependency to B, because A and B is
> read+read. So B can be ordered before A, right?

Yes, I think that's right: Both C and B can be executed before A.

> > One last thing to think about: My original assessment or Björn's problem 
> > wasn't right, because the dep in (dep ; rfi) doesn't include control 
> > dependencies.  Only data and address.  So I believe that the LKMM 
> 
> Ah, right. I was mising that part (ctrl is not in dep). So I guess my
> example is pointless for the question we are discussing here ;-(
> 
> > wouldn't consider A to be ordered before B in this example even if x 
> > was nonzero.
> 
> Yes, and similar to my example (changing B to a read).
> 
> I did try to run my example with herd, and got confused no matter I make
> dep; [Plain]; rfi as to-r (I got the same result telling me a reorder
> can happen). Now the reason is clear, because this is a ctrl; rfi not a
> dep; rfi.
> 
> Thanks so much for walking with me on this ;-)

You're welcome.  At this point, it looks like the only remaining 
question is whether to include (dep ; [Plain] ; rfi) in to-r.  This 
doesn't seem to be an urgent question.

Alan
