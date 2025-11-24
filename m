Return-Path: <bpf+bounces-75398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FCC82BB9
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD06A34B825
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D502EB86A;
	Mon, 24 Nov 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgc6Wl7a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9EA944;
	Mon, 24 Nov 2025 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024458; cv=none; b=nJ8VKwjXwu0XZiauWK37J2C1qA5tInhltQ4dJYD0CWpzrDXBpXBYf6JhemhZ60el6GNR7VKEstdGEf77CnZkUG5zZ9R4/mGswGHL9feI/j/CEuM0jqCGUEQ8Ljnp7pdlJKdop4QYiYXiPUmyc5nXz3ga4YnReQjhkTn8o1ctnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024458; c=relaxed/simple;
	bh=2wy8ehXzr9jvFTSWp5rIJ9UVgYX28BfvWePNf2TNPXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdOqRxuRtywWhn3mroYYlhQ1N5dqRZsiLepQg1i7EXDQ7/f6XQjKk4gTIhhqrLCsWoraKWUqxFE2jjyC/qi9qV8336/hXRRREaQ8XO4lFmx6g2FYMcNZxOC92bPZjR8sJwFcLKRLwnUqI+os7U6EHx61REJTNRyDIP2Vu1vDrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgc6Wl7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D94C4CEF1;
	Mon, 24 Nov 2025 22:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764024458;
	bh=2wy8ehXzr9jvFTSWp5rIJ9UVgYX28BfvWePNf2TNPXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qgc6Wl7aaPK5/FaCkyrpsXlSpoMlG/loLGZakm6F7R/Avo/8iLoiyZ9fxVQpSlG9z
	 oCtri/77Aw2AgHimvGWZmU38fkY5E1Fl+N3XqFftGKXG0bm7r1hAD3H4k0aq8isnxf
	 EZh4reQ/TZs8uWbsdLFkioZ/0ohC0M6uiWczaG/Xgc0jtlT2wMdczPyXl5LeQuqCXU
	 62d9EjQa+SPj8DzsRnXQSaXlb5px6GCu8dCV+QUca9b33WycMwa0zspke6DBt6/fkL
	 /KN6Ts77sXkz5XtubqTfCDeQZ+2KmzwratNuYN4FhmWDXlxIr5h0CoMv2pBhuflKKA
	 b7U0Bq1vElYYA==
Date: Mon, 24 Nov 2025 23:47:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 15/16] srcu: Optimize SRCU-fast-updown for arm64
Message-ID: <aSTgh8B0SiKz2t5c@pavilion.home>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-15-paulmck@kernel.org>
 <aQ9AoauJKLYeYvrn@willie-the-truck>
 <d53a5852-f84a-4dae-9bf4-312751880452@paulmck-laptop>
 <aRHLV8lLX0fxQICR@willie-the-truck>
 <ab6cd1c2-39c5-4b39-9585-6123835a6229@paulmck-laptop>
 <aSRX1HKNdks5pHsd@willie-the-truck>
 <c632fb32-dccb-4c61-9b2e-d0c2b55fb2e4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c632fb32-dccb-4c61-9b2e-d0c2b55fb2e4@paulmck-laptop>

Le Mon, Nov 24, 2025 at 09:20:25AM -0800, Paul E. McKenney a écrit :
> On Mon, Nov 24, 2025 at 01:04:20PM +0000, Will Deacon wrote:
> > On Mon, Nov 10, 2025 at 09:29:43AM -0800, Paul E. McKenney wrote:
> > > On Mon, Nov 10, 2025 at 11:24:07AM +0000, Will Deacon wrote:
> > > > On Sat, Nov 08, 2025 at 10:38:32AM -0800, Paul E. McKenney wrote:
> > > > > On Sat, Nov 08, 2025 at 01:07:45PM +0000, Will Deacon wrote:
> > > > > > On Wed, Nov 05, 2025 at 12:32:15PM -0800, Paul E. McKenney wrote:
> > > > > > > Some arm64 platforms have slow per-CPU atomic operations, for example,
> > > > > > > the Neoverse V2.  This commit therefore moves SRCU-fast from per-CPU
> > > > > > > atomic operations to interrupt-disabled non-read-modify-write-atomic
> > > > > > > atomic_read()/atomic_set() operations.  This works because
> > > > > > > SRCU-fast-updown is not invoked from read-side primitives, which
> > > > > > > means that if srcu_read_unlock_fast() NMI handlers.  This means that
> > > > > > > srcu_read_lock_fast_updown() and srcu_read_unlock_fast_updown() can
> > > > > > > exclude themselves and each other
> > > > > > > 
> > > > > > > This reduces the overhead of calls to srcu_read_lock_fast_updown() and
> > > > > > > srcu_read_unlock_fast_updown() from about 100ns to about 12ns on an ARM
> > > > > > > Neoverse V2.  Although this is not excellent compared to about 2ns on x86,
> > > > > > > it sure beats 100ns.
> > > > > > > 
> > > > > > > This command was used to measure the overhead:
> > > > > > > 
> > > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs NOPREEMPT --kconfig "CONFIG_NR_CPUS=64 CONFIG_TASKS_TRACE_RCU=y" --bootargs "refscale.loops=100000 refscale.guest_os_delay=5 refscale.nreaders=64 refscale.holdoff=30 torture.disable_onoff_at_boot refscale.scale_type=srcu-fast-updown refscale.verbose_batched=8 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=8 refscale.nruns=100" --trust-make
> > > > > > > 
> > > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > > > Cc: Will Deacon <will@kernel.org>
> > > > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > > > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > > > > > Cc: <bpf@vger.kernel.org>
> > > > > > > ---
> > > > > > >  include/linux/srcutree.h | 51 +++++++++++++++++++++++++++++++++++++---
> > > > > > >  1 file changed, 48 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > I've queued the per-cpu tweak from Catalin in the arm64 fixes tree [1]
> > > > > > for 6.18, so please can you drop this SRCU commit from your tree?
> > > > > 
> > > > > Very good!  Adding Frederic on CC since he is doing the pull request
> > > > > for the upcoming merge window.
> > > > > 
> > > > > But if this doesn't show up in -rc1, we reserve the right to put it
> > > > > back in.
> > > > > 
> > > > > Sorry, couldn't resist!   ;-)
> > > > 
> > > > I've merged it as a fix, so hopefully it will show up in v6.18-rc6.
> > > 
> > > Even better, thank you!!!
> > 
> > It landed in Linus' tree here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64?id=535fdfc5a228524552ee8810c9175e877e127c27
> 
> Again, thank you, and Breno has started backporting it for use in
> our fleet.
> 
> > Please can you drop the SRCU change from -next? It still shows up in
> > 20251121.
> 
> This one?
> 
> 11f748499236 ("srcu: Optimize SRCU-fast-updown for arm64")
> 
> if so, Frederic, could you please drop this commit?

Dropped, thanks!

(And I'm glad to do so given how error-prone it can be).

-- 
Frederic Weisbecker
SUSE Labs

