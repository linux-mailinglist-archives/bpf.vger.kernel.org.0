Return-Path: <bpf+bounces-33974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCAB928F6B
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 00:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8167B1F24DA7
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF82146A73;
	Fri,  5 Jul 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNTlWAw2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188372AD39;
	Fri,  5 Jul 2024 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720219799; cv=none; b=SmsAKuJHjbsOQtfq0w+Gnz0SYEKadxFstm9FwurF5UmONzyj94Nb2lu5q/BPn26YlLTC8ug3mN7/0MVk5FkhVw2DCOtNtrxtCyvcst5SLvKHWOrxAuqQzs4BU/BliDZ1SYxB5dFm0o5ItGO1m4BvL2cxupbpjpH37/43wQIm8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720219799; c=relaxed/simple;
	bh=Lyw6cxE1x3aUiLd6sJIV/kCTV3lqLRy8hkPd2040/es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBvxtAibov6Rxf7M+lh7EIl1dhrTe81eSt6+8VJeic9pgoB+ik7Kpjlu/DX6BpLWLuHkWIxS3Hn5yslxT/SS9ebSWi5HVIvuHDiP9Fa3bsED4t7WbC5sadGHpBF6H6nkwxWe9XGhrbVbjLzn7Enrmi2w8peB3nEp7AD/oP0/XGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNTlWAw2; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e397c51b2so801125fac.3;
        Fri, 05 Jul 2024 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720219796; x=1720824596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZvvLgBS6bDUd1BF7bdmLHmHQbQkQFs7zJpwYTA0a/8=;
        b=fNTlWAw22/noz+ROMpC/Gy0z5abER6fr73vfbmNYk6rZYd1zCpmlYfM75EAkjzM/Q6
         O21l8S09BEyAkFcvNjhUXF2YAm1/c7OBzQhOGGqQyfk0Os1gD70ogHN/XDvjv03OHG+5
         FJUoHe8LyQSgzCMTdl+Gi4QfjiuOmaaMX20nma3wLeuBL4TPS9gTQp4VRfI96ZSGgmAh
         /sb8ZT19Jb0aF2dGZyfzhMRDn5J5d7N+IOG9Abs3UezLBcBz0PM1y33sZ4pEvv9e9fAZ
         G1BSB5N3a8MR+kU4+uRdNcB1Qt2gPWWQoh9y1tEEALGNVkjjS1KusuDz5bl+8GjfhkAP
         y/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720219796; x=1720824596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZvvLgBS6bDUd1BF7bdmLHmHQbQkQFs7zJpwYTA0a/8=;
        b=JnHwlWYGeBnqlSI1teAv/lUyVgrm44+gEqohU/RxiH0wbAfAMFWPFPiKeyg50tSqN2
         /dAuBP7TdxpZ9egC9kT80F5NKZgzgHyk3pCle6dv630WvafViuMSZUFlvXbYBGw43iz2
         6fPgrrHPrR10tsXp79jQMm40a3I/Yp4EQzGUiQg+XHBxDt/BORb8su/xP+PHrO2j2Dtu
         xXCVcqQ9MG1zgwCRFN2e0DJRfUDjFohJmJSolUUEYxd9TtH3YuDFfOc+6w4G5G5FX0sb
         A3wNgkgAJSxXAa8460uTIPnRV8EpnPe/pujW5lHlalYGOIL2LbqZfw49PM+1LYjbV5Lj
         35+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIv/8i40ruUX8/tQcjt8J3FBWt72EXJ9t5pYiJdXGjH/Ehw8vfWLkp3nPxVHZOUO4kN+LdrY8jHzN+XYP44BMHetLJ
X-Gm-Message-State: AOJu0YxaOzkepF8DFJyeVNGP6oEM8lWFdWyz/vGoG3uGJNKhalLEYmbB
	BPS7vNBlsxbhmvxOrfImnm69rkbeCkruLuZI1YnCKD3V16bwFZuCmbcwDg==
X-Google-Smtp-Source: AGHT+IHNSXtyJQSzTNTgoLNCdtOEKrFf3zKZZwNajpnlJTkD4FHpfAYdK8P0V3nMQOQZykIXxUWSuA==
X-Received: by 2002:a05:6870:c094:b0:25e:4de:8026 with SMTP id 586e51a60fabf-25e2bf90ddemr5259730fac.51.1720219795853;
        Fri, 05 Jul 2024 15:49:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708043b70a6sm14497013b3a.150.2024.07.05.15.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:49:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 5 Jul 2024 12:49:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	David Vernet <void@manifault.com>, kernel-team@meta.com
Subject: [PATCH v4 sched_ext/for-6.11 2/2] sched_ext: Implement DSQ iterator
Message-ID: <Zoh4kp7-jAFZXhe6@slm.duckdns.org>
References: <Zn9oEjsm_1aWb35J@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn9oEjsm_1aWb35J@slm.duckdns.org>

DSQs are very opaque in the consumption path. The BPF scheduler has no way
of knowing which tasks are being considered and which is picked. This patch
adds BPF DSQ iterator.

- Allows iterating tasks queued on a DSQ in the dispatch order or reverse
  from anywhere using bpf_for_each(scx_dsq) or calling the iterator kfuncs
  directly.

- Has ordering guarantee where only tasks which were already queued when the
  iteration started are visible and consumable during the iteration.

scx_qmap is updated to implement periodic dumping of the shared DSQ.

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
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
---
 include/linux/sched/ext.h                |    3 
 kernel/sched/ext.c                       |  187 ++++++++++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |    3 
 tools/sched_ext/scx_qmap.bpf.c           |   25 ++++
 tools/sched_ext/scx_qmap.c               |    8 -
 5 files changed, 222 insertions(+), 4 deletions(-)

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
@@ -1066,6 +1071,73 @@ static __always_inline bool scx_kf_allow
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
@@ -1415,7 +1487,7 @@ static void dispatch_enqueue(struct scx_
 		 * tested easily when adding the first task.
 		 */
 		if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
-			     !list_empty(&dsq->list)))
+			     nldsq_next_task(dsq, NULL, false)))
 			scx_ops_error("DSQ ID 0x%016llx already had FIFO-enqueued tasks",
 				      dsq->id);
 
@@ -1447,6 +1519,10 @@ static void dispatch_enqueue(struct scx_
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
 	}
 
+	/* seq records the order tasks are queued, used by BPF DSQ iterator */
+	dsq->seq++;
+	p->scx.dsq_seq = dsq->seq;
+
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
@@ -2109,7 +2185,7 @@ retry:
 
 	raw_spin_lock(&dsq->lock);
 
-	list_for_each_entry(p, &dsq->list, scx.dsq_list.node) {
+	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
@@ -5697,6 +5773,110 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64
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
@@ -6118,6 +6298,9 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -39,6 +39,9 @@ u32 scx_bpf_reenqueue_local(void) __ksym
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
+struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
+void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
 void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -36,6 +36,7 @@ const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_inf_loop_after;
 const volatile u32 dsp_batch;
+const volatile bool print_shared_dsq;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 
@@ -604,10 +605,34 @@ out:
 	scx_bpf_put_cpumask(online);
 }
 
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
+	bpf_for_each(scx_dsq, p, SHARED_DSQ, SCX_DSQ_ITER_REV)
+		bpf_printk("%s[%d]", p->comm, p->pid);
+	bpf_rcu_read_unlock();
+}
+
 static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
 	monitor_cpuperf();
 
+	if (print_shared_dsq)
+		dump_shared_dsq();
+
 	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
 	return 0;
 }
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-d PID] [-D LEN] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -28,6 +28,7 @@ const char help_fmt[] =
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
+"  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
@@ -62,7 +63,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:d:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:Pd:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -82,6 +83,9 @@ int main(int argc, char **argv)
 		case 'b':
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
+		case 'P':
+			skel->rodata->print_shared_dsq = true;
+			break;
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)

