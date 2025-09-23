Return-Path: <bpf+bounces-69413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7DB963A5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4ECD19C686D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3592E54D6;
	Tue, 23 Sep 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyaO48o5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939F266B46;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637302; cv=none; b=Y7x/ub5EHZFTBBlJDea8Gvz45Xha8OVumtBM0RbPymNK0BfbN2NMd/jlDY54K9xuV3NEvw8U1/qyws4Z2FUAW9smtsRNuTGF8XYrO83kdHcHQW4XhO4v1lnfXbU3xjtXGu5q3qbIfsFkHmTx41IP8JTR24dCLg6r3vP7jDA7Hc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637302; c=relaxed/simple;
	bh=Ko1cw61hU1PAAj+U3rTa7B+e/zegi9QjEUcXug5eMKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGGQ3y4oANLWypWuZ/U/5yc9gQqSWArZJWff86+TgGMtEy1SQ5TFEhtw5wZhZXpfWYmoBz8WoFlh6Zie7GtPfn/jplFVNqm2QSitj2phZdsZ5aDTK4enfekaDq2N91gIHDzgfFPybImbUk7RrX2W+XW30RkCFHSks4qp8sjO1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyaO48o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B4AC4AF09;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=Ko1cw61hU1PAAj+U3rTa7B+e/zegi9QjEUcXug5eMKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyaO48o57k4+Agc6ginPdjeD+MQkDVMSHNF5EBoDbN2LWLdOFpicNnOhl3z2XmnbZ
	 iyNcNLewqEpPhAIop/a4WEmikqLPghjJe0N7IWk7uinvUCWx73uUTGTwu40OcB1bOX
	 nB9wNhK744xCd1DcblpVxN6OLfyX2bREK1ZBUCWxHsiDS88K9SP381Zv4ly+uxWl5Z
	 Xd4uJZ6Npx2ag43HqKGmq4NxUTHJn2csgmS/Vy0PPcqoM0Ib+1Ugq0+TX00RFKECIi
	 5zr1oT2G9YKT2p/0lbUzm5s3KjgjSSCf6yvKWpv/pnLazKNYilkila9pbUA3/zpVTZ
	 P46muwfMqjFRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0A17BCE172F; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 27/34] srcu: Make DEFINE_SRCU_FAST() available to modules
Date: Tue, 23 Sep 2025 07:20:29 -0700
Message-Id: <20250923142036.112290-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit makes DEFINE_SRCU_FAST() available to modules.  The trick
is that DEFINE_SRCU_FAST() does not allocate the per-CPU data structure
when used within a module (by design), which means that it is not possible
to compile-time-initialize any of the fields in this structure, including
in particular the ->srcu_reader_flavor field.

This commit therefore creates an ->srcu_reader_flavor field in the
srcu_struct structure, adds arguments to the DEFINE_SRCU()-related
macros to initialize this new field, and extending the checks in the
__srcu_check_read_flavor() function to include this new field.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/notifier.h |  2 +-
 include/linux/srcutiny.h | 10 ++++++----
 include/linux/srcutree.h | 24 +++++++++++++-----------
 kernel/rcu/srcutree.c    |  3 +++
 4 files changed, 23 insertions(+), 16 deletions(-)

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
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 941e8210479607..b5f62259d56fb1 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -31,7 +31,7 @@ struct srcu_struct {
 
 void srcu_drive_gp(struct work_struct *wp);
 
-#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored)			\
+#define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
@@ -44,10 +44,12 @@ void srcu_drive_gp(struct work_struct *wp);
  * Tree SRCU, which needs some per-CPU data.
  */
 #define DEFINE_SRCU(name) \
-	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
-#define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
+	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
 #define DEFINE_STATIC_SRCU(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
+#define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
+#define DEFINE_STATIC_SRCU_FAST(name) \
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name, name)
 
 // Dummy structure for srcu_notifier_head.
 struct srcu_usage { };
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 4a5d1c0e7db361..05400f70baa40a 100644
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
@@ -207,22 +209,22 @@ struct srcu_struct {
 #ifdef MODULE
 # define __DEFINE_SRCU(name, fast, is_static)							\
 	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
-	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage);	\
+	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage,	\
+								      fast);			\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
 		__section("___srcu_struct_ptrs") = &name
 #else
 # define __DEFINE_SRCU(name, fast, is_static)							\
-	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data) = {				\
-		.srcu_reader_flavor = fast,							\
-	};											\
+	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
 	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
 	is_static struct srcu_struct name =							\
-		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
-#define DEFINE_SRCU_FAST(name)		__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, /* not static */)
+		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data, fast)
 #endif
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, 0, /* not static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, 0, static)
+#define DEFINE_SRCU_FAST(name)		__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, /* not static */)
+#define DEFINE_STATIC_SRCU_FAST(name)	__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, static)
 
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f2f11492e6936e..7c8b39d4dd3162 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -734,6 +734,9 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 
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


