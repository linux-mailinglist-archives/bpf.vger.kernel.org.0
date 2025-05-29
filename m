Return-Path: <bpf+bounces-59242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE19BAC762B
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6989B188F46E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA68253F03;
	Thu, 29 May 2025 03:11:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D57B244682;
	Thu, 29 May 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488271; cv=none; b=nJ6K7yZI+4AfcO5X7vNAcRWqLpK3RrYxmxP9kWSgPBtyhENBV17DZ7HxAGhjPZhHMzBqnlrGTFpqZ901749/9DsI8C/LyNDKc2WIJnkyJHNcrWFzn5sh2GWuZ5xIbhMxIuSpgGO9eNw1CDhzQrAA8E2uBRbCbuzfEnEDSIcafTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488271; c=relaxed/simple;
	bh=ypyoaLK2EXv2j/+xowGIgr+UdmJFtJ+H2sG3LeoYBkM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EFIkLw0SN7Qg00NM7GvTK7V4UMKk/yUpABS3Q7RPx8iPh9VIVC84pZD1HPtqkL1XiTla8m1t7PIGs/bCm8g9dxVr1PxqFWyYX5ozNFFf9m2FajIHEdOM7OsimMtLpX1ozgwZ6Qr4ILMl64zExiAd7jJdSFpzM35eV0PG6ZV94Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c4-6837d0412192
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
Subject: [RFC v3 00/18] Split netmem from struct page
Date: Thu, 29 May 2025 12:10:29 +0900
Message-Id: <20250529031047.7587-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTcRyG+++cnXNcDk5T8mhROJDIyDT8+JV9WBfx7yYjr6xAh57cUqfM
	rxkFppJtqEWplc2YaUunNZumM8RsmtoHpYa2zPxEiShDZ0udZA7x7uF9eN+blyEk9aQPo1Cm
	8yqlLElKiUjRL/fKvcf6wuSBhr4Q0JnqKahbVMPjcYsQdMZmBAtLX2mwd/VQUFXpIED3MZ+E
	P6ZlAqa7J2kYM8yQ0FbQQsDkjV4KivKdBORaagTQ11wshJLlRwS05IzT8OmFjoLR+lUhzFiL
	SHhTXkvCWHEEdOu3guPdTwRdphYBOAorKLg9oKdgKn8MwUDnJAn3rxYjMLXbhOBc1FERvrip
	9osAt5Z/o7HenIEba/yx1jZAYLNRQ2Hz/C0ajwy1Ubj3rpPErRa7ABflzVJ4bnqYxL/bByls
	ahok8Xt9F43t5h2n2bOiQ/F8kiKTV+07EiuSL0+UCVIbD6onDHMoB10P0CI3hmODOYdVS21w
	Z3Mn6WKK3cXZbEuEiz3ZIM4+2bOWixiCnRVy0zqnwCU82BCu5JoDaRHDkKwfN1zg44rFazul
	zkJ6fXMnV9fQQbi6HDtKc5/1FnJdeHOvamzkTbRZjzYZkUShzEyWKZKCA+TZSoU6IC4l2YzW
	PjRcWTlnQfN9UVbEMkjqLu5FYXKJUJaZlp1sRRxDSD3FuUdD5RJxvCz7Eq9KiVFlJPFpVrSN
	IaVe4v2OrHgJmyBL5xN5PpVXbVgB4+aTg6T8if6Ofk1Zg8cD+1BFdXT/M6w5+SPw+4ctf4Oe
	K4NHVg9rNa+rL0fFqv28jLMXj2uWA2JCFx5eqA6Pz1s5sDschxvGCXVcVtuef5FLmvP5iXOR
	U6fqZjJeloruBOmeKKN7fH20GZHuvt5iQ/1qt9D69kzhvbkR/dMEnt5eVayWkmlyWZA/oUqT
	/QdTa+mCvwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAwGiAl39CAMSjwQaCGludGVybmFsIgYKBApOO4MtQdA3aDCZlSM4nK+sBjir
	+Hg4p+C4BTicqrYBOPT52wc488THBjijofYDOJzPhAQ49a/6AzjlxuIHON+m5gQ4vIe3Azji
	j8gGOI2E+wM4grioAjjDnckFONC2jgU4lPqlAzi3gOAHONO6nAY43qz/BTjmwo0EOMmaqQQ4
	345AOMagFjj2y+wBOMSvtwI49oydBjiT0qAGOOOE3wE40sPiBDibgY4BOK++2AU4+/icBkAi
	SLSp2QJIuZrdB0igsnVIs6gqSIrY0gNIsqqJBkiy8pIHSNzWvAZIyJj7BEi5uPMCSI2D7gZI
	8eXaBEjvvtUGSKPo8AJIr7TVBEjMoMQHUBFaCjxkZWxpdmVyLz5gCmj64ZYCcLM6eOGm8QGA
	AYguigEJCBgQNBjDtsMEigEJCAYQJxjY2PkDigEJCBQQMRjz4scEigEKCAMQ7gUY5Zz7AooB
	CQgTEDUYlIb2AYoBCAgEECUY2ocaigEJCA0QNBiV+4wHigEJCBgQHxirsMADkAEIoAEAqgEU
	aW52bWFpbDUuc2toeW5peC5jb22yAQYKBKZ9/JG4AfTTR8IBEAgBIgwNyAE3aBIFYXZzeW3C
	ARgIAyIUDYI/NmgSDWRheXplcm9fcnVsZXPCARsIBCIXDUpXZWASEGdhdGVrZWVwZXJfcnVs
	ZXPCAQIICRqAAa+Hq3m/hccYoJPZo6j6cRoCjXvo1gf1Puf0j/MIhwfP8s0R7XIiu+jKFFyt
	uMXcEW+w6itfTKn54TfanYu6Mgj1DjgE5CtKcXzO151ADqudYqo/ieyZPJdDoHRqED94IRmY
	wSs8mS7XMlqxznvLtwNFZLAYcTm326N+hXOuwGoLIgRzaGExKgNyc2Hs4jL8ogIAAA==
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

The final patch removing the page pool fields will be submitted once
all the converting work of page to netmem are done:

   1. converting of libeth_fqe by Tony Nguyen.
   2. converting of mlx5 by Tariq Toukan.
   3. converting of prueth_swdata (on me).
   4. converting of freescale driver (on me).

For our discussion, I'm sharing what the final patch looks like the
following.

	Byungchul
--8<--
commit 86be39ea488df859cff6bc398a364f1dc486f2f9
Author: Byungchul Park <byungchul@sk.com>
Date:   Wed May 28 20:44:55 2025 +0900

    mm, netmem: remove the page pool members in struct page
    
    Now that all the users of the page pool members in struct page have been
    gone, the members can be removed from struct page.
    
    However, since struct netmem_desc still uses the space in struct page,
    the important offsets should be checked properly, until struct
    netmem_desc has its own instance from slab.
    
    Remove the page pool members in struct page and modify static checkers
    for the offsets.
    
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
index 9e4ed3530788..e88e299dd0f0 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -39,11 +39,8 @@ struct netmem_desc {
 	static_assert(offsetof(struct page, pg) == \
 		      offsetof(struct netmem_desc, desc))
 NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
-NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
-NETMEM_DESC_ASSERT_OFFSET(pp, pp);
-NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
-NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
-NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
+NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic);
+NETMEM_DESC_ASSERT_OFFSET(mapping, _pp_mapping_pad);
 #undef NETMEM_DESC_ASSERT_OFFSET
 
 /*
---
Changes from v2:
	1. Introduce a netmem API, virt_to_head_netmem(), and use it
	   when it's needed.
	2. Introduce struct netmem_desc as a new struct and union'ed
	   with the existing fields in struct net_iov.
	3. Make page_pool_page_is_pp() access ->pp_magic through struct
	   netmem_desc instead of struct page.
	4. Move netmem alloc APIs from include/net/netmem.h to
	   net/core/netmem_priv.h.
	5. Apply trivial feedbacks, thanks to Mina, Pavel, and Toke.
	6. Add given 'Reviewed-by's, thanks to Mina.

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

Byungchul Park (18):
  netmem: introduce struct netmem_desc mirroring struct page
  netmem: introduce netmem alloc APIs to wrap page alloc APIs
  page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
  page_pool: rename __page_pool_alloc_page_order() to
    __page_pool_alloc_netmem_order()
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
  netmem: introduce a netmem API, virt_to_head_netmem()
  mt76: use netmem descriptor and APIs for page pool
  page_pool: access ->pp_magic through struct netmem_desc in
    page_pool_page_is_pp()

 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  48 +++---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
 drivers/net/netdevsim/netdev.c                |  19 +--
 drivers/net/netdevsim/netdevsim.h             |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c      |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
 .../net/wireless/mediatek/mt76/sdio_txrx.c    |  24 +--
 drivers/net/wireless/mediatek/mt76/usb.c      |  10 +-
 include/linux/mm.h                            |  12 --
 include/net/netmem.h                          | 145 +++++++++++++-----
 include/net/page_pool/helpers.h               |   7 +-
 mm/page_alloc.c                               |   1 +
 net/core/netmem_priv.h                        |  14 ++
 net/core/page_pool.c                          | 101 ++++++------
 15 files changed, 239 insertions(+), 174 deletions(-)


base-commit: d09a8a4ab57849d0401d7c0bc6583e367984d9f7
-- 
2.17.1


