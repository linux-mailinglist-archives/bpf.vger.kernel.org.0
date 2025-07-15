Return-Path: <bpf+bounces-63315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13720B057D0
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 12:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6C91C22A3D
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC32D8380;
	Tue, 15 Jul 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0JZHr7y"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7ED2AD00;
	Tue, 15 Jul 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575369; cv=none; b=ZTVvhVWGhxRGW6krIpwTyLo1wHgKjXVDxOFFMxpmgj8izT9seTFE4bgT/bTWz/ClrdW6pTYA4cU5xBpNlr1orAAJv9fV93L3ykuV8o8ATAFIhCQFLmyBnYYoaRosoAApz0wa+pODhGC20vvYT64g2bCI0vez9HkrwRVYTkXxBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575369; c=relaxed/simple;
	bh=L0YekEeSU1cUyrX3obpasfu/+6I/edwp9hDqtSmbtCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MchIrbC81GStbojwfPdZu5cs6ySpU3NKMpyK1ny9sb1yU6M9F+hctRjOLCXB2Epz7eMaWhqHnKsdI/8DgQBPx45VqYtbwNyUYnybX0IU9uDg6++0RBVvNmJeHzMavaW+a+XNfhoj3zRqbasxAUMN49nvH4vqTwDKB0GqNLubBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D0JZHr7y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EAwT4PmrC0SJhIE5b9fTa/r05WfihpVwq1Eps+d/0L0=; b=D0JZHr7yG276cGcCMp9JQpeEeI
	DRbkmAdM+xrOCYJpqAbfkpJlrgTR3visJs6LsTHR7icTaqC3SdeKcK2LJm6ByIhXB67JIKbQ2EWV9
	iZ1FajxYMAdfeol1Ca0ahUV+4cqeyeOeQXfIc1jT2btDfrhgix+MwuLtWw3QU687ZcUt/4bThndOD
	td9V8FZkA9IVLs52votXDA0ITsEzdFzgddOMehftgWd/VRF6CA57XmP4OyDc+pnmlqtwVhjTe9mSo
	vNXiqQ5yvDbkcLYqAL16J1RHjYxT8SAvGgeOe/IXIFA3hk7PS8DpH3j/KDG7M6QIiSM7Mrlq28TiI
	KRXUUJ3Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubcuQ-00000009rkE-0L9j;
	Tue, 15 Jul 2025 10:29:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 903D83001AA; Tue, 15 Jul 2025 12:29:12 +0200 (CEST)
Date: Tue, 15 Jul 2025 12:29:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
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
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to user
 space
Message-ID: <20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
 <20250708012359.345060579@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708012359.345060579@kernel.org>

On Mon, Jul 07, 2025 at 09:22:49PM -0400, Steven Rostedt wrote:
> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> index 12bffdb0648e..587e120c0fd6 100644
> --- a/include/linux/unwind_deferred.h
> +++ b/include/linux/unwind_deferred.h
> @@ -18,6 +18,14 @@ struct unwind_work {
>  
>  #ifdef CONFIG_UNWIND_USER
>  
> +#define UNWIND_PENDING_BIT	(BITS_PER_LONG - 1)
> +#define UNWIND_PENDING		BIT(UNWIND_PENDING_BIT)

Since it really didn't matter what bit you took, why not take bit 0?

> +
> +enum {
> +	UNWIND_ALREADY_PENDING	= 1,
> +	UNWIND_ALREADY_EXECUTED	= 2,
> +};
> +
>  void unwind_task_init(struct task_struct *task);
>  void unwind_task_free(struct task_struct *task);
>  
> @@ -29,15 +37,26 @@ void unwind_deferred_cancel(struct unwind_work *work);
>  
>  static __always_inline void unwind_reset_info(void)
>  {
> -	if (unlikely(current->unwind_info.id.id))
> +	struct unwind_task_info *info = &current->unwind_info;
> +	unsigned long bits;
> +
> +	/* Was there any unwinding? */
> +	if (unlikely(info->unwind_mask)) {
> +		bits = info->unwind_mask;
> +		do {
> +			/* Is a task_work going to run again before going back */
> +			if (bits & UNWIND_PENDING)
> +				return;
> +		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
>  		current->unwind_info.id.id = 0;
> +	}
>  	/*
>  	 * As unwind_user_faultable() can be called directly and
>  	 * depends on nr_entries being cleared on exit to user,
>  	 * this needs to be a separate conditional.
>  	 */
> -	if (unlikely(current->unwind_info.cache))
> -		current->unwind_info.cache->nr_entries = 0;
> +	if (unlikely(info->cache))
> +		info->cache->nr_entries = 0;
>  }
>  
>  #else /* !CONFIG_UNWIND_USER */

> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index 9aed9866f460..256458f3eafe 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -47,6 +47,11 @@ static LIST_HEAD(callbacks);
>  static unsigned long unwind_mask;
>  DEFINE_STATIC_SRCU(unwind_srcu);
>  
> +static inline bool unwind_pending(struct unwind_task_info *info)
> +{
> +	return test_bit(UNWIND_PENDING_BIT, &info->unwind_mask);
> +}
> +
>  /*
>   * This is a unique percpu identifier for a given task entry context.
>   * Conceptually, it's incremented every time the CPU enters the kernel from
> @@ -143,14 +148,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
>  	struct unwind_stacktrace trace;
>  	struct unwind_work *work;
> +	unsigned long bits;
>  	u64 cookie;
>  	int idx;
>  
> -	if (WARN_ON_ONCE(!local_read(&info->pending)))
> +	if (WARN_ON_ONCE(!unwind_pending(info)))
>  		return;
>  
> -	/* Allow work to come in again */
> -	local_set(&info->pending, 0);
> +	/* Clear pending bit but make sure to have the current bits */
> +	bits = READ_ONCE(info->unwind_mask);
> +	while (!try_cmpxchg(&info->unwind_mask, &bits, bits & ~UNWIND_PENDING))
> +		;

We have:

	bits = atomic_long_fetch_andnot(UNWIND_PENDING, &info->unwind_mask);

for that. A fair number of architecture can actually do this better than
a cmpxchg loop.

>  
>  	/*
>  	 * From here on out, the callback must always be called, even if it's
> @@ -166,10 +174,8 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  	idx = srcu_read_lock(&unwind_srcu);
>  	list_for_each_entry_srcu(work, &callbacks, list,
>  				 srcu_read_lock_held(&unwind_srcu)) {
> -		if (test_bit(work->bit, &info->unwind_mask)) {
> +		if (test_bit(work->bit, &bits))
>  			work->func(work, &trace, cookie);
> -			clear_bit(work->bit, &info->unwind_mask);
> -		}
>  	}
>  	srcu_read_unlock(&unwind_srcu, idx);
>  }
> @@ -194,15 +200,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
>   * because it has already been previously called for the same entry context,
>   * it will be called again with the same stack trace and cookie.
>   *
> - * Return: 1 if the the callback was already queued.
> - *         0 if the callback successfully was queued.
> + * Return: 0 if the callback successfully was queued.
> + *         UNWIND_ALREADY_PENDING if the the callback was already queued.
> + *         UNWIND_ALREADY_EXECUTED if the callback was already called
> + *                (and will not be called again)
>   *         Negative if there's an error.
>   *         @cookie holds the cookie of the first request by any user
>   */

Lots of babbling in the Changelog, but no real elucidation as to why you
need this second return value.

AFAICT it serves no real purpose; the users of this function should not
care. The only difference is that the unwind reference (your cookie)
becomes a backward reference instead of a forward reference. But why
would anybody care?

Whatever tool is ultimately in charge of gluing humpty^Wstacktraces back
together again should have no problem with this.

>  int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  {
>  	struct unwind_task_info *info = &current->unwind_info;
> -	long pending;
> +	unsigned long old, bits;
>  	int bit;
>  	int ret;
>  
> @@ -225,32 +233,52 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  
>  	*cookie = get_cookie(info);
>  
> -	/* This is already queued */
> -	if (test_bit(bit, &info->unwind_mask))
> -		return 1;
> +	old = READ_ONCE(info->unwind_mask);
> +
> +	/* Is this already queued */
> +	if (test_bit(bit, &old)) {
> +		/*
> +		 * If pending is not set, it means this work's callback
> +		 * was already called.
> +		 */
> +		return old & UNWIND_PENDING ? UNWIND_ALREADY_PENDING :
> +			UNWIND_ALREADY_EXECUTED;
> +	}
>  
> -	/* callback already pending? */
> -	pending = local_read(&info->pending);
> -	if (pending)
> +	if (unwind_pending(info))
>  		goto out;
>  
> +	/*
> +	 * This is the first to enable another task_work for this task since
> +	 * the task entered the kernel, or had already called the callbacks.
> +	 * Set only the bit for this work and clear all others as they have
> +	 * already had their callbacks called, and do not need to call them
> +	 * again because of this work.
> +	 */
> +	bits = UNWIND_PENDING | BIT(bit);
> +
> +	/*
> +	 * If the cmpxchg() fails, it means that an NMI came in and set
> +	 * the pending bit as well as cleared the other bits. Just
> +	 * jump to setting the bit for this work.
> +	 */
>  	if (CAN_USE_IN_NMI) {
> -		/* Claim the work unless an NMI just now swooped in to do so. */
> -		if (!local_try_cmpxchg(&info->pending, &pending, 1))
> +		if (!try_cmpxchg(&info->unwind_mask, &old, bits))
>  			goto out;
>  	} else {
> -		local_set(&info->pending, 1);
> +		info->unwind_mask = bits;
>  	}
>  
>  	/* The work has been claimed, now schedule it. */
>  	ret = task_work_add(current, &info->work, TWA_RESUME);
> -	if (WARN_ON_ONCE(ret)) {
> -		local_set(&info->pending, 0);
> -		return ret;
> -	}
>  
> +	if (WARN_ON_ONCE(ret))
> +		WRITE_ONCE(info->unwind_mask, 0);
> +
> +	return ret;
>   out:
> -	return test_and_set_bit(bit, &info->unwind_mask);
> +	return test_and_set_bit(bit, &info->unwind_mask) ?
> +		UNWIND_ALREADY_PENDING : 0;
>  }

This is some of the most horrifyingly confused code I've seen in a
while.

Please just slow down and think for a minute.

The below is the last four patches rolled into one. Not been near a
compiler.

---

--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -524,4 +524,8 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_st
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
 
+DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,
+		    _T->idx = srcu_read_lock_lite(_T->lock),
+		    srcu_read_unlock_lite(_T->lock, _T->idx),
+		    int idx)
 #endif
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -13,10 +13,14 @@ typedef void (*unwind_callback_t)(struct
 struct unwind_work {
 	struct list_head		list;
 	unwind_callback_t		func;
+	int				bit;
 };
 
 #ifdef CONFIG_UNWIND_USER
 
+#define UNWIND_PENDING_BIT	0
+#define UNWIND_PENDING		BIT(UNWIND_PENDING_BIT)
+
 void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
@@ -28,15 +32,26 @@ void unwind_deferred_cancel(struct unwin
 
 static __always_inline void unwind_reset_info(void)
 {
-	if (unlikely(current->unwind_info.id.id))
+	struct unwind_task_info *info = &current->unwind_info;
+	unsigned long bits;
+
+	/* Was there any unwinding? */
+	if (unlikely(info->unwind_mask)) {
+		bits = raw_atomic_long_read(&info->unwind_mask);
+		do {
+			/* Is a task_work going to run again before going back */
+			if (bits & UNWIND_PENDING)
+				return;
+		} while (!raw_atomic_long_try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 		current->unwind_info.id.id = 0;
+	}
 	/*
 	 * As unwind_user_faultable() can be called directly and
 	 * depends on nr_entries being cleared on exit to user,
 	 * this needs to be a separate conditional.
 	 */
-	if (unlikely(current->unwind_info.cache))
-		current->unwind_info.cache->nr_entries = 0;
+	if (unlikely(info->cache))
+		info->cache->nr_entries = 0;
 }
 
 #else /* !CONFIG_UNWIND_USER */
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+#include <linux/atomic.h>
+
 struct unwind_cache {
 	unsigned int		nr_entries;
 	unsigned long		entries[];
@@ -19,8 +21,8 @@ union unwind_task_id {
 struct unwind_task_info {
 	struct unwind_cache	*cache;
 	struct callback_head	work;
+	atomic_long_t		unwind_mask;
 	union unwind_task_id	id;
-	int			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -12,13 +12,39 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 
+/*
+ * For requesting a deferred user space stack trace from NMI context
+ * the architecture must support a safe cmpxchg in NMI context.
+ * For those architectures that do not have that, then it cannot ask
+ * for a deferred user space stack trace from an NMI context. If it
+ * does, then it will get -EINVAL.
+ */
+#ifdef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
+#define UNWIND_NMI_SAFE 1
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	u32 zero = 0;
+	return try_cmpxchg(&info->id.cnt, &zero, cnt);
+}
+#else
+#define UNWIND_NMI_SAFE 0
+/* When NMIs are not allowed, this always succeeds */
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	info->id.cnt = cnt;
+	return true;
+}
+#endif /* CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG */
+
 /* Make the cache fit in a 4K page */
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
 
-/* Guards adding to and reading the list of callbacks */
+/* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
+static unsigned long unwind_mask;
+DEFINE_STATIC_SRCU(unwind_srcu);
 
 /*
  * This is a unique percpu identifier for a given task entry context.
@@ -41,21 +67,16 @@ static DEFINE_PER_CPU(u32, unwind_ctx_ct
  */
 static u64 get_cookie(struct unwind_task_info *info)
 {
-	u32 cpu_cnt;
-	u32 cnt;
-	u32 old = 0;
+	u32 cnt = 1;
 
 	if (info->id.cpu)
 		return info->id.id;
 
-	cpu_cnt = __this_cpu_read(unwind_ctx_ctr);
-	cpu_cnt += 2;
-	cnt = cpu_cnt | 1; /* Always make non zero */
-
-	if (try_cmpxchg(&info->id.cnt, &old, cnt)) {
-		/* Update the per cpu counter */
-		__this_cpu_write(unwind_ctx_ctr, cpu_cnt);
-	}
+	/* LSB it always set to ensure 0 is an invalid value. */
+	cnt |= __this_cpu_read(unwind_ctx_ctr) + 2;
+	if (try_assign_cnt(info, cnt))
+		__this_cpu_write(unwind_ctx_ctr, cnt);
+
 	/* Interrupts are disabled, the CPU will always be same */
 	info->id.cpu = smp_processor_id() + 1; /* Must be non zero */
 
@@ -117,13 +138,13 @@ static void unwind_deferred_task_work(st
 	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
+	unsigned long bits;
 	u64 cookie;
 
-	if (WARN_ON_ONCE(!info->pending))
+	if (WARN_ON_ONCE(!unwind_pending(info)))
 		return;
 
-	/* Allow work to come in again */
-	WRITE_ONCE(info->pending, 0);
+	bits = atomic_long_fetch_andnot(UNWIND_PENDING, &info->unwind_mask);
 
 	/*
 	 * From here on out, the callback must always be called, even if it's
@@ -136,9 +157,11 @@ static void unwind_deferred_task_work(st
 
 	cookie = info->id.id;
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
-		work->func(work, &trace, cookie);
+	guard(srcu_lite)(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
+		if (test_bit(work->bit, &bits))
+			work->func(work, &trace, cookie);
 	}
 }
 
@@ -162,7 +185,7 @@ static void unwind_deferred_task_work(st
  * because it has already been previously called for the same entry context,
  * it will be called again with the same stack trace and cookie.
  *
- * Return: 1 if the the callback was already queued.
+ * Return: 1 if the callback was already queued.
  *         0 if the callback successfully was queued.
  *         Negative if there's an error.
  *         @cookie holds the cookie of the first request by any user
@@ -170,41 +193,62 @@ static void unwind_deferred_task_work(st
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-	int ret;
+	unsigned long bits, mask;
+	int bit, ret;
 
 	*cookie = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	/* NMI requires having safe cmpxchg operations */
+	if (WARN_ON_ONCE(!UNWIND_NMI_SAFE && in_nmi()))
+		return -EINVAL;
+
+	/* Do not allow cancelled works to request again */
+	bit = READ_ONCE(work->bit);
+	if (WARN_ON_ONCE(bit < 0))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
-	/* callback already pending? */
-	if (info->pending)
+	bits = UNWIND_PENDING | BIT(bit);
+	mask = atomic_long_fetch_or(bits, &info->unwind_mask);
+	if (mask & bits)
 		return 1;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
 	if (WARN_ON_ONCE(ret))
-		return ret;
-
-	info->pending = 1;
-	return 0;
+		atomic_long_set(0, &info->unwind_mask);
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
 {
+	struct task_struct *g, *t;
+	int bit;
+
 	if (!work)
 		return;
 
 	guard(mutex)(&callback_mutex);
-	list_del(&work->list);
+	list_del_rcu(&work->list);
+	bit = work->bit;
+
+	/* Do not allow any more requests and prevent callbacks */
+	work->bit = -1;
+
+	__clear_bit(bit, &unwind_mask);
+
+	synchronize_srcu(&unwind_srcu);
+
+	guard(rcu)();
+	/* Clear this bit from all threads */
+	for_each_process_thread(g, t)
+		atomic_long_andnot(BIT(bit), &t->unwind_info.unwind_mask);
 }
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
@@ -212,7 +256,15 @@ int unwind_deferred_init(struct unwind_w
 	memset(work, 0, sizeof(*work));
 
 	guard(mutex)(&callback_mutex);
-	list_add(&work->list, &callbacks);
+
+	/* See if there's a bit in the mask available */
+	if (unwind_mask == ~UNWIND_PENDING)
+		return -EBUSY;
+
+	work->bit = ffz(unwind_mask);
+	__set_bit(work->bit, &unwind_mask);
+
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }


