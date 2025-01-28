Return-Path: <bpf+bounces-49974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3BA20F8A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 18:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B503A3DD4
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983BF1DE3DD;
	Tue, 28 Jan 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RS36gzQL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ka5PDexh"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448041CDFD5
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084903; cv=none; b=E4vD9SGmjxf7Zdm3WICmUm8+KGG4MhFulZu0wcUTQgQiL83bWM07ZENK+q4DCOxQxR71vDAq2LnKbDmR843HhkyNVBZnCxmlvQclYqfzXJG3/AP00QcHuMZd0yjtDiNxMRVn+tYkuoUGLrxyO7kY3K+mYEKOtON8qGvV0DNtOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084903; c=relaxed/simple;
	bh=bRaw5BbzRZN4GeebOuH76POYP/O165F58ttXnN/pUvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUx5nNpO931aA4+AMde146ySGGlh3QRE4MOdcuCUTBCxlwk8zRpQQVVSzoomGLsUZ20dkmGSxdxPkIU0oApgvJysCLG38tzm4X55HKvJSqlL07/Ac1uYiYWko3hG4B6A2AgvmDD7wkCScFieRmDRtY2koRZRxilz6NjSHA2Sr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RS36gzQL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ka5PDexh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Jan 2025 18:21:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738084899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOJUlAo7lz1CwdMKpv46rlAJOwnNrK33eU6Dw3GvpRY=;
	b=RS36gzQLNYLvo/gP8Pu3Qw+zafkf6Vyzb3rQz+36Z4CDthljPupCFikNp0MNMl1AXuWZ+/
	7/a5KjvD28hNar6vx4iMVRRGQYN5IC0AwDuMARcCxXjdlzfc2Ao1R6hw0Di7TXrW5bbEYK
	Yh4Ye2v9lheN+5fJMdaOTpRXxnhici02bM7H+1bgxKlxL5nKycx+/+E4dztIAVpcCgRcYf
	vhrupS1PipeRLed5lz29oo+RJBNjh1GklFQ/nJXBHwRmj0+YHpiBxj4xM1XtfI03pH5ux+
	pv0jIw8/7ffpViTNzV7aXhSWWt5Cfkwi89J9XeUMV9tzEMIAtJehdaRKz3BUkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738084899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOJUlAo7lz1CwdMKpv46rlAJOwnNrK33eU6Dw3GvpRY=;
	b=Ka5PDexhtF5JhuaPwa5lr6lrqXmXclnV44mzF0L9JhPN2+u5ZT5ueMiRFKfP0WgONYda9G
	qIi5tstpIZoOTuCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v6 3/6] locking/local_lock: Introduce
 local_trylock_t and local_trylock_irqsave()
Message-ID: <20250128172137.bLPGqHth@linutronix.de>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <20250124035655.78899-4-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124035655.78899-4-alexei.starovoitov@gmail.com>

On 2025-01-23 19:56:52 [-0800], Alexei Starovoitov wrote:
> Usage:
> 
> local_lock_t lock;                     // sizeof(lock) == 0 in !RT
> local_lock_irqsave(&lock, ...);        // irqsave as before
> if (local_trylock_irqsave(&lock, ...)) // compilation error
> 
> local_trylock_t lock;                  // sizeof(lock) == 4 in !RT
> local_lock_irqsave(&lock, ...);        // irqsave and active = 1
> if (local_trylock_irqsave(&lock, ...)) // if (!active) irqsave

so I've been looking at this for a while and I don't like the part where
the type is hidden away. It is then casted back. So I tried something
with _Generics but then the existing guard implementation complained.
Then I asked myself why do we want to hide much of the implementation
and not make it obvious. So I made a few macros to hide most of the
implementation for !RT. Later I figured if the variable is saved locally
then I save one this_cpu_ptr invocation. So I wrote it out and the
snippet below is what I have.

is this anywhere near possible to accept?

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 091dc0b6bdfb9..05c254a5d7d3e 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,6 +51,65 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
 
+/**
+ * localtry_lock_init - Runtime initialize a lock instance
+ */
+#define localtry_lock_init(lock)		__localtry_lock_init(lock)
+
+/**
+ * localtry_lock - Acquire a per CPU local lock
+ * @lock:	The lock variable
+ */
+#define localtry_lock(lock)		__localtry_lock(lock)
+
+/**
+ * localtry_lock_irq - Acquire a per CPU local lock and disable interrupts
+ * @lock:	The lock variable
+ */
+#define localtry_lock_irq(lock)		__localtry_lock_irq(lock)
+
+/**
+ * localtry_lock_irqsave - Acquire a per CPU local lock, save and disable
+ *			 interrupts
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ */
+#define localtry_lock_irqsave(lock, flags)				\
+	__localtry_lock_irqsave(lock, flags)
+
+/**
+ * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			      interrupts if acquired
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ *
+ * The function can be used in any context such as NMI or HARDIRQ. Due to
+ * locking constrains it will _always_ fail to acquire the lock on PREEMPT_RT.
+ */
+#define localtry_trylock_irqsave(lock, flags)				\
+	__localtry_trylock_irqsave(lock, flags)
+
+/**
+ * local_unlock - Release a per CPU local lock
+ * @lock:	The lock variable
+ */
+#define localtry_unlock(lock)		__localtry_unlock(lock)
+
+/**
+ * local_unlock_irq - Release a per CPU local lock and enable interrupts
+ * @lock:	The lock variable
+ */
+#define localtry_unlock_irq(lock)		__localtry_unlock_irq(lock)
+
+/**
+ * localtry_unlock_irqrestore - Release a per CPU local lock and restore
+ *			      interrupt flags
+ * @lock:	The lock variable
+ * @flags:      Interrupt flags to restore
+ */
+#define localtry_unlock_irqrestore(lock, flags)			\
+	__localtry_unlock_irqrestore(lock, flags)
+
 DEFINE_GUARD(local_lock, local_lock_t __percpu*,
 	     local_lock(_T),
 	     local_unlock(_T))
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 8dd71fbbb6d2b..789b0d878e6c5 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -15,6 +15,11 @@ typedef struct {
 #endif
 } local_lock_t;
 
+typedef struct {
+	local_lock_t	llock;
+	unsigned int	acquired;
+} localtry_lock_t;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define LOCAL_LOCK_DEBUG_INIT(lockname)		\
 	.dep_map = {					\
@@ -50,6 +55,7 @@ static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
+#define INIT_LOCALTRY_LOCK(lockname)	{ .llock = { LOCAL_LOCK_DEBUG_INIT(lockname.llock) }}
 
 #define __local_lock_init(lock)					\
 do {								\
@@ -118,6 +124,86 @@ do {								\
 #define __local_unlock_nested_bh(lock)				\
 	local_lock_release(this_cpu_ptr(lock))
 
+/* localtry_lock_t variants */
+
+#define __localtry_lock_init(lock)				\
+do {								\
+	__local_lock_init(&(lock)->llock);			\
+	WRITE_ONCE(&(lock)->acquired, 0);			\
+} while (0)
+
+#define __localtry_lock(lock)					\
+	do {							\
+		localtry_lock_t *lt;				\
+		preempt_disable();				\
+		lt = this_cpu_ptr(lock);			\
+		local_lock_acquire(&lt->llock);			\
+		WRITE_ONCE(lt->acquired, 1);			\
+	} while (0)
+
+#define __localtry_lock_irq(lock)				\
+	do {							\
+		localtry_lock_t *lt;				\
+		local_irq_disable();				\
+		lt = this_cpu_ptr(lock);			\
+		local_lock_acquire(&lt->llock);			\
+		WRITE_ONCE(lt->acquired, 1);			\
+	} while (0)
+
+#define __localtry_lock_irqsave(lock, flags)			\
+	do {							\
+		localtry_lock_t *lt;				\
+		local_irq_save(flags);				\
+		lt = this_cpu_ptr(lock);			\
+		local_lock_acquire(&lt->llock);			\
+		WRITE_ONCE(lt->acquired, 1);			\
+	} while (0)
+
+#define __localtry_trylock_irqsave(lock, flags)			\
+	({							\
+		localtry_lock_t *lt;				\
+		bool _ret;					\
+								\
+		local_irq_save(flags);				\
+		lt = this_cpu_ptr(lock);			\
+		if (!READ_ONCE(lt->acquired)) {			\
+			local_lock_acquire(&lt->llock);		\
+			WRITE_ONCE(lt->acquired, 1);		\
+			_ret = true;				\
+		} else {					\
+			_ret = false;				\
+			local_irq_restore(flags);		\
+		}						\
+		_ret;						\
+	})
+
+#define __localtry_unlock(lock)					\
+	do {							\
+		localtry_lock_t *lt;				\
+		lt = this_cpu_ptr(lock);			\
+		WRITE_ONCE(lt->acquired, 0);			\
+		local_lock_release(&lt->llock);			\
+		preempt_enable();				\
+	} while (0)
+
+#define __localtry_unlock_irq(lock)				\
+	do {							\
+		localtry_lock_t *lt;				\
+		lt = this_cpu_ptr(lock);			\
+		WRITE_ONCE(lt->acquired, 0);			\
+		local_lock_release(&lt->llock);			\
+		local_irq_enable();				\
+	} while (0)
+
+#define __localtry_unlock_irqrestore(lock, flags)		\
+	do {							\
+		localtry_lock_t *lt;				\
+		lt = this_cpu_ptr(lock);			\
+		WRITE_ONCE(lt->acquired, 0);			\
+		local_lock_release(&lt->llock);			\
+		local_irq_restore(flags);			\
+	} while (0)
+
 #else /* !CONFIG_PREEMPT_RT */
 
 /*
@@ -125,8 +211,10 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
+typedef spinlock_t localtry_lock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+#define INIT_LOCALTRY_LOCK(lockname) INIT_LOCAL_LOCK(lockname)
 
 #define __local_lock_init(l)					\
 	do {							\
@@ -169,4 +257,31 @@ do {								\
 	spin_unlock(this_cpu_ptr((lock)));			\
 } while (0)
 
+/* localtry_lock_t variants */
+
+#define __localtry_lock_init(lock)			__local_lock_init(lock)
+#define __localtry_lock(lock)				__local_lock(lock)
+#define __localtry_lock_irq(lock)			__local_lock(lock)
+#define __localtry_lock_irqsave(lock, flags)		__local_lock_irqsave(lock, flags)
+#define __localtry_unlock(lock)				__local_unlock(lock)
+#define __localtry_unlock_irq(lock)			__local_unlock(lock)
+#define __localtry_unlock_irqrestore(lock, flags)	__local_unlock_irqrestore(lock, flags)
+
+#define __localtry_trylock_irqsave(lock, flags)			\
+	({							\
+		int __locked;					\
+								\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		if (in_nmi() | in_hardirq()) {			\
+			__locked = 0;				\
+		} else {					\
+			migrate_disable();			\
+			__locked = spin_trylock(this_cpu_ptr((lock)));	\
+			if (!__locked)				\
+				migrate_enable();		\
+		}						\
+		__locked;					\
+	})
+
 #endif /* CONFIG_PREEMPT_RT */

