Return-Path: <bpf+bounces-46899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A09F17AD
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB88188F6C9
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E33418E02A;
	Fri, 13 Dec 2024 21:00:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518918660F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123611; cv=none; b=Gr2mvIisT7uo41fJeFt3nnYArr7XOrjAOP1S3lHKXbKYlnLfXPSGfqab6KtiqRxCs1JsAv4ErwtuWPjuo7qrgXhhB340gn5Td7q+mjEFpZFURZ7Q8lfktzUdU52QgM7qy9jySxq33vrgKZb0Tr6wVlry6Zpbh1zRZWESToAUm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123611; c=relaxed/simple;
	bh=SX6MBQzLs9NpwJ11OkF5G5o94O/V8ha1yI1FhNkn1zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6EE9EEHq4rA5hUsbS+HxMjxwCFCErFfCh0aONbAbj4wbdH//rWVMIM404jFfLBr7g6yBGaTLy4Ha5CeCbVrmNNBo95onQkVZ7b6QCQ0biPO3pQLMjkZqqDOIk41t588uqw5sJwZePWslHaykjIJhlVyZfrouisGk+vTE5pJIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62700C4CED0;
	Fri, 13 Dec 2024 21:00:09 +0000 (UTC)
Date: Fri, 13 Dec 2024 16:00:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Michal Hocko
 <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, bpf
 <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 shakeel.butt@linux.dev, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo
 <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241213160035.677810fb@gandalf.local.home>
In-Reply-To: <20241213150950.2879b7db@gandalf.local.home>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
	<20241210023936.46871-2-alexei.starovoitov@gmail.com>
	<Z1fSMhHdSTpurYCW@casper.infradead.org>
	<Z1gEUmHkF1ikgbor@tiehlicka>
	<CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
	<20241212150744.dVyycFUJ@linutronix.de>
	<Z1r_eKGkJYMz-uwH@tiehlicka>
	<20241212153506.dT1MvukO@linutronix.de>
	<20241212104809.1c6cb0a1@batman.local.home>
	<20241212160009.O3lGzN95@linutronix.de>
	<20241213124411.105d0f33@gandalf.local.home>
	<CAADnVQ+R3ABHX2sdiTqjgZDgn0==cA3gryx9h_uDktU6P2s2aw@mail.gmail.com>
	<20241213150950.2879b7db@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 15:09:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > What's the concern then? That PI may see an odd order of locks for this task ?
> > but it cannot do anything about it anyway, since the task won't schedule.
> > And before irq handler is over the B will be released and everything
> > will look normal again.  
> 
> The problem is the chain walk. It could also cause unwanted side effects in RT.
> 
> If low priority task 1 has lock A and is running on another CPU and low
> priority task 2 blocks on lock A and then is interrupted right before going
> to sleep as being "blocked on", and takes lock B in the interrupt context.
> We then have high priority task 3 on another CPU block on B which will then
> see that the owner of B is blocked (even though it is not blocked for B), it
> will boost its priority as well as the owner of the lock (A). The A owner
> will get boosted where it is not the task that is blocking the high
> priority task.
> 
> My point is that RT is all about deterministic behavior. It would require
> a pretty substantial audit to the PI logic to make sure that this doesn't
> cause any unexpected results.
> 
> My point is, the PI logic was not designed for taking a lock after being
> blocked on another lock. It may work, but we had better prove and show all
> side effects that can happen in these cases.

When B is released, task 2 will be unboosted, but task 1 will not. That's
because a task is only unboosted when it releases a lock (or a lock times
out, and then the waiter will unboost the chain, but that's not this case).

Task 1 will unboost when it finally releases lock A.

Another issue is that interrupts are not stopped by spin_lock_irq*() as in
RT spin_lock_irq*() is the same as spin_lock(). As spin_locks() are assumed
to only be in threaded irq context, there's no reason to actually disable
interrupts when taking one of these spin_lock_irq*().

That means we could have task 1 trying to take lock B too. If we have a
lock order of:

  A -> B

Where B is the trylock in the irq context, we have:


  CPU 1			CPU 2			CPU 3
  -----			-----			-----
 task 1 takes A
			task 2 blocks on A, gets interrupted, trylock B and succeeds:

 task 1 takes B (blocks)

						High priority task 3 blocks on B

Now we have this in the PI chain:

  Task 3 boosts tasks 2 but task 2 is blocked on A
  Task 3 then boosts owner of A which is task 1 which is blocked on lock B
  Task 3 then boosts owner of lock B which is task 2
  [ wash, rinse, repeat!!! ]

There is a safety valve in the code that will prevent an infinite loop, and
it will trigger a printk message or it may stop because the priorities are
equal, but still, this is not desirable and may even have other side
effects. If deadlock detection is enabled, this will trigger it.

Again, allowing spin_locks being taken in hard irq context in RT, even with
trylock is going to open a nasty can of worms that will make this less
deterministic and determinism is the entire point of RT. If we allow one
user to have spin_lock_trylock() in hard irq context, we have to allow
anyone to do it.

-- Steve

