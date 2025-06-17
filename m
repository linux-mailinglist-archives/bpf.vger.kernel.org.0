Return-Path: <bpf+bounces-60843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF5ADDCBA
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 21:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE6F3B256F
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD582E2676;
	Tue, 17 Jun 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ksYBtdU5"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04B25B69B
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190263; cv=none; b=YDzRg6EfRExkbZ07baIlt80sq3A/mlOORFk6kLpFrwtvO0sTcNpalQy3CbmX/ktFY8hK4AvbsgmMFMzlo/lPYDCq+IPvZJldD8x/HdvCYBRjKn4mTGdh9hMil4ytkflz53jgFusc/4GaN5IU9QEHiR+z6jA1AqZN/xQBUHOtnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190263; c=relaxed/simple;
	bh=eBuM4xbsgEv3PiEj2py1DjSDnmzrDvVbqpwBpyR3S1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPp1/DeAAnLljGkuef9N3yiNSUuFOtpppA8D8hdWgSKiQUvf8PMtsyuOul1lU+HOntnHV1l0z4SN89Nh1Hm5eqHYd82kuBJ3Cz3Hxpb780zcaW9EMCzbzWAcaY+IsChesBsIV/E0uGNd0mv86mrfC4TMFy09Yi1fr0kK+12IDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ksYBtdU5; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750190258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RuXBCpwuDEI0gqG4HUctbQ7ZAR2IU1ANbbo6C4hyxvo=;
	b=ksYBtdU5CySMUYVnlyVTTVB+k7YYn0LsOFueTOnAykFrJq8FN4z8nqHvECIwRAEtOW5XEr
	5XxtFhBRhDBWf7WbEo6G0fiCNIk0pncH2ltXaZYwNEhWbcYHtgJxIFqpAtDS6A32etGpnb
	ciR4v0kYykgAkQgA+dpsvu8l69RjB84=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: [PATCH v3 1/4] cgroup: support to enable nmi-safe css_rstat_updated
Date: Tue, 17 Jun 2025 12:57:22 -0700
Message-ID: <20250617195725.1191132-2-shakeel.butt@linux.dev>
In-Reply-To: <20250617195725.1191132-1-shakeel.butt@linux.dev>
References: <20250617195725.1191132-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add necessary infrastructure to enable the nmi-safe execution of
css_rstat_updated(). Currently css_rstat_updated() takes a per-cpu
per-css raw spinlock to add the given css in the per-cpu per-css update
tree. However the kernel can not spin in nmi context, so we need to
remove the spinning on the raw spinlock in css_rstat_updated().

To support lockless css_rstat_updated(), let's add necessary data
structures in the css and ss structures.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/cgroup-defs.h |  4 ++++
 kernel/cgroup/rstat.c       | 23 +++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index cd7f093e34cd..04191d99228c 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -384,6 +384,9 @@ struct css_rstat_cpu {
 	 */
 	struct cgroup_subsys_state *updated_children;
 	struct cgroup_subsys_state *updated_next;	/* NULL if not on the list */
+
+	struct llist_node lnode;		/* lockless list for update */
+	struct cgroup_subsys_state *owner;	/* back pointer */
 };
 
 /*
@@ -822,6 +825,7 @@ struct cgroup_subsys {
 
 	spinlock_t rstat_ss_lock;
 	raw_spinlock_t __percpu *rstat_ss_cpu_lock;
+	struct llist_head __percpu *lhead; /* lockless update list head */
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ce4752ab9e09..bfa6366d2325 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -11,6 +11,7 @@
 
 static DEFINE_SPINLOCK(rstat_base_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
+static DEFINE_PER_CPU(struct llist_head, rstat_backlog_list);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -45,6 +46,13 @@ static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
 	return &rstat_base_lock;
 }
 
+static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
+{
+	if (ss)
+		return per_cpu_ptr(ss->lhead, cpu);
+	return per_cpu_ptr(&rstat_backlog_list, cpu);
+}
+
 static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
 {
 	if (ss)
@@ -456,7 +464,8 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 	for_each_possible_cpu(cpu) {
 		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
-		rstatc->updated_children = css;
+		rstatc->owner = rstatc->updated_children = css;
+		init_llist_node(&rstatc->lnode);
 
 		if (is_self) {
 			struct cgroup_rstat_base_cpu *rstatbc;
@@ -525,9 +534,19 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 	}
 #endif
 
+	if (ss) {
+		ss->lhead = alloc_percpu(struct llist_head);
+		if (!ss->lhead) {
+			free_percpu(ss->rstat_ss_cpu_lock);
+			return -ENOMEM;
+		}
+	}
+
 	spin_lock_init(ss_rstat_lock(ss));
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		raw_spin_lock_init(ss_rstat_cpu_lock(ss, cpu));
+		init_llist_head(ss_lhead_cpu(ss, cpu));
+	}
 
 	return 0;
 }
-- 
2.47.1


