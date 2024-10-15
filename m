Return-Path: <bpf+bounces-42074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B269699F26D
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716BB281AB3
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C901E1FAF05;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra5QECD3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19C1F76C7;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=Qmo1/ZTTYwqWxXHf0smlrpNlqbz6Zi/+D0lCeIi8wUuR8/+cLtlQ0dkcevckY9U8BmmpLjTmX9lYOPSHNboouRuVkqsW4j5u+J21nRtMLjne8CwZJRdHdGtvvNTK9uvLoMYX7k5lh4eVz04HQLB9xr5QJ+iUcuCAeUZWF90VkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=MCTM0QcTKx5V+XLmwCnRaQM2SyFIPw4fWJwP26eLAXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pP2LdcEHQxAnOJTwfOlp3kR9bCQ+Dsmw4fwRlOljZ0XX3nK+jAAfHtcV0+r8CybNvmlqPkDLC7VPagt+l9strVitjdKvEuBR1WnZ03UIG5203OV3eNPnIkPz6agW4/sO5HHbbgK6jvcpNFkpKzUnX3/GYzSfXbSErpq+9ID50aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra5QECD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A209C4CEDD;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=MCTM0QcTKx5V+XLmwCnRaQM2SyFIPw4fWJwP26eLAXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ra5QECD3QJxWPaa32Olv7ALvD8WaHYOESDtwfwVpFNCLGi5UelTFTH7vC+X7TgmHv
	 tdHVAt2CSY5nB/4aBW+ELG94HXe6z9fdqbv1mXTtbgV3tOZ+yfKRwyUtGU2QC/95ls
	 4hj+TnYv4EstDFP8jdQ+4TXqnkiXxPBV/oM9MK+nK4OZwvWM3bKL6OSeh+jSM2gc8W
	 3SN0DGUuH6anwYHG4H9zwM5h1DWcBDKZBbkpmNsd58hF0Intcrko5eCUagiENwHBtq
	 NZIT5Kc4S6DZB3Ks3pIVYVMBsKLtThc8U1joWpwjIWLnTDqXoPxGcv0EvMO27k3rVZ
	 y1bsOFXkGDElQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C9DC2CE13D2; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 09/15] srcu: Allow inlining of __srcu_read_{,un}lock_lite()
Date: Tue, 15 Oct 2024 09:11:06 -0700
Message-Id: <20241015161112.442758-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit moves __srcu_read_lock_lite() and __srcu_read_unlock_lite()
into include/linux/srcu.h and marks them "static inline" so that they
can be inlined into srcu_read_lock_lite() and srcu_read_unlock_lite(),
respectively.  They are not hand-inlined due to Tree SRCU and Tiny SRCU
having different implementations.

The earlier removal of smp_mb() combined with the inlining produce
significant single-percentage performance wins.

Link: https://lore.kernel.org/all/CAEf4BzYgiNmSb=ZKQ65tm6nJDi1UX2Gq26cdHSH1mPwXJYZj5g@mail.gmail.com/

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h | 39 ++++++++++++++++++++++++++++++++++++++
 kernel/rcu/srcutree.c    | 41 ----------------------------------------
 2 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8074138cbd624..778eb61542e18 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -209,4 +209,43 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
+/*
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct.  Returns an index that must be passed to the matching
+ * srcu_read_unlock_lite().
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
+{
+	int idx;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
+	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
+	barrier(); /* Avoid leaking the critical section. */
+	return idx;
+}
+
+/*
+ * Removes the count for the old reader from the appropriate
+ * per-CPU element of the srcu_struct.  Note that this may well be a
+ * different CPU than that which was incremented by the corresponding
+ * srcu_read_lock_lite(), but it must be within the same task.
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
+{
+	barrier();  /* Avoid leaking the critical section. */
+	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
+}
+
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bf51758cf4a64..07147efcb64d3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -763,47 +763,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
-/*
- * Counts the new reader in the appropriate per-CPU element of the
- * srcu_struct.  Returns an index that must be passed to the matching
- * srcu_read_unlock_lite().
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-int __srcu_read_lock_lite(struct srcu_struct *ssp)
-{
-	int idx;
-
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
-	barrier(); /* Avoid leaking the critical section. */
-	return idx;
-}
-EXPORT_SYMBOL_GPL(__srcu_read_lock_lite);
-
-/*
- * Removes the count for the old reader from the appropriate
- * per-CPU element of the srcu_struct.  Note that this may well be a
- * different CPU than that which was incremented by the corresponding
- * srcu_read_lock_lite(), but it must be within the same task.
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
-{
-	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
-}
-EXPORT_SYMBOL_GPL(__srcu_read_unlock_lite);
-
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 
 /*
-- 
2.40.1


