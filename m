Return-Path: <bpf+bounces-58231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E19BAB74AF
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90677A8B18
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995928C86F;
	Wed, 14 May 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z5+Yysz/"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7481728CF61
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248175; cv=none; b=tvnxChWQkyn038iBt7cN2iRSnU/EGlOno5rNXIAUykSuNI7p8YgjXe+zaraEGXkRZxGFWQ6OBoy38kE+9ZBt8gt4pCwYJ3uU0lZF/wnFa9e7j0Mi1/BPts2SCmnS1WCPoVxp26g5IE3734S9R2D7wctbC+KAb+pgFwdR5yvUagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248175; c=relaxed/simple;
	bh=eOV34W3QxTAg9tNCEM3huHB/nJbyQjF4t6Sq0HwlHdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6lGEtZFBpK4gtZDZGGaWHr7l0dZcMZwtKCZoL43s/g1W+D2Mgb35Ob748QW6wBzTRxe4xMoZpMfh4hcAGNqGVXTUpl7ApxPim5PCxvnsN+Z6lgMXJ3wMnU7YRx+FNS2V2ONmIeBFhDLVqhdVpqgylAp4zqunFgUaysktK/sSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z5+Yysz/; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747248171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4sog0H8PQnyhxh0qyypANz3qKaJTBcH3eV85qDti8s=;
	b=Z5+Yysz/a0FdntBwdRVd8vs8HsgqhcPMP+VKoaKIvnPkLTDX4LkzhvGK1PfZ7VZPIKZMun
	JBNzghWN4lIUeiS04Y8Rcd9V0puEcW7IGz7xPLlH0EmzJODv/2n91JroIJvlIakoJCqSkL
	VAjiedXqXbQZ+nC5FqwmFn+0vYrU1DA=
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
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 7/7] memcg: objcg stock trylock without irq disabling
Date: Wed, 14 May 2025 11:41:58 -0700
Message-ID: <20250514184158.3471331-8-shakeel.butt@linux.dev>
In-Reply-To: <20250514184158.3471331-1-shakeel.butt@linux.dev>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is no need to disable irqs to use objcg per-cpu stock, so let's
just not do that but consume_obj_stock() and refill_obj_stock() will
need to use trylock instead to avoid deadlock against irq. One
consequence of this change is that the charge request from irq context
may take slowpath more often but it should be rare.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 04d756be708b..e17b698f6243 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1882,18 +1882,17 @@ static void drain_local_memcg_stock(struct work_struct *dummy)
 static void drain_local_obj_stock(struct work_struct *dummy)
 {
 	struct obj_stock_pcp *stock;
-	unsigned long flags;
 
 	if (WARN_ONCE(!in_task(), "drain in non-task context"))
 		return;
 
-	local_lock_irqsave(&obj_stock.lock, flags);
+	local_lock(&obj_stock.lock);
 
 	stock = this_cpu_ptr(&obj_stock);
 	drain_obj_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&obj_stock.lock, flags);
+	local_unlock(&obj_stock.lock);
 }
 
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
@@ -2876,10 +2875,10 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			      struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	struct obj_stock_pcp *stock;
-	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&obj_stock.lock, flags);
+	if (!local_trylock(&obj_stock.lock))
+		return ret;
 
 	stock = this_cpu_ptr(&obj_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2890,7 +2889,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
-	local_unlock_irqrestore(&obj_stock.lock, flags);
+	local_unlock(&obj_stock.lock);
 
 	return ret;
 }
@@ -2979,10 +2978,16 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		enum node_stat_item idx)
 {
 	struct obj_stock_pcp *stock;
-	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&obj_stock.lock, flags);
+	if (!local_trylock(&obj_stock.lock)) {
+		if (pgdat)
+			mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
+		nr_pages = nr_bytes >> PAGE_SHIFT;
+		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
+		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
+		goto out;
+	}
 
 	stock = this_cpu_ptr(&obj_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -3004,8 +3009,8 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&obj_stock.lock, flags);
-
+	local_unlock(&obj_stock.lock);
+out:
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
-- 
2.47.1


