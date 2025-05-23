Return-Path: <bpf+bounces-58805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9199AAC1A7F
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 05:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30807BA21B
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 03:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A324DCF6;
	Fri, 23 May 2025 03:26:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C9221712;
	Fri, 23 May 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970787; cv=none; b=YpZY6l3ZsMoNK3NEBCjqac/QDxNgSYEKejn33mogQjD9bTEu1yg6PcPvrbdo3SjAPpI9XQK+DJYQtfb3TEjWYfW/PewTzwC0Xx/OqerLcXwXY/zl06np5kVvMCooMynnmFMgb54ZYP+Vt1niNEvSMrTPUhemn4yE8SB8PIyZOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970787; c=relaxed/simple;
	bh=LYjtRJWbnb2SMqSZQglLReuXm4WbuSlnvqUof5UfcMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zvvxqz5Ep/VoyAzDvm2R7i/18vOqqvW14hctRfL9boyDiw8UBr8ucUeJLVT8huLI+W93HGRfCpr38Rp9roSH4Kq7zFUhWD2Q9MHpgkM39J68LhnY3WNbpJMISG/Jv+a+yU9VwZI8aNFUuXotlwXJOgSk83HlheL+v/W7q25FEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-89-682feadb9103
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
Subject: [PATCH 03/18] page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
Date: Fri, 23 May 2025 12:25:54 +0900
Message-Id: <20250523032609.16334-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523032609.16334-1-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/e+cnTOXk8MadTIom0UhOfNSvEEX0S8H+pCV9KGoHHlow23a
	vOSKaObMsmZifTCbONHM+2ounTXMzFsUJN6Yl5zNNC0z8jLUSeUsv/14nvf5fXl5mLAN9+PJ
	VcmsWiVViAk+zv/hUxw0/C1Yti9b7w0GUzUBVYtp8HTUygVDZT2C+aUhEuZaOwgoKXZhYPio
	w2HBtIzBeLuTBEfZBA62rAYMnPc7CdDr3BjctJZzoKs+hwsPl59g0KAdJaHnpYGAkeo/XJho
	0ePwrqACB0dOBLQbN4Hr/TSCVlMDB1z3Cgl40G0kYEznQND91onD4/QcBKYmOxfciwYiYgdj
	qRjgMI0Fn0jGaE5h6soDmWx7N8aYK+8QjHk2j2SG+20E05nvxplG6xyH0WfMEMyv8UGc+dnU
	RzAmSx/OfDC2ksyceVs0dYZ/KI5VyFNZdfCRWL6sNDOfSJyi0tJtXwktyvDNRt48mgqnl343
	EOvcN+TGPUxQu2m7fQnzsIgKoeecHas5n4dRM1x63ODmeIqN1Dl6yp6zNsapXfSKu4TrYQG1
	n86cnP0v3U5XPWteE3lTB+jckYW1XLh686p3kPRIaWqBpHWlteS/wRb6Tbkdz0UCI/KqREK5
	KlUplSvCJTKNSp4muZigNKPV55ZdXzlrRbNdp1oQxUNiH4GVHywTcqWpSRplC6J5mFgkaJuQ
	yISCOKnmKqtOuKBOUbBJLWgrDxdvFoS6rsQJqUvSZDaeZRNZ9XrL4Xn7adFd/7DJ5+2LL04H
	HLTZipS938OE7Yox36iY5h7Ol9bB2qKdtZEhzTpZvb/m2A2X6HKFeWovXx86IOmqu32cnp/e
	Ex8zLrJEkUf7YKAmupK/HJB3K+ukV0SN9nystODRZ9bPEakIyt0gc554HYviTZbCw9ccVf1K
	7pB7obQ3a1qMJ8mkIYGYOkn6FymUZqPYAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyGOztn/83R6rhED3aDRWRKmqX1i0JECg9JFn3IECyHntrQTd1U
	NBG8IkpbalpikxYz77AwL1OHxTSvgeWN6Upt5tIom1fUSeWMvj0878v75eXighrCnSuRJTJy
	mShWiHgEL/Ri9inzdx/x6ac2ALWuAUH9RgpUz+jZoK5rwWB108yBle5eBNoX6zioh3IIWNNt
	4TDXY+HAdJWVAENeKw6WR30IlDl2HLL0NSzoquhnw4cWFRtKtl7i0Joxw4GRdjWCqYY/bLAa
	lQT0l9cSMK0KhB6NK6wP/sCgW9fKgvWHFQgeD2sQzOZMYzDcZSHgWaYKA12niQ32DTUKFNJN
	tRMsuq38M4fWNCbRr2s86QLTME431uUjunG5mEN/Gjcguq/MTtBt+hUWrcxeRPTS3CRB/+oc
	Q7R23saidU1jBP1e08254RzOuxTNxEqSGblPQCRPXJlbhuIXyJRMwzeUgWXvK8CcuBTpR42Z
	7YSDEXmCMpk2cQe7kL7UiqV3x/O4OLnIpubUdpYjOEBGUAsmFXIwQR6ntu1atoP5pD+VO7+M
	/o0epepfvd0dciLPUYVTa7tesNPpGJ3kFGI8DbanDnORyJKlIkmsv7ciRpwqk6R4R8VJG7Gd
	/6rSt4v02OpIsBEjuZhwL99D6iMWsEXJilSpEaO4uNCF/87qLRbwo0WpDxh53F15UiyjMGIH
	uYTQjX81jIkUkPdFiUwMw8Qz8v8pi+vknoG5BTeX+vUn8yNMJ6/DrdRj4YcCfl5urs1nJMUh
	h0fFZ0tjAtoH9ntltTdM6JE5ISro+ezqWM+9pTsD7l9CItKrbYMlCXlnnMNcf398MuX3xnpb
	GqrtUBZupl3rrC0931W8cCHfkHZlXONVOZIbVNT29cjNCNtQg7nS2UPVITDmaISEQizy9cTl
	CtFfNYnaOLsCAAA=
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
---
 net/core/page_pool.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 974f3eef2efa..2680d38d3daf 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,29 +518,29 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
 	return false;
 }
 
-static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
+static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
 						 gfp_t gfp)
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


