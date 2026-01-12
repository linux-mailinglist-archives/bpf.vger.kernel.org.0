Return-Path: <bpf+bounces-78526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8163BD10D93
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 743EA30274D6
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE2932E6BA;
	Mon, 12 Jan 2026 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B39GCIub"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F942E62DA
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202607; cv=none; b=kkyZ2l3lDQhTGJk06GPiZlZW+O/erBDgbDgrGzQoTj6l/jzI7nOa5UKhO/5gfLplzRU0KtM/u0tpklPxyQTz8lzHhsr9NImADm4/duRJpKem3D5rCxM9i5cmKG/cnL5QGBhafbEV1qWVXddvQMpHwZVdXJMl7ZdwBp8t68tLhc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202607; c=relaxed/simple;
	bh=F1V8XP6HfIfDJMn8b3y89S9z8mQ50N6xQrztS65BQo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rafs6Abo8OWjgmAhQLetSpUyL8TM+YKojQWG16blh9ZXFo+VkA+IYa44B6yplLkU/S7I1lCtdwXKxmJqJWmKI10A6u8/yMTo5FEAUo0NTl7q6KOO3efVd9MIgUeEgE/+WPuG7YxcpNKo8PCXiwuqZ+3eswAdcr2ypjcf81IO/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B39GCIub; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768202602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcAsPi/didUAjJXFDQZOG7bxdnR13N/UiSq6MPkktV8=;
	b=B39GCIubC5D2ehRQZqMm5Vw7TUDlLnTT5SqLIQ42mQkHCdv9m9WYsJ302mX/2FS7urRwYL
	Kana3WIerh0vVjwRHB0UBX68zx/N6t7lk0Zy92RATokQxmkqOBpRA9Dr/AIkXiR94mYkLO
	3DzGJPWhDiNzFFN4sw6Yu+VqAFeRUds=
From: Menglong Dong <menglong.dong@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject:
 Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with
 SRCU-fast
Date: Mon, 12 Jan 2026 15:23:13 +0800
Message-ID: <13926791.uLZWGnKmhe@7940hx>
In-Reply-To: <20260109160202.22975aa4@gandalf.local.home>
References:
 <20260108220550.2f6638f3@fedora>
 <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <20260109160202.22975aa4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/10 05:02 Steven Rostedt <rostedt@goodmis.org> write:
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
> 
> It looks like it has to allow access to the rq->nr_pinned. There's a hack to
> expose this part of the rq struct for in-kernel by the following:
> 
> kernel/sched/rq-offsets.c:      DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));
> 
> Then for the in-kernel code we have:
> 
> #define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
> #else
> #define this_rq_raw() PERCPU_PTR(&runqueues)
> #endif
> #define this_rq_pinned() (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pinned))
> 
> Looking at the scheduler code, the rq->nr_pinned is referenced by a static
> function with:
> 
> static inline bool rq_has_pinned_tasks(struct rq *rq)
> {
> 	return rq->nr_pinned;
> }
> 
> Which is only referenced in hotplug code and a balance_push() path in load
> balancing. Does this variable really need to be in the runqueue struct?
> 
> Why not just make it a per-cpu variable. Maybe call it cpu_nr_pinned_tasks,
> and export that for all to use?
> 
> It will not only fix the discrepancy between the overhead of
> migrate_disable/enable in modules vs in-kernel. But it also removes the
> hack to expose a portion of the runqueue.

I think it's a good idea to factor out the "nr_pinned" from struct rq.
The current approach that we inline the migrate_disable is a little
obscure. The initial propose of inline migrate_disable is to optimize the
performance of bpf trampoline, so the modules are not considered.

As you said, rq_has_pinned_tasks() is the only place that use the
nr_pinned, except the migrate_disable/migrate_enable. After more
analysis, I think maybe we can do it this way:

DEFINE_PER_CPU_SHARED_ALIGNED(int, cpu_nr_pinned_tasks);

And change rq_has_pinned_tasks() to:
static inline bool rq_has_pinned_tasks(struct rq *rq)
{
	return *per_cpu_ptr(&cpu_nr_pinned_tasks, rq->cpu);
}

The "rq" in rq_has_pinned_tasks() may come from other CPU, so we
can't use "return this_cpu_read(cpu_nr_pinned_tasks)" directly.

Thanks!
Menglong Dong

> 
> -- Steve
> 
> 





