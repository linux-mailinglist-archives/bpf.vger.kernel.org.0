Return-Path: <bpf+bounces-49644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E698A1AF35
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BE516A40D
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63B1D79B4;
	Fri, 24 Jan 2025 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVXttmkK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40F1D7998
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691030; cv=none; b=OrdM+jQA42N04/e87eHaPW6WQNOmgvNjYDkL6FcA//pN4tbiRS+v+VG9I1QYdUN+ygeXF6w+ijE44T9H06gQLwqy6dNk7aI6n8cegt6mZ6OLHtQT3v+4i0LbE1pkvYGdQkpZm2ZM41SIJ1u2wiUG/HNnh1MidPa11EA50+KOiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691030; c=relaxed/simple;
	bh=6Qk1+Qx2cCbWbbuR9eij2Zo5YTD9MoCgs+QDBDGb+LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dm1zNseJQJr9py49qbbQ7wQcYOoi6WYq4rS7HRGMzOtWf9O5thLiYDiAb0ZgPZQ8JnjsV2YCqZCWSmeLnUZ3ZTrbc3mJjgpiz7DBuWHcC0D2D+wmEqQoWoL0/wwdYrVPflrpXwj5SHdKCYTMn4bNf6HQ9hN1G5tlGOs9VttrNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVXttmkK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso2510929a91.1
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691028; x=1738295828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhWoq2FKuOuB0wGZug1HgiVNgCDD6ysBALAFLwpbX6U=;
        b=KVXttmkKyPW4PtSV2KwZtKz3Zv1DdLfcZ7y4Uon9jOrXNrZ8HcQMXkMiArYc4k7FAh
         NCZCBHec+2uwD4YVmgSmmfNWh3sCpRbn/1rl8uO2bfyNkuiAC9acZlgBEPprT7c9ILKH
         PTXr2E2zt1GbaSES+GYL5uxwM1o0s8p7Lvj9YEVwSOgl7p/v130MYC9qhX58Uh5XGTKY
         F6CTQRRFt94xXKhcX1fcE/pbPvdqkMTluOcXE53jt9TihzNuJvEE5pgaupxYeTTfipXj
         w4+uGqUiIUonglXeBc0q1sHvS+GsjTid/tGcXLSD1dn7WLpxVLRe+KcBJVZJPmwVuOej
         C6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691028; x=1738295828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhWoq2FKuOuB0wGZug1HgiVNgCDD6ysBALAFLwpbX6U=;
        b=kKDeTSeJ5bp8Q2E5FOpwARh0MIh/tuPSHoW8KgwzOiJFPk97kyw7mgrd2v9MlLupDZ
         Jz7udMjHy9kd/uqVTqhv8PlL9eZZD9yacUaw6Kz1nDpr6sKw3gqOUA6tadotEP+Q00Jq
         TSK7ovc4X80S43PsVVK9Ls7MgKCCM/cdpHqHEv75LNWxSRXizgwVvgyP0ILriImV6ncg
         8GBFOzUd5Aq01rdP2HDjAyBMJJw6CK4kjtkytA87YPg0hIaB3EbGiNQBURBYbO8Ml7sU
         8exmvlqZhlTJ3Y9ROoO2E6IyIbzhNXIs9mB4I0/JFgW2cQNLpxfE1G6ig2qMiZHSwTlE
         9lgA==
X-Gm-Message-State: AOJu0Ywt8dYpNoIdgehVCOn0XrDtRozUYgT/ppnR//RpVQL9DtWl/19s
	YEa9o6sQ6+AY4U9e3wvyN9Z/eU0iCgUyF53xNcFGOfpC216gqDz36r6XOA==
X-Gm-Gg: ASbGnctup1vZ50RdsC7p3wxYUGkNxNd8e4+S8RDYeermp7Bn0pmrkxj5vQzWHlhz9iv
	1+4c6xGLlKJCc0xkVZagkt6t1A4VNeCKMy5+44PXoSKtdchdLusuFkKHjQJJXb0q6duKAWfOD2u
	Xo8zMZDYosE4tc1iF89LUw0iNLpU8FA95YKJGmcdEe9NpezPjm5oD7cRDdqLbp4tG5lqHbq97As
	YXAiPHhkc1z46Gs9Nlfx8dWl7vZeAP+2Lx+dUPTVB+ob4Md+zOoJ2HPRKTf+Qpx65EXHAnVW4SW
	Dbn8Q6wOGQXLefjjqy0xqjZiYzr1SnH9x5Ok8qA=
X-Google-Smtp-Source: AGHT+IHjf895nN6HJ8zSuYUNSFGgzi7wNzn53xXi9fqFCiweThxJGpq1eNj/CM9sNN+YbDe1QrSLvw==
X-Received: by 2002:a17:90b:3bc3:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-2f782d9a9eamr46529484a91.33.1737691027837;
        Thu, 23 Jan 2025 19:57:07 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffaf8b34sm541383a91.30.2025.01.23.19.57.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 19:57:07 -0800 (PST)
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
Subject: [PATCH bpf-next v6 3/6] locking/local_lock: Introduce local_trylock_t and local_trylock_irqsave()
Date: Thu, 23 Jan 2025 19:56:52 -0800
Message-Id: <20250124035655.78899-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
critical section, but it doesn't prevent NMI, so the fully reentrant
code cannot use local_lock_irqsave() for exclusive access.

Introduce local_trylock_t and local_trylock_irqsave() that
disables interrupts and sets active=1, so local_trylock_irqsave()
from NMI of the same lock will return false.

In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
Map local_trylock_irqsave() to preemptible spin_trylock().
When in hard IRQ or NMI return false right away, since
spin_trylock() is not safe due to PI issues.

Note there is no need to use local_inc for active variable,
since it's a percpu variable with strict nesting scopes.

Usage:

local_lock_t lock;                     // sizeof(lock) == 0 in !RT
local_lock_irqsave(&lock, ...);        // irqsave as before
if (local_trylock_irqsave(&lock, ...)) // compilation error

local_trylock_t lock;                  // sizeof(lock) == 4 in !RT
local_lock_irqsave(&lock, ...);        // irqsave and active = 1
if (local_trylock_irqsave(&lock, ...)) // if (!active) irqsave

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  9 ++++
 include/linux/local_lock_internal.h | 79 ++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 091dc0b6bdfb..f4bc3e9b2b20 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -30,6 +30,15 @@
 #define local_lock_irqsave(lock, flags)				\
 	__local_lock_irqsave(lock, flags)
 
+/**
+ * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			   interrupts. Fails in PREEMPT_RT when in hard IRQ or NMI.
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ */
+#define local_trylock_irqsave(lock, flags)			\
+	__local_trylock_irqsave(lock, flags)
+
 /**
  * local_unlock - Release a per CPU local lock
  * @lock:	The lock variable
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 8dd71fbbb6d2..14757b7aea99 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -15,6 +15,19 @@ typedef struct {
 #endif
 } local_lock_t;
 
+typedef struct {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+	struct task_struct	*owner;
+#endif
+	/*
+	 * Same layout as local_lock_t with 'active' field
+	 * at the end, since (local_trylock_t *) will be
+	 * casted to (local_lock_t *).
+	 */
+	int active;
+} local_trylock_t;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define LOCAL_LOCK_DEBUG_INIT(lockname)		\
 	.dep_map = {					\
@@ -31,6 +44,13 @@ static inline void local_lock_acquire(local_lock_t *l)
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
@@ -45,6 +65,7 @@ static inline void local_lock_debug_init(local_lock_t *l)
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_trylock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
 static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
@@ -87,10 +108,37 @@ do {								\
 
 #define __local_lock_irqsave(lock, flags)			\
 	do {							\
+		local_trylock_t *tl;				\
+		local_lock_t *l;				\
 		local_irq_save(flags);				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		l = (local_lock_t *)this_cpu_ptr(lock);		\
+		tl = (local_trylock_t *)l;			\
+		_Generic((lock),				\
+			local_trylock_t *: ({			\
+				lockdep_assert(tl->active == 0);\
+				WRITE_ONCE(tl->active, 1);	\
+			}),					\
+			default:(void)0);			\
+		local_lock_acquire(l);				\
 	} while (0)
 
+
+#define __local_trylock_irqsave(lock, flags)			\
+	({							\
+		local_trylock_t *tl;				\
+		local_irq_save(flags);				\
+		tl = this_cpu_ptr(lock);			\
+		if (READ_ONCE(tl->active) == 1) {		\
+			local_irq_restore(flags);		\
+			tl = NULL;				\
+		} else {					\
+			WRITE_ONCE(tl->active, 1);		\
+			local_trylock_acquire(			\
+				(local_lock_t *)tl);		\
+		}						\
+		!!tl;						\
+	})
+
 #define __local_unlock(lock)					\
 	do {							\
 		local_lock_release(this_cpu_ptr(lock));		\
@@ -105,7 +153,17 @@ do {								\
 
 #define __local_unlock_irqrestore(lock, flags)			\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		local_trylock_t *tl;				\
+		local_lock_t *l;				\
+		l = (local_lock_t *)this_cpu_ptr(lock);		\
+		tl = (local_trylock_t *)l;			\
+		_Generic((lock),				\
+			local_trylock_t *: ({			\
+				lockdep_assert(tl->active == 1);\
+				WRITE_ONCE(tl->active, 0);	\
+			}),					\
+			default:(void)0);			\
+		local_lock_release(l);				\
 		local_irq_restore(flags);			\
 	} while (0)
 
@@ -125,6 +183,7 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
+typedef spinlock_t local_trylock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
 
@@ -148,6 +207,22 @@ typedef spinlock_t local_lock_t;
 		__local_lock(lock);				\
 	} while (0)
 
+#define __local_trylock_irqsave(lock, flags)			\
+	({							\
+		__label__ out;					\
+		int ret = 0;					\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		if (in_nmi() || in_hardirq())			\
+			goto out;				\
+		migrate_disable();				\
+		ret = spin_trylock(this_cpu_ptr((lock)));	\
+		if (!ret)					\
+			migrate_enable();			\
+	out:							\
+		ret;						\
+	})
+
 #define __local_unlock(__lock)					\
 	do {							\
 		spin_unlock(this_cpu_ptr((__lock)));		\
-- 
2.43.5


