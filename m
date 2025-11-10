Return-Path: <bpf+bounces-74091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A3C4855E
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE83F188CCD5
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E6D2C0263;
	Mon, 10 Nov 2025 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4OHUePh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C485283682;
	Mon, 10 Nov 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795784; cv=none; b=TvSui1LXQRuiIHWu9XR98bYe9lmXmMHWCUmUqyRiwmK+57zrnEJwEgCtnY/fZZci8LIV5mPCrePE98CB7nnxR+LfCz0HEV3OpYrUAcCiW2T+j476dBs0yYBw6CrDzbNKruFxhZ3htTmqGdO85VxHSmuFCcqlcxsZVCfiqKo8fLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795784; c=relaxed/simple;
	bh=irSNmNU33uoNE+xtcXh4F9V8GNWZBQMnuLEnS4K0yYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhgHTEzdQ9CfkcwKJNcRuZT1DkrYD/r5EhdkqmjYbJZuNtgEzkQk3SDz3izGrxN0Te545aDSz5P+xsTAQtN1az6I2iFJovgnJTVdeqqDsVbWxP7+rWUkWbSBwh+tBsJOLFzoECoAUKTGQBvuSuMblLerPR1Is8ixGSvfErlTRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4OHUePh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEEFC4CEF5;
	Mon, 10 Nov 2025 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762795784;
	bh=irSNmNU33uoNE+xtcXh4F9V8GNWZBQMnuLEnS4K0yYc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=K4OHUePh1JIsul5wTckByN1KX/imTS4vSvdMW+PZoScGRsl31xGewJCuQm6s4E0KS
	 z7oXMfRhvjcoC+Zbm98jZBfe/DoOaIA08oq9qGMG5jbZh/+/UZOcV+EGk2M1E6Pt+l
	 N6SktXEKUtDTREzGJDNVPwrSwOhfB/tMIz/HygZvk2TXZ2wS+WQifhL1PJF+++YNyj
	 QLEB+vHDw17Lcm8XEHxe9XytipxMSKEU+fdg5egk2S/sBK0+s2tgVbPy6wxclE1Ial
	 LJh2kNZZQqQVx8Bf8xixbBuKug/ddARm23lNi8DvLONJLIlQW9JsKWfgNFfjIapzDp
	 gU7fYw5Qdmehg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B6DECE0D0D; Mon, 10 Nov 2025 09:29:43 -0800 (PST)
Date: Mon, 10 Nov 2025 09:29:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	frederic@kernel.org
Subject: Re: [PATCH v2 15/16] srcu: Optimize SRCU-fast-updown for arm64
Message-ID: <ab6cd1c2-39c5-4b39-9585-6123835a6229@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-15-paulmck@kernel.org>
 <aQ9AoauJKLYeYvrn@willie-the-truck>
 <d53a5852-f84a-4dae-9bf4-312751880452@paulmck-laptop>
 <aRHLV8lLX0fxQICR@willie-the-truck>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHLV8lLX0fxQICR@willie-the-truck>

On Mon, Nov 10, 2025 at 11:24:07AM +0000, Will Deacon wrote:
> On Sat, Nov 08, 2025 at 10:38:32AM -0800, Paul E. McKenney wrote:
> > On Sat, Nov 08, 2025 at 01:07:45PM +0000, Will Deacon wrote:
> > > On Wed, Nov 05, 2025 at 12:32:15PM -0800, Paul E. McKenney wrote:
> > > > Some arm64 platforms have slow per-CPU atomic operations, for example,
> > > > the Neoverse V2.  This commit therefore moves SRCU-fast from per-CPU
> > > > atomic operations to interrupt-disabled non-read-modify-write-atomic
> > > > atomic_read()/atomic_set() operations.  This works because
> > > > SRCU-fast-updown is not invoked from read-side primitives, which
> > > > means that if srcu_read_unlock_fast() NMI handlers.  This means that
> > > > srcu_read_lock_fast_updown() and srcu_read_unlock_fast_updown() can
> > > > exclude themselves and each other
> > > > 
> > > > This reduces the overhead of calls to srcu_read_lock_fast_updown() and
> > > > srcu_read_unlock_fast_updown() from about 100ns to about 12ns on an ARM
> > > > Neoverse V2.  Although this is not excellent compared to about 2ns on x86,
> > > > it sure beats 100ns.
> > > > 
> > > > This command was used to measure the overhead:
> > > > 
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs NOPREEMPT --kconfig "CONFIG_NR_CPUS=64 CONFIG_TASKS_TRACE_RCU=y" --bootargs "refscale.loops=100000 refscale.guest_os_delay=5 refscale.nreaders=64 refscale.holdoff=30 torture.disable_onoff_at_boot refscale.scale_type=srcu-fast-updown refscale.verbose_batched=8 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=8 refscale.nruns=100" --trust-make
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > > Cc: <bpf@vger.kernel.org>
> > > > ---
> > > >  include/linux/srcutree.h | 51 +++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 48 insertions(+), 3 deletions(-)
> > > 
> > > I've queued the per-cpu tweak from Catalin in the arm64 fixes tree [1]
> > > for 6.18, so please can you drop this SRCU commit from your tree?
> > 
> > Very good!  Adding Frederic on CC since he is doing the pull request
> > for the upcoming merge window.
> > 
> > But if this doesn't show up in -rc1, we reserve the right to put it
> > back in.
> > 
> > Sorry, couldn't resist!   ;-)
> 
> I've merged it as a fix, so hopefully it will show up in v6.18-rc6.

Even better, thank you!!!

							Thanx, Paul

