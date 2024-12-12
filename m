Return-Path: <bpf+bounces-46708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265369EEA45
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 16:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D608188D4B0
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEA5215F48;
	Thu, 12 Dec 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGaZYc/e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7d6kHi/3"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7992156EA
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016069; cv=none; b=BOKho3Qz5uvikOE3qAIqkPh2XGrv99XWyO5trL2DtwdQAyH98+xEhnUmRszI0rcUrlASWu+jljZWqfpwS6Fc31Y/e/XDvD5sxNf1bRV3QLOYRcKKfYRjWVqyR5v+Z6yo9bgbDAEGb6WwER9RxENAFkzNivjqCoWFywxYxaDqb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016069; c=relaxed/simple;
	bh=DZby7l1d9k2K1tcVsiNHGreMGm/ww2XeHJ2/aXTVnTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9hVbCf4Cdf3ErBtDOBTWL9wDmj0/TA/0+GC/5TKeaSxK62+vYyWMkTFNrApohkA1iPT1k0tsMZpuCLu+uPepuv/jTUHToMk/mzL5lIhDfuovuHs8TUOHql/W4LW1WCASLvVBcEcDEsEkYZY0IjrbC6I13Pe8/2ft8nsqyrroxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGaZYc/e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7d6kHi/3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Dec 2024 16:07:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734016065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eY305dc3rE3qvXpFds78ml1gx5qsrQHsdU//zOdN308=;
	b=lGaZYc/ev1Oxhb+h7Qhy6vhaJHJpEpMIurB9thL6gwpbSvgiHJ+WPjpdWZdHi/u9HYI/ut
	26I+2rseH5/wHn3VnCYnYWXeaEWX+BbcX33CC8d3uiyaHEF+D6VJfps12VJj32IkvS6MHd
	UZfiRCuu6x4SbrG38+eBLtXTxMfRT9F6QWbEkSpSTc49gjnfMLfbWhRO/TWUQKA2reqZnF
	IDJhmjh4K+bM96gdQNgcmugT1mQUbZuu+iNkJyHpMhTCSEXQTLPWQA/+sYrWis//MR5Hrt
	pSRrSpi/+C7TEI4VhO6qfC9n7X7vj4Kjy2bqFzSIjxt2esHYZCRSvRf8dxU4Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734016065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eY305dc3rE3qvXpFds78ml1gx5qsrQHsdU//zOdN308=;
	b=7d6kHi/3PRl0sVZ1/mDjhi0ZH5pVm9hDbqJAoxWDp0wJOp6Fh8kXlNzsaAhsJ9X0GlnsOu
	GPJJdsE3kiU1ooAw==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241212150744.dVyycFUJ@linutronix.de>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka>
 <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>

On 2024-12-10 14:06:32 [-0800], Alexei Starovoitov wrote:
> > Is there any reason why GFP_ATOMIC cannot be extended to support new
> > contexts? This allocation mode is already documented to be usable from
> > atomic contexts except from NMI and raw_spinlocks. But is it feasible to
> > extend the current implementation to use only trylock on zone->lock if
> > called from in_nmi() to reduce unexpected failures on contention for
> > existing users?
> 
> No. in_nmi() doesn't help. It's the lack of reentrance of slab and page
> allocator that is an issue.
> The page alloctor might grab zone lock. In !RT it will disable irqs.
> In RT will stay sleepable. Both paths will be calling other
> kernel code including tracepoints, potential kprobes, etc
> and bpf prog may be attached somewhere.
> If it calls alloc_page() it may deadlock on zone->lock.
> pcpu lock is thankfully trylock already.
> So !irqs_disabled() part of preemptible() guarantees that
> zone->lock won't deadlock in !RT.
> And rcu_preempt_depth() case just steers bpf into try lock only path in RT.
> Since there is no way to tell whether it's safe to call
> sleepable spin_lock(&zone->lock).

Oh. You don't need to check rcu_preempt_depth() for that. On PREEMPT_RT
rcu_preempt_depth() is incremented with every spin_lock() because we
need an explicit start of a RCU section (same thing happens with
preempt_disable() spin_lock()). If there is already a RCU section
(rcu_preempt_depth() > 0) you can still try to acquire a spinlock_t and
maybe schedule out/ sleep. That is okay.

But since I see in_nmi(). You can't trylock from NMI on RT. The trylock
part is easy but unlock might need to acquire rt_mutex_base::wait_lock
and worst case is to wake a waiter via wake_up_process().

Sebastian

