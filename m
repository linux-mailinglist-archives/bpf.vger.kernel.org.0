Return-Path: <bpf+bounces-48730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C95A0FEA0
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEDD1889416
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 02:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D0AD27;
	Tue, 14 Jan 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhVtzEnr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391B22FE02
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821188; cv=none; b=r+7zSlEblILGx5zjB4exCV5L0SQxrwL73d5VQF/bD7C5+AgaSyOekimWU2ui/Tqz7bNXCOow/q8E4cNgzeyo6OpPg3iQHkQIK8b/jJZjl1gF1yRlT0bdqCfK9z1dJQgoLHYYbGAPOw8xPNL7hBO/c8o3wqA+1KmkXI59IM+6nCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821188; c=relaxed/simple;
	bh=FxvXZIK6Q1cSySyzTPe24jvgtxLpl4PK0Mjw9ENtIKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dnOZBtB3pfVL1k/KBy6I9IGKCgvykm6rkxHryiDiRnqdvGuISP2h0xcsbdqeBAgVOjjsI3UZ+g+Bzg83oC05pq/VyyTmjreFzgsU1p4oYLsExsfvMC2UZ7/BD/Ve/3nFqFqdO9spEoaplPCJEbzDlfVBSXc9yR/dSiYTte9B4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhVtzEnr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so8305814a91.3
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 18:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821185; x=1737425985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+Lbt2oOvlSTPMdIT0UeNEpvkZe5nRvEnawf5u/tH+w=;
        b=bhVtzEnrYJz013Y8BCGL4XOfEhENsTevRDs140nLosfbG9nKKlTr1BkRhlwpLnae8B
         6BD7ZqEhtTs72lOaX4t35UCWN8XCbHrVSB6jyH/g/iT8YPUC4RMsgBrYwPz1J55ezDJH
         EbNaEn5/sARj2a3MQIJ+O316QWKDWW059Z9zq7XR3vyLiC6hG15cekMPjQnGvI6Yhuhi
         3XEYoJ/kYq3vi1hafOM5zsHwiNQWsg0+EVmxB0JEhD7WDC1JbeAOLcPOvZ9EduNlkXPF
         Cs0pPFl8KttJVfICzBGof5jXy7U/dhXbC9579Sooh1s483JnfNtqSIuOAZigrcjVDWJv
         ThMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821185; x=1737425985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+Lbt2oOvlSTPMdIT0UeNEpvkZe5nRvEnawf5u/tH+w=;
        b=V5+MuYB7tyvYf9C+94bwtiCbk/3+vQTt98zTczTuFd2bvnVwR2k/Zgk6BHN8E3vSdx
         1T7IVOkt+z3flQ6pM3JwVcQWog1e/vRuOYZrVEvqQRaDvaCjScHkD8+OcR3/0dWfOhk7
         jLbTugIcjZSVb1DdnYaeRoeJyl/Z8Wluk7MpV0fRa3IRfY2FcwIsVjKhadCcVeU++yeY
         /cUdbpdkEHa3aN/vXM+jUimOdQfdqB0oYcfkwtwe0B+lF587WtY2YNfYjMwZnNAWFL/z
         f2RnlKWGFokoloD820hMpemvNnBP9V6RaHOnwUEWpXhf5DIVmqSYGlypufVtGN+u8bur
         K8Sw==
X-Gm-Message-State: AOJu0YwPTExlriFx5UKJj8atkkK+WFN8rQiI5vnR31upzLZT6svf+7x+
	V7Ip5dwUiEjkUPEzU3Z090v6FXc7ZZxLQh9JT198eM91/nrpeHbecjnUVw==
X-Gm-Gg: ASbGnctIMAJia1r9lkFl5+VOGwhok9N9hWsweZSt5XiPWamEn2TKx2+3lMHGWokpRLW
	NSTdtCPeMdN7JQYwDMXktPT/W8ACA5bgzlgRNBbfFISJbboatt8aKlbxBY7oit86GjMj2aDC9w0
	IzAr2unIsASvWZH+MRL6xk8BVye52zmc/DlteuQ3wMkJiTA3cB0kkygHAyd+mMsDzd7XoauA4X/
	bJtlWi5lMkcUh6dRLDZXO2IkSIi9T8UIIZLMSH64bzZmHPmD7pj0gIRrl0T+wRnweGAqta9ydsi
	jJSmcbEs
X-Google-Smtp-Source: AGHT+IEFmgpkoNWWnjwaaKDdY0kFEuoA/VYtTI9WUz5vYKzivTLXj4vvKroyeHsRxZ0DCUaCQZ66Tg==
X-Received: by 2002:a17:90b:51cb:b0:2ee:863e:9fff with SMTP id 98e67ed59e1d1-2f548f2a4afmr34600926a91.10.1736821185517;
        Mon, 13 Jan 2025 18:19:45 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07cccbsm7420136a12.11.2025.01.13.18.19.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:19:45 -0800 (PST)
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
Subject: [PATCH bpf-next v4 3/6] locking/local_lock: Introduce local_trylock_irqsave()
Date: Mon, 13 Jan 2025 18:19:19 -0800
Message-Id: <20250114021922.92609-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Similar to local_lock_irqsave() introduce local_trylock_irqsave().
This is inspired by 'struct local_tryirq_lock' in:
https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-5-ddc0bdc27e05@suse.cz/

Use spin_trylock in PREEMPT_RT when not in hard IRQ and not in NMI
and fail instantly otherwise, since spin_trylock is not safe from IRQ
due to PI issues.

In !PREEMPT_RT use simple active flag to prevent IRQs or NMIs
reentering locked region.

Note there is no need to use local_inc for active flag.
If IRQ handler grabs the same local_lock after READ_ONCE(lock->active)
already completed it has to unlock it before returning.
Similar with NMI handler. So there is a strict nesting of scopes.
It's a per cpu lock. Multiple cpus do not access it in parallel.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  9 ++++
 include/linux/local_lock_internal.h | 76 ++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 091dc0b6bdfb..84ee560c4f51 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -30,6 +30,15 @@
 #define local_lock_irqsave(lock, flags)				\
 	__local_lock_irqsave(lock, flags)
 
+/**
+ * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			   interrupts. Always fails in RT when in_hardirq or NMI.
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
index 8dd71fbbb6d2..93672127c73d 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -9,6 +9,7 @@
 #ifndef CONFIG_PREEMPT_RT
 
 typedef struct {
+	int active;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 	struct task_struct	*owner;
@@ -22,7 +23,7 @@ typedef struct {
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 		.lock_type = LD_LOCK_PERCPU,		\
 	},						\
-	.owner = NULL,
+	.owner = NULL, .active = 0
 
 static inline void local_lock_acquire(local_lock_t *l)
 {
@@ -31,6 +32,13 @@ static inline void local_lock_acquire(local_lock_t *l)
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
@@ -45,6 +53,7 @@ static inline void local_lock_debug_init(local_lock_t *l)
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_trylock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
 static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
@@ -60,6 +69,7 @@ do {								\
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_PERCPU);			\
 	local_lock_debug_init(lock);				\
+	(lock)->active = 0;					\
 } while (0)
 
 #define __spinlock_nested_bh_init(lock)				\
@@ -75,37 +85,73 @@ do {								\
 
 #define __local_lock(lock)					\
 	do {							\
+		local_lock_t *l;				\
 		preempt_disable();				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		l = this_cpu_ptr(lock);				\
+		lockdep_assert(l->active == 0);			\
+		WRITE_ONCE(l->active, 1);			\
+		local_lock_acquire(l);				\
 	} while (0)
 
 #define __local_lock_irq(lock)					\
 	do {							\
+		local_lock_t *l;				\
 		local_irq_disable();				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		l = this_cpu_ptr(lock);				\
+		lockdep_assert(l->active == 0);			\
+		WRITE_ONCE(l->active, 1);			\
+		local_lock_acquire(l);				\
 	} while (0)
 
 #define __local_lock_irqsave(lock, flags)			\
 	do {							\
+		local_lock_t *l;				\
 		local_irq_save(flags);				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		l = this_cpu_ptr(lock);				\
+		lockdep_assert(l->active == 0);			\
+		WRITE_ONCE(l->active, 1);			\
+		local_lock_acquire(l);				\
 	} while (0)
 
+#define __local_trylock_irqsave(lock, flags)			\
+	({							\
+		local_lock_t *l;				\
+		local_irq_save(flags);				\
+		l = this_cpu_ptr(lock);				\
+		if (READ_ONCE(l->active) == 1) {		\
+			local_irq_restore(flags);		\
+			l = NULL;				\
+		} else {					\
+			WRITE_ONCE(l->active, 1);		\
+			local_trylock_acquire(l);		\
+		}						\
+		!!l;						\
+	})
+
 #define __local_unlock(lock)					\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		local_lock_t *l = this_cpu_ptr(lock);		\
+		lockdep_assert(l->active == 1);			\
+		WRITE_ONCE(l->active, 0);			\
+		local_lock_release(l);				\
 		preempt_enable();				\
 	} while (0)
 
 #define __local_unlock_irq(lock)				\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		local_lock_t *l = this_cpu_ptr(lock);		\
+		lockdep_assert(l->active == 1);			\
+		WRITE_ONCE(l->active, 0);			\
+		local_lock_release(l);				\
 		local_irq_enable();				\
 	} while (0)
 
 #define __local_unlock_irqrestore(lock, flags)			\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		local_lock_t *l = this_cpu_ptr(lock);		\
+		lockdep_assert(l->active == 1);			\
+		WRITE_ONCE(l->active, 0);			\
+		local_lock_release(l);				\
 		local_irq_restore(flags);			\
 	} while (0)
 
@@ -148,6 +194,22 @@ typedef spinlock_t local_lock_t;
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


