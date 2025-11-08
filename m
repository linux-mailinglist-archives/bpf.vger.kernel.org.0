Return-Path: <bpf+bounces-73997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12FC42D20
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 14:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB4EE349144
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271519067C;
	Sat,  8 Nov 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7D+tM5k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BE34D3A9;
	Sat,  8 Nov 2025 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762607271; cv=none; b=uujAV4pFV5nmTPYyqI3zLyPMJkl4g3FyBDMm9xGZ9/k5riJO5JFei87r04MS7PudtPV0XQmRc16tlOAa5xNrmBSxQf5XMwU+VYNrBPP3y21DXBa6Ck9TPkgor0aCgYL79kS0xwI3V/j5VYSYe04i8nWd25eFl/GzhXjqLzPNIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762607271; c=relaxed/simple;
	bh=i7HXPTYeK+e+Jl5vz+u8MqxdLo1lCA/B25zaKUgWUkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH7GbVMa7n6FAlqs9FAvGBQfs9GNwQf5g/qQQZts3B38BMdozkDnSGFT1zPTIpy4btR8OUyqiZiSbXLCLmfKpU1SyH7mQIEK4HKwoSPfW32HLYihWhBNo1flsdhu3TX9Aw1Uc+cfE61K3npx2dj0a+TPHUGQ8p1FeYBtX4Ii4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7D+tM5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E95EC4CEF7;
	Sat,  8 Nov 2025 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762607271;
	bh=i7HXPTYeK+e+Jl5vz+u8MqxdLo1lCA/B25zaKUgWUkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7D+tM5kRH+NjazgLU1QcpEGK3MSiun+xEIGRss4cHMEJkPH+dAAG9aWL0+Ni/kzp
	 tdgB8qNQ/5v8GCWh/yvzGxkmtXcLRIZPeEurA0js5LUFoZR/s/5Ql1kIfFWoAFIXVa
	 7xLE/8CefNRlBnOVhFRWSP5mkIpzN3q4JwW7x6qPwc216NOTGhKbv1gs9U492MMFl+
	 UCXxdzRBNa+58S/xIxPrtUkKQK8lKxoE467ijgeeYg/uJItdpy0C+EzqiY7umw00zf
	 L7lketTeGJhxeWsBRGZjEYkqlMumv2nPYEWkrMiQTtzV98m6hmshhuMkN38ko+wC/O
	 jEl8eGclEP93w==
Date: Sat, 8 Nov 2025 13:07:45 +0000
From: Will Deacon <will@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 15/16] srcu: Optimize SRCU-fast-updown for arm64
Message-ID: <aQ9AoauJKLYeYvrn@willie-the-truck>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-15-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105203216.2701005-15-paulmck@kernel.org>

Hi Paul,

On Wed, Nov 05, 2025 at 12:32:15PM -0800, Paul E. McKenney wrote:
> Some arm64 platforms have slow per-CPU atomic operations, for example,
> the Neoverse V2.  This commit therefore moves SRCU-fast from per-CPU
> atomic operations to interrupt-disabled non-read-modify-write-atomic
> atomic_read()/atomic_set() operations.  This works because
> SRCU-fast-updown is not invoked from read-side primitives, which
> means that if srcu_read_unlock_fast() NMI handlers.  This means that
> srcu_read_lock_fast_updown() and srcu_read_unlock_fast_updown() can
> exclude themselves and each other
> 
> This reduces the overhead of calls to srcu_read_lock_fast_updown() and
> srcu_read_unlock_fast_updown() from about 100ns to about 12ns on an ARM
> Neoverse V2.  Although this is not excellent compared to about 2ns on x86,
> it sure beats 100ns.
> 
> This command was used to measure the overhead:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs NOPREEMPT --kconfig "CONFIG_NR_CPUS=64 CONFIG_TASKS_TRACE_RCU=y" --bootargs "refscale.loops=100000 refscale.guest_os_delay=5 refscale.nreaders=64 refscale.holdoff=30 torture.disable_onoff_at_boot refscale.scale_type=srcu-fast-updown refscale.verbose_batched=8 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=8 refscale.nruns=100" --trust-make
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/srcutree.h | 51 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)

I've queued the per-cpu tweak from Catalin in the arm64 fixes tree [1]
for 6.18, so please can you drop this SRCU commit from your tree?

Cheers,

Will

[1] https://git.kernel.org/arm64/c/535fdfc5a228

