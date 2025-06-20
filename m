Return-Path: <bpf+bounces-61151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B71AE123B
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070C44A4539
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3C62222BF;
	Fri, 20 Jun 2025 04:12:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C11FDA94;
	Fri, 20 Jun 2025 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392761; cv=none; b=lNX8ikdtZlOsLNP+Ixs4QUEY0TJxgLhnOzPtkrs0+XMDMrraONamE7XUiW69RBS32hGTUbNg90bKPqayKLiL0mmGfqV3h3wXXkiG9h7oOplt4kVsYcGYD/gH3GnpgfyfWWEYQ5OoRlsmuR4v0WA3bBoLtMdmcWbmxAuVwq6DljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392761; c=relaxed/simple;
	bh=OX7su+A2+XxOGEYJv11FdVH8w8M7m/9/3b1Kym7xqMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYjK3PNNPyZKLuYYnIO5xh1kYaKWQ3yJiGMYfEmM/eC6QYBPTgH56KNs3UBCDzkz5mFEFKc6hOzc/VZRWnt8v36lY9fxNfAiWaQ1Fitu1cKA1AfhykF/txwJwBdFDaFO4iHWOOaG7YTajjI2aIRwA4kwFW6onQUg3cio4PcNczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-97-6854dfb383b2
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
Subject: [PATCH net-next v6 7/9] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Fri, 20 Jun 2025 13:12:22 +0900
Message-Id: <20250620041224.46646-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250620041224.46646-1-byungchul@sk.com>
References: <20250620041224.46646-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe/eenXO2XJxm1Ek/COtGdwuLJ4joU50PFYVBUHQ55aENtymb
	rhlEpoPI8rIuYNuq1SqXGpO1dGZJzZUTjczSlmtOtILANLNMnV02Jerbn+f5/37Pl4fG8nJx
	Eq3S5gg6La9WkFJC+jnh+sp7kd3K1HP+WWBzVZNQNWaEil6vGGyVtQi+jYcoGPE3k+C4PorB
	9sJEwHfXBIYPz/ooqHJvh8jtjwQ8PF2Hoa80QEKxKYrh0fggBQVepwjaa0vEcHHiFoa6/F4K
	Xj2wkdBT/VsMH33FBLRY7hAQKdkMz+xzYbR1AIHfVSeC0XNXSLjQYSeh3xRB0NHUR4D1VAkC
	V2NQDNGxmMP6tIfavJBrGhjCnOfOWxFXbwlTnN2dy91zLuOKgh2Yc1eeITn31/MU967rIckF
	yqMEV+8dEXHFhYMkN/yhm+CGGjtJzuXpJLg2u5/aOXuvdGOGoFYZBN3qTYekSuuXN6LsEqnR
	9wvyUZguQhKaZdJYm6uN/JvPNjlRPJPMEjYYHMfxPIdZw470NRNFSEpj5i7J+qtDVBGi6URG
	z5o+TbEEs4htD7WI4lnGrGO7BxvQtDOFrap5POWRMOvZ4YKGqb481hm7YRJP92ezLZffE3El
	jt11XZXHxziGFt634vhZlvHQ7I9oOZ52zmefOINEGWIs/+GWf7jlP9yOcCWSq7QGDa9Sp61S
	5mlVxlVHsjRuFPuX2ycm93nR1/Z0H2JopEiQeb+lK+Vi3qDP0/gQS2PFHJkjsEMpl2XweccF
	XdZBXa5a0PtQMk0o5snWjh7LkDNH+RwhUxCyBd3frYiWJOWjFM82yVXJgQWHM2tOnt1DpS8O
	h2rw8qWFM7Y0a7rNFdvaKm5MtqS6bypI7UIq19y0wi7fmjxQcMn48nur9nXZT7w/Yg4Y8p47
	AgeubTDnDNnTQ4qjHjNfqu5NzniRUjhQK3Xy2TMnG4+z87qywgmOjbsSulr3k4lrKUe/Ndyt
	IPRKfs0yrNPzfwD/hsCVKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRiH+++cnXMcrk5r1EExcSGBoDXK8UJRfetgJFJKdNVTHdryVpuZ
	BtHSQeRlXQnbZkxnNS+xmKYzTWKabkVkk8y0OVkZFeUlTVxatiVR33687/M+75cfhUkCeASl
	ysnj1TlclowQ4aLkTcXxjb5U5XprKphsDQTUzxbA3RGHEEx1zQimA0MkTHX1EGCpmsHA9EKH
	w3fbDwxGu/0k1Nt3gu/OBxzaL7Rg4L/kIqBcN4fBo8AYCUUOqwA6K91C6G3WC+H6j9sYtGhH
	SOh7aCJguGFBCB+c5Ti4DbU4+PTboNu8EmaefUHQZWsRwExZJQHXPGYC3ul8CDydfhyM5/UI
	bB0DQpibDTqMT4bJbbFs55dxjG2qfSNgWw1ekjXbT7GN1ji2ZMCDsfa6iwRr/3aVZN/2txOs
	q2IOZ1sdUwK2vHiMYCdHB3F2vOMVwVo+TghYW9MrPEWyT7T5KJ+lyufV67ZkiJTGideCE3pR
	gfMXaJGXKkFhFENvZEo7rSiUCXotMzAQwEJZSsuZKX8PXoJEFEbfI5iuhiGyBFHUClrD6D4R
	IQanY5neIbcglMV0IjM41oYWndFM/f3HfzxhtIKZLGr7w0uCzGy1TrjIL2fcN9/jISUW/Gu7
	JQmNseBp8QMjdhmJDf9Rhn+U4T/KjLA6JFXl5GdzqqzEBE2msjBHVZBwJDfbjoKFuHN2/ooD
	TfdtdyKaQrJwsWN6t1Ii5PI1hdlOxFCYTCq2uJKVEvFRrvAMr85NV5/K4jVOFEnhslXipD18
	hoQ+xuXxmTx/glf/3QqosAgtqrBWpwe+LZtfsqD3y0+nkVGRSdKYg77C+LSvUdTHNfjwp9Yj
	uc8+J3dxkSc9Nc/lW59PSFxxW+b61tZsdStSUemNtA0R+/u9o9qY1T9HdE9Ld/SanIcijw9O
	Hj6TfSDl667KPO/ZTO7c9rG9ioToA2WKQd5WdU9zcWl4ntFbZHkpwzVKTh6HqTXcb4JAdcIM
	AwAA
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


