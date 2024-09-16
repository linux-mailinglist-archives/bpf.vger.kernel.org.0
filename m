Return-Path: <bpf+bounces-40003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93997A76C
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554EB285191
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4D15B57D;
	Mon, 16 Sep 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABtgotaV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58614264A;
	Mon, 16 Sep 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512463; cv=none; b=ibF/lI1TmbNF+fVVb1GG11Rr0mXtOnASdTfxTelp13TtOxvD6ogJ+yRjWYFYWXAtyQSHebIa0yepIHMwLECtsahrgqglaXlE5fCW8grgVGmLUmvmHFyMsNWV4v09DX+JXIUepFMyRlwD9U7UMp3flJ8MvtvFc3z0NWdMl4EkCR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512463; c=relaxed/simple;
	bh=YONIu19JZeROs0DNZfx7fAzpgVhaKHDQf+Xd3Y0Y7jw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=clH/61lZ9FLh95KCwoqdBq733MYSiomPYzrHT2Ol1XX/KvpM4XtznwwuyvY08Q0ishsahj/LdBzgcij28I1XWOcU+BcGX4aX3F+IDXLvFCjMmN31wO/IQ21N35JlVnMxw+7ELOKeXumbpkqvo6yHOr/zE3taMQZ5NpomHms70L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABtgotaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30299C4CEC4;
	Mon, 16 Sep 2024 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726512463;
	bh=YONIu19JZeROs0DNZfx7fAzpgVhaKHDQf+Xd3Y0Y7jw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ABtgotaVgCYOmMXISzBoxSvfF476n8+kLCfxtoSgQhtz5c4K6gBVrEmzHUQWOqe5+
	 jXO6Mk8V+sE+dqNgNFjg7IQD1dZ+0vKMUjul15ZkSz0RS92YUclRdSwqSVAHdkRMWF
	 X4xgAnw33lEZJsk+N8Rp5l+Xo32sK7zAtUby7Lti6ccllCU2qW+3JEht/h8xoGKevW
	 bVQm6TSM7ruQ92ef17SSV69c5A5CAn7Vry97UE6zJYK8PS6N06Kn4HTJ7idZB9L/Sl
	 CE2f5M846jUQxnAa3PiIg7SGXcp0146XaJA3wPx1HzL6Ukw7fsLJfXN9bjzzFoK7MZ
	 2fG+yB0LjTVEQ==
Date: Tue, 17 Sep 2024 03:47:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
Message-Id: <20240917034732.67af2533dec577f96bdb36f8@kernel.org>
In-Reply-To: <20240909201652.319406-3-mathieu.desnoyers@efficios.com>
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
	<20240909201652.319406-3-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 16:16:46 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> In preparation for allowing system call enter/exit instrumentation to
> handle page faults, make sure that ftrace can handle this change by
> explicitly disabling preemption within the ftrace system call tracepoint
> probes to respect the current expectations within ftrace ring buffer
> code.
> 
> This change does not yet allow ftrace to take page faults per se within
> its probe, but allows its existing probes to adapt to the upcoming
> change.

OK, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/trace/trace_events.h  | 38 ++++++++++++++++++++++++++++-------
>  kernel/trace/trace_syscalls.c | 12 +++++++++++
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 8bcbb9ee44de..0228d9ed94a3 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -263,6 +263,9 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
>  	tstruct								\
>  	{} };
>  
> +#undef DECLARE_EVENT_SYSCALL_CLASS
> +#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
> +
>  #undef DEFINE_EVENT_PRINT
>  #define DEFINE_EVENT_PRINT(template, name, proto, args, print)
>  
> @@ -396,11 +399,11 @@ static inline notrace int trace_event_get_offsets_##call(		\
>  
>  #include "stages/stage6_event_callback.h"
>  
> -#undef DECLARE_EVENT_CLASS
> -#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
> -									\
> +
> +#undef __DECLARE_EVENT_CLASS
> +#define __DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
>  static notrace void							\
> -trace_event_raw_event_##call(void *__data, proto)			\
> +do_trace_event_raw_event_##call(void *__data, proto)			\
>  {									\
>  	struct trace_event_file *trace_file = __data;			\
>  	struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
> @@ -425,15 +428,34 @@ trace_event_raw_event_##call(void *__data, proto)			\
>  									\
>  	trace_event_buffer_commit(&fbuffer);				\
>  }
> +
> +#undef DECLARE_EVENT_CLASS
> +#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
> +__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> +		      PARAMS(assign), PARAMS(print))			\
> +static notrace void							\
> +trace_event_raw_event_##call(void *__data, proto)			\
> +{									\
> +	do_trace_event_raw_event_##call(__data, args);			\
> +}
> +
> +#undef DECLARE_EVENT_SYSCALL_CLASS
> +#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print) \
> +__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> +		      PARAMS(assign), PARAMS(print))			\
> +static notrace void							\
> +trace_event_raw_event_##call(void *__data, proto)			\
> +{									\
> +	guard(preempt_notrace)();					\
> +	do_trace_event_raw_event_##call(__data, args);			\
> +}
> +
>  /*
>   * The ftrace_test_probe is compiled out, it is only here as a build time check
>   * to make sure that if the tracepoint handling changes, the ftrace probe will
>   * fail to compile unless it too is updated.
>   */
>  
> -#undef DECLARE_EVENT_SYSCALL_CLASS
> -#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
> -
>  #undef DEFINE_EVENT
>  #define DEFINE_EVENT(template, call, proto, args)			\
>  static inline void ftrace_test_probe_##call(void)			\
> @@ -443,6 +465,8 @@ static inline void ftrace_test_probe_##call(void)			\
>  
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>  
> +#undef __DECLARE_EVENT_CLASS
> +
>  #include "stages/stage7_class_define.h"
>  
>  #undef DECLARE_EVENT_CLASS
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 067f8e2b930f..abf0e0b7cd0b 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -299,6 +299,12 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>  	int syscall_nr;
>  	int size;
>  
> +	/*
> +	 * Syscall probe called with preemption enabled, but the ring
> +	 * buffer and per-cpu data require preemption to be disabled.
> +	 */
> +	guard(preempt_notrace)();
> +
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>  		return;
> @@ -338,6 +344,12 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
>  	struct trace_event_buffer fbuffer;
>  	int syscall_nr;
>  
> +	/*
> +	 * Syscall probe called with preemption enabled, but the ring
> +	 * buffer and per-cpu data require preemption to be disabled.
> +	 */
> +	guard(preempt_notrace)();
> +
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>  		return;
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

