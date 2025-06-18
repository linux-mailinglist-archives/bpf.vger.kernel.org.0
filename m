Return-Path: <bpf+bounces-60987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE00ADF630
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A4E17E954
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE6A1A316E;
	Wed, 18 Jun 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eTZEkEX4"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF31A3167;
	Wed, 18 Jun 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272392; cv=none; b=Mtdhvr0iitT8sTuqUETNHUskpyR4u2cb6ueKH/2dltoABkc6ncTNk71REbKUrHygVYO0NO90kPX+76us2OwjFVAtnTpnBIUthnSQNlTUyYnq2AIPYNLkucCsEYIWEw008xouOZ4o4sTX/4OjXeZd/Jo5ken1k4znSXRZcCMCkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272392; c=relaxed/simple;
	bh=nwHc7+FhruTCmFkGw9cAHt/FPgfsGbv6otZRqkGaASc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhxaNUhmrMRGM+pUJhtPLUVQPVd+yWDfxgvMbL1DRMi3opl+CQPV/US+F6pjeD4ZUKPHAretb/XaB1KFQ/27AvutbFflr81Od0hSJqrs3A2Y8CjRY5o7IkaH3QFpYdGkCSNWO6zDNPXteIpJoLZiQ2ChQ/ITc1nHgbQya7SLNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eTZEkEX4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nnawhQuXAs7uTQeaNTHZqCRiwoXsLdqroTgKhX6cKYk=; b=eTZEkEX4ozmSlQkVChhsWgEg34
	YmPB8fb5CQP5JO3PfozQmAgVu+sS7yexuPZ+ScWHOkeWdAYYXpt/BnojgX40wuNrspLuwdVBBWrOq
	+62JZg+b3hS//vXrz/GKzQhbZ+gkaVxLs0MUYaFXyFbhL7Tos3BXkBCsbfVvja6Ta2DF7G7V56BuH
	BCl98YXhutlHe6KuTloc5PrYlULiRgr0sK/73AxAk6sE3+k6NeVQ0T5nlTvsqM2CjkIggu956wfsu
	bfB8yk5szx2KtGDxx3qAAJ42hPsRvUCL+8pslW98Fu+Tlrztc+Wp0z3M6aU7bK9/8ItvWO3t0id3H
	775odANg==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRxng-00000004auJ-3tiq;
	Wed, 18 Jun 2025 18:46:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5F7EC3061C1; Wed, 18 Jun 2025 20:46:20 +0200 (CEST)
Date: Wed, 18 Jun 2025 20:46:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250618184620.GT1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.770214773@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.770214773@goodmis.org>


> +struct unwind_work;
> +
> +typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 timestamp);
> +
> +struct unwind_work {
> +	struct list_head		list;

Does this really need to be a list? Single linked list like
callback_head not good enough?

> +	unwind_callback_t		func;
> +};
> +
>  #ifdef CONFIG_UNWIND_USER
>  
>  void unwind_task_init(struct task_struct *task);
> @@ -12,10 +22,15 @@ void unwind_task_free(struct task_struct *task);
>  
>  int unwind_deferred_trace(struct unwind_stacktrace *trace);
>  
> +int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
> +int unwind_deferred_request(struct unwind_work *work, u64 *timestamp);
> +void unwind_deferred_cancel(struct unwind_work *work);
> +
>  static __always_inline void unwind_exit_to_user_mode(void)
>  {
>  	if (unlikely(current->unwind_info.cache))
>  		current->unwind_info.cache->nr_entries = 0;
> +	current->unwind_info.timestamp = 0;

Surely clearing that timestamp is only relevant when there is a cache
around? Better to not add this unconditional write to the exit path.

>  }
>  
>  #else /* !CONFIG_UNWIND_USER */
> @@ -24,6 +39,9 @@ static inline void unwind_task_init(struct task_struct *task) {}
>  static inline void unwind_task_free(struct task_struct *task) {}
>  
>  static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
> +static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
> +static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
> +static inline void unwind_deferred_cancel(struct unwind_work *work) {}
>  
>  static inline void unwind_exit_to_user_mode(void) {}
>  
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index db5b54b18828..5df264cf81ad 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -9,6 +9,9 @@ struct unwind_cache {
>  
>  struct unwind_task_info {
>  	struct unwind_cache	*cache;
> +	struct callback_head	work;
> +	u64			timestamp;
> +	int			pending;
>  };
>  
>  #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index e3913781c8c6..b76c704ddc6d 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -2,13 +2,35 @@
>  /*
>   * Deferred user space unwinding
>   */
> +#include <linux/sched/task_stack.h>
> +#include <linux/unwind_deferred.h>
> +#include <linux/sched/clock.h>
> +#include <linux/task_work.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> -#include <linux/unwind_deferred.h>
> +#include <linux/mm.h>
>  
>  #define UNWIND_MAX_ENTRIES 512
>  
> +/* Guards adding to and reading the list of callbacks */
> +static DEFINE_MUTEX(callback_mutex);
> +static LIST_HEAD(callbacks);

Global state.. smells like failure.

> +/*
> + * Read the task context timestamp, if this is the first caller then
> + * it will set the timestamp.
> + */
> +static u64 get_timestamp(struct unwind_task_info *info)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	if (!info->timestamp)
> +		info->timestamp = local_clock();
> +
> +	return info->timestamp;
> +}
> +
>  /**
>   * unwind_deferred_trace - Produce a user stacktrace in faultable context
>   * @trace: The descriptor that will store the user stacktrace
> @@ -59,11 +81,117 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
>  	return 0;
>  }
>  
> +static void unwind_deferred_task_work(struct callback_head *head)
> +{
> +	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
> +	struct unwind_stacktrace trace;
> +	struct unwind_work *work;
> +	u64 timestamp;
> +
> +	if (WARN_ON_ONCE(!info->pending))
> +		return;
> +
> +	/* Allow work to come in again */
> +	WRITE_ONCE(info->pending, 0);
> +
> +	/*
> +	 * From here on out, the callback must always be called, even if it's
> +	 * just an empty trace.
> +	 */
> +	trace.nr = 0;
> +	trace.entries = NULL;
> +
> +	unwind_deferred_trace(&trace);
> +
> +	timestamp = info->timestamp;
> +
> +	guard(mutex)(&callback_mutex);
> +	list_for_each_entry(work, &callbacks, list) {
> +		work->func(work, &trace, timestamp);
> +	}

So now you're globally serializing all return-to-user instances. How is
that not a problem?

> +}

