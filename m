Return-Path: <bpf+bounces-78593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D93D13D40
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4806D302696F
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1C361668;
	Mon, 12 Jan 2026 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="omZjSHsE"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD933370EB;
	Mon, 12 Jan 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232658; cv=none; b=A5NWv5/sO4pxwI6DX0kn1XrZRF2rv9tXgSekQgo0zBW6+AgWT5C3l6bs0Y+GR4DcMwUc+qbQisDX8sueD/K57/ILFoj4jT1MaIrXuSY/7h7wV+k5ReTfW0RAGTt7vL1uwQr/cE8BcTtNP6GEYl39cn2DCswqu0gWv0ktvWM38Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232658; c=relaxed/simple;
	bh=F+dD0O5rdLlpkSFu3XJPiUpuzGcIGKqS1IYu4fWWxf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg6f6lRVQBGaEWnaFAJXBlOrEy9cSIVg/jYh2l4Fe7AzMsvwxqDo9AS8BNqrJDjSAKXL7g1+aP2wLvW5cLj99vWjjHNykeoS1C+bBOoCN+KFX3v+vGrdehx01MYKoO4TaNie7LToGd5q1wGmmOKnNIWmFjthNi+gK/4JgT+kNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=omZjSHsE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GHlgTWqk7Lzv2HzCIc5hb0RdKxS5l4uVv2fCHeXt8IA=; b=omZjSHsE59RIJ9X/oCtNVQogsk
	/zXhvFRscrDOejzz00XtcugWOPBxkTRtZs+reSIvVCvVnJPTaa/Q0GeoQz4XCf2/DyU+xPMf5Dmmw
	VKtzVKkl9U3BoL7E5lKjpUR0sECg5wZ2FFgqI/NMSdklpxZEnh48icd71Z53h9vwFVX9mSbcTLQQh
	YwWZSXh1zpooKvZK8fSBbAw6FvG8hAytclWumF5VV+M3h+Vv4MD2TVpgl7WSlz95wIGvN+H7XpPoX
	nAcAJ+Ncuu7aIUOdFYKaeAuCCPsL9fqXBpIwVRAB/qnm5m78joVWIWDugLPmjTOc3WS6eRBWqVkIo
	6qDhhkIQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfK5U-000000015Sc-0C5h;
	Mon, 12 Jan 2026 15:44:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 060AF3030B0; Mon, 12 Jan 2026 16:44:11 +0100 (CET)
Date: Mon, 12 Jan 2026 16:44:10 +0100
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
Message-ID: <20260112154410.GA830229@noisy.programming.kicks-ass.net>
References: <20260108220550.2f6638f3@fedora>
 <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home>
 <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <20260109160202.22975aa4@gandalf.local.home>
 <20260112153128.GO830755@noisy.programming.kicks-ass.net>
 <20260112103612.41dd4f03@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112103612.41dd4f03@gandalf.local.home>

On Mon, Jan 12, 2026 at 10:36:12AM -0500, Steven Rostedt wrote:
> On Mon, 12 Jan 2026 16:31:28 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > OUCH! So migrate disable/enable has a much larger overhead when executed in
> > > a module than in the kernel? This means all spin_locks() in modules
> > > converted to mutexes in PREEMPT_RT are taking this hit!  
> > 
> > Not so, the migrate_disable() for PREEMPT_RT is still in core code --
> > kernel/locking/spinlock_rt.c is very much not build as a module.
> 
> True. But still, wouldn't it be cleaner to have that variable separate from
> the run queue and make the code a bit simpler?

I still don't like exporting variables either way around. Exporting
functions is much saner.

