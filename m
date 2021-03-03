Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9832C1B6
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449565AbhCCWwh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Mar 2021 17:52:37 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35025 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236532AbhCCRjp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 12:39:45 -0500
X-IronPort-AV: E=Sophos;i="5.81,220,1610406000"; 
   d="scan'208";a="495963342"
Received: from lfbn-idf1-1-708-183.w86-245.abo.wanadoo.fr (HELO mp-66156.home) ([86.245.159.183])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 18:37:38 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: XDP socket rings, and LKMM litmus tests
From:   maranget <luc.maranget@inria.fr>
In-Reply-To: <20210303171221.GA1574518@rowland.harvard.edu>
Date:   Wed, 3 Mar 2021 18:37:36 +0100
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <29736B0B-9960-473C-85BB-5714F181198B@inria.fr>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 3 Mar 2021, at 18:12, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Tue, Mar 02, 2021 at 03:50:19PM -0800, Paul E. McKenney wrote:
>> On Tue, Mar 02, 2021 at 04:14:46PM -0500, Alan Stern wrote:
> 
>>> This result is wrong, apparently because of a bug in herd7.  There 
>>> should be control dependencies from each of the two loads in P0 to each 
>>> of the two stores, but herd7 doesn't detect them.
>>> 
>>> Maybe Luc can find some time to check whether this really is a bug and 
>>> if it is, fix it.
>> 
>> I agree that herd7's control dependency tracking could be improved.
>> 
>> But sadly, it is currently doing exactly what I asked Luc to make it do,
>> which is to confine the control dependency to its "if" statement.  But as
>> usual I wasn't thinking globally enough.  And I am not exactly sure what
>> to ask for.  Here a store to a local was control-dependency ordered after
>> a read, and so that should propagate to a read from that local variable.
>> Maybe treat local variables as if they were registers, so that from
>> herd7's viewpoint the READ_ONCE()s are able to head control-dependency
>> chains in multiple "if" statements?
>> 
>> Thoughts?
> 
> Local variables absolutely should be treated just like CPU registers, if 
> possible.  In fact, the compiler has the option of keeping local 
> variables stored in registers.
> 

And indeed local variables are treated as registers by herd7.


> (Of course, things may get complicated if anyone writes a litmus test 
> that uses a pointer to a local variable,  Especially if the pointer 
> could hold the address of a local variable in one execution and a 
> shared variable in another!  Or if the pointer is itself a shared 
> variable and is dereferenced in another thread!)
> 
> But even if local variables are treated as non-shared storage locations, 
> we should still handle this correctly.  Part of the problem seems to lie 
> in the definition of the to-r dependency relation; the relevant portion 
> is:

In fact, I’d rather change the computation of “dep” here control-dependency “ctrl”. Notice that “ctrl” is computed by herd7 and present in the initial environment of the Cat interpreter.

I have made a PR to herd7 that performs the change. The commit message states the new definition.


> 
> 	(dep ; [Marked] ; rfi)
> 
> Here dep is the control dependency from the READ_ONCE to the 
> local-variable store, and the rfi refers to the following load of the 
> local variable.  The problem is that the store to the local variable 
> doesn't go in the Marked class, because it is notated as a plain C 
> assignment.  (And likewise for the following load.)
> 
This is a related issue, I am not sure, but perhaps it can be formulated as
"should rfi and rf on registers behave the  same?”



> Should we change the model to make loads from and stores to local 
> variables always count as Marked?
> 
> What should have happened if the local variable were instead a shared 
> variable which the other thread didn't access at all?  It seems like a 
> weak point of the memory model that it treats these two things 
> differently.
> 
> Alan

