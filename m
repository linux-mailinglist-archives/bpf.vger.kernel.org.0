Return-Path: <bpf+bounces-59070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F73FAC5F87
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D10A4C0B30
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3021B196;
	Wed, 28 May 2025 02:29:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF31F09A5;
	Wed, 28 May 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399371; cv=none; b=JsFPX2vpJ1mgiP+TJeGA0VAhTyVNblSdyZexIwe0EB6YyGkGg9DnOFfu9r7qVBy7AqU5LulqXN+ZeYrT4xgzfOSZPC80q906jwXI9CyO1K1hLbOUM3/P5Ag2cx6A+T0BblI9r6vztlTod0i/Hs8wDQ/Nqu2wPz6pUPXUPnLZcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399371; c=relaxed/simple;
	bh=NybD056fPIwRjjACeccsAsw51OHyvTZyAaLmLap/H0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Sv85tYMExneNOGeMBQ+h8hg3C5pS2xjAmg04r8QC4imZOz3butNwRoVscOxqbVEr24a9fuFnOtqMBJKADV62mJoTPUuzWrHHoI/EMm8tCnI11+jvX57js8z7ztZMi5OBHGZoZD5IsC9s0KJ/XWr64F2bQ6qePER5ZXF4zL8j43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a7-6836750207ab
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
Subject: [PATCH v2 14/16] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Wed, 28 May 2025 11:29:09 +0900
Message-Id: <20250528022911.73453-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250528022911.73453-1-byungchul@sk.com>
References: <20250528022911.73453-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRjHe3fO3h1Ho9OSPClYDUyorCyzB4qSwno/FBRiH+qDDj201bZk
	U1NBMhUq75egsFmzyMu0ZsvLDMlay+5p3lhmLWazD5WSy02dXZzltx+/5//8eeBhKKmNDmaU
	mlReq5GrZFhMi78vrYkQpEUrtngHwkFvasLQOJ0BdZ8sQtAb2xD8nHkvArftKYabNR4K9D35
	NEyZZilwdTtF4Kgdo6HzfDsFztJnGIrzfRTkWuoF0NtWIoRLs7coaM/5JIL++3oMH5v+CGHM
	WkzD86oGGhwlMdBtWAmel98Q2EztAvAUVWOo7DNgGM13IOh77KTh6rkSBKYHdiH4pvU4Zi1p
	aXgnIB1VH0TEYE4j9+rXkwJ7H0XMxouYmCcrRGRkqBOTZ1d8NOmwuAWkOG8ckx+uYZpMPBjE
	xNQySJNXBpuIuM2hh9lj4l3JvEqZzms3704UK3pcX1DK9YCMct85KgdNiwpQAMOxUVy38Re1
	yM57FoGfMRvO2e0zCz6QjeTczqd0ARIzFDsu5Fx630JoBaviWsvvCv1Ms2HcW0//woKEjeYe
	v8kT/itdzTU2P5z3DBMw75+MJPm1lN3OTRSakL+TY6dE3NTEwP8jVnGP6u10GZIY0BIjkio1
	6Wq5UhW1SZGpUWZsSjqtNqP539Zmzx23oMneOCtiGSRbKiHN2xVSoTxdl6m2Io6hZIGS3D3R
	CqkkWZ6ZxWtPJ2jTVLzOikIYWhYk2eo5kyxlT8hT+VM8n8JrF6cCJiA4B2m+dpXffp61oin2
	9XdDCBN4x4aKwsyXj4yWueInhsoCN8Y2Dvc51tnIvsSIzy8mO0IS1K6Ty0MLD8TgV2nnR+Kz
	92un8jbg8eGjdYcuZJTHJVTuPLum9tGy8ZqukIPKEa8paJtkx2jOjYoxd9Pea7HeVm4ODzqq
	f/8ojfd5Q3VfZbROIY9cT2l18r+KbOjt1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRW0iTcRjG/e877HM5+lxSX3aCYQWCmuDkjaysCP8dkKgLo5sc+tWGc8o2
	RQPBI6GmZXoRNnOhea7pNJ2lJmoeSvKEMnM5XWgWoZY2phNMje5+/N7neW5ehpBUkt6MUq3j
	NWq5SkqLSFH4qQw/QUKw4sTLLG/QG+toqHUmQeWMmQJ9TTOC1bUpIaz09NFQ9txBgH4ok4Q/
	xnUC5nrtQrBVzJPQdr+FAPvDfhryMl0EpJurBNBdMkDBcHM+BUXrLwhoSZ0RwtgbPQ3TdZsU
	zHflkTBQXE2CLT8Ueg17wfHxJ4IeY4sAHA9KaCgcNdDwNdOGYLTbTsLTtHwExg4LBS6nng6V
	4qbqSQFuLf4ixAZTAm6s8sU5llECm2qyaWz6/ViIrRNtNO5/4iJxq3lFgPMyFmn8a+4ziZc6
	xmlctrAswMamcRIPGnqE1zxviUKieZUykdcEnIkUKYbmvqH4UvekAlcakYqcwhzkznBsEGdv
	NAu2mWaPcxbLGrHNXmwgt2LvI3OQiCHYRYqb07t2QntYFfe6oIHaZpI9yo04xnYKYjaY6/6U
	Qf0bPcLV1ndueYZx3/LvrVHbWsLKuKVcI3qERAbkVoO8lOrEWLlSJfPXxiiS1cok/6i4WBPa
	el9FykaBGa2OhXUhlkFSDzGulykklDxRmxzbhTiGkHqJ088GKyTiaHnyPV4Td1uToOK1XegA
	Q0r3iS9H8JES9q5cx8fwfDyv+X8VMO7eqYiLijjmuXDuSt3Nzqu6yWmf4vMpmzq7KCh7vaNw
	t7qz9kPWsHUyaJdjSjcSNtDewhYtWp0rpbbOweByQnajfS3kYFws8Wpa2SqUz1+yXJ8IFEfH
	WN45w4jW2fLcixv1P2yz/v1WtzvLHsXPLpz0kR3e79Pg13govGz0bf/ppYDvUlKrkAf6Ehqt
	/C+bozxnugIAAA==
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


