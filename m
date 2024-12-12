Return-Path: <bpf+bounces-46716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158949EEF44
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C193D294A1E
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C82288FD;
	Thu, 12 Dec 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zDCmuVT8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfpVSuwg"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3221766D
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019214; cv=none; b=Z3EjFud09wM7ig/TZMJYHmrsF/MHzXtV/0W7FMU1a3zoHdq49IDZ7yCOVEfQrYa1TA7Tu5fqWbCzK2Ve5jrXQ+J2C9ck+muwN13/cKQeB8/BM+/P+z53FHlfztRdNxFay7+i0f+5Dyb06Yn2mWoFTEl5HstFZdRafk1eis1OLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019214; c=relaxed/simple;
	bh=ICJ+S+1qM6mvzE1JgOHP9eIvy65HW0ixwHu8nwlDaGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/UxIjKJopFPqulRmyHfoxaxYoYdoMkINs2iSi58FIshNhA/JqXaW0bHvRa+IjCQTtVf8/72rn4i+XFURXlQeicP3Wz3ynfK6ZNNW7mXoGGa7LwzBZskZYj23VTSktFu51jLki8AfCqu5JG7TIPCib24GB7WUuFUz/lLyFHxbng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zDCmuVT8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfpVSuwg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Dec 2024 17:00:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734019211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICJ+S+1qM6mvzE1JgOHP9eIvy65HW0ixwHu8nwlDaGw=;
	b=zDCmuVT8/UT/IrU94t9gYBsobMNwPcF2i0hWDsl30ECnZtAxiB7keIuH6AdntoBKkpJz8G
	zPju/ybt8amr7zrgXNRBMT2jI1zSd0OnafdrfhEGKnLmnRymmJ7xzFxSWJXWXPAmmz9REn
	ixUGOJav30VMEjYrp81/6siIqJd+bijJq4Z5NHdQfYTh6QNkWXWlaZ+LSBxy/o8v4Uk91y
	2bnyGCU1pt9PWPtW8B7S8tEpZpxMalpYabzKZSl3InKVlW5imo1jnGpMs7LQHYUdEF0bYd
	t/iVHGo4osClkantGT0vd6uITBM3b/b39o7W/JLZkmngvgzIi4ohvYzy371NVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734019211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICJ+S+1qM6mvzE1JgOHP9eIvy65HW0ixwHu8nwlDaGw=;
	b=PfpVSuwgHv1e0r+1UiUxh2mx2ck7r8dlJePxZAhnaplekTYqDrvFB5nI9+7x1t//Ub3UQU
	k+sh1fPmFK2HwfDw==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241212160009.O3lGzN95@linutronix.de>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka>
 <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
 <20241212150744.dVyycFUJ@linutronix.de>
 <Z1r_eKGkJYMz-uwH@tiehlicka>
 <20241212153506.dT1MvukO@linutronix.de>
 <20241212104809.1c6cb0a1@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241212104809.1c6cb0a1@batman.local.home>

On 2024-12-12 10:48:09 [-0500], Steven Rostedt wrote:
> On Thu, 12 Dec 2024 16:35:06 +0100
> Sebastian Sewior <bigeasy@linutronix.de> wrote:
>=20
> > If NMI is one of the possible calling contexts, yes.
> >=20
> > One thing I am not 100% sure about is how "good" a spinlock_t trylock is
> > if attempted from hardirq (on PREEMPT_RT). Obtaining the lock und
> > unlocking is doable. The lock part will assign the "current" task as the
> > task that owns the lock now. This task is just randomly on the CPU while
> > the hardirq triggered. The regular spin_lock() will see this random task
> > as the owner and might PI-boost it. This could work=E2=80=A6
>=20
> Looking at the unlock code, it and the slowtrylock() appears to use
> raw_spin_lock_irqsave(). Hence it expects that it can be called from
> irq disabled context. If it can be used in interrupt disabled context,
> I don't see why it wouldn't work in actual interrupt context.

trylock records current as owner. This task did not attempt to acquire
the lock.
The lock part will might PI-boost it via task_blocks_on_rt_mutex() -
this random task. That task might already wait on one lock and now this
gets added to the mix.
This could be okay since a task can own multiple locks, wait on one and
get PI boosted on any of those at any time.
However, we never used that way.

The lockig of the raw_spinlock_t has irqsave. Correct. But not because
it expects to be called in interrupt disabled context or an actual
interrupt. It was _irq() but got changed because it is used in the early
init code and would unconditionally enable interrupts which should
remain disabled.

> -- Steve

Sebastian

