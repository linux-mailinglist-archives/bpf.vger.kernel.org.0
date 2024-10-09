Return-Path: <bpf+bounces-41466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468A997420
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42DB28175A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D691E25FB;
	Wed,  9 Oct 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2Bove1C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F01E1A37;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497242; cv=none; b=ZnEMCcdXPFvQqTxvZwjh/7MFDT3GX2qQiVbGtZAgcTllaNb+nZIMij5SzJ2sc3Q0+RIiwdccCs83+pblkKvNHEocTS478fcgHIJKd63szlSR61jVGOUTLZGAF+hZqBM8EzxSKeCpvi/pR+wFuGVmLpSTGWy8x3iey7pqtPA230U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497242; c=relaxed/simple;
	bh=8hfp/Du5Ub9QEkjtr1jYWVVr4ZGe06rAIhqfw3Hf/sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nu80CVzE/3SljmBgDKnEya0Tk4EllFEf+IP4KC49849IaTh9yBAxZ3DNgm7yMsvetxLBcUdqivF6DSMlIjOGIfnnMe++W7aaSYRpvvGXuwjQ28z4D9+DoMXF+TDGQw8YlB021HAbbwHNQb8GYnyg97zxEGEF+w7L50PI12vc640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2Bove1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19A6C4CEDD;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=8hfp/Du5Ub9QEkjtr1jYWVVr4ZGe06rAIhqfw3Hf/sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2Bove1CxN9O3t+3f4epgXH9FlAwJt8guCyG6qgqYxPERi41AXQBBh+Ft1HLNTZWD
	 8MJnaZxUFg8QQLp0Oqn6fIYPOLx5UwBy4+/Om4arXhBvr6AVyovGdRbKqCskD8w6l6
	 zZmLF2HYjoKcZs7ZBLFQMG+RRqvAHBkka1P3ZAyGzwZ/WGTNZRrDyIfMO1also+gT3
	 /Yk28W/gPyOqFy+jihd8Fuga+wGGUGMAJ5CWVmook/48oivGDvcua/JbR41q22x3ln
	 ol/MNPxE2Xa3MG/SPPIqNeqtweZDUjsAuTc8EDMeOhfYeUvmtka2N62sWMKXoL5qoz
	 CzWrqIjecIPSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 260C3CE1291; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 08/12] rcutorture: Expand RCUTORTURE_RDR_MASK_[12] to eight bits
Date: Wed,  9 Oct 2024 11:07:15 -0700
Message-Id: <20241009180719.778285-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit prepares for testing of multiple SRCU reader flavors by
expanding RCUTORTURE_RDR_MASK_1 and RCUTORTURE_RDR_MASK_2 from a single
bit to eight bits, allowing them to accommodate the return values from
multiple calls to srcu_read_lock*().  This will in turn permit better
testing coverage for these SRCU reader flavors, including testing of
the diagnostics for inproper use of mixed reader flavors.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3ac8c69dd5bc9..ea71a23b45d8b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -57,9 +57,9 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
 
 /* Bits for ->extendables field, extendables param, and related definitions. */
 #define RCUTORTURE_RDR_SHIFT_1	 8	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK_1	 (1 << RCUTORTURE_RDR_SHIFT_1)
-#define RCUTORTURE_RDR_SHIFT_2	 9	/* Put SRCU index in upper bits. */
-#define RCUTORTURE_RDR_MASK_2	 (1 << RCUTORTURE_RDR_SHIFT_2)
+#define RCUTORTURE_RDR_MASK_1	 (0xff << RCUTORTURE_RDR_SHIFT_1)
+#define RCUTORTURE_RDR_SHIFT_2	 16	/* Put SRCU index in upper bits. */
+#define RCUTORTURE_RDR_MASK_2	 (0xff << RCUTORTURE_RDR_SHIFT_2)
 #define RCUTORTURE_RDR_BH	 0x01	/* Extend readers by disabling bh. */
 #define RCUTORTURE_RDR_IRQ	 0x02	/*  ... disabling interrupts. */
 #define RCUTORTURE_RDR_PREEMPT	 0x04	/*  ... disabling preemption. */
@@ -71,6 +71,9 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@
 #define RCUTORTURE_MAX_EXTEND	 \
 	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
 	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
+#define RCUTORTURE_RDR_ALLBITS	\
+	(RCUTORTURE_MAX_EXTEND | RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2 | \
+	 RCUTORTURE_RDR_MASK_1 | RCUTORTURE_RDR_MASK_2)
 #define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
 					/* Must be power of two minus one. */
 #define RCUTORTURE_RDR_MAX_SEGS (RCUTORTURE_RDR_MAX_LOOPS + 3)
@@ -1835,7 +1838,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	int statesold = *readstate & ~newstate;
 
 	WARN_ON_ONCE(idxold2 < 0);
-	WARN_ON_ONCE((idxold2 >> RCUTORTURE_RDR_SHIFT_2) > 1);
+	WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
 	rtrsp->rt_readstate = newstate;
 
 	/* First, put new protection in place to avoid critical-section gap. */
@@ -1850,9 +1853,9 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	if (statesnew & RCUTORTURE_RDR_SCHED)
 		rcu_read_lock_sched();
 	if (statesnew & RCUTORTURE_RDR_RCU_1)
-		idxnew1 = (cur_ops->readlock() & 0x1) << RCUTORTURE_RDR_SHIFT_1;
+		idxnew1 = (cur_ops->readlock() << RCUTORTURE_RDR_SHIFT_1) & RCUTORTURE_RDR_MASK_1;
 	if (statesnew & RCUTORTURE_RDR_RCU_2)
-		idxnew2 = (cur_ops->readlock() & 0x1) << RCUTORTURE_RDR_SHIFT_2;
+		idxnew2 = (cur_ops->readlock() << RCUTORTURE_RDR_SHIFT_2) & RCUTORTURE_RDR_MASK_2;
 
 	/*
 	 * Next, remove old protection, in decreasing order of strength
@@ -1872,7 +1875,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	if (statesold & RCUTORTURE_RDR_RBH)
 		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_RCU_2) {
-		cur_ops->readunlock((idxold2 >> RCUTORTURE_RDR_SHIFT_2) & 0x1);
+		cur_ops->readunlock((idxold2 & RCUTORTURE_RDR_MASK_2) >> RCUTORTURE_RDR_SHIFT_2);
 		WARN_ON_ONCE(idxnew2 != -1);
 		idxold2 = 0;
 	}
@@ -1882,7 +1885,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		lockit = !cur_ops->no_pi_lock && !statesnew && !(torture_random(trsp) & 0xffff);
 		if (lockit)
 			raw_spin_lock_irqsave(&current->pi_lock, flags);
-		cur_ops->readunlock((idxold1 >> RCUTORTURE_RDR_SHIFT_1) & 0x1);
+		cur_ops->readunlock((idxold1 & RCUTORTURE_RDR_MASK_1) >> RCUTORTURE_RDR_SHIFT_1);
 		WARN_ON_ONCE(idxnew1 != -1);
 		idxold1 = 0;
 		if (lockit)
@@ -1897,16 +1900,13 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	if (idxnew1 == -1)
 		idxnew1 = idxold1 & RCUTORTURE_RDR_MASK_1;
 	WARN_ON_ONCE(idxnew1 < 0);
-	if (WARN_ON_ONCE((idxnew1 >> RCUTORTURE_RDR_SHIFT_1) > 1))
-		pr_info("Unexpected idxnew1 value of %#x\n", idxnew1);
 	if (idxnew2 == -1)
 		idxnew2 = idxold2 & RCUTORTURE_RDR_MASK_2;
 	WARN_ON_ONCE(idxnew2 < 0);
-	WARN_ON_ONCE((idxnew2 >> RCUTORTURE_RDR_SHIFT_2) > 1);
 	*readstate = idxnew1 | idxnew2 | newstate;
 	WARN_ON_ONCE(*readstate < 0);
-	if (WARN_ON_ONCE((*readstate >> RCUTORTURE_RDR_SHIFT_2) > 1))
-		pr_info("Unexpected idxnew2 value of %#x\n", idxnew2);
+	if (WARN_ON_ONCE(*readstate & ~RCUTORTURE_RDR_ALLBITS))
+		pr_info("Unexpected readstate value of %#x\n", *readstate);
 }
 
 /* Return the biggest extendables mask given current RCU and boot parameters. */
@@ -1931,7 +1931,7 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
 	unsigned long bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
 
-	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT_1);
+	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT_1);  // Can't have reader idx bits.
 	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
 	if (!(randmask1 & 0x7))
 		mask = mask & randmask2;
-- 
2.40.1


