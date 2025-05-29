Return-Path: <bpf+bounces-59240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B6AAC7625
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053AD9E249E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A77D25228C;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D1218EBA;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488270; cv=none; b=crnFwS4pDZmE1zUWTkxI0+/0z80dgb6G3lOnvkpweBkcE4QRB/+PYRaAz9VWb6fcVm0vInAEAdSyI7C1clRgC4W28cEUmdPoQTFCQfOYaasLK1dBz6S/dzbXlqJrlPV2h14xI5o0zMzw01nd4IPHQuxfjn+CQaHUbQL1j860YlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488270; c=relaxed/simple;
	bh=O4OVr102+Q9xG83rHoks5YzlZj6BBvsZTeqPS8k64qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=c3AxKjpW3Pw6D+O3rGn3FUexEqK815mVaQ3kdcJ5cqi54tbIqyf3SogPMWtk2wJX38LRnr/mE7qHwwdw1D4UsnKr42S0Kx3GojZ238mkXuUiy/WwUaEm1s+/ACEkL022yP24KBRo5KHYBPGKKdQFmjrt6lepqcmR+i+oEh+aqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e1-6837d041a7a7
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	asml.silence@gmail.com,
	toke@redhat.com,
	tariqt@nvidia.com,
	edumazet@google.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: [RFC v3 03/18] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
Date: Thu, 29 May 2025 12:10:32 +0900
Message-Id: <20250529031047.7587-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGe3fOeXccrY7L7KRgtahIuhmW/yKy+hAv0Q27QBfMkae22lZs
	aTOoTKVyNYsysbVgEtm8wGpWLilNW80ukJjKaqWx0JTK0LWlLitn+e0Hz/P8vjwsJXPRMaxK
	e0TQaRVqOZbQkm/jS+avaUpSLnrkRmCxV2KoGDDArY9OBizl9xH8GPSKwe9yY7hREqTA8jqP
	hoB9iILOZz4xdJR20fDwTDUFvguNGEx5IQpynDYRNN0vYKBw6CYF1dkfxfCmxoKhvfIPA10N
	Jhqem8to6ChYBc+s0RB8+RWBy14tguD56xguN1sxfMrrQND8xEfDtVMFCOy1HgZCAxa8aga5
	W/ZWRB6YP4iJ1ZFBqmzxxOhppoijPB8TR/8lMXnf9hCTxuIQTR44/SJiyu3FpK/zHU2+17Zi
	Yr/bSpNXVpeY+B1xm7mdkhXpglqVKegWrkyTKG3FUw47Iw05PW9xNqqbYEQRLM8l8k+739Fj
	3B2wUWHG3Bze4xkc5Sgugff73CMdCUtxvQzfaQmJwsEkLpVvrGtHYaa5Wfy9wRocZumIyO2p
	/S+dxlfcfjwqiuCW8EVVRaNb2UjnqrEeh6U8FxDz7pJc0b/BVL7e5qEvIqkVjStHMpU2U6NQ
	qRMXKLO0KsOCvYc0DjTybenxX7ucqL9pSwPiWCQfL21ESUoZo8jUZ2kaEM9S8ihpTvJSpUya
	rsg6JugO7dFlqAV9A4plafkU6eLg0XQZt19xRDgoCIcF3VgqYiNispH5555Y7+9ijT/l7MIN
	6+bu2JjSfe77Fc0L85cWvezN/DOhR8H1hh7N9O3zCmfHndBmpMbOmdiyMtgk3bT6s9yxdubJ
	GuJqmRDtTRtOXhbbxmw78NLWVthqajdn4PjTqcMkMqpo6778K8f7jIsDifXDd/Jn5PWKln/e
	zcRFpnrHaSfLab1SkRBP6fSKv3roE0bXAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnc3V6jhHHu2DMQtJyAu0/EVi1gf9K2R9iW6Ujjy45Zyy
	qU1B8EooamomppMmks4LTabpFNNS09nFRDNmmtpiphFqecEbmRp9e+B93+fLyydENaQrX6GK
	Z9UqmVJCCUhB2NmMk+eH/OQ+dpsP6IwNFNSvaaFm2swFXV0LguX1cR4s9fZTUFW5SoDuQyYJ
	K8YNAux9Nh5MVc+Q0HG/lQDbAwsFeZmbBKSbDRzoqRjgwlBLPheKN54S0Jo6zYORdh0Fkw3b
	XJjpziNhoKyWhKn8QOjTH4bVtz8R9BpbObCaW0HBw2E9Bd8ypxAM99hIKE/LR2DstHJhc01H
	BUpwc+0YB7eVfeFhvSkBNxk8cY51mMCmumwKm34X8fDEpw4KW0o3SdxmXuLgvIx5Cv+yfybx
	QucohatmFznY2DxK4nf6Xt5lxxsC/0hWqUhk1d4BEQK5odQ5zuyoTZ8bo1JR18Ec5MBn6FPM
	7IqB2GWK9mCs1vU9FtO+zJKtn8xBAj5Bz3MZu26Tsxs40bcZS9ck2mWSPs48X2+ndlm4I+q3
	dpL/pG5MfePLPZEDLWVKmkr2tqKdzuOcV1QBEujRvjokVqgSY2QKpdRLEy1PUim0XndiY0xo
	577qlK1CM1oeCe5GNB9JDggtyE8u4soSNUkx3YjhExKxMP3cablIGClLSmbVseHqBCWr6UZH
	+KTEWRh6lY0Q0VGyeDaaZeNY9f+Uw3dwTUUm3T7v+lulBU/0Lmtn3md9vWePmCsOEydf0wYP
	lrTl1sQpn93cEi+9rvWIKhrjdQkCpCG9hWNv0n40zl+5XjkR8OKu/9GtpkE/aVY8aii/sD83
	5dClE0WGi9ISbDz2pzLEy0VLTEc9Gnd32w5aqF9fjP7+sSMjdKonO8hdHe4kVEhIjVzm60mo
	NbK/uD5MDboCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Use netmem alloc/put APIs instead of page alloc/put APIs and make it
return netmem_ref instead of struct page * in
__page_pool_alloc_page_order().

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/page_pool.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 974f3eef2efa..e101c39d65c7 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,29 +518,29 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 	return false;
 }
 
-static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
-						 gfp_t gfp)
+static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
+					       gfp_t gfp)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	gfp |= __GFP_COMP;
-	page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
-	if (unlikely(!page))
-		return NULL;
+	netmem = alloc_netmems_node(pool->p.nid, gfp, pool->p.order);
+	if (unlikely(!netmem))
+		return 0;
 
-	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
-		put_page(page);
-		return NULL;
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
+		put_netmem(netmem);
+		return 0;
 	}
 
 	alloc_stat_inc(pool, slow_high_order);
-	page_pool_set_pp_info(pool, page_to_netmem(page));
+	page_pool_set_pp_info(pool, netmem);
 
 	/* Track how many pages are held 'in-flight' */
 	pool->pages_state_hold_cnt++;
-	trace_page_pool_state_hold(pool, page_to_netmem(page),
+	trace_page_pool_state_hold(pool, netmem,
 				   pool->pages_state_hold_cnt);
-	return page;
+	return netmem;
 }
 
 /* slow path */
@@ -555,7 +555,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
+		return __page_pool_alloc_page_order(pool, gfp);
 
 	/* Unnecessary as alloc cache is empty, but guarantees zero count */
 	if (unlikely(pool->alloc.count > 0))
-- 
2.17.1


