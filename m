Return-Path: <bpf+bounces-60671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55490ADA0AC
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 04:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF81188FBB5
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 02:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486726057D;
	Sun, 15 Jun 2025 02:41:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03362CCDB;
	Sun, 15 Jun 2025 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749955277; cv=none; b=iedtHIqFxoNxCdUqrCqnCrOLSWxGn73ne7yZn7t3e2Km6591GHr9Qe95e5Vyn2ra/iog8llcgyGryeXn8QUrcM+DHbASry+XxvKwXuwnPAgTwk0mqJKHaFCGNEVzUvArTjMwT+xLhr9Fbv6bWN11RbrQmMHCk7WqpzyFaA/iNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749955277; c=relaxed/simple;
	bh=42hHEKic1VacB13vV/becXEpEt+H8TRWfpKTXWoQMV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRhvDZ6fksH6K5JDjaNGLjsH+3OyNGbfFQ7tkhDpe0GCXY2JtfCOQ5miObe5nBfXedWObjjXbj+dwcwwZhQHd3ienYRDdtyNyqfRkinXbWWNDptp7zhNWrdh+WPWmcfzvIMipLknLq0rl5QXmnGNQlG2cPfVchN2b+kRcXOHAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 69D87BE48A;
	Sun, 15 Jun 2025 02:41:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 420FE20018;
	Sun, 15 Jun 2025 02:41:08 +0000 (UTC)
Date: Sat, 14 Jun 2025 22:41:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 07/11] perf: Support deferred user callchains for
 per CPU events
Message-ID: <20250614224107.5dfc9f9b@batman.local.home>
In-Reply-To: <20250614024716.798086123@goodmis.org>
References: <20250614024605.597728558@goodmis.org>
	<20250614024716.798086123@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 420FE20018
X-Stat-Signature: gagcigm6c7ynt17aaadxay7m3th34881
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/AgC/Hg0NQSm/NY+yVWvFc6hNX64fqZ10=
X-HE-Tag: 1749955268-571584
X-HE-Meta: U2FsdGVkX18lCD0oF62pyZw65mwLuJAHMAhN67MmLhqV6ghsR1XZJaO2RJjn5MfYCfzjG3xQkpp8R+VjIANl1rkY2OgB9NDggp8itSnBCvlQNUX2DXl2mfr1nzsy2uUEsnF538nURAmf2Cgh43IAEqHQ5mc+fOijY3PHg+eQuo/nsCR5PCFM6+BjaSVOClrpihmGvS0HweJhfXFEay0VPUjRR0LOpKdcCfukBv0nPNahLvAZza4zdys0a6aVF/Va8N9dpHTWmc7rH1EBmCwJFknEjpFXzwdxhKucVCC8lL8BBoQYMMl+PUEwj04mSmmHjW66XJIGKsajDHfiKsLVFhgDwiVX7tmTAFjMvET3CzR+XHERyecXHzsbVRAXeEhM

On Fri, 13 Jun 2025 22:46:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +/*
> + * Deferred unwinding callback for per CPU events.
> + * Note, the request for the deferred unwinding may have happened
> + * on a different CPU.
> + */
> +static void perf_event_deferred_cpu(struct unwind_work *work,
> +				    struct unwind_stacktrace *trace, u64 timestamp)
> +{
> +	struct perf_unwind_deferred *defer =
> +		container_of(work, struct perf_unwind_deferred, unwind_work);
> +	struct perf_unwind_cpu *cpu_events, *cpu_unwind;
> +	struct perf_event *event;
> +	int cpu;
> +
> +	guard(rcu)();
> +	guard(preempt)();
> +
> +	cpu = smp_processor_id();
> +	cpu_events = rcu_dereference(defer->cpu_events);
> +	cpu_unwind = &cpu_events[cpu];
> +
> +	WRITE_ONCE(cpu_unwind->processing, 1);
> +	/*
> +	 * Make sure the above is seen before the event->unwind_deferred
> +	 * is checked. This matches the mb() in rcuwait_rcu_wait_event() in
> +	 * perf_remove_unwind_deferred().
> +	 */
> +	smp_mb();
> +
> +	list_for_each_entry_rcu(event, &cpu_unwind->list, unwind_list) {
> +		/* If unwind_deferred is NULL the event is going away */
> +		if (unlikely(!event->unwind_deferred))
> +			continue;
> +		perf_event_callchain_deferred(event, trace, timestamp);
> +		/* Only the first CPU event gets the trace */
> +		break;
> +	}
> +

Hmm, I think I need a smp_mb() here too.

> +	WRITE_ONCE(cpu_unwind->processing, 0);
> +	rcuwait_wake_up(&cpu_unwind->pending_unwind_wait);
> +}

The first smp_mb() is for synchronizing removing of the event from
perf_remove_unwind_deferred() that has:

	event->unwind_deferred = NULL;

	/*
	 * Make sure perf_event_deferred_cpu() is done with this event.
	 * That function will set cpu_unwind->processing and then
	 * call smp_mb() before iterating the list of its events.
	 * If the event's unwind_deferred is NULL, it will be skipped.
	 * The smp_mb() in that function matches the mb() in
	 * rcuwait_wait_event().
	 */
	rcuwait_wait_event(&cpu_unwind->pending_unwind_wait,
				   !cpu_unwind->processing, TASK_UNINTERRUPTIBLE);


So that the unwind_deferred setting to NULL is seen before the
cpu_unwind->processing is checked. But I think, in theory, without the
smp_mb() before the clearing of the cpu_unwind->procssing that it can
be seen before the unwind_deferred is read.

  CPU 0                                    CPU 1
  -----                                    -----
read event->unwind_deferred

                                        write NULL > event->unwind_deferre
                                        smp_mb() (in rcuwait)

CPU writes 0 > cpu_unwind->processing (re-ordered)

                                        reads cpu_unwind->processing == 0
                                        Starts to free event

Executes perf_event_callchain_deferred()


I'll add another smp_mb() to be safe in v11.

-- Steve





