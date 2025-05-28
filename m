Return-Path: <bpf+bounces-59057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFFDAC5F56
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122F71BA6574
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D41DEFE8;
	Wed, 28 May 2025 02:29:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77073D544;
	Wed, 28 May 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399367; cv=none; b=osI9bhYOpB7U1USyNOy2zlyW/mcoL8EiAiXr3utIggq77BGtkT+WdkLshzztI6el62wm5hW111hw7I+r1iF+BnC57KECalfnWhv9u52/Sk3bq5kHIDnAqYRlOqICh0WKI5ValSr7aBYrCPvOWnSEEIgrYXPeVoSTtSe5kIyr15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399367; c=relaxed/simple;
	bh=m9e+j3OAmxaHvdQJRLMFV+bkA6h52c5RMu4JlkUzqX8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LC0uwT1f5hgJSLdt/rTv4UaAkcafzK9DKJVldU1+1Rhs47dYHm/nvSlWio7XtFfUVcaIz0+T3tP5zIkIReoJGjk6VFnicNxSNH/+3GteotDlP4Schtyd5meTfzVUmvjDfQLw5YN2ofmmb/4TV8UyoFoxrr2sgiI5aY4k+gnneAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-16-68367501819d
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
Subject: [PATCH v2 00/16] Split netmem from struct page
Date: Wed, 28 May 2025 11:28:55 +0900
Message-Id: <20250528022911.73453-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGfXfOzo7TwWFaHRWyBhWImora/0OYRtQLQRhBQUY28uCG25TN
	67qpSeXQdRM0XTETl5fRZBOdImrTvFCkrYxlpTZRClNJ09RFponffjy3Lw9NiM1kIC1XZXJq
	lVQhoYSkcNa3Ogxlxcoiyrr2g8FipqBxJReeTdj5YGhoQfBr9ZMAFnv7KaipXibAMFREwpJl
	jYCpPrcAxk3TJHTcbiXAfXeAgtIiDwGF9joeDLfo+VC2VktAa/6EAN61GygYM6/zYdpRSsJg
	ZT0J4/p46DPuhOVXPxD0Wlp5sFzymIKHTiMFk0XjCJw9bhKqCvQILJ0uPnhWDFT8Xtxc/5GH
	2yq/CLDRmoVtdSFY53IS2NpQTGHrwgMB/vyhg8IDFR4St9kXebj05hyFf06Nkni+c4TCluYR
	Er829grwonV3InNeeDiFU8izOfXBuEtCmalkSZBRGZc7Ob2C8lFtpA550ywTzTY+7Sa3uad6
	5j9TzAHW5VolNtmfiWQX3f0bupAmmDk+O2Xw8HSIpv2YQ6zJjDczJLOPbenqQpssYmJY13wB
	tbUZzDY2dRObXZYZFbAV98v5W0YA+6LORd5DPkbk1YDEclW2UipXRIfL8lTy3PDL6Uor2vjQ
	dO1Pkh0tDJ9xIIZGEl8RboqRifnSbE2e0oFYmpD4iwqPxMrEohRpnpZTpyersxScxoGCaFKy
	SxS1nJMiZlKlmVwax2Vw6m2XR3sH5iOt7TefPp7wUjRkP5c79mStZF1bbg7od0QpggYk7vLr
	zhuOR/OhRs/75+7Z4JA94o7WiOY225WTSd/lHVzAZFuV3nkitYZOCD/lc+doTuGMUhu64+vZ
	wQvlQe3aUF9dVG2YrTgx+XTWN03xrQbdsYtv38wZ/a56pdlMg39VolSThNTIpJEhhFoj/QdY
	RR2pvwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTcRyG/e+cnR1Xq+MSO5haTUUQMlfNflaYeNOfSIu6CLowVx7acn6w
	6XJRMd00Ejczu4g5YSaaX7C1RKeI1hQ/KKg0Y5U1mTiCTC0/UCeUI7p7eN+H9+alCXENGUkr
	C4o5dYFcJaGEpDDrpOEQKklRJDvqI8Bq76SgY70Uns24+GBt70awsvFFAMvDoxQ0Na4RYH1r
	JGHVvknA3IhPAN4WPwn993sI8NWMUWAyBggod7XyYKhhnA/vus18eLzZTECPfkYAk31WCr51
	/uGD320iYdzSRoLXnA4jtghYez2PYNjew4O16gYK6iZsFMwavQgmhnwk1JeZEdgHPHwIrFup
	dAnuavvEw72WrwJsc5bgF62JuMozQWBn+wMKO38/EuDpj/0UHnsSIHGva5mHTYYFCv+a+0zi
	xYEpCjd9X+Jhe9cUid/YhgUXwq4IT+VyKqWWUx9OyxEqWqpXBUWWtNJZ/zrSo2ZpFQqlWeYY
	O9T4gwwyxSSwHs8GEeRwRsou+0a3cyFNMAt8ds4a4FUhmt7DHGdbOnHQIZl4tntwEAVZxMhY
	z2IZ9W9zP9vheEk8RLQNhbSjcGWBNl+uVMmSNHkKXYGyNOl6Yb4Tbd/Ucner1oVWJs+4EUMj
	yU4RdsgUYr5cq9HluxFLE5JwUfnpFIVYlCvX3ebUhVfVJSpO40b7aFKyV3T2MpcjZm7Ii7k8
	jivi1P9bHh0aqUeVlbGmzJGKCjS960jGh61bS+8zJq8dSDMa+jPDkiXRa5Fz83F9Im/0vaSw
	HDLbnC2Lt6iI1Na4AyG1zvOpK6+W9AFjZUyC4XnppSiA3sSin4t1KR3RB+9oYxWDpphOf4LU
	b0jOMpmi+Bd9Rx2x5A7z7oRB/VOR7sRN77kZl4TUKOTSREKtkf8FKMw2W6ICAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The MM subsystem is trying to reduce struct page to a single pointer.
The first step towards that is splitting struct page by its individual
users, as has already been done with folio and slab.  This patchset does
that for netmem which is used for page pools.

Matthew Wilcox tried and stopped the same work, you can see in:

   https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/

Mina Almasry already has done a lot fo prerequisite works by luck, he
said :).  I stacked my patches on the top of his work e.i. netmem.

I focused on removing the page pool members in struct page this time,
not moving the allocation code of page pool from net to mm.  It can be
done later if needed.

There are still a lot of works to do, to remove the dependency on struct
page in the network subsystem.  I will continue to work on this after
this base patchset is merged.

The final patch removing the page pool fields will be submitted once
all the converting work of page to netmem are done:

   1. converting of libeth_fqe by Tony Nguyen.
   2. converting of mlx5 by Tariq Toukan.
   3. converting of prueth_swdata (on me).
   4. converting of freescale driver (on me).
   5. making page_pool_page_is_pp() not access via page->pp_magic (on me).

For our discussion, I'm sharing what the final patch looks like.

	Byungchul
--8<--
commit 8e56edf5e4fcd614e951fa046a1479e7fc1c1f95
Author: Byungchul Park <byungchul@sk.com>
Date:   Fri May 23 10:40:00 2025 +0900

    mm, netmem: remove the page pool members in struct page
    
    Now that all the users of the page pool members in struct page have been
    gone, the members can be removed from struct page.
    
    However, since struct netmem_desc might still use the space in struct
    page, the size of struct netmem_desc should be checked, until struct
    netmem_desc has its own instance from slab, to avoid conficting with
    other members within struct page.
    
    Remove the page pool members in struct page and modify static checkers
    for the offsets and the size.
    
    Signed-off-by: Byungchul Park <byungchul@sk.com>

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 56d07edd01f9..5a7864eb9d76 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -119,17 +119,6 @@ struct page {
 			 */
 			unsigned long private;
 		};
-		struct {	/* page_pool used by netstack */
-			/**
-			 * @pp_magic: magic value to avoid recycling non
-			 * page_pool allocated pages.
-			 */
-			unsigned long pp_magic;
-			struct page_pool *pp;
-			unsigned long _pp_mapping_pad;
-			unsigned long dma_addr;
-			atomic_long_t pp_ref_count;
-		};
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 96472e56e8ee..4979bd33ba9d 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -81,19 +81,26 @@ struct net_iov_area {
  *        };
  *
  * We mirror the page_pool fields here so the page_pool can access these fields
- * without worrying whether the underlying fields belong to a page or net_iov.
+ * without worrying whether the underlying fields belong to a page or,
+ * net_iov and netmem_desc.
  *
  * The non-net stack fields of struct page are private to the mm stack and must
- * never be mirrored to net_iov.
+ * never be mirrored to net_iov and netmem_desc.
  */
-#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
+#define NETMEM_DESC_ASSERT_OFFSET(pg, ndesc)       \
 	static_assert(offsetof(struct page, pg) == \
-		      offsetof(struct net_iov, iov))
-NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
-NET_IOV_ASSERT_OFFSET(pp, pp);
-NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
-NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
-#undef NET_IOV_ASSERT_OFFSET
+		      offsetof(struct netmem_desc, ndesc))
+NETMEM_DESC_ASSERT_OFFSET(flags, type);
+NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic);
+NETMEM_DESC_ASSERT_OFFSET(mapping, owner);
+#undef NETMEM_DESC_ASSERT_OFFSET
+
+/* XXX: The page pool fields in struct page have been removed but they
+ * might still use the space in struct page.  Thus, the size of struct
+ * netmem_desc should be under control until struct netmem_desc has its
+ * own instance from slab.
+ */
+static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
 
 /*
  * Since struct netmem_desc uses the space in struct page, the size
---

Changes from v1:
	1. Rebase on net-next's main as of May 26.
	2. Check checkpatch.pl, feedbacked by SJ Park.
	3. Add converting of page to netmem in mt76.
	4. Revert 'mlx5: use netmem descriptor and APIs for page pool'
	   since it's on-going by Tariq Toukan.  I will wait for his
	   work to be done.
	5. Revert 'page_pool: use netmem APIs to access page->pp_magic
	   in page_pool_page_is_pp()' since we need more discussion.
	6. Revert 'mm, netmem: remove the page pool members in struct
	   page' since there are some prerequisite works to remove the
	   page pool fields from struct page.  I can submit this patch
	   separatedly later.
	7. Cancel relocating a page pool member in struct page.
	8. Modify static assert for offests and size of struct
	   netmem_desc.

Changes from rfc:
	1. Rebase on net-next's main branch.
	   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
	2. Fix a build error reported by kernel test robot.
	   https://lore.kernel.org/all/202505100932.uzAMBW1y-lkp@intel.com/
	3. Add given 'Reviewed-by's, thanks to Mina and Ilias.
	4. Do static_assert() on the size of struct netmem_desc instead
	   of placing place-holder in struct page, feedbacked by
	   Matthew.
	5. Do struct_group_tagged(netmem_desc) on struct net_iov instead
	   of wholly renaming it to strcut netmem_desc, feedbacked by
	   Mina and Pavel.

Byungchul Park (16):
  netmem: introduce struct netmem_desc struct_group_tagged()'ed on
    struct net_iov
  netmem: introduce netmem alloc APIs to wrap page alloc APIs
  page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
  page_pool: rename __page_pool_alloc_page_order() to
    __page_pool_alloc_large_netmem()
  page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
  page_pool: rename page_pool_return_page() to page_pool_return_netmem()
  page_pool: use netmem put API in page_pool_return_netmem()
  page_pool: rename __page_pool_release_page_dma() to
    __page_pool_release_netmem_dma()
  page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
  page_pool: rename __page_pool_alloc_pages_slow() to
    __page_pool_alloc_netmems_slow()
  mlx4: use netmem descriptor and APIs for page pool
  netmem: use _Generic to cover const casting for page_to_netmem()
  netmem: remove __netmem_get_pp()
  page_pool: make page_pool_get_dma_addr() just wrap
    page_pool_get_dma_addr_netmem()
  netdevsim: use netmem descriptor and APIs for page pool
  mt76: use netmem descriptor and APIs for page pool

 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  48 +++++----
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
 drivers/net/netdevsim/netdev.c                |  19 ++--
 drivers/net/netdevsim/netdevsim.h             |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c      |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +--
 .../net/wireless/mediatek/mt76/sdio_txrx.c    |  24 ++---
 drivers/net/wireless/mediatek/mt76/usb.c      |  10 +-
 include/net/netmem.h                          |  73 ++++++++-----
 include/net/page_pool/helpers.h               |   7 +-
 net/core/page_pool.c                          | 101 +++++++++---------
 12 files changed, 170 insertions(+), 144 deletions(-)


base-commit: d09a8a4ab57849d0401d7c0bc6583e367984d9f7
-- 
2.17.1


