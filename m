Return-Path: <bpf+bounces-27737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6428B1558
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0233B2156C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0E9157492;
	Wed, 24 Apr 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDowTJ65"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA8157469;
	Wed, 24 Apr 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995544; cv=none; b=N2oBySmEm5RbmTMSt8EUnAhZVrSVhhgS8VT7qkQmtMhmwaG172Op22jifi0iClTWlCnnVJIoyP0IIKla6cDGtomLfbkIkZ2py8MLG98B7M5WRowGoU4gsoSeDA5qbH/MKCqt4vov6NXy93uajyZuhxwNHKKqfw0VuZEP6pHFzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995544; c=relaxed/simple;
	bh=v8ZEyC9wZDEBzCvIlqmeLIf+Ne1bHwEK75ySUZPrO0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4AfyddsWTMnzgz0ZLJPQPq2iZkIliTPCyVdEZaX+7BwoRvkN6IkTU8+/ZGvyCdmg4aG9yWvEXLn9OE7+MT5VsJVw/yIFNPewdT6WnungqzkMhX+8s6JC0UvuNLIZk3wnQwOmd/Ma0f3hEVgPClCnnQQZEI4S/8oz1Jywa4qj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDowTJ65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623C8C113CD;
	Wed, 24 Apr 2024 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713995543;
	bh=v8ZEyC9wZDEBzCvIlqmeLIf+Ne1bHwEK75ySUZPrO0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDowTJ651yBEr7sTKS432/aQiXrtGVF7CVPNFJdQeYkKbWciQqzy3QeS+SOZZMFCL
	 d4X7Q5eYSWb5nDahHLJu3Mp/IiZ71zx2Yxc6qpcl6V1Lk18xCpvDZ25VdY3PZb0VJO
	 eJh8xlvQNuwpjvyusSH3nFHtqxkDHf5nQujseb7hXi6/tZHpisno7uD1xgfynzNPEK
	 jTQgwvMPxGfYc84nIM+yWpHYwuErUrQ9H4dRLwdPRx4+/1hbaqs5ppMM7mZ2BlluSk
	 Q9gnlJJk2WKMjgjAhQp9qzFZ7Oc+zshq8MVRjdJm64WVEXQegZ2av8KGKty8aFyIIx
	 I/rbi8yPevPcA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>
Subject: [PATCH 2/2] objpool: cache nr_possible_cpus() and avoid caching nr_cpu_ids
Date: Wed, 24 Apr 2024 14:52:14 -0700
Message-ID: <20240424215214.3956041-3-andrii@kernel.org>
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

Profiling shows that calling nr_possible_cpus() in objpool_pop() takes
a noticeable amount of CPU (when profiled on 80-core machine), as we
need to recalculate number of set bits in a CPU bit mask. This number
can't change, so there is no point in paying the price for recalculating
it. As such, cache this value in struct objpool_head and use it in
objpool_pop().

On the other hand, cached pool->nr_cpus isn't necessary, as it's not
used in hot path and is also a pretty trivial value to retrieve. So drop
pool->nr_cpus in favor of using nr_cpu_ids everywhere. This way the size
of struct objpool_head remains the same, which is a nice bonus.

Same BPF selftests benchmarks were used to evaluate the effect. Using
changes in previous patch (inlining of objpool_pop/objpool_push) as
baseline, here are the differences:

BASELINE
========
kretprobe      :    9.937 ± 0.174M/s
kretprobe-multi:   10.440 ± 0.108M/s

AFTER
=====
kretprobe      :   10.106 ± 0.120M/s (+1.7%)
kretprobe-multi:   10.515 ± 0.180M/s (+0.7%)

Cc: Matt (Qiang) Wu <wuqiang.matt@bytedance.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/objpool.h |  6 +++---
 lib/objpool.c           | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/objpool.h b/include/linux/objpool.h
index d8b1f7b91128..cb1758eaa2d3 100644
--- a/include/linux/objpool.h
+++ b/include/linux/objpool.h
@@ -73,7 +73,7 @@ typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
  * struct objpool_head - object pooling metadata
  * @obj_size:   object size, aligned to sizeof(void *)
  * @nr_objs:    total objs (to be pre-allocated with objpool)
- * @nr_cpus:    local copy of nr_cpu_ids
+ * @nr_possible_cpus: cached value of num_possible_cpus()
  * @capacity:   max objs can be managed by one objpool_slot
  * @gfp:        gfp flags for kmalloc & vmalloc
  * @ref:        refcount of objpool
@@ -85,7 +85,7 @@ typedef int (*objpool_fini_cb)(struct objpool_head *head, void *context);
 struct objpool_head {
 	int                     obj_size;
 	int                     nr_objs;
-	int                     nr_cpus;
+	int                     nr_possible_cpus;
 	int                     capacity;
 	gfp_t                   gfp;
 	refcount_t              ref;
@@ -176,7 +176,7 @@ static inline void *objpool_pop(struct objpool_head *pool)
 	raw_local_irq_save(flags);
 
 	cpu = raw_smp_processor_id();
-	for (i = 0; i < num_possible_cpus(); i++) {
+	for (i = 0; i < pool->nr_possible_cpus; i++) {
 		obj = __objpool_try_get_slot(pool, cpu);
 		if (obj)
 			break;
diff --git a/lib/objpool.c b/lib/objpool.c
index f696308fc026..234f9d0bd081 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -50,7 +50,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
 {
 	int i, cpu_count = 0;
 
-	for (i = 0; i < pool->nr_cpus; i++) {
+	for (i = 0; i < nr_cpu_ids; i++) {
 
 		struct objpool_slot *slot;
 		int nodes, size, rc;
@@ -60,8 +60,8 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
 			continue;
 
 		/* compute how many objects to be allocated with this slot */
-		nodes = nr_objs / num_possible_cpus();
-		if (cpu_count < (nr_objs % num_possible_cpus()))
+		nodes = nr_objs / pool->nr_possible_cpus;
+		if (cpu_count < (nr_objs % pool->nr_possible_cpus))
 			nodes++;
 		cpu_count++;
 
@@ -103,7 +103,7 @@ static void objpool_fini_percpu_slots(struct objpool_head *pool)
 	if (!pool->cpu_slots)
 		return;
 
-	for (i = 0; i < pool->nr_cpus; i++)
+	for (i = 0; i < nr_cpu_ids; i++)
 		kvfree(pool->cpu_slots[i]);
 	kfree(pool->cpu_slots);
 }
@@ -130,13 +130,13 @@ int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
 
 	/* initialize objpool pool */
 	memset(pool, 0, sizeof(struct objpool_head));
-	pool->nr_cpus = nr_cpu_ids;
+	pool->nr_possible_cpus = num_possible_cpus();
 	pool->obj_size = object_size;
 	pool->capacity = capacity;
 	pool->gfp = gfp & ~__GFP_ZERO;
 	pool->context = context;
 	pool->release = release;
-	slot_size = pool->nr_cpus * sizeof(struct objpool_slot);
+	slot_size = nr_cpu_ids * sizeof(struct objpool_slot);
 	pool->cpu_slots = kzalloc(slot_size, pool->gfp);
 	if (!pool->cpu_slots)
 		return -ENOMEM;
-- 
2.43.0


