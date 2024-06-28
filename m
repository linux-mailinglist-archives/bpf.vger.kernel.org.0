Return-Path: <bpf+bounces-33298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0B91B345
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 02:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4203C1F23340
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 00:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450317F6;
	Fri, 28 Jun 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp5okWa8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CFC17C2;
	Fri, 28 Jun 2024 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534015; cv=none; b=XqvVdiGzwH02LVmVoRuQTBw8jSuPsdo23PQ6542nUJ2GNrpLLcMjfMUlaNRbOHD51aWAJ3UVyinlYKSygButCwOihIBZ64nyH2SU7ELdWiLOqPmO1zuxJVwqkE+vfPfbnShxH6BimaCWM9GZvxhW0Ojfu4yLLBu4+Zrh/Ipr9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534015; c=relaxed/simple;
	bh=hPmWAhV/ALZwfkxEChzHV75XSsab9YDRMs8lb1BInpM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MHSmuDpME2dEoJnySYHKsMKN3I64SUnqb4V+WSxdkNhKXsBj+fR9SZuKqUqerOefx7+SUni/WjLMhKwzdfmJjivFihIocE675N3mZRVVRCL/Q+IdED+jjIQl5KfHO8VRHFciYsACbJE/57GKGtfKGFaw08o0ZCLetSu/HY33zXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp5okWa8; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375daa47685so432025ab.0;
        Thu, 27 Jun 2024 17:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719534012; x=1720138812; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OhR6U8HdcgsRkilpfr/+5R8pDo1Y/RagWPTFGhtn6mk=;
        b=Mp5okWa8/QEFCCJT2NNfcfdfisHB3bscKP2GfUd76Ygr7FP5TcA9nD0SCgh22oXJHE
         2nerh7ima0NBMzI//a3p6BJA3i5xSu/xcBA//1R9h5j38eG8P+x/2K75s/z4lSnXEjgj
         cslM8+Zfk4ylgeMF1aYMdmbarlBRcry7efL1O0j+d0vchWNqiQ6QNVLVpMHYExZjQg5N
         n5gF2jDfIKzlMWT/nTbRQqm5OXUu2EcZBSSJ5igvHP1dZgsJAeOz6le4zE1iTsx5vBMj
         t4iR5xPE4NahxrSUwpUko/2s/TbqG9kJhRe1/HQ+n6B/M1+nLSWth5M+MEIYLJ/s8QDm
         oWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534012; x=1720138812;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhR6U8HdcgsRkilpfr/+5R8pDo1Y/RagWPTFGhtn6mk=;
        b=av91hXUpPAL14nqzBLvDXzRzp+gq58XeOdprnSXBqhAAs8u9eh3gHxlAzW5g6u1ItH
         YofCWkYIRJuYrrc0uTpMAVoagv7rMqKGmeH4c1jQs9BKjgs6EQRGfQ9WxeVM/vXgvpct
         IDgsqMVZKMjh5jijoF4AeFUWdMz5LrqJoDQVJNW1csTmXoMYq5C57xVeyhrA1VIUgH9x
         30VYW/OfvEpaWVSEUZFSmnmXTeqr78bKbMBOKQijaLWGU0S4KvEVRntu6mP8n5xgAuKa
         Yp6entDwH/iqGMlMqaq5cKk2L3B2TDIp+lsxK0fFYT/rJ61Y2qdZiY24y1ZXIVcMooBo
         4QFg==
X-Forwarded-Encrypted: i=1; AJvYcCWfjunmIN+0MnyoWWqWtsOVnqvC49ln2D8GMI3vIyaozjQn4EcrWJzMnUGYLcLlbM5UWWJmX4Xzv+d9YdGgrnp9EROa
X-Gm-Message-State: AOJu0YxZJdH/qYCkPcc7WX/odLFdiC359/7GYBd4Qxv8R5r2oeS0uiIU
	bGRLKQc6XlGKx2pZ+mb2qpDs0gKgRMNgIMYNd5nbTq6iPot9QtLL
X-Google-Smtp-Source: AGHT+IGBT+hnZZ4CvDKXS/sFPaSLM/BLDOjCu1YHS4Wa/AD2WuNuVJ2fFamVc6Gbg/znf7/+WDwnGA==
X-Received: by 2002:a05:6e02:20c4:b0:36d:acb4:8c02 with SMTP id e9e14a558f8ab-3763f5ade61mr195944315ab.6.1719534012112;
        Thu, 27 Jun 2024 17:20:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53bb8sm276071a12.10.2024.06.27.17.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 17:20:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 14:20:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	David Vernet <void@manifault.com>
Subject: [PATCH sched_ext/for-6.11 1/2] sched_ext: Implement DSQ iterator
Message-ID: <Zn4BupVa65CVayqQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

DSQs are very opaque in the consumption path. The BPF scheduler has no way
of knowing which tasks are being considered and which is picked. This patch
adds BPF DSQ iterator.

- Allows iterating tasks queued on a DSQ in the dispatch order or reverse
  from anywhere using bpf_for_each(scx_dsq) or calling the iterator kfuncs
  directly.

- Has ordering guarantee where only tasks which were already queued when the
  iteration started are visible and consumable during the iteration.

scx_qmap is updated to implement periodic dumping of the shared DSQ.

v2: - scx_bpf_consume_task() is separated out into a separate patch.

    - DSQ seq and iter flags don't need to be u64. Use u32.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
---
Hello, Alexei.

These two patches implement inline iterator for a task queue data structure
that's used by sched_ext. The first one implements the iterator itself. It's
pretty straightforward and seems to work fine. The second one implements a
kfunc which consumes a task while iterating. This one is a bit nasty
unfortunately. I'll continue on the second patch.

Thanks.

 include/linux/sched/ext.h                |    4 
 kernel/sched/ext.c                       |  182 ++++++++++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |    3 
 tools/sched_ext/scx_qmap.bpf.c           |   25 ++++
 tools/sched_ext/scx_qmap.c               |    8 +
 5 files changed, 218 insertions(+), 4 deletions(-)

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
@@ -94,6 +95,8 @@ enum scx_task_state {
 /* scx_entity.dsq_flags */
 enum scx_ent_dsq_flags {
 	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
+
+	SCX_TASK_DSQ_CURSOR	= 1 << 31, /* iteration cursor, not a task */
 };
 
 /*
@@ -134,6 +137,7 @@ struct scx_dsq_node {
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
 	struct scx_dsq_node	dsq_node;	/* protected by dsq lock */
+	u32			dsq_seq;
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	s32			sticky_cpu;
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1066,6 +1066,72 @@ static __always_inline bool scx_kf_allow
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
+	SCX_DSQ_ITER_REV		= 1U << 0,
+
+	__SCX_DSQ_ITER_ALL_FLAGS	= SCX_DSQ_ITER_REV,
+};
+
+struct bpf_iter_scx_dsq_kern {
+	struct scx_dsq_node		cursor;
+	struct scx_dispatch_q		*dsq;
+	u32				dsq_seq;
+	u32				flags;
+} __attribute__((aligned(8)));
+
+struct bpf_iter_scx_dsq {
+	u64				__opaque[12];
+} __attribute__((aligned(8)));
+
 
 /*
  * SCX task iterator.
@@ -1415,7 +1481,7 @@ static void dispatch_enqueue(struct scx_
 		 * tested easily when adding the first task.
 		 */
 		if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
-			     !list_empty(&dsq->list)))
+			     nldsq_next_task(dsq, NULL, false)))
 			scx_ops_error("DSQ ID 0x%016llx already had FIFO-enqueued tasks",
 				      dsq->id);
 
@@ -1447,6 +1513,10 @@ static void dispatch_enqueue(struct scx_
 			list_add_tail(&p->scx.dsq_node.list, &dsq->list);
 	}
 
+	/* seq records the order tasks are queued, used by BPF DSQ iterator */
+	dsq->seq++;
+	p->scx.dsq_seq = dsq->seq;
+
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
@@ -2109,7 +2179,7 @@ retry:
 
 	raw_spin_lock(&dsq->lock);
 
-	list_for_each_entry(p, &dsq->list, scx.dsq_node.list) {
+	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
@@ -5697,6 +5767,111 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64
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
+	} while (p && unlikely((s32)(p->scx.dsq_seq - kit->dsq_seq) > 0));
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
 
 static s32 __bstr_format(u64 *data_buf, char *line_buf, size_t line_size,
@@ -6118,6 +6293,9 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
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
+int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, bool rev) __ksym __weak;
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

