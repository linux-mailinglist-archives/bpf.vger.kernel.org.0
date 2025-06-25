Return-Path: <bpf+bounces-61484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11AAAE75E6
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C51BC38C8
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA71E22E9;
	Wed, 25 Jun 2025 04:34:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B2515A86B;
	Wed, 25 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826046; cv=none; b=bHJxGOytUt+n2SiLk2KgJDvcvayIMy57dXy4Rug+tVQPTBD/aUwf0K6Ry2plg00NLIOMrswNENx0jAZfopdKdyBwsaivdkPULwKpokFi8ZRd4b58LjD9Gi9asqddb1U7qU0pd1NK8m5jlQxtOHg/zEZ4hoN5MSq6U5uMpmbB5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826046; c=relaxed/simple;
	bh=iwwuyvONXr1evv+EmIIgn8DacwbjxouYfYpkh2hqk/c=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QLVUaqN9XrmNnjNkfxtmJF+j64rmFUTUu+V2sdsQguS5IPNY2UYRhP4WbP7R0lIkksMuhvmibaEmsHDuY7v8XQdJNnSPkEc68bjPUXzlOhIrd5YMHyAWLEyI7CMjh7RcCYKLko5zf8+p9m0bGBdZHE5dleHl79aEnp+JQ1b638M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-e2-685b7c38181d
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
Subject: [PATCH net-next v7 0/7] Split netmem from struct page
Date: Wed, 25 Jun 2025 13:33:43 +0900
Message-Id: <20250625043350.7939-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRXUhTcRjG/e+cnXNcro7L7GRBNDJDyrREXypEKOh/UaTkTXpRSw9tNT/a
	1FSUzBal5XcNUYNZqfMjVlPcFBO/mmZWZqkzS8VQupjKtIYfUW1Jdz/e53l+Ny9DSNpIH0aR
	kMyrEmRKKSUiRfMejw9CZow8cN4SApWGRgoaVtKgdtoshMr6FgQ/VidoWO7to+BJlYOAyvca
	En4a1giYtczQ0GA8A1M1cyS03zERMFPYT0G+Zp2Al6sLNOSY9QIYaikQwoO1agJM2dM0fGyr
	pGCy8Y8Q5rrzSXhdXkfCVEE4WHTe4HhjQ9BrMAnAcf8RBaXDOgq+aaYQDPfMkFBxswCBocMq
	hPUVp6Pi1SQdvhf32BYJ3Fw3LsCt5V9prDOm4Ca9P86zDhPYWJ9LYeNSCY2/jLZTuL9sncSt
	5mUBzr+1QGH77GcSL3aMUNjQPELiQV0vHeEZLToexysVqbzqUNhFkbzk4aAgKSc07d1kC5mN
	7h7IQwzDscFctQXnIfd/OOooplxMsX6c1bpKuNiLDeKWZ/rIPCRiCPYZxfU2TtCu7VY2jLPN
	S1wdkvXlBl5YhC4WOz05hla04dzNNTzvJFxbjrXTnGZqjNoIdnBdeitZhDbpkFs9kigSUuNl
	CmVwgDw9QZEWEJsYb0TOj9Zk/Yoxo6Whc92IZZDUQxx4O1ouEcpS1enx3YhjCKmXWBvqPInj
	ZOkZvCrxgipFyau70U6GlG4XH3Zcj5Owl2XJ/FWeT+JV/1MB4+6TjXZpWVlweL+iMCv2g5s9
	qlyqNYZEjtI2vV9ExkjLjQX70Opi5tl74/uLtx0LqsK5OCrjhAnVQgBzylb1fd/JujH9mpvX
	o9rzisjZMP/TgJo6R5uLPPf4vh24pnFvzTjq7dis/fR0izq87Ldm2mQ+cilCmbuyoL+S2BVV
	quhkpaRaLgvyJ1Rq2V/oAZR0zQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAwGwAk/9CAMSnQQaCGludGVybmFsIgYKBApOO4MtOHxbaDCoqSQ4nK+sBjir
	+Hg4p+C4BTicqrYBOPT52wc488THBjijofYDOJzPhAQ49a/6AzjlxuIHOKuyTTjfpuYEOLyH
	twM44o/IBjiNhPsDOL357gc4grioAjjDnckFONC2jgU4lPqlAzi3gOAHONO6nAY43qz/BTjm
	wo0EOMmaqQQ4345AOMagFjj2y+wBOMSvtwI49oydBjiT0qAGOOOE3wE40sPiBDibgY4BOK++
	2AU4+/icBjibxd4HQCVIw+zvA0i0qdkCSLma3QdIoLJ1SLOoKkiK2NIDSLKqiQZIsvKSB0jc
	1rwGSMiY+wRIubjzAkiNg+4GSPHl2gRI777VBkij6PACSK+01QRQEloKPGRlbGl2ZXIvPmAK
	aJKVzAJwgjd4zt62BIABiCyKAQkIGBA0GNb2kQaKAQkIBhAnGNjY+QOKAQkIFBAxGPPixwSK
	AQoIAxCtBhjErNsHigEICBMQPhjs7RKKAQkIBBAlGMqxxgWKAQkIDRA0GIKvuQGKAQkIGBAf
	GKuwwAOQAQigAQCqARRpbnZtYWlsNS5za2h5bml4LmNvbbIBBgoEpn38kbgB9NNHwgEQCAEi
	DA0whVpoEgVhdnN5bcIBGAgDIhQNljdaaBINZGF5emVyb19ydWxlc8IBGwgEIhcNSldlYBIQ
	Z2F0ZWtlZXBlcl9ydWxlc8IBAggJGoABzpp6BUwS9WLgA39HjaNWVbzfDDRjjVF5nJTtLfXN
	dm4yu9RmQoNPytWHzejMz1+m8E9j7tT+gdVfJGddNgMsrdIk7XE5IEFCYEfnfcVvGWC5wn/g
	3dZHZxPbTMSV3Wkjk6nXU+RQ8JzU1HM9xjXiTv02FCnPbUe+nOPgG/UX+n4iBHNoYTEqA3Jz
	YU4YI1qwAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hi all,

In this version, I'm posting non-controversial patches first since there
are pending works that should be based on this series so that those can
be started shortly.  I will post the rest later.

The MM subsystem is trying to reduce struct page to a single pointer.
The first step towards that is splitting struct page by its individual
users, as has already been done with folio and slab.  This patchset does
that for netmem which is used for page pools.

Matthew Wilcox tried and stopped the same work, you can see in:

   https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/

Mina Almasry already has done a lot fo prerequisite works by luck.  I
stacked my patches on the top of his work e.i. netmem.

I focused on removing the page pool members in struct page this time,
not moving the allocation code of page pool from net to mm.  It can be
done later if needed.

The final patch removing the page pool fields will be submitted once
all the converting work of page to netmem are done:

   1. converting of libeth_fqe by Tony Nguyen.
   2. converting of mlx5 by Tariq Toukan.
   3. converting of prueth_swdata.
   4. converting of freescale driver.

For our discussion, I'm sharing what the final patch looks like the
following.

	Byungchul
--8<--
commit 1847d9890f798456b21ccb27aac7545303048492
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
index 32ba5126e221..db2fe0d0ebbf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -120,17 +120,6 @@ struct page {
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
index 8f354ae7d5c3..3414f184d018 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -42,11 +42,8 @@ struct netmem_desc {
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
Changes from v5 (no actual updates):
	1. Rebase on net-next/main as of Jun 25.
	2. Supplement a comment describing struct net_iov.
	3. Exclude a controversial patch, "page_pool: access ->pp_magic
	   through struct netmem_desc in page_pool_page_is_pp()".
	4. Exclude "netmem: remove __netmem_get_pp()" since the API
	   started to be used again by libeth.

Changes from v5 (no actual updates):
	1. Rebase on net-next/main as of Jun 20.
	2. Add given 'Reviewed-by's and 'Acked-by's, thanks to all.
	3. Add missing cc's.

Changes from v4:
	1. Add given 'Reviewed-by's, thanks to all.
	2. Exclude potentially controversial patches.

Changes from v3:
	1. Relocates ->owner and ->type of net_iov out of netmem_desc
	   and make them be net_iov specific.
	2. Remove __force when casting struct page to struct netmem_desc.

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

Byungchul Park (7):
  netmem: introduce struct netmem_desc mirroring struct page
  page_pool: rename page_pool_return_page() to page_pool_return_netmem()
  page_pool: rename __page_pool_release_page_dma() to
    __page_pool_release_netmem_dma()
  page_pool: rename __page_pool_alloc_pages_slow() to
    __page_pool_alloc_netmems_slow()
  netmem: use _Generic to cover const casting for page_to_netmem()
  page_pool: make page_pool_get_dma_addr() just wrap
    page_pool_get_dma_addr_netmem()
  netmem: introduce a netmem API, virt_to_head_netmem()

 include/net/netmem.h            | 130 ++++++++++++++++++++++++++------
 include/net/page_pool/helpers.h |   7 +-
 net/core/page_pool.c            |  36 ++++-----
 3 files changed, 124 insertions(+), 49 deletions(-)


base-commit: 8dacfd92dbefee829ca555a860e86108fdd1d55b
-- 
2.17.1


