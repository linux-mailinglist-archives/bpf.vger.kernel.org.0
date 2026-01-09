Return-Path: <bpf+bounces-78382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3227D0C3AE
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519AB302BA94
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C12DB7B0;
	Fri,  9 Jan 2026 21:01:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471AA500950;
	Fri,  9 Jan 2026 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992496; cv=none; b=Eh1mEHDowB/0nQA63gGZeMM/eZYIlXvDVtSdt/5toYIgcENUXUB3o04jvgnARDQSgQmvvS5d8CjD1yzqDhzeq2WVfz0KOUdjKDg7SqGlMLpkpC+zH0yBULt2Q8Ha4zXhVWwnpLFg14aueH38+/IT6s+E/gxHeW3IiMOqxRnqdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992496; c=relaxed/simple;
	bh=9XUI4i+LGx0Qcv6y9jzLcYeRbjdsGAmNd4maGThNz0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHsIWk+kw5Dw+Q5tV1H4OyXyx0FHlT6m5ikHr2x38jf0U5FKpYyylL/iE13j4+45S9RU1+Q3Jc4/4YXiWGwMNpolb1QRwqxujOYc5va4Frn2fwvLtBRH/ISBxezTVZWUmXSfwfQeQ3r2HQlApO0nLnfnckP0zZDKgixv8pu1reA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7E71E1A04E6;
	Fri,  9 Jan 2026 21:01:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 3497A6000A;
	Fri,  9 Jan 2026 21:01:31 +0000 (UTC)
Date: Fri, 9 Jan 2026 16:02:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260109160202.22975aa4@gandalf.local.home>
In-Reply-To: <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
References: <20260108220550.2f6638f3@fedora>
	<da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
	<CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
	<20260109141930.6deb2a0a@gandalf.local.home>
	<3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3497A6000A
X-Stat-Signature: 4kb1xufixft3epcii11k18k1scxgiwcm
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//B9L03woEJO2WIo/FpAYNjLa59iUjkPA=
X-HE-Tag: 1767992491-919078
X-HE-Meta: U2FsdGVkX18/fPyNl6/I/ybwnBPr8aMvlspPzOSk1hJeReOCOpsEFsw5v9A4LawoTaHderAQvRA9d/wRL9TXPbTSXeRLHjDYjLZnK2OBuVRzXTpg7zf36uBOPzH0WeU7aX79QrJy5pIBdRDlzfZ6T5hN0P4xA5Dk1BSeih4xCEJLHSBtSnhFiNi6ihagZ/cBc6Pkg1LcwV6557Crsn65IZN0+txfP/oDEqjAI48Gu6jl7D2Wid2XTy6aQhrhSH2hdzSwlWXc7wMM9IUrvDjEF7OhFDXIvWj60h6XnL41ex+8e9i8IiHkp2gZieJCdujYuKVUhZ+am1sY5qdRQDA6JZ8bVm2qnoV3i/EEufa0q3TakWNGh6LSTOH0R9DskO1A

On Fri, 9 Jan 2026 15:21:19 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> * preempt disable/enable pair:                                     1.1 ns
> * srcu-fast lock/unlock:                                           1.5 ns
> 
> CONFIG_RCU_REF_SCALE_TEST=y
> * migrate disable/enable pair:                                     3.0 ns
> * calls to migrate disable/enable pair within noinline functions: 17.0 ns
> 
> CONFIG_RCU_REF_SCALE_TEST=m
> * migrate disable/enable pair:                                    22.0 ns

OUCH! So migrate disable/enable has a much larger overhead when executed in
a module than in the kernel? This means all spin_locks() in modules
converted to mutexes in PREEMPT_RT are taking this hit!

It looks like it has to allow access to the rq->nr_pinned. There's a hack to
expose this part of the rq struct for in-kernel by the following:

kernel/sched/rq-offsets.c:      DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));

Then for the in-kernel code we have:

#define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
#else
#define this_rq_raw() PERCPU_PTR(&runqueues)
#endif
#define this_rq_pinned() (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))

Looking at the scheduler code, the rq->nr_pinned is referenced by a static
function with:

static inline bool rq_has_pinned_tasks(struct rq *rq)
{
	return rq->nr_pinned;
}

Which is only referenced in hotplug code and a balance_push() path in load
balancing. Does this variable really need to be in the runqueue struct?

Why not just make it a per-cpu variable. Maybe call it cpu_nr_pinned_tasks,
and export that for all to use?

It will not only fix the discrepancy between the overhead of
migrate_disable/enable in modules vs in-kernel. But it also removes the
hack to expose a portion of the runqueue.

-- Steve

