Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8132CABD
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 04:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhCDDOF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 22:14:05 -0500
Received: from netrider.rowland.org ([192.131.102.5]:49975 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232249AbhCDDOD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 22:14:03 -0500
Received: (qmail 1595805 invoked by uid 1000); 3 Mar 2021 22:13:22 -0500
Date:   Wed, 3 Mar 2021 22:13:22 -0500
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
Message-ID: <20210304031322.GA1594980@rowland.harvard.edu>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <YEA3RwYixQPt6gul@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEA3RwYixQPt6gul@boqun-archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 04, 2021 at 09:26:31AM +0800, Boqun Feng wrote:
> On Wed, Mar 03, 2021 at 03:22:46PM -0500, Alan Stern wrote:

> > Which brings us back to the case of the
> > 
> > 	dep ; rfi
> > 
> > dependency relation, where the accesses in the middle are plain and 
> > non-racy.  Should the LKMM be changed to allow this?
> > 
> 
> For this particular question, do we need to consider code as the follow?
> 
> 	r1 = READ_ONCE(x);  // f
> 	if (r == 1) {
> 		local_v = &y; // g
> 		do_something_a();
> 	}
> 	else {
> 		local_v = &y;
> 		do_something_b();
> 	}
> 
> 	r2 = READ_ONCE(*local_v); // e
> 
> , do we have the guarantee that the first READ_ONCE() happens before the
> second one? Can compiler optimize the code as:
> 
> 	r2 = READ_ONCE(y);
> 	r1 = READ_ONCE(x);

Well, it can't do that because the compiler isn't allowed to reorder
volatile accesses (which includes READ_ONCE).  But the compiler could
do:

	r1 = READ_ONCE(x);
	r2 = READ_ONCE(y);

> 	if (r == 1) {
> 		do_something_a();
> 	}
> 	else {
> 		do_something_b();
> 	}
> 
> ? Although we have:
> 
> 	f ->dep g ->rfi ->addr e

This would be an example of a problem Paul has described on several
occasions, where both arms of an "if" statement store the same value
(in this case to local_v).  This problem arises even when local
variables are not involved.  For example:

	if (READ_ONCE(x) == 0) {
		WRITE_ONCE(y, 1);
		do_a();
	} else {
		WRITE_ONCE(y, 1);
		do_b();
	}

The compiler can change this to:

	r = READ_ONCE(x);
	WRITE_ONCE(y, 1);
	if (r == 0)
		do_a();
	else
		do_b();

thus allowing the marked accesses to be reordered by the CPU and
breaking the apparent control dependency.

So the answer to your question is: No, we don't have this guarantee,
but the reason is because of doing the same store in both arms, not
because of the use of local variables.

Alan
