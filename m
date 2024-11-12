Return-Path: <bpf+bounces-44635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A271C9C5DAC
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E1AB451AD
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF1320101B;
	Tue, 12 Nov 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIaby/0O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144B1FF056;
	Tue, 12 Nov 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423158; cv=none; b=lD9MhSFo0OjGUh8ldpPIU3zh2CnkHwZie9LMfXAyWoAYScXBqkhPGp/VqPfJT5CfX3WVrWXWLtjYcshJowM984y8kYFikq+GC++0Abp2y11qdIKmGCFFPyEfqSaKIWFUjiU7g/ScbUa26h0jP36hrc8bNeLxI2EM5SFMtpu/RpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423158; c=relaxed/simple;
	bh=XHUlBJ+mKYT+6k4IYtYtDy0V0TjePNkPX4AfboMkkeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=an1H7s5XVZ3dsI46boT+5x2LGyo220zhcBAR4LBJxoXj/wjpmn36ZAYo7ca8u/0/fxvoyazlRj4k2xi195SZHtCi4QQW/406slXMTqmlnB05g1xib3FROYtAxPr96iY9hYdMyFKe4SlyPXru0gK4z3+ba05mPvs8KxC4Z3UIExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIaby/0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01806C4CECD;
	Tue, 12 Nov 2024 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423157;
	bh=XHUlBJ+mKYT+6k4IYtYtDy0V0TjePNkPX4AfboMkkeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIaby/0OJfZLGuEU9xoWWlvVpghxrlhsQ57edyJGRLUBbHXZtb9z1n5F41v3cDyOJ
	 6hc1e5kOsHBDJR8tcwP8vcGYd+/CwWdqiFOrzF4vV9P75DocB8Y0ixrOuZkRDbHOxi
	 mSqh5oKexrap/owERE6mdWStr3g/G+YrWjI6w+iZdu3A8aG2xEUcPLZnjc5YZ6mfu8
	 s5NR2Hzwb4Mr6VrBZ7SSvRPY1NaPip+57jgDxXL0dW3GsO4Ts7eooAij/ExWRoRPuT
	 ojoKlx4Lt/SLUPnqbC0qi70IY83iXj1xBzrO6lcKFcekMfFDH1Q6hU7qhyVV/dAKYt
	 lJHKgDeJnA5kg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 08/16] srcu: Create CPP macros for normal and NMI-safe SRCU readers
Date: Tue, 12 Nov 2024 15:51:51 +0100
Message-ID: <20241112145159.23032-9-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit creates SRCU_READ_FLAVOR_NORMAL and SRCU_READ_FLAVOR_NMI
C-preprocessor macros for srcu_read_lock() and srcu_read_lock_nmisafe(),
respectively.  These replace the old true/false values that were
previously passed to srcu_check_read_flavor().  In addition, the
srcu_check_read_flavor() function itself requires a bit of rework to
handle bitmasks instead of true/false values.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/srcu.h     | 20 ++++++++------------
 include/linux/srcutree.h |  4 ++++
 kernel/rcu/srcutree.c    | 21 +++++++++++----------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 46fd06b212ba..84daaa33ea0a 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -176,10 +176,6 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
-#define SRCU_NMI_UNKNOWN	0x0
-#define SRCU_NMI_UNSAFE		0x1
-#define SRCU_NMI_SAFE		0x2
-
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
 void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 #else
@@ -247,7 +243,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	retval = __srcu_read_lock(ssp);
 	srcu_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -268,7 +264,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, true);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
 	retval = __srcu_read_lock_nmisafe(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -280,7 +276,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	retval = __srcu_read_lock(ssp);
 	return retval;
 }
@@ -309,7 +305,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
 {
 	WARN_ON_ONCE(in_nmi());
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	return __srcu_read_lock(ssp);
 }
 
@@ -324,7 +320,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock(ssp, idx);
 }
@@ -340,7 +336,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_read_flavor(ssp, true);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
 	rcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock_nmisafe(ssp, idx);
 }
@@ -349,7 +345,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 static inline notrace void
 srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
 {
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	__srcu_read_unlock(ssp, idx);
 }
 
@@ -366,7 +362,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	WARN_ON_ONCE(in_nmi());
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	__srcu_read_unlock(ssp, idx);
 }
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ab7d8d215b84..79ad809c7f03 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -43,6 +43,10 @@ struct srcu_data {
 	struct srcu_struct *ssp;
 };
 
+/* Values for ->srcu_reader_flavor. */
+#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
+#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
+
 /*
  * Node in SRCU combining tree, similar in function to rcu_data.
  */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b85da944d794..602b4b8c4b89 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -463,7 +463,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
-		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
+		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
 	return sum;
 }
 
@@ -703,20 +703,21 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
  */
 void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 {
-	int reader_flavor_mask = 1 << read_flavor;
-	int old_reader_flavor_mask;
+	int old_read_flavor;
 	struct srcu_data *sdp;
 
-	/* NMI-unsafe use in NMI is a bad sign */
-	WARN_ON_ONCE(!read_flavor && in_nmi());
+	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
+	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
+	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
+
 	sdp = raw_cpu_ptr(ssp->sda);
-	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
-	if (!old_reader_flavor_mask) {
-		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
-		if (!old_reader_flavor_mask)
+	old_read_flavor = READ_ONCE(sdp->srcu_reader_flavor);
+	if (!old_read_flavor) {
+		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
+		if (!old_read_flavor)
 			return;
 	}
-	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
+	WARN_ONCE(old_read_flavor != read_flavor, "CPU %d old state %d new state %d\n", sdp->cpu, old_read_flavor, read_flavor);
 }
 EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
 #endif /* CONFIG_PROVE_RCU */
-- 
2.46.0


