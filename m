Return-Path: <bpf+bounces-69078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FCFB8BC84
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B761897779
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659B2E427C;
	Sat, 20 Sep 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+BvtDp0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B5230264;
	Sat, 20 Sep 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330021; cv=none; b=FLmlIt8rEiA0Jx+TjIBO/ATTvfuy7+MH41CHvzsFBgL+lQxdddHftTauLlecO9/YUShQgtIPRt9PD/WXdeaT/FKizr9WGwjiZC2cb5WUto6xQTWPlBQeE94yC0zoWEqH9/cILX3x+i2UTuJouTc8C696DPb75+OWK02+fDWmLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330021; c=relaxed/simple;
	bh=B/Q0AEuxbLjwxnFtA2f7DqgvK0KFO/hLFsyma70t6UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3AAY5DEAlMnIfRxl16AYnzx+gTZbPVGRZJ55IobBe8oO/et6QAwpMYz9ASnTd0rgNdUgJsdJsCjkYyV5JyAlreM187TEJBQoqMeK3wuG/7Ylb9M2SKk62atV+wiGKUB4c8O7A6DKuC3joh0EciERXPjDmFutqV5TcVaSh1cx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+BvtDp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F738C4CEF0;
	Sat, 20 Sep 2025 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330021;
	bh=B/Q0AEuxbLjwxnFtA2f7DqgvK0KFO/hLFsyma70t6UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+BvtDp0DxBnwkaLvXxmLYgO/dQxxAhs2vNAtoLPZnVRzpKPi2q9PToHPfPReqYH6
	 1zRY5o8rla0gQ05xdYb5R44YVau5b5Ow4wsG9vOnVk/rGkhfebJVZx7pUqkpgCtIlx
	 SNomP7FmNYoGYu98/HJ5cxU30nkZCP9ggRJ3OuGVsXQ7Mi2bs/vLq40E7PvpLEu2xY
	 jHeauCFgZZd74Y3+wtxt6P0MMj2fqM5+k8M20WDPNMB5gQfU7AdycuU8a0e4fKGvI7
	 FvPXRYfeAsWTbrrTs0LAr7rE5TF2lG8VlVXpD+0DrnZnAbmHBde0olGUGFqyJJr90j
	 8M/VMF6mIEcCw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 44/46] sched_ext: Factor out scx_link_sched() and scx_unlink_sched()
Date: Fri, 19 Sep 2025 14:59:07 -1000
Message-ID: <20250920005931.2753828-45-tj@kernel.org>
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

Factor out scx_link_sched() and scx_unlink_sched() functions to reduce
code duplication in the scheduler enable/disable paths.

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 53 +++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4558bec72508..058315fc524b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4221,6 +4221,33 @@ static void refresh_watchdog(void)
 		cancel_delayed_work_sync(&scx_watchdog_work);
 }
 
+static void scx_link_sched(struct scx_sched *sch)
+{
+	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+#ifdef CONFIG_EXT_SUB_SCHED
+		struct scx_sched *parent = scx_parent(sch);
+		if (parent)
+			list_add_tail(&sch->sibling, &parent->children);
+#endif	/* CONFIG_EXT_SUB_SCHED */
+		list_add_tail_rcu(&sch->all, &scx_sched_all);
+	}
+
+	refresh_watchdog();
+}
+
+static void scx_unlink_sched(struct scx_sched *sch)
+{
+	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+#ifdef CONFIG_EXT_SUB_SCHED
+		if (scx_parent(sch))
+			list_del_init(&sch->sibling);
+#endif	/* CONFIG_EXT_SUB_SCHED */
+		list_del_rcu(&sch->all);
+	}
+
+	refresh_watchdog();
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
@@ -4385,12 +4412,7 @@ static void scx_sub_disable(struct scx_sched *sch)
 	 */
 	synchronize_rcu_expedited();
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_del_init(&sch->sibling);
-	list_del_rcu(&sch->all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_unlink_sched(sch);
 
 	mutex_unlock(&scx_enable_mutex);
 
@@ -4549,11 +4571,7 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, ei);
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_del_rcu(&sch->all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_unlink_sched(sch);
 
 	/*
 	 * scx_root clearing must be inside cpus_read_lock(). See
@@ -5215,11 +5233,7 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	rcu_assign_pointer(scx_root, sch);
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_add_tail_rcu(&sch->all, &scx_sched_all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_link_sched(sch);
 
 	scx_idle_enable(ops);
 
@@ -5486,12 +5500,7 @@ static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		goto out_put_cgrp;
 	}
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_add_tail(&sch->sibling, &parent->children);
-	list_add_tail_rcu(&sch->all, &scx_sched_all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_link_sched(sch);
 
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
-- 
2.51.0


