Return-Path: <bpf+bounces-69353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2CB9536A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02542174CB2
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC613191D2;
	Tue, 23 Sep 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTRFhFuL"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA62745E;
	Tue, 23 Sep 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619190; cv=none; b=NZCcDi6v2ECh+xoGCW3bifQbTDwGlbyLZP0GnDWW0a6pvyeULI3zF6AwRy9ptrqsQcN22kU1ADUHVALLAVVP97uNhGeY8SX+E6nk0nlsMockXCj2I8Z4XB6zck8EwKrbMcggcrJpdMm2fNSohaFLk6wUB5k44JPfGXgyGaqL25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619190; c=relaxed/simple;
	bh=0L7MiOb5pyYVW4bzwC/AunqTwqImMvZW7R/YhyguT8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIKvUi0dpoVaIF0hXH90+Lizve7fDRhWa0MqHYIUXfYgVJmS0e8sp4sWGgcdUdIk+EcpqkmgdIi0EfmC7iD4Xw9DjBWW1w8viVEThD1pQpMOgtFnqrnXzKYdz724m2vM7MAYdkQ+Tu9KByA7x36TBCeXe7pjMn4LGVvHt5x5lfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tTRFhFuL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=omsqDx8h+bMH2VbzuY1YC4ZuHDpP4MNKt84hgwmMr3Y=; b=tTRFhFuL/MGzVtagKpKqzLTUJE
	EI+Mdj8YQizpcvJuwUFVVh5/JlDPoG2SMX9TJPUdsnvJ0Vc71Lh90f28H7ZDCohT8og/fR4SkOtrs
	CePSNaETXmRmAmkRZncbGbJZrj3xsSpNxmy0fmCfQav4sdsME7buO2uWJqWX8Si6IKYf3UeSv1JjE
	IKMC/m07VNxjLxeJoomB9ZCI8pln1lxOPcqyElnw15zP7ZIp61cMmVmB3vYBX7tH5NxyXNBZc6ieT
	hHZhFZ9osBfjsckTynPeyinRgUmwmwiYGqTwPkVH1I6CIzajmU0u+sa+bVR4jcYsXf/Ro4WB9Kkem
	qlF5bByw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0zBR-00000008qq6-0GFG;
	Tue, 23 Sep 2025 09:19:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D313330049C; Tue, 23 Sep 2025 11:19:35 +0200 (CEST)
Date: Tue, 23 Sep 2025 11:19:35 +0200
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
Message-ID: <20250923091935.GA3419281@noisy.programming.kicks-ass.net>
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

This is broken. Because:

> +
> +	/*
> +	 * All accesses to the event must belong to the same implicit RCU
> +	 * read-side critical section as the ->pending_unwind_callback reset.
> +	 * See comment in perf_pending_unwind_sync().
> +	 */
> +	guard(rcu)();

Here you start a guard, that lasts until close of function..

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

Which very much includes here, so your goto jumps into a scope, which is
not permitted.

GCC can fail to warn on this, but clang will consistently fail to
compile this. Surely the robot would've told you by now -- even if
you're not using clang yourself.

> +	event->pending_unwind_callback = 0;
> +	local_dec(&event->ctx->nr_no_switch_fast);
> +	rcuwait_wake_up(&event->pending_unwind_wait);
> +}

