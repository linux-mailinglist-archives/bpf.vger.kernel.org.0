Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471BB32B357
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352538AbhCCDvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444954AbhCBT6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 14:58:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 707A864F16;
        Tue,  2 Mar 2021 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614715078;
        bh=hyDREYjkyRLda93XeYqtSaRIRtjT4SlJIyzUDf9DXiE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j5KfiQ2gq5PFDBXaE3tuzlqSV7rffOGyxdTNHmJQ6r6qoG25shheU0jBIg6uL+6yg
         x2Plbz/7YohB2NgM0VFNIcnnxUfk1Z+JzXyiITV3DhcHWH7JLlo9tz0j/1s3olVNfw
         icXYWbFSGjR8cdMIMGZwONSSwd4eQvhmPuWWwZ4wYjeqvEdQhUD0owTACHMgu1JTi/
         ZBIKyTupHlTkJJAZ9mQRgiO7eF2CbWaaSUztBKHghQf7zDqOdsaKermByLbLrtOaXJ
         zLYC3hc0/QlDvFTT+PmK6A+gXSqU4LXJHPCG40XZZrK6x6bKEUabHbZzoEqkvn+HCs
         L1Nj1g3qcSYCA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 215B0352259C; Tue,  2 Mar 2021 11:57:58 -0800 (PST)
Date:   Tue, 2 Mar 2021 11:57:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: XDP socket rings, and LKMM litmus tests
Message-ID: <20210302195758.GQ2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+HfNhxWFeKnn1aZw-YJmzpBuCaoeGkXXKn058GhY-6ZBDtZA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Before digging in too deeply, does the following simplification
still capture your intent?

P0(int *prod, int *cons, int *data)
{
    int p;
    int cond = 0;

    p = READ_ONCE(*prod);
    if (p == READ_ONCE(*cons))
            cond = 1;
    if (cond) {
	smp_mb();
        WRITE_ONCE(*data, 1);
        smp_wmb();
        WRITE_ONCE(*prod, p ^ 1);
    }
}

P1(int *prod, int *cons, int *data)
{
    int c;
    int d = -1;
    int cond = 0;

    c = READ_ONCE(*cons);
    if (READ_ONCE(*prod) == c)
            cond = 1;

    if (cond == 1) {
        smp_rmb();
        d = READ_ONCE(*data);
        smp_mb();
        WRITE_ONCE(*cons, c ^ 1);
    }
}

							Thanx, Paul

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
> 
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
> 
> 
> If you read this far, thanks! :-)
> Björn
> 
> 
> [1] https://lore.kernel.org/bpf/20210301104318.263262-2-bjorn.topel@gmail.com/
