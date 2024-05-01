Return-Path: <bpf+bounces-28366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DC98B8CC8
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF10280F63
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0B13A89A;
	Wed,  1 May 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcr+4Odh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84413A261;
	Wed,  1 May 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576475; cv=none; b=U+wK5PYWsPnwif3cxQ2aQhIeGzsK3+Pucc6g75tzqwWQRq1fPLpHvqewPH8OUoeG0Fddezke10gMylANbnUpr6EWVWRim+JxXVpBrlmhSlPUkla+SCv+ddpyi8OVwH8AfnwelOaMSs+cvJNfQvRsxnkAXg9l3oY7PZhlA9IKjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576475; c=relaxed/simple;
	bh=iJb2LSUiGBxmrgz4bAxRC+2wK37RpT/feqreOT6i+Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8d41IKbslPDoC7wv74l7OEKXVoEc0emWqoYZjgOQY4lhJdYr8BmAT6V/Tt37Ziez7/X5SOm5Y5wQQ9M36JStKrBRSmVIaD9ag/NiQiLwdTjNRq8D+ocu6L+FCNmp1nAGUGef8SrncRFnkWXT47Qv1+wEOc+Zl00ndj55YAtKAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcr+4Odh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4178aec15so1389737b3a.0;
        Wed, 01 May 2024 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576472; x=1715181272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro+m552MFLE2iVSGPT8gWxPGdYcQAGPDSSJd3ksdqDo=;
        b=hcr+4OdhUuBAsNE/0hvUboXOWwhBITzJ5t77GmNlKBt7E6cxgqgwz2v7SHEBIw2y1V
         7rGBUyfDS8ClvtDBsRJ0o9NZQL0RKJGYScjTDIEADPZNV5wdCWykS52aIWoO2AYrr7oY
         Hbr+q1C1/BtiX4N7LmyTH7i21JmQFju+r0xwZSczRDqdxGC7klPZlZwkS/rBJLLndA17
         O5O9XxxDYphTct3loQbEvQJDFUaulh13o9m/jsrYiQTVdHRjIc3qchifGXG5nbMOcKQ2
         VnvUF3mv+PPV5A+PJZ1Ys3S9feOLgSfcv2/bIgaztDBzNE/V6nteM/hvvXtTFJj/Chls
         Onkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576472; x=1715181272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ro+m552MFLE2iVSGPT8gWxPGdYcQAGPDSSJd3ksdqDo=;
        b=LtxhOk48mheX8I1CZ68zT3/qZ6fGORwETUJ6As4ulhmhd3lMuKj0kDTBujUFDx7RDo
         EKewgHUoqNycczA5oO45giF1RGGG2YTKJJ6OEQB58W1iz5NmUtRE/pVQmjNQZFZBwBa3
         xIFwQQkrX8PE3XKZLD6Vk+9eE11Rg27LADPyA4ThdnWvNh4W9g7bHluMYs2rIdKcOxok
         xMkDwCMMWxPw7fyiYTUgOKiDRD4smcrmxDzxAxghuEq+4GhhnwMYxSfBIO2pMF411ZIe
         xUY32sgE32+lsNYNiRFeE6nzeFGKzaoPFFZuLYVvanfpH8J04wavZDdRVR52CNnwoe0R
         +jUw==
X-Forwarded-Encrypted: i=1; AJvYcCWlrfa7N6Dnb7fzm8luEFWXhUoQvAAKMUMiVbwuZki1g0YbdU4ojRbVjvIcActHO95NVcnAyzMaaFMCBSEnMrdjZEak
X-Gm-Message-State: AOJu0YwydMxX65nks/1K4+Ubg8tbt4dhK+EkaX8FyiYVsQAxdoOBZ8xm
	pJT7aX7DMsnD3DVJBY4GGc6YXD4qUVv0FtLRmpACMK4uJP7hUo4B
X-Google-Smtp-Source: AGHT+IEcSpxZZK7iiYl1VCD8E6kDGUQLcWLpUeg89xzsw1ijB3+9GRbkCPG8Zg7jfyAy2Hzc9miZTQ==
X-Received: by 2002:a05:6a00:22c6:b0:6ea:950f:7d29 with SMTP id f6-20020a056a0022c600b006ea950f7d29mr3446671pfj.20.1714576471031;
        Wed, 01 May 2024 08:14:31 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id q3-20020a056a00084300b006ecc6c1c67asm22713823pfk.215.2024.05.01.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 36/39] sched_ext: Implement DSQ iterator
Date: Wed,  1 May 2024 05:10:11 -1000
Message-ID: <20240501151312.635565-37-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
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

- Allows consuming arbitrary tasks on the DSQ in any order while iterating
  in the dispatch path using the new scx_bpf_consume_task().

- Has ordering guarantee where only tasks which were already queued when the
  iteration started are visible and consumable during the iteration.

Note that scx_bpf_consume_task() does a bit of dance to pass in the pointer
to the iterator to __scx_bpf_consume_task(). This is to work around the
current limitation in the BPF verifier where it doesn't allow the memory
area used for an iterator to be passed into kfuncs. We should be able to
remove this workaround in the future.

scx_qmap is updated to implement periodic dumping of the shared DSQ and a
rather silly prioritization mechanism to demonstrate the use of DSQ
iteration and selective consumption.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 include/linux/sched/ext.h                |   4 +
 kernel/sched/ext.c                       | 271 ++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  19 ++
 tools/sched_ext/include/scx/compat.bpf.h |  15 ++
 tools/sched_ext/include/scx/compat.h     |   6 +
 tools/sched_ext/scx_qmap.bpf.c           |  98 +++++++-
 tools/sched_ext/scx_qmap.c               |  22 +-
 7 files changed, 422 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 8c6299915800..32cc5f439983 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -59,6 +59,7 @@ struct scx_dispatch_q {
 	struct list_head	list;	/* tasks in dispatch order */
 	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
 	u32			nr;
+	u64			seq;	/* used by BPF iter */
 	u64			id;
 	struct rhash_head	hash_node;
 	struct llist_node	free_node;
@@ -92,6 +93,8 @@ enum scx_task_state {
 /* scx_entity.dsq_flags */
 enum scx_ent_dsq_flags {
 	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
+
+	SCX_TASK_DSQ_CURSOR	= 1 << 31, /* iteration cursor, not a task */
 };
 
 /*
@@ -132,6 +135,7 @@ struct scx_dsq_node {
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
 	struct scx_dsq_node	dsq_node;	/* protected by dsq lock */
+	u64			dsq_seq;
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	s32			sticky_cpu;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 13ba4d3d39bd..fb4849fb7afd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1088,6 +1088,78 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
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
+	struct scx_dsq_node *dsq_node;
+
+	lockdep_assert_held(&dsq->lock);
+
+	if (cur)
+		list_node = &cur->scx.dsq_node.list;
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
+		dsq_node = container_of(list_node, struct scx_dsq_node, list);
+	} while (dsq_node->flags & SCX_TASK_DSQ_CURSOR);
+
+	return container_of(dsq_node, struct task_struct, scx.dsq_node);
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
+	SCX_DSQ_ITER_REV		= 1LLU << 0,
+
+	__SCX_DSQ_ITER_ALL_FLAGS	= SCX_DSQ_ITER_REV,
+};
+
+struct bpf_iter_scx_dsq_kern {
+	/*
+	 * Must be the first field. Used to work around BPF restriction and pass
+	 * in the iterator pointer to scx_bpf_consume_task().
+	 */
+	struct bpf_iter_scx_dsq_kern	*self;
+
+	struct scx_dsq_node		cursor;
+	struct scx_dispatch_q		*dsq;
+	u64				dsq_seq;
+	u64				flags;
+} __attribute__((aligned(8)));
+
+struct bpf_iter_scx_dsq {
+	u64				__opaque[12];
+} __attribute__((aligned(8)));
+
 
 /*
  * SCX task iterator.
@@ -1429,7 +1501,7 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		 * tested easily when adding the first task.
 		 */
 		if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
-			     !list_empty(&dsq->list)))
+			     nldsq_next_task(dsq, NULL, false)))
 			scx_ops_error("DSQ ID 0x%016llx already had FIFO-enqueued tasks",
 				      dsq->id);
 
@@ -1461,8 +1533,12 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			list_add_tail(&p->scx.dsq_node.list, &dsq->list);
 	}
 
+	/* seq records the order tasks are queued, used by BPF DSQ iterator */
+	dsq->seq++;
+	p->scx.dsq_seq = dsq->seq;
+
 	dsq_mod_nr(dsq, 1);
-	p->scx.dsq = dsq;
+	WRITE_ONCE(p->scx.dsq, dsq);
 
 	/*
 	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
@@ -1555,7 +1631,7 @@ static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
 		WARN_ON_ONCE(task_linked_on_dsq(p));
 		p->scx.holding_cpu = -1;
 	}
-	p->scx.dsq = NULL;
+	WRITE_ONCE(p->scx.dsq, NULL);
 
 	if (!is_local)
 		raw_spin_unlock(&dsq->lock);
@@ -2059,7 +2135,7 @@ static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
 	list_add_tail(&p->scx.dsq_node.list, &scx_rq->local_dsq.list);
 	dsq_mod_nr(dsq, -1);
 	dsq_mod_nr(&scx_rq->local_dsq, 1);
-	p->scx.dsq = &scx_rq->local_dsq;
+	WRITE_ONCE(p->scx.dsq, &scx_rq->local_dsq);
 	raw_spin_unlock(&dsq->lock);
 }
 
@@ -2131,7 +2207,7 @@ static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 
 	raw_spin_lock(&dsq->lock);
 
-	list_for_each_entry(p, &dsq->list, scx.dsq_node.list) {
+	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
@@ -5693,12 +5769,88 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
 	}
 }
 
+/**
+ * __scx_bpf_consume_task - Transfer a task from DSQ iteration to the local DSQ
+ * @it: DSQ iterator in progress
+ * @p: task to consume
+ *
+ * Transfer @p which is on the DSQ currently iterated by @it to the current
+ * CPU's local DSQ. For the transfer to be successful, @p must still be on the
+ * DSQ and have been queued before the DSQ iteration started. This function
+ * doesn't care whether @p was obtained from the DSQ iteration. @p just has to
+ * be on the DSQ and have been queued before the iteration started.
+ *
+ * Returns %true if @p has been consumed, %false if @p had already been consumed
+ * or dequeued.
+ */
+__bpf_kfunc bool __scx_bpf_consume_task(unsigned long it, struct task_struct *p)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+	struct scx_dispatch_q *dsq, *kit_dsq;
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
+	struct rq *task_rq;
+	u64 kit_dsq_seq;
+
+	/* can't trust @kit, carefully fetch the values we need */
+	if (get_kernel_nofault(kit_dsq, &kit->dsq) ||
+	    get_kernel_nofault(kit_dsq_seq, &kit->dsq_seq)) {
+		scx_ops_error("invalid @it 0x%lx", it);
+		return false;
+	}
+
+	/*
+	 * @kit can't be trusted and we can only get the DSQ from @p. As we
+	 * don't know @p's rq is locked, use READ_ONCE() to access the field.
+	 * Derefing is safe as DSQs are RCU protected.
+	 */
+	dsq = READ_ONCE(p->scx.dsq);
+
+	if (unlikely(dsq->id == SCX_DSQ_LOCAL)) {
+		scx_ops_error("local DSQ not allowed");
+		return false;
+	}
+
+	if (unlikely(!dsq || dsq != kit_dsq))
+		return false;
+
+	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+		return false;
+
+	flush_dispatch_buf(dspc->rq, dspc->rf);
+
+	raw_spin_lock(&dsq->lock);
+
+	/*
+	 * Did someone else get to it? @p could have already left $dsq, got
+	 * re-enqueud, or be in the process of being consumed by someone else.
+	 */
+	if (unlikely(p->scx.dsq != dsq ||
+		     time_after64(p->scx.dsq_seq, kit_dsq_seq) ||
+		     p->scx.holding_cpu >= 0))
+		goto out_unlock;
+
+	task_rq = task_rq(p);
+
+	if (dspc->rq == task_rq) {
+		consume_local_task(dspc->rq, dsq, p);
+		return true;
+	}
+
+	if (task_can_run_on_remote_rq(p, dspc->rq))
+		return consume_remote_task(dspc->rq, dspc->rf, dsq, p, task_rq);
+
+out_unlock:
+	raw_spin_unlock(&dsq->lock);
+	return false;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_consume)
+BTF_ID_FLAGS(func, __scx_bpf_consume_task)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
@@ -5877,6 +6029,112 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64 dsq_id)
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
+	INIT_LIST_HEAD(&kit->cursor.list);
+	RB_CLEAR_NODE(&kit->cursor.priq);
+	kit->cursor.flags = SCX_TASK_DSQ_CURSOR;
+	kit->self = kit;
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
+	if (list_empty(&kit->cursor.list))
+		p = NULL;
+	else
+		p = container_of(&kit->cursor, struct task_struct, scx.dsq_node);
+
+	/*
+	 * Only tasks which were queued before the iteration started are
+	 * visible. This bounds BPF iterations and guarantees that vtime never
+	 * jumps in the other direction while iterating.
+	 */
+	do {
+		p = nldsq_next_task(kit->dsq, p, rev);
+	} while (p && unlikely(time_after64(p->scx.dsq_seq, kit->dsq_seq)));
+
+	if (p) {
+		if (rev)
+			list_move_tail(&kit->cursor.list, &p->scx.dsq_node.list);
+		else
+			list_move(&kit->cursor.list, &p->scx.dsq_node.list);
+	} else {
+		list_del_init(&kit->cursor.list);
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
+	if (!list_empty(&kit->cursor.list)) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&kit->dsq->lock, flags);
+		list_del_init(&kit->cursor.list);
+		raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
+	}
+	kit->dsq = NULL;
+}
+
 __bpf_kfunc_end_defs();
 
 struct scx_bpf_error_bstr_bufs {
@@ -6211,6 +6469,9 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 0b26046339ee..17c76919e450 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -35,10 +35,14 @@ void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vt
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
+bool __scx_bpf_consume_task(unsigned long it, struct task_struct *p) __ksym __weak;
 u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, bool rev) __ksym __weak;
+struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
+void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
@@ -55,6 +59,21 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym;
 
+/*
+ * Use the following as @it when calling scx_bpf_consume_task() from whitin
+ * bpf_for_each() loops.
+ */
+#define BPF_FOR_EACH_ITER	(&___it)
+
+/* hopefully temporary wrapper to work around BPF restriction */
+static inline bool scx_bpf_consume_task(struct bpf_iter_scx_dsq *it,
+					struct task_struct *p)
+{
+	unsigned long ptr;
+	bpf_probe_read_kernel(&ptr, sizeof(ptr), it);
+	return __scx_bpf_consume_task(ptr, p);
+}
+
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_exit_format_checker(const char *fmt, ...) {}
 
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 0729aa9bb03e..c17ef3757b31 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -56,6 +56,21 @@ static inline void __COMPAT_scx_bpf_switch_all(void)
 #define __COMPAT_HAS_CPUMASKS							\
 	bpf_ksym_exists(scx_bpf_nr_cpu_ids)
 
+/*
+ * Iteration and scx_bpf_consume_task() are new. The following become noop on
+ * older kernels. The users can switch to bpf_for_each(scx_dsq) and directly
+ * call scx_bpf_consume_task() in the future.
+ */
+#define __COMPAT_DSQ_FOR_EACH(p, dsq_id, flags)					\
+	if (bpf_ksym_exists(bpf_iter_scx_dsq_new))				\
+		bpf_for_each(scx_dsq, (p), (dsq_id), (flags))
+
+static inline bool __COMPAT_scx_bpf_consume_task(struct bpf_iter_scx_dsq *it,
+						 struct task_struct *p)
+{
+	return false;
+}
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 7155b69150ff..7783c82a8a18 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -123,6 +123,12 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define __COMPAT_HAS_CPUMASKS							\
 	__COMPAT_has_ksym("scx_bpf_nr_cpu_ids")
 
+/*
+ * DSQ iterator is new. Users will be able to assume existence in the future.
+ */
+#define __COMPAT_HAS_DSQ_ITER							\
+	__COMPAT_has_ksym("bpf_iter_scx_dsq_new")
+
 static inline long scx_hotplug_seq(void)
 {
 	int fd;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a442031309c0..924e7e2b8c4c 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -23,6 +23,7 @@
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
 #include <scx/common.bpf.h>
+#include <string.h>
 
 enum consts {
 	ONE_SEC_IN_NS		= 1000000000,
@@ -36,6 +37,8 @@ const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
+const volatile bool print_shared_dsq;
+const volatile char exp_prefix[17];
 const volatile s32 disallow_tgid;
 const volatile bool switch_partial;
 
@@ -106,7 +109,7 @@ struct {
 
 /* Statistics */
 u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
-u64 nr_core_sched_execed;
+u64 nr_core_sched_execed, nr_expedited;
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -243,6 +246,37 @@ static void update_core_sched_head_seq(struct task_struct *p)
 		scx_bpf_error("task_ctx lookup failed");
 }
 
+static bool consume_shared_dsq(void)
+{
+	struct task_struct *p;
+	bool consumed;
+
+	if (exp_prefix[0] == '\0')
+		return scx_bpf_consume(SHARED_DSQ);
+
+	/*
+	 * To demonstrate the use of scx_bpf_consume_task(), implement silly
+	 * selective priority boosting mechanism by scanning SHARED_DSQ looking
+	 * for matching comms and consume them first. This makes difference only
+	 * when dsp_batch is larger than 1.
+	 */
+	consumed = false;
+	__COMPAT_DSQ_FOR_EACH(p, SHARED_DSQ, 0) {
+		char comm[sizeof(exp_prefix)];
+
+		memcpy(comm, p->comm, sizeof(exp_prefix) - 1);
+
+		if (!bpf_strncmp(comm, sizeof(exp_prefix),
+				 (const char *)exp_prefix) &&
+		    __COMPAT_scx_bpf_consume_task(BPF_FOR_EACH_ITER, p)) {
+			consumed = true;
+			__sync_fetch_and_add(&nr_expedited, 1);
+		}
+	}
+
+	return consumed || scx_bpf_consume(SHARED_DSQ);
+}
+
 void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 {
 	struct task_struct *p;
@@ -251,7 +285,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	void *fifo;
 	s32 i, pid;
 
-	if (scx_bpf_consume(SHARED_DSQ))
+	if (consume_shared_dsq())
 		return;
 
 	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
@@ -302,7 +336,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			batch--;
 			cpuc->dsp_cnt--;
 			if (!batch || !scx_bpf_dispatch_nr_slots()) {
-				scx_bpf_consume(SHARED_DSQ);
+				consume_shared_dsq();
 				return;
 			}
 			if (!cpuc->dsp_cnt)
@@ -445,14 +479,70 @@ void BPF_STRUCT_OPS(qmap_cpu_offline, s32 cpu)
 	print_cpus();
 }
 
+struct monitor_timer {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct monitor_timer);
+} central_timer SEC(".maps");
+
+/*
+ * Dump the currently queued tasks in the shared DSQ to demonstrate the usage of
+ * scx_bpf_dsq_nr_queued() and DSQ iterator. Raise the dispatch batch count to
+ * see meaningful dumps in the trace pipe.
+ */
+static void dump_shared_dsq(void)
+{
+	struct task_struct *p;
+	s32 nr;
+
+	if (!(nr = scx_bpf_dsq_nr_queued(SHARED_DSQ)))
+		return;
+
+	bpf_printk("Dumping %d tasks in SHARED_DSQ in reverse order", nr);
+
+	bpf_rcu_read_lock();
+	__COMPAT_DSQ_FOR_EACH(p, SHARED_DSQ, SCX_DSQ_ITER_REV)
+		bpf_printk("%s[%d]", p->comm, p->pid);
+	bpf_rcu_read_unlock();
+}
+
+static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	if (print_shared_dsq)
+		dump_shared_dsq();
+
+	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
+	return 0;
+}
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
+	u32 key = 0;
+	struct bpf_timer *timer;
+	s32 ret;
+
 	if (!switch_partial)
 		__COMPAT_scx_bpf_switch_all();
 
 	print_cpus();
 
-	return scx_bpf_create_dsq(SHARED_DSQ, -1);
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	timer = bpf_map_lookup_elem(&central_timer, &key);
+	if (!timer)
+		return -ESRCH;
+
+	bpf_timer_init(timer, &central_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, monitor_timerfn);
+
+	return bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
 }
 
 void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index a106ba099e5e..1b8cd2993ee2 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-E PREFIX] [-d PID] [-D LEN] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -28,6 +28,9 @@ const char help_fmt[] =
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
+"  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
+"  -E PREFIX     Expedite consumption of threads w/ matching comm, use with -b\n"
+"                (e.g. match shell on a loaded system)\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
@@ -61,7 +64,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:d:D:pvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PE:d:D:pvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -81,6 +84,13 @@ int main(int argc, char **argv)
 		case 'b':
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
+		case 'P':
+			skel->rodata->print_shared_dsq = true;
+			break;
+		case 'E':
+			strncpy(skel->rodata->exp_prefix, optarg,
+				sizeof(skel->rodata->exp_prefix) - 1);
+			break;
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)
@@ -102,6 +112,10 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (!__COMPAT_HAS_DSQ_ITER &&
+	    (skel->rodata->print_shared_dsq || strlen(skel->rodata->exp_prefix)))
+		fprintf(stderr, "kernel doesn't support DSQ iteration\n");
+
 	SCX_OPS_LOAD(skel, qmap_ops, scx_qmap, uei);
 	link = SCX_OPS_ATTACH(skel, qmap_ops);
 
@@ -109,10 +123,10 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64"\n",
+		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64" exp=%"PRIu64"\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
 		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
-		       skel->bss->nr_core_sched_execed);
+		       skel->bss->nr_core_sched_execed, skel->bss->nr_expedited);
 		fflush(stdout);
 		sleep(1);
 	}
-- 
2.44.0


