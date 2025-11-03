Return-Path: <bpf+bounces-73364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C224FC2D623
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 18:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 425904F433E
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5DB319605;
	Mon,  3 Nov 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPLq8Qxj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AF25FA0A;
	Mon,  3 Nov 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189721; cv=none; b=V0EdzLrxZX/0EfWUNnytrjf7tSHcRyeRL5A1xvju9L4/TPNAJzRK4UWEHfVH2W30AdoVNrBDu7AXBr8pWvmpOhaPSmp4E4KNQ5LMRKajK+HsXVPNnEYzaD3pom9onZLMyVqGbk0V3LvGPNHKD7NNS7naLjQarJ8jDmKnVU32KIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189721; c=relaxed/simple;
	bh=nc9pwfo7tVhfkofi9WsCHyPsawYIqzmCCe2hZfm+ryk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg9AWKa8IR3wtkKhV+MYwffB9Cqw6FQU5G7AARy8fHnRB8zayKGFrEy30atb9pz7f+xFiI0VQhs+GDSWndmRrbAzdJocFs4lF5rGprUi/TItpxL7/pI0byMIhp+5TSRMKcimYGRLAhRRKECrdlmVe4kWWdMp5XMafph+MTx8fIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPLq8Qxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1FFC4CEFD;
	Mon,  3 Nov 2025 17:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189721;
	bh=nc9pwfo7tVhfkofi9WsCHyPsawYIqzmCCe2hZfm+ryk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NPLq8Qxjk5TF2XoJ3zCNnbZ8M1n51tjVIBvXcBq0DCmi75P9TiTP+gla/3+NQ6kIG
	 ec171K/lqcI/7q3+JNfTlBvy5eFF+tqfh6FiJEithvtCOfxDJ1P9KFV7X9SQy6R7wm
	 LLfCZGkKk5NNubTVqLPOHZI3QbET/7DHSJt/ayYOkswXKLJmkjEOD4SStXpJC/MMWX
	 n1Ls3fQRTAY2MRktVlxsEqKZnTCVpFkB/jSGbVb2W8I5CUq0ydnb1IjUY71U/dLOBK
	 wJUXvdfqTdj1ffixMOMeJlkD9CQSTvvjOYGgLd0zoO1u5ujBnxFQ/VLkINpSwZDcyA
	 bTLK6d+XFNUhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6772CE0B94; Mon,  3 Nov 2025 09:08:39 -0800 (PST)
Date: Mon, 3 Nov 2025 09:08:39 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH 17/19] srcu: Optimize SRCU-fast-updown for arm64
Message-ID: <f89a3a56-e48a-4975-b67b-9387fe2e48c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
 <20251102214436.3905633-17-paulmck@kernel.org>
 <b2fb5a99-8dc2-440b-bf52-1dbcf3d7d9a7@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fb5a99-8dc2-440b-bf52-1dbcf3d7d9a7@efficios.com>

On Mon, Nov 03, 2025 at 08:34:10AM -0500, Mathieu Desnoyers wrote:
> On 2025-11-02 16:44, Paul E. McKenney wrote:
> > Some arm64 platforms have slow per-CPU atomic operations, for example,
> > the Neoverse V2.  This commit therefore moves SRCU-fast from per-CPU
> > atomic operations to interrupt-disabled non-read-modify-write-atomic
> > atomic_read()/atomic_set() operations.  This works because
> > SRCU-fast-updown is not invoked from read-side primitives, which
> > means that if srcu_read_unlock_fast() NMI handlers.  This means that
> > srcu_read_lock_fast_updown() and srcu_read_unlock_fast_updown() can
> > exclude themselves and each other
> > 
> > This reduces the overhead of calls to srcu_read_lock_fast_updown() and
> > srcu_read_unlock_fast_updown() from about 100ns to about 12ns on an ARM
> > Neoverse V2.  Although this is not excellent compared to about 2ns on x86,
> > it sure beats 100ns.
> > 
> > This command was used to measure the overhead:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs NOPREEMPT --kconfig "CONFIG_NR_CPUS=64 CONFIG_TASKS_TRACE_RCU=y" --bootargs "refscale.loops=100000 refscale.guest_os_delay=5 refscale.nreaders=64 refscale.holdoff=30 torture.disable_onoff_at_boot refscale.scale_type=srcu-fast-updown refscale.verbose_batched=8 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=8 refscale.nruns=100" --trust-make
> > 
> Hi Paul,
> 
> At a high level, what are you trying to achieve with this ?

I am working around the high single-CPU cost of arm64 LSE instructions,
as in about 50ns per compared non-LSE of about 5ns per.  The 50ns rules
them out for uretprobes, for example.

But Catalin's later patch is in all ways better than mine, so I will be
keeping this one only until Catalin's hits mainline.  Once that happens,
I will revert this one the following merge window.  (It might be awhile
because of the testing required on a wide range of platforms.)

> AFAIU, you are trying to remove the cost of atomics on per-cpu
> data from srcu-fast read lock/unlock for frequent calls for
> CONFIG_NEED_SRCU_NMI_SAFE=y, am I on the right track ?
> 
> [disclaimer: I've looked only briefly at your proposed patch.]
> Then there are various other less specific approaches to consider
> before introducing such architecture and use-case specific work-around.
> 
> One example is the libside (user level) rcu implementation which uses
> two counters per cpu [1]. One counter is the rseq fast path, and the
> second counter is for atomics (as fallback).
> 
> If the typical scenario we want to optimize for is thread context, we
> can probably remove the atomic from the fast path with just preempt off
> by partitioning the per-cpu counters further, one possibility being:
> 
> struct percpu_srcu_fast_pair {
> 	unsigned long lock, unlock;
> };
> 
> struct percpu_srcu_fast {
> 	struct percpu_srcu_fast_pair thread;
> 	struct percpu_srcu_fast_pair irq;
> };
> 
> And the grace period sums both thread and irq counters.
> 
> Thoughts ?

One complication here is that we need srcu_down_read() at task level
and the matching srcu_up_read() at softirq and/or hardirq level.

Or am I missing a trick in your proposed implementation?

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> [1] https://github.com/compudj/libside/blob/master/src/rcu.h#L71
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

