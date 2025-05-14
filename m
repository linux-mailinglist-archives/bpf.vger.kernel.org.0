Return-Path: <bpf+bounces-58172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2870AB620E
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 07:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A0017D5DA
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 05:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5DA1FFC46;
	Wed, 14 May 2025 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+de8KGJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E101FCFFB
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199345; cv=none; b=uUAo4nVSjKeVWj8mfWqu1SCLFOudBSzZl/O0T0IxM8ETZTUff26jaX8DtCqbeFhbzhALccvu+BVILKC9iryctHfVfym6daWqPz8PqmUca/T+JnhK9/xQrFVum5SViZeGP/5P+UQAFaj6VupI65EVfD3n0Xs4UXPp2uCP3quEXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199345; c=relaxed/simple;
	bh=SEJ3LGQS31qJB107TFfmG+4J9z28S29RJDM8tdnS1nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/Riqy25xdySTy/XkU4bU+LVlRnGdsDlTzr+wheVUQG8Vy7YgDxarcexjUbXJgFuzrHp4vd3NFonFoMuXK5vbtLaVoTLSqYjcwcHYlfb/mJzBe977Er7sKyOjQ+NW0gf3XtHSQPQ3BxxzoMLB7nCIkil5gjLY/I+Pv+iBKKUEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+de8KGJ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747199340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0h+SN0UhJ+eLym9lbXu/RGEYZMj+86zExOIBnbok3mA=;
	b=C+de8KGJN9lp4gQRHrHBI4K2deILhvh8eDjt9b1qW70ETe92jGJ2G5ft+1/TLBJgvvo4Sd
	3pF9fDgCGR+Z/uYwP3bFGBQuZQlsqVAZzIuwh1FO4zcThO9kM6mtyAhaDxufaU23KbGCk/
	DQHrlLHfhbKtrkK0/btvhoPSRjJlSEQ=
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
Subject: [PATCH 6/7] memcg: no stock lock for cpu hot-unplug
Date: Tue, 13 May 2025 22:08:12 -0700
Message-ID: <20250514050813.2526843-7-shakeel.butt@linux.dev>
In-Reply-To: <20250514050813.2526843-1-shakeel.butt@linux.dev>
References: <20250514050813.2526843-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Previously on the cpu hot-unplug, the kernel would call
drain_obj_stock() with objcg local lock. However local lock was not
needed as the stock which was accessed belongs to a dead cpu but we kept
it there to disable irqs as drain_obj_stock() may call
mod_objcg_mlstate() which required irqs disabled. However there is no
need to disable irqs now for mod_objcg_mlstate(), so we can remove the
local lock altogether from cpu hot-unplug path.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4f19fe9de5bf..78a41378b8f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2050,17 +2050,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
-	struct obj_stock_pcp *obj_st;
-	unsigned long flags;
-
-	obj_st = &per_cpu(obj_stock, cpu);
-
-	/* drain_obj_stock requires objstock.lock */
-	local_lock_irqsave(&obj_stock.lock, flags);
-	drain_obj_stock(obj_st);
-	local_unlock_irqrestore(&obj_stock.lock, flags);
-
 	/* no need for the local lock */
+	drain_obj_stock(&per_cpu(obj_stock, cpu));
 	drain_stock_fully(&per_cpu(memcg_stock, cpu));
 
 	return 0;
-- 
2.47.1


