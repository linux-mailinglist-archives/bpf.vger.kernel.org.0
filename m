Return-Path: <bpf+bounces-69079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E98B8BC8A
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62011C22D5F
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23E2E765E;
	Sat, 20 Sep 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKKjnFEU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B82E6CC7;
	Sat, 20 Sep 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330022; cv=none; b=r1g5tFAwZ+dQ4927s6i+EI8lcLZSN7j78jp9uKtIc7LVk6YbzBv3kMCEyYHuO+fSl+ScMlmmtQ+oaV9MuFbdb4d/V15fVtFACbN2KRUqAkErh+n50Irs8TfXQBXaj/dcm0Zj6D3C6SKvy9LRsPhV13qQTe1+G1GUhsZ5gnKiDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330022; c=relaxed/simple;
	bh=lEIMCk3ilAs8TY+TybyMcfYO/HF7q96MAMMCY3VfSC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMiKQCiBTMvsvJNUulfULC4aA9x0jjszFRvKVWjXyPIoQ8gyJ1PNtD6QJFMoT56C9WORvJndFKVBoiilutQtgzHTMlzLJcjT5TJUteoadAkr85T5qnL74jWG71hSTCBdtrqUW52CzlvoWuUiWDbpVq/Js3RlI8htizqKWOY0FCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKKjnFEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114ADC4CEF0;
	Sat, 20 Sep 2025 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330022;
	bh=lEIMCk3ilAs8TY+TybyMcfYO/HF7q96MAMMCY3VfSC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKKjnFEUEzauHjpdJWzmvqpX6KLW0rFmAUZZSvREVpniknhBmUgw/9hQq1PMAUQwG
	 SoyvtFHMHidlmxUXoXQHI8FVZ8BQQ4E7LxLM7MEEhJidbVwlabB0FpGxPS/VNeUl7y
	 ZpJ9nwvIDNXHLn7+N8WNdWe1FsfMYtqvf9wZRjyYrQ8P+b0PRyqUad8yj7MeL1LgOq
	 gKqmLQN0A02KpLk34QUf572nCAKzXBQBkJPSVBMYOKPe9FayxfibptvGydCKbHxxx6
	 yz2O443T754j3WIc2S0QltCvDN0Iy6Dm5crP2o8Gzp5dp9b/kTA0HzJr/zSOIhZKpV
	 8Uskm7jfHi9yw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 45/46] sched_ext: Add rhashtable lookup for sub-schedulers
Date: Fri, 19 Sep 2025 14:59:08 -1000
Message-ID: <20250920005931.2753828-46-tj@kernel.org>
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

Add rhashtable-based lookup for sub-schedulers indexed by cgroup_id to
enable efficient scheduler discovery in preparation for multiple scheduler
support. The hash table allows quick lookup of the appropriate scheduler
instance when processing tasks from different cgroups.

This extends scx_link_sched() to register sub-schedulers in the hash table
and scx_unlink_sched() to remove them. A new scx_find_sub_sched() function
provides the lookup interface.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 54 +++++++++++++++++++++++++++++++++----
 kernel/sched/ext_internal.h |  2 ++
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 058315fc524b..0d865e017115 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -27,6 +27,16 @@ struct scx_sched __rcu *scx_root;
  */
 static LIST_HEAD(scx_sched_all);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+static const struct rhashtable_params scx_sched_hash_params = {
+	.key_len		= sizeof_field(struct scx_sched, ops.sub_cgroup_id),
+	.key_offset		= offsetof(struct scx_sched, ops.sub_cgroup_id),
+	.head_offset		= offsetof(struct scx_sched, hash_node),
+};
+
+static struct rhashtable scx_sched_hash;
+#endif
+
 /*
  * - We want to visit and perform sleepable operations on every task.
  *
@@ -201,6 +211,12 @@ static struct scx_sched *scx_parent(struct scx_sched *sch)
 }
 
 #ifdef CONFIG_EXT_SUB_SCHED
+static struct scx_sched *scx_find_sub_sched(u64 cgroup_id)
+{
+	return rhashtable_lookup(&scx_sched_hash, &cgroup_id,
+				 scx_sched_hash_params);
+}
+
 static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 {
 	rcu_assign_pointer(p->scx.sched, sch);
@@ -233,6 +249,11 @@ static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
 	return NULL;
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
+static struct scx_sched *scx_find_sub_sched(u64 cgroup_id)
+{
+	return NULL;
+}
+
 static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 {
 }
@@ -4221,26 +4242,41 @@ static void refresh_watchdog(void)
 		cancel_delayed_work_sync(&scx_watchdog_work);
 }
 
-static void scx_link_sched(struct scx_sched *sch)
+static int scx_link_sched(struct scx_sched *sch)
 {
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
-		if (parent)
+		int ret;
+
+		if (parent) {
+			ret = rhashtable_lookup_insert_fast(&scx_sched_hash,
+					&sch->hash_node, scx_sched_hash_params);
+			if (ret) {
+				scx_error(sch, "failed to insert into scx_sched_hash (%d)", ret);
+				return ret;
+			}
+
 			list_add_tail(&sch->sibling, &parent->children);
+		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
+
 		list_add_tail_rcu(&sch->all, &scx_sched_all);
 	}
 
 	refresh_watchdog();
+	return 0;
 }
 
 static void scx_unlink_sched(struct scx_sched *sch)
 {
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
-		if (scx_parent(sch))
+		if (scx_parent(sch)) {
+			rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
+					       scx_sched_hash_params);
 			list_del_init(&sch->sibling);
+		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 		list_del_rcu(&sch->all);
 	}
@@ -5233,7 +5269,9 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	rcu_assign_pointer(scx_root, sch);
 
-	scx_link_sched(sch);
+	ret = scx_link_sched(sch);
+	if (ret)
+		goto err_disable;
 
 	scx_idle_enable(ops);
 
@@ -5500,7 +5538,9 @@ static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		goto out_put_cgrp;
 	}
 
-	scx_link_sched(sch);
+	ret = scx_link_sched(sch);
+	if (ret)
+		goto err_disable;
 
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
@@ -6287,6 +6327,10 @@ void __init init_sched_ext_class(void)
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 	register_sysrq_key('D', &sysrq_sched_ext_dump_op);
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
+
+#ifdef CONFIG_EXT_SUB_SCHED
+	BUG_ON(rhashtable_init(&scx_sched_hash, &scx_sched_hash_params));
+#endif	/* CONFIG_EXT_SUB_SCHED */
 }
 
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index f6d5867230bd..7a26c7c89e1f 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -980,6 +980,8 @@ struct scx_sched {
 	struct list_head	all;
 
 #ifdef CONFIG_EXT_SUB_SCHED
+	struct rhash_head	hash_node;
+
 	struct list_head	children;
 	struct list_head	sibling;
 	struct cgroup		*cgrp;
-- 
2.51.0


