Return-Path: <bpf+bounces-51348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B529A33620
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8C7A3501
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20903204F82;
	Thu, 13 Feb 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vis1ppbf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB129204F72
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417772; cv=none; b=mqHzAaBqcdke0ZCy7dtoxO8yl8NW/WVDo3L5CyL4/d2Riy6pBVr258yjaBuVBioilcQm0kaTG7opeLouS35IXoG84JOUZ9NYgx9GFQEBF8xmkGAJHdPJKIrTGM5oEBMgghftX3X3g70jJAeVJuvc18HMkzoQGqiyjWbioRUbPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417772; c=relaxed/simple;
	bh=U90v5Pk93VeiqRlGaWd3w3TfoItyJk0Pr1aSpT1G4VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGg/qEbgOCQfQoZuwcknPrI59AlKpgKtSRx5Z+HA0opHF+ab81bDewngj3+CmDIxJPlIp8bnddJR1mefgUeZSYQv9XT4kncZQ6uQr1WyIkaGsUeBjnD/GwgD+F7yL6EeXo+IPMNMnVAPGB16hspboIWwzz+J00+TBlCqNkokyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vis1ppbf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220c8f38febso6286095ad.2
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 19:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739417769; x=1740022569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxu1Rc7/sI72JB4NYxxk9elaSjOiJ9Td89bVV/zMYyc=;
        b=Vis1ppbfARabHZAvNLFq9MM/+3FV38KUwbcOxPsLIw0E0bOil6y09ecYBWb4bn7hov
         JlXJW66LQjrepLqtmu+POOcHpW79nVgoiGOQOvSFK0blBKrUaJ+hG8NqsHDB6zAW/lqW
         ke9b8t/DkiPkqRYV/IVm/qNrVz+eaWMby4QrBQtNGvNqMBeSDg0Pgfx4w0UWeFtEq9UL
         H/5KWZr0APl209vnJl8o8qJ8WxaLJ0rYFTJzu+KHKV6+eDCHNh2/P+JmnugYm4KAEGyl
         HK1VJCJo2OwFdrpdtTeDTNSJBAW7MCCVVZj3faykjZqulhQo27Qj6qzBIp/KA0gkvAlD
         tVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739417769; x=1740022569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxu1Rc7/sI72JB4NYxxk9elaSjOiJ9Td89bVV/zMYyc=;
        b=BuepztY1F87YOEe5QEvtkW/Tmush3g71ghsn3mK2s5vB4d/HxKNj3LUFW4JCAh8a51
         nPb3Xlyb0AkxYQQzq1f75/QTp153SdCRYQOimsi88brnjKbnrfsOXyeKX0BtR1JqVBTB
         n4M7zvIBfOgwsSQZqTfwjsvw7K7U9aP1uNVIBTHIR/2VxonuSIG8MwL8XHHAPLAngwmg
         x027L+lURa4309mgZD4pZ8kx2kVcPsfVJZ7W7zludPcfRISSniKA+y00psUesmNJmHbm
         41S4QRdw/RwjLUvg9h38SW9wOdtqDwnBsKprz+5K/i/vGYd3crC3tZD3JfB57Ad72lrU
         d4JA==
X-Gm-Message-State: AOJu0YxpT4qgX41xyjGJGITNIwdjteedlf2FNqiVBMEGmgHugWikiQeU
	LQiWRHwdZfYy9uFzGY3PJmvW/+zzX9cwU5cWhaxIIcReYIhPXjYGqQxjpg==
X-Gm-Gg: ASbGncsN6aEdS6WKJoQaGjrcnk3Kp+ZanE3o/2CrIcPdriv3da2JpdQTr1XFhseM/lX
	UFAiW0ya+UfyY5ch4dFVFxr+PTU0gAPadUXjZIADH7L9sc7ej7S7PA7CL3TcSeBVQYDiy3CnlEc
	7iBrx3zI2DcXpji5WIGliDpWjyl3utI5s6uNVzA62vzSOZJ7J7ifE1Keh57H2qdA61thZ3rB0My
	SB8i1IxUXrsnkwY1F5YNuWiHP4MFVseCj5+vq38INGb9dU9FE6/TfkLhV8TTFW/mcYzFWZgVcRn
	V7vvnUJ2jRz2yzuOFnoO0IyrcJZ7d4PT15NNwnrvi7jkSy0NjQ==
X-Google-Smtp-Source: AGHT+IF0oyIrki3EN7feLFgHfxItX3wzuThKb7cJwiTjjSoOQ/uGuke17pktF4EceH+U1SvptjTlvw==
X-Received: by 2002:a17:902:c94b:b0:220:d1c3:2511 with SMTP id d9443c01a7336-220d1c327f5mr24489425ad.26.1739417769475;
        Wed, 12 Feb 2025 19:36:09 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d6d2sm2693595ad.177.2025.02.12.19.36.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 19:36:09 -0800 (PST)
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
Subject: [PATCH bpf-next v8 3/6] locking/local_lock: Introduce localtry_lock_t
Date: Wed, 12 Feb 2025 19:35:53 -0800
Message-Id: <20250213033556.9534-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
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
spin_trylock() is not safe due to PI issues.

Note there is no need to use local_inc for acquired variable,
since it's a percpu variable with strict nesting scopes.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  59 +++++++++++++
 include/linux/local_lock_internal.h | 123 ++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 091dc0b6bdfb..05c254a5d7d3 100644
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
index 8dd71fbbb6d2..c1369b300777 100644
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
@@ -118,6 +132,86 @@ do {								\
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
@@ -125,8 +219,10 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
+typedef spinlock_t localtry_lock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+#define INIT_LOCALTRY_LOCK(lockname) INIT_LOCAL_LOCK(lockname)
 
 #define __local_lock_init(l)					\
 	do {							\
@@ -169,4 +265,31 @@ do {								\
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
-- 
2.43.5


