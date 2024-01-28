Return-Path: <bpf+bounces-20522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD183F5D5
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 15:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46821F23192
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB642C6AA;
	Sun, 28 Jan 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET1JIOFN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF31DA44;
	Sun, 28 Jan 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451740; cv=none; b=sxl/kP5HMWzgm4sPocfMu2ySTHERxGZ+4HOn1wihVJU+1aIJCX9j3oH3TiJ32uSBul7wzSzaopxF33zYG2lwDjYKZkcmhQnOVVVQfgyZRhiYFYHGoCI1etHoB1J6x12Jym2IA69Xe3yyJlC+Ig49k6vm1UB2zRCYs6/CuGMPV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451740; c=relaxed/simple;
	bh=O+YeuMB8+lN1QWS1jW/X6V/PjZZ4TGDBb2JpTZRa5gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R66q/zU83qHIr/P5Wm/r7YET9o7ku6LFbC7DkMwiewITv8eVEEfeWGecbWFRWTtiCFOxTb0xnTUZGiPJNDt37lS/wJ8lp3RL5cFK3i6mKIabVQluVzsxkQDCJygn8puD2ktcbj/IiBa1sd83QHLLsA379EcgWGXXfiKB/RFKfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET1JIOFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9B3C433C7;
	Sun, 28 Jan 2024 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706451740;
	bh=O+YeuMB8+lN1QWS1jW/X6V/PjZZ4TGDBb2JpTZRa5gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ET1JIOFNNX9QHMD2y4Fe4OHnjLipcrAcXdnpxilURkvl1M8H/0Ac1Ht2F27WxcGN7
	 pQ6mq7twb5h8HmXPyCR1/c4y+v0SfH7zmo0ByK5BVehLEC2D07Hu9KTE8X0EDol457
	 oBFGWrDB8tZuOwXYBx8fRiox+JSth/chM6rey/AaHNMVKyNSqXlLdSkWeZCJIe2fb9
	 dWdwGvX929XimAyFcrVnyFeRZBiNvqeMlXFUDsriwxB0KRg5ifszHoGZbqKPEgLHc0
	 /YRpY13pjfyZbC8nb3jzpjuWGLHKqGjpmTb0g4Yovm03lySQ26vC1ne0vnJqpo6sXp
	 AgynIdg7kTagQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH v6 net-next 4/5] net: page_pool: make stats available just for global pools
Date: Sun, 28 Jan 2024 15:20:40 +0100
Message-ID: <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706451150.git.lorenzo@kernel.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move page_pool stats allocation in page_pool_create routine and get rid
of it for percpu page_pools.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/core/page_pool.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 89c835fcf094..5278ffef6442 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -37,13 +37,15 @@
 #define recycle_stat_inc(pool, __stat)							\
 	do {										\
 		struct page_pool_recycle_stats __percpu *s = pool->recycle_stats;	\
-		this_cpu_inc(s->__stat);						\
+		if (s)									\
+			this_cpu_inc(s->__stat);					\
 	} while (0)
 
 #define recycle_stat_add(pool, __stat, val)						\
 	do {										\
 		struct page_pool_recycle_stats __percpu *s = pool->recycle_stats;	\
-		this_cpu_add(s->__stat, val);						\
+		if (s)									\
+			this_cpu_add(s->__stat, val);					\
 	} while (0)
 
 static const char pp_stats[][ETH_GSTRING_LEN] = {
@@ -79,6 +81,9 @@ bool page_pool_get_stats(const struct page_pool *pool,
 	if (!stats)
 		return false;
 
+	if (!pool->recycle_stats)
+		return false;
+
 	/* The caller is responsible to initialize stats. */
 	stats->alloc_stats.fast += pool->alloc_stats.fast;
 	stats->alloc_stats.slow += pool->alloc_stats.slow;
@@ -218,19 +223,8 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	pool->has_init_callback = !!pool->slow.init_callback;
-
-#ifdef CONFIG_PAGE_POOL_STATS
-	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
-	if (!pool->recycle_stats)
+	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0)
 		return -ENOMEM;
-#endif
-
-	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
-#ifdef CONFIG_PAGE_POOL_STATS
-		free_percpu(pool->recycle_stats);
-#endif
-		return -ENOMEM;
-	}
 
 	atomic_set(&pool->pages_state_release_cnt, 0);
 
@@ -295,7 +289,21 @@ EXPORT_SYMBOL(page_pool_create_percpu);
  */
 struct page_pool *page_pool_create(const struct page_pool_params *params)
 {
-	return page_pool_create_percpu(params, -1);
+	struct page_pool *pool;
+
+	pool = page_pool_create_percpu(params, -1);
+	if (IS_ERR(pool))
+		return pool;
+
+#ifdef CONFIG_PAGE_POOL_STATS
+	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
+	if (!pool->recycle_stats) {
+		page_pool_uninit(pool);
+		kfree(pool);
+		pool = ERR_PTR(-ENOMEM);
+	}
+#endif
+	return pool;
 }
 EXPORT_SYMBOL(page_pool_create);
 
-- 
2.43.0


