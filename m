Return-Path: <bpf+bounces-58383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D8DAB963E
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 08:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778F91B6652D
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042522ACD6;
	Fri, 16 May 2025 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eUrZE+qT"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A81A5B95
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378200; cv=none; b=YEgFD84HsNlBxGv73ZoJ18NQDfmIGx+MyL7OyjzOkttVlgi62CdH5Ef0F/9LW58GLd1+gP/nkpo4lTSWeA+Egs6nzSTwwnqg9fAJQxoCu5i7dS1wXICVsMQiboF2LuTRcavH1OlAhxxcjN5srQqpuCaChmCbetG5VyhowZ4LXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378200; c=relaxed/simple;
	bh=/T3ZsKT8VNYbD3xOoG59SO/PpCy0LoJnigPxVN5Air4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQccbAEItCkd9F6p8S5qUczZDltq0qzedjGV4Ow6CwcYI4p2OPSuFUB5Ryg7HGlkEh/ju+n8ZupZDXmgS+1WxJIz0WdIttH8feClNUZd5gOx2GPgo6b4cOGYiubeva1HujCQYtII8xydpBDz1SWApo3Xsv0yzwP4cTtPcKigyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eUrZE+qT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747378196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CI0Bp2IqmZG3mdccHhETvzHB03Kjr+cVmvCiU8mxhk8=;
	b=eUrZE+qTBmqtnw5qgpMu5Xy5nqqfp4nL5OQwO/cMx1nhkP5cl2G1N0FzLVHsYX+AHOAX0R
	6r+IDuqrlnNMWzF5B7mNhK+NW7AjBBMC6xFKS6uO7B3olBoUWEoUYgewvnNkpuTfE3GGub
	1Bvoop0NQFZkgT+rvHVR4ZkpVSP33pk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 3/5] memcg: add nmi-safe update for MEMCG_KMEM
Date: Thu, 15 May 2025 23:49:10 -0700
Message-ID: <20250516064912.1515065-4-shakeel.butt@linux.dev>
In-Reply-To: <20250516064912.1515065-1-shakeel.butt@linux.dev>
References: <20250516064912.1515065-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The objcg based kmem charging and uncharging code path needs to update
MEMCG_KMEM appropriately. Let's add support to update MEMCG_KMEM in
nmi-safe way for those code paths.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 102fdec3f49e..899a31e6b087 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2729,6 +2729,23 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 	return objcg;
 }
 
+#ifdef MEMCG_NMI_NEED_ATOMIC
+static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
+{
+	if (likely(!in_nmi())) {
+		mod_memcg_state(memcg, MEMCG_KMEM, val);
+	} else {
+		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		atomic_add(val, &memcg->kmem_stat);
+	}
+}
+#else
+static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
+{
+	mod_memcg_state(memcg, MEMCG_KMEM, val);
+}
+#endif
+
 /*
  * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a objcg
  * @objcg: object cgroup to uncharge
@@ -2741,7 +2758,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+	account_kmem_nmi_safe(memcg, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
 		refill_stock(memcg, nr_pages);
@@ -2769,7 +2786,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
+	account_kmem_nmi_safe(memcg, nr_pages);
 	memcg1_account_kmem(memcg, nr_pages);
 out:
 	css_put(&memcg->css);
-- 
2.47.1


