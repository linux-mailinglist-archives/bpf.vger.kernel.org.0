Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846A532B35E
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352482AbhCCDvO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:14 -0500
Received: from netrider.rowland.org ([192.131.102.5]:53941 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1383578AbhCBVQ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 16:16:28 -0500
Received: (qmail 1545136 invoked by uid 1000); 2 Mar 2021 16:14:46 -0500
Date:   Tue, 2 Mar 2021 16:14:46 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210302211446.GA1541641@rowland.harvard.edu>
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 02, 2021 at 07:46:27PM +0100, Björn Töpel wrote:
> Hi!
> 
> Firstly; The long Cc-list is to reach the LKMM-folks.
> 
> Some background; the XDP sockets use a ring-buffer to communicate
> between the kernel and userland. It's a
> single-consumer/single-producer ring, and described in
> net/xdp/xsk_queue.h.
> 
> --8<---
> /* The structure of the shared state of the rings are the same as the
>  * ring buffer in kernel/events/ring_buffer.c. For the Rx and completion
>  * ring, the kernel is the producer and user space is the consumer. For
>  * the Tx and fill rings, the kernel is the consumer and user space is
>  * the producer.
>  *
>  * producer                         consumer
>  *
>  * if (LOAD ->consumer) {           LOAD ->producer
>  *                    (A)           smp_rmb()       (C)
>  *    STORE $data                   LOAD $data
>  *    smp_wmb()       (B)           smp_mb()        (D)
>  *    STORE ->producer              STORE ->consumer
>  * }
>  *
>  * (A) pairs with (D), and (B) pairs with (C).
> ...
> -->8---
> 
> I'd like to replace the smp_{r,w,}mb() barriers with acquire-release
> semantics [1], without breaking existing userspace applications.
> 
> So, I figured I'd use herd7 and the LKMM model to build a litmus test
> for the barrier version, then for the acquire-release version, and
> finally permutations of both.
> 
> The idea is to use a one element ring, with a state machine outlined
> in the litmus test.
> 
> The basic test for the existing smp_{r,w,}mb() barriers looks like:
> 
> $ cat spsc-rb+1p1c.litmus
> C spsc-rb+1p1c
> 
> // Stupid one entry ring:
> // prod cons     allowed action       prod cons
> //    0    0 =>       prod          =>   1    0
> //    0    1 =>       cons          =>   0    0
> //    1    0 =>       cons          =>   1    1
> //    1    1 =>       prod          =>   0    1
> 
> { prod = 1; }
> 
> // Here, we start at prod==1,cons==0, data==0, i.e. producer has
> // written data=0, so from here only the consumer can start, and should
> // consume data==0. Afterwards, producer can continue and write 1 to
> // data. Can we enter state prod==0, cons==1, but consumer observerd
> // the write of 1?
> 
> P0(int *prod, int *cons, int *data)
> {
>     int p;
>     int c;
>     int cond = 0;
> 
>     p = READ_ONCE(*prod);
>     c = READ_ONCE(*cons);
>     if (p == 0)
>         if (c == 0)
>             cond = 1;
>     if (p == 1)
>         if (c == 1)
>             cond = 1;
> 
>     if (cond) {
>         smp_mb();
>         WRITE_ONCE(*data, 1);
>         smp_wmb();
>         WRITE_ONCE(*prod, p ^ 1);
>     }
> }
> 
> P1(int *prod, int *cons, int *data)
> {
>     int p;
>     int c;
>     int d = -1;
>     int cond = 0;
> 
>     p = READ_ONCE(*prod);
>     c = READ_ONCE(*cons);
>     if (p == 1)
>         if (c == 0)
>             cond = 1;
>     if (p == 0)
>         if (c == 1)
>             cond = 1;
> 
>     if (cond == 1) {
>         smp_rmb();
>         d = READ_ONCE(*data);
>         smp_mb();
>         WRITE_ONCE(*cons, c ^ 1);
>     }
> }
> 
> exists( 1:d=1 /\ prod=0 /\ cons=1 );
> 
> --
> 
> The weird state changing if-statements is because that I didn't get
> '&&' and '||' to work with herd.
> 
> When this is run:
> 
> $ herd7 -conf linux-kernel.cfg litmus-tests/spsc-rb+1p1c.litmus
> Test spsc-rb+1p1c Allowed
> States 2
> 1:d=0; cons=1; prod=0;
> 1:d=0; cons=1; prod=1;
> No
> Witnesses
> Positive: 0 Negative: 2
> Condition exists (1:d=1 /\ prod=0 /\ cons=1)
> Observation spsc-rb+1p1c Never 0 2
> Time spsc-rb+1p1c 0.04
> Hash=b399756d6a1301ca5bda042f32130791
> 
> Now to my question; In P0 there's an smp_mb(). Without that, the d==1
> can be observed from P1 (consumer):
> 
> $ herd7 -conf linux-kernel.cfg litmus-tests/spsc-rb+1p1c.litmus
> Test spsc-rb+1p1c Allowed
> States 3
> 1:d=0; cons=1; prod=0;
> 1:d=0; cons=1; prod=1;
> 1:d=1; cons=1; prod=0;
> Ok
> Witnesses
> Positive: 1 Negative: 2
> Condition exists (1:d=1 /\ prod=0 /\ cons=1)
> Observation spsc-rb+1p1c Sometimes 1 2
> Time spsc-rb+1p1c 0.04
> Hash=0047fc21fa77da9a9aee15e35ec367ef

This result is wrong, apparently because of a bug in herd7.  There 
should be control dependencies from each of the two loads in P0 to each 
of the two stores, but herd7 doesn't detect them.

Maybe Luc can find some time to check whether this really is a bug and 
if it is, fix it.

> In commit c7f2e3cd6c1f ("perf: Optimize ring-buffer write by depending
> on control dependencies") removes the corresponding smp_mb(), and also
> the circular buffer in circular-buffers.txt (pre commit 6c43c091bdc5
> ("documentation: Update circular buffer for
> load-acquire/store-release")) is missing the smp_mb() at the
> producer-side.
> 
> I'm trying to wrap my head around why it's OK to remove the smp_mb()
> in the cases above? I'm worried that the current XDP socket ring
> implementation (which is missing smp_mb()) might be broken.

Because of the control dependencies, the smp_mb isn't needed.  The 
dependencies will order both of the stores after both of the loads.

Alan Stern
