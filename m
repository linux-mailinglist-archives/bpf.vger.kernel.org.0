Return-Path: <bpf+bounces-46215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C182C9E6222
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A62168AF1
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8012288B5;
	Fri,  6 Dec 2024 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aISFCA4L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B2208DA;
	Fri,  6 Dec 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444666; cv=none; b=r0BMxFDLwz+C5jM4nePj0eH+TzagQrZ85FirypYav47MouJ0DLZjzsVak/rCuapMO+Rwz9EQmhU0d+PEm8H/y6sNsQ3Km5yJVaj2njgewQq2ReikJHza1RgrSr2tvW2PfaV8eUvl8P40a5Gan1r9KgJVfOz2DvibA5BLpFYA8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444666; c=relaxed/simple;
	bh=XJcGgMfvVEFnnmGCSoFFS5wunI/wQCjII7NV6YUoSgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dScStbiZZF8fV+cTP/6EBjVit24O3iM9sZbLq8yfPAVTXBd/ybpU0HwVP5vvKItksyu1bRurHEhqIGc5EqmIwTIs/Ejh19dO/UBEAyLCnlzJoD1B7oFeoDShmgtoCTe36cGCqgqvEbJ5/bjfHGK9Gj3QobkZt9rA3/l9312Fmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aISFCA4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7093CC4CED1;
	Fri,  6 Dec 2024 00:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733444665;
	bh=XJcGgMfvVEFnnmGCSoFFS5wunI/wQCjII7NV6YUoSgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aISFCA4LCAzc+skMVsut5LurVjDfup/3THzEjW4bJo2wNtVzVsDQgW9OhSPFhsI34
	 cPAt3bstXQfkf8E4U+14Ii84Hda3/ekV+1/YmfdTi7GenoMtqntQ3PqBfOJt0LXykB
	 lhY64aZ330aNnJiTgHIeJw8PG5RFEoGCuGPxnfSMXe/4Mnz8mEGptkcwb6+WI/spuJ
	 +XG6bhlP/CIQe0gMNm0z7xA8zzrEV0inpiZLPxRAdOw1jUDtUQWkUqPhTjSqxR+IXP
	 tS5+GdqOz8z4TlwREhKwG6qQj9peeo67smqJaGMe4ENk9iLeMFbuYR4VW8UD9LjUG/
	 CJfA/8jbpflfg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	liaochang1@huawei.com,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH perf/core 1/4] uprobes: simplify session consumer tracking
Date: Thu,  5 Dec 2024 16:24:14 -0800
Message-ID: <20241206002417.3295533-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206002417.3295533-1-andrii@kernel.org>
References: <20241206002417.3295533-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In practice, each return_instance will typically contain either zero or
one return_consumer, depending on whether it has any uprobe session
consumer attached or not. It's highly unlikely that more than one uprobe
session consumers will be attached to any given uprobe, so there is no
need to optimize for that case. But the way we currently do memory
allocation and accounting is by pre-allocating the space for 4 session
consumers in contiguous block of memory next to struct return_instance
fixed part. This is unnecessarily wasteful.

This patch changes this to keep struct return_instance fixed-sized with one
pre-allocated return_consumer, while (in a highly unlikely scenario)
allowing for more session consumers in a separate dynamically
allocated and reallocated array.

We also simplify accounting a bit by not maintaining a separate
temporary capacity for consumers array, and, instead, relying on
krealloc() to be a no-op if underlying memory can accommodate a slightly
bigger allocation (but again, it's very uncommon scenario to even have
to do this reallocation).

All this gets rid of ri_size(), simplifies push_consumer() and removes
confusing ri->consumers_cnt re-assignment, while containing this
singular preallocated consumer logic contained within a few simple
preexisting helpers.

Having fixed-sized struct return_instance simplifies and speeds up
return_instance reuse that we ultimately add later in this patch set,
see follow up patches.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h | 10 ++++--
 kernel/events/uprobes.c | 72 +++++++++++++++++++++--------------------
 2 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e0a4c2082245..1d449978558d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -154,12 +154,18 @@ struct return_instance {
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
-	int			consumers_cnt;
+	int			cons_cnt;	/* total number of session consumers */
 
 	struct return_instance	*next;		/* keep as stack */
 	struct rcu_head		rcu;
 
-	struct return_consumer	consumers[] __counted_by(consumers_cnt);
+	/* singular pre-allocated return_consumer instance for common case */
+	struct return_consumer	consumer;
+	/*
+	 * extra return_consumer instances for rare cases of multiple session consumers,
+	 * contains (cons_cnt - 1) elements
+	 */
+	struct return_consumer	*extra_consumers;
 } ____cacheline_aligned;
 
 enum rp_check {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index daf4314961ab..6beac52239be 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1899,6 +1899,7 @@ static struct return_instance *free_ret_instance(struct return_instance *ri, boo
 		hprobe_finalize(&ri->hprobe, hstate);
 	}
 
+	kfree(ri->extra_consumers);
 	kfree_rcu(ri, rcu);
 	return next;
 }
@@ -1974,32 +1975,34 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
 
-static size_t ri_size(int consumers_cnt)
-{
-	struct return_instance *ri;
-
-	return sizeof(*ri) + sizeof(ri->consumers[0]) * consumers_cnt;
-}
-
-#define DEF_CNT 4
-
 static struct return_instance *alloc_return_instance(void)
 {
 	struct return_instance *ri;
 
-	ri = kzalloc(ri_size(DEF_CNT), GFP_KERNEL);
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
 		return ZERO_SIZE_PTR;
 
-	ri->consumers_cnt = DEF_CNT;
 	return ri;
 }
 
 static struct return_instance *dup_return_instance(struct return_instance *old)
 {
-	size_t size = ri_size(old->consumers_cnt);
+	struct return_instance *ri;
+
+	ri = kmemdup(old, sizeof(*ri), GFP_KERNEL);
+
+	if (unlikely(old->cons_cnt > 1)) {
+		ri->extra_consumers = kmemdup(old->extra_consumers,
+					      sizeof(ri->extra_consumers[0]) * (old->cons_cnt - 1),
+					      GFP_KERNEL);
+		if (!ri->extra_consumers) {
+			kfree(ri);
+			return NULL;
+		}
+	}
 
-	return kmemdup(old, size, GFP_KERNEL);
+	return ri;
 }
 
 static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
@@ -2369,25 +2372,28 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	return uprobe;
 }
 
-static struct return_instance*
-push_consumer(struct return_instance *ri, int idx, __u64 id, __u64 cookie)
+static struct return_instance *push_consumer(struct return_instance *ri, __u64 id, __u64 cookie)
 {
+	struct return_consumer *ric;
+
 	if (unlikely(ri == ZERO_SIZE_PTR))
 		return ri;
 
-	if (unlikely(idx >= ri->consumers_cnt)) {
-		struct return_instance *old_ri = ri;
-
-		ri->consumers_cnt += DEF_CNT;
-		ri = krealloc(old_ri, ri_size(old_ri->consumers_cnt), GFP_KERNEL);
-		if (!ri) {
-			kfree(old_ri);
+	if (unlikely(ri->cons_cnt > 0)) {
+		ric = krealloc(ri->extra_consumers, sizeof(*ric) * ri->cons_cnt, GFP_KERNEL);
+		if (!ric) {
+			kfree(ri->extra_consumers);
+			kfree_rcu(ri, rcu);
 			return ZERO_SIZE_PTR;
 		}
+		ri->extra_consumers = ric;
 	}
 
-	ri->consumers[idx].id = id;
-	ri->consumers[idx].cookie = cookie;
+	ric = likely(ri->cons_cnt == 0) ? &ri->consumer : &ri->extra_consumers[ri->cons_cnt - 1];
+	ric->id = id;
+	ric->cookie = cookie;
+
+	ri->cons_cnt++;
 	return ri;
 }
 
@@ -2395,14 +2401,17 @@ static struct return_consumer *
 return_consumer_find(struct return_instance *ri, int *iter, int id)
 {
 	struct return_consumer *ric;
-	int idx = *iter;
+	int idx;
 
-	for (ric = &ri->consumers[idx]; idx < ri->consumers_cnt; idx++, ric++) {
+	for (idx = *iter; idx < ri->cons_cnt; idx++)
+	{
+		ric = likely(idx == 0) ? &ri->consumer : &ri->extra_consumers[idx - 1];
 		if (ric->id == id) {
 			*iter = idx + 1;
 			return ric;
 		}
 	}
+
 	return NULL;
 }
 
@@ -2416,7 +2425,6 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_consumer *uc;
 	bool has_consumers = false, remove = true;
 	struct return_instance *ri = NULL;
-	int push_idx = 0;
 
 	current->utask->auprobe = &uprobe->arch;
 
@@ -2441,18 +2449,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 			ri = alloc_return_instance();
 
 		if (session)
-			ri = push_consumer(ri, push_idx++, uc->id, cookie);
+			ri = push_consumer(ri, uc->id, cookie);
 	}
 	current->utask->auprobe = NULL;
 
-	if (!ZERO_OR_NULL_PTR(ri)) {
-		/*
-		 * The push_idx value has the final number of return consumers,
-		 * and ri->consumers_cnt has number of allocated consumers.
-		 */
-		ri->consumers_cnt = push_idx;
+	if (!ZERO_OR_NULL_PTR(ri))
 		prepare_uretprobe(uprobe, regs, ri);
-	}
 
 	if (remove && has_consumers) {
 		down_read(&uprobe->register_rwsem);
-- 
2.43.5


