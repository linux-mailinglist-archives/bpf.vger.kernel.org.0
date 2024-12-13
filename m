Return-Path: <bpf+bounces-46876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DFC9F1428
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AE6188D1A3
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33C1E571F;
	Fri, 13 Dec 2024 17:43:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183D1E570B
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111828; cv=none; b=q5LJKFlObN9UiTynQFwFu2UiaYvLYynZxuPJae+xQEe/kgvNajhezqftriPylUu06HXf1EG7QZvuV4tjzWXf8QTdc+erOkrxuX5b0cl7JGrhFtdb0fqubCdGtNdSog4LEdsJuOt2wOViV679zRbEkuoluxDfXZ/0LmNcm5r0rQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111828; c=relaxed/simple;
	bh=xc8TJ5O6FCzVjbCNOyceHoHz8hrjkW3f5pSkWwqQ5Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi/00RNDPwf8mV/sSoDTUgLReSFOBTKvDKmcJfTMsjrjcfY57D1GmjhXw9PsQODzkWY1RxxFUrnqGxYF3l37j3OHqDftUSG/zii1cy3RV6QnlO7ry0Bjz9yO5vlleO6yCNURXnl84Zw4yTx1rB9/wsWW+J0GjWkI5El73ryszKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4752C4CED0;
	Fri, 13 Dec 2024 17:43:45 +0000 (UTC)
Date: Fri, 13 Dec 2024 12:44:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Matthew Wilcox <willy@infradead.org>, bpf
 <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 shakeel.butt@linux.dev, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo
 <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241213124411.105d0f33@gandalf.local.home>
In-Reply-To: <20241212160009.O3lGzN95@linutronix.de>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 17:00:09 +0100
Sebastian Sewior <bigeasy@linutronix.de> wrote:

> 
> The lockig of the raw_spinlock_t has irqsave. Correct. But not because
> it expects to be called in interrupt disabled context or an actual
> interrupt. It was _irq() but got changed because it is used in the early
> init code and would unconditionally enable interrupts which should
> remain disabled.
> 

Yep, I understand that. My point was that because it does it this way, it
should also work in hard interrupt context. But it doesn't!

Looking deeper, I do not think this is safe from interrupt context!

I'm looking at the rt_mutex_slowlock_block():


		if (waiter == rt_mutex_top_waiter(lock))
			owner = rt_mutex_owner(lock);
		else
			owner = NULL;
		raw_spin_unlock_irq(&lock->wait_lock);

		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
			rt_mutex_schedule();


If we take an interrupt right after the raw_spin_unlock_irq() and then do a
trylock on an rt_mutex in the interrupt and it gets the lock. The task is
now both blocked on a lock and also holding a lock that's later in the
chain. I'm not sure the PI logic can handle such a case. That is, we have
in the chain of the task:

 lock A (blocked-waiting-for-lock) -> lock B (taken in interrupt)

If another task blocks on B, it will reverse order the lock logic. It will
see the owner is the task, but the task is blocked on A, the PI logic
assumes that for such a case, the lock order would be:

  B -> A

But this is not the case. I'm not sure what would happen here, but it is
definitely out of scope of the requirements of the PI logic and thus,
trylock must also not be used in hard interrupt context.

-- Steve

