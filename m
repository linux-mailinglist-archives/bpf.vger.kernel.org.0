Return-Path: <bpf+bounces-58093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF1AB4A08
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 05:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EB419E8615
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F81E5210;
	Tue, 13 May 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VHLI3S18"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289C1DFD86
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106092; cv=none; b=SdCz9YNnOwojntg8IIXHhaV1IeH49Zrp6xCQ4xY8N209yRGgmXRt2Cy3cZRoMWVzibjaMxDrLaoH3ZttDfEYHv7LxL97ki8iDgPf4hN72KMbyoVty5Tr64zOX/NSKPKrrwWdUpYJ62vcOFbNFzjBlVrPhGSn530hhDJrCBFmGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106092; c=relaxed/simple;
	bh=bq4n+CapkiEufHmuXYXMnRfxZsa90fHutL5r54oLDFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBsTpzVLXRCo20nD2ndkOSD2V3c6FuNjDgVTCoNpxiX/ruAtrYeoyKbKbN1YSbcyHoVDZudjn4nSdODXUHqAecy3KDB0/yDDZAkyjMxRsdX/17lMxWvMF+liWrNgfphUq5JediKVWH91edho+5aQtBwHCgOvKNIt7az0ye5Re8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VHLI3S18; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747106089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FByBL+Uk6nVPajbs5jWaOtV9bA6rKUCuGTge/ypRKI4=;
	b=VHLI3S18C0ilRJtHPuy5DdQfm7qGScWd+9hI+WlIJvZueihhycJEFqGZU2rpRElPW0R7dG
	eRrrEvnQdBtAUsWD0dya+31904+ICeO+NjH2WCcHY18grx/0I+CEACOvkXQojrVYoAv2gN
	mjw9+y9HBGPc9spYYkZCsrqOavp9eyE=
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
Subject: [RFC PATCH 7/7] memcg: no stock lock for cpu hot-unplug
Date: Mon, 12 May 2025 20:13:16 -0700
Message-ID: <20250513031316.2147548-8-shakeel.butt@linux.dev>
In-Reply-To: <20250513031316.2147548-1-shakeel.butt@linux.dev>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
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
neede as the stock which was accessed belongs to a dead cpu but we kept
it there to disable irqs as drain_obj_stock() may call
mod_objcg_mlstate() which required irqs disabled. However there is no
need to disable irqs now for mod_objcg_mlstate(), so we can remove the
lcoal lock altogether from cpu hot-unplug path.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af7df675d733..539cd76e1492 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2060,16 +2060,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
-	struct obj_stock_pcp *obj_st;
-
-	obj_st = &per_cpu(obj_stock, cpu);
-
-	/* drain_obj_stock requires objstock.lock */
-	local_lock(&obj_stock.lock);
-	drain_obj_stock(obj_st);
-	local_unlock(&obj_stock.lock);
-
 	/* no need for the local lock */
+	drain_obj_stock(&per_cpu(obj_stock, cpu));
 	drain_stock_fully(&per_cpu(memcg_stock, cpu));
 
 	return 0;
-- 
2.47.1


