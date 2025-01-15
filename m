Return-Path: <bpf+bounces-48897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105FA11728
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F7167DE8
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE61132105;
	Wed, 15 Jan 2025 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ylzc3FNt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E272D638
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907490; cv=none; b=SbzC5TFoje/yV/jJ5GZ5yQM1BrOGy9G2iJY2KSPgtDTAHfq0cjrgajAqWn+TYwxntXPwDIfKL3n2eUXvhYXGubOz0IcgwJAtrUhpCU5n677Pbw1AyoCvXoOt7E68byi+r+qdq70kBshQKa542qbG2eXHXyM5nFhFSeYE2Xr+ros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907490; c=relaxed/simple;
	bh=FxvXZIK6Q1cSySyzTPe24jvgtxLpl4PK0Mjw9ENtIKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hp9z2nrm0jyiulhEC/p4d7DoY6a/1xA4XYpOkO8u0fcfgmEJVkBJPOT2ejb/PzARqYZhullH5G0Xl2AWL4VKpqxU0n89OGNT6YZK/ntsUC9grvpVIAr159odMV/5ifhw/v7ZdZWY/DL62QFyCs8dDQzqooRzzgjTyRhkLPk33YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ylzc3FNt; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f441904a42so10670918a91.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907487; x=1737512287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+Lbt2oOvlSTPMdIT0UeNEpvkZe5nRvEnawf5u/tH+w=;
        b=Ylzc3FNti01w/AWFXwIQ3XmyHo+KXXoQQ6opRGWUbE19v/H+ccgi0yywWUj3fZAAJR
         NRf3Id4AVR1shD8teYzr4B7WloZNt+LP5V2vi8/TpKStlfEyVBwlr81hiLY6he80w4Oo
         zvgq6OKuPi5hevLj+Hr9Ytw+XDMGldITBo8r8Jr+0f6MtHEkkphv/VMCFd3WqsZsZA0/
         7RXHrma4WeV1y47CUASdjJXAA0WDIID+jtP+l1xxJmq+CYeKBaVUqf7mzgWaw6vueqzO
         TsHAScW/enjwdGQAeoffXo5BALga31wqRnABZJOVKDHAmbHS31515saUJGpqQBqxK8hV
         3UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907487; x=1737512287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+Lbt2oOvlSTPMdIT0UeNEpvkZe5nRvEnawf5u/tH+w=;
        b=aOO91UL0yokphbhbsBhgdAyIA4Lj4yhhac8UKBSK11Wv0SzI0kfqTYnS33sOfKf7pV
         iObUeqrf7h+47S5GXTRCsE5tglgWViB6INDHQaVplS4NrNUjxgj9ebHf1KsJwC10K3bg
         aEJAdqPzLBx1Vu9PqJtU9DBEr4JdCihfRqwkXwiU46Y32brUOZIvF7cT9Qi6x2HqB6Ri
         xxoxhTmz/JhvIPOKzOW5hws9Np2GGSfz8yuBSaFhDnDvIuNcTlFwaCMVPKDTiP+VIg9/
         4WvqzeUKpWs7VEgAJnleDn3noxcTkYSYzl5g5q2uxXDGSceT8rqX8OgIet+amXCor8QH
         JbkQ==
X-Gm-Message-State: AOJu0YztE9a+Wg3hbQQKNXw8OnJ9eimh3wnOMx+exPLqLKoSlh3cQza3
	JVpqtXtc+g+FTTcnSqODhEPMyY3Lt0Dh70RxE/GlUIGlTc6yRp9O/5b7ug==
X-Gm-Gg: ASbGncsaKVOlZNo4r2xobOMxv/frOBQNRL8SBSTtvwyvNumjd3crHhnbH6yAyhyYopp
	0Rl9PiBd28yZXV+aPwWahkNYBWg0oFpqi1RkSooLgSFnmfmD2Cc8B7iDx49yc5HUHGCKpBE5f7r
	kmPiair4VGAl1AwWEijMgBYYlKuMH3Q4xEdTORaiNedMbeQSGvHBxiUuqutIAqlPvxPZaMtrBie
	QoTQf97o2i8fM5MAh7jB6F4MUgpwwQ24GxRxs45jHZVtWUlPeEjvi1NO6CbXwYzUN0ZgeHqVjVK
	l0zbW/dy
X-Google-Smtp-Source: AGHT+IG/cFjjNteRnggOPcJd7ml3IweEri0dZgwymeHUFWzv/5oMKi4cBo8NV/fu9YuNibkf/qV0PQ==
X-Received: by 2002:a05:6a00:1942:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-72d21f7bcccmr39594907b3a.12.1736907487230;
        Tue, 14 Jan 2025 18:18:07 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dddsm8016029b3a.155.2025.01.14.18.18.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:18:06 -0800 (PST)
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
Subject: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce local_trylock_irqsave()
Date: Tue, 14 Jan 2025 18:17:42 -0800
Message-Id: <20250115021746.34691-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
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


