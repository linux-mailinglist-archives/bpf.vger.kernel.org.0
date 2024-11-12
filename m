Return-Path: <bpf+bounces-44638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC1E9C5B07
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ACE1F2204A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254052022D3;
	Tue, 12 Nov 2024 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3b8kn2A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F731FF7AF;
	Tue, 12 Nov 2024 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423170; cv=none; b=AO9uBYg3CliH5qJBTbV5KodS8sGVmSEh+z59zDUgfBckOJQab2HhtdNt8ztdRsbcFlBX2n63uNun+AG370W2oM5QbQ6rXp/GVYEYqYKfoCnyyV21QAthmdwyghoHQ0R4VlJqUPCtb4x2KKCEf8R0gtWMEwdEQKJq/vYJLNa0s/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423170; c=relaxed/simple;
	bh=eTwF1Vp7R6rmPCXlAVbdnCiKJbBVd/JbVkLnHoPeyJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWB/vs0XX3nnHo+9lsTF28whA3IaT3udp649sxPCZjMVxIAw0dXbiz3VgpDlXAMI+6lP928RJlUhXy16q9QMdUPD4ZvTNFXAE05myDDZjL6xpo9ykRO2FVyVK/CCDzh05ISkIuhC3qgk3o2AyIkdJxmCRA70a5figmE7tOstons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3b8kn2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14EEC4CED0;
	Tue, 12 Nov 2024 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423170;
	bh=eTwF1Vp7R6rmPCXlAVbdnCiKJbBVd/JbVkLnHoPeyJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3b8kn2AjbO/2Hzdk1eUXP2nXskxOj8F3tA5UULmRxDtQ8RDIC+4tECD3kpz776Xl
	 Lziwr4SdXX6FdOFbL381W2JqtWvcet79hBFFSo3sVBBHQdzaCoWkiATP9ZoAT0ZOPI
	 z42i9QxILWsAAt+nyON57yjt8hkf0uWD1nN7wPc4FNNv3l0VvQSMJ4gTl4elIZusuV
	 Y0lsts/mTbr42pejx2VW9zxNiOC8BiZUX60F8KhOxWcHXW5i9F+qOLVlP6WjfSrETl
	 f5+p4r3675cdX8zAZi5JiPJOgGUayyk8hFilnZRAbvsB00tfiWr5XViYkT4R4/3eKC
	 9RS9KYHuGtJNg==
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
Subject: [PATCH 11/16] rcutorture: Expand RCUTORTURE_RDR_MASK_[12] to eight bits
Date: Tue, 12 Nov 2024 15:51:54 +0100
Message-ID: <20241112145159.23032-12-frederic@kernel.org>
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
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bb75dbf5c800..f96ab98f8182 100644
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
@@ -1820,7 +1823,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	int statesold = *readstate & ~newstate;
 
 	WARN_ON_ONCE(idxold2 < 0);
-	WARN_ON_ONCE((idxold2 >> RCUTORTURE_RDR_SHIFT_2) > 1);
+	WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
 	rtrsp->rt_readstate = newstate;
 
 	/* First, put new protection in place to avoid critical-section gap. */
@@ -1835,9 +1838,9 @@ static void rcutorture_one_extend(int *readstate, int newstate,
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
@@ -1857,7 +1860,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	if (statesold & RCUTORTURE_RDR_RBH)
 		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_RCU_2) {
-		cur_ops->readunlock((idxold2 >> RCUTORTURE_RDR_SHIFT_2) & 0x1);
+		cur_ops->readunlock((idxold2 & RCUTORTURE_RDR_MASK_2) >> RCUTORTURE_RDR_SHIFT_2);
 		WARN_ON_ONCE(idxnew2 != -1);
 		idxold2 = 0;
 	}
@@ -1867,7 +1870,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		lockit = !cur_ops->no_pi_lock && !statesnew && !(torture_random(trsp) & 0xffff);
 		if (lockit)
 			raw_spin_lock_irqsave(&current->pi_lock, flags);
-		cur_ops->readunlock((idxold1 >> RCUTORTURE_RDR_SHIFT_1) & 0x1);
+		cur_ops->readunlock((idxold1 & RCUTORTURE_RDR_MASK_1) >> RCUTORTURE_RDR_SHIFT_1);
 		WARN_ON_ONCE(idxnew1 != -1);
 		idxold1 = 0;
 		if (lockit)
@@ -1882,16 +1885,13 @@ static void rcutorture_one_extend(int *readstate, int newstate,
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
@@ -1916,7 +1916,7 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
 	unsigned long bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
 
-	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT_1);
+	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT_1);  // Can't have reader idx bits.
 	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
 	if (!(randmask1 & 0x7))
 		mask = mask & randmask2;
-- 
2.46.0


