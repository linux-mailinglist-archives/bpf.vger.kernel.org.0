Return-Path: <bpf+bounces-70103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEBBB0D3A
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BE33C0EBE
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E143081B2;
	Wed,  1 Oct 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLCIQ08z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71470306D40;
	Wed,  1 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330122; cv=none; b=YBHC3Z3lNul/umJy1z72zCA6m8Ra5eDtNbqhtJZFxehCQVYcrAlxd9tMswtgzI8hnFXTLlGWp2ekEgnx0Cza5VwKSIIqKf27kPOCE0KsH7wdMfzUUpi0eTcjvzK9myblUwP+3XCIWfQLFyx7KpTksjCDtsoIvr8yqBIUrRFDS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330122; c=relaxed/simple;
	bh=h25HXfqFwZPbzPp+0/q7PleMKwW/TXZPNmjI5yN4W8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gaJCUtoDYHc0XdbY9Y4ZCvjtiVYzx64nx021rOtcyIUGp7LVfOZZaoASkTvn/xAHYoOWMd/YGB/R5fAEv+ZUGMzbDhL5I55hkaiYN16NGVldJfYgLcsxD5IHLvUrVSanRt+3omJKksBGBWXKFHDXMVUgAke4tmylDcAQ1Zth7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLCIQ08z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD0FC4CEFB;
	Wed,  1 Oct 2025 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330122;
	bh=h25HXfqFwZPbzPp+0/q7PleMKwW/TXZPNmjI5yN4W8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLCIQ08z3SlN2WlN4vUVtl0nuhTVvrV6DT78yaGGwFs4MPshPJxuGtQj6Gq10iJT0
	 A1yZ5/WwCHq1YysHhe7ZR7AgGHW0kJWhjwdm9okrAusdn8p9Lhr29gfoEWcJfjUgxk
	 W3Nla37WhiWgfAetAal7z0U9dVmANGuAM8U1PvLe+tZ9QRqTqw2k3cSd0u0VPocQqI
	 UeWIAv99XsjEzka5J3ywtxg7eJaAWSNraittJN32vWVGtTY7h06v5vTgOjdmWhDAVb
	 9ukKfRjbrpH4n+/w4p26/3XBglI2KoC4P3F7AOSBUEcXkQQEPtV51MjPc6Znfz/dTM
	 PJcVvAI41/o8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F63FCE14F4; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 18/21] srcu: Make SRCU-fast readers enforce use of SRCU-fast definition/init
Date: Wed,  1 Oct 2025 07:48:29 -0700
Message-Id: <20251001144832.631770-18-paulmck@kernel.org>
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

This commit makes CONFIG_PROVE_RCU=y kernels enforce the new rule
that srcu_struct structures that are passed to srcu_read_lock_fast()
and other SRCU-fast read-side markers be either initialized with
init_srcu_struct_fast() on the one hand or defined with DEFINE_SRCU_FAST()
or DEFINE_STATIC_SRCU_FAST() on the other.

This eliminates the read-side test that was formerly included in
srcu_read_lock_fast() and friends, speeding these primitives up by
about 25% (admittedly only about half of a nanosecond, but when tracing
on fastpaths...)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     |  6 +++---
 include/linux/srcutiny.h |  1 -
 include/linux/srcutree.h | 16 +---------------
 kernel/rcu/tasks.h       |  5 -----
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 2982b5a6930fa6..41e27c1d917d3e 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -297,7 +297,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 	struct srcu_ctr __percpu *retval;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
-	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	retval = __srcu_read_lock_fast(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -312,7 +312,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_
 {
 	struct srcu_ctr __percpu *retval;
 
-	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	retval = __srcu_read_lock_fast(ssp);
 	return retval;
 }
@@ -333,7 +333,7 @@ static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_down_read_fast().");
-	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	return __srcu_read_lock_fast(ssp);
 }
 
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 92e6ab53398fc0..1ecc3393fb26be 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -112,7 +112,6 @@ static inline void srcu_barrier(struct srcu_struct *ssp)
 
 static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
 #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
-#define srcu_check_read_flavor_force(ssp, read_flavor) do { } while (0)
 
 /* Defined here to avoid size increase for non-torture kernels. */
 static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 05400f70baa40a..fd24ec146af614 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -311,21 +311,7 @@ __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 
-// Record reader usage even for CONFIG_PROVE_RCU=n kernels.  This is
-// needed only for flavors that require grace-period smp_mb() calls to be
-// promoted to synchronize_rcu().
-static inline void srcu_check_read_flavor_force(struct srcu_struct *ssp, int read_flavor)
-{
-	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
-
-	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & read_flavor))
-		return;
-
-	// Note that the cmpxchg() in __srcu_check_read_flavor() is fully ordered.
-	__srcu_check_read_flavor(ssp, read_flavor);
-}
-
-// Record non-_lite() usage only for CONFIG_PROVE_RCU=y kernels.
+// Record SRCU-reader usage type only for CONFIG_PROVE_RCU=y kernels.
 static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 {
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bf1226834c9423..76f952196a2921 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1600,11 +1600,6 @@ static inline void rcu_tasks_bootup_oddness(void) {}
 // Tracing variant of Tasks RCU.  This variant is designed to be used
 // to protect tracing hooks, including those of BPF.  This variant
 // is implemented via a straightforward mapping onto SRCU-fast.
-// DEFINE_SRCU_FAST() is required because rcu_read_lock_trace() must
-// use __srcu_read_lock_fast() in order to bypass the rcu_is_watching()
-// checks in kernels built with CONFIG_TASKS_TRACE_RCU_NO_MB=n, which also
-// bypasses the srcu_check_read_flavor_force() that would otherwise mark
-// rcu_tasks_trace_srcu_struct as needing SRCU-fast readers.
 
 DEFINE_SRCU_FAST(rcu_tasks_trace_srcu_struct);
 EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
-- 
2.40.1


