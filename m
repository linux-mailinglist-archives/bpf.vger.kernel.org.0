Return-Path: <bpf+bounces-49100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B25A14305
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4CF166CFE
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9826242245;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWCCRSlZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D7234D1F;
	Thu, 16 Jan 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=ajemDGGenlsgeaT1vIAV6fJVFdCvKKww5Y54eyoUrPHbqQyCyqilopAc9YdHVeHTM0PIL9krIdFBh1lKFMBZUlHfSk84iKj+/4I2CX17VqeZFqsUuJJe72JB7L/DqrX1wR2t6kfRtF58WkCgRj2VCOxLu7aSYVCuLaGq8vxhoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=VRFMoQRjCDCrcYqMSI5WVHsIfkcveQwBtMml9lqeExM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMJ60aeyLGSrAstFuVyF6cu7YSeJAgcJgK9xTXrNv7fT/tS35I64xdojc8htImlQBt+Elu/m9rVYEJoPsxTpA2IYh7sdxx2U3bR+WQ5Ow1CSxN4zyRt6hAJH9Bcmjx1bBkZWahIhNznWRpP/EOMFurOPD8t/hjeudARAe91fzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWCCRSlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD840C4CED6;
	Thu, 16 Jan 2025 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058874;
	bh=VRFMoQRjCDCrcYqMSI5WVHsIfkcveQwBtMml9lqeExM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWCCRSlZ55WZZ+5V4EZDKfJChiI3ypOxZR0iTdwGS4vsq9uw/HBEeZO6ibmFXHZtk
	 DSZS+4QCZa4d9JAB5GO8zG1DM8OYAltikxZTsMvyCwFCrtc1kcrOc8n0DmTssShU8o
	 pwM9KJUOo9VtOM4no0BIIG4KOLMNEMdrUsQWyDbZCFS/vmCJuuSo9Eg4g7wK+qMG7d
	 4I7qHQmId6WWDVrXVKqpZ5j4hYuj1KRWU7VZOgMt0O1ZZeVkjdzl5R1fN3+yXlVNsr
	 FwE8gf5vPYw2F2m5wcu0IX5UYyfNLvojqeNUI9vktR5OjCJZrrwSQ+oRmbZvJgTCyi
	 QX8QsEOd5sMSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8249CCE13C4; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 01/17] srcu: Make Tiny SRCU able to operate in preemptible kernels
Date: Thu, 16 Jan 2025 12:20:56 -0800
Message-Id: <20250116202112.3783327-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that SRCU allows its read-side critical sections are not just
preemptible, but also allow general blocking, there is not much
reason to restrict Tiny SRCU to non-preemptible kernels.  This commit
therefore removes Tiny SRCU dependencies on non-preemptibility, primarily
surrounding its interaction with rcutorture and early boot.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcu.h      | 9 ++++++---
 kernel/rcu/srcutiny.c | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index f87c9d6d36fcb..f6fcf87d91395 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -611,8 +611,6 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
-static inline unsigned long
-srcu_batches_completed(struct srcu_struct *sp) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
 static inline bool rcu_check_boost_fail(unsigned long gp_state, int *cpup) { return true; }
 static inline void show_rcu_gp_kthreads(void) { }
@@ -624,7 +622,6 @@ static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 bool rcu_watching_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
-unsigned long srcu_batches_completed(struct srcu_struct *sp);
 bool rcu_check_boost_fail(unsigned long gp_state, int *cpup);
 void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
@@ -636,6 +633,12 @@ void rcu_gp_slow_register(atomic_t *rgssp);
 void rcu_gp_slow_unregister(atomic_t *rgssp);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
+#ifdef CONFIG_TINY_SRCU
+static inline unsigned long srcu_batches_completed(struct srcu_struct *sp) { return 0; }
+#else // #ifdef CONFIG_TINY_SRCU
+unsigned long srcu_batches_completed(struct srcu_struct *sp);
+#endif // #else // #ifdef CONFIG_TINY_SRCU
+
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_bind_current_to_nocb(void);
 #else
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index f688bdad293ed..6e9fe2ce1075d 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -20,7 +20,11 @@
 #include "rcu_segcblist.h"
 #include "rcu.h"
 
+#ifndef CONFIG_TREE_RCU
 int rcu_scheduler_active __read_mostly;
+#else // #ifndef CONFIG_TREE_RCU
+extern int rcu_scheduler_active;
+#endif // #else // #ifndef CONFIG_TREE_RCU
 static LIST_HEAD(srcu_boot_list);
 static bool srcu_init_done;
 
@@ -282,11 +286,13 @@ bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
 
+#ifndef CONFIG_TREE_RCU
 /* Lockdep diagnostics.  */
 void __init rcu_scheduler_starting(void)
 {
 	rcu_scheduler_active = RCU_SCHEDULER_RUNNING;
 }
+#endif // #ifndef CONFIG_TREE_RCU
 
 /*
  * Queue work for srcu_struct structures with early boot callbacks.
-- 
2.40.1


