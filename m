Return-Path: <bpf+bounces-34179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56292AD2E
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200731C212E6
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314738DFC;
	Tue,  9 Jul 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9XGdeBn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94473612D;
	Tue,  9 Jul 2024 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485654; cv=none; b=liAU2vf+AVe+xMb2zpz6R30rMcSKhMjtQvjpgABd//QjHtjtO91gGNgN26hIQTsrkMLsSwCr2JA/GJ86vzfK42wxxjFaGVFSIvn5Cnn+SgLpQfKWlzO5sMD4NjRL8TFE0XCYW/1jLpfwnIlPk0dQ19lSKwel4Pz07sjrPqAwSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485654; c=relaxed/simple;
	bh=tbzHIRib7qqNQULKsuexke8HJylXQhJ1f0GbLtbB5Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsKK4bzzK6egdIHfazA3KmFUAN9feqHUnvA9SPEUvSgwHgyJxKxrNJShx4uGRpg6+oaOYshPiyjBfW3bAMLlFK73Fvfzh167dMjvvrupJPQAoFQvaX0ThaYvkZP+9vUn5QBi/qdbxCbFQhJxzZTRhMrMgoSTwLqWu8hdAy/llhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9XGdeBn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb53bfb6easo18154275ad.2;
        Mon, 08 Jul 2024 17:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720485652; x=1721090452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxmafiSR6k4R2wQFiP9NmJTSMZynO/xpv4YZvryzppU=;
        b=c9XGdeBnFGMfLB/YLhZQnJI+cDum7yahVG771axsXLv+L9QgC5yNrND/WyBUq2ynRt
         8YfdI5C8hnJD1BNZlTwFFSxITMZiK4BZ2o6yxVMhQqKIzTuAsBryb8mFCYKyLfW1LRcN
         /JtZsLLRQCfmvePNfq0qEluE2/c42cKnaYL4AjPoK5WNRXa+3fEJHZLQaFk6in2UVVcw
         /t8cESKRii39ihkbBZvzDmMp9HgsnliIK4ActeuQW9c4AOZmjg4zNNW/4TyFUrqSJy5d
         55NnLfZ3hcmLQYz/tH1q9KO4bA6E01bPwBgk3ZcvssyCUwwD4JYKIZI4CfXN2PWfCF/I
         uJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720485652; x=1721090452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FxmafiSR6k4R2wQFiP9NmJTSMZynO/xpv4YZvryzppU=;
        b=ikh8vA1dhuPESl5vYu+P9OnT2Nk4TCwFL0U7V2RYQ8p5yt67w9HDAiaUqpAR8kFiaQ
         UITDJpZfdsq783A2IOt6995pU0xPLCPQoz34VukXHF99n+c6TkoWs82EAkonA+AgbRoL
         xASg2YQBY3U0yYOlCOGm9WNocth+SCTgiWABTADMKeKLDjPWKOyDSjVv/M+p2L/lwUMA
         5dKg1zybDqu1TWod03zzNyH+Jrx8zg08aHzY7GAOhCMEA9yrU1jal3zvGYmSyq7+xUbv
         wNCVncqK3/jdnllFmsRbUgHVn6jsuFcw86u73UVBbEvu4uCZ6WECgX5W49kZseS27qOp
         znRA==
X-Forwarded-Encrypted: i=1; AJvYcCXyYQDD5O3+qjOyc0VPatI8XzxM05B1zyKEpla4i9RGx+LWyeAOmJJ6yefwkd0PZUCLKwzNrJLCTvKsyw0G2cT9rp31
X-Gm-Message-State: AOJu0Yx2/YTzOx7ZXgziSH0QbXER41ijeOm74yn2y1yJT/czJ3DYXKLN
	MwcLgbNqvPq3u2hD80Cu03RZlKOQLbIjdcJFAtHX0LNmso1vwBHx
X-Google-Smtp-Source: AGHT+IEJ/3n42eWr0olISdz70f50Y+1j2WjNhWbV4A2+WFam/3JV/o7W/Bzg99tlRM5UUm3kuiPJLw==
X-Received: by 2002:a17:902:a604:b0:1fa:ff8:e66e with SMTP id d9443c01a7336-1fbb6eb248cmr6658085ad.59.1720485651857;
        Mon, 08 Jul 2024 17:40:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac29f2sm4414125ad.218.2024.07.08.17.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:40:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org,
	andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	void@manifault.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>
Subject: [PATCH 2/3] sched_ext: Implement DSQ iterator
Date: Mon,  8 Jul 2024 14:40:23 -1000
Message-ID: <20240709004041.1111039-3-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709004041.1111039-1-tj@kernel.org>
References: <20240709004041.1111039-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSQs are very opaque in the consumption path. The BPF scheduler has no way
of knowing which tasks are being considered and which is picked. This patch
adds BPF DSQ iterator.

- Allows iterating tasks queued on a DSQ in the dispatch order or reverse
  from anywhere using bpf_for_each(scx_dsq) or calling the iterator kfuncs
  directly.

- Has ordering guarantee where only tasks which were already queued when the
  iteration started are visible and consumable during the iteration.

v5: - Add a comment to the naked list_empty(&dsq->list) test in
      consume_dispatch_q() to explain the reasoning behind the lockless test
      and by extension why nldsq_next_task() isn't used there.

    - scx_qmap changes separated into its own patch.

v4: - bpf_iter_scx_dsq_new() declaration in common.bpf.h was using the wrong
      type for the last argument (bool rev instead of u64 flags). Fix it.

v3: - Alexei pointed out that the iterator is too big to allocate on stack.
      Added a prep patch to reduce the size of the cursor. Now
      bpf_iter_scx_dsq is 48 bytes and bpf_iter_scx_dsq_kern is 40 bytes on
      64bit.

    - u32_before() comparison factored out.

v2: - scx_bpf_consume_task() is separated out into a separate patch.

    - DSQ seq and iter flags don't need to be u64. Use u32.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
---
 include/linux/sched/ext.h                |   3 +
 kernel/sched/ext.c                       | 192 ++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |   3 +
 3 files changed, 196 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index eb9cfd18a923..593d2f4909dd 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -61,6 +61,7 @@ struct scx_dispatch_q {
 	struct list_head	list;	/* tasks in dispatch order */
 	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
 	u32			nr;
+	u32			seq;	/* used by BPF iter */
 	u64			id;
 	struct rhash_head	hash_node;
 	struct llist_node	free_node;
@@ -123,6 +124,7 @@ enum scx_kf_mask {
 
 struct scx_dsq_list_node {
 	struct list_head	node;
+	bool			is_bpf_iter_cursor;
 };
 
 /*
@@ -133,6 +135,7 @@ struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
 	struct scx_dsq_list_node dsq_list;	/* dispatch order */
 	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
+	u32			dsq_seq;
 	u32			dsq_flags;	/* protected by DSQ lock */
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 069c2f33883c..f16d72d72635 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -926,6 +926,11 @@ static u32 highest_bit(u32 flags)
 	return ((u64)1 << bit) >> 1;
 }
 
+static bool u32_before(u32 a, u32 b)
+{
+	return (s32)(a - b) < 0;
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -1066,6 +1071,73 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
 	return true;
 }
 
+/**
+ * nldsq_next_task - Iterate to the next task in a non-local DSQ
+ * @dsq: user dsq being interated
+ * @cur: current position, %NULL to start iteration
+ * @rev: walk backwards
+ *
+ * Returns %NULL when iteration is finished.
+ */
+static struct task_struct *nldsq_next_task(struct scx_dispatch_q *dsq,
+					   struct task_struct *cur, bool rev)
+{
+	struct list_head *list_node;
+	struct scx_dsq_list_node *dsq_lnode;
+
+	lockdep_assert_held(&dsq->lock);
+
+	if (cur)
+		list_node = &cur->scx.dsq_list.node;
+	else
+		list_node = &dsq->list;
+
+	/* find the next task, need to skip BPF iteration cursors */
+	do {
+		if (rev)
+			list_node = list_node->prev;
+		else
+			list_node = list_node->next;
+
+		if (list_node == &dsq->list)
+			return NULL;
+
+		dsq_lnode = container_of(list_node, struct scx_dsq_list_node,
+					 node);
+	} while (dsq_lnode->is_bpf_iter_cursor);
+
+	return container_of(dsq_lnode, struct task_struct, scx.dsq_list);
+}
+
+#define nldsq_for_each_task(p, dsq)						\
+	for ((p) = nldsq_next_task((dsq), NULL, false); (p);			\
+	     (p) = nldsq_next_task((dsq), (p), false))
+
+
+/*
+ * BPF DSQ iterator. Tasks in a non-local DSQ can be iterated in [reverse]
+ * dispatch order. BPF-visible iterator is opaque and larger to allow future
+ * changes without breaking backward compatibility. Can be used with
+ * bpf_for_each(). See bpf_iter_scx_dsq_*().
+ */
+enum scx_dsq_iter_flags {
+	/* iterate in the reverse dispatch order */
+	SCX_DSQ_ITER_REV		= 1U << 0,
+
+	__SCX_DSQ_ITER_ALL_FLAGS	= SCX_DSQ_ITER_REV,
+};
+
+struct bpf_iter_scx_dsq_kern {
+	struct scx_dsq_list_node	cursor;
+	struct scx_dispatch_q		*dsq;
+	u32				dsq_seq;
+	u32				flags;
+} __attribute__((aligned(8)));
+
+struct bpf_iter_scx_dsq {
+	u64				__opaque[6];
+} __attribute__((aligned(8)));
+
 
 /*
  * SCX task iterator.
@@ -1415,7 +1487,7 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		 * tested easily when adding the first task.
 		 */
 		if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
-			     !list_empty(&dsq->list)))
+			     nldsq_next_task(dsq, NULL, false)))
 			scx_ops_error("DSQ ID 0x%016llx already had FIFO-enqueued tasks",
 				      dsq->id);
 
@@ -1447,6 +1519,10 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
 	}
 
+	/* seq records the order tasks are queued, used by BPF DSQ iterator */
+	dsq->seq++;
+	p->scx.dsq_seq = dsq->seq;
+
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
@@ -2104,12 +2180,17 @@ static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 {
 	struct task_struct *p;
 retry:
+	/*
+	 * The caller can't expect to successfully consume a task if the task's
+	 * addition to @dsq isn't guaranteed to be visible somehow. Test
+	 * @dsq->list without locking and skip if it seems empty.
+	 */
 	if (list_empty(&dsq->list))
 		return false;
 
 	raw_spin_lock(&dsq->lock);
 
-	list_for_each_entry(p, &dsq->list, scx.dsq_list.node) {
+	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
@@ -5705,6 +5786,110 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64 dsq_id)
 	destroy_dsq(dsq_id);
 }
 
+/**
+ * bpf_iter_scx_dsq_new - Create a DSQ iterator
+ * @it: iterator to initialize
+ * @dsq_id: DSQ to iterate
+ * @flags: %SCX_DSQ_ITER_*
+ *
+ * Initialize BPF iterator @it which can be used with bpf_for_each() to walk
+ * tasks in the DSQ specified by @dsq_id. Iteration using @it only includes
+ * tasks which are already queued when this function is invoked.
+ */
+__bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
+				     u64 flags)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_scx_dsq_kern) >
+		     sizeof(struct bpf_iter_scx_dsq));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_scx_dsq_kern) !=
+		     __alignof__(struct bpf_iter_scx_dsq));
+
+	if (flags & ~__SCX_DSQ_ITER_ALL_FLAGS)
+		return -EINVAL;
+
+	kit->dsq = find_non_local_dsq(dsq_id);
+	if (!kit->dsq)
+		return -ENOENT;
+
+	INIT_LIST_HEAD(&kit->cursor.node);
+	kit->cursor.is_bpf_iter_cursor = true;
+	kit->dsq_seq = READ_ONCE(kit->dsq->seq);
+	kit->flags = flags;
+
+	return 0;
+}
+
+/**
+ * bpf_iter_scx_dsq_next - Progress a DSQ iterator
+ * @it: iterator to progress
+ *
+ * Return the next task. See bpf_iter_scx_dsq_new().
+ */
+__bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+	bool rev = kit->flags & SCX_DSQ_ITER_REV;
+	struct task_struct *p;
+	unsigned long flags;
+
+	if (!kit->dsq)
+		return NULL;
+
+	raw_spin_lock_irqsave(&kit->dsq->lock, flags);
+
+	if (list_empty(&kit->cursor.node))
+		p = NULL;
+	else
+		p = container_of(&kit->cursor, struct task_struct, scx.dsq_list);
+
+	/*
+	 * Only tasks which were queued before the iteration started are
+	 * visible. This bounds BPF iterations and guarantees that vtime never
+	 * jumps in the other direction while iterating.
+	 */
+	do {
+		p = nldsq_next_task(kit->dsq, p, rev);
+	} while (p && unlikely(u32_before(kit->dsq_seq, p->scx.dsq_seq)));
+
+	if (p) {
+		if (rev)
+			list_move_tail(&kit->cursor.node, &p->scx.dsq_list.node);
+		else
+			list_move(&kit->cursor.node, &p->scx.dsq_list.node);
+	} else {
+		list_del_init(&kit->cursor.node);
+	}
+
+	raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
+
+	return p;
+}
+
+/**
+ * bpf_iter_scx_dsq_destroy - Destroy a DSQ iterator
+ * @it: iterator to destroy
+ *
+ * Undo scx_iter_scx_dsq_new().
+ */
+__bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+
+	if (!kit->dsq)
+		return;
+
+	if (!list_empty(&kit->cursor.node)) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&kit->dsq->lock, flags);
+		list_del_init(&kit->cursor.node);
+		raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
+	}
+	kit->dsq = NULL;
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(u64 *data_buf, char *line_buf, size_t line_size,
@@ -6138,6 +6323,9 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 965d20324114..20280df62857 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -39,6 +39,9 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
+struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
+void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
 void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
-- 
2.45.2


