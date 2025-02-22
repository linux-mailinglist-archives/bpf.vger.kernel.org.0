Return-Path: <bpf+bounces-52234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D5A40525
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A43421D92
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267051FDA76;
	Sat, 22 Feb 2025 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM1ootlN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E351FBEB3
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192279; cv=none; b=mCf93VDHs79oNhU439Q5zZyAhobXN+Z9gvoq0m6ALVkLh+CvMK0f64B4dOZg21JAB0ZE4ke1lWIJJBVGiIU7qUsaJUgSyNbTVN9Amil07sK9kHTgfTdKBwzjHm7VMiq5gmCScWHwtWCsOaLpzEipjdCVheXz0Vpj47YGL4pffJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192279; c=relaxed/simple;
	bh=WL71uV2ZNGnRr+mbHVLa0ks+Vqr1Ig6jqQJVVIKQsBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dC87WP8+p8Z2X5T5+9op5hM6nHY+6JI1fPcIEYXwiFdgHZwFupfNJJOywv/BfrOBXiAeoHm05xgNKjluKo+DdTcO1/nhU01oZsXeUqxuHZEaqgN82sFAOx2XhJ/RlvA7moh3Z5rC0g6Gdc0ilEsLSgzwHUtaFlruray8/Nte48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM1ootlN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so5573301a91.2
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740192276; x=1740797076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk02Orm/sDWbmfQ5EAte0I5oPgAuhzQ+C9dMQxWikoo=;
        b=UM1ootlN2ZwEm00j3RFU+f/tPn5wSGiSvk1JLNsyBog88J2a03rBdScFABbDFgZVwB
         lrXlW31XxZXFH4Taddvvj3ZBdmLp8jf06hhll6cd3Bml8LZgiCN5Rsa/5+7r/ZnU6BPt
         xRyOGHtSUCqH/v6u8nCWNiP4YMDXNGWJKXlja5zUm+Btjl2jDDWCazgMOl2thy2/NI8K
         i4VQaobh9KtxqDY4KMPt6jXOWB2FtF9R9j+ZLtawh3twlSAEX/S+AsFkGpx+hHDqo4oZ
         VdId6UtuKUIvGIArM1yqsHgw0jegbopKHaPPN2rZB72JKgiZovrIZrvFTHEDqEWLG2MR
         atmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740192276; x=1740797076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk02Orm/sDWbmfQ5EAte0I5oPgAuhzQ+C9dMQxWikoo=;
        b=VQtiGNV+hApehNmesQIO2Jl8KJyoYvFdClHPsBJrb22zyxOBt71gg4TZJ5Hvxxb9HS
         fYUo74AQOwXckcPSLS/ksXw+h34J3jJ6V5pH5OUOAbeLKh+95Xh60WrlkzpwfnkT8PaV
         yNv7sdKj5vViexk9ABLatAvhJLhdrU7sT3gSWmxV85N+DePdB7htyVv0QuvwyYJut6Yu
         tEIYBwFYmMxcy4gHUwOkF0HLF3Jdiv5h8alwpntzv3sz4mKpv7KIShQxYDTHBcIgAT/B
         mxCKKZHviX0gyJcUz9rBf7vwgHfsN4DDuZKsI4Ezg5HF7Mb+Mk0MEztX6xSurn96JMY9
         9kkA==
X-Gm-Message-State: AOJu0YyiLNBL7BriqPfSxnhK1tKy4FFrlOWcQcouV6kSUDVLGDpuZXNI
	1Bi078mw8m47R9IIOCZ9TL2QQ6RP4nkKIE3cah3stJF6/OqatczN5+rstQ==
X-Gm-Gg: ASbGnctM4iiWfsn/yFJq/kT51Psb1u43nVofAEbDzGCyzoI9JFPzU/Y8ViO+Zi+7DLK
	cqlTR/yhaJqBc1anOKUnG+f0eEpoMXMSI5LdInoocxPt0VMVf2khbF9JV+ie5+BH+TYdfFwAKx7
	btOtuIDwYLUz2RscbgA7UHdVvKIyrMVJVgaIGFmkntt4IrQq4Xo7JaafjehnxgKizDw4AWqSf18
	qSFKAbRXM1bOnYEgyVtY8839QzOn8bPaLR3GWTtJoOzkzNMmBQ1bRxJki9I2DKu5CYxQM/BXMuz
	bXP4gu1I9bQfzJ8cbAcUvJ8jTJYosompPX74rHFb8RVDlZDkyGqwDA==
X-Google-Smtp-Source: AGHT+IGlSaTzpWPllvJGdoZ8RptnpXSPkTv04MwCkc6eCe1wznNZ2YqQBDcM5ibR5tXrH+w8nZ0TTA==
X-Received: by 2002:a05:6a00:4fc4:b0:730:7771:39c6 with SMTP id d2e1a72fcca58-73426cab09emr10492884b3a.8.1740192276435;
        Fri, 21 Feb 2025 18:44:36 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fd1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546158sm17069167b3a.16.2025.02.21.18.44.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 18:44:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce localtry_lock_t
Date: Fri, 21 Feb 2025 18:44:22 -0800
Message-Id: <20250222024427.30294-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
critical section, but it doesn't prevent NMI, so the fully reentrant
code cannot use local_lock_irqsave() for exclusive access.

Introduce localtry_lock_t and localtry_lock_irqsave() that
disables interrupts and sets acquired=1, so localtry_lock_irqsave()
from NMI attempting to acquire the same lock will return false.

In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
Map localtry_lock_irqsave() to preemptible spin_trylock().
When in hard IRQ or NMI return false right away, since
spin_trylock() is not safe due to explicit locking in the underneath
rt_spin_trylock() implementation. Removing this explicit locking and
attempting only "trylock" is undesired due to PI implications.

Note there is no need to use local_inc for acquired variable,
since it's a percpu variable with strict nesting scopes.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  70 +++++++++++++
 include/linux/local_lock_internal.h | 146 ++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 091dc0b6bdfb..1a0bc35839e3 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,6 +51,76 @@
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
+ * localtry_trylock - Try to acquire a per CPU local lock.
+ * @lock:	The lock variable
+ *
+ * The function can be used in any context such as NMI or HARDIRQ. Due to
+ * locking constrains it will _always_ fail to acquire the lock in NMI or
+ * HARDIRQ context on PREEMPT_RT.
+ */
+#define localtry_trylock(lock)		__localtry_trylock(lock)
+
+/**
+ * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			      interrupts if acquired
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ *
+ * The function can be used in any context such as NMI or HARDIRQ. Due to
+ * locking constrains it will _always_ fail to acquire the lock in NMI or
+ * HARDIRQ context on PREEMPT_RT.
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
index 8dd71fbbb6d2..67bd13d142fa 100644
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
@@ -31,6 +36,13 @@ static inline void local_lock_acquire(local_lock_t *l)
 	l->owner = current;
 }
 
+static inline void local_trylock_acquire(local_lock_t *l)
+{
+	lock_map_acquire_try(&l->dep_map);
+	DEBUG_LOCKS_WARN_ON(l->owner);
+	l->owner = current;
+}
+
 static inline void local_lock_release(local_lock_t *l)
 {
 	DEBUG_LOCKS_WARN_ON(l->owner != current);
@@ -45,11 +57,13 @@ static inline void local_lock_debug_init(local_lock_t *l)
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_trylock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
 static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
+#define INIT_LOCALTRY_LOCK(lockname)	{ .llock = { LOCAL_LOCK_DEBUG_INIT(lockname.llock) }}
 
 #define __local_lock_init(lock)					\
 do {								\
@@ -118,6 +132,104 @@ do {								\
 #define __local_unlock_nested_bh(lock)				\
 	local_lock_release(this_cpu_ptr(lock))
 
+/* localtry_lock_t variants */
+
+#define __localtry_lock_init(lock)				\
+do {								\
+	__local_lock_init(&(lock)->llock);			\
+	WRITE_ONCE((lock)->acquired, 0);			\
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
+#define __localtry_trylock(lock)				\
+	({							\
+		localtry_lock_t *lt;				\
+		bool _ret;					\
+								\
+		preempt_disable();				\
+		lt = this_cpu_ptr(lock);			\
+		if (!READ_ONCE(lt->acquired)) {			\
+			WRITE_ONCE(lt->acquired, 1);		\
+			local_trylock_acquire(&lt->llock);	\
+			_ret = true;				\
+		} else {					\
+			_ret = false;				\
+			preempt_enable();			\
+		}						\
+		_ret;						\
+	})
+
+#define __localtry_trylock_irqsave(lock, flags)			\
+	({							\
+		localtry_lock_t *lt;				\
+		bool _ret;					\
+								\
+		local_irq_save(flags);				\
+		lt = this_cpu_ptr(lock);			\
+		if (!READ_ONCE(lt->acquired)) {			\
+			WRITE_ONCE(lt->acquired, 1);		\
+			local_trylock_acquire(&lt->llock);	\
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
@@ -125,8 +237,10 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
+typedef spinlock_t localtry_lock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+#define INIT_LOCALTRY_LOCK(lockname) INIT_LOCAL_LOCK(lockname)
 
 #define __local_lock_init(l)					\
 	do {							\
@@ -169,4 +283,36 @@ do {								\
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
+#define __localtry_trylock(lock)				\
+	({							\
+		int __locked;					\
+								\
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
+#define __localtry_trylock_irqsave(lock, flags)			\
+	({							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__localtry_trylock(lock);			\
+	})
+
 #endif /* CONFIG_PREEMPT_RT */
-- 
2.43.5


