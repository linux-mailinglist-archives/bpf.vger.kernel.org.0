Return-Path: <bpf+bounces-60027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054DEAD17DF
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E1C3A1D8D
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 04:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C527FD7B;
	Mon,  9 Jun 2025 04:32:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32721FCF41;
	Mon,  9 Jun 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443561; cv=none; b=j+aV1q2MSbSIB8A7OzI/0aiL9rhZ5fYK/jQ+b6LynFDz/lul4uaIr/I3VrR5q6K0aHsrPNJnMcaQx8nh3Ghk15coBFqfJOIn8yLGn6iekCXEZ8B5spd5cYZJ5pmyXOXlVOe7yAH293ILz7kKy9O1aYPZ5qky9FUNnpgnr/Tc1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443561; c=relaxed/simple;
	bh=wuMzdjrsppK7zABodLU2wRyjcVCWRTcLAGXBfXPuU7I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=E0jrWdk3PtbdZzVoCqwjXPSi6FBkqR7Ow6K05CzgccmqOKpSIQwUPXzqFp69sfVmwGKwOw+99m+1jq+r9Yhs/XbiDd9Wy/eu3hwyUBSI9f42WoGKelAv0r56Qd5CZdmmttLJcWSiXSQyxPye0mmkFTB+k07pfGig4iw7wBLE46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-44-684663e373eb
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
Subject: [PATCH net-next 0/9] Split netmem from struct page
Date: Mon,  9 Jun 2025 13:32:16 +0900
Message-Id: <20250609043225.77229-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRa0hTYRwG8N6ds7PjcnFcUicDrWEElpqh8gclFla8SESUoSmVQw9u5qZt
	ulQILwmW6CorNV00MW1OabJk0xJREzUMMi81L+Ut7UuaORV1gWnitx88PM+XhybEdaQHrVCl
	cmqVLElCCUnhnGul73TcOfmJstLjoDfXU1C3mg6vJpr4oDdZESytjQrA0dlNQVXlCgH6T3kk
	LJvXCZjpmhLAeM0sCS35NgKmHvRQUJTnJCC3yciDPquOD0/WqwmwZU8IYOCtnoLv9Rt8mO0o
	IuFDeS0J4zopdBn2wUrvLwSdZhsPVgqfU/C430DBdN44gv73UyRU5OgQmFvtfHCu6inpYdxY
	O8zDzeXfBNhgScNvjD64wN5PYIvpPoUti8UCPPalhcI9ZU4SNzc5eLjo7jyF/8yMkPh36xCF
	zY1DJP5o6BRgh8XzIhMtDI3nkhRaTu1/KlYof9YwSqXkBKW326vJbFTlU4BcaJYJZNs2egU7
	fvFoA22ZYo6ydvsasWV3JoB1THWTBUhIE8w8n53RO3lbwV4mhB28N7lZpmmSOcKWlf7fFDFB
	bLsjG21verF1DW3EtkcE7PACve0DbLvRTj5Euw1olwmJFSqtUqZICvSTZ6gU6X5xyUoL2ryw
	5s7fmCa02He5AzE0kriKYkvPysV8mVaToexALE1I3EXMeJhcLIqXZWRy6uQb6rQkTtOBDtKk
	ZL/o5MrteDGTIEvlbnJcCqfeSXm0i0c2yi+tGtCmLZ+pPx3Ktj+NCNaJin9mSSMDy02mAU34
	D18X74oYiFi4ZMvy6lYs6a3cWG5IT0gUNs5es1xYTQyDwck+d2bu0nnfdzFXr0TsMR17HQWM
	0S3cf9kt2M34VVvYolSxJS9vSSMP0cJuqzIk37Pk83qid9l1/8wEdbSE1MhlAT6EWiP7BweT
	b+u+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRxA/d97d+91OrktsYt+CAZRCJpWxi8UsUL7E/SAiigUnXprQ+dj
	U9EgmClYy0em4aNJk2E+ZkyW6AwTneIrQ9GMlaU2UYJMy6lMZ1gWfTtw4Hw5LCkto/xZZVqW
	oE6Tp8poMSW+GF4QtJAUowhx6QJAb26lweTKhcZ5qwj0LR0I1rdmGHAODNFgrN8kQT9eSMGG
	eZuExUEHA3PPlyjoLuokwVE2TENJoZuEe9YmAvrrRkQw0VEqgsrtBhI6tfMMTL3S0zDbuiuC
	JVsJBSO1zRTMlUbBoMEPNt8sIxgwdxKwWVxHQ8WkgYaFwjkEk/0OCp7mlyIw99hF4Hbp6SgZ
	bm/+QOCu2s8MNliy8cumQKyzT5LY0vKAxpa1xwz+9L6bxsPVbgp3WZ0ELilYofHPxY8UXu2Z
	prHx6w8Cm9unKTxmGGAu77spjkgWUpU5gvpoZIJYUdM2Q2fkh+X22RsoLTIG6pAny3Mn+Gfl
	u2iPae4wb7dvkXvsy4XyTscQpUNiluRWRPyi3k3sif1cOP/u/hdGh1iW4g7x1VV/OxIujO9z
	atG/5kHe1NZLPkKsAXm0IF9lWo5KrkwNC9akKPLSlLnBSekqC/qz6fndnXIrWp86Z0Mci2Te
	koSqaIVUJM/R5KlsiGdJma+EmzurkEqS5Xl3BHV6vDo7VdDYUABLyQ5Izl8XEqTcbXmWkCII
	GYL6vyVYT38tuvGa5xmB709cimc8EiG5IfObt9TvpPvYjjzuRRcK/26xjI3HFg2pTG97Fx/W
	b/htNJi2ioK0kW1lFXGz1xJvhU/0EJf6iRCRV/HymYWAmNhffhdO79bYQoeNjTi2I9qn2efU
	lZAnoyFDxtVMl25mrTLiePaoqTLhCHl1pdlLRmkU8tBAUq2R/wY0vT3IogIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hi all,

In this version, I'm posting non-controversial patches first.  I will
post the rest more carefully later.  In this version, no update has been
applied except excluding some patches from the previous version.  See
the changes below.

--8<---
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
   3. converting of prueth_swdata (on me).
   4. converting of freescale driver (on me).

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

Byungchul Park (9):
  netmem: introduce struct netmem_desc mirroring struct page
  page_pool: rename page_pool_return_page() to page_pool_return_netmem()
  page_pool: rename __page_pool_release_page_dma() to
    __page_pool_release_netmem_dma()
  page_pool: rename __page_pool_alloc_pages_slow() to
    __page_pool_alloc_netmems_slow()
  netmem: use _Generic to cover const casting for page_to_netmem()
  netmem: remove __netmem_get_pp()
  page_pool: make page_pool_get_dma_addr() just wrap
    page_pool_get_dma_addr_netmem()
  netmem: introduce a netmem API, virt_to_head_netmem()
  page_pool: access ->pp_magic through struct netmem_desc in
    page_pool_page_is_pp()

 include/linux/mm.h              |  12 ---
 include/net/netmem.h            | 138 ++++++++++++++++++++++----------
 include/net/page_pool/helpers.h |   7 +-
 mm/page_alloc.c                 |   1 +
 net/core/page_pool.c            |  36 ++++-----
 5 files changed, 117 insertions(+), 77 deletions(-)


base-commit: 90b83efa6701656e02c86e7df2cb1765ea602d07
-- 
2.17.1


