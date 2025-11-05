Return-Path: <bpf+bounces-73728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97FC37C04
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DF1A4F2B22
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5934DB70;
	Wed,  5 Nov 2025 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnlDKyih"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2534B662;
	Wed,  5 Nov 2025 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374741; cv=none; b=AVJ7nZFFv/0a7XFXJhd9p3Vq26B0vdZcE2EowQLNpRoylgJ6UhYY02dMYKUqkCtXrQka2oun04XslJcICe2jtZEpwR39NI6obnzWV66JGmhoex9kGPwDhABRF++UrpxVpW+BB55Z/xkYPUFnPQGT7+AO2HD85DdkaTSDKYxH+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374741; c=relaxed/simple;
	bh=RBKV/fx25yjgLjjokyJhRKWQbPIobFaP4EPJRNJ/XNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oW0TrBBH6IOW63ENfIfv9SXCrruiTqGSkWnTjq8wtD6HSKLFSuLzSlip/6OF9goJ8CzFEoz7TPbqnJ865mtU2ZGfE3OEEXVzTw+jtIQKYjEqKYyW9j4V3H8uQagMqDe+4hycMzabbFG8iQe07D3ZWene0N/fBJtn33nrvBj11A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnlDKyih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D440C4CEF5;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=RBKV/fx25yjgLjjokyJhRKWQbPIobFaP4EPJRNJ/XNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnlDKyih3F51XskOWk5bMPXa5calzArTtSyoxQUAId6xGxS3O6X8bWmK5HBAzlJra
	 mCnwVxAexHDJvBB0OCyAdpFN/ISlW1iUYLNVcgKvVI8cU6NYTgLQbB+BZc53lz1/2b
	 ZAph6HsJFXwohLgkiK1QtlV/JUuc/rvJsFkO+N/dpPmodZxYBda+GN/fB9REShX1Tt
	 BgOSPDtIX/YCdIyUhbObUt0iZ24nVZOFgEnDuXu9LdNb4CvMwHFM1T+cijzGr20Id9
	 HGdOb5YTe4LkGvvuViVJUMWwY3JuNVqK0MFPIvGoHdZq7DCRI7hShbvmD07AXcGRbP
	 4pISFTZcokn3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A8DCACE0FF8; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
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
Subject: [PATCH v2 14/16] srcu: Create an SRCU-fast-updown API
Date: Wed,  5 Nov 2025 12:32:14 -0800
Message-Id: <20251105203216.2701005-14-paulmck@kernel.org>
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

This commit creates an SRCU-fast-updown API, including
DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
__init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
__srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().

These are initially identical to their SRCU-fast counterparts, but both
SRCU-fast and SRCU-fast-updown will be optimized in different directions
by later commits.  SRCU-fast will lack any sort of srcu_down_read() and
srcu_up_read() APIs, which will enable extremely efficient NMI safety.
For its part, SRCU-fast-updown will not be NMI safe, which will enable
reasonably efficient implementations of srcu_down_read_fast() and
srcu_up_read_fast().

This commit also adds rcutorture tests for the new APIs.  This
(annoyingly) needs to be in the same commit for bisectability.  With this
commit, the 0x8 value tests SRCU-fast-updown.  However, most SRCU-fast
testing will be via the RCU Tasks Trace wrappers.

[ paulmck: Apply s/0x8/0x4/ missing change per Boqun Feng feedback. ]
[ paulmck: Apply Akira Yokosawa feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 77 +++++++++++++++++++++++++++++++++++++---
 include/linux/srcutiny.h | 16 +++++++++
 include/linux/srcutree.h | 55 ++++++++++++++++++++++++++--
 kernel/rcu/rcutorture.c  | 12 ++++---
 kernel/rcu/srcutree.c    | 39 +++++++++++++++++---
 5 files changed, 183 insertions(+), 16 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 1dd6812aabe7..344ad51c8f6c 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -28,6 +28,8 @@ struct srcu_struct;
 int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
 #ifndef CONFIG_TINY_SRCU
 int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
+int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
+				   struct lock_class_key *key);
 #endif // #ifndef CONFIG_TINY_SRCU
 
 #define init_srcu_struct(ssp) \
@@ -44,12 +46,20 @@ int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lo
 	__init_srcu_struct_fast((ssp), #ssp, &__srcu_key); \
 })
 
+#define init_srcu_struct_fast_updown(ssp) \
+({ \
+	static struct lock_class_key __srcu_key; \
+	\
+	__init_srcu_struct_fast_updown((ssp), #ssp, &__srcu_key); \
+})
+
 #define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name },
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 int init_srcu_struct(struct srcu_struct *ssp);
 #ifndef CONFIG_TINY_SRCU
 int init_srcu_struct_fast(struct srcu_struct *ssp);
+int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
 #endif // #ifndef CONFIG_TINY_SRCU
 
 #define __SRCU_DEP_MAP_INIT(srcu_name)
@@ -305,6 +315,46 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 	return retval;
 }
 
+/**
+ * srcu_read_lock_fast_updown - register a new reader for an SRCU-fast-updown structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter an SRCU read-side critical section, but for a light-weight
+ * smp_mb()-free reader.  See srcu_read_lock() for more information.
+ * This function is compatible with srcu_down_read_fast(), but is not
+ * NMI-safe.
+ *
+ * For srcu_read_lock_fast_updown() to be used on an srcu_struct
+ * structure, that structure must have been defined using either
+ * DEFINE_SRCU_FAST_UPDOWN() or DEFINE_STATIC_SRCU_FAST_UPDOWN() on the one
+ * hand or initialized with init_srcu_struct_fast_updown() on the other.
+ * Such an srcu_struct structure cannot be passed to any non-fast-updown
+ * variant of srcu_read_{,un}lock() or srcu_{down,up}_read().  In kernels
+ * built with CONFIG_PROVE_RCU=y, __srcu_check_read_flavor() will complain
+ * bitterly if you ignore this * restriction.
+ *
+ * Grace-period auto-expediting is disabled for SRCU-fast-updown
+ * srcu_struct structures because SRCU-fast-updown expedited grace periods
+ * invoke synchronize_rcu_expedited(), IPIs and all.  If you need expedited
+ * SRCU-fast-updown grace periods, use synchronize_srcu_expedited().
+ *
+ * The srcu_read_lock_fast_updown() function can be invoked only from
+ * those contexts where RCU is watching, that is, from contexts where
+ * it would be legal to invoke rcu_read_lock().  Otherwise, lockdep will
+ * complain.
+ */
+static inline struct srcu_ctr __percpu *srcu_read_lock_fast_updown(struct srcu_struct *ssp)
+__acquires(ssp)
+{
+	struct srcu_ctr __percpu *retval;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast_updown().");
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST_UPDOWN);
+	retval = __srcu_read_lock_fast_updown(ssp);
+	rcu_try_lock_acquire(&ssp->dep_map);
+	return retval;
+}
+
 /*
  * Used by tracing, cannot be traced and cannot call lockdep.
  * See srcu_read_lock_fast() for more information.
@@ -335,8 +385,8 @@ static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_down_read_fast().");
-	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
-	return __srcu_read_lock_fast(ssp);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST_UPDOWN);
+	return __srcu_read_lock_fast_updown(ssp);
 }
 
 /**
@@ -432,6 +482,23 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
+/**
+ * srcu_read_unlock_fast_updown - unregister a old reader from an SRCU-fast-updown structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @scp: return value from corresponding srcu_read_lock_fast_updown().
+ *
+ * Exit an SRCU-fast-updown read-side critical section.
+ */
+static inline void
+srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp) __releases(ssp)
+{
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST_UPDOWN);
+	srcu_lock_release(&ssp->dep_map);
+	__srcu_read_unlock_fast_updown(ssp, scp);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(),
+			 "RCU must be watching srcu_read_unlock_fast_updown().");
+}
+
 /*
  * Used by tracing, cannot be traced and cannot call lockdep.
  * See srcu_read_unlock_fast() for more information.
@@ -455,9 +522,9 @@ static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ctr __
 	__releases(ssp)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
-	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
-	__srcu_read_unlock_fast(ssp, scp);
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_up_read_fast().");
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST_UPDOWN);
+	__srcu_read_unlock_fast_updown(ssp, scp);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_up_read_fast_updown().");
 }
 
 /**
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 1ecc3393fb26..e0698024667a 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -50,13 +50,18 @@ void srcu_drive_gp(struct work_struct *wp);
 #define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
 #define DEFINE_STATIC_SRCU_FAST(name) \
 	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+#define DEFINE_SRCU_FAST_UPDOWN(name) DEFINE_SRCU(name)
+#define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
 
 // Dummy structure for srcu_notifier_head.
 struct srcu_usage { };
 #define __SRCU_USAGE_INIT(name) { }
 #define __init_srcu_struct_fast __init_srcu_struct
+#define __init_srcu_struct_fast_updown __init_srcu_struct
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 #define init_srcu_struct_fast init_srcu_struct
+#define init_srcu_struct_fast_updown init_srcu_struct
 #endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
 
 void synchronize_srcu(struct srcu_struct *ssp);
@@ -100,6 +105,17 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
 	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
 }
 
+static inline struct srcu_ctr __percpu *__srcu_read_lock_fast_updown(struct srcu_struct *ssp)
+{
+	return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
+}
+
+static inline
+void __srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+{
+	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
+}
+
 static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 {
 	synchronize_srcu(ssp);
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 6080a9094618..d6f978b50472 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -199,8 +199,15 @@ struct srcu_struct {
  *
  * See include/linux/percpu-defs.h for the rules on per-CPU variables.
  *
- * DEFINE_SRCU_FAST() creates an srcu_struct and associated structures
- * whose readers must be of the SRCU-fast variety.
+ * DEFINE_SRCU_FAST() and DEFINE_STATIC_SRCU_FAST create an srcu_struct
+ * and associated structures whose readers must be of the SRCU-fast variety.
+ * DEFINE_SRCU_FAST_UPDOWN() and DEFINE_STATIC_SRCU_FAST_UPDOWN() create
+ * an srcu_struct and associated structures whose readers must be of the
+ * SRCU-fast-updown variety.  The key point (aside from error checking) with
+ * both varieties is that the grace periods must use synchronize_rcu()
+ * instead of smp_mb(), and given that the first (for example)
+ * srcu_read_lock_fast() might race with the first synchronize_srcu(),
+ * this different must be specified at initialization time.
  */
 #ifdef MODULE
 # define __DEFINE_SRCU(name, fast, is_static)							\
@@ -221,6 +228,10 @@ struct srcu_struct {
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, 0, static)
 #define DEFINE_SRCU_FAST(name)		__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, /* not static */)
 #define DEFINE_STATIC_SRCU_FAST(name)	__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, static)
+#define DEFINE_SRCU_FAST_UPDOWN(name)	__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST_UPDOWN, \
+						      /* not static */)
+#define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
+					__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST_UPDOWN, static)
 
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
@@ -305,6 +316,46 @@ __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
 }
 
+/*
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct.  Returns a pointer that must be passed to the matching
+ * srcu_read_unlock_fast_updown().  This type of reader is compatible
+ * with srcu_down_read_fast() and srcu_up_read_fast().
+ *
+ * See the __srcu_read_lock_fast() comment for more details.
+ */
+static inline
+struct srcu_ctr __percpu notrace *__srcu_read_lock_fast_updown(struct srcu_struct *ssp)
+{
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
+
+	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
+		this_cpu_inc(scp->srcu_locks.counter); // Y, and implicit RCU reader.
+	else
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU reader.
+	barrier(); /* Avoid leaking the critical section. */
+	return scp;
+}
+
+/*
+ * Removes the count for the old reader from the appropriate
+ * per-CPU element of the srcu_struct.  Note that this may well be a
+ * different CPU than that which was incremented by the corresponding
+ * srcu_read_lock_fast(), but it must be within the same task.
+ *
+ * Please see the __srcu_read_lock_fast() function's header comment for
+ * information on implicit RCU readers and NMI safety.
+ */
+static inline void notrace
+__srcu_read_unlock_fast_updown(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+{
+	barrier();  /* Avoid leaking the critical section. */
+	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
+		this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
+	else
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
+}
+
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 
 // Record SRCU-reader usage type only for CONFIG_PROVE_RCU=y kernels.
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 70ee838cab55..a52e21634b28 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -693,6 +693,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
 
 DEFINE_STATIC_SRCU(srcu_ctl);
 DEFINE_STATIC_SRCU_FAST(srcu_ctlf);
+DEFINE_STATIC_SRCU_FAST_UPDOWN(srcu_ctlfud);
 static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
 static struct rcu_torture_ops srcud_ops;
@@ -703,7 +704,7 @@ static void srcu_torture_init(void)
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		srcu_ctlp = &srcu_ctlf;
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
-		srcu_ctlp = &srcu_ctlf;
+		srcu_ctlp = &srcu_ctlfud;
 }
 
 static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
@@ -736,7 +737,7 @@ static int srcu_torture_read_lock(void)
 		ret += idx << 2;
 	}
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
-		scp = srcu_read_lock_fast(srcu_ctlp);
+		scp = srcu_read_lock_fast_updown(srcu_ctlp);
 		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 3;
@@ -767,9 +768,10 @@ static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
-		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
+		srcu_read_unlock_fast_updown(srcu_ctlp,
+					     __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
-		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 2));
+		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x4) >> 2));
 	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL))
@@ -919,7 +921,7 @@ static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
-		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
+		WARN_ON(init_srcu_struct_fast_updown(&srcu_ctld));
 	else if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
 	else
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2f8aa280911e..ea3f128de06f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -309,13 +309,24 @@ int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lo
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct_fast);
 
+int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
+				   struct lock_class_key *key)
+{
+	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST_UPDOWN;
+	return __init_srcu_struct_common(ssp, name, key);
+}
+EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
+
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
  * init_srcu_struct - initialize a sleep-RCU structure
  * @ssp: structure to initialize.
  *
- * Must invoke this on a given srcu_struct before passing that srcu_struct
+ * Use this in place of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
+ * for non-static srcu_struct structures that are to be passed to
+ * srcu_read_lock(), srcu_read_lock_nmisafe(), and friends.  It is necessary
+ * to invoke this on a given srcu_struct before passing that srcu_struct
  * to any other function.  Each srcu_struct represents a separate domain
  * of SRCU protection.
  */
@@ -330,9 +341,11 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
  * init_srcu_struct_fast - initialize a fast-reader sleep-RCU structure
  * @ssp: structure to initialize.
  *
- * Must invoke this on a given srcu_struct before passing that srcu_struct
- * to any other function.  Each srcu_struct represents a separate domain
- * of SRCU protection.
+ * Use this in place of DEFINE_SRCU_FAST() and DEFINE_STATIC_SRCU_FAST()
+ * for non-static srcu_struct structures that are to be passed to
+ * srcu_read_lock_fast() and friends.  It is necessary to invoke this on a
+ * given srcu_struct before passing that srcu_struct to any other function.
+ * Each srcu_struct represents a separate domain of SRCU protection.
  */
 int init_srcu_struct_fast(struct srcu_struct *ssp)
 {
@@ -341,6 +354,24 @@ int init_srcu_struct_fast(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_fast);
 
+/**
+ * init_srcu_struct_fast_updown - initialize a fast-reader up/down sleep-RCU structure
+ * @ssp: structure to initialize.
+ *
+ * Use this function in place of DEFINE_SRCU_FAST_UPDOWN() and
+ * DEFINE_STATIC_SRCU_FAST_UPDOWN() for non-static srcu_struct
+ * structures that are to be passed to srcu_read_lock_fast_updown(),
+ * srcu_down_read_fast(), and friends.  It is necessary to invoke this on a
+ * given srcu_struct before passing that srcu_struct to any other function.
+ * Each srcu_struct represents a separate domain of SRCU protection.
+ */
+int init_srcu_struct_fast_updown(struct srcu_struct *ssp)
+{
+	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST_UPDOWN;
+	return init_srcu_struct_fields(ssp, false);
+}
+EXPORT_SYMBOL_GPL(init_srcu_struct_fast_updown);
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /*
-- 
2.40.1


