Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40BB32C1F6
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449760AbhCCWxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:47 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55505 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1343665AbhCCTmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 14:42:10 -0500
Received: (qmail 1582740 invoked by uid 1000); 3 Mar 2021 14:40:54 -0500
Date:   Wed, 3 Mar 2021 14:40:54 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     maranget <luc.maranget@inria.fr>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210303194054.GB1582185@rowland.harvard.edu>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <29736B0B-9960-473C-85BB-5714F181198B@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29736B0B-9960-473C-85BB-5714F181198B@inria.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 06:37:36PM +0100, maranget wrote:
> 
> 
> > On 3 Mar 2021, at 18:12, Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > On Tue, Mar 02, 2021 at 03:50:19PM -0800, Paul E. McKenney wrote:
> >> On Tue, Mar 02, 2021 at 04:14:46PM -0500, Alan Stern wrote:
> > 
> >>> This result is wrong, apparently because of a bug in herd7.  There 
> >>> should be control dependencies from each of the two loads in P0 to each 
> >>> of the two stores, but herd7 doesn't detect them.
> >>> 
> >>> Maybe Luc can find some time to check whether this really is a bug and 
> >>> if it is, fix it.
> >> 
> >> I agree that herd7's control dependency tracking could be improved.
> >> 
> >> But sadly, it is currently doing exactly what I asked Luc to make it do,
> >> which is to confine the control dependency to its "if" statement.  But as
> >> usual I wasn't thinking globally enough.  And I am not exactly sure what
> >> to ask for.  Here a store to a local was control-dependency ordered after
> >> a read, and so that should propagate to a read from that local variable.
> >> Maybe treat local variables as if they were registers, so that from
> >> herd7's viewpoint the READ_ONCE()s are able to head control-dependency
> >> chains in multiple "if" statements?
> >> 
> >> Thoughts?
> > 
> > Local variables absolutely should be treated just like CPU registers, if 
> > possible.  In fact, the compiler has the option of keeping local 
> > variables stored in registers.
> > 
> 
> And indeed local variables are treated as registers by herd7.
> 
> 
> > (Of course, things may get complicated if anyone writes a litmus test 
> > that uses a pointer to a local variable,  Especially if the pointer 
> > could hold the address of a local variable in one execution and a 
> > shared variable in another!  Or if the pointer is itself a shared 
> > variable and is dereferenced in another thread!)
> > 
> > But even if local variables are treated as non-shared storage locations, 
> > we should still handle this correctly.  Part of the problem seems to lie 
> > in the definition of the to-r dependency relation; the relevant portion 
> > is:
> 
> In fact, I’d rather change the computation of “dep” here control-dependency “ctrl”. Notice that “ctrl” is computed by herd7 and present in the initial environment of the Cat interpreter.
> 
> I have made a PR to herd7 that performs the change. The commit message states the new definition.

Shouldn't similar reasoning apply to data and address dependencies?

For example, suppose there is a control dependency from a load to a 
register variable, and then a data dependency from the register variable 
to a store.  This should be treated as an overall data dependency from 
the load to the store.

Does your change to herd7 do this?  I couldn't tell from the description 
in the PR.

Also, do you think it's reasonable to add a restriction to herd7 against 
taking the address of a local variable?

> > 	(dep ; [Marked] ; rfi)
> > 
> > Here dep is the control dependency from the READ_ONCE to the 
> > local-variable store, and the rfi refers to the following load of the 
> > local variable.  The problem is that the store to the local variable 
> > doesn't go in the Marked class, because it is notated as a plain C 
> > assignment.  (And likewise for the following load.)
> > 
> This is a related issue, I am not sure, but perhaps it can be formulated as
> "should rfi and rf on registers behave the  same?”

Aren't they already the same thing?  It's not possible to have an rfe 
from a register, is it?

Alan

> > Should we change the model to make loads from and stores to local 
> > variables always count as Marked?
> > 
> > What should have happened if the local variable were instead a shared 
> > variable which the other thread didn't access at all?  It seems like a 
> > weak point of the memory model that it treats these two things 
> > differently.
> > 
> > Alan
