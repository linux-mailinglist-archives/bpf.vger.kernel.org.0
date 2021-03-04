Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA332D6FD
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhCDPpY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 4 Mar 2021 10:45:24 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45887 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235493AbhCDPpS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Mar 2021 10:45:18 -0500
X-IronPort-AV: E=Sophos;i="5.81,222,1610406000"; 
   d="scan'208";a="496144963"
Received: from lfbn-idf1-1-708-183.w86-245.abo.wanadoo.fr (HELO mp-66156.home) ([86.245.159.183])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 16:44:35 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: XDP socket rings, and LKMM litmus tests
From:   maranget <luc.maranget@inria.fr>
In-Reply-To: <20210303202246.GC1582185@rowland.harvard.edu>
Date:   Thu, 4 Mar 2021 16:44:34 +0100
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "Alglave, Jade" <j.alglave@ucl.ac.uk>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, joel@joelfernandes.org,
        =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <EF3F87BF-2AA1-4F96-A2A0-EA8A9D6FC8F7@inria.fr>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
 <20210302211446.GA1541641@rowland.harvard.edu>
 <20210302235019.GT2696@paulmck-ThinkPad-P72>
 <20210303171221.GA1574518@rowland.harvard.edu>
 <20210303174022.GD2696@paulmck-ThinkPad-P72>
 <20210303202246.GC1582185@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 3 Mar 2021, at 21:22, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
>>> 
>>> Local variables absolutely should be treated just like CPU registers, if 
>>> possible.  In fact, the compiler has the option of keeping local 
>>> variables stored in registers.
>>> 
>>> (Of course, things may get complicated if anyone writes a litmus test 
>>> that uses a pointer to a local variable,  Especially if the pointer 
>>> could hold the address of a local variable in one execution and a 
>>> shared variable in another!  Or if the pointer is itself a shared 
>>> variable and is dereferenced in another thread!)
>> 
>> Good point!  I did miss this complication.  ;-)
> 
> I suspect it wouldn't be so bad if herd7 disallowed taking addresses of 
> local variables.
> 
> 

Herd7 does disallow taking addresses of local variables.

However, such  tests can still be run on machine, provided function bodies are accepted by the C compiler.

—Luc

