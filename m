Return-Path: <bpf+bounces-73727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36641C37C16
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04233AFAF6
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F534DB79;
	Wed,  5 Nov 2025 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQqWGwL2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4D34B661;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374741; cv=none; b=N+ivOAElpW7nOw1WyanHPx//1KMhLSa20o8wylXB+Zq2Ia+yVn/pGIfwBYzlbFTB60Am6bgiz/vhGR7mErwlK9Y1m1+XVFX9KkNpxhSnhmUBlr9/QKNk3mPDQ9arWKDw+G+RW2ynJ1cvINV0RUKi/duvQgQihpG0bCIJ9lX2y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374741; c=relaxed/simple;
	bh=SxM5obABZJXPt/ymairqXuBar3neaMVGlr0dx2kNeSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdEmfr+2r2Z9S3G+CBgNRwOVghXJsVmgIjBojwkDjvLVfSmnyH6fUN/31cNtCBojEaIOPFD1Fj+0yZeRdJc4NSE96RwUPlbXuTaua1PbWvLppmtd0KroLZ5r9LhZxfBORAVYvu4akGmJuzn3/uRjHlGpMujDciJ7G2+OfQlyhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQqWGwL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C961C2BC9E;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=SxM5obABZJXPt/ymairqXuBar3neaMVGlr0dx2kNeSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQqWGwL2o9drFtCx5CpwBGO7KB4JNdBRaUaq84ybIBhIli6XjwarMA25lLOonojmp
	 hoMPAou4EpsZfVBlw6m0o2ir8YNHMNhJCqWjSaj+uCwe9f/lNG8OtBjpWo2YEijvuA
	 8uHihImeTRkCBPpjlRKCVuOX/YZJcH0DNCyviZr3JwGITXptP45s2qXZEhRBrbfy5j
	 0P0V4tkauD/K8qEim1Uld8pS+uDyHl+1TT6SFf1TcSj5ZF70TmW+OXc9GuXjfCRXgP
	 Tk5emLbiN3J4KK+H2i5s5M3RdsLZLLyUDmC9tOmBe23MITswn59ephbHAtLYKvtzUD
	 WS/Z0yMLdAGXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A3B00CE0F98; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 12/16] srcu: Add SRCU_READ_FLAVOR_FAST_UPDOWN CPP macro
Date: Wed,  5 Nov 2025 12:32:12 -0800
Message-Id: <20251105203216.2701005-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the SRCU_READ_FLAVOR_FAST_UPDOWN=0x8 macro
and adjusts rcutorture to make use of it.  In this commit, both
SRCU_READ_FLAVOR_FAST=0x4 and the new SRCU_READ_FLAVOR_FAST_UPDOWN
test SRCU-fast.  When the SRCU-fast-updown is added, the new
SRCU_READ_FLAVOR_FAST_UPDOWN macro will test it when passed to the
rcutorture.reader_flavor module parameter.

The old SRCU_READ_FLAVOR_FAST macro's value changed from 0x8 to 0x4.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h    | 16 +++++++++-------
 kernel/rcu/rcutorture.c | 24 ++++++++++++++++++------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 41e27c1d917d..1dd6812aabe7 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -56,13 +56,15 @@ int init_srcu_struct_fast(struct srcu_struct *ssp);
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /* Values for SRCU Tree srcu_data ->srcu_reader_flavor, but also used by rcutorture. */
-#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
-#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
-//				0x4		// SRCU-lite is no longer with us.
-#define SRCU_READ_FLAVOR_FAST	0x8		// srcu_read_lock_fast().
-#define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
-				SRCU_READ_FLAVOR_FAST) // All of the above.
-#define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_FAST
+#define SRCU_READ_FLAVOR_NORMAL		0x1		// srcu_read_lock().
+#define SRCU_READ_FLAVOR_NMI		0x2		// srcu_read_lock_nmisafe().
+//					0x4		// SRCU-lite is no longer with us.
+#define SRCU_READ_FLAVOR_FAST		0x4		// srcu_read_lock_fast().
+#define SRCU_READ_FLAVOR_FAST_UPDOWN	0x8		// srcu_read_lock_fast().
+#define SRCU_READ_FLAVOR_ALL		(SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
+					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN)
+						// All of the above.
+#define SRCU_READ_FLAVOR_SLOWGP		(SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN)
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8022d32be351..70ee838cab55 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -702,6 +702,8 @@ static void srcu_torture_init(void)
 	rcu_sync_torture_init();
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		srcu_ctlp = &srcu_ctlf;
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
+		srcu_ctlp = &srcu_ctlf;
 }
 
 static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
@@ -728,6 +730,12 @@ static int srcu_torture_read_lock(void)
 		ret += idx << 1;
 	}
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 2;
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
 		scp = srcu_read_lock_fast(srcu_ctlp);
 		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
 		WARN_ON_ONCE(idx & ~0x1);
@@ -758,8 +766,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
 		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 2));
 	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL))
@@ -793,7 +803,7 @@ static int srcu_torture_down_read(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		return idx;
 	}
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
 		scp = srcu_down_read_fast(srcu_ctlp);
 		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
 		WARN_ON_ONCE(idx & ~0x1);
@@ -806,7 +816,7 @@ static int srcu_torture_down_read(void)
 static void srcu_torture_up_read(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
 		srcu_up_read_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
 	else if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) ||
 		 !(reader_flavor & SRCU_READ_FLAVOR_ALL))
@@ -901,14 +911,16 @@ static struct rcu_torture_ops srcu_ops = {
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
 	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
-				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
 	.name		= "srcu"
 };
 
 static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
+		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
+	else if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
 	else
 		WARN_ON(init_srcu_struct(&srcu_ctld));
@@ -953,7 +965,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
 	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
-				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
 	.name		= "srcud"
 };
 
-- 
2.40.1


