Return-Path: <bpf+bounces-73999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB6C4337C
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 19:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049E8188D534
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B038F280A5B;
	Sat,  8 Nov 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1hLQWo9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27204236454;
	Sat,  8 Nov 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762627114; cv=none; b=RK0Lq6wTTyT9GEfCKN+dLt26hYX3BJQrVObX+eFqBvDuzZnEn5tgJuxEFvVF+BmU9mLU0D7gSvBdkac0jivEanVCYE6/x4knqFC4AiW9uQKoi8I3ySn2sN+NdlzLNu7LIdit0MLrPUpBnfZaLT15588kyDBD1CAtRInZlDtQO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762627114; c=relaxed/simple;
	bh=t3e7SIt0+zXbhtJv1BbHHXc8fxypkZN0DeRPDQUHafQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQwCMEoc0hvljknV+Rlc9htyelKvwoa6RsK6SOVpPMaVA4aAh2eZTA9wigkK5vn/BtQHCuUTnV2t3lePzjrsyFr5CHWOkMMC6taUuy95ixAWnhQhh6r69UGPUgj40MPCFRL90HTTY7hLrzghhbRdUeHvv65sdb4ZCb5VuJ+neq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1hLQWo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3C8C4CEFB;
	Sat,  8 Nov 2025 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762627113;
	bh=t3e7SIt0+zXbhtJv1BbHHXc8fxypkZN0DeRPDQUHafQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=S1hLQWo9OpsM4h7Qvv7OGWHH/FvfTZBcdvZr6BCrJPEev3bx53NZ65gLGVIGqNjSi
	 hDnVtVxMfF1Av8f+rtEAN6Z79VooIY90Ft+7PPVKdSBnV61CK1YGWzklvYbyT5y+Vn
	 c54iF3Y8y/Ie4mwws0ErfyzZUd0AOxGmI69tt+zAlCt8gmZWoTPR+hmi7honkrvSRP
	 Nn3WA/0re9nAo7gtq2rxyJhoz8kOKMNkU4dpoT1UlszQ/GHPsJwO0sUn8taG/Ww7Qp
	 30Gy2iVZBPmr66zawuEKwoVACvjvgqU2Ta9CAM3qTzxUQGNGJaH5YbzVbAqqYWmAS3
	 qlx2fckgUhBzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5BD38CE0BB3; Sat,  8 Nov 2025 10:38:32 -0800 (PST)
Date: Sat, 8 Nov 2025 10:38:32 -0800
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
Message-ID: <d53a5852-f84a-4dae-9bf4-312751880452@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-15-paulmck@kernel.org>
 <aQ9AoauJKLYeYvrn@willie-the-truck>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ9AoauJKLYeYvrn@willie-the-truck>

On Sat, Nov 08, 2025 at 01:07:45PM +0000, Will Deacon wrote:
> Hi Paul,
> 
> On Wed, Nov 05, 2025 at 12:32:15PM -0800, Paul E. McKenney wrote:
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
> >  include/linux/srcutree.h | 51 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> I've queued the per-cpu tweak from Catalin in the arm64 fixes tree [1]
> for 6.18, so please can you drop this SRCU commit from your tree?

Very good!  Adding Frederic on CC since he is doing the pull request
for the upcoming merge window.

But if this doesn't show up in -rc1, we reserve the right to put it
back in.

Sorry, couldn't resist!   ;-)

							Thanx, Paul

> Cheers,
> 
> Will
> 
> [1] https://git.kernel.org/arm64/c/535fdfc5a228

