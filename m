Return-Path: <bpf+bounces-60846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C566DADDCC6
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 21:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F197E3BB75F
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD782EE982;
	Tue, 17 Jun 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9ibs7Iv"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867022E3AEF
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190283; cv=none; b=DDEejO8JUjoUzO6GUx2JgoPUh0tXH2FoDk8pv3LjjzwAILInueNKSo9TmYM2kJV2UcQcCSpiuKjOmlChJR3Gg+khNojsTkWniywaUJNum1jfo1bdRkdUhefrrfadsiol/L27ynWpgwl0c2OGVZaTUguYNqPwTFV7QtmYnE3uoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190283; c=relaxed/simple;
	bh=oXikNS+kgN+2w3qPcZgZY0QITtEf/BerEbAt8eoZsE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKlnGblGoU0eOF3sgm1hl2TUMrVG3mfho6UVnZOUtJI+dzfsAcqiu7/73dJYYeosi4wHpRfpC3U8lVXixsRs6INdAtiWAQHViVAIXzapuVNp6v3w4XlLrqpo8kitalJPCNmbq4v/1EEhlGJQ16Ig+I5IhaysseSV1j4oCucIJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9ibs7Iv; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750190279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffjH9W3JevRTfPRrE/1Jq8fYf5w4/j5rXWB6dZVk6cA=;
	b=I9ibs7Iv16R19VtNHI3r16YWM+R6GMUxfrW9o3AoqGOnyIw7QNWgzHjiBF2OouseZBhI/b
	cFmoHTCP6F93DIuqWY3swCmM87/IRdkwPldjOW/Ma7hF8p7K1v2rU1Sd61zsYFxxAIm0nW
	heZJLdNjUGJa8lzobV+R8sh6gXchSE8=
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
Subject: [PATCH v3 4/4] memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
Date: Tue, 17 Jun 2025 12:57:25 -0700
Message-ID: <20250617195725.1191132-5-shakeel.butt@linux.dev>
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

css_rstat_updated() is nmi safe, so there is no need to avoid it in
in_nmi(), so remove the check.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 902da8a9c643..d122bfe33e98 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -573,9 +573,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
 	if (!val)
 		return;
 
-	/* TODO: add to cgroup update tree once it is nmi-safe. */
-	if (!in_nmi())
-		css_rstat_updated(&memcg->css, cpu);
+	css_rstat_updated(&memcg->css, cpu);
 	statc_pcpu = memcg->vmstats_percpu;
 	for (; statc_pcpu; statc_pcpu = statc->parent_pcpu) {
 		statc = this_cpu_ptr(statc_pcpu);
@@ -2530,7 +2528,8 @@ static inline void account_slab_nmi_safe(struct mem_cgroup *memcg,
 	} else {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
 
-		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		/* preemption is disabled in_nmi(). */
+		css_rstat_updated(&memcg->css, smp_processor_id());
 		if (idx == NR_SLAB_RECLAIMABLE_B)
 			atomic_add(nr, &pn->slab_reclaimable);
 		else
@@ -2753,7 +2752,8 @@ static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
 	if (likely(!in_nmi())) {
 		mod_memcg_state(memcg, MEMCG_KMEM, val);
 	} else {
-		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		/* preemption is disabled in_nmi(). */
+		css_rstat_updated(&memcg->css, smp_processor_id());
 		atomic_add(val, &memcg->kmem_stat);
 	}
 }
-- 
2.47.1


