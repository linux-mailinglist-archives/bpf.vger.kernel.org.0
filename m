Return-Path: <bpf+bounces-34178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248692AD2C
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546C7B20A72
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C1A2BD05;
	Tue,  9 Jul 2024 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elaUVLv2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2E2746F;
	Tue,  9 Jul 2024 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485652; cv=none; b=XPfHv3leLj9dOJHn2bzfSLGtbohpFMCVA8yKPauV8jypfmRgD+DOR0jbN2gwpelJK0OeYaE2z4CIukKGW2Vdbky1+9MyO4X5vtoXkbIxcb+oIfMcqExTLMW3YKdbWA9MZ9QFASrQVbkAL5EJCm6pYYXwomMrh2t6I59szMgfkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485652; c=relaxed/simple;
	bh=DbkPVTm/7q7WixhdzEg4uJBhXyQuuR0VZJCrrmdac8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5hTuJnmX7UqsGDMHp6Yu7dIHwg57e2XDcqAiMFwSxXwi7yQzl/Xm++0zXzqEphK+urAPe4l+RBim4560GSAy7SkygMdcaKExPOYwvFMD3ZwUAAJdfI81k/jJVfLzSh73L/5R+Hpa9HWOR4QsBftMGtaX5knqGQrgqb+cuF7oB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elaUVLv2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so2839992b3a.1;
        Mon, 08 Jul 2024 17:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720485650; x=1721090450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lafGRsY1MNlSAiP6oppq1e6Zb00bt33pGTN+A1vFm50=;
        b=elaUVLv2oqFZNxwpJzO9g5Nx0QlIH9RTZRXdOSJyAuc8/9oc0KTiPg2ygTKM2cNNOG
         ATLcygaSsqFjZsWozHvqniy1HIAddTILnD8xAg5wB3xDBJdRXxcmdZsVaVUhJRUcGMKe
         6q7sYLU8xa3sTqMQg8wKz7ZpSX5ovxNpTzdcNLFc1YBAZeaSBgFdn6WUoPVSmvpPH5lv
         0CbMSX12H/A2diwQk7B2s+Z6Hm4uoMtLTWzMb7UqZU1VHOO6c+IhgaAD7NgD7N3fSAMA
         LuMP4MWW6mFwald1xZPMsc77pBqzFVxRoXhmfpok5fo57VNc4DLQOVGKf4HIs6yO/EU7
         RuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720485650; x=1721090450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lafGRsY1MNlSAiP6oppq1e6Zb00bt33pGTN+A1vFm50=;
        b=gn2lWP878iB8TQRv7CI6c23oATJ6up5+2aMlL7lbzLBH0gDJ+myo7l8kI2h36UJhB1
         /6CpchYHKcGupBkSozAnAcu99kKWYcVoCWt3mj5ZvCrbXqKxVDWRqD9lnBeoOko7i+we
         UarTp4+7AEp5guqmn7DFaRQoiMBX5XddBW5ucMFN8YsSHyOjzmSG4nYVvDas26IRdq0H
         omgRgkxzR7DsV44+gURBl6BVE0Upw4WPNWnD2qzvI/x+w/LSbceQLcY50V4lWyhhZq0V
         ARDwF/INdcWsXM9ZvvgyArEVlt/S9DpQTrG2jxMLNTzkbm3886x8mzpc9M3Ab7X4esHK
         Y9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9YZ2peFikQ5V1NCwkeJODqNceUJzFJKKgVftJkyhS2JPIOBpnp1vAJj5iYb5ozO4W+1KyBzCrYLsqRGelB2ivo3gX
X-Gm-Message-State: AOJu0Yx7JpVRZ1PqwSBSm/fcjrMzc1wa/A4u0X5jdUxGeyt0hhFzlvAu
	4r0+C5gaGWSnARTo/vPVSwpE7wV26TsR0vFvlbK+Md3/vVWNq0od
X-Google-Smtp-Source: AGHT+IEY0piqOUBgLnkF2xw5/Sp8FZYZQLCHAiwOydmqSt/i+jQzI/iih9pf5iDg7rC4WQrvzLvxOQ==
X-Received: by 2002:a05:6a00:2190:b0:706:938a:5d49 with SMTP id d2e1a72fcca58-70b44e02bbamr1199510b3a.14.1720485649785;
        Mon, 08 Jul 2024 17:40:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438e53a7sm498882b3a.88.2024.07.08.17.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:40:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org,
	andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	void@manifault.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Take out ->priq and ->flags from scx_dsq_node
Date: Mon,  8 Jul 2024 14:40:22 -1000
Message-ID: <20240709004041.1111039-2-tj@kernel.org>
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

struct scx_dsq_node contains two data structure nodes to link the containing
task to a DSQ and a flags field that is protected by the lock of the
associated DSQ. One reason why they are grouped into a struct is to use the
type independently as a cursor node when iterating tasks on a DSQ. However,
when iterating, the cursor only needs to be linked on the FIFO list and the
rb_node part ends up inflating the size of the iterator data structure
unnecessarily making it potentially too expensive to place it on stack.

Take ->priq and ->flags out of scx_dsq_node and put them in sched_ext_entity
as ->dsq_priq and ->dsq_flags, respectively. scx_dsq_node is renamed to
scx_dsq_list_node and the field names are renamed accordingly. This will
help implementing DSQ task iterator that can be allocated on stack.

No functional change intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: David Vernet <void@manifault.com>
---
 include/linux/sched/ext.h | 10 ++++----
 init/init_task.c          |  2 +-
 kernel/sched/ext.c        | 54 +++++++++++++++++++--------------------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index fe9a67ffe6b1..eb9cfd18a923 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -121,10 +121,8 @@ enum scx_kf_mask {
 	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
 };
 
-struct scx_dsq_node {
-	struct list_head	list;		/* dispatch order */
-	struct rb_node		priq;		/* p->scx.dsq_vtime order */
-	u32			flags;		/* SCX_TASK_DSQ_* flags */
+struct scx_dsq_list_node {
+	struct list_head	node;
 };
 
 /*
@@ -133,7 +131,9 @@ struct scx_dsq_node {
  */
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
-	struct scx_dsq_node	dsq_node;	/* protected by dsq lock */
+	struct scx_dsq_list_node dsq_list;	/* dispatch order */
+	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
+	u32			dsq_flags;	/* protected by DSQ lock */
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	s32			sticky_cpu;
diff --git a/init/init_task.c b/init/init_task.c
index 5726b3a0eea9..e222722e790b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -102,7 +102,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #endif
 #ifdef CONFIG_SCHED_CLASS_EXT
 	.scx		= {
-		.dsq_node.list	= LIST_HEAD_INIT(init_task.scx.dsq_node.list),
+		.dsq_list.node	= LIST_HEAD_INIT(init_task.scx.dsq_list.node),
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
 		.runnable_node	= LIST_HEAD_INIT(init_task.scx.runnable_node),
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b7fad9bf27ae..069c2f33883c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1360,9 +1360,9 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
 			      const struct rb_node *node_b)
 {
 	const struct task_struct *a =
-		container_of(node_a, struct task_struct, scx.dsq_node.priq);
+		container_of(node_a, struct task_struct, scx.dsq_priq);
 	const struct task_struct *b =
-		container_of(node_b, struct task_struct, scx.dsq_node.priq);
+		container_of(node_b, struct task_struct, scx.dsq_priq);
 
 	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
 }
@@ -1378,9 +1378,9 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
 
-	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node.list));
-	WARN_ON_ONCE((p->scx.dsq_node.flags & SCX_TASK_DSQ_ON_PRIQ) ||
-		     !RB_EMPTY_NODE(&p->scx.dsq_node.priq));
+	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
+	WARN_ON_ONCE((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
+		     !RB_EMPTY_NODE(&p->scx.dsq_priq));
 
 	if (!is_local) {
 		raw_spin_lock(&dsq->lock);
@@ -1419,21 +1419,21 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			scx_ops_error("DSQ ID 0x%016llx already had FIFO-enqueued tasks",
 				      dsq->id);
 
-		p->scx.dsq_node.flags |= SCX_TASK_DSQ_ON_PRIQ;
-		rb_add(&p->scx.dsq_node.priq, &dsq->priq, scx_dsq_priq_less);
+		p->scx.dsq_flags |= SCX_TASK_DSQ_ON_PRIQ;
+		rb_add(&p->scx.dsq_priq, &dsq->priq, scx_dsq_priq_less);
 
 		/*
 		 * Find the previous task and insert after it on the list so
 		 * that @dsq->list is vtime ordered.
 		 */
-		rbp = rb_prev(&p->scx.dsq_node.priq);
+		rbp = rb_prev(&p->scx.dsq_priq);
 		if (rbp) {
 			struct task_struct *prev =
 				container_of(rbp, struct task_struct,
-					     scx.dsq_node.priq);
-			list_add(&p->scx.dsq_node.list, &prev->scx.dsq_node.list);
+					     scx.dsq_priq);
+			list_add(&p->scx.dsq_list.node, &prev->scx.dsq_list.node);
 		} else {
-			list_add(&p->scx.dsq_node.list, &dsq->list);
+			list_add(&p->scx.dsq_list.node, &dsq->list);
 		}
 	} else {
 		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
@@ -1442,9 +1442,9 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 				      dsq->id);
 
 		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
-			list_add(&p->scx.dsq_node.list, &dsq->list);
+			list_add(&p->scx.dsq_list.node, &dsq->list);
 		else
-			list_add_tail(&p->scx.dsq_node.list, &dsq->list);
+			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
 	}
 
 	dsq_mod_nr(dsq, 1);
@@ -1487,18 +1487,18 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 static void task_unlink_from_dsq(struct task_struct *p,
 				 struct scx_dispatch_q *dsq)
 {
-	if (p->scx.dsq_node.flags & SCX_TASK_DSQ_ON_PRIQ) {
-		rb_erase(&p->scx.dsq_node.priq, &dsq->priq);
-		RB_CLEAR_NODE(&p->scx.dsq_node.priq);
-		p->scx.dsq_node.flags &= ~SCX_TASK_DSQ_ON_PRIQ;
+	if (p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) {
+		rb_erase(&p->scx.dsq_priq, &dsq->priq);
+		RB_CLEAR_NODE(&p->scx.dsq_priq);
+		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
 	}
 
-	list_del_init(&p->scx.dsq_node.list);
+	list_del_init(&p->scx.dsq_list.node);
 }
 
 static bool task_linked_on_dsq(struct task_struct *p)
 {
-	return !list_empty(&p->scx.dsq_node.list);
+	return !list_empty(&p->scx.dsq_list.node);
 }
 
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
@@ -1523,8 +1523,8 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		raw_spin_lock(&dsq->lock);
 
 	/*
-	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_node
-	 * can't change underneath us.
+	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_* can't
+	 * change underneath us.
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
@@ -2034,7 +2034,7 @@ static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
 	/* @dsq is locked and @p is on this rq */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	task_unlink_from_dsq(p, dsq);
-	list_add_tail(&p->scx.dsq_node.list, &rq->scx.local_dsq.list);
+	list_add_tail(&p->scx.dsq_list.node, &rq->scx.local_dsq.list);
 	dsq_mod_nr(dsq, -1);
 	dsq_mod_nr(&rq->scx.local_dsq, 1);
 	p->scx.dsq = &rq->scx.local_dsq;
@@ -2109,7 +2109,7 @@ static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 
 	raw_spin_lock(&dsq->lock);
 
-	list_for_each_entry(p, &dsq->list, scx.dsq_node.list) {
+	list_for_each_entry(p, &dsq->list, scx.dsq_list.node) {
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
@@ -2628,7 +2628,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 static struct task_struct *first_local_task(struct rq *rq)
 {
 	return list_first_entry_or_null(&rq->scx.local_dsq.list,
-					struct task_struct, scx.dsq_node.list);
+					struct task_struct, scx.dsq_list.node);
 }
 
 static struct task_struct *pick_next_task_scx(struct rq *rq)
@@ -3309,8 +3309,8 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	 */
 	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
 
-	INIT_LIST_HEAD(&scx->dsq_node.list);
-	RB_CLEAR_NODE(&scx->dsq_node.priq);
+	INIT_LIST_HEAD(&scx->dsq_list.node);
+	RB_CLEAR_NODE(&scx->dsq_priq);
 	scx->sticky_cpu = -1;
 	scx->holding_cpu = -1;
 	INIT_LIST_HEAD(&scx->runnable_node);
@@ -4160,7 +4160,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
 	dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
 		  scx_get_task_state(p), p->scx.flags & ~SCX_TASK_STATE_MASK,
-		  p->scx.dsq_node.flags, ops_state & SCX_OPSS_STATE_MASK,
+		  p->scx.dsq_flags, ops_state & SCX_OPSS_STATE_MASK,
 		  ops_state >> SCX_OPSS_QSEQ_SHIFT);
 	dump_line(s, "      sticky/holding_cpu=%d/%d dsq_id=%s dsq_vtime=%llu",
 		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf,
-- 
2.45.2


