Return-Path: <bpf+bounces-57962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 981ABAB2047
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 01:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CBA1BA33B9
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D9267F68;
	Fri,  9 May 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jO54i0gB"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DC26560A;
	Fri,  9 May 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833399; cv=none; b=IHeZn8q1a27kCRBvwfttnuMZ41qQ3Yzrw4pXc+G9t6ZeDiSljxdEMsIiPNLImb2SED59voLq97XGwjUGDUd2ZUyFh8zkFJWXm5rIdsVk3N5KK9vNMwVJ2PgtgXnQRZRXge6hXzB3izT8KEFRY+Q+OIsyDLK6EhCkKDIHy8rUJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833399; c=relaxed/simple;
	bh=AKyXGOGVKSPuvLYS3bA9GrhLG5FKkEMoHJdXPl0VcwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX9Va3OCSe81DiNFHQVNEPMMj0lIkywXFTMatS5plf3wBPfL3Piz9Kg3GjCj1repNTImqlZXbUnr+GspzGmf+MyvXdkjhHh+kGdEl5ifU/uLL+4myBV1WpWWad4PBvDAvYMDfoJo/tEmdnRTzMuilQ3LIm2hQ2lb8HyPdmnq/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jO54i0gB; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746833394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOY56VtkuEsaEOIjh23t6VcD+q32Hzr2b1NcpUgpvDE=;
	b=jO54i0gBEBaFktQDWRNMuv4pLq+uKpVvOSG8rTGoHARaxg8BKTT6XbD+GIS15P62AwsIgo
	GN6rjfqV9p4hIv4kuKltdlIFtazFX1Sdk5xLUX4DldmlmVbQcCnTMwi4oc6iq5souJ0Adb
	19j4Qj8OvDs/mAh60jbhxHW5ENDLVBw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 4/4] memcg: make objcg charging nmi safe
Date: Fri,  9 May 2025 16:28:59 -0700
Message-ID: <20250509232859.657525-5-shakeel.butt@linux.dev>
In-Reply-To: <20250509232859.657525-1-shakeel.butt@linux.dev>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To enable memcg charged kernel memory allocations from nmi context,
consume_obj_stock() and refill_obj_stock() needs to be nmi safe. With
the simple in_nmi() check, take the slow path of the objcg charging
which handles the charging and memcg stats updates correctly for the nmi
context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bba549c1f18c..6cfa3550f300 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2965,6 +2965,9 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	bool ret = false;
 
+	if (unlikely(in_nmi()))
+		return ret;
+
 	local_lock_irqsave(&obj_stock.lock, flags);
 
 	stock = this_cpu_ptr(&obj_stock);
@@ -3068,6 +3071,15 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
+	if (unlikely(in_nmi())) {
+		if (pgdat)
+			__mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
+		nr_pages = nr_bytes >> PAGE_SHIFT;
+		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
+		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
+		goto out;
+	}
+
 	local_lock_irqsave(&obj_stock.lock, flags);
 
 	stock = this_cpu_ptr(&obj_stock);
@@ -3091,7 +3103,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	}
 
 	local_unlock_irqrestore(&obj_stock.lock, flags);
-
+out:
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
-- 
2.47.1


