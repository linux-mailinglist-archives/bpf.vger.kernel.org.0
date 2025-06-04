Return-Path: <bpf+bounces-59623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24DACD608
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 04:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D692E17C577
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA8258CC4;
	Wed,  4 Jun 2025 02:53:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74B21507C;
	Wed,  4 Jun 2025 02:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005594; cv=none; b=joEJvAHKtSwTtZvN3wRlSHmTmTfHwhGG2y+XbJwD/PEXm2Qqjf772RoGKpr2LPQKE+wyVd4Tg4GNrQSurR7kENOOah69bo/TmuyRDC4Ih4NXFcFC/fh+Uy5okJDTGUF7vNayJIDn4JgwfZ2dMbN6GrjfxKtymh2Zj3ieT77Vr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005594; c=relaxed/simple;
	bh=NybD056fPIwRjjACeccsAsw51OHyvTZyAaLmLap/H0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Nw7crF/3O3hpXnatOgMPjAxtgT9sceOX1rAr8mKZoyjfdc5kyl7tFGRFSn0DC0rfEBS1NQltgIqPuRmw7N+0B51mHPSgEU1oE1YMMHB2u6oXYPYXMoPEUMkAIKX4wDgr8BEpoDJgrzK56dlOjgtz4Ha9eA/+khpl//axevNS1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-46-683fb50abef6
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
Subject: [RFC v4 14/18] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Wed,  4 Jun 2025 11:52:42 +0900
Message-Id: <20250604025246.61616-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHfXfOzi44OKzbm0biwiQl01J5sDLpQm8QdKMP2Qc9uUNbeWNT
	UyHQspupXanQRbPwNpXZMjfFIs3UMvPWYuUVZVrgpZyJusq84Lcf////+X15xJT8He0mVscm
	8JpYLlrBSGnpmGv+VunLPSr/5nJP0BnLGCidSYaiAYsQdIYqBFOz3SJwNDQx8Cx/mgJdWwYN
	v41zFNgbB0XQXzhMQ+01MwWDt5oZyM5wUnDJUiyA9qocIdyfK6DAnDYggq4aHQN9ZfNCGK7P
	puF9bgkN/Tlh0KhfC9MtowgajGYBTGc9ZuBep56BoYx+BJ1vB2nIS89BYHxtE4JzRseEeZLK
	kq8CUp3bKyJ6UyJ5UexDMm2dFDEZbjDENHlXRHq+1DKk+ZGTJtUWh4BkXx5nyC/7N5pMvLYy
	xFhppclHfYOIOEwbj7Lh0l1KPlqdxGu2hUZKVW32ERT/RJJ8x5lOpaEZUSaSiDEbiIfme+kV
	NlxtQYvMsN7YZpulFnk1G4Adg00LG6mYYseF2K5zChaLVew53Gp+viSiWS/8r9i6JJKxwfjv
	aI5gWeqBSyveLIkkC3nP+MOlXM4G4WzLZ2pRitkxETYW2anlg/W4rthG30YyPXIxILk6NimG
	U0cH+qlSYtXJflFxMSa08NzCi39OW9Bk+4l6xIqRwlVm6QlVyYVckjYlph5hMaVYLfPYshDJ
	lFxKKq+Ji9AkRvPaeuQuphXrZNunLyjl7FkugT/P8/G8ZqUViCVuaejICPfCcbhmwrlJmcZl
	tLe9Kp0LUgXt21mRFeXrj0d9O+qsEVdyI/GaJ0+/ByeHN10/2+p1rKV76kdqTM/uM24pXae0
	feabO8a9ew8NhNS1Kk5aD46Ewc+5D24FuG6/xHkA+RmESs2QH3nQUXncPcRF4GLRcXktmw17
	XT5tKKcUtFbFBfhQGi33H2scw7nYAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0hTcRzH/Z9zdradGhyX1MkelEGImpai8YOFCSKdIiQKuviihzy45ZVN
	xSWCphVJmjcodNJqaXOTpmZuiknN4QVNy0vOMhVr1oOZd9Rl5ozePny+fL8vXxEuNRDeImVq
	Bq9K5ZJlJEVQMfKCIOrVacWJ13opaM0NJJg2suH5jFUAWmMrgtXNz0JYsfeQoH+yjoN2qJCA
	NfMWDs7uWSFM180R0HHXgsPsg14SigtdONyyGjDoqukTwPvWEgFUbtXiYMmbEcJIu5aEqYYd
	AczZignoq6onYLokErp1B2G9fx6B3WzBYP1+DQkVwzoSvhZOIxjumiWgOr8EgbnTIQDXhpaM
	lLEt9RMY21b1RcjqmjPZl4YAtsgxjLPNxnsk27xcLmQnP3aQbO8jF8G2WVcwtrhggWSXnJ8I
	9lfnGMnqfyxirLlljGAHdHbhBc9Y6lQCn6zM4lXHI+IpxZDzO0p/LM4uc+XjeWhDWITEIoYO
	Y4x3+pGbSdqPcTg2cTd70SHMymwPUYQoEU4vCBin1oW5gwP0DeadpWmvTNBHmT+GMcLNEvok
	sz1fgv0b9WFMjW/2hsS7fnLh4Z6X0uFMsXUUL0WUDnkYkZcyNSuFUyaHB6uTFJpUZXbw9bSU
	ZrT7X13u7zIrWh05Y0O0CMn2S6yTEQqpgMtSa1JsiBHhMi+Jj/+ukiRwmpu8Ki1OlZnMq23o
	iIiQHZKcu8LHS+lELoNP4vl0XvU/xURi7zykdA1efPrt8Pz40tozv2ONH1541sdQvnC1ctUk
	XIoONfNRg9fi9+1kUJP+lRA4WLSo96YtPw2cJnH8rTzIfrm7cqqhCeo4csy43lgebdpYTp8I
	VVK+HWdzR7dNA6aoshw9Jq+1B1rk5+Mq9JkeQeh2ju+lsKVprr1aE1sqI9QKLiQAV6m5v1yZ
	1AW7AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The page pool members in struct page cannot be removed unless it's not
allowed to access any of them via struct page.

Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
just wrap page_pool_get_dma_addr_netmem() safely.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/net/page_pool/helpers.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 93f2c31baf9b..387913b6c8bf 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -437,12 +437,7 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
  */
 static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 {
-	dma_addr_t ret = page->dma_addr;
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
-		ret <<= PAGE_SHIFT;
-
-	return ret;
+	return page_pool_get_dma_addr_netmem(page_to_netmem(page));
 }
 
 static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
-- 
2.17.1


