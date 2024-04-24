Return-Path: <bpf+bounces-27736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580778B1557
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6291F23113
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4B815748A;
	Wed, 24 Apr 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKhPv4G6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD1157479;
	Wed, 24 Apr 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995540; cv=none; b=aFaA/9E3m2gmgA1om9hpoN/T0JsyIX6H5pyNo1Y5F736OPvO7aUbY/D6A8KSADbcADLiK4NpgiyZTau8CENMfF8PC4wwAC4T/SR9Ksd/V3giI5m5wsq3k/yeF/mzontyrRGYgB6Cp5KPpveI1EX5QjFP0e6kqnOdWEYWXT2wnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995540; c=relaxed/simple;
	bh=XtNrbPSD1+IofbiPGH4XD5FP5EzJaizt14pH7ughloI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ir5BL0pYk+zdj2vrNh1+0MKibxjUNm4ZXsaJadRRBhBMEuurhZi9oQqjUhYS1pwbC2Cg6H+MIiB4cSMsdW0+mefphvJDrcN1agZZNiaVeSGdFVIf9IzMNvXAVwKrvHWYkVcJV4SgWb7SO2jYz52E76Xgkju/F5F/TeZPfzf1tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKhPv4G6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007D5C113CD;
	Wed, 24 Apr 2024 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713995540;
	bh=XtNrbPSD1+IofbiPGH4XD5FP5EzJaizt14pH7ughloI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKhPv4G6RseEmIZZSPXO4sWq+oyLvHS5DQOiaJ0cXQGyp0CMeX9M73InPIcy/WY45
	 Lp8c7Qq1joSWWFPJleHIrH6sUlt8pNLNQ/DbeLcCrsXTjSv+fP9MJGLrasfwu+O8vz
	 BtGuQASL4UtTlhZ+OAAWCYXuvH7WRmYnxeGVHfUo3U0mBLPu7cgQtS2ypoB59+9LTT
	 kccsw/Uk/fhEgB91z6tLqW4W7pcE9u1jobrpnqLNk/psByw25QGVb6tVKz7/LdGZxI
	 vWLWLU781kKJQM9sIegT7qBGuq75peLaeGkuzP1gi5uwKt8YnwIrfFNe3CgHVfYyP6
	 K8TltwwLIWIoQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>
Subject: [PATCH 1/2] objpool: enable inlining objpool_push() and objpool_pop() operations
Date: Wed, 24 Apr 2024 14:52:13 -0700
Message-ID: <20240424215214.3956041-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424215214.3956041-1-andrii@kernel.org>
References: <20240424215214.3956041-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

objpool_push() and objpool_pop() are very performance-critical functions
and can be called very frequently in kretprobe triggering path.

As such, it makes sense to allow compiler to inline them completely to
eliminate function calls overhead. Luckily, their logic is quite well
isolated and doesn't have any sprawling dependencies.

This patch moves both objpool_push() and objpool_pop() into
include/linux/objpool.h and marks them as static inline functions,
enabling inlining. To avoid anyone using internal helpers
(objpool_try_get_slot, objpool_try_add_slot), rename them to use leading
underscores.

We used kretprobe microbenchmark from BPF selftests (bench trig-kprobe
and trig-kprobe-multi benchmarks) running no-op BPF kretprobe/kretprobe.multi
programs in a tight loop to evaluate the effect. BPF own overhead in
this case is minimal and it mostly stresses the rest of in-kernel
kretprobe infrastructure overhead. Results are in millions of calls per
second. This is not super scientific, but shows the trend nevertheless.

BEFORE
======
kretprobe      :    9.794 ± 0.086M/s
kretprobe-multi:   10.219 ± 0.032M/s

AFTER
=====
kretprobe      :    9.937 ± 0.174M/s (+1.5%)
kretprobe-multi:   10.440 ± 0.108M/s (+2.2%)

Cc: Matt (Qiang) Wu <wuqiang.matt@bytedance.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/objpool.h | 101 +++++++++++++++++++++++++++++++++++++++-
 lib/objpool.c           | 100 ---------------------------------------
 2 files changed, 99 insertions(+), 102 deletions(-)

diff --git a/include/linux/objpool.h b/include/linux/objpool.h
index 15aff4a17f0c..d8b1f7b91128 100644
--- a/include/linux/objpool.h
+++ b/include/linux/objpool.h
@@ -5,6 +5,10 @@
 
 #include <linux/types.h>
 #include <linux/refcount.h>
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
+#include <linux/irqflags.h>
+#include <linux/smp.h>
 
 /*
  * objpool: ring-array based lockless MPMC queue
@@ -118,13 +122,94 @@ int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
 		 gfp_t gfp, void *context, objpool_init_obj_cb objinit,
 		 objpool_fini_cb release);
 
+/* try to retrieve object from slot */
+static inline void *__objpool_try_get_slot(struct objpool_head *pool, int cpu)
+{
+	struct objpool_slot *slot = pool->cpu_slots[cpu];
+	/* load head snapshot, other cpus may change it */
+	uint32_t head = smp_load_acquire(&slot->head);
+
+	while (head != READ_ONCE(slot->last)) {
+		void *obj;
+
+		/*
+		 * data visibility of 'last' and 'head' could be out of
+		 * order since memory updating of 'last' and 'head' are
+		 * performed in push() and pop() independently
+		 *
+		 * before any retrieving attempts, pop() must guarantee
+		 * 'last' is behind 'head', that is to say, there must
+		 * be available objects in slot, which could be ensured
+		 * by condition 'last != head && last - head <= nr_objs'
+		 * that is equivalent to 'last - head - 1 < nr_objs' as
+		 * 'last' and 'head' are both unsigned int32
+		 */
+		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
+			head = READ_ONCE(slot->head);
+			continue;
+		}
+
+		/* obj must be retrieved before moving forward head */
+		obj = READ_ONCE(slot->entries[head & slot->mask]);
+
+		/* move head forward to mark it's consumption */
+		if (try_cmpxchg_release(&slot->head, &head, head + 1))
+			return obj;
+	}
+
+	return NULL;
+}
+
 /**
  * objpool_pop() - allocate an object from objpool
  * @pool: object pool
  *
  * return value: object ptr or NULL if failed
  */
-void *objpool_pop(struct objpool_head *pool);
+static inline void *objpool_pop(struct objpool_head *pool)
+{
+	void *obj = NULL;
+	unsigned long flags;
+	int i, cpu;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
+
+	cpu = raw_smp_processor_id();
+	for (i = 0; i < num_possible_cpus(); i++) {
+		obj = __objpool_try_get_slot(pool, cpu);
+		if (obj)
+			break;
+		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
+	}
+	raw_local_irq_restore(flags);
+
+	return obj;
+}
+
+/* adding object to slot, abort if the slot was already full */
+static inline int
+__objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
+{
+	struct objpool_slot *slot = pool->cpu_slots[cpu];
+	uint32_t head, tail;
+
+	/* loading tail and head as a local snapshot, tail first */
+	tail = READ_ONCE(slot->tail);
+
+	do {
+		head = READ_ONCE(slot->head);
+		/* fault caught: something must be wrong */
+		WARN_ON_ONCE(tail - head > pool->nr_objs);
+	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
+
+	/* now the tail position is reserved for the given obj */
+	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
+	/* update sequence to make this obj available for pop() */
+	smp_store_release(&slot->last, tail + 1);
+
+	return 0;
+}
 
 /**
  * objpool_push() - reclaim the object and return back to objpool
@@ -134,7 +219,19 @@ void *objpool_pop(struct objpool_head *pool);
  * return: 0 or error code (it fails only when user tries to push
  * the same object multiple times or wrong "objects" into objpool)
  */
-int objpool_push(void *obj, struct objpool_head *pool);
+static inline int objpool_push(void *obj, struct objpool_head *pool)
+{
+	unsigned long flags;
+	int rc;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
+	rc = __objpool_try_add_slot(obj, pool, raw_smp_processor_id());
+	raw_local_irq_restore(flags);
+
+	return rc;
+}
+
 
 /**
  * objpool_drop() - discard the object and deref objpool
diff --git a/lib/objpool.c b/lib/objpool.c
index cfdc02420884..f696308fc026 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -152,106 +152,6 @@ int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
 }
 EXPORT_SYMBOL_GPL(objpool_init);
 
-/* adding object to slot, abort if the slot was already full */
-static inline int
-objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
-{
-	struct objpool_slot *slot = pool->cpu_slots[cpu];
-	uint32_t head, tail;
-
-	/* loading tail and head as a local snapshot, tail first */
-	tail = READ_ONCE(slot->tail);
-
-	do {
-		head = READ_ONCE(slot->head);
-		/* fault caught: something must be wrong */
-		WARN_ON_ONCE(tail - head > pool->nr_objs);
-	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
-
-	/* now the tail position is reserved for the given obj */
-	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
-	/* update sequence to make this obj available for pop() */
-	smp_store_release(&slot->last, tail + 1);
-
-	return 0;
-}
-
-/* reclaim an object to object pool */
-int objpool_push(void *obj, struct objpool_head *pool)
-{
-	unsigned long flags;
-	int rc;
-
-	/* disable local irq to avoid preemption & interruption */
-	raw_local_irq_save(flags);
-	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
-	raw_local_irq_restore(flags);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(objpool_push);
-
-/* try to retrieve object from slot */
-static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
-{
-	struct objpool_slot *slot = pool->cpu_slots[cpu];
-	/* load head snapshot, other cpus may change it */
-	uint32_t head = smp_load_acquire(&slot->head);
-
-	while (head != READ_ONCE(slot->last)) {
-		void *obj;
-
-		/*
-		 * data visibility of 'last' and 'head' could be out of
-		 * order since memory updating of 'last' and 'head' are
-		 * performed in push() and pop() independently
-		 *
-		 * before any retrieving attempts, pop() must guarantee
-		 * 'last' is behind 'head', that is to say, there must
-		 * be available objects in slot, which could be ensured
-		 * by condition 'last != head && last - head <= nr_objs'
-		 * that is equivalent to 'last - head - 1 < nr_objs' as
-		 * 'last' and 'head' are both unsigned int32
-		 */
-		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
-			head = READ_ONCE(slot->head);
-			continue;
-		}
-
-		/* obj must be retrieved before moving forward head */
-		obj = READ_ONCE(slot->entries[head & slot->mask]);
-
-		/* move head forward to mark it's consumption */
-		if (try_cmpxchg_release(&slot->head, &head, head + 1))
-			return obj;
-	}
-
-	return NULL;
-}
-
-/* allocate an object from object pool */
-void *objpool_pop(struct objpool_head *pool)
-{
-	void *obj = NULL;
-	unsigned long flags;
-	int i, cpu;
-
-	/* disable local irq to avoid preemption & interruption */
-	raw_local_irq_save(flags);
-
-	cpu = raw_smp_processor_id();
-	for (i = 0; i < num_possible_cpus(); i++) {
-		obj = objpool_try_get_slot(pool, cpu);
-		if (obj)
-			break;
-		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
-	}
-	raw_local_irq_restore(flags);
-
-	return obj;
-}
-EXPORT_SYMBOL_GPL(objpool_pop);
-
 /* release whole objpool forcely */
 void objpool_free(struct objpool_head *pool)
 {
-- 
2.43.0


