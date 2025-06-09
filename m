Return-Path: <bpf+bounces-60036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78AAD17FF
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4763AC7A6
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB7E284B4A;
	Mon,  9 Jun 2025 04:32:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D6027FD7D;
	Mon,  9 Jun 2025 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443565; cv=none; b=NZf9J0H8LIKnChYB0zWAvANRSIc7PJoGhfWa/vEjEvDXyCwPnZuU1CMhEg7y0IQUhOHXaHTxnZPaE1JCwNk+QbmsrP64bp3qsx88LO3DY6d+/V/l955/6ewvxQjKpf8VfucbJgluLTWhctCk/VqXnMaIK3kiP4zVq7OSJ7eQgRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443565; c=relaxed/simple;
	bh=hvhefW5aoQ5VsS9tMRkwS2v29al0s6YzPpQyZayU4RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mw9TVb1Dj9J+Ijdk9C6Kt6J2APkvjjoFt59BjzGJBbEE1wNppupoocH2qPH5SQ0rS5zI15EWQtPN5fou5m5T5xa7698qJo1xRqPlyrMrtvPeccgNS43BW/pyKF7oalB7foEsLca13B7wkH0znfGMNahiu78HyadjZQ4CP74JdmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8f-684663e4e1a1
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
Subject: [PATCH net-next 7/9] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
Date: Mon,  9 Jun 2025 13:32:23 +0900
Message-Id: <20250609043225.77229-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
References: <20250609043225.77229-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGefe+57Ll4rSsjgZdRiEI2gWLPxFRRPUWUVEfIoNy6cGtptm8
	NKXI0rK8FRVUa9akMlNzOs1pSeSSvFWK19lN8fZBUklN0kW1g0R9e3j+v+d5vvx5rLnC+POG
	6DjJFK0zalkVUY345AYNhG/Xr7Y1zgWrvYiFwh9meNxbyYC1oALB5PRHDiZq61h4kDuFwdqc
	SuC7fQbD4Js+DnryhghUpzkx9F2tZyEr1YPhQmW+Aloqshm4OfMIgzO5l4O251YWvhT9ZmDI
	lUWgwfKEQE/2ZnhjWwhTTV8R1NqdCpjKzGHhRquNhf7UHgStr/sI3D2fjcD+0s2A54eV3byc
	lj/pVtAqy2eO2hzxtCw/kKa7WzF1FFxhqWP8Okc/dVaztP62h9CqygkFzUoZZem3wQ+Ejr3s
	YKm9vIPQt7Zajk44luwTQlUbIySjIUEyrdoUptKPO88rYrJV5pJiD5eMPvPpSMmLQoh433mP
	/NXvJws4WbNCgOh2T2NZ+wprxIm+Oi+j4rEwyoiDVo8iHfH8fCFGTHunkBkirBTb29IYWauF
	dWKWc5Sb7VwqFpa8wjKuFNaLve442dZ4EVd7Pp7F54kNdwaIjGDvrP2eRraxN5ny7C6WV0Uh
	hxdThl+j2Uo/sSbfTa4hwfJf3PIvbvkvbkO4AGkM0QlROoMxJFifGG0wB4efjHIg74Pknf15
	uBKNtxxwIYFHWh912K1teg2jS4hNjHIhkcdaX7XQs1WvUUfoEpMk08mjpnijFOtCi3miXaRe
	O3U6QiNE6uKkE5IUI5n+XhW80j8Z3SjdW/7+nafx5/EQ40MavJcLUm5nzLbqVbt9XvjQp8N1
	gSOhuw7m2torqvs3pJLSwi9dATssK3/FnNmys/NiV1Gmue3yns7u+29vNh0baj41mtFUc+lB
	2UzkghU5GfyRuDG//oyuOb2HPp74RhqX96/IVCadQ0FlxRsq2pep59r3Yy2J1evWBGJTrO4P
	nGIdbhwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se0hTcRQHcH73d1+OBrdldTFCmkUgZQlZhyyRQrv4x+q/IIkcemmjTdc2
	xQXia2SaWmlhzVkr05xKEyunUhLT1PXGaayHzuaDoFiZJuqCckjkf1/O+Zxz/jksln0jI1h1
	plHUZyo1clpCShTxxTsn05NVu6tKEVgdrTS0LOTCvfFOCqzNHQjmFj8yMNs3QEP97XkM1jdm
	En45ljBM9fsZ8DVOk/C4xInBf2mQhgpzEENRZxMBvXVuCt52VFJwdakBg7NgnAFPt5WGsdY/
	FEy7KkhwW+wk+CoTod+2AeZffEPQ53ASMF9eR0P1kI2GCbMPwVCvn4TawkoEjh4vBcEFK50o
	Fx7a3xNCl2WUEWzt2cKDpmihzDuEhfbmUlpo/1nFCJ/ePaaFwetBUujqnCWEiuIALcxMfSCF
	7z0jtFD/5QchOB6OkMJLWx9zbO0JyYEMUaPOEfW7EtIkqp/OQkJXKcltux9kCtAoW4bCWJ7b
	w7+ea2ZCmea2817vIg7lcC6Wn/UPkGVIwmIuQPFT1iBRhlh2HafjS14RIUNy2/hhTwkVylIu
	jq9wBpiVnZF8S9tTHOJh3F5+3GsMlWXLxDXchFf4Wt59Y5IMEbx81nFTFirj5cniR7X4MpJa
	VinLf2VZpWwIN6NwdWaOVqnWxMUYzqhMmercmPQsbTta/oHGvN9XOtGc54gLcSySr5Gm1SSp
	ZJQyx2DSuhDPYnm4lPMdVsmkGUrTOVGfdUqfrRENLrSJJeUbpSnHxTQZd1ppFM+Iok7U/+sS
	bFhEARr8rKHajFPl9vMs52Gepfrc6+92mU1VyVtORm6WLETVHLugSTTRnuiWFFSdMFPNPlpo
	0rpKz87UHhSL8u6cbKiD/h/xin2K0qPa9PoorQ7Nu2/lZ2jzklJb7dfM0d3EweD+LPbrE+WO
	sQj/UmAiPF+R5rW/ed7TUb314qGXctKgUsZGY71B+RdVujwW/wIAAA==
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


