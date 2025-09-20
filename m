Return-Path: <bpf+bounces-69053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E85B8BBE4
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8BA02F66
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B42877DA;
	Sat, 20 Sep 2025 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/N2I1Ut"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8E27A135;
	Sat, 20 Sep 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329994; cv=none; b=M4UXExYboBt8V4H9DX8fY+CvPItVy2xTaeIaPxSu/gnTeQyaWE7BvTEDNtSCBNLntX1WjLGe4kfMhgA+O5raG+C9prMKlEJjxpwMt/4ybq5lA0PvoXAh20bELLKLOhfiJgYTUg9e17sEM+LeZKXOQlSKcNvbu8+yBi48mC6/BWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329994; c=relaxed/simple;
	bh=m/X9z6ILVRXT184q/do4C8nPaaxm59G1O8FvxzE7WXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeGZsH7WBTxFu37C4fnND/c04LL3csu1cEWO2GEczQ+ckcQyE+XP5g7lmNa5wgOj+p/TEd2Uqn9k7VFHv0SWykpM5udZx9mjx4fP95+JeSNDKImhJu7p3V2xscZqfK9O5kSGCzjdxvPwspnBykkmQuBYEGl6uSa8ok1IeX8kJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/N2I1Ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AB4C4CEF0;
	Sat, 20 Sep 2025 00:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329993;
	bh=m/X9z6ILVRXT184q/do4C8nPaaxm59G1O8FvxzE7WXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/N2I1UtdpXGxrO8oa2zA6wVjAjBopaJnBxuJJkgEbBb1Z9PI8y8sKV5kTUI2AWq6
	 jFnytqShIz7hE/PxdHdl4Uyr+0QbmIeH/vu22/rJzrOpvEvcewpCXQzAB6GPVWpoVn
	 dc8l4M5tYFtf4KCSd/n86G41qHew97K7JIEoIlgLXxvytb27pguLA6wKksSlrJlpFq
	 USigJGnOAq7tQQQS/mT6hx5PRD8agUWdfGGhW5kYCCdhO5IrRnd2TXfwUJUecNzs0s
	 lCd0tDl4U+r9Ys6DJI6zb4ziKSC7lL4WdUK7sn/K6s+4qRCQHLQY8vPe+nIjHnjwbL
	 o7crGJhFhm6fw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 19/46] cgroup: Expose some cgroup helpers
Date: Fri, 19 Sep 2025 14:58:42 -1000
Message-ID: <20250920005931.2753828-20-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the following through cgroup.h:

- cgroup_on_dfl()
- cgroup_is_dead()
- cgroup_for_each_live_child()
- cgroup_for_each_live_descendant_pre()
- cgroup_for_each_live_descendant_post()

Until now, these didn't need to be exposed because controllers only cared
about the css hierarchy. The planned sched_ext hierarchical scheduler
support will be based on the default cgroup hierarchy, which is in line
with the existing BPF cgroup support, and thus needs these exposed.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h          | 65 ++++++++++++++++++++++++++++++++-
 kernel/cgroup/cgroup-internal.h |  6 ---
 kernel/cgroup/cgroup.c          | 55 ----------------------------
 3 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..3abdff370dd3 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -41,6 +41,14 @@ struct kernel_clone_args;
 
 #ifdef CONFIG_CGROUPS
 
+/*
+ * To avoid confusing the compiler (and generating warnings) with code
+ * that attempts to access what would be a 0-element array (i.e. sized
+ * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
+ * constant expression can be added.
+ */
+#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
+
 enum css_task_iter_flags {
 	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
 	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
@@ -75,6 +83,7 @@ enum cgroup_lifetime_events {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 extern struct blocking_notifier_head cgroup_lifetime_notifier;
 
@@ -102,6 +111,8 @@ extern struct blocking_notifier_head cgroup_lifetime_notifier;
 #define cgroup_subsys_on_dfl(ss)						\
 	static_branch_likely(&ss ## _on_dfl_key)
 
+bool cgroup_on_dfl(const struct cgroup *cgrp);
+
 bool css_has_online_children(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *css_from_id(int id, struct cgroup_subsys *ss);
 struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgroup,
@@ -272,6 +283,32 @@ void css_task_iter_end(struct css_task_iter *it);
 	for ((pos) = css_next_descendant_post(NULL, (css)); (pos);	\
 	     (pos) = css_next_descendant_post((pos), (css)))
 
+/* iterate over child cgrps, lock should be held throughout iteration */
+#define cgroup_for_each_live_child(child, cgrp)				\
+	list_for_each_entry((child), &(cgrp)->self.children, self.sibling) \
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       cgroup_is_dead(child); }))			\
+			;						\
+		else
+
+/* walk live descendants in pre order */
+#define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
+	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       (dsct) = (d_css)->cgroup;			\
+		       cgroup_is_dead(dsct); }))			\
+			;						\
+		else
+
+/* walk live descendants in postorder */
+#define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
+	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       (dsct) = (d_css)->cgroup;			\
+		       cgroup_is_dead(dsct); }))			\
+			;						\
+		else
+
 /**
  * cgroup_taskset_for_each - iterate cgroup_taskset
  * @task: the loop cursor
@@ -334,6 +371,27 @@ static inline u64 cgroup_id(const struct cgroup *cgrp)
 	return cgrp->kn->id;
 }
 
+/**
+ * cgroup_css - obtain a cgroup's css for the specified subsystem
+ * @cgrp: the cgroup of interest
+ * @ss: the subsystem of interest (%NULL returns @cgrp->self)
+ *
+ * Return @cgrp's css (cgroup_subsys_state) associated with @ss.  This
+ * function must be called either under cgroup_mutex or rcu_read_lock() and
+ * the caller is responsible for pinning the returned css if it wants to
+ * keep accessing it outside the said locks.  This function may return
+ * %NULL if @cgrp doesn't have @subsys_id enabled.
+ */
+static inline struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
+						     struct cgroup_subsys *ss)
+{
+	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
+		return rcu_dereference_check(cgrp->subsys[ss->id],
+					lockdep_is_held(&cgroup_mutex));
+	else
+		return &cgrp->self;
+}
+
 /**
  * css_is_dying - test whether the specified css is dying
  * @css: target css
@@ -365,6 +423,11 @@ static inline bool css_is_self(struct cgroup_subsys_state *css)
 	return false;
 }
 
+static inline bool cgroup_is_dead(const struct cgroup *cgrp)
+{
+	return !(cgrp->self.flags & CSS_ONLINE);
+}
+
 static inline void cgroup_get(struct cgroup *cgrp)
 {
 	css_get(&cgrp->self);
@@ -380,8 +443,6 @@ static inline void cgroup_put(struct cgroup *cgrp)
 	css_put(&cgrp->self);
 }
 
-extern struct mutex cgroup_mutex;
-
 static inline void cgroup_lock(void)
 {
 	mutex_lock(&cgroup_mutex);
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index b14e61c64a34..31b6f4cb05ba 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -184,11 +184,6 @@ extern bool cgrp_dfl_visible;
 	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
 	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
 
-static inline bool cgroup_is_dead(const struct cgroup *cgrp)
-{
-	return !(cgrp->self.flags & CSS_ONLINE);
-}
-
 static inline bool notify_on_release(const struct cgroup *cgrp)
 {
 	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
@@ -222,7 +217,6 @@ static inline void get_css_set(struct css_set *cset)
 }
 
 bool cgroup_ssid_enabled(int ssid);
-bool cgroup_on_dfl(const struct cgroup *cgrp);
 
 struct cgroup_root *cgroup_root_from_kf(struct kernfs_root *kf_root);
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..4107af27965f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -69,14 +69,6 @@
 /* let's not notify more than 100 times per second */
 #define CGROUP_FILE_NOTIFY_MIN_INTV	DIV_ROUND_UP(HZ, 100)
 
-/*
- * To avoid confusing the compiler (and generating warnings) with code
- * that attempts to access what would be a 0-element array (i.e. sized
- * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
- * constant expression can be added.
- */
-#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
-
 /*
  * cgroup_mutex is the master lock.  Any modification to cgroup or its
  * hierarchy must be performed while holding it.
@@ -480,27 +472,6 @@ static u16 cgroup_ss_mask(struct cgroup *cgrp)
 	return cgrp->root->subsys_mask;
 }
 
-/**
- * cgroup_css - obtain a cgroup's css for the specified subsystem
- * @cgrp: the cgroup of interest
- * @ss: the subsystem of interest (%NULL returns @cgrp->self)
- *
- * Return @cgrp's css (cgroup_subsys_state) associated with @ss.  This
- * function must be called either under cgroup_mutex or rcu_read_lock() and
- * the caller is responsible for pinning the returned css if it wants to
- * keep accessing it outside the said locks.  This function may return
- * %NULL if @cgrp doesn't have @subsys_id enabled.
- */
-static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
-					      struct cgroup_subsys *ss)
-{
-	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
-		return rcu_dereference_check(cgrp->subsys[ss->id],
-					lockdep_is_held(&cgroup_mutex));
-	else
-		return &cgrp->self;
-}
-
 /**
  * cgroup_e_css_by_mask - obtain a cgroup's effective css for the specified ss
  * @cgrp: the cgroup of interest
@@ -712,32 +683,6 @@ EXPORT_SYMBOL_GPL(of_css);
 	}								\
 } while (false)
 
-/* iterate over child cgrps, lock should be held throughout iteration */
-#define cgroup_for_each_live_child(child, cgrp)				\
-	list_for_each_entry((child), &(cgrp)->self.children, self.sibling) \
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       cgroup_is_dead(child); }))			\
-			;						\
-		else
-
-/* walk live descendants in pre order */
-#define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
-	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       (dsct) = (d_css)->cgroup;			\
-		       cgroup_is_dead(dsct); }))			\
-			;						\
-		else
-
-/* walk live descendants in postorder */
-#define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
-	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       (dsct) = (d_css)->cgroup;			\
-		       cgroup_is_dead(dsct); }))			\
-			;						\
-		else
-
 /*
  * The default css_set - used by init and its children prior to any
  * hierarchies being mounted. It contains a pointer to the root state
-- 
2.51.0


