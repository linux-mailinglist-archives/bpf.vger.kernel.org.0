Return-Path: <bpf+bounces-69358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C911B95454
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209373ACAE1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A331CA5A;
	Tue, 23 Sep 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FumE7SRj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C941922ACEB;
	Tue, 23 Sep 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620125; cv=none; b=mRLceCyS5mPwnUeC0R7Sbojav5m3QTfx5/+V9/0GsCTvBWbCw5kAFkLiBSsNO6C0ZFWw9AqOGw3gtJVPvATu9Nd1cXvduIK8b6f1Vk/k+l+gnZCrYSxhomuV9g+xic2Z4kc3NPJ1FRH3KhJ9bCv27/E6XDxvDl31cFqtJU4G6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620125; c=relaxed/simple;
	bh=sGTPjkogMZc7blO0QGcTSkETJ00J0BsNpZHH9yhP6Es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lehFwBAb8U6JK0uxq4It/yPKzXVl80/rEqTZxPj6/pC3OAZVh5zh4/XW91en3la1lSdGMkgyYLdrbuUbs5fttlHvoNe43Oz8OwnfOsReWb3AyNUbF1buquo0LN811ocaJLzW06hnrJpRLESfALRg72YVx63Nqpcd+uqEKkfqRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FumE7SRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3951BC4CEF7;
	Tue, 23 Sep 2025 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758620125;
	bh=sGTPjkogMZc7blO0QGcTSkETJ00J0BsNpZHH9yhP6Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FumE7SRjhoGU9CPgsFuEblsbdY5jwRLcFzAXKdD+bA93EQjki286fn9nDRouWmXof
	 pchJ5+tW9jXl++u6lfhKme4z58TYOPxZaYyvHPVYJAqkuzttBQWj44hOPG0KcCRL6w
	 o+qj4FINHy6bjXqjPGPjp33qAoYFT2qdbCp+fuANzMA9F/8/G57LZtvx3QDcnRf1o4
	 Xt9sLqTN09p87/Bx5jGHranNhAgGVjX9LsGnCBessu8h7KHJAPn+/4NK9D2N5GHaGy
	 M8YR0Kli81hpKJhhMlgKa8afnmGpbgftKrcwuLyRxmgYl1uHjrLQ0IJ35ZAu3s7u4A
	 gZLjoLbA/a36w==
Date: Tue, 23 Sep 2025 05:35:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Sam James
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, Carlos O'Donell
 <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 2/4] perf: Support deferred user callchains
Message-ID: <20250923053515.25a1713e@batman.local.home>
In-Reply-To: <20250923091935.GA3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
	<20250908171524.605637238@kernel.org>
	<20250923091935.GA3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 11:19:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 08, 2025 at 01:14:14PM -0400, Steven Rostedt wrote:
> 
> > +static void perf_event_callchain_deferred(struct callback_head *work)
> > +{
> > +	struct perf_event *event = container_of(work, struct perf_event, pending_unwind_work);
> > +	struct perf_callchain_deferred_event deferred_event;
> > +	u64 callchain_context = PERF_CONTEXT_USER;
> > +	struct unwind_stacktrace trace;
> > +	struct perf_output_handle handle;
> > +	struct perf_sample_data data;
> > +	u64 nr;
> > +
> > +	if (!event->pending_unwind_callback)
> > +		return;
> > +
> > +	if (unwind_user_faultable(&trace) < 0)
> > +		goto out;  
> 
> This is broken. Because:
> 
> > +
> > +	/*
> > +	 * All accesses to the event must belong to the same implicit RCU
> > +	 * read-side critical section as the ->pending_unwind_callback reset.
> > +	 * See comment in perf_pending_unwind_sync().
> > +	 */
> > +	guard(rcu)();  
> 
> Here you start a guard, that lasts until close of function..
> 
> > +
> > +	if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
> > +		goto out;
> > +
> > +	nr = trace.nr + 1 ; /* '+1' == callchain_context */
> > +
> > +	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
> > +	deferred_event.header.misc = PERF_RECORD_MISC_USER;
> > +	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
> > +
> > +	deferred_event.nr = nr;
> > +	deferred_event.cookie = unwind_user_get_cookie();
> > +
> > +	perf_event_header__init_id(&deferred_event.header, &data, event);
> > +
> > +	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
> > +		goto out;
> > +
> > +	perf_output_put(&handle, deferred_event);
> > +	perf_output_put(&handle, callchain_context);
> > +	/* trace.entries[] are not guaranteed to be 64bit */
> > +	for (int i = 0; i < trace.nr; i++) {
> > +		u64 entry = trace.entries[i];
> > +		perf_output_put(&handle, entry);
> > +	}
> > +	perf_event__output_id_sample(event, &handle, &data);
> > +
> > +	perf_output_end(&handle);
> > +
> > +out:  
> 
> Which very much includes here, so your goto jumps into a scope, which is
> not permitted.

Nice catch.

> 
> GCC can fail to warn on this, but clang will consistently fail to
> compile this. Surely the robot would've told you by now -- even if
> you're not using clang yourself.

Unfortunately it hasn't :-(

I need to start building with clang more often.

I even pushed this to a git tree. Not sure why it didn't get flagged.

-- Steve


