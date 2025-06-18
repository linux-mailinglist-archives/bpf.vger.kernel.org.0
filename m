Return-Path: <bpf+bounces-60988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B26ADF69C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 21:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9836A4A2DA9
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90220E71E;
	Wed, 18 Jun 2025 19:09:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8020A5EA;
	Wed, 18 Jun 2025 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273761; cv=none; b=iDEnVNhUmLbGrKPOgL+8116xVZYz+mUykTtGk71TdZhf6DLVtfkRWeb3wMK83UyZ6A4E3AU5Af7WrnkDcR9q+drKlU2WFyfIXZI8XMpOEvdbD3+HaidKv+0DPjP5eKn2r0ePD8zsI1GdIP4WAUxcuIy25ukGkZpdztzYG2Aqu/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273761; c=relaxed/simple;
	bh=YJ8mz+ikgW8nKvjldFD7MTl5HffyMooPfVfI4mhvw+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgjutJ/TvZ6/2+nibgj1GFV7w20IyQ6RiQIrXMxfpAPZgU3tgCrRRfv5baDFxP9KKSS/YjV/vEWnl6sN2aoQU4mDvImjRpa0zVqeIITgXg5kKxeca1s/reXXJfYOFnJrKw/nYb6N4rakbn+22E6jAJ+k28cBH60GsRNu/aQQ8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 934CBBD597;
	Wed, 18 Jun 2025 19:09:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id CFEC42002B;
	Wed, 18 Jun 2025 19:09:06 +0000 (UTC)
Date: Wed, 18 Jun 2025 15:09:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250618150915.3e811f4b@gandalf.local.home>
In-Reply-To: <20250618184620.GT1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.770214773@goodmis.org>
	<20250618184620.GT1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CFEC42002B
X-Stat-Signature: xymxfyhx6nz85eykkyyk75a7pf5icotc
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//gPL2Am6Um4rgqXE7/zsuJupVWU7zvUY=
X-HE-Tag: 1750273746-299713
X-HE-Meta: U2FsdGVkX1/iuUT1wS6HmN8aOXA0jTCnMH9pqx9YO3LcwcuOu+qWjJNY0zT2xtV4bVBwjGBx/xiA626GfvLBedmWrblKFf4y6nwNfCLeovh58OkMRMw/Wn8m4D+tAue55WxAhmtJ4o1ULeZ4/z5TDHFdhNitF6wm46IMTFkAgIjjS3+LJ12shSs9VawFev8YYTB3rGX+vyMArQ3PO3IgWY32CY4iD/2Sx/bgXLGsZcB5iMxlDH+4qI78n7+K0Lw6imh6VesOOQoWu1mfGBad0ie7FDq1ku2arPNrViuxfjOo7T/RpKW1fQEbS7CfV+rMAEVnNC4bPpsEsLzXR/3IJ/Mbu1e5f9Y3F63SvnCIk3APvNopf2jhSlNRSdDO40iB

On Wed, 18 Jun 2025 20:46:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > +struct unwind_work;
> > +
> > +typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 timestamp);
> > +
> > +struct unwind_work {
> > +	struct list_head		list;  
> 
> Does this really need to be a list? Single linked list like
> callback_head not good enough?

Doesn't a list head make it easier to remove without having to iterate the
list?

> 
> > +	unwind_callback_t		func;
> > +};
> > +
> >  #ifdef CONFIG_UNWIND_USER
> >  
> >  void unwind_task_init(struct task_struct *task);
> > @@ -12,10 +22,15 @@ void unwind_task_free(struct task_struct *task);
> >  
> >  int unwind_deferred_trace(struct unwind_stacktrace *trace);
> >  
> > +int unwind_deferred_init(struct unwind_work *work, unwind_callback_t
> > func); +int unwind_deferred_request(struct unwind_work *work, u64
> > *timestamp); +void unwind_deferred_cancel(struct unwind_work *work);
> > +
> >  static __always_inline void unwind_exit_to_user_mode(void)
> >  {
> >  	if (unlikely(current->unwind_info.cache))
> >  		current->unwind_info.cache->nr_entries = 0;
> > +	current->unwind_info.timestamp = 0;  
> 
> Surely clearing that timestamp is only relevant when there is a cache
> around? Better to not add this unconditional write to the exit path.

That's actually not quite true. If the allocation fails, we still want to
clear the timestamp. But later patches add more data to check and it does
exit out if there's been no requests:

{
        struct unwind_task_info *info = &current->unwind_info;
        unsigned long bits;

        /* Was there any unwinding? */
        if (likely(!info->unwind_mask))
                return;

        bits = info->unwind_mask;
        do {
                /* Is a task_work going to run again before going back */
                if (bits & UNWIND_PENDING)
                        return;
        } while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));

        if (likely(info->cache))
                info->cache->nr_entries = 0;
        info->timestamp = 0;
}

But for better reviewing, I could add a comment in this patch that states
that this will eventually exit out early when it does more work.


> 
> >  }
> >  
> >  #else /* !CONFIG_UNWIND_USER */
> > @@ -24,6 +39,9 @@ static inline void unwind_task_init(struct
> > task_struct *task) {} static inline void unwind_task_free(struct
> > task_struct *task) {} 
> >  static inline int unwind_deferred_trace(struct unwind_stacktrace
> > *trace) { return -ENOSYS; } +static inline int
> > unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> > { return -ENOSYS; } +static inline int unwind_deferred_request(struct
> > unwind_work *work, u64 *timestamp) { return -ENOSYS; } +static inline
> > void unwind_deferred_cancel(struct unwind_work *work) {} static inline
> > void unwind_exit_to_user_mode(void) {} 
> > diff --git a/include/linux/unwind_deferred_types.h
> > b/include/linux/unwind_deferred_types.h index
> > db5b54b18828..5df264cf81ad 100644 ---
> > a/include/linux/unwind_deferred_types.h +++
> > b/include/linux/unwind_deferred_types.h @@ -9,6 +9,9 @@ struct
> > unwind_cache { 
> >  struct unwind_task_info {
> >  	struct unwind_cache	*cache;
> > +	struct callback_head	work;
> > +	u64			timestamp;
> > +	int			pending;
> >  };
> >  
> >  #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
> > diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> > index e3913781c8c6..b76c704ddc6d 100644
> > --- a/kernel/unwind/deferred.c
> > +++ b/kernel/unwind/deferred.c
> > @@ -2,13 +2,35 @@
> >  /*
> >   * Deferred user space unwinding
> >   */
> > +#include <linux/sched/task_stack.h>
> > +#include <linux/unwind_deferred.h>
> > +#include <linux/sched/clock.h>
> > +#include <linux/task_work.h>
> >  #include <linux/kernel.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> > -#include <linux/unwind_deferred.h>
> > +#include <linux/mm.h>
> >  
> >  #define UNWIND_MAX_ENTRIES 512
> >  
> > +/* Guards adding to and reading the list of callbacks */
> > +static DEFINE_MUTEX(callback_mutex);
> > +static LIST_HEAD(callbacks);  
> 
> Global state.. smells like failure.

Yes, the unwind infrastructure is global, as it is the way tasks know what
tracer's callbacks to call.

> 
> > +/*
> > + * Read the task context timestamp, if this is the first caller then
> > + * it will set the timestamp.
> > + */
> > +static u64 get_timestamp(struct unwind_task_info *info)
> > +{
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	if (!info->timestamp)
> > +		info->timestamp = local_clock();
> > +
> > +	return info->timestamp;
> > +}
> > +
> >  /**
> >   * unwind_deferred_trace - Produce a user stacktrace in faultable
> > context
> >   * @trace: The descriptor that will store the user stacktrace
> > @@ -59,11 +81,117 @@ int unwind_deferred_trace(struct unwind_stacktrace
> > *trace) return 0;
> >  }
> >  
> > +static void unwind_deferred_task_work(struct callback_head *head)
> > +{
> > +	struct unwind_task_info *info = container_of(head, struct
> > unwind_task_info, work);
> > +	struct unwind_stacktrace trace;
> > +	struct unwind_work *work;
> > +	u64 timestamp;
> > +
> > +	if (WARN_ON_ONCE(!info->pending))
> > +		return;
> > +
> > +	/* Allow work to come in again */
> > +	WRITE_ONCE(info->pending, 0);
> > +
> > +	/*
> > +	 * From here on out, the callback must always be called, even
> > if it's
> > +	 * just an empty trace.
> > +	 */
> > +	trace.nr = 0;
> > +	trace.entries = NULL;
> > +
> > +	unwind_deferred_trace(&trace);
> > +
> > +	timestamp = info->timestamp;
> > +
> > +	guard(mutex)(&callback_mutex);
> > +	list_for_each_entry(work, &callbacks, list) {
> > +		work->func(work, &trace, timestamp);
> > +	}  
> 
> So now you're globally serializing all return-to-user instances. How is
> that not a problem?

It was the original way we did things. The next patch changes this to SRCU.
But it requires a bit more care. For breaking up the series, I preferred
not to add that logic and make it a separate patch.

For better reviewing, I'll add a comment here that says:

	/* TODO switch this global lock to SRCU */

-- Steve

