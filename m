Return-Path: <bpf+bounces-74058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D770C46390
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 12:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505B01890079
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F67C30BF77;
	Mon, 10 Nov 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTdtQjEL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72A3074BA;
	Mon, 10 Nov 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773853; cv=none; b=eLi1jp9N+CCyzSxEaVsJu3sMGsTmVFMyym6fH/K8vTD/+MDqL5lKx2Dos0HFT5kEymPgGtf3HUQNw9ZKOPvgjOB/Oc5zLaKe3K5C8OHMIK9U454oeU9y36jtOyuhtUk7AQUyMfJejb/lr9h1pXABqad07VK/ssLHP9NqUDmxEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773853; c=relaxed/simple;
	bh=CNw1030aR0tDxXS19BWbvMOxPaKDJmkacafLyOuVbFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMqTQ71yl1/LlRU8XrI8kQOTqtTXSLF3Nr9leFFNiRqS/wZi2UVYdlsOuYAMGLpdFfo1Vqb0RBCv0jJV+2SmN4kDVSy/vzKCqja5/HNP9DxkNH+ScaM1P5bZa3KYIwgvcYnmcEY1ZVxJsPiGdFmxnoT8X0RskipWF3/Y4IBdwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTdtQjEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E86FC4CEF5;
	Mon, 10 Nov 2025 11:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773852;
	bh=CNw1030aR0tDxXS19BWbvMOxPaKDJmkacafLyOuVbFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTdtQjELkr4GX/ZycI2Ayz0hg0oy2xF/1KCasnHySwd7gCP6RbWQw32/n2zLOXRyP
	 0kHFhjI1HYgbL8AAIbJ46FRzOAVryTDncE2F2iJCl9xg0HkDyIRqOcwA8pPhyQ3ofR
	 ixkCHORdmGkGGh5PgOf3BzJD7VjmfVOLWncuWnhdtTq65x03YUkzLO5JZfOlRNkmB1
	 Yr6WMfu3ePAQ1T05ZDScTeHVID2ChAmcLBGSD818nMjXPfrB1Lu3bggWqZI9nh9EAB
	 Nho9e08elCIMOat0uaiXOJ7NvONrj17HK3aJ30a902qG8GE1Sy/bRIdP4ZStgPtkja
	 7egpFYeX9f6mQ==
Date: Mon, 10 Nov 2025 11:24:07 +0000
From: Will Deacon <will@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	frederic@kernel.org
Subject: Re: [PATCH v2 15/16] srcu: Optimize SRCU-fast-updown for arm64
Message-ID: <aRHLV8lLX0fxQICR@willie-the-truck>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-15-paulmck@kernel.org>
 <aQ9AoauJKLYeYvrn@willie-the-truck>
 <d53a5852-f84a-4dae-9bf4-312751880452@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53a5852-f84a-4dae-9bf4-312751880452@paulmck-laptop>

On Sat, Nov 08, 2025 at 10:38:32AM -0800, Paul E. McKenney wrote:
> On Sat, Nov 08, 2025 at 01:07:45PM +0000, Will Deacon wrote:
> > On Wed, Nov 05, 2025 at 12:32:15PM -0800, Paul E. McKenney wrote:
> > > Some arm64 platforms have slow per-CPU atomic operations, for example,
> > > the Neoverse V2.  This commit therefore moves SRCU-fast from per-CPU
> > > atomic operations to interrupt-disabled non-read-modify-write-atomic
> > > atomic_read()/atomic_set() operations.  This works because
> > > SRCU-fast-updown is not invoked from read-side primitives, which
> > > means that if srcu_read_unlock_fast() NMI handlers.  This means that
> > > srcu_read_lock_fast_updown() and srcu_read_unlock_fast_updown() can
> > > exclude themselves and each other
> > > 
> > > This reduces the overhead of calls to srcu_read_lock_fast_updown() and
> > > srcu_read_unlock_fast_updown() from about 100ns to about 12ns on an ARM
> > > Neoverse V2.  Although this is not excellent compared to about 2ns on x86,
> > > it sure beats 100ns.
> > > 
> > > This command was used to measure the overhead:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs NOPREEMPT --kconfig "CONFIG_NR_CPUS=64 CONFIG_TASKS_TRACE_RCU=y" --bootargs "refscale.loops=100000 refscale.guest_os_delay=5 refscale.nreaders=64 refscale.holdoff=30 torture.disable_onoff_at_boot refscale.scale_type=srcu-fast-updown refscale.verbose_batched=8 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=8 refscale.nruns=100" --trust-make
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > Cc: <bpf@vger.kernel.org>
> > > ---
> > >  include/linux/srcutree.h | 51 +++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 48 insertions(+), 3 deletions(-)
> > 
> > I've queued the per-cpu tweak from Catalin in the arm64 fixes tree [1]
> > for 6.18, so please can you drop this SRCU commit from your tree?
> 
> Very good!  Adding Frederic on CC since he is doing the pull request
> for the upcoming merge window.
> 
> But if this doesn't show up in -rc1, we reserve the right to put it
> back in.
> 
> Sorry, couldn't resist!   ;-)

I've merged it as a fix, so hopefully it will show up in v6.18-rc6.

Will

