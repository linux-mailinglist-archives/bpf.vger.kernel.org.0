Return-Path: <bpf+bounces-55102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738FA783A5
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C9188FE9F
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C921324D;
	Tue,  1 Apr 2025 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS39QGx+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551D01F0E3C;
	Tue,  1 Apr 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540772; cv=none; b=IsK7FB4SdqRgTHCx9XVhKyCKGWmZSn5/yF+kLW8UfqyzjOTlqa6cQgkoGHr7Jo5vQ/8CBJbmrRbp+bGrZ1qRFrZAB6wV6NjXCQ38JgQVtRlLrhuMpj1KQVvqbDgbQFx/iq0PfgO45xceVZsvZfj8QBwBu1ecvvyKwo5WzoS7Myg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540772; c=relaxed/simple;
	bh=sn30y9A04WDuc9egoz6LhiGwjJgmZAQbgClV8xEa+WM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggmcmLtU94wmLymuLWKfoOFteL7DYo2GxsNThlktrNBZVNg0kEuhfRfAD/Qm+k/XoTwKTc4lKfOzGWJO2EOu3RE9oF9BcpIQqtBeTjVrt0VNRQIXDBFL4RVfYSTqgKyxFIDZs6oRJrbuPtL8y8jMsDL8RQEqaKEpJr0lNTzvoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS39QGx+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223f4c06e9fso4582785ad.1;
        Tue, 01 Apr 2025 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743540770; x=1744145570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbnqMSopdIUubaAU0RLOqaX1LKEA2UE8yCCeCrMS7gI=;
        b=MS39QGx+LcOTeVQ7vsWDXG6wRj1KTXWcszo3lP5NMdLX68xz1hKN/wkAqQlUofYrPl
         1D/dUw62ieZpQ+2S94Qzt7kjcE0lz/8KoVz5Py0tfmqYQ3TuyU1cxw9nBSyMIvbME8uK
         MR0GP2iNjYgyQNW4lfCcAkNE8y56tWIfIPckFXcbqpDaONqT21e4WgEbmTHVLUqdoHDp
         71DJ/jh5f8ZYZ8hi4DCL0wA4qipuzNcv9MTn1mXQ0MhY4c48dfTHGGNfYM15XMBU+26m
         UipBm7eKqOcPOCBya5Q+AVJ+O7ULEBZUowD+zeXUOFi8JgOnTK1bN7mxxliNvQYG/03r
         Cqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540770; x=1744145570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbnqMSopdIUubaAU0RLOqaX1LKEA2UE8yCCeCrMS7gI=;
        b=BLqhZHSrmFNg1+GUJc7ZwSJCndZockEmPgl6vnqFip4SKJY5Cfk+5swPyRTUlSM4Zw
         uoB6OiKM3ElPlcGAzDUiW73QSQLvkiMkyvmloF8r5kcby0UtFuYzuXx/C/z901AV+M5u
         JcR54BBfDeYK9p7Lc9OHRkVo7l2X7/NTHUWpCcJ6j48UYQ0cJ63PId8m/IP8u0cniOA8
         wE755XB0YcouYSU6TaBlaagy9itPu2l91mvcjoWuQuE4O6A/0w+z4ZqWhpsP/osE0MeQ
         nINkyaq6YnErvU8qt/RLtOkCEP/Ycl5AXeIsZ48bMKbOKbRfK3CPRk73Mh3lGKqNLZxn
         TUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtkp+sc9H+9aa+Bo5nUKJlfEUfskbXhvV/1jh1VhEUOMMGeHDmx15amuXWb/3uBabEi70V97UNyfsbUuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+G6m1+G7nwJdiLXz2e0iMOA0ovur80OXJKR8nw83d0gZ1GN9
	/ZVulCxio6GUXDP0z5eSar4ZDOwycbdXxxbhQ3tGDU9xyMLvx7wi
X-Gm-Gg: ASbGncu2bp9/5WilAPGH2EXSTg4aLihlHKXmZ/2p+QoaOZKAVqMYfHHg3jjRexNJDpA
	vXxJGlBnCbysAdACA981fBBnQNRnCajr8jghuz0x/CTJBWSy+2J/RwOFb/xyTTGHffhxbAyz4Qg
	OHfLv3Iovz7W5oZXRZ+3SXoG2d5Yql1Aakidzj9wxnzBZtS8M17GxOZS+WD6nzk6tL+H69loXo7
	SIdm6U1py81iPRUAHHXHjro4MWeQXPKypowK/aOsp/koGrZaqECI1TpRcZwOrV1qQY1gsmiHWLX
	Ok9qqEN6wauPHaAcao5UWNJknwKy+6moJ5kfA3sxgGrmgEoDpPafKH3sxjNMDKxfjvZliu5OprQ
	=
X-Google-Smtp-Source: AGHT+IEQpjVcdT9VtBOdsAPfQ26iEXmg4h52HaPeWx14ayBtTplL3qDlQIKXzFZ3w/AoDQgdeOVBFQ==
X-Received: by 2002:a17:902:db09:b0:215:b1e3:c051 with SMTP id d9443c01a7336-229682c14ccmr17980615ad.11.1743540769493;
        Tue, 01 Apr 2025 13:52:49 -0700 (PDT)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::4:b843])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f9584sm93651185ad.224.2025.04.01.13.52.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Apr 2025 13:52:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	mhocko@suse.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] locking/local_lock, mm: Replace localtry_ helpers with local_trylock_t type
Date: Tue,  1 Apr 2025 13:52:45 -0700
Message-Id: <20250401205245.70838-1-alexei.starovoitov@gmail.com>
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
if (local_trylock(&lock))              // if (!acquired) preempt disable
if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save

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

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  59 +-------
 include/linux/local_lock_internal.h | 208 ++++++++++++----------------
 mm/memcontrol.c                     |  39 +++---
 3 files changed, 111 insertions(+), 195 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 1a0bc35839e3..7ac9385cd475 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -52,44 +52,18 @@
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
- */
-#define localtry_lock_irqsave(lock, flags)				\
-	__localtry_lock_irqsave(lock, flags)
-
-/**
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
@@ -97,29 +71,8 @@
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
index 67bd13d142fa..2389ae4f69a6 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -15,10 +15,18 @@ typedef struct {
 #endif
 } local_lock_t;
 
+/* local_trylock() and local_trylock_irqsave() only work with local_trylock_t */
 typedef struct {
-	local_lock_t	llock;
-	unsigned int	acquired;
-} localtry_lock_t;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+	struct task_struct	*owner;
+#endif
+	/*
+	 * Same layout as local_lock_t with 'acquired' field at the end.
+	 * (local_trylock_t *) will be cast to (local_lock_t *).
+	 */
+	int acquired;
+} local_trylock_t;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define LOCAL_LOCK_DEBUG_INIT(lockname)		\
@@ -63,7 +71,6 @@ static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
-#define INIT_LOCALTRY_LOCK(lockname)	{ .llock = { LOCAL_LOCK_DEBUG_INIT(lockname.llock) }}
 
 #define __local_lock_init(lock)					\
 do {								\
@@ -73,7 +80,7 @@ do {								\
 	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_PERCPU);			\
-	local_lock_debug_init(lock);				\
+	local_lock_debug_init((local_lock_t *)lock);		\
 } while (0)
 
 #define __spinlock_nested_bh_init(lock)				\
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
-	} while (0)
-
-#define __local_unlock_irq(lock)				\
-	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
-		local_irq_enable();				\
+		__local_lock_acquire(lock);			\
 	} while (0)
 
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
+		_Generic((lock),					\
+			local_trylock_t *: ({				\
+				lockdep_assert(tl->acquired == 1);	\
+				WRITE_ONCE(tl->acquired, 0);		\
+			}),						\
+			default:(void)0);				\
+		local_lock_release(l);					\
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
@@ -237,10 +212,9 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
-typedef spinlock_t localtry_lock_t;
+typedef spinlock_t local_trylock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
-#define INIT_LOCALTRY_LOCK(lockname) INIT_LOCAL_LOCK(lockname)
 
 #define __local_lock_init(l)					\
 	do {							\
@@ -283,17 +257,7 @@ do {								\
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
@@ -308,11 +272,11 @@ do {								\
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
index 421740f1bcdc..813f5b73e7c8 100644
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
+	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
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


