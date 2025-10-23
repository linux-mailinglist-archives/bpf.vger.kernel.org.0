Return-Path: <bpf+bounces-71958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C57DAC0279A
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63C0E35776F
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717E333430;
	Thu, 23 Oct 2025 16:40:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49C308F38;
	Thu, 23 Oct 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237647; cv=none; b=okK5RoYnjym61kCEH6wciS1MoM19Gjw0EszRI+WwMhY/t+saNjJjSQmahucRvlmmqcPlTKjF39us2isRpPwcKAih6ZwJOcyOYCfKhC9AanvMOwqGV8OyZFNxPlOBoeZFOBkW5uobIF183cCZ3VBxktW8QAY3pLIlSGjZ2ddkiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237647; c=relaxed/simple;
	bh=rnsLj7G2Q4LWV1AO4LqUJD5jb2kwyjL7kpPO+GtVgdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayz8C1xdwRnXXkZytfndeqUilXz7KIWSFvBDdAG0XokM9wRIsDqV/b+jUk93Qgf+B+ufSkohWLPvLkVRSMVdDuf7/5iYrlA3P/7+aTKdUAbU3mq7Ypx/R3ikdDh/9btsWfXhZph4s8bhOIDxNM11L8kLDnE8c6T9GmONUtBzKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1C1C6C0C03;
	Thu, 23 Oct 2025 16:40:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 1C16719;
	Thu, 23 Oct 2025 16:40:31 +0000 (UTC)
Date: Thu, 23 Oct 2025 12:40:57 -0400
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
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251023124057.2a6e793a@gandalf.local.home>
In-Reply-To: <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
	<20251023150002.GR4067720@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4ghmzc64qshrjyu9b44bi1ze1a7zh14x
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1C16719
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/vS1yPcV24TdOmvaIXpwP/jWrmfBeXtwA=
X-HE-Tag: 1761237631-199775
X-HE-Meta: U2FsdGVkX1/KkQayy8T8nBvljuDSAC4RsHEqtrM3F6Pudd/lnjCVzSCIxptS//mwcDPMu4ogrFlzkh85nZ5lmKGYP/TNSa4Mi+yXVqZXYDJDTgTUc8OZtwjuhyGhO1pY0YDzmd9ISyCdoeymCDptCYRq1Ao36PzorqdffVgGDAwgtFgSj6hAav3C1hd2GSo0srCRd1nerjiTzSQ7cSLHzQAHR2CjsHT9x/TzlTracVJNef3RcpWo6f6jjTKN+1qlvmsOcpqynWpUy7zWGBdQPH0qVq4s41RUBNZ1sUFJfH3ZOvvFdJvOVfmjvHQZl6a6c/TiUwEA6D9Ew4KCMNUN4X0qvzjqNhRJuPk3XgTin57C0tnYviom2CEXvXLD7IQS

On Thu, 23 Oct 2025 17:00:02 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +/* Deferred unwinding callback for task specific events */
> +static void perf_unwind_deferred_callback(struct unwind_work *work,
> +					 struct unwind_stacktrace *trace, u64 cookie)
> +{
> +	struct perf_callchain_deferred_event deferred_event = {
> +		.trace = trace,
> +		.event = {
> +			.header = {
> +				.type = PERF_RECORD_CALLCHAIN_DEFERRED,
> +				.misc = PERF_RECORD_MISC_USER,
> +				.size = sizeof(deferred_event.event) +
> +					(trace->nr * sizeof(u64)),
> +			},
> +			.cookie = cookie,
> +			.nr = trace->nr,
> +		},
> +	};
> +
> +	perf_iterate_sb(perf_callchain_deferred_output, &deferred_event, NULL);
> +}
> +

So "perf_iterate_sb()" was the key point I was missing. I'm guessing it's
basically a demultiplexer that distributes events to all the requestors?

If I had know this, I would have done it completely different.

-- Steve

