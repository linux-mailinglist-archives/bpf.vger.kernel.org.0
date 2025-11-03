Return-Path: <bpf+bounces-73363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B326C2D5B1
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 18:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7793A189E40A
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256A31B809;
	Mon,  3 Nov 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIB6Mk+z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38C31A81D;
	Mon,  3 Nov 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189326; cv=none; b=B9UYYF9jRT81esnQV/X9xfUoNtXYygTSHmo+4lJYvqaTsSbjhIjHbHmMjiuh5YaOv9zR+ZflPNof7eXU/KhX7CKnw57EBpJeVXLLd+etRYny4s/myL4mNbLr6rsjxy5NXsyDSyPeEekKBLU3jtz8xdoPrdN8vYHrSUaIUDE9P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189326; c=relaxed/simple;
	bh=z4bhIkeLe61YGtNnfKtyj+dwQB2OwI+pXpuaZfbsQts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/NU6i/LNmUNQMmJctPtBPiLaxN3TOT7WmCeJH2BlzM9ucrNdrn+rOSfeUzQxaX2HOp2Y0YL70KBnRIJWgw8bmnnl/vHe+wX4u/PLXzsKM7mpw/DmJPt7UWK3+y1pjxC1rVTYr1kTXsvvXwCAkkY7niNZlA/EtGI+dv5YZHSG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIB6Mk+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EC1C4CEE7;
	Mon,  3 Nov 2025 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189324;
	bh=z4bhIkeLe61YGtNnfKtyj+dwQB2OwI+pXpuaZfbsQts=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YIB6Mk+zbB+GuDbJ0vWKv4vitziT/ejEWmFLfRUmfVLCbHkCc1NoXbUQ8oUDIISbW
	 OXJnzt8GUPCdEfPwgjFVlp+q3Ey0IuWRWLoZ4jKpoqkVAkJYB7wkZVirI+P/T0gs1D
	 zczVjmrjN0XRrX1f0wHJcVNwPt5QBOk27UDLUfG52wRylaTiBLO+EVJGtAaZuiuoBz
	 x1xc4vd2DbaCB4HK2AweVplZg6GowNF6DcS1HSuCkioX7pDEJStFfU5wvE3vHPwrnl
	 xbCVvjZl4YCUbCIrIwQqVaAF7zn3C5GQBxFCXVdx5HheXwY2ZHhQDUnt4iWqfo4g94
	 +Mqb1OQrjIztQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 44EABCE0B94; Mon,  3 Nov 2025 09:02:02 -0800 (PST)
Date: Mon, 3 Nov 2025 09:02:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH 17/19] srcu: Optimize SRCU-fast-updown for arm64
Message-ID: <c598e85a-4008-4ca7-a424-80c324523bbb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
 <20251102214436.3905633-17-paulmck@kernel.org>
 <aQilZAXQv2P-b2eI@willie-the-truck>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQilZAXQv2P-b2eI@willie-the-truck>

On Mon, Nov 03, 2025 at 12:51:48PM +0000, Will Deacon wrote:
> Hi Paul,
> 
> On Sun, Nov 02, 2025 at 01:44:34PM -0800, Paul E. McKenney wrote:
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
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  include/linux/srcutree.h | 56 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 51 insertions(+), 5 deletions(-)
> 
> [...]
> 
> > @@ -327,12 +355,23 @@ __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> >  static inline
> >  struct srcu_ctr __percpu notrace *__srcu_read_lock_fast_updown(struct srcu_struct *ssp)
> >  {
> > -	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> > +	struct srcu_ctr __percpu *scp;
> >  
> > -	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> > +	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM64_USE_LSE_PERCPU_ATOMICS)) {
> > +		unsigned long flags;
> > +
> > +		local_irq_save(flags);
> > +		scp = __srcu_read_lock_fast_na(ssp);
> > +		local_irq_restore(flags); /* Avoids leaking the critical section. */
> > +		return scp;
> > +	}
> 
> Do we still need to pursue this after Catalin's prefetch suggestion for the
> per-cpu atomics?
> 
> https://lore.kernel.org/r/aQU7l-qMKJTx4znJ@arm.com
> 
> Although disabling/enabling interrupts on your system seems to be
> significantly faster than an atomic instruction, I'm worried that it's
> all very SoC-specific and on a mobile part (especially with pseudo-NMI),
> the relative costs could easily be the other way around.

In my testing Catalin's patch wins by at least 10% on microbenchmarks.
So I am holding this one in my back pocket just in case, but yes, you
should ignore it, hopefully forever.  ;-)

							Thanx, Paul

