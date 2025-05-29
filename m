Return-Path: <bpf+bounces-59248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE91AC763F
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D611C05A52
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656A025B1F4;
	Thu, 29 May 2025 03:11:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06E250C18;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488273; cv=none; b=i8iV8a4nA/G18l7Bf0OD3pnqgQ5nMBodp8KEItJhJzN2w+/MtvEXBSOM4WtY8ncENh3Zotd5F88PBQuM5q3dMfll2WXQrqRNtRDNoBKq+Hg6OW+uBCyYzbVDkzdb7EtM6+pnQxGZgoiQWfzLyt3oDDEBrCZQhe4ebSCLDqgptkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488273; c=relaxed/simple;
	bh=NybD056fPIwRjjACeccsAsw51OHyvTZyAaLmLap/H0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gTHMOVWVYy19j0yW5MOLzQcnXRynGRaGUKGphllpKDYm77S/wzVllOWTxkUx66qOO5IQfnW9WCblGs4+vqKHy7LBFHAiP+aUqe0LoQFrvWl53rSple8J3GlOBvgz4HmCEZtV74Y7H1FsCzae7eTZiepY5F0rct2nWDil8Ash44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-53-6837d042cfe1
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
Subject: [RFC v3 14/18] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Thu, 29 May 2025 12:10:43 +0900
Message-Id: <20250529031047.7587-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
References: <20250529031047.7587-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0jTcRzF++1/m9PBv2n5z240ysDK0ky/gZX49IMggsCHjGzon7aaF/5e
	0qjwBupKrQxvrZyJNqcxm+J1StOhEyUvYayyNEPrwbQ0r5PMS759OIdzzsMREzIr6SFWRcXx
	QpRCLaclpOSnS+mx4P4A5YmVF/6gNVbTULWYCC9HGynQGuoR/Fn6xMCstYuGstJ5ArR96STM
	GZcJGO8cY2CkYoIEc0YDAWO5Nhqy0x0EpDbqRdBfn0PBk+VyAhqSRxl416yl4Uv1KgUT7dkk
	dBdXkjCSEwSdup0w3zOJwGpsEMH8g2c05A3qaPiWPoJgsGOMhKcpOQiMbXYKHItaOugArqv8
	IMJNxZ8ZrDPF41q9F9bYBwlsMmTR2DTzmMHD7800thU6SNzUOCvC2WlTNP49/pHE021DNDbW
	DZG4V2dl8Kxp30X2siQwglerEnjh+NlrEmXf+HcUU+KU+MiRQiSjRUaDnMQc68cZmjPpLX7e
	Ureh0+xhzm5fItbZjfXhZse6SA2SiAl2iuLGtQ7RuuHK3uC+vu3ZCJPsIa6u9we1zlL2FPc6
	LZ/YLN3PVdW82WCnNT2/Nn8jK1sbK9JY/g/PMVx6i2STd3EWvZ18iKQ6tM2AZKqohEiFSu3n
	rUyKUiV6h0dHmtDatxV3V0Ib0Uz/pXbEipHcRWpDAUoZpUiITYpsR5yYkLtJU8/5K2XSCEXS
	bV6IDhPi1XxsO9otJuXuUt/5WxEy9roijr/J8zG8sOWKxE4eySj0ZKmpv2x7t6bjKD1qZlsZ
	i8VSkKv5daQk84qmQDsXWImHy4V7obwwbewiIguvWoMN7nkhrb5ZyW7LiwMmOnxozx11cFGG
	aCXV+eDqwuR53USI2bMtw9D01/lM+H3KRtUMZLu+ytyhD1vQd+1dviDTWocWRit5nJBxWvCU
	k7FKhY8XIcQq/gGPdbsg1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRe0hTcRQH8H73tetocV2SN62skViClph5wB6mRDcD6Z8ILdSZl7acDzY1
	FQRf4IM0tZC0WRPJfMFszlcuSR06U9IUZaU102aCsSxtqAtKjf77cL58z/nj0Li4gXCj5Ykp
	vDJRqpBQQkIYHpTnEzIeKDtpXT0Gam0LBc3r6fB8rosEdVMHgrWNGQGsGocoqKu146Aeyyfg
	l3YTB+vgvAAs9YsEGAo6cZi/b6KgJN+BQ25XAwYDNcMkjHeUkvBw8xkOndlzAph8qabgU8sf
	Ehb7SwgYrm4kwFIaDIOafWAf+YbAqO3EwH6vhoIHExoKFvItCCYG5gl4nFOKQNtrJsGxrqaC
	JZy+8T3GdVd/FHAaXSrX1uDNFZsncE7XVERxup8VAm522kBxpkcOguvuWsW4kjwbxf2wfiC4
	771TFFe3tIJxWv0UwY1qjIKrzpHCM3G8Qp7GK0+cixHKxqxfUfJTp/RyRw6ejdYFxciJZplT
	7JMe/Y4pxos1mzfwbbswfuzq/BBRjIQ0zthI1qp2YNvBXuYO+/ntCLVtgvFk9aNL5LZFTAD7
	Iq8S/7fUg21ufb1jp615ZVvlTle8dayquI8qQ0IN2tWEXOSJaQlSuSLAVxUvy0iUp/veSkrQ
	oa3/1Wf9Lu9Ca5OX+hFDI8lukQkFysSkNE2VkdCPWBqXuIhyz5+WiUVx0oxMXpkUrUxV8Kp+
	5E4TEldR2HU+Rszclqbw8TyfzCv/pxjt5JaN/G+MXC6c7Wlvn8HSGIiKKD+LF5QxsVEWw7Jr
	j1f+xTcpy9NHyhv314f66+W7OoNCaee69j0XPAbeHfhS6GNrXTneXFSVkpXnmVnkbjg4GrIW
	S4bbTLKwTX20RjHSdtd4xfCqbb3abjdei4gZX1FVdJcdNWM3FyyHImtlfYeXJYRKJvXzxpUq
	6V+O7DX+uwIAAA==
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


