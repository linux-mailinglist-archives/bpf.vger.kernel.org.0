Return-Path: <bpf+bounces-47177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8109F5D3C
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8DC1889500
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0871448F2;
	Wed, 18 Dec 2024 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnphg4d6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729743146
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491263; cv=none; b=huYccEJbpwZb2B0b44jl8iwX5ECgCNuwc3OUw8Yb6SALof04qM8jaJGf9dUAiFSp7TV0W/KLk5C4dMi02bZpvHfxrZETKrRPneWE1dsileR9QfuadZ4o2ZCiUcdLd0HNHB6yo9ODI4GGOizjwLIn1QFOqkOFk26bikzuhX89pHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491263; c=relaxed/simple;
	bh=TkxOKnG0Zg/aV4ON18flvreuq6SyqnihyXeEFYVd3fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5rBRodGsWyucjKPm7hTNTQ8eJsBF8MAdbcSvd0+wbKrWDT6utzRko0udOza3VxInHAaoI5VxGZ+oev+p4ckH+LWNR4h3mWiJ2g3iCB+1uo4x+vFgKEccPQa0bF0dtB6aidrVt4LPK5NFOhI5ET46XmUdsoiWnzhBIfdkexS4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnphg4d6; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f4c111991bso185337eaf.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 19:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491260; x=1735096060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcHIP1+8Pwyc2xkUuGVXiolOQkisEg3F+R5j1Yt+uzY=;
        b=Vnphg4d6hM7oA9TfMNenHKc8TDOsN2R1NYJwaZM/h4Vls06hrA7NeiyZOXaVIrgWDc
         sd+rIuNZo4Vp5oNwPo+LHAyS7yHVeiHtkgEY+SMlaW71/I+O0MFqzY0dcS6lN/nDGt9f
         hDvWTblEvF7oL2JZn6fYx2WyvfbsI1DS3QjBAvFzWREDwIDbjaFinThWasTDAP7ly7mJ
         8arUkG/usfyfkkyBhJr+I13bHJqY1y42mC7QoRIQg9KiW4BJCDUJrpcxuVxCCiXnOE/Q
         SkOtzoBmnfAuyXDFkZ3XjyQiLcCDHZl8lFC0RN6uBDV8pxucfnE50s+piankvn5AYaRX
         jRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491260; x=1735096060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcHIP1+8Pwyc2xkUuGVXiolOQkisEg3F+R5j1Yt+uzY=;
        b=koMBdMTC82wz+eSgeh7sZVKg9kns327C68W4sLsNV5tuKbmGxGD2/pn/zcIMnn8lmR
         jN/t2Rpt8w1y17DDoHnSmYjhrWW0p3bFgMms6mXoA8uBIjHWweKjX6oSUCoAHgTq+t9B
         DUluAfh/IfyNzF11Fl6scXbmxn48vMVmLDjA/yq0fWnUMfuUK8JFDIzC+qJsvZVzgO6W
         VUBvEYoN4B+6o8sE8v7lxpa7Xou9fO0kPv6QjR+gmpCOONW3AXCHbvnyC6OOXxEq2WGt
         hZ0mugq6Qw7yIUVvn5QOVDrNQYy0ckCTCWMZTl1LXqjZsfenyomtzqVDQOqUnDhDU+Ju
         pOmA==
X-Gm-Message-State: AOJu0Yw+O67H8T91LcSgWcsAfz8/h17Zpg5MRjf6t/0MVwRx9NahCLs9
	N9ShEpxVxKi7lYFx4Z7DmhevymuMVpvN0P8QADfjirZw3eyQBnynZZxAnQ==
X-Gm-Gg: ASbGncu3DpLpfbJCBFqWkmtweCVwZqOXzHzENoZDMpt4pHmdXgUFCSXGD1T0P0NfhjZ
	E4iCKfnzvMAaWHPedvYjBDi+O2D9Gz/wr5HgCw2ee0VOY5cSsCC1xUbbB7CfJuNzinEzFzxdB4U
	JynXFPYqZ2E5EVMg9gFKFH7YknV2jz+ZSBTw3rjHuRnJo8N6Eay+5BGI3HR+Pxs2EZqro+jrDnW
	hhMrj3EhMDGpM3C1ERhf3lJXfj1tJu/fqH4t3K5hIJAXaf+B22duHSNLFKxPg==
X-Google-Smtp-Source: AGHT+IGAOWU8WTtpajWGghl6QstJosNCQ5UcWaUN0/NUcMXEsAsN5z1Ap2Hz23QuLwZvMvbxMXfsRw==
X-Received: by 2002:a4a:d74c:0:b0:5f2:b6d5:bf53 with SMTP id 006d021491bc7-5f45c71a68cmr2978615eaf.1.1734491259593;
        Tue, 17 Dec 2024 19:07:39 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f33a98a3f7sm2526797eaf.36.2024.12.17.19.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:07:38 -0800 (PST)
From: alexei.starovoitov@gmail.com
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
Subject: [PATCH bpf-next v3 3/6] locking/local_lock: Introduce local_trylock_irqsave()
Date: Tue, 17 Dec 2024 19:07:16 -0800
Message-ID: <20241218030720.1602449-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

This is inspired by 'struct local_tryirq_lock' in:
https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-5-ddc0bdc27e05@suse.cz/

Similar to local_lock_irqsave() introduce local_trylock_irqsave().
It uses spin_trylock in PREEMPT_RT when not in hard IRQ and not in NMI
and instantly fails otherwise.
In !RT it uses simple active flag that prevents IRQs or NMIs reentering
locked region.

Note there is no need to use local_inc for active flag.
If IRQ handler grabs the same local_lock after READ_ONCE(lock->active)
already completed it has to unlock it before returning.
Similar with NMI handler. So there is a strict nesting of scopes.
It's a per cpu lock, so multiple cpus do not access it in parallel.

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


