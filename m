Return-Path: <bpf+bounces-50140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702DA2344C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696D83A5813
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026C1F1511;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjI6ub+w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92781946C8;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263799; cv=none; b=DqeOw4wJiORvUnbiPxcKnyXXDFjBCDGIfRX+XBngGoBmFzJuAk3HypJpV65opI4cceoRDZfwrciPhueSIOzMvgJWrb9zl0peDM0EgOvjFTf7a21mSwGmUWwFTayPYdm2E0lZMSS1YuEuTm/M3U3zDv6uv5FNk51/rwK1k3X2qKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263799; c=relaxed/simple;
	bh=MuiGWlKDzF6dNqbiFZiGQuuHK6BJEGPPyZ6qKqtvXc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbInnhQw8aS/ziKeHCyh5AFAVotjvCmTBMtLAzJAVpPJiABlsg/9Ansbx2zlxybM7ohx8lkOqBwqHKLMXxhs0HfyVLZzq4A1HKnO7LGJQ5dzf6ZPEVaidjVhtMwrSDptEWRhoQouCWw0mCw0sbk+AmmDq/q1ogOfJYONfEwBx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjI6ub+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C54C4CED2;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=MuiGWlKDzF6dNqbiFZiGQuuHK6BJEGPPyZ6qKqtvXc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjI6ub+wPoD8oq3IGsijUYGJ/XuDknLqIlQ4cgfYgEXQbydVFPcp7V8L4Huo2DSjg
	 wIpRYkOJ29FqoLA9hTWKoYod/ey7VfYY5TXyrEqo+N1GY8WKHemwwRuFcUefoQ1Li9
	 Ep/ExkYuCTdPzjgBzqM11RuUavmcvMDfKY92C1cnI/HmSLH9V8q44TynD4snd9uuJ/
	 bY7LMv8uh4EgYThjzejHPwzDoitaz5BHSEaDR5EjrOtIhwCmBiNv4frcPS5Ox5JK4X
	 d3Olu0tEV5nFkf/c2kN76INaiCJBH3oPiSgD8yhr43nL+zJYEQVZfrEfVtvlGfwQbJ
	 OBRtlwW5hrzEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D1911CE37D9; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 01/20] srcu: Make Tiny SRCU able to operate in preemptible kernels
Date: Thu, 30 Jan 2025 11:02:58 -0800
Message-Id: <20250130190317.1652481-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
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
index f87c9d6d36fc..f6fcf87d9139 100644
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
index f688bdad293e..6e9fe2ce1075 100644
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


