Return-Path: <bpf+bounces-73323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004EBC2A67E
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE823B12C8
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8A2C15BE;
	Mon,  3 Nov 2025 07:51:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B61411DE;
	Mon,  3 Nov 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156292; cv=none; b=LxZu1v9Dj72t2bmQdUkGBgFuMMKzVne1rp3dv5fQgg9rJia1ByfEy0Ovc1PvHS2SbTaFR+u0RBcIjuUWsez5tDU9mhiER3m/RtGZUVzXvUdnjFPhM94+cmbmIUAPI+YqPMbQ27N9oI+2NXlpoHSy4rv+tMKCh1rohQfjinDfxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156292; c=relaxed/simple;
	bh=hfqpfBfHxBxqAMWf51/e9m+GyU8Dfc8f0Ko1up50BfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z+Hd882BjU6FpZa3tjEiYdkx5PBuWCFsh4VIIqYDD7BIguFUf8dAo95cnQfNM0WMpaWHd7LfZH4gAhQW3jivXa/f9q++IP8RjGtaFuycoZmp+rUDlvnlFpPaU4qPGIuQXZqyfybVG+e3Ca8fddCoTBK70FzHqW0JChzCnjWC7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-ff-69085ef70e8f
From: Byungchul Park <byungchul@sk.com>
To: linux-mm@kvack.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	horms@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ilias.apalodimas@linaro.org,
	willy@infradead.org,
	brauner@kernel.org,
	kas@kernel.org,
	yuzhao@google.com,
	usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com,
	almasrymina@google.com,
	toke@redhat.com,
	asml.silence@gmail.com,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au,
	dw@davidwei.uk,
	ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as page pool for net_iov not page-backed
Date: Mon,  3 Nov 2025 16:51:07 +0900
Message-Id: <20251103075108.26437-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251103075108.26437-1-byungchul@sk.com>
References: <20251103075108.26437-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSb0gTcRwG8H53t7tzOTqW5qWRMIrASE2tvkGJIMSvIgh6VUE53JFXumTL
	pYG0apJlmlmW6QTtj82pWLN0LldrM80yCkudVP4vo8zMfzk1bBq9+8DzfJ9XX5aUZ0gCWVF9
	QtColYkKWkpJf/iWbvh9iBXDPxX4g7G6koaK6VS412uVgKdyiACjuRbBhOcDA/P2JgTjjc00
	fHeNIbhdOkWC8Y2BgsnqGRLqbUMIvhVU0fC5qZ+BCsse6Cn7QkHD+ToS+i+/oCHbMEuC3TPC
	wFmryTtco2fgbW2OBK7N3CWhTt/LwDubkYbuynkJfHFmU9BSWE7BaH4jCT05MdBUsgKmXg0j
	aKyuI2DqUjEN7TdtBDyytzNwta2EhgFDD4I2Vz8F+XOZNBSdyUEwO+2dHMmdkEDR824mJhSf
	cbtp7Br+SeKH5V0E7ii4QmH3k5cEri/8xOASSwquMYXgi+42ElvMF2hsGctj8MeOBhq/KJil
	cH3fVlxvHSdw9rkReq//Aek2lZAo6gRNWHScNGHSOk0lvw9Kbfp1h9KjwRUXkQ/Lc1H8ecco
	89+u/kx6wTS3jne7PeSC/bhw3pQ/4bWUJbkslv/w5MFisJxT8+Nd9kVT3Fr+a187tWAZt4kv
	zXLS/0aD+Yr7jsWOD7eZt7eWEQuWezvmh4bFUZ5zsHzDn9fEv4OV/DOTm8pFshK0xIzkolqX
	pBQTo0IT0tRiamj88SQL8j5HWfrcQSsae7vPiTgWKXxlvfGMKJcoddq0JCfiWVLhJ+syUKJc
	plKmnRI0xw9rUhIFrRMFsZQiQBYxdVIl544oTwjHBCFZ0PxPCdYnUI8yVq/KIxMC4pfoHN92
	GiPiM6W7zcpy/10hP/qiTjuyRm/tCFb1SIa3momc2uT9nZE3tumwQttS7HkfeW9+YF2k+LT5
	+tItsdHLgh5v0LoqhvIybMGDN7pjYp8ubz+5ptOuXa/YblN/3dWrzy+Kk6iC3h0++tmvqkbb
	WpoVEd6RHqagtAnKjSGkRqv8C9711w0YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTYRwG8N6ds/ccZ5PDMjtoEY3EEtKkrH9m0ZfoIBjdi6B01CFP6qxN
	TaNCc5BmLrVWZkpqZd5Cm7WLOKnN7KKQeMmZ5a20m1le84Y1jb794Hl4vjw0Iesn3WlBGc2r
	lIoIOZaQkp2bk9b8PkoLa40nIae8DEPpRBw86DaJYbLsswhySgwIRic7KPhjqUMwUvsCw3fb
	MIK7+eME5LzRkDBWPkWAueozgm9ZDzH01fVSUKoPhq7CfhKqLxkJ6L36EkOaZpoAy+QgBRdN
	RY7hygQKbLmvxNBo0Irh+tR9AowJ3RQ0V+Vg6Cz7I4Z+axoJr7KLSfilqyWgS7sN6vLcYLx+
	AEFtuVEE41dyMbTeqhLBE0srBdea8jB81HQhaLL1kqCbScZwO1GLYHrCMTmYPiqG2887qW2+
	XKLdjjnbwE+Ce1zcLuLeZmWQnL3mtYgzZ3+guDx9DFdZ5M1dtjcRnL4kBXP64UyKe/+2GnMv
	s6ZJztyziTObRkRcWtIg3uV2WBJ4nI8QYnmV79ZQSdiYaYI81eIRVzd0j0xAn9wuIyeaZdaz
	tt5kPGfMeLF2+yQxZ1dmLVukG3VYQhNMKs121DyaDxYxSnak3TJvkvFkv/S0knOWMv5sfqoV
	/xtdzpZWPJ3vODEbWEtDoWjOMken5LGGSEeSPLSgBLkKythIhRDh76MOD4tXCnE+x6Ii9cjx
	fuH5mQwTGm3eYUUMjeQLpd3HKEEmVsSq4yOtiKUJuau0XUMKMulxRfxZXhUVooqJ4NVW5EGT
	8iXSoIN8qIw5oYjmw3n+FK/6n4poJ/cE5KI7NBV0kvBKCjQcaeGl7+SNPhVts8taVukMG73c
	tWJ1wOr7yb/PZq+Oly/NFG4WnCvff+DJ3oGxNkr4keiyx7zYvq9ruu+0R+DKNhd2e2a+5Wt6
	2ooLdz1t2pAr6y5h3wZnv6gthcGzBS6Rht1nhooDntWv2G/sTFHdCM24lX7HWU6qwxR+3oRK
	rfgLYMXzOvkCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
determine if a page belongs to a page pool.  However, with the planned
removal of ->pp_magic, we will instead leverage the page_type in struct
page, such as PGTY_netpp, for this purpose.

That works for page-backed network memory.  However, for net_iov not
page-backed, the identification cannot be based on the page_type.
Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
making sure nmdesc->pp is NULL otherwise.

For net_iov not page-backed, initialize it using nmdesc->pp = NULL in
net_devmem_bind_dmabuf() and using kvmalloc_array(__GFP_ZERO) in
io_zcrx_create_area() so that netmem_is_pp() can check if nmdesc->pp is
!NULL to confirm its usage as page pool.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c      |  1 +
 net/core/netmem_priv.h |  8 ++++++++
 net/core/page_pool.c   | 16 ++++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index d9de31a6cc7f..f81b700f1fd1 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -291,6 +291,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			niov = &owner->area.niovs[i];
 			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
+			niov->desc.pp = NULL;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 			if (direction == DMA_TO_DEVICE)
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 23175cb2bd86..5561fd556bc5 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -22,6 +22,14 @@ static inline void netmem_clear_pp_magic(netmem_ref netmem)
 
 static inline bool netmem_is_pp(netmem_ref netmem)
 {
+	/* net_iov may be part of a page pool.  For net_iov, ->pp in
+	 * net_iov.desc can be used to determine if the pages belong to
+	 * a page pool.  Ensure that the ->pp either points to its page
+	 * pool or is set to NULL if it does not.
+	 */
+	if (netmem_is_net_iov(netmem))
+		return !!netmem_to_nmdesc(netmem)->pp;
+
 	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
 }
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..2756b78754b0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -699,7 +699,13 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
 	netmem_set_pp(netmem, pool);
-	netmem_or_pp_magic(netmem, PP_SIGNATURE);
+
+	/* For page-backed, pp_magic is used to identify if it's pp.
+	 * For net_iov, it's ensured nmdesc->pp is non-NULL if it's pp
+	 * and nmdesc->pp is NULL if it's not.
+	 */
+	if (!netmem_is_net_iov(netmem))
+		netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -714,7 +720,13 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	netmem_clear_pp_magic(netmem);
+	/* For page-backed, pp_magic is used to identify if it's pp.
+	 * For net_iov, it's ensured nmdesc->pp is non-NULL if it's pp
+	 * and nmdesc->pp is NULL if it's not.
+	 */
+	if (!netmem_is_net_iov(netmem))
+		netmem_clear_pp_magic(netmem);
+
 	netmem_set_pp(netmem, NULL);
 }
 
-- 
2.17.1


