Return-Path: <bpf+bounces-61488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C0AE75F5
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864D61BC3E6E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 04:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01A1F4C83;
	Wed, 25 Jun 2025 04:34:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C571A238F;
	Wed, 25 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826047; cv=none; b=CwaMX28sGX4+DB2Q3ht8Bk59aOl2GIYb1IcKXFw8IeKtWXuUQ7u028Tgfkjz9gY0wF3tkzqro8peFAgQK3uK9IcsR8s2xT+F52Ov96nhmDv+Jr8ErmPOffRb4m1nKFpgOI/2SI4d9XDFulJbZceF50yng47hZ5sgokbIQp30aX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826047; c=relaxed/simple;
	bh=OX7su+A2+XxOGEYJv11FdVH8w8M7m/9/3b1Kym7xqMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H89miKB9alJLBtO3Y9vHbX2INrTURvqG2n6L2RlkCBq49TsJwSo96X4boHMdCkrDowZG8GoytWXLbzGQa+owYUd8WoiASRfScIdrNppFaaMjh0xuQ8RxuSJ9imnRXw9czDZVsVUjKUpqTGGz/u0F4XBR4YST1SgUIj1lRFs8ijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-1d-685b7c398dd5
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
	vishal.moola@gmail.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	jackmanb@google.com
Subject: [PATCH net-next v7 6/7] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Wed, 25 Jun 2025 13:33:49 +0900
Message-Id: <20250625043350.7939-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250625043350.7939-1-byungchul@sk.com>
References: <20250625043350.7939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG++9/ds5xODguy1MSxigKuxpd3uiCWOD/Q0FgUOQHW3lqKy+1
	pakUWDqilTNKyrZVM6nMKatlbd2k1kpNo1LUleVipRAzu6zMqV12rMhvD8/7PL/3/fCyWFEu
	ncxqsvYI2ixVhpKWUbIPkRVzlu5LVc8v+zYBLPYaGmyDeXDpjUsKluobCL6GuhgIehpoqKwY
	wGB5WkzBN/sQhp5HfgZsjrXgu9hLwZ1DTgz+0kYaSoqHMdwN9TNw0FUlgWc3jFIoG7qAwVn4
	hoG2WxYaumt+SaHXXUJBk+kyBT5jIjyyToSB5j4EHrtTAgNHz9BwotVKw9tiH4LWB34KzAeM
	COz1XikMD4YZ5ofdTOI08qDvIyZ1l19IyE3Ta4ZYHTnkWlU8MXhbMXFUH6aJ48txhrzquEOT
	xvJhitx0BSWkpKifJp97XlLkY307Tex17RRpsXqYdVGbZMvThQxNrqCdt3KzTG3+1CnZZZTl
	uX9CIXrNGlAEy3ML+Xp7PTIgdlQbzetEm+Zm8F5vCIs6mkvgg/4GyoBkLOZqad5T08WIg/Gc
	jnc+bqZETXHT+UBbJRK1PMzRv69j/vDjeNuVe6OgCG4Rb/EXjeYVYqbjAP6Tj+KbTr+jxBtw
	eLH9rEK0cbhadN2Mxb08V8fyAaPtL3MSf7/KSx1DnGlM3fS/bhpTtyJcjRSarNxMlSZj4Vx1
	fpYmb+7W7EwHCv/Lxf0jqS705VmKG3EsUkbK5+s3qRVSVa4uP9ONeBYro+Unl4Qteboqv0DQ
	ZqdpczIEnRvFspQyRr5gYG+6gtuu2iPsFIRdgvbfVMJGTC5E691lO5N8ntm1gdVbbaqebP6I
	YXfbtXspLf3Bq2VHvkdlz0puTOoudm77FSuRJ5Po1LPDKwpifUlNieNyY86xi2NelOo7y+3X
	15imulJCq+5OuQ2z2isCMxassVm2xOvNHwoq0o4+LY37XDoz+fbItjmntpzfMLF92cYdT4yG
	Wz9/PFdSOrUqIR5rdarfs7vEXysDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e//39lxODstqYMRxUiSIlNKfMMQ7UunoPCDdFEiV57aUGds
	ZrMLaV6ikbOr1DZlYWleYrFMp1jINK9lpWiapjLTbqKWF3RathmR3x6e5/c+7/vhpbHUSXxo
	pSqJV6vk8TJKTMQHQtK37rwQrQi4kUuDyVJGQemsFooGbUIwlVQgmJrrFcFkfSMFBfdnMJje
	ZBCYtjgxDDc4RFBq3Q8DhSMEaq5UYnDkNFGQnTGP4fncmAgu2x4JoC6vWQhvK/RCuO18iKEy
	dVAEHdUmCvrLFoUwYs8m0GwoJjCgD4MG82qYaR1FUG+pFMDMtTwKbrWbKRjKGEDQXucgYEzT
	I7C86BbC/Kyrw/iyXxTmy9WNjmOuvLhHwFUZPoo4s/UM9/TRZk7X3Y45a8lVirP+vCni+rpq
	KK7p7jzhqmyTAi47fYzifgx/INz4i06KK/gyIeAs5Z0kQhol3hXLxyuTefW20BixwjjxXnBa
	L9baf0Mq+kjrEE2zzA5Wb4zQIQ+aYjax3d1z2K29mUB20tFIdEhMY+YxxdaX9YrcwSpGw1a2
	tBK3Jowv+72jALm1xNWT+bV8iWGZ9Wzpk9qlIg8miDU50pd4qZvpSsN/+ZVs871PxH0Ddi22
	5EvdNnaNpj8z4utIYlhGGf5ThmWUGeES5K1UJSfIlfFB/po4RYpKqfU/kZhgRa6PKLy4cMOG
	pjr22BFDI5mnJCAzSiEVypM1KQl2xNJY5i3JDXZZklh5yjlenXhMfSae19jRWprI1kj2HeJj
	pMwpeRIfx/OnefW/VEB7+KSiw1nDO6MOnfDy6iRbvplqrPhBeEXvE+az2dA/Sb/JcfjZYotO
	hh6duzJIt++OoXKL5QfbDGWRd4YKDTLpyOuO6Ir8ddq+Rac6snp/uIpfrPUfePU7+BTkZ284
	ouu1e6c4AzKntu8NXXiX9Gv6eJafNrxlytF26ezG8z2eZ7UhK2REo5AHbsZqjfwPwi3TdA0D
	AAA=
X-CFilter-Loop: Reflected

The page pool members in struct page cannot be removed unless it's not
allowed to access any of them via struct page.

Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
just wrap page_pool_get_dma_addr_netmem() safely.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/page_pool/helpers.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 773fc65780b5..db180626be06 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -444,12 +444,7 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
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


