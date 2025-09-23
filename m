Return-Path: <bpf+bounces-69373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F414FB9570E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58CD3B8B46
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E1321266;
	Tue, 23 Sep 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="llxZup63"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC32609C5;
	Tue, 23 Sep 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623546; cv=none; b=NRUG0iP2qpbM3HeV/95vU+dtqdxxy3j/VZdtYKz/L7abAhHilOGXdoekQqZ8eg/upkHu4J03CKKs5P+mOgTzWdm4oSDcnAhhwDJeu2RuHc++govnLl8/ewR86Z/nV03Oh6EAhRrhdsWygaWhzRT5nNiKcXRT2IdQNlgeQb7z9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623546; c=relaxed/simple;
	bh=KLtU2Domg70B6qt1IxPQKFkXGlPsM7PrRt1CyEwI9y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U77P9TBuTh0UbO5dv19eI8vgym5V/bvxEfFyUJdJocAUQXUvdSBpn0GU64XNhF+yOo1bjGRmaMXpj+3Yy3QVX+VneGTfn64XjvBwRmHkle7JnPTZqjDaSCw1ihse0JtjIVColq+OT4HNLPf7DqZqm6wyD64P4eTay+cOCLkpwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=llxZup63; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QxQK5moMr9wL0LagnLqZcrNTSI/n1ADMFlNCPKQ5iE8=; b=llxZup63rhlI4Dg+OEYiwHZMBF
	4EjJzhEKtXEcM5SWBx9uDNCWk2hfABeH41EiZN7IhJX1yqozxZHbm6o/LiGQuzMv9bW+q1MXHbM/J
	CGqM6i1d/pRqDj8PIuBzdSL5UOBZHQN1OXztFGsiuXPIP9RERy9zMEPsb4lQD6iYoX7dISx41Hy/v
	TW3RaG/7FQZdrUquiWeeFHe0dx24aMV3MnFadf5TnQpzlIBiZfWnZ/ss6egWu9B75jC4K0YRjiRUH
	2n5kHQdyzBrde18OEdmThSpapq3xxLJxf399OfX0uHfXxCRaW/vXzTc3tetMf9nHXn5XMeewP5gee
	Z1TRtPsQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v10Ji-00000009wwx-3L4c;
	Tue, 23 Sep 2025 10:32:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB4F530049C; Tue, 23 Sep 2025 12:32:13 +0200 (CEST)
Date: Tue, 23 Sep 2025 12:32:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 2/4] perf: Support deferred user callchains
Message-ID: <20250923103213.GD3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
 <20250908171524.605637238@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908171524.605637238@kernel.org>

On Mon, Sep 08, 2025 at 01:14:14PM -0400, Steven Rostedt wrote:
> +struct perf_callchain_deferred_event {
> +	struct perf_event_header	header;
> +	u64				cookie;
> +	u64				nr;
> +	u64				ips[];
> +};
> +
> +static void perf_event_callchain_deferred(struct callback_head *work)
> +{
> +	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
> +	struct perf_callchain_deferred_event deferred_event;
> +	u64 callchain_context = PERF_CONTEXT_USER;
> +	struct unwind_stacktrace trace;
> +	struct perf_output_handle handle;
> +	struct perf_sample_data data;
> +	u64 nr;
> +
> +	if (!event->pending_unwind_callback)
> +		return;
> +
> +	if (unwind_user_faultable(&trace) < 0)
> +		goto out;
> +
> +	/*
> +	 * All accesses to the event must belong to the same implicit RCU
> +	 * read-side critical section as the ->pending_unwind_callback reset.
> +	 * See comment in perf_pending_unwind_sync().
> +	 */
> +	guard(rcu)();
> +
> +	if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
> +		goto out;
> +
> +	nr = trace.nr + 1 ; /* '+1' == callchain_context */
> +
> +	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
> +	deferred_event.header.misc = PERF_RECORD_MISC_USER;
> +	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
> +
> +	deferred_event.nr = nr;
> +	deferred_event.cookie = unwind_user_get_cookie();
> +
> +	perf_event_header__init_id(&deferred_event.header, &data, event);
> +
> +	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
> +		goto out;
> +
> +	perf_output_put(&handle, deferred_event);
> +	perf_output_put(&handle, callchain_context);
> +	/* trace.entries[] are not guaranteed to be 64bit */
> +	for (int i = 0; i < trace.nr; i++) {
> +		u64 entry = trace.entries[i];
> +		perf_output_put(&handle, entry);
> +	}
> +	perf_event__output_id_sample(event, &handle, &data);
> +
> +	perf_output_end(&handle);
> +
> +out:
> +	event->pending_unwind_callback = 0;
> +	local_dec(&event->ctx->nr_no_switch_fast);
> +	rcuwait_wake_up(&event->pending_unwind_wait);
> +}
> +

> +/*
> + * Returns:
> +*     > 0 : if already queued.
> + *      0 : if it performed the queuing
> + *    < 0 : if it did not get queued.
> + */
> +static int deferred_request(struct perf_event *event)
> +{
> +	struct callback_head *work = &event->pending_unwind_work;
> +	int pending;
> +	int ret;
> +
> +	/* Only defer for task events */
> +	if (!event->ctx->task)
> +		return -EINVAL;
> +
> +	if ((current->flags & (PF_KTHREAD | PF_USER_WORKER)) ||
> +	    !user_mode(task_pt_regs(current)))
> +		return -EINVAL;
> +
> +	guard(irqsave)();
> +
> +	/* callback already pending? */
> +	pending = READ_ONCE(event->pending_unwind_callback);
> +	if (pending)
> +		return 1;
> +
> +	/* Claim the work unless an NMI just now swooped in to do so. */
> +	if (!try_cmpxchg(&event->pending_unwind_callback, &pending, 1))
> +		return 1;
> +
> +	/* The work has been claimed, now schedule it. */
> +	ret = task_work_add(current, work, TWA_RESUME);
> +	if (WARN_ON_ONCE(ret)) {
> +		WRITE_ONCE(event->pending_unwind_callback, 0);
> +		return ret;
> +	}
> +	return 0;
> +}

So the thing that stands out is that you're not actually using the
unwind infrastructure you've previously created. Things like: struct
unwind_work, unwind_deferred_{init,request,cancel}() all go unused, and
instead you seem to have build a parallel set, with similar bugs to the
ones I just had to fix in the unwind_deferred things :/

I'm also not much of a fan of nr_no_switch_fast, and the fact that this
patch is limited to per-task events, and you're then adding another 300+
lines of code to support per-cpu events later on.

Fundamentally we only have one stack-trace per task at any one point. We
can have many events per task and many more per-cpu. Let us stick a
struct unwind_work in task_struct and have the perf callback function
use perf_iterate_sb() to find all events that want delivery or so (or we
can add another per perf_event_context list for this purpose).

But duplicating all this seems 'unfortunate'.

