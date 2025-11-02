Return-Path: <bpf+bounces-73281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A30C29781
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD71D4EAC1D
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434025A2CF;
	Sun,  2 Nov 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y59alB+C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77484253B5C;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119879; cv=none; b=F++xHgP+ZVncwpbjvHtMX/Z64jElmquaJgyiwtgBJqtqBQtdfCJts5P+Cx6XfkL7k2O5ST81QU/M7IwIhH319BYbCfTC6g47HgSLXXuO/Exeb25nz0ZAfAqhy6TSRlcz9P54Z2V53pvOvhmtKQDWooqMicoQPr1xDkR1gd0NHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119879; c=relaxed/simple;
	bh=nCGLsD7q2HOJPiSlnIStGPVemKa7l7hTEsNDv1pJevc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6/KDLwGk6BAQjtvK73Kif/PNT6LHsXEzbVq/Nuv9YqhFZXabT5oaUbgpRhD1YqMNYTj+cXgdXUqMwZBRmMm9H1QfPa2ikH/stnO2/mbhTjW/9ojckU79GzqNmc4Muplr7b0n0S8RqHSqi2+6Tf57mGVIu533EkEt4mgjJpM/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y59alB+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050D9C19421;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119879;
	bh=nCGLsD7q2HOJPiSlnIStGPVemKa7l7hTEsNDv1pJevc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y59alB+CHMcEw0H2sjInl49oEyk3z0Ql/twC/hBSNaLA4pedhttOz/dPuiwUAkXpg
	 C3OnLaa9OZA+B9CjBl7H5M4FN7CHJFEY+OZN6QULo4MH5yXBJluZoNz6DMuvRkH3RB
	 2PUV5OW/MTnXEEXrIKNjGwEI3zY1CdLzmtJblSeKsw4bGs2q240URRZO7uHI6UPYsj
	 T/DUuPWVYGE8mH+rISnFt65i78JSbUq21or5iP3cGexS4AqXlBeNqHGdxLUbjAoC+t
	 LwL7Ib/gZlVij6UYfulGK0BTY6+bVC4X58oqiQ7zb5U+Tfx21QDd8pKBNgGLQALKnS
	 xfxW94zd4fvnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7BD65CE0F65; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
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
Subject: [PATCH 02/19] srcu: Create an srcu_expedite_current() function
Date: Sun,  2 Nov 2025 13:44:19 -0800
Message-Id: <20251102214436.3905633-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
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
index 51ce25f07930..3bfbd44cb1b3 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -103,6 +103,7 @@ static inline void srcu_barrier(struct srcu_struct *ssp)
 	synchronize_srcu(ssp);
 }
 
+static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
 #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
 #define srcu_check_read_flavor_force(ssp, read_flavor) do { } while (0)
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 42098e0fa0b7..93ad18acd6d0 100644
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
index 1ff94b76d91f..38b440b0b0c8 100644
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


