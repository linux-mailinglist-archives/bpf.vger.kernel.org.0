Return-Path: <bpf+bounces-78590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16693D13AE4
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6A5E3001619
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7CE35E54C;
	Mon, 12 Jan 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jjNVCcCQ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BC35E52C;
	Mon, 12 Jan 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231905; cv=none; b=XxK3NryZ0e+Nz1H8rt8tkJRwSSs+ac89bm2rc2jwJXcWyi+l9SN/KPx2SBwHkdg+NylM1be/sKeWOhWLdKLc4jesUqEpNbfRU3lV8h6NjTGdSZm6RyLVpGTk3MngNJrCH1intPVHlYVxiGldnNU56VIjwVCQAvE633Ms6Vne4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231905; c=relaxed/simple;
	bh=iNuKlYergc1Qti4EM+/2W5oSqvu/mQWpHDVVV2PTmlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSlleohkIiJK77RkVgaR5oq8TtAOY/BLmoPb++D3dGdyVUGTCwQR5VjX2Skv8E3MQQSuo5tUq9FFSAHhWy5+4t6P4Yz+7e3syP+QZ01A6lkU0U6EP68TEukz7ednXegPjhuxDvm/i3HHk7qNskES8QaiIMOHzO6Lg4qVzJsr7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jjNVCcCQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mpvI4NMGhfa99WAkU0UXnKdY/goH2f25zOH4yuWCuBc=; b=jjNVCcCQGFUAfUf/5hIb4rmrOw
	9b33Wp8ICmPI8CEfoxZ05ZS4eANhNx1k1OOHjBhAUIGTh9dkm69hGlZqIwN0a2cYdhR+xvJa9RrPl
	VB9qwwfcFUBbK93wkvDv1p0Zo+dDUM/cXFXckGIODPuU+UQ1RVjfU67sC65Xqme/Sf07I6+YtD+4F
	tORrrPK9jAe9RRmDcKUPfdkBUerDH86STDdLTX3/xCn3UcGdep0vdZl3PrcR6JFYAzd3FmwP7IfER
	s9Nb3RMxu105Vx5dyaFmtSJXVMZfGw7kV6tvg9R7O5cGA8gWdVVDz22IJK3x/Ifhykb+l0AmWPhdK
	Xc3mZ1eQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfJtB-00000003Pow-1aZN;
	Mon, 12 Jan 2026 15:31:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4A8C7302D3E; Mon, 12 Jan 2026 16:31:28 +0100 (CET)
Date: Mon, 12 Jan 2026 16:31:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260112153128.GO830755@noisy.programming.kicks-ass.net>
References: <20260108220550.2f6638f3@fedora>
 <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home>
 <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <20260109160202.22975aa4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109160202.22975aa4@gandalf.local.home>

On Fri, Jan 09, 2026 at 04:02:02PM -0500, Steven Rostedt wrote:
> On Fri, 9 Jan 2026 15:21:19 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > * preempt disable/enable pair:                                     1.1 ns
> > * srcu-fast lock/unlock:                                           1.5 ns
> > 
> > CONFIG_RCU_REF_SCALE_TEST=y
> > * migrate disable/enable pair:                                     3.0 ns
> > * calls to migrate disable/enable pair within noinline functions: 17.0 ns
> > 
> > CONFIG_RCU_REF_SCALE_TEST=m
> > * migrate disable/enable pair:                                    22.0 ns
> 
> OUCH! So migrate disable/enable has a much larger overhead when executed in
> a module than in the kernel? This means all spin_locks() in modules
> converted to mutexes in PREEMPT_RT are taking this hit!

Not so, the migrate_disable() for PREEMPT_RT is still in core code --
kernel/locking/spinlock_rt.c is very much not build as a module.


