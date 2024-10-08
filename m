Return-Path: <bpf+bounces-41311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B136D995B98
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79382284A5B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C136217914;
	Tue,  8 Oct 2024 23:23:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF71E0B8C;
	Tue,  8 Oct 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429813; cv=none; b=J0E8SGCsXIwh4/7zX+IjoJSX9BiU5JjK1ezNSBcKV6eCpnt9i/gJAxbVagltRfLJidzhdKmCNi9o4YBIFceYp05GFz5dy8wz5mKOuiWdvAngdJoFBTG2wMAIqFn41OhRVI9WnAXmcKWit0rERUt7cKVUlKsOpWUTJAbxBxcR6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429813; c=relaxed/simple;
	bh=GVM3fdwPOHCoBeEq1zhyLLV1E6WbNIYAHglxuRrIrlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKLLvZZsoPcFhf+FlPL9EO0kf8d611uAfo/9a8EWADzkRhslWS+67ooSh5imFSs9FXL+oPBLVNKsnJpnfD7z6+2e9qAd9vjUUNUW1RX7kcbZq/pLsLXEEhTR63z8HRnLRHHA/Hnf2+o6WqNk+JSmGNLdPwhI0/id5xvDQtRY0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBA6C4CEC7;
	Tue,  8 Oct 2024 23:23:30 +0000 (UTC)
Date: Tue, 8 Oct 2024 19:23:34 -0400
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
Subject: Re: [PATCH v3 5/8] tracing: Allow system call tracepoints to handle
 page faults
Message-ID: <20241008192334.54180520@gandalf.local.home>
In-Reply-To: <20241004145818.1726671-6-mathieu.desnoyers@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
	<20241004145818.1726671-6-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 10:58:15 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Use Tasks Trace RCU to protect iteration of system call enter/exit
> tracepoint probes to allow those probes to handle page faults.
> 
> In preparation for this change, all tracers registering to system call
> enter/exit tracepoints should expect those to be called with preemption
> enabled.
> 
> This allows tracers to fault-in userspace system call arguments such as
> path strings within their probe callbacks.
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
>  include/linux/tracepoint.h | 12 ++++++++++--
>  init/Kconfig               |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 014790495ad8..cefd44b7c91f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -17,6 +17,7 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/rcupdate.h>
> +#include <linux/rcupdate_trace.h>
>  #include <linux/tracepoint-defs.h>
>  #include <linux/static_call.h>
>  
> @@ -107,6 +108,7 @@ void for_each_tracepoint_in_module(struct module *mod,
>  #ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +	synchronize_rcu_tasks_trace();
>  	synchronize_rcu();
>  }
>  #else
> @@ -204,11 +206,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (!(cond))						\
>  			return;						\
>  									\
> -		preempt_disable_notrace();				\

Should add a comment somewhere stating that the syscall version is to allow faults.

-- Steve

> +		if (syscall)						\
> +			rcu_read_lock_trace();				\
> +		else							\
> +			preempt_disable_notrace();			\
>  									\
>  		__DO_TRACE_CALL(name, TP_ARGS(args));			\
>  									\
> -		preempt_enable_notrace();				\
> +		if (syscall)						\
> +			rcu_read_unlock_trace();			\
> +		else							\
> +			preempt_enable_notrace();			\
>  	} while (0)
>  
>  /*
> diff --git a/init/Kconfig b/init/Kconfig
> index fbd0cb06a50a..eedd0064fb36 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1984,6 +1984,7 @@ config BINDGEN_VERSION_TEXT
>  #
>  config TRACEPOINTS
>  	bool
> +	select TASKS_TRACE_RCU
>  
>  source "kernel/Kconfig.kexec"
>  


