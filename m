Return-Path: <bpf+bounces-70343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA8EBB8030
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 21:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3703A7ED2
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA021D3F8;
	Fri,  3 Oct 2025 19:55:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A61E9B0D;
	Fri,  3 Oct 2025 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521316; cv=none; b=cAlq49v6hrfmXrskejWytCKozx9IfvnHgaCyjtUq4ctc1g65HeRvL1RGaAZewwzrF9PTjXtbNG3xpmPm15Y0CxjXKCrSJ22Krbz+IM9dne+ZB4uAAiBtkit1t484S09aJ3ELTHQ4gkXi8HrqenwcBpcirUKSPh5y9kzHbW/sWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521316; c=relaxed/simple;
	bh=7pB+HiVazOC8+Uhf3ApKYcMMp113PQkrr83WDVsAmmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6dfKLraFK+g91NG52NeGyq5bDKQ8bd1mgReZQewcAltc+uNcGq4UstkbR9ORPODa6XHB4XCiQ0dJMvgcXgkpaVT7h9BRKu9RVTuWIPxWT9y6tytDTPGo55+0uv3ke02EKhNVfyTvypmsuStoJOZcU3bMLvDEhLdvzvB7+NKHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id BE5C4160906;
	Fri,  3 Oct 2025 19:55:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id D011720024;
	Fri,  3 Oct 2025 19:54:59 +0000 (UTC)
Date: Fri, 3 Oct 2025 15:56:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook
 <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 2/4] perf: Support deferred user callchains
Message-ID: <20251003155642.370b0953@gandalf.local.home>
In-Reply-To: <20250923103213.GD3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
	<20250908171524.605637238@kernel.org>
	<20250923103213.GD3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g5nknu876pd6ggwoqsamxmzcoy14398p
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D011720024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/yWTU57gIy/HMFvQkWcmsu15QgC8o7GQI=
X-HE-Tag: 1759521299-102347
X-HE-Meta: U2FsdGVkX1+IlwL7q5g8ZfhdQ1wr9ZONT9FLUuMKTzJaXTzlXEN9fusU3HAqA7JagvK1hElcOctVB2riE0nQu+lWbg8OmZmS7LNa5cCv54y++hRd/qa65XAd4+oaLiuB0iHImGsjAN4eBze8U0r3HKtQmRVpYfEeCbZFgAi6Xpft4yBUUf09NmIY7MPs36thdfLheKxOgEIMYgE4CwMQWaNRSphwrIdiisFQpsbm9Ry05K9hSxunhbcl2rYYUIrnNVxkBhbxyity/tstltrfX+EfKCG76pfjsahpeVSYtReBr2gdQjgTDiMp4dwrBqe94LqSu3bAk+T2MhKTlPTpGnIDEif+N/xViaOfNm6cucwU9KpJcrp84PK7OdUlDoyN

On Tue, 23 Sep 2025 12:32:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> I'm also not much of a fan of nr_no_switch_fast, and the fact that this
> patch is limited to per-task events, and you're then adding another 300+
> lines of code to support per-cpu events later on.

BTW, I'm not exactly sure what the purpose of the "nr_no_switch_fast" is
for. Josh had it in his patches and I kept it.

I'm almost done with my next version that moved a lot of the "follow task"
work into the deferred unwind infrastructure, which drastically simplified
this patch.

But I still have this "nr_no_switch_fast" increment when a request is
successfully made and decremented when the stacktrace is executed. In the
task switch perf code there's:

			/* PMIs are disabled; ctx->nr_no_switch_fast is stable. */
			if (local_read(&ctx->nr_no_switch_fast) ||
			    local_read(&next_ctx->nr_no_switch_fast)) {
				/*
				 * Must not swap out ctx when there's pending
				 * events that rely on the ctx->task relation.
				 *
				 * Likewise, when a context contains inherit +
				 * SAMPLE_READ events they should be switched
				 * out using the slow path so that they are
				 * treated as if they were distinct contexts.
				 */
				raw_spin_unlock(&next_ctx->lock);
				rcu_read_unlock();
				goto inside_switch;
			}

Is this mostly to do with PMU counters? Here there is a relation to the
task and the event, but that's just that the task is going to have a
deferred stack trace.

Can I safely drop this counter?

-- Steve

