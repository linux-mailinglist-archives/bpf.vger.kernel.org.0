Return-Path: <bpf+bounces-58230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9FDAB74A2
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163A717807A
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46801289808;
	Wed, 14 May 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XsH+sSP2"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9428C5C5
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248172; cv=none; b=PwZ4cd3G/MWDh4gWJU0eX+6vmwlGClvpGNWA52MUtCxTnQmji6vaAwI/HD4wUn1+DxLhNhTYge9kXOsD6EB3Od1SbUTcs7EyQJT7maXM2db4TGj/2rGOYT7xPTQ7EeWO/+8xZF/vjy78+4DYM0etlXOPr6f9AuM0Q6IFh3mgSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248172; c=relaxed/simple;
	bh=F3WEBTPiQLWz9cCb+hjP8Ux7u/ANXbxtzcyn85cfhmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucRNFI+/lsCqWQnL0jNmo9Yp0njpbTCjnXz+5OyhZ08rcmTTmPauoO5XXr1/tkNhe6PbN4RANvnSHKsEu/XteCL/hNIQ3vXs2+lgCZPH5UXh3SLZjZVGjVZfFut3riQgSkQXwIVx+g61FQJTbfUVeYeRfyJguLXKLnTrFObDzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XsH+sSP2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747248167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tl4rUg93LkTokTk1IS4m9ISxrd6enFA07YnhN9En2KU=;
	b=XsH+sSP2IqgV4b7JFzKmne3RJ7B8fs6sll5nB5jaO2ynnf01GgAFSgEyNXGG86e9Z7QQ1C
	xAVYpXslEoie+4agb0gtbili30uXYuaShK5I8zmCyUoS39PXhQWaMMqSpDmDEFLEr7kO7A
	tKA3XPMFfwrhihunQK+imHxFUbmwrx0=
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
Subject: [PATCH v2 6/7] memcg: no stock lock for cpu hot-unplug
Date: Wed, 14 May 2025 11:41:57 -0700
Message-ID: <20250514184158.3471331-7-shakeel.butt@linux.dev>
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
index 1071db0b1df8..04d756be708b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2025,17 +2025,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
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


