Return-Path: <bpf+bounces-60108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6BEAD2A07
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 00:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F3A3A33C9
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB222756A;
	Mon,  9 Jun 2025 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wpWU8hZ3"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9B226165
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509793; cv=none; b=L8EXYUft5ZC/1Qekn/VJd3bdRBoyAXLIMHSO3epLladgZ7FATGD0+bNdOiW5dARrtDskM7Sq2pagKqFtIuxP2vOXGtA+JlGTZz6uAPOoCAfDVP9CuXs8fh/+FEK6abJ6fxLC3FOofOo8JaDZ+XidiWaP34BkkhcCEydvUX4Wrlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509793; c=relaxed/simple;
	bh=q/5uQgl9QRgYBR7ahdMseA6XxY7GRQsOpumksRP85aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ac5HOzIS+zQj5ykOSpkBYr/2OWdkm1fB1ajXwIB4veSeb0UiZDRfkZraLA5h21Rruxa1BNA395mOQUck0QEBpJyyWXVfnj/5KcFjLUJm4P031ePdTe9hr60OsHVFoE40LFHnxdtniQNkpfNpkFvUChmF2jT6BG0xUN7RaFBfDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wpWU8hZ3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749509788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ipQfALEF/dBZznaVw0Klj9I7jvOAPbti7+InyzJ+44=;
	b=wpWU8hZ36G9p/4DRgAXIGESz1EZxzTdj//O6Df64GuE54onSIdS0slIj7gKAPNCTbjrS5E
	2KlHWmrflLMQaEGV9qhrhaOUUtKUHOWD1/b0kpDDB9P0Am8exWCDg1FM8+obWe67EKAW5A
	2sbpiDjBNYfA05yQIppOJCGTFdOS1jI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
Date: Mon,  9 Jun 2025 15:56:10 -0700
Message-ID: <20250609225611.3967338-3-shakeel.butt@linux.dev>
In-Reply-To: <20250609225611.3967338-1-shakeel.butt@linux.dev>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To make css_rstat_updated() able to safely run in nmi context, let's
move the rstat update tree creation at the flush side and use per-cpu
lockless lists in struct cgroup_subsys to track the css whose stats are
updated on that cpu.

The struct cgroup_subsys_state now has per-cpu lnode which needs to be
inserted into the corresponding per-cpu lhead of struct cgroup_subsys.
Since we want the insertion to be nmi safe, there can be multiple
inserters on the same cpu for the same lnode. The current llist does not
provide function to protect against the scenario where multiple
inserters can use the same lnode. So, using llist_node() out of the box
is not safe for this scenario.

However we can protect against multiple inserters using the same lnode
by using the fact llist node points to itself when not on the llist and
atomically reset it and select the winner as the single inserter.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/cgroup/rstat.c | 57 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a5608ae2be27..4fabd7973067 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -138,13 +138,15 @@ void _css_rstat_cpu_unlock(struct cgroup_subsys_state *css, int cpu,
  * @css: target cgroup subsystem state
  * @cpu: cpu on which rstat_cpu was updated
  *
- * @css's rstat_cpu on @cpu was updated. Put it on the parent's matching
- * rstat_cpu->updated_children list. See the comment on top of
- * css_rstat_cpu definition for details.
+ * Atomically inserts the css in the ss's llist for the given cpu. This is nmi
+ * safe. The ss's llist will be processed at the flush time to create the update
+ * tree.
  */
 __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	unsigned long flags;
+	struct llist_head *lhead = ss_lhead_cpu(css->ss, cpu);
+	struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
+	struct llist_node *self;
 
 	/*
 	 * Since bpf programs can call this function, prevent access to
@@ -153,19 +155,37 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	if (!css_uses_rstat(css))
 		return;
 
+	lockdep_assert_preemption_disabled();
+
+	/*
+	 * For arch that does not support nmi safe cmpxchg, we ignore the
+	 * requests from nmi context for rstat update llist additions.
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && in_nmi())
+		return;
+
+	/* If already on list return. */
+	if (llist_on_list(&rstatc->lnode))
+		return;
+
 	/*
-	 * Speculative already-on-list test. This may race leading to
-	 * temporary inaccuracies, which is fine.
+	 * Make sure only one insert request can proceed on this cpu for this
+	 * specific lnode and thus this needs to be safe against irqs and nmis.
 	 *
-	 * Because @parent's updated_children is terminated with @parent
-	 * instead of NULL, we can tell whether @css is on the list by
-	 * testing the next pointer for NULL.
+	 * Please note that llist_add() does not protect against multiple
+	 * inserters for the same lnode. We use the fact that lnode points to
+	 * itself when not on a list and then atomically set it to NULL to
+	 * select the single inserter.
 	 */
-	if (data_race(css_rstat_cpu(css, cpu)->updated_next))
+	self = &rstatc->lnode;
+	if (!try_cmpxchg(&(rstatc->lnode.next), &self, NULL))
 		return;
 
-	flags = _css_rstat_cpu_lock(css, cpu, true);
+	llist_add(&rstatc->lnode, lhead);
+}
 
+static void __css_process_update_tree(struct cgroup_subsys_state *css, int cpu)
+{
 	/* put @css and all ancestors on the corresponding updated lists */
 	while (true) {
 		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
@@ -191,8 +211,19 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 
 		css = parent;
 	}
+}
+
+static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
+{
+	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
+	struct llist_node *lnode;
+
+	while ((lnode = llist_del_first_init(lhead))) {
+		struct css_rstat_cpu *rstatc;
 
-	_css_rstat_cpu_unlock(css, cpu, flags, true);
+		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
+		__css_process_update_tree(rstatc->owner, cpu);
+	}
 }
 
 /**
@@ -300,6 +331,8 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 
 	flags = _css_rstat_cpu_lock(root, cpu, false);
 
+	css_process_update_tree(root->ss, cpu);
+
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
 		goto unlock_ret;
-- 
2.47.1


