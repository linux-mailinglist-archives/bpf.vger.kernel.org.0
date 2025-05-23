Return-Path: <bpf+bounces-58803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 877DEAC1A78
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707A67B783A
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4237229B38;
	Fri, 23 May 2025 03:26:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543C22129A;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970787; cv=none; b=EKL9iWjsFb9Wa7FlrCDWkyQhx61I6TQzizn0UWHbPyzKN0aR3Y2y8It4bH5Y1MnahRjK+kKRWHGIGVttZEGEbFU6sTb74TU8JI5+sjXK2jl+qXk015m3EA03kaVNaUFpEe3d8ROzwzB6gBM0l2zkPmEgj2lXQ6BQsnusfCXM3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970787; c=relaxed/simple;
	bh=2rd10fUytpnKnU502rTnHmJRW6qjn3HdLUwj8HXCC+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D3X0NSf3OlnYbrQos4dokoYUR1mn+enFW2LvdZ657n7bL9C1pDy6jSW/hrNPPWpVax0f4/oiBcKC+qiBpJELtnt0YphgrZyx10jX3StXMwL5+kWXQrps7eh0R5whfTh2AxbBV/SRiH/H2G6rdgcsDrml7iZZjX479/vnzA4LqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-b1-682feadc71ab
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
Subject: [PATCH 07/18] page_pool: use netmem put API in page_pool_return_netmem()
Date: Fri, 23 May 2025 12:25:58 +0900
Message-Id: <20250523032609.16334-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/Z/zPxeXi9MSOxplLSKQ1AyzF7Trp0OfulAfiqiRh7bSZXOu
	TSq8QSRpUhZlUxelzUut1mXTSmotLbrMTGNpTltMyMzKtamtm0v69oPneX7vh5clZU4cx6rU
	WlGjVmTJaQmWfI66mPhuOFm5zGWOBaOlmYamCT1cGbRTYGy8g+D7ZB8DfmcHDZcuBkkwukow
	BCw/SPC1exkYqB/CcO+YjQTvySc0lJWESCiymwnovFNOQeWPOhJsBYMMvG410uBp/kPBkKMM
	w9OqBgwD5Wuh3RQDwWcjCJwWGwHBE9U0nO4y0fChZABB1yMvhguF5QgsbW4KQhNGeu1C4VbD
	W0JoqepnBJM1T7hpThBK3V2kYG08TgvWsVOM8O7NPVp4ci6EhRa7nxDKikdp4ZuvFwtf2npo
	wXKrBwvPTU5G8Fvnb+S2SzIyxSyVTtQkr94tUdr6O3HOYJS+qHcAF6AXklIUyfJcKn/+dzH9
	n5+fHKPCTHNLeLd7kgxzNJfC+70duBRJWJIbpXifMUSEg9ncJt5V08yEGXOL+adtvqkSy0q5
	FfzZa0ennfF80/UH/zyRXBpf4Qn8uyWbqtzt7mXCTp4LMPyNCy3E9CCWf2h24wokNaGIRiRT
	qXXZClVWapLSoFbpk/YcyLaiqd/WH/m5w47GOrc4EMcieZTULklWyiiFLteQ7UA8S8qjpY+H
	kpQyaabCkC9qDuzS5GWJuQ40l8XyOdLlwUOZMm6vQivuF8UcUfM/JdjIuAKkq6rVnl3ZT1Uk
	VEbMsnbP01rT1uxZ5bod3Lx+qfr+59aY8YBn5/q+ba/mk58Ga+OGdWf0vo/VFeNXDKcC29QG
	w2FjRl5hq3fRzJENOdSv+Pyvur1L31fVbpXXDK/ruJoRvKy9xM5bXHTQ89C6T9aa3rci54Zr
	QeL3SmKGp24k/epLOc5VKlISSE2u4i8Skc6O1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRyHe3fenR2Xo+MSO5gQnApLaiZo/KkI7UMeCko/hFIf8pBHt3TT
	NmcaJKaSKV7LLuiUmeY9J1O8NJGY5i1F0xTzOgwlIjSveaVc0bcHnh/Plx9FyMuxK6XSxAha
	DR/JklIsvXY++fTkd0/lmdL+/WAw1ZBQvREH5bZmMRiqGhGsbk5IYKWji4SS4nUCDAMpGNZM
	WwTMdc5KYKZsHkNrahMBs9ndJGSmbBOQ1FwhgvbCHjEMNmaJIW/rDQFNiTYJDL8zkDBd81sM
	89ZMDD35lRhmsnyh0+gC6x9/IOgwNYlgPaOQhGdDRhK+pswgGGqfxVDwKAuBqW1MDNsbBtKX
	5Roqv4i4lvwpCWc067n6Cg8ufWyI4MxVaSRnXn4q4SZHW0mu+9U25lqaV0RcZvICyS3NjWNu
	sW2E5Eq+/RRxpoYRzPUZOyQBTjelF0KFSFWsoPW8GCJVNk0N4mibY1zS+AxORP3SdORAMbQ3
	05e9LLYzSbszY2ObhJ2daS9mZbYLpyMpRdALYmbOsC2yi4N0IDNQVCOxM6aPMz1tc3sjipLR
	PsyL2oR/zSNMdd37vx0H+iyTM71G2lm+N7F8HpfkIKkR7atCzipNrJpXRfoodBHKeI0qTnEn
	Sm1Ge/eVPdzJbUarw/5WRFOIdZSdUHsq5WI+VhevtiKGIlhn2Yd5hVIuC+XjHwjaqNtafaSg
	s6LDFGYPya4ECSFyOpyPESIEIVrQ/rciysE1EfnpE3Y/Xcq4NVrs3e2u7ypQWwKu5z3xt9W1
	11oZ9kB+b+kvG9+16G5i0+4LHm9DRixLqRWvw3YsCu3uiMsNHLacS1ZbJsKDnII967P49MB4
	tmjJ/JJ3PHpP6tb7uHHH7WSBLNjv1OWKc2X6RsfiurtMrKJw9Jjm6mANmvB+zmKdkvfyILQ6
	/g85hwLaugIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Use netmem put API, put_netmem(), instead of put_page() in
page_pool_return_netmem().

While at it, delete #include <linux/mm.h> since the last put_page() in
page_pool.c has been just removed with this patch.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1106d4759fc6..00bd5898a25c 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -20,7 +20,6 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/page-flags.h>
-#include <linux/mm.h> /* for put_page() */
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
@@ -711,7 +710,7 @@ static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 /* Disconnects a page (from a page_pool).  API users can have a need
  * to disconnect a page (from a page_pool), to allow it to be used as
  * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
+ * page-allocator via put_netmem() and then put_page()).
  */
 static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 {
@@ -732,7 +731,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 
 	if (put) {
 		page_pool_clear_pp_info(netmem);
-		put_page(netmem_to_page(netmem));
+		put_netmem(netmem);
 	}
 	/* An optimization would be to call __free_pages(page, pool->p.order)
 	 * knowing page is not part of page-cache (thus avoiding a
-- 
2.17.1


