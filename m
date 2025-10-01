Return-Path: <bpf+bounces-70096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86051BB0D25
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8422B7B272E
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8502230497C;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrC+zIU2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58BF303A24;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330119; cv=none; b=MYFJca6n4XXdDRclYler1zcxuMf2lZl2AogGPFS9qJ4+xnKZZTqxNfhFsAQBbPigLN4h8Wr/+XIdpIyy2sRAIUJDna4mRAxr6M+53CtkjR6jbzuEq/5735sEeyxEw92E8uURAyqP2DtBS+8bVd8NSgVpGgviIOgc/QHlAtJz39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330119; c=relaxed/simple;
	bh=iKeiZMJ0ulhBekBtlRCePhWmJOVL8l8/TB0NfJOhkCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RH23mOK0qQBLWm+zT/3Qs9J/RQgY/JU3yeTKj/VF6JlgoLAiuFs+F4XDH5pPMd046nzAVF7uvzyIAGrFJuNWrHzmibWLD8ev18gPy72tBcFy80kuGt4xPACuk29exq6G4IzDXqyJnxCvxQg3O8d6/nfZwCmBFjPdnevuz6kRp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrC+zIU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE56C4CEFA;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330119;
	bh=iKeiZMJ0ulhBekBtlRCePhWmJOVL8l8/TB0NfJOhkCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrC+zIU2Xv1YYDU5cBFWUDH8QhtVwbSpaiuWqdIQb/UY9gDUKVRANLQh+RS9W/W+I
	 LJj4gYRh/0C4K47ggkRe3/lmL9wzmvZbz5JiM1hMOoIsgOHc846r04W7oMQb3n84MS
	 aAWjhzntL/bO5QJo1mG9BwKR84pQ2KCfRL/1/h6ehmNwu6j5fpl44loIrWiKI6E1b3
	 z2nV74NMIFt4wL8ocFJa1B9eM3gtAriawI0QKE4Kb61P1OPrUILTBwzwOwlmo5pZUt
	 sudLKucfZYa5aiT2plZrEqPwANn7myo35b1Io1QEo5/CiNu0TEw4pW0BurWF28auKA
	 a1LwvYQ66tTzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6FD28CE1160; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2 06/21] srcu: Create an srcu_expedite_current() function
Date: Wed,  1 Oct 2025 07:48:17 -0700
Message-Id: <20251001144832.631770-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit creates an srcu_expedite_current() function that expedites
the current (and possibly the next) SRCU grace period for the specified
srcu_struct structure.  This functionality will be inherited by RCU
Tasks Trace courtesy of its mapping to SRCU fast.

If the current SRCU grace period is already waiting, that wait will
complete before the expediting takes effect.  If there is no SRCU grace
period in flight, this function might well create one.

[ paulmck: Apply Zqiang feedback for PREEMPT_RT use. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutiny.h |  1 +
 include/linux/srcutree.h |  8 ++++++
 kernel/rcu/srcutree.c    | 58 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 51ce25f07930ee..3bfbd44cb1b37d 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -103,6 +103,7 @@ static inline void srcu_barrier(struct srcu_struct *ssp)
 	synchronize_srcu(ssp);
 }
 
+static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
 #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
 #define srcu_check_read_flavor_force(ssp, read_flavor) do { } while (0)
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 42098e0fa0b7dd..93ad18acd6d02d 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -42,6 +42,8 @@ struct srcu_data {
 	struct timer_list delay_work;		/* Delay for CB invoking */
 	struct work_struct work;		/* Context for CB invoking. */
 	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
+	struct rcu_head srcu_ec_head;		/* For srcu_expedite_current() use. */
+	int srcu_ec_state;			/*  State for srcu_expedite_current(). */
 	struct srcu_node *mynode;		/* Leaf srcu_node. */
 	unsigned long grpmask;			/* Mask for leaf srcu_node */
 						/*  ->srcu_data_have_cbs[]. */
@@ -135,6 +137,11 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN1	1
 #define SRCU_STATE_SCAN2	2
 
+/* Values for srcu_expedite_current() state (->srcu_ec_state). */
+#define SRCU_EC_IDLE		0
+#define SRCU_EC_PENDING		1
+#define SRCU_EC_REPOST		2
+
 /*
  * Values for initializing gp sequence fields. Higher values allow wrap arounds to
  * occur earlier.
@@ -210,6 +217,7 @@ struct srcu_struct {
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
+void srcu_expedite_current(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
 // Converts a per-CPU pointer to an ->srcu_ctrs[] array element to that
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1ff94b76d91f15..38b440b0b0c80b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1688,6 +1688,64 @@ void srcu_barrier(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(srcu_barrier);
 
+/* Callback for srcu_expedite_current() usage. */
+static void srcu_expedite_current_cb(struct rcu_head *rhp)
+{
+	unsigned long flags;
+	bool needcb = false;
+	struct srcu_data *sdp = container_of(rhp, struct srcu_data, srcu_ec_head);
+
+	spin_lock_irqsave_sdp_contention(sdp, &flags);
+	if (sdp->srcu_ec_state == SRCU_EC_IDLE) {
+		WARN_ON_ONCE(1);
+	} else if (sdp->srcu_ec_state == SRCU_EC_PENDING) {
+		sdp->srcu_ec_state = SRCU_EC_IDLE;
+	} else {
+		WARN_ON_ONCE(sdp->srcu_ec_state != SRCU_EC_REPOST);
+		sdp->srcu_ec_state = SRCU_EC_PENDING;
+		needcb = true;
+	}
+	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	// If needed, requeue ourselves as an expedited SRCU callback.
+	if (needcb)
+		__call_srcu(sdp->ssp, &sdp->srcu_ec_head, srcu_expedite_current_cb, false);
+}
+
+/**
+ * srcu_expedite_current - Expedite the current SRCU grace period
+ * @ssp: srcu_struct to expedite.
+ *
+ * Cause the current SRCU grace period to become expedited.  The grace
+ * period following the current one might also be expedited.  If there is
+ * no current grace period, one might be created.  If the current grace
+ * period is currently sleeping, that sleep will complete before expediting
+ * will take effect.
+ */
+void srcu_expedite_current(struct srcu_struct *ssp)
+{
+	unsigned long flags;
+	bool needcb = false;
+	struct srcu_data *sdp;
+
+	migrate_disable();
+	sdp = this_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_sdp_contention(sdp, &flags);
+	if (sdp->srcu_ec_state == SRCU_EC_IDLE) {
+		sdp->srcu_ec_state = SRCU_EC_PENDING;
+		needcb = true;
+	} else if (sdp->srcu_ec_state == SRCU_EC_PENDING) {
+		sdp->srcu_ec_state = SRCU_EC_REPOST;
+	} else {
+		WARN_ON_ONCE(sdp->srcu_ec_state != SRCU_EC_REPOST);
+	}
+	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	// If needed, queue an expedited SRCU callback.
+	if (needcb)
+		__call_srcu(ssp, &sdp->srcu_ec_head, srcu_expedite_current_cb, false);
+	migrate_enable();
+}
+EXPORT_SYMBOL_GPL(srcu_expedite_current);
+
 /**
  * srcu_batches_completed - return batches completed.
  * @ssp: srcu_struct on which to report batch completion.
-- 
2.40.1


