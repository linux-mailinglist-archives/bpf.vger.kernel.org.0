Return-Path: <bpf+bounces-73285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60340C29784
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92FB54E9A8D
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C4E25BEFD;
	Sun,  2 Nov 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or5spg9F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB39256C89;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119879; cv=none; b=ZQRX8c8SZYE7UtZz3TDBKHCKwtOvKbLnb/m4z98eyzvi0018Sq7xbut3IYX7vpimHtfjJTvserzx6W6PAuCyL4zP9C2Fbxf7NddiccE+9KxHa4lFJngO0RpgbRWdQXew+Z456jj/x3Eb/E/vQ4TN/490gTkk/Wf7Js7wpDqzeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119879; c=relaxed/simple;
	bh=7l0RKrGot9+VxpVYsZ6++nqGzBBkeqDPhqDWexz8syM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UYtUoowCn58J7+q2tFHZPtXwhrD16hFB9kXfoHeGB75m/BKMCPtPDeCtLWxvXMYLL2AhzcUufuttamC+sm8W8W3BFrkNWislbzZ9pZl89NAklg4BZ2ahvStbH+s0dpNeWAzdJ287LdUirO01rAjT21tJU5BKO+GmuReKxnb5cWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or5spg9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAA8C116D0;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119879;
	bh=7l0RKrGot9+VxpVYsZ6++nqGzBBkeqDPhqDWexz8syM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Or5spg9FXTtnkljSyHz35kGCS5pd13dn6JO2z1fl5fpSR+B7I7cz1b8eX1dGoOrX0
	 h7anRIbbexF2wq8fEAnok2ej415ircL1pLgOP0eSHWWBHcQI85U/E8nA+50PAPL1/F
	 pH9denxBl38dz7xNhY2yfmuxZTCcWqxBR5Ci7BEtOMvPXT61Z38P8AxdrdcI1lsF6o
	 VZJX065pjwY2H9sGrsB7aKLpNqUqVTKWGuBIP1Qf+3py6mw6OIGOx+FsSBcmLXPh/A
	 jec+QsivF+oaI/GKFEwZwhZbW2NR3fft5K+t1uMBsnhxHaYMj30byaGuIPdzYC7+Z1
	 qHN3mAOO/zt/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9FAACCE167B; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
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
Subject: [PATCH 15/19] srcu: Create an SRCU-fast-updown API
Date: Sun,  2 Nov 2025 13:44:32 -0800
Message-Id: <20251102214436.3905633-15-paulmck@kernel.org>
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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 77 +++++++++++++++++++++++++++++++++++++---
 include/linux/srcutiny.h | 16 +++++++++
 include/linux/srcutree.h | 55 ++++++++++++++++++++++++++--
 kernel/rcu/srcutree.c    | 39 +++++++++++++++++---
 4 files changed, 176 insertions(+), 11 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 1dd6812aabe7..1fbf475eae5e 100644
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
+ * built with CONFIG_PROVE_RCU=y, () will complain bitterly if you ignore
+ * this * restriction.
+ *
+ * Grace-period auto-expediting is disabled for SRCU-fast-updown
+ * srcu_struct structures because SRCU-fast-updown expedited grace periods
+ * invoke synchronize_rcu_expedited(), IPIs and all.  If you need expedited
+ * SRCU-fast-updown grace periods, use synchronize_srcu_expedited().
+ *
+ * The srcu_read_lock_fast_updown() function can be invoked only from
+ those contexts where RCU is watching, that is, from contexts where
+ it would be legal to invoke rcu_read_lock().  Otherwise, lockdep will
+ complain.
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


