Return-Path: <bpf+bounces-33403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D681D91CA15
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 03:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF201F22886
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0D46BF;
	Sat, 29 Jun 2024 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdrYmhJy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62C2F2C;
	Sat, 29 Jun 2024 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719625750; cv=none; b=HCuCEOgNSrWiniKkdBR06e6khdO+aiiNMEBtzgMLlfhlESmFvlZb8D4omRiDBenF2BjDHv/FmeFAvFxShSCldQ5PB7UMJ3E3XqIeGeQe4n+y89+N+rYZkk4Yb/Bw19CojnVyZzJUzfGYY/KxFWUZegUI68CDCIVqnv4iLK7Ir4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719625750; c=relaxed/simple;
	bh=xKD6IBum6Auj1fEhDZ1eYezrsEYFjj7S0WRjkTcWNuE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BwCKNkSb9rgGwMYR8r+FcKVX42fWS9IrPKk6Pb+EQ+yZbbGlh1Nh5U39SsPvcGl8xEmuRmBs2FB3RqlL3Bce8HcUy8MaWNArAPEA+0MCWvdRjqdHYJCBR6X6Zg/qp7TWWayRBulLkamnDRQL1A8PbEXLeiRH0XIWQKxmkS9pGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdrYmhJy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70698bcd19eso908834b3a.0;
        Fri, 28 Jun 2024 18:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719625748; x=1720230548; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8rlXgaH8KLmqo1tJ0ciF97QiwLxWcr3xFfDIUUgWK4Y=;
        b=HdrYmhJyFP7v112Uooc9+X7pp/tdjcyxORDBynD/dgDLk/MWbV7PGQWF2D5EClR6di
         Q/ebgYuVgAAIt5gMJBUnSrsO6KEmxZccpudU/bRCeq4fDJtF1ciwfIOluAdj63R/oICR
         M44aEwF2Sfaf8VGlxdhvXm/22jFscvOODf7Zu7Nad4/+Eg45IB3os4jBysGrbO/guiQl
         dq1HlxtV56aVufqspS2dJGy+hRapKU2LOYJbI889Tt7Xzk/4txzji2YLc6xnBdpjPk8A
         XnPVclE+6z3DeIzgAiyg3N4H6Q89v3he82tPLzzzztYmiLNM67m4yNrdzTblgkNfDiia
         IPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719625748; x=1720230548;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rlXgaH8KLmqo1tJ0ciF97QiwLxWcr3xFfDIUUgWK4Y=;
        b=W67+8xUvFHMaETlPT7OlRbje3MJdN1V7aGtvLTab4qTH/4+9x4BR01MAiS5zb3nBmX
         RgXEzC23UvBB8TxJ2EJwnrcDBjrEqpodlS3V082OAlVPChKJgeXm8Pq+XstfqX0SZms7
         SzNDFDEAH5PPRI2PJr75rbfgoTPiO9XPX4d3vMLlxcFSlpWjUCodZOeaKE+9Q364mB8N
         Qi1/47PspOEs19o2tWjWBBFElwDjLsA5v3h0jR0Tz5GHGc9fhRfC+q03ruk1E/HCC1fs
         ZMJUy+r0XOk9BAFK8QSW7PvQMmfDMwir+ABeC1W3U3dx1HQNIdp0I+i31kBXpe6ASc0d
         mwCA==
X-Forwarded-Encrypted: i=1; AJvYcCUE+9GN/UoRL7/5yL+hcjNimH+T3AI2Tt/KL3uq5Z0rB2dnhesrMkUxtyV/QDvrAqK6HuNbG30IXO4iPzDIJLS1bLYf
X-Gm-Message-State: AOJu0YwjkZHFmcQjuem1mzI/zjL2EemvSzLg492FiGZDM9ey1JxEDMtP
	X4dyY5pD1Bu4HOyYQmsEPHvc/OzjUUnIwkkJa0fXTJlS4i/X0HQv
X-Google-Smtp-Source: AGHT+IHjD4fQwqZ1H0rSoUgKm9TvRIAhuHgGbmVsiC/1KOprWC/aBCOGHnMW+G/uqFM7ri6XjKPnvQ==
X-Received: by 2002:a05:6a00:4649:b0:709:822f:82c2 with SMTP id d2e1a72fcca58-709823ec591mr2029983b3a.12.1719625748220;
        Fri, 28 Jun 2024 18:49:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802564b50sm2287243b3a.67.2024.06.28.18.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:49:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 28 Jun 2024 15:49:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	David Vernet <void@manifault.com>, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.11 1/2] sched_ext: Take out ->priq and
 ->flags from scx_dsq_node
Message-ID: <Zn9oEjsm_1aWb35J@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
Cc: David Vernet <void@manifault.com>
---
 include/linux/sched/ext.h |   10 ++++----
 init/init_task.c          |    2 -
 kernel/sched/ext.c        |   54 +++++++++++++++++++++++-----------------------
 3 files changed, 33 insertions(+), 33 deletions(-)

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
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -102,7 +102,7 @@ struct task_struct init_task __aligned(L
 #endif
 #ifdef CONFIG_SCHED_CLASS_EXT
 	.scx		= {
-		.dsq_node.list	= LIST_HEAD_INIT(init_task.scx.dsq_node.list),
+		.dsq_list.node	= LIST_HEAD_INIT(init_task.scx.dsq_list.node),
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
 		.runnable_node	= LIST_HEAD_INIT(init_task.scx.runnable_node),
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1360,9 +1360,9 @@ static bool scx_dsq_priq_less(struct rb_
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
@@ -1378,9 +1378,9 @@ static void dispatch_enqueue(struct scx_
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
@@ -1419,21 +1419,21 @@ static void dispatch_enqueue(struct scx_
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
@@ -1442,9 +1442,9 @@ static void dispatch_enqueue(struct scx_
 				      dsq->id);
 
 		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
-			list_add(&p->scx.dsq_node.list, &dsq->list);
+			list_add(&p->scx.dsq_list.node, &dsq->list);
 		else
-			list_add_tail(&p->scx.dsq_node.list, &dsq->list);
+			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
 	}
 
 	dsq_mod_nr(dsq, 1);
@@ -1487,18 +1487,18 @@ static void dispatch_enqueue(struct scx_
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
@@ -1523,8 +1523,8 @@ static void dispatch_dequeue(struct rq *
 		raw_spin_lock(&dsq->lock);
 
 	/*
-	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_node
-	 * can't change underneath us.
+	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_* can't
+	 * change underneath us.
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
@@ -2034,7 +2034,7 @@ static void consume_local_task(struct rq
 	/* @dsq is locked and @p is on this rq */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	task_unlink_from_dsq(p, dsq);
-	list_add_tail(&p->scx.dsq_node.list, &rq->scx.local_dsq.list);
+	list_add_tail(&p->scx.dsq_list.node, &rq->scx.local_dsq.list);
 	dsq_mod_nr(dsq, -1);
 	dsq_mod_nr(&rq->scx.local_dsq, 1);
 	p->scx.dsq = &rq->scx.local_dsq;
@@ -2109,7 +2109,7 @@ retry:
 
 	raw_spin_lock(&dsq->lock);
 
-	list_for_each_entry(p, &dsq->list, scx.dsq_node.list) {
+	list_for_each_entry(p, &dsq->list, scx.dsq_list.node) {
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
@@ -2628,7 +2628,7 @@ static void put_prev_task_scx(struct rq
 static struct task_struct *first_local_task(struct rq *rq)
 {
 	return list_first_entry_or_null(&rq->scx.local_dsq.list,
-					struct task_struct, scx.dsq_node.list);
+					struct task_struct, scx.dsq_list.node);
 }
 
 static struct task_struct *pick_next_task_scx(struct rq *rq)
@@ -3308,8 +3308,8 @@ void init_scx_entity(struct sched_ext_en
 	 */
 	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
 
-	INIT_LIST_HEAD(&scx->dsq_node.list);
-	RB_CLEAR_NODE(&scx->dsq_node.priq);
+	INIT_LIST_HEAD(&scx->dsq_list.node);
+	RB_CLEAR_NODE(&scx->dsq_priq);
 	scx->sticky_cpu = -1;
 	scx->holding_cpu = -1;
 	INIT_LIST_HEAD(&scx->runnable_node);
@@ -4158,7 +4158,7 @@ static void scx_dump_task(struct seq_buf
 		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
 	dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
 		  scx_get_task_state(p), p->scx.flags & ~SCX_TASK_STATE_MASK,
-		  p->scx.dsq_node.flags, ops_state & SCX_OPSS_STATE_MASK,
+		  p->scx.dsq_flags, ops_state & SCX_OPSS_STATE_MASK,
 		  ops_state >> SCX_OPSS_QSEQ_SHIFT);
 	dump_line(s, "      sticky/holding_cpu=%d/%d dsq_id=%s dsq_vtime=%llu",
 		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf,

