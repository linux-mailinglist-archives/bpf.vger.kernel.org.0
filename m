Return-Path: <bpf+bounces-55200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741EA79A37
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 04:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C78E67A5445
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 02:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7C18C93C;
	Thu,  3 Apr 2025 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpx9pgme"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BC14386D;
	Thu,  3 Apr 2025 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648923; cv=none; b=lzb1a/mPgVzAA+EL34HYfESFdmz1g6NWsvtidoea9goL7lao98qjEnwP+6JHRP+ItE75FgKD8ruZ8e0jTE+LINsJBCM/HOPeFfk2lI5EH195EKI55ZA1OHyiegNP+3I5XDrwTEu4tjr9zPcv6fNlTAgApupHFDG7NvplrwHG8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648923; c=relaxed/simple;
	bh=lF7xCeqnu6WUxrYI8JZbzD65LPB+hMcDiQuyYdVeD1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=laYz0BJF0bwlXdqk54FUXAIpt9uKAlEkbWp/UEC4w6JZxKPKTmJWCXLN2g5qZ8bJA+vnwq76Dy4vvBSqg9sp7hgF/Pa4BrBoaH7apPz5OywTqu15JcEpJ0ridNDJ9nDllHPbzWIOiyFSCHFtX/UqMcgAzOmb+mvREzGBRp/80io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpx9pgme; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af51596da56so407097a12.0;
        Wed, 02 Apr 2025 19:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743648919; x=1744253719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8HvJwspofL3opmVS7sNQqlC6na2Ox7veMaFc22izrMY=;
        b=Zpx9pgmel2AcAcEE7r6QzXhFacZofMYPcfHqx0orS9nbkgmKZeWAEx6Xj7roXlSS31
         +Qy3NlS79xCciWqvoX7pGp+nnxU5B4NF1EwnxAW1BnZGCE1W4metQXKj73qW1Yc5Y5EU
         HJMelPUHTuGBUogofce24uJgIUqsRBG52SKOhrowIMnVxuntR/a+zg/Ki3XliwUflXlH
         PKB4t0Suh+SMIkSZ2tIYZ3t9hCSVp4+n4kx9s8jJrbQi56PrAGZQx8RETUcLjXDNGm37
         UuHsBWp04eYpyY5X1Qk/XIIjRtt016Mbno61gw/q1VAxV1FFiHYDzyuosZaE0gpC/IyM
         iR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743648919; x=1744253719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HvJwspofL3opmVS7sNQqlC6na2Ox7veMaFc22izrMY=;
        b=GM1c5Nw+Fg+s6U7XrcwAuHBEPlFU604U70LgRgd1pHUQXkYRmDNuA4GNd9wn019VuU
         dI7XNWsb5rUy3HR5bW8gdUD+mCmJmzufILfOkZGpwAwUu/s5+PwiZWWyr41VLptvX2p9
         3PuHmoRkZd7PRMWVzGKW/PfqctL3FM9BBdQv3eZY0wfn4ZzIWJHQpUrkjXkItI8bG0b5
         BxqzsKsFpIoxXbtJmhWaOeoi7feOsYxJ/RUMYwjecqZRgWVMbsLQLqbMMhDEJGQsiTOk
         gv8PV7gUx/sPTezkJo7i8jVOy6EkblZL2PY0199N7F/RA+NAyn2JdYrFyu3yrwJSWpAC
         vz2w==
X-Forwarded-Encrypted: i=1; AJvYcCXuHR26YE+e+EIBUuYg6Qtsys1PtxTuDFl+mRX1/21XJybJeVnBTPzq+0nRrOYhe3B/kyx7r0ZxV1iYkYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlMwvg0tBc0VqMM/HlDa4baBfrZ+S++pTUx6qTTsDbW7es3KG
	mljM7lBHgX2bTRbpxOHFLXsNplGGw7bUvc9ZZ+zkmP3aftdcwEUGfnpRrw==
X-Gm-Gg: ASbGncvAfhEFSfveKkrb/HE3BxffM2V0Md0QB1eA5hPPppzp7sqinKkvFR1pcx82Rc3
	TYyppMnBm8lPMvaisrJ1WARO2x+SxzJi052e4abedZBtMyon5NRw6y/HgVCvCFg+96Rk6mxRsKh
	lbbsSiFC3W9fWZHR0J/lj/XGTdNe+lHWX3QsQu0MQP4H8hnlH3jBevEkPjiGO2lgM2RVDqHopzC
	PyzkeEFKob/SMyO3r6F0Cl2agRUSGbFZLLI5B2kRQATyqq9Eqyx6CpjGF8zpk+0tsoTBysxfTws
	45heiDiNNL3MieeVVsZ2/iNeTDVvBlM2LsDqrF1YDSowrcjpE3+8ZYnNhvSFerkkamy4rq27
X-Google-Smtp-Source: AGHT+IHGaLtu9bsoLEbQRzO5L3L4Hbaue1lHXQugDpLzSpRKTGCJVpwHHS1mONaC514HgcDbdsxsVA==
X-Received: by 2002:a17:902:cec3:b0:21f:988d:5758 with SMTP id d9443c01a7336-2292f9dd7a0mr321172215ad.35.1743648919304;
        Wed, 02 Apr 2025 19:55:19 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:22d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865dffcsm3345315ad.127.2025.04.02.19.55.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Apr 2025 19:55:18 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: torvalds@linux-foundation.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] locking/local_lock, mm: Replace localtry_ helpers with local_trylock_t type
Date: Wed,  2 Apr 2025 19:55:14 -0700
Message-Id: <20250403025514.41186-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t").
Remove localtry_*() helpers, since localtry_lock() name might
be misinterpreted as "try lock".

Introduce local_trylock[_irqsave]() helpers that only work
with newly introduced local_trylock_t type.
Note that attempt to use local_trylock[_irqsave]() with local_lock_t
will cause compilation failure.

Usage and behavior in !PREEMPT_RT:

local_lock_t lock;                     // sizeof(lock) == 0
local_lock(&lock);                     // preempt disable
local_lock_irqsave(&lock, ...);        // irq save
if (local_trylock_irqsave(&lock, ...)) // compilation error

local_trylock_t lock;                  // sizeof(lock) == 4
local_lock(&lock);                     // preempt disable, acquired = 1
local_lock_irqsave(&lock, ...);        // irq save, acquired = 1
if (local_trylock(&lock))              // if (!acquired) preempt disable, acquired = 1
if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save, acquired = 1

The existing local_lock_*() macros can be used either with
local_lock_t or local_trylock_t.
With local_trylock_t they set acquired = 1 while local_unlock_*() clears it.

In !PREEMPT_RT local_lock_irqsave(local_lock_t *) disables interrupts
to protect critical section, but it doesn't prevent NMI, so the fully
reentrant code cannot use local_lock_irqsave(local_lock_t *) for
exclusive access.

The local_lock_irqsave(local_trylock_t *) helper disables interrupts
and sets acquired=1, so local_trylock_irqsave(local_trylock_t *) from
NMI attempting to acquire the same lock will return false.

In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
Map local_trylock_irqsave() to preemptible spin_trylock().
When in hard IRQ or NMI return false right away, since
spin_trylock() is not safe due to explicit locking in the underneath
rt_spin_trylock() implementation. Removing this explicit locking and
attempting only "trylock" is undesired due to PI implications.

The local_trylock() without _irqsave can be used to avoid the cost of
disabling/enabling interrupts by only disabling preemption, so
local_trylock() in an interrupt attempting to acquire the same
lock will return false.

Note there is no need to use local_inc for acquired variable,
since it's a percpu variable with strict nesting scopes.

Note that guard(local_lock)(&lock) works only for "local_lock_t lock".

The patch also makes sure that local_lock_release(l) is called before
WRITE_ONCE(l->acquired, 0). Though IRQs are disabled at this point
the local_trylock() from NMI will succeed and local_lock_acquire(l)
will warn.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Fixes: 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  58 ++------
 include/linux/local_lock_internal.h | 207 ++++++++++++----------------
 mm/memcontrol.c                     |  39 +++---
 3 files changed, 114 insertions(+), 190 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 1a0bc35839e3..16a2ee4f8310 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -52,44 +52,23 @@
 	__local_unlock_irqrestore(lock, flags)
 
 /**
- * localtry_lock_init - Runtime initialize a lock instance
- */
-#define localtry_lock_init(lock)		__localtry_lock_init(lock)
-
-/**
- * localtry_lock - Acquire a per CPU local lock
- * @lock:	The lock variable
- */
-#define localtry_lock(lock)		__localtry_lock(lock)
-
-/**
- * localtry_lock_irq - Acquire a per CPU local lock and disable interrupts
- * @lock:	The lock variable
- */
-#define localtry_lock_irq(lock)		__localtry_lock_irq(lock)
-
-/**
- * localtry_lock_irqsave - Acquire a per CPU local lock, save and disable
- *			 interrupts
- * @lock:	The lock variable
- * @flags:	Storage for interrupt flags
+ * local_lock_init - Runtime initialize a lock instance
  */
-#define localtry_lock_irqsave(lock, flags)				\
-	__localtry_lock_irqsave(lock, flags)
+#define local_trylock_init(lock)	__local_trylock_init(lock)
 
 /**
- * localtry_trylock - Try to acquire a per CPU local lock.
+ * local_trylock - Try to acquire a per CPU local lock
  * @lock:	The lock variable
  *
  * The function can be used in any context such as NMI or HARDIRQ. Due to
  * locking constrains it will _always_ fail to acquire the lock in NMI or
  * HARDIRQ context on PREEMPT_RT.
  */
-#define localtry_trylock(lock)		__localtry_trylock(lock)
+#define local_trylock(lock)		__local_trylock(lock)
 
 /**
- * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
- *			      interrupts if acquired
+ * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			   interrupts if acquired
  * @lock:	The lock variable
  * @flags:	Storage for interrupt flags
  *
@@ -97,29 +76,8 @@
  * locking constrains it will _always_ fail to acquire the lock in NMI or
  * HARDIRQ context on PREEMPT_RT.
  */
-#define localtry_trylock_irqsave(lock, flags)				\
-	__localtry_trylock_irqsave(lock, flags)
-
-/**
- * local_unlock - Release a per CPU local lock
- * @lock:	The lock variable
- */
-#define localtry_unlock(lock)		__localtry_unlock(lock)
-
-/**
- * local_unlock_irq - Release a per CPU local lock and enable interrupts
- * @lock:	The lock variable
- */
-#define localtry_unlock_irq(lock)		__localtry_unlock_irq(lock)
-
-/**
- * localtry_unlock_irqrestore - Release a per CPU local lock and restore
- *			      interrupt flags
- * @lock:	The lock variable
- * @flags:      Interrupt flags to restore
- */
-#define localtry_unlock_irqrestore(lock, flags)			\
-	__localtry_unlock_irqrestore(lock, flags)
+#define local_trylock_irqsave(lock, flags)			\
+	__local_trylock_irqsave(lock, flags)
 
 DEFINE_GUARD(local_lock, local_lock_t __percpu*,
 	     local_lock(_T),
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 67bd13d142fa..bf2bf40d7b18 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -15,10 +15,11 @@ typedef struct {
 #endif
 } local_lock_t;
 
+/* local_trylock() and local_trylock_irqsave() only work with local_trylock_t */
 typedef struct {
 	local_lock_t	llock;
-	unsigned int	acquired;
-} localtry_lock_t;
+	u8		acquired;
+} local_trylock_t;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define LOCAL_LOCK_DEBUG_INIT(lockname)		\
@@ -29,6 +30,9 @@ typedef struct {
 	},						\
 	.owner = NULL,
 
+# define LOCAL_TRYLOCK_DEBUG_INIT(lockname)		\
+	.llock = { LOCAL_LOCK_DEBUG_INIT((lockname).llock) },
+
 static inline void local_lock_acquire(local_lock_t *l)
 {
 	lock_map_acquire(&l->dep_map);
@@ -56,6 +60,7 @@ static inline void local_lock_debug_init(local_lock_t *l)
 }
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
+# define LOCAL_TRYLOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
 static inline void local_trylock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
@@ -63,7 +68,7 @@ static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
-#define INIT_LOCALTRY_LOCK(lockname)	{ .llock = { LOCAL_LOCK_DEBUG_INIT(lockname.llock) }}
+#define INIT_LOCAL_TRYLOCK(lockname)	{ LOCAL_TRYLOCK_DEBUG_INIT(lockname) }
 
 #define __local_lock_init(lock)					\
 do {								\
@@ -76,6 +81,8 @@ do {								\
 	local_lock_debug_init(lock);				\
 } while (0)
 
+#define __local_trylock_init(lock) __local_lock_init(lock.llock)
+
 #define __spinlock_nested_bh_init(lock)				\
 do {								\
 	static struct lock_class_key __key;			\
@@ -87,149 +94,117 @@ do {								\
 	local_lock_debug_init(lock);				\
 } while (0)
 
+#define __local_lock_acquire(lock)					\
+	do {								\
+		local_trylock_t *tl;					\
+		local_lock_t *l;					\
+									\
+		l = (local_lock_t *)this_cpu_ptr(lock);			\
+		tl = (local_trylock_t *)l;				\
+		_Generic((lock),					\
+			local_trylock_t *: ({				\
+				lockdep_assert(tl->acquired == 0);	\
+				WRITE_ONCE(tl->acquired, 1);		\
+			}),						\
+			default:(void)0);				\
+		local_lock_acquire(l);					\
+	} while (0)
+
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		__local_lock_acquire(lock);			\
 	} while (0)
 
 #define __local_lock_irq(lock)					\
 	do {							\
 		local_irq_disable();				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		__local_lock_acquire(lock);			\
 	} while (0)
 
 #define __local_lock_irqsave(lock, flags)			\
 	do {							\
 		local_irq_save(flags);				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
-	} while (0)
-
-#define __local_unlock(lock)					\
-	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
-		preempt_enable();				\
+		__local_lock_acquire(lock);			\
 	} while (0)
 
-#define __local_unlock_irq(lock)				\
-	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
-		local_irq_enable();				\
-	} while (0)
-
-#define __local_unlock_irqrestore(lock, flags)			\
-	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
-		local_irq_restore(flags);			\
-	} while (0)
-
-#define __local_lock_nested_bh(lock)				\
-	do {							\
-		lockdep_assert_in_softirq();			\
-		local_lock_acquire(this_cpu_ptr(lock));	\
-	} while (0)
-
-#define __local_unlock_nested_bh(lock)				\
-	local_lock_release(this_cpu_ptr(lock))
-
-/* localtry_lock_t variants */
-
-#define __localtry_lock_init(lock)				\
-do {								\
-	__local_lock_init(&(lock)->llock);			\
-	WRITE_ONCE((lock)->acquired, 0);			\
-} while (0)
-
-#define __localtry_lock(lock)					\
-	do {							\
-		localtry_lock_t *lt;				\
-		preempt_disable();				\
-		lt = this_cpu_ptr(lock);			\
-		local_lock_acquire(&lt->llock);			\
-		WRITE_ONCE(lt->acquired, 1);			\
-	} while (0)
-
-#define __localtry_lock_irq(lock)				\
-	do {							\
-		localtry_lock_t *lt;				\
-		local_irq_disable();				\
-		lt = this_cpu_ptr(lock);			\
-		local_lock_acquire(&lt->llock);			\
-		WRITE_ONCE(lt->acquired, 1);			\
-	} while (0)
-
-#define __localtry_lock_irqsave(lock, flags)			\
-	do {							\
-		localtry_lock_t *lt;				\
-		local_irq_save(flags);				\
-		lt = this_cpu_ptr(lock);			\
-		local_lock_acquire(&lt->llock);			\
-		WRITE_ONCE(lt->acquired, 1);			\
-	} while (0)
-
-#define __localtry_trylock(lock)				\
+#define __local_trylock(lock)					\
 	({							\
-		localtry_lock_t *lt;				\
-		bool _ret;					\
+		local_trylock_t *tl;				\
 								\
 		preempt_disable();				\
-		lt = this_cpu_ptr(lock);			\
-		if (!READ_ONCE(lt->acquired)) {			\
-			WRITE_ONCE(lt->acquired, 1);		\
-			local_trylock_acquire(&lt->llock);	\
-			_ret = true;				\
-		} else {					\
-			_ret = false;				\
+		tl = this_cpu_ptr(lock);			\
+		if (READ_ONCE(tl->acquired)) {			\
 			preempt_enable();			\
+			tl = NULL;				\
+		} else {					\
+			WRITE_ONCE(tl->acquired, 1);		\
+			local_trylock_acquire(			\
+				(local_lock_t *)tl);		\
 		}						\
-		_ret;						\
+		!!tl;						\
 	})
 
-#define __localtry_trylock_irqsave(lock, flags)			\
+#define __local_trylock_irqsave(lock, flags)			\
 	({							\
-		localtry_lock_t *lt;				\
-		bool _ret;					\
+		local_trylock_t *tl;				\
 								\
 		local_irq_save(flags);				\
-		lt = this_cpu_ptr(lock);			\
-		if (!READ_ONCE(lt->acquired)) {			\
-			WRITE_ONCE(lt->acquired, 1);		\
-			local_trylock_acquire(&lt->llock);	\
-			_ret = true;				\
-		} else {					\
-			_ret = false;				\
+		tl = this_cpu_ptr(lock);			\
+		if (READ_ONCE(tl->acquired)) {			\
 			local_irq_restore(flags);		\
+			tl = NULL;				\
+		} else {					\
+			WRITE_ONCE(tl->acquired, 1);		\
+			local_trylock_acquire(			\
+				(local_lock_t *)tl);		\
 		}						\
-		_ret;						\
+		!!tl;						\
 	})
 
-#define __localtry_unlock(lock)					\
+#define __local_lock_release(lock)					\
+	do {								\
+		local_trylock_t *tl;					\
+		local_lock_t *l;					\
+									\
+		l = (local_lock_t *)this_cpu_ptr(lock);			\
+		tl = (local_trylock_t *)l;				\
+		local_lock_release(l);					\
+		_Generic((lock),					\
+			local_trylock_t *: ({				\
+				lockdep_assert(tl->acquired == 1);	\
+				WRITE_ONCE(tl->acquired, 0);		\
+			}),						\
+			default:(void)0);				\
+	} while (0)
+
+#define __local_unlock(lock)					\
 	do {							\
-		localtry_lock_t *lt;				\
-		lt = this_cpu_ptr(lock);			\
-		WRITE_ONCE(lt->acquired, 0);			\
-		local_lock_release(&lt->llock);			\
+		__local_lock_release(lock);			\
 		preempt_enable();				\
 	} while (0)
 
-#define __localtry_unlock_irq(lock)				\
+#define __local_unlock_irq(lock)				\
 	do {							\
-		localtry_lock_t *lt;				\
-		lt = this_cpu_ptr(lock);			\
-		WRITE_ONCE(lt->acquired, 0);			\
-		local_lock_release(&lt->llock);			\
+		__local_lock_release(lock);			\
 		local_irq_enable();				\
 	} while (0)
 
-#define __localtry_unlock_irqrestore(lock, flags)		\
+#define __local_unlock_irqrestore(lock, flags)			\
 	do {							\
-		localtry_lock_t *lt;				\
-		lt = this_cpu_ptr(lock);			\
-		WRITE_ONCE(lt->acquired, 0);			\
-		local_lock_release(&lt->llock);			\
+		__local_lock_release(lock);			\
 		local_irq_restore(flags);			\
 	} while (0)
 
+#define __local_lock_nested_bh(lock)				\
+	do {							\
+		lockdep_assert_in_softirq();			\
+		local_lock_acquire(this_cpu_ptr(lock));	\
+	} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+	local_lock_release(this_cpu_ptr(lock))
+
 #else /* !CONFIG_PREEMPT_RT */
 
 /*
@@ -237,16 +212,18 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
-typedef spinlock_t localtry_lock_t;
+typedef spinlock_t local_trylock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
-#define INIT_LOCALTRY_LOCK(lockname) INIT_LOCAL_LOCK(lockname)
+#define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
 
 #define __local_lock_init(l)					\
 	do {							\
 		local_spin_lock_init((l));			\
 	} while (0)
 
+#define __local_trylock_init(l)			__local_lock_init(l)
+
 #define __local_lock(__lock)					\
 	do {							\
 		migrate_disable();				\
@@ -283,17 +260,7 @@ do {								\
 	spin_unlock(this_cpu_ptr((lock)));			\
 } while (0)
 
-/* localtry_lock_t variants */
-
-#define __localtry_lock_init(lock)			__local_lock_init(lock)
-#define __localtry_lock(lock)				__local_lock(lock)
-#define __localtry_lock_irq(lock)			__local_lock(lock)
-#define __localtry_lock_irqsave(lock, flags)		__local_lock_irqsave(lock, flags)
-#define __localtry_unlock(lock)				__local_unlock(lock)
-#define __localtry_unlock_irq(lock)			__local_unlock(lock)
-#define __localtry_unlock_irqrestore(lock, flags)	__local_unlock_irqrestore(lock, flags)
-
-#define __localtry_trylock(lock)				\
+#define __local_trylock(lock)					\
 	({							\
 		int __locked;					\
 								\
@@ -308,11 +275,11 @@ do {								\
 		__locked;					\
 	})
 
-#define __localtry_trylock_irqsave(lock, flags)			\
+#define __local_trylock_irqsave(lock, flags)			\
 	({							\
 		typecheck(unsigned long, flags);		\
 		flags = 0;					\
-		__localtry_trylock(lock);			\
+		__local_trylock(lock);				\
 	})
 
 #endif /* CONFIG_PREEMPT_RT */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 421740f1bcdc..c96c1f2b9cf5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1759,7 +1759,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 struct memcg_stock_pcp {
-	localtry_lock_t stock_lock;
+	local_trylock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
@@ -1774,7 +1774,7 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCALTRY_LOCK(stock_lock),
+	.stock_lock = INIT_LOCAL_TRYLOCK(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
@@ -1805,11 +1805,10 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
-		if (!gfpflags_allow_spinning(gfp_mask))
-			return ret;
-		localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
-	}
+	if (gfpflags_allow_spinning(gfp_mask))
+		local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	else if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags))
+		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
 	stock_pages = READ_ONCE(stock->nr_pages);
@@ -1818,7 +1817,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		ret = true;
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -1857,14 +1856,14 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	old = drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 }
 
@@ -1894,7 +1893,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
 		/*
 		 * In case of unlikely failure to lock percpu stock_lock
 		 * uncharge memcg directly.
@@ -1907,7 +1906,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		return;
 	}
 	__refill_stock(memcg, nr_pages);
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /*
@@ -1964,9 +1963,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	stock = &per_cpu(memcg_stock, cpu);
 
 	/* drain_obj_stock requires stock_lock */
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	old = drain_obj_stock(stock);
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	drain_stock(stock);
 	obj_cgroup_put(old);
@@ -2787,7 +2786,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	unsigned long flags;
 	int *bytes;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
 
 	/*
@@ -2836,7 +2835,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 }
 
@@ -2846,7 +2845,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2854,7 +2853,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		ret = true;
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -2946,7 +2945,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -2960,7 +2959,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 
 	if (nr_pages)
-- 
2.47.1


