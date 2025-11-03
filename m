Return-Path: <bpf+bounces-73379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C5C2DE21
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 20:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E0A422AE2
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 19:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705131E115;
	Mon,  3 Nov 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEeNuDTr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6231D74E;
	Mon,  3 Nov 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197473; cv=none; b=mcESlDDK8Z1uXxRZIhsA36G5GOAOuFQBZnXb+c2VPsguWw7ND8DGg3PtuQDkDzWXnBRR4ryCreRRyvsdtgmT3R1siq3dOEBLzy5+9pzuQ/i7r64zkhjHhLkE1mG9WMdgMYdFeoiJi6+adxn/p5WgTRsPWEmbr5NU4D5AsIkJass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197473; c=relaxed/simple;
	bh=hXuE1VBaSY3RKRgphu5e9Wa0Cavk7sH93K8Brpnelhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4PcaMG6u1YBi1F6veBHotmNwZGN+51N96SrUWxIHKdUivyzpv5tK37rp1gXc/y9SFr+JDGrK1GMJlZhrpgItO7PcR0J6z1SsTwRmRqSIihWlMq0uatoOCi7Yam9mZMvifPwK/SfNcL/+3QcSgMr4ovPY6r61s3tIZds5tb66KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEeNuDTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E071C4CEE7;
	Mon,  3 Nov 2025 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197471;
	bh=hXuE1VBaSY3RKRgphu5e9Wa0Cavk7sH93K8Brpnelhw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cEeNuDTr1SboNVPsjO50nf9fbgya3TROP191it+xMY0GC6SUqqkeZSHuss3m/OFW1
	 rWuRFnTf6Mtuv12qSlGbiD03Rq6E6Wl+7KYuRVNdmNBhzsiusb0GHv5PitEUvqhEez
	 ZyprsnZuAHp8MVZ154qU3gCMzqvr7gHvnqhNMRTqvyO2zW2MynDG2+nuS2pdRtOaFv
	 +Yrem4yAAvxN9aMqqfUjCl2+Dd0xypZgu6aGCE619PdS9s8BGK5GrR/jSfEJjwIm4f
	 ACmB5v7t7iTvrEwgQYkzl+rek4TUUJ5lYi7WE+1NEjtwZ+t1rPIb8rmdj9HhuKs6MI
	 BKre6jda/c4bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4330ACE0BB3; Mon,  3 Nov 2025 11:17:50 -0800 (PST)
Date: Mon, 3 Nov 2025 11:17:50 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH 17/19] srcu: Optimize SRCU-fast-updown for arm64
Message-ID: <8a33bf08-8ca4-4fc1-9481-fff2247e5518@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
 <20251102214436.3905633-17-paulmck@kernel.org>
 <b2fb5a99-8dc2-440b-bf52-1dbcf3d7d9a7@efficios.com>
 <f89a3a56-e48a-4975-b67b-9387fe2e48c6@paulmck-laptop>
 <7cdecba1-2b30-4296-9862-3dd7bcc013d8@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cdecba1-2b30-4296-9862-3dd7bcc013d8@efficios.com>

On Mon, Nov 03, 2025 at 01:16:23PM -0500, Mathieu Desnoyers wrote:
> On 2025-11-03 12:08, Paul E. McKenney wrote:
> > On Mon, Nov 03, 2025 at 08:34:10AM -0500, Mathieu Desnoyers wrote:
> [...]
> 
> > > One example is the libside (user level) rcu implementation which uses
> > > two counters per cpu [1]. One counter is the rseq fast path, and the
> > > second counter is for atomics (as fallback).
> > > 
> > > If the typical scenario we want to optimize for is thread context, we
> > > can probably remove the atomic from the fast path with just preempt off
> > > by partitioning the per-cpu counters further, one possibility being:
> > > 
> > > struct percpu_srcu_fast_pair {
> > > 	unsigned long lock, unlock;
> > > };
> > > 
> > > struct percpu_srcu_fast {
> > > 	struct percpu_srcu_fast_pair thread;
> > > 	struct percpu_srcu_fast_pair irq;
> > > };
> > > 
> > > And the grace period sums both thread and irq counters.
> > > 
> > > Thoughts ?
> > 
> > One complication here is that we need srcu_down_read() at task level
> > and the matching srcu_up_read() at softirq and/or hardirq level.
> > 
> > Or am I missing a trick in your proposed implementation?
> 
> I think you are indeed missing the crux of the solution here.
> 
> Each of task level and soft/hard irq level increments will be
> dispatched into different counters (thread vs irq). But the
> grace period will sum, for each the the two periods one after the
> next, the unlock counts and then the lock counts. It will consider
> the period as quiescent if the delta between the two sums is zero,
> e.g.
> 
>   (count[period].irq.unlock + count[period].thread.unlock -
>    count[period].irq.lock - count[period].thread.lock) == 0
> 
> so the sum does not care how the counters were incremented
> (it just does a load-relaxed), but each counter category
> have its own way of dealing with concurrency (thread: percpu
> ops, irq: atomics).
> 
> This is effectively a use of split-counters, but the split
> is across concurrency handling mechanisms rather than across
> CPUs.

Ah, got it, thank you!  But we would need an additional softirq counter,
correct?

I will keep this in my back pocket in case Catalin's and Yicong's prefetch
trick turns out to be problematic, and again, thank you!

							Thanx, Paul

