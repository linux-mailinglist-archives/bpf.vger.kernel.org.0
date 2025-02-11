Return-Path: <bpf+bounces-51161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AB1A311C6
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDACA162570
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C6256C91;
	Tue, 11 Feb 2025 16:38:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA721A424;
	Tue, 11 Feb 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291905; cv=none; b=nq5PtV1IxlufnN2fq3B2VevFnCVRrYg7datMbZn0Nbn8+q6VIhElVOiLTkZKLPNo/cfzTSwU9NdHwTQiM/NI5maUA+Ji0huQLJdLDHeWUeFuzVhDOliYJBnb4/zCNSqOx5ojBv+Xki/QWXQshuK/ibMIfgqmYENbYOXpM45nYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291905; c=relaxed/simple;
	bh=EH78O8RKXYsZb3sKsKknXs5y5E4YMKIVrAexeyvs1rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxpE7JmKhMJDd0IA0zljkyir3hSivgUrclN3CiPq4VxqC3kPAg3rE2HKWCAiTPI+noCT+mw4H11LYcx5WIusUniI3HMySvAX7j8CTSqTBdRHeDbukfKs2FaxAfGkWcandDjZZDHXuneKsW0vJrjgMqHit4P+tLF0yzHyoCYU8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA85AC4CEDD;
	Tue, 11 Feb 2025 16:38:22 +0000 (UTC)
Date: Tue, 11 Feb 2025 11:38:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, David
 Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <20250211113827.302fd066@gandalf.local.home>
In-Reply-To: <Z6tie5F-AkGkiV74@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
	<20250207211104.30009-6-arighi@nvidia.com>
	<Z6ju7vFK5TpJamn5@thinkpad>
	<Z6owBvYiArjXvIGC@thinkpad>
	<Z6r9H6JukZi19dQP@gpd3>
	<Z6r_NZui9GibrQHY@gpd3>
	<Z6sddk2otmAVrfcb@gpd3>
	<Z6tciKa58iqWZ3eM@thinkpad>
	<Z6tf3Rn0pamy3g1_@gpd3>
	<Z6tie5F-AkGkiV74@gpd3>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 15:45:15 +0100
Andrea Righi <arighi@nvidia.com> wrote:

> ...which is basically this (with GFP_ATOMIC):
> 
> [   11.829079] =============================
> [   11.829109] [ BUG: Invalid wait context ]
> [   11.829146] 6.13.0-virtme #51 Not tainted
> [   11.829185] -----------------------------
> [   11.829243] fish/344 is trying to lock:
> [   11.829285] ffff9659bec450b0 (&c->lock){..-.}-{3:3}, at: ___slab_alloc+0x66/0x1510
> [   11.829380] other info that might help us debug this:
> [   11.829450] context-{5:5}
> [   11.829494] 8 locks held by fish/344:
> [   11.829534]  #0: ffff965a409c70a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x60
> [   11.829643]  #1: ffff965a409c7130 (&tty->atomic_write_lock){+.+.}-{4:4}, at: file_tty_write.isra.0+0xa1/0x330
> [   11.829765]  #2: ffff965a409c72e8 (&tty->termios_rwsem/1){++++}-{4:4}, at: n_tty_write+0x9e/0x510
> [   11.829871]  #3: ffffbc6d01433380 (&ldata->output_lock){+.+.}-{4:4}, at: n_tty_write+0x1f1/0x510
> [   11.829979]  #4: ffffffffb556b5c0 (rcu_read_lock){....}-{1:3}, at: __queue_work+0x59/0x680
> [   11.830173]  #5: ffff9659800f0018 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0xd7/0x680
> [   11.830286]  #6: ffff9659801bcf60 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x56/0x920
> [   11.830396]  #7: ffffffffb556b5c0 (rcu_read_lock){....}-{1:3}, at: scx_select_cpu_dfl+0x56/0x460
> 
> And I think that's because:
> 
>  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
>  * watermark is applied to allow access to "atomic reserves".
>  * The current implementation doesn't support NMI and few other strict
>  * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
> 
> So I guess we the only viable option is to preallocate nodemask_t and
> protect it somehow, hoping that it doesn't add too much overhead...

I believe it's because you have p->pi_lock which is a raw_spin_lock() and
you are trying to take a lock in ___slab_alloc() which I bet is a normal
spin_lock(). In PREEMPT_RT() that turns into a mutex, and you can not take
a spin_lock while holding a raw_spin_lock.

-- Steve

