Return-Path: <bpf+bounces-55021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798D1A77216
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 02:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C46169FFC
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 00:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BB781ACA;
	Tue,  1 Apr 2025 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K10hrEYQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E612E3360;
	Tue,  1 Apr 2025 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743468701; cv=none; b=kNaWcpjjB/AWUrB01KReb3xjOI85IJdf5Zy/JboVuz2n5OPnNTmnU2YHSP/ye/JQomEpz6c5I3uEDjP4pTUAYNGsjpUAjwtXuDJiukFUfU9X5nVMzYCyrqQlSeKWq6q3wb2YLtR9qVrBBgi0g47as5sb2+OoIAKIEz8aPnrLmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743468701; c=relaxed/simple;
	bh=R60DDXtd3YxiOK/s8MWCE/GBlhG53kTB+kWpGSc4byA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dxwAwfMKG7HXFuVGZltjWYGXeckA0r5AFcefZfU4tbk9nbV8Q8sfcLlsyjoASS7oq4Ai9yGc8Frg6Uae7Dqpp2vviknflbYLc/JqK5QdfUNdSVBHbjzau7tCcXH3ba+zf28HkQvsBeMRA0Gz9LWl/Ykl5JemILHR2lz2qmkfsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K10hrEYQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22548a28d0cso135212705ad.3;
        Mon, 31 Mar 2025 17:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743468698; x=1744073498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoPlnUj9VYVfTn2EhY6mZPQ4JMBrtPu8Y1smqMHSsw8=;
        b=K10hrEYQyQIY/o4AV0DVUDwz3CiBedRRh2M2P+906ocXF3qqDZkzfBfSAM8nzYxEPI
         +6ad57iGAbVsJ/Fqz7DLJn7mZ4jwYa4hyiU8SXoitsH/Un2RoGg2s+LAKlqUxw/V7KN1
         NS3xxzGhA1TJHCej881QvAqpcL8Gd9TCAfz2vbWz4HYDDxs/riet47uvKmpitzNMLlki
         FBzHU1AUQOd9tuRCVVsrmIjj29crACWH1p3mh93JEHFKqzx++RHfD05YQE+0FH16wT0m
         TBFMt2aToTX81TiR2Ms6IMT8qumRzOCotTh0QUlWpYFrK9EzpEQFsW/4rQMCgHXrB8k0
         5wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743468698; x=1744073498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoPlnUj9VYVfTn2EhY6mZPQ4JMBrtPu8Y1smqMHSsw8=;
        b=mvem10mxIO2TRsFuGlw7d9vKGPj4mufot5mYa4lqth5MqmWy/vzFrzkofh7yxj3rY0
         YzkXx/QzFb4UlbO6xrmOO0tF65byL6EU7do/eot+f3PWsiychwuiy9G4QnGDDwWJQFxj
         nymRd9DW7sGW9jj2qmp3SwaLjbcpXj3CzkCbwwjaW/papaaLHqyGoYXgX3K0vfCnf5xH
         NIBbVzPyMxFQ2l6AmkNV0sZ1iJWmzWV2L8HIeTxJM++QYqyUm+/XNgQGo95tHRV7bDme
         iQ2ysRPEfwmI9+fvSHjqYUcFHEXT6rTnizVQhpys3f2xkegf0i3hvy8dLRol5YyePrkZ
         nr0A==
X-Forwarded-Encrypted: i=1; AJvYcCUvUZD5CSt6YlTQ8u38V9UFRfm4TiqxNoYz3qbsp+AaAWjcKZrj4KZ5AVhDJw9lskUZpmqSdRGNeZB1qd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzflsbPiQFjcM+Kd6VAlYyq+KlVLcEL7B7CFlUFc8NJYL/9X2fy
	1dMSNgu53qRMQNcb6w83NfbSfsKmD3xOL+CKSqb1OJCnAdzd1Gqq
X-Gm-Gg: ASbGncuGZ5fobKgXRZz0BGI1iRhxaMrEjR5JDm35q1UGwxnNtgu2ZL7VOM1FyoDjxw0
	6AgUAtMnDp3cZm0XmAo9RmZeoqI+ThO/zPdeIXa1D94U4tIMwx/CtAg2ceafsDBTVNh1qGLzDJN
	r1vLu+S2dSFmBU7KcNqdZyIkzPdTJJNCtusdQCpnYZhGy62an617qGVG6yW0r5DWbrv6Fk1urXr
	KTlQcXqgcgHCdR5PokDFM/x0lW8fkUUcR1vYyDxzJXA1WMqYbigFOoERFV//GPMLf8CWaFwx4Y/
	BRchpkhbVe6XrAqPRNzrF2R0Arh3TYwq/BFv8sk1wzMcC7MocNk/CX1PqcKZhQHYrghNNF7a
X-Google-Smtp-Source: AGHT+IG2uoTtYHsOhKY+bOe2Z5kTaeHHDlNe/QpMvVEuyUW5/7EPmwSTDq3bK38ywiIuj7Us/Ekklw==
X-Received: by 2002:a17:902:ce8b:b0:224:179a:3b8f with SMTP id d9443c01a7336-2292f979cb9mr169297455ad.23.1743468698320;
        Mon, 31 Mar 2025 17:51:38 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:22d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cdd43sm76025095ad.133.2025.03.31.17.51.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Mar 2025 17:51:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org,
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] locking/local_lock, mm: Replace localtry_ helpers with local_trylock_t type
Date: Mon, 31 Mar 2025 17:51:34 -0700
Message-Id: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
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

Introduce local_trylock_irqsave() helper that only works
with newly introduced local_trylock_t type.
Note that attempt to use local_trylock_irqsave() with local_lock_t
will cause compilation failure.

Usage and behavior in !PREEMPT_RT:

local_lock_t lock;                     // sizeof(lock) == 0
local_lock_irqsave(&lock, ...);        // irq save
if (local_trylock_irqsave(&lock, ...)) // compilation error

local_trylock_t lock;                  // sizeof(lock) == 4
local_lock_irqsave(&lock, ...);        // irq save and acquired = 1
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

Note there is no need to use local_inc for acquired variable,
since it's a percpu variable with strict nesting scopes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  58 +--------
 include/linux/local_lock_internal.h | 193 ++++++++++------------------
 mm/memcontrol.c                     |  39 +++---
 3 files changed, 95 insertions(+), 195 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 1a0bc35839e3..9262109cca51 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -52,44 +52,19 @@
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
+ * local_trylock_irqsave - Try to acquire a per CPU local lock
  * @lock:	The lock variable
  * @flags:	Storage for interrupt flags
- */
-#define localtry_lock_irqsave(lock, flags)				\
-	__localtry_lock_irqsave(lock, flags)
-
-/**
- * localtry_trylock - Try to acquire a per CPU local lock.
- * @lock:	The lock variable
  *
  * The function can be used in any context such as NMI or HARDIRQ. Due to
  * locking constrains it will _always_ fail to acquire the lock in NMI or
  * HARDIRQ context on PREEMPT_RT.
  */
-#define localtry_trylock(lock)		__localtry_trylock(lock)
+#define local_trylock(lock, flags)	__local_trylock(lock, flags)
 
 /**
- * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
- *			      interrupts if acquired
+ * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			   interrupts if acquired
  * @lock:	The lock variable
  * @flags:	Storage for interrupt flags
  *
@@ -97,29 +72,8 @@
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
index 67bd13d142fa..cc79854206df 100644
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
+	 * (local_trylock_t *) will be casted to (local_lock_t *).
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
@@ -87,39 +94,88 @@ do {								\
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
+		__local_lock_acquire(lock);			\
+	} while (0)
+
+#define __local_trylock_irqsave(lock, flags)			\
+	({							\
+		local_trylock_t *tl;				\
+								\
+		local_irq_save(flags);				\
+		tl = this_cpu_ptr(lock);			\
+		if (READ_ONCE(tl->acquired) == 1) {		\
+			local_irq_restore(flags);		\
+			tl = NULL;				\
+		} else {					\
+			WRITE_ONCE(tl->acquired, 1);		\
+			local_trylock_acquire(			\
+				(local_lock_t *)tl);		\
+		}						\
+		!!tl;						\
+	})
+
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
 	} while (0)
 
 #define __local_unlock(lock)					\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		__local_lock_release(lock);			\
 		preempt_enable();				\
 	} while (0)
 
 #define __local_unlock_irq(lock)				\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		__local_lock_release(lock);			\
 		local_irq_enable();				\
 	} while (0)
 
 #define __local_unlock_irqrestore(lock, flags)			\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		__local_lock_release(lock);			\
 		local_irq_restore(flags);			\
 	} while (0)
 
@@ -132,104 +188,6 @@ do {								\
 #define __local_unlock_nested_bh(lock)				\
 	local_lock_release(this_cpu_ptr(lock))
 
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
-	({							\
-		localtry_lock_t *lt;				\
-		bool _ret;					\
-								\
-		preempt_disable();				\
-		lt = this_cpu_ptr(lock);			\
-		if (!READ_ONCE(lt->acquired)) {			\
-			WRITE_ONCE(lt->acquired, 1);		\
-			local_trylock_acquire(&lt->llock);	\
-			_ret = true;				\
-		} else {					\
-			_ret = false;				\
-			preempt_enable();			\
-		}						\
-		_ret;						\
-	})
-
-#define __localtry_trylock_irqsave(lock, flags)			\
-	({							\
-		localtry_lock_t *lt;				\
-		bool _ret;					\
-								\
-		local_irq_save(flags);				\
-		lt = this_cpu_ptr(lock);			\
-		if (!READ_ONCE(lt->acquired)) {			\
-			WRITE_ONCE(lt->acquired, 1);		\
-			local_trylock_acquire(&lt->llock);	\
-			_ret = true;				\
-		} else {					\
-			_ret = false;				\
-			local_irq_restore(flags);		\
-		}						\
-		_ret;						\
-	})
-
-#define __localtry_unlock(lock)					\
-	do {							\
-		localtry_lock_t *lt;				\
-		lt = this_cpu_ptr(lock);			\
-		WRITE_ONCE(lt->acquired, 0);			\
-		local_lock_release(&lt->llock);			\
-		preempt_enable();				\
-	} while (0)
-
-#define __localtry_unlock_irq(lock)				\
-	do {							\
-		localtry_lock_t *lt;				\
-		lt = this_cpu_ptr(lock);			\
-		WRITE_ONCE(lt->acquired, 0);			\
-		local_lock_release(&lt->llock);			\
-		local_irq_enable();				\
-	} while (0)
-
-#define __localtry_unlock_irqrestore(lock, flags)		\
-	do {							\
-		localtry_lock_t *lt;				\
-		lt = this_cpu_ptr(lock);			\
-		WRITE_ONCE(lt->acquired, 0);			\
-		local_lock_release(&lt->llock);			\
-		local_irq_restore(flags);			\
-	} while (0)
-
 #else /* !CONFIG_PREEMPT_RT */
 
 /*
@@ -237,10 +195,9 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
-typedef spinlock_t localtry_lock_t;
+typedef spinlock_t local_trylock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
-#define INIT_LOCALTRY_LOCK(lockname) INIT_LOCAL_LOCK(lockname)
 
 #define __local_lock_init(l)					\
 	do {							\
@@ -283,17 +240,7 @@ do {								\
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
@@ -308,11 +255,11 @@ do {								\
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
index 83c2df73e4b6..bca86961754e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1739,7 +1739,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 struct memcg_stock_pcp {
-	localtry_lock_t stock_lock;
+	local_trylock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
@@ -1754,7 +1754,7 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCALTRY_LOCK(stock_lock),
+	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
@@ -1785,11 +1785,10 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
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
@@ -1798,7 +1797,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		ret = true;
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -1837,14 +1836,14 @@ static void drain_local_stock(struct work_struct *dummy)
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
 
@@ -1874,7 +1873,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
 		/*
 		 * In case of unlikely failure to lock percpu stock_lock
 		 * uncharge memcg directly.
@@ -1887,7 +1886,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		return;
 	}
 	__refill_stock(memcg, nr_pages);
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /*
@@ -1944,9 +1943,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	stock = &per_cpu(memcg_stock, cpu);
 
 	/* drain_obj_stock requires stock_lock */
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	old = drain_obj_stock(stock);
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	drain_stock(stock);
 	obj_cgroup_put(old);
@@ -2729,7 +2728,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	unsigned long flags;
 	int *bytes;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
 
 	/*
@@ -2782,7 +2781,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 }
 
@@ -2792,7 +2791,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2800,7 +2799,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		ret = true;
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -2892,7 +2891,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -2910,7 +2909,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 	obj_cgroup_put(old);
 
 	if (nr_pages)
-- 
2.47.1


