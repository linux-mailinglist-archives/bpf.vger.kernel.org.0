Return-Path: <bpf+bounces-58811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9FAC1A9C
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3529540195
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692DB275861;
	Fri, 23 May 2025 03:26:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976722CBD0;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970790; cv=none; b=ODvKtG+BxQoS1jYhA2GRD3NLvJ7Ry9RmZcVmG2P+neHRXQOpaxMc6ayeW90txltRyGW+IDMB7ngGdcxIncJitg5LFb9GPHqFtIhQYrOPb1Gyp6C24d+3lcVtJ50N8Q2qy9FhRvSHqI0V8T2k3RnnuTKH0w0Lkxe78z8+WqaquS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970790; c=relaxed/simple;
	bh=3L2Sd+xZtgizrI7/hZTYQUIdhjVtfvc7DF5TSB/XC6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qy28QPTSXcSAPAfx0uujUI7UlC5gvcw1R/3L6YRTJq8hk/RASKf83uRgjtmhJGcBHOPtglQUdMqKKacKC2Dua+FczIvip50I3tHWNUMsJeqBrtlV1l1+BE3vnICxQZso4TBDucBejF2uZRANIrKyIZPTVdvt9BB8M/ZZlQnt8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0c-682feadc1cb7
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
Subject: [PATCH 16/18] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Fri, 23 May 2025 12:26:07 +0900
Message-Id: <20250523032609.16334-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGe3fevedsNDosqWNBl0EIQjPL5P1gMvqQL30IyQ+BRXnQUxvO
	aZvOqRRLjUhy3SSGTZpdljdYrounVlG60igozeVaeWHmCjMtzeUlKmf17cfzPP/flz9DKX1w
	FaMzFApGA69XITmUf1lav7F/NEG7abaGwg53C8LNMxZ8fUiUYkfTHYC/z76j8ZSvE+Er9ZGF
	xctKiKfdcxQeeRqi8aArDPH9E20UDp3uQri6cp7C5WKDBL+6Y5PimrlrFG6zDtH49T0HwgMt
	v6U43F4N8bPaRogHbRr81LkCR56PAexzt0lw5FQdwud7nAgPVw4C3NMRgvjiMRvA7ocBKZ6f
	cSDNenKr8a2E3K3tp4nTU0RuNsSTqkAPRTxNJxHxTJ6jyfs39xHpss9DcleckpDqinFEvo0E
	IZl46EfEfcsPyQunjyZTnjXpbKY8JUfQ68yCMSE1S6612ydRwSWZxRr2QyuYoauAjOHYJO6F
	1SupAswi/7ZlR2PExnGBwCwV5Rg2kZsKdcIqIGcodlzKjTjmJdFiOavjWjvaFhmyGzjx5ACM
	soJN5oLD4j//Wq75xqNFkWwhPzMwjaKsZLdy3t4gHZVy7DTNed290r8HsdzjhgA8AxROsKQJ
	KHUGcx6v0yeptSUGnUWdnZ/nAQu/dR35uVcEk68y2gHLANVShShP0CqlvNlUktcOOIZSxSie
	hNVapSKHLykVjPkHjEV6wdQOVjNQtVKxOVKco2QP8YVCriAUCMb/rYSRrbKCvE+aq5+8N7vM
	aQ2j5Y7sH7zVvDu+TnO7z6nu69j3eUAp/x67Pbs7dTA1k0i7BYdr3+WPGfkVO/wd9XFPvro/
	m9Xr0s4eTdkTtjdrfrkOfxP9F3L3lh6Hw2UZ+x3oQ9L+E2M7H9i3oFrDslE+7mDZ5OF36duS
	gwWWidYVxVm2XSpo0vKJ8ZTRxP8BsPeBqtcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRe0hTcRwF8H67z80G12V5M6MYPYV8kfGNQrRCLz0k+iMpqBx6cUunsqlo
	EM0X4dBppiE6cyL5hqWJzgcmznzU0poaS01FcWSEmS/UheaC/vtwDpx/Do1JqnEPWhGXyKvi
	ZLFSUoSLwi5knJn84SP3fTHuD3pjAwn1GylQPWMiQF/XgmB1c4KCld5+Eior1jHQD2fisGbc
	wmC+b5aC6So7Dp1PWzGYzRsgITfTgUG6qUYA5rJBAj616Ago3HqFQatmhoKRdj0JUw07BNh7
	cnEYLKnFYVoXBH2GA7D+4SeCXmOrANZzykh4bjWQMJc5jcBqnsWhNE2HwNhlI8CxoSeDpFxz
	7VcB11byjeIMTUncmxovTmuzYlxTXTbJNS0XUNzkl06SGyh24FybaUXA5WYsktzv+XGc+9U1
	RnKV35cEnLF5DOcshl7qputd0cUoPlaRzKt8AiNE8uLiZTKhXJiisY/hGrRBaRFNs8xZdkcX
	qUVCmmROsjbbJua0G+PHrsz241okojFmkWDn9Q6Bs9jHKNhGc+s/48xx1pQ9hTstZs6x43Mm
	ymmWOcLWv+7+NyTczfOn1kinJUwA2zE6TuUjkQHtqUNuirhkpUwRG+CtjpGnxilSvCPjlU1o
	976qx3+emdDqSGgPYmgk3Ss+pfSRSwhZsjpV2YNYGpO6id/ZveUScZQs9RGvin+gSorl1T3o
	EI1L3cVXw/kICRMtS+RjeD6BV/1vBbTQQ4N80064vF0gT9/aeaK97loxVH5neWL14cECa/tt
	W03E+/rP5qSQQoML6tgOTh5zCWnMshzVl97fzKhcqG7OC1ff8zxst1hCSsrLXw4R0UXnVXLZ
	lSXd/iVXs94aMJxFbK+3uVyyFF2+kT7QEKgcDVo6dq3M/aMjWOzv2c2EFYXmSHG1XObnhanU
	sr8WbSCuugIAAA==
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
index aa120f6d519a..bcd0c08fd5b8 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -441,12 +441,7 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
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


