Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B732D776
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhCDQMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 11:12:36 -0500
Received: from netrider.rowland.org ([192.131.102.5]:50879 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236634AbhCDQMX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 11:12:23 -0500
Received: (qmail 1614672 invoked by uid 1000); 4 Mar 2021 11:11:42 -0500
Date:   Thu, 4 Mar 2021 11:11:42 -0500
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
Message-ID: <20210304161142.GB1612307@rowland.harvard.edu>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
 <YEA3RwYixQPt6gul@boqun-archlinux>
 <20210304031322.GA1594980@rowland.harvard.edu>
 <YEB/PGHs94W2l6hA@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEB/PGHs94W2l6hA@boqun-archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 04, 2021 at 02:33:32PM +0800, Boqun Feng wrote:

> Right, I was thinking about something unrelated.. but how about the
> following case:
> 
> 	local_v = &y;
> 	r1 = READ_ONCE(*x); // f
> 
> 	if (r1 == 1) {
> 		local_v = &y; // e
> 	} else {
> 		local_v = &z; // d
> 	}
> 
> 	p = READ_ONCE(local_v); // g
> 
> 	r2 = READ_ONCE(*p);   // h
> 
> if r1 == 1, we definitely think we have:
> 
> 	f ->ctrl e ->rfi g ->addr h
> 
> , and if we treat ctrl;rfi as "to-r", then we have "f" happens before
> "h". However compile can optimze the above as:
> 
> 	local_v = &y;
> 
> 	r1 = READ_ONCE(*x); // f
> 
> 	if (r1 != 1) {
> 		local_v = &z; // d
> 	}
> 
> 	p = READ_ONCE(local_v); // g
> 
> 	r2 = READ_ONCE(*p);   // h
> 
> , and when this gets executed, I don't think we have the guarantee we
> have "f" happens before "h", because CPU can do optimistic read for "g"
> and "h".

In your example, which accesses are supposed to be to actual memory and 
which to registers?  Also, remember that the memory model assumes the 
hardware does not reorder loads if there is an address dependency 
between them.

> Part of this is because when we take plain access into consideration, we
> won't guarantee a read-from or other relations exists if compiler
> optimization happens.
> 
> Maybe I'm missing something subtle, but just try to think through the
> effect of making dep; rfi as "to-r".

Forget about local variables for the time being and just consider

	dep ; [Plain] ; rfi

For example:

	A: r1 = READ_ONCE(x);
	   y = r1;
	B: r2 = READ_ONCE(y);

Should B be ordered after A?  I don't see how any CPU could hope to 
excute B before A, but maybe I'm missing something.

There's another twist, connected with the fact that herd7 can't detect 
control dependencies caused by unexecuted code.  If we have:

	A: r1 = READ_ONCE(x);
	if (r1)
		WRITE_ONCE(y, 5);
	r2 = READ_ONCE(y);
	B: WRITE_ONCE(z, r2);

then in executions where x == 0, herd7 doesn't see any control 
dependency.  But CPUs do see control dependencies whenever there is a 
conditional branch, whether the branch is taken or not, and so they will 
never reorder B before A.

One last thing to think about: My original assessment or Björn's problem 
wasn't right, because the dep in (dep ; rfi) doesn't include control 
dependencies.  Only data and address.  So I believe that the LKMM 
wouldn't consider A to be ordered before B in this example even if x 
was nonzero.

Alan
