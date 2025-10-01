Return-Path: <bpf+bounces-70098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C0FBB0D10
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484131943955
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D992D306488;
	Wed,  1 Oct 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOLocjYY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E842303C9F;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330120; cv=none; b=M/JWSkNhrqb+TWjaKWZNiWfjm6+RtykTwOLmtu4P8QlnsiJLigkuDQmd1r6JtwsrFP0TG1QqVll58cDg9hbWkJBNfHc2xlFiGBf+D6+7FyyJjtZm+SmCbqhmi8A15QPCGff5tiBaBGXW3xsAKGMIRzBj8r0Nb6JBA0XEt7LHDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330120; c=relaxed/simple;
	bh=KsyAiYK2BbMqGVso6WNz3IqAqctiHCv1RlmZwiUylvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mp+T3/7lkZdiBMItKzKloMpErY+HtZlhnkK8+rS3hv8z2eo+P0iTpsT5IEymICh1zMIU1kIOnp1pUAhDs2zbljmt8LM7uki1/+ySK1PhY2rrqDhOh7+lGF4BiipgdPfIBJOTsze0CF4LnxbuXMuTIiTretHQD3M99vjNRQKhpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOLocjYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB2DC4CEF1;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330119;
	bh=KsyAiYK2BbMqGVso6WNz3IqAqctiHCv1RlmZwiUylvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOLocjYYkXFAZXMqryXV0ZEbA/RIlrBIXShFF8/TaQvjQdSePGfozymi1/eawhMy2
	 P2iH8sz6rt8WFLF5WXu+a2GXKbRuyFeavaHob7MB+B5W/FgkJUrnbdQVHKoEgzBXfb
	 /iCwHdFh7KAZsgae0okgLf6uXOweHfq8LUIgxCsVQaRK+CECLYg0PdXVr2Xk9kqpVy
	 JcFKTX5BkrFVkzNO+ZeNoNT3RqPl9H7uxOVfCH1q3wYgE2LaGuSiO7/xwzFlv958TE
	 FSnMAVGKwgFB2JflQMo7o1m4TaCMU+3xRDm2VamMncgDf1rjcEgKJSvy1m6F8OxV7w
	 z4DtVuH/GBzVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D305CE1418; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 11/21] srcu: Create a DEFINE_SRCU_FAST()
Date: Wed,  1 Oct 2025 07:48:22 -0700
Message-Id: <20251001144832.631770-11-paulmck@kernel.org>
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

This commit creates DEFINE_SRCU_FAST() and DEFINE_STATIC_SRCU_FAST()
macros that are similar to DEFINE_SRCU() and DEFINE_STATIC_SRCU(),
but which create srcu_struct structures that are usable only by readers
initiated by srcu_read_lock_fast() and friends.

This commit does make DEFINE_SRCU_FAST() available to modules, in which
case the per-CPU srcu_data structures are not created at compile time, but
rather at module-load time.  This means that the >srcu_reader_flavor field
of the srcu_data structure is not available.  Therefore,
this commit instead creates an ->srcu_reader_flavor field in the
srcu_struct structure, adds arguments to the DEFINE_SRCU()-related
macros to initialize this new field, and extends the checks in the
__srcu_check_read_flavor() function to include this new field.

This commit also allows dynamically allocated srcu_struct structure
to be marked for SRCU-fast readers.  It does so by defining a new
init_srcu_struct_fast() function that marks the specified srcu_struct
structure for use by srcu_read_lock_fast() and friends.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/notifier.h |  2 +-
 include/linux/srcu.h     | 16 ++++++++++++++--
 include/linux/srcutiny.h | 13 ++++++++++---
 include/linux/srcutree.h | 34 +++++++++++++++++++++++-----------
 kernel/rcu/srcutree.c    | 36 ++++++++++++++++++++++++++++++++++--
 5 files changed, 82 insertions(+), 19 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index b42e6473496882..01b6c9d9956f90 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -109,7 +109,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
 		.head = NULL,					\
 		.srcuu = __SRCU_USAGE_INIT(name.srcuu),		\
-		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
+		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu, 0), \
 	}
 
 #define ATOMIC_NOTIFIER_HEAD(name)				\
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index ada65b58bc4c5f..26de47820c58cd 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -25,8 +25,10 @@ struct srcu_struct;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
-		       struct lock_class_key *key);
+int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
+#ifndef CONFIG_TINY_SRCU
+int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
+#endif // #ifndef CONFIG_TINY_SRCU
 
 #define init_srcu_struct(ssp) \
 ({ \
@@ -35,10 +37,20 @@ int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
 	__init_srcu_struct((ssp), #ssp, &__srcu_key); \
 })
 
+#define init_srcu_struct_fast(ssp) \
+({ \
+	static struct lock_class_key __srcu_key; \
+	\
+	__init_srcu_struct_fast((ssp), #ssp, &__srcu_key); \
+})
+
 #define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name },
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 int init_srcu_struct(struct srcu_struct *ssp);
+#ifndef CONFIG_TINY_SRCU
+int init_srcu_struct_fast(struct srcu_struct *ssp);
+#endif // #ifndef CONFIG_TINY_SRCU
 
 #define __SRCU_DEP_MAP_INIT(srcu_name)
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 3bfbd44cb1b37d..92e6ab53398fc0 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -31,7 +31,7 @@ struct srcu_struct {
 
 void srcu_drive_gp(struct work_struct *wp);
 
-#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored)			\
+#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
@@ -44,13 +44,20 @@ void srcu_drive_gp(struct work_struct *wp);
  * Tree SRCU, which needs some per-CPU data.
  */
 #define DEFINE_SRCU(name) \
-	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
+	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
 #define DEFINE_STATIC_SRCU(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+#define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
+#define DEFINE_STATIC_SRCU_FAST(name) \
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
 
 // Dummy structure for srcu_notifier_head.
 struct srcu_usage { };
 #define __SRCU_USAGE_INIT(name) { }
+#define __init_srcu_struct_fast __init_srcu_struct
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#define init_srcu_struct_fast init_srcu_struct
+#endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
 
 void synchronize_srcu(struct srcu_struct *ssp);
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 93ad18acd6d02d..05400f70baa40a 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -104,6 +104,7 @@ struct srcu_usage {
 struct srcu_struct {
 	struct srcu_ctr __percpu *srcu_ctrp;
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
+	u8 srcu_reader_flavor;
 	struct lockdep_map dep_map;
 	struct srcu_usage *srcu_sup;		/* Update-side data. */
 };
@@ -162,20 +163,21 @@ struct srcu_struct {
 	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
 }
 
-#define __SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
+#define __SRCU_STRUCT_INIT_COMMON(name, usage_name, fast)					\
 	.srcu_sup = &usage_name,								\
+	.srcu_reader_flavor = fast,								\
 	__SRCU_DEP_MAP_INIT(name)
 
-#define __SRCU_STRUCT_INIT_MODULE(name, usage_name)						\
+#define __SRCU_STRUCT_INIT_MODULE(name, usage_name, fast)					\
 {												\
-	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
+	__SRCU_STRUCT_INIT_COMMON(name, usage_name, fast)					\
 }
 
-#define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name)						\
+#define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name, fast)					\
 {												\
 	.sda = &pcpu_name,									\
 	.srcu_ctrp = &pcpu_name.srcu_ctrs[0],							\
-	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
+	__SRCU_STRUCT_INIT_COMMON(name, usage_name, fast)						\
 }
 
 /*
@@ -196,23 +198,33 @@ struct srcu_struct {
  *	init_srcu_struct(&my_srcu);
  *
  * See include/linux/percpu-defs.h for the rules on per-CPU variables.
+ *
+ * DEFINE_SRCU_FAST() creates an srcu_struct and associated structures
+ * whose readers must be of the SRCU-fast variety.  DEFINE_SRCU_FAST()
+ * cannot be used within modules due to there being no place to
+ * put the desired ->srcu_reader_flavor value.  If in-module use of
+ * DEFINE_SRCU_FAST() becomes necessary, the srcu_struct structure will
+ * need to grow in order to store this value.
  */
 #ifdef MODULE
-# define __DEFINE_SRCU(name, is_static)								\
+# define __DEFINE_SRCU(name, fast, is_static)							\
 	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
-	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage);	\
+	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage,	\
+								      fast);			\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
 		__section("___srcu_struct_ptrs") = &name
 #else
-# define __DEFINE_SRCU(name, is_static)								\
+# define __DEFINE_SRCU(name, fast, is_static)							\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
 	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
 	is_static struct srcu_struct name =							\
-		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
+		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data, fast)
 #endif
-#define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
-#define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
+#define DEFINE_SRCU(name)		__DEFINE_SRCU(name, 0, /* not static */)
+#define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, 0, static)
+#define DEFINE_SRCU_FAST(name)		__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, /* not static */)
+#define DEFINE_STATIC_SRCU_FAST(name)	__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, static)
 
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 38b440b0b0c80b..9869a13b876342 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -286,16 +286,29 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
-		       struct lock_class_key *key)
+static int
+__init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
 {
 	/* Don't re-initialize a lock while it is held. */
 	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
 	lockdep_init_map(&ssp->dep_map, name, key, 0);
 	return init_srcu_struct_fields(ssp, false);
 }
+
+int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
+{
+	ssp->srcu_reader_flavor = 0;
+	return __init_srcu_struct_common(ssp, name, key);
+}
 EXPORT_SYMBOL_GPL(__init_srcu_struct);
 
+int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
+{
+	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
+	return __init_srcu_struct_common(ssp, name, key);
+}
+EXPORT_SYMBOL_GPL(__init_srcu_struct_fast);
+
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
@@ -308,10 +321,26 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct);
  */
 int init_srcu_struct(struct srcu_struct *ssp)
 {
+	ssp->srcu_reader_flavor = 0;
 	return init_srcu_struct_fields(ssp, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct);
 
+/**
+ * init_srcu_struct_fast - initialize a fast-reader sleep-RCU structure
+ * @ssp: structure to initialize.
+ *
+ * Must invoke this on a given srcu_struct before passing that srcu_struct
+ * to any other function.  Each srcu_struct represents a separate domain
+ * of SRCU protection.
+ */
+int init_srcu_struct_fast(struct srcu_struct *ssp)
+{
+	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
+	return init_srcu_struct_fields(ssp, false);
+}
+EXPORT_SYMBOL_GPL(init_srcu_struct_fast);
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /*
@@ -734,6 +763,9 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 
 	sdp = raw_cpu_ptr(ssp->sda);
 	old_read_flavor = READ_ONCE(sdp->srcu_reader_flavor);
+	WARN_ON_ONCE(ssp->srcu_reader_flavor && read_flavor != ssp->srcu_reader_flavor);
+	WARN_ON_ONCE(old_read_flavor && ssp->srcu_reader_flavor &&
+		     old_read_flavor != ssp->srcu_reader_flavor);
 	if (!old_read_flavor) {
 		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
 		if (!old_read_flavor)
-- 
2.40.1


