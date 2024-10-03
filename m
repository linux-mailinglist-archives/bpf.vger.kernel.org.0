Return-Path: <bpf+bounces-40881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D914598F9F1
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1DC2834BE
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DEC1CDFD2;
	Thu,  3 Oct 2024 22:36:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379F824BD;
	Thu,  3 Oct 2024 22:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995006; cv=none; b=mZ52b1Z3xS/Ppsd9mIBIlyeKUBiGwQrkyJCDV0B9KP2mWBXr2CH+PFntljzpF3J60WpaSM/JXsz9a+ytsh6zBcCrP1F1IsB863/EHqzLnFBMa8gcCRrlRyccndyF8N9JgK/D7ciCZN6u2zirkSRm7c4c5n4NeoqUkwt3D4U8/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995006; c=relaxed/simple;
	bh=TVsn/95wWLL5iksakvNhZU0qqBQP0YTvnJq53+3O0Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiwrCA1LX07Ik7slPUzaGNvHPObJXfZw7EJ922jjKF1VU/vbTBvr45UFJRom9nl6vKgxcqXyvYrj2DDc57m5+SEeP2XuzPg67HkZMM2xh8QCy8qaH4BLBzIfWWNGQTIi1oarEs8EUerJnWYM4zGrJm2/dZEn8lc9tnWm4onv4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC76C4CEC5;
	Thu,  3 Oct 2024 22:36:44 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:37:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v1 7/8] tracing/perf: Add might_fault check to syscall
 probes
Message-ID: <20241003183738.4ebd97f9@gandalf.local.home>
In-Reply-To: <20241003151638.1608537-8-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-8-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 11:16:37 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Add a might_fault() check to validate that the perf sys_enter/sys_exit
> probe callbacks are indeed called from a context where page faults can
> be handled.
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
>  include/trace/perf.h          | 1 +
>  kernel/trace/trace_syscalls.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index 5650c1bad088..321bfd7919f6 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -84,6 +84,7 @@ perf_trace_##call(void *__data, proto)					\
>  	u64 __count __attribute__((unused));				\
>  	struct task_struct *__task __attribute__((unused));		\
>  									\
> +	might_fault();							\
>  	guard(preempt_notrace)();					\
>  	do_perf_trace_##call(__data, args);				\

Same for this. This is used for all tracepoints that perf hooks to.

-- Steve

>  }
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 89d7e4c57b5b..0d42d6f293d6 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -602,6 +602,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  	 * Syscall probe called with preemption enabled, but the ring
>  	 * buffer and per-cpu data require preemption to be disabled.
>  	 */
> +	might_fault();
>  	guard(preempt_notrace)();
>  
>  	syscall_nr = trace_get_syscall_nr(current, regs);
> @@ -710,6 +711,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
>  	 * Syscall probe called with preemption enabled, but the ring
>  	 * buffer and per-cpu data require preemption to be disabled.
>  	 */
> +	might_fault();
>  	guard(preempt_notrace)();
>  
>  	syscall_nr = trace_get_syscall_nr(current, regs);


