Return-Path: <bpf+bounces-62892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6562DAFFC3E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF41C283DD
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7319F28E5E6;
	Thu, 10 Jul 2025 08:28:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CFC28C5BE;
	Thu, 10 Jul 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136110; cv=none; b=syM7LBmNTVSyIgKPePkqsytNjgPzGdgOwqV2RU97eIkGe+lp4Ffnq+9Sp8gqxI1Yd66Rb9TUVRprWozWcbS5O4EHpst4aayBOPLtfT+NE+YiSBT3584jDLK7zh8RJM9VAYxKPIFnBhOk4iTD0LEjSmNOkOIo0P5ZPuYUvM0ZwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136110; c=relaxed/simple;
	bh=pKsc+X3ArB1fzhyo3sUlt4fKKGqJ/cai1NrR8gCWFA8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EKIPSQoYCYnhQqH291Dyvp+DHgQTOhOF1J58ljWx6RkdJUnIYQiYXff4Tz2ZDoObIThRiuI37TbQVv4OIxVmiAbrkayyHaSVFhQk6vEUKZx1DFnA6t5IWWL8AetLV3zTuCRRlWAbHkmxIc63vLOOxJy0Jdb/YSpnCS0xEx4XxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ca-686f79a1a247
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
Subject: [PATCH net-next v9 0/8] Split netmem from struct page
Date: Thu, 10 Jul 2025 17:27:59 +0900
Message-Id: <20250710082807.27402-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRiH++/8z8Xl4DQvnQwSRmVGmYbF+yHMwuD4waykEoVq6MGt5rR5
	ScPCclSONClL89ZUKu+LJTrtgk2ddoHUUleWyrpA5gUveZtgLunbw/vwe768DCFtxh6MUp0o
	aNRylYwSY/GYc+nO0tQ4hW/tLy8oMtRQUD2fAo+HTSQUVTUgmFkYoGG6rYOC8tJZAoreazH8
	MSwS8MNio6HaGAJDj35ieH69kQDbrU4KsrR2Al4sjNNw1VQhgq6GbBJyFx8S0Jg+TMOH5iIK
	BmuWSfhpzsLwuqASw1B2IFj07jD7dhRBm6FRBLM3iym406On4Jt2CEFPqw1D4ZVsBIaXVhLs
	8yuNwvZBOnAz3zo6QfD1lZ9EfFPBV5rXG5P4pxXbeZ21h+CNVZkUb5y6TfNf+p5TfGe+HfNN
	pmkRn5UxTvGTPz5jfuJlL8Ub6nsx/07fRh9ZFyHeFy2olMmCZlfAGbHi2o3vKD4/IOXh2CiR
	jrR+OuTEcKw/V5vdROoQ848zde6OM8V6cVbrAuFgV9aPm7Z1YB0SMwRbS3FtNQO0Q7iwAZyt
	zIIdjNktnNlehxwdCbuHe1ZydDXvyVU/aSEcW46dpLnXGd3kqtjAvaqw4hy0Vo/WVCGpUp0c
	K1eq/H0UqWplik9UXKwRrXz00aWlSBOa6gozI5ZBMmdJV4xaISXlyQmpsWbEMYTMVTIfrlJI
	JdHy1IuCJu60JkklJJjRRgbL1kt2z16IlrIx8kThnCDEC5r/VsQ4eaSjCB+PsBZ7cJSlrjPz
	yxu35RGLQnNcfTgvqCy039C+6R7ZVyIVsDk50F4eenJrWta2YjJk5v6BuQdVEu+5XDdq+nxe
	jLa7J/zgnrzoQ8rikfcLH4P6f7d0uB3zbfXM2bt09tupKG9uueDEjeC04BCrq+Fujk+lKVIR
	v8MlZfByzX4ZTlDI/bYTmgT5X0ihWDbNAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAwGvAlD9CAMSnAQaCGludGVybmFsIgYKBApOO4MtoXlvaDDzmBU4nK+sBjir
	+Hg4p+C4BTicqrYBOPT52wc488THBjijofYDOJzPhAQ49a/6AzjlxuIHOKuyTTjfpuYEOLyH
	twM44o/IBjiNhPsDOL357gc4grioAjjDnckFONC2jgU4lPqlAzi3gOAHONO6nAY43qz/BTjm
	wo0EOMmaqQQ4345AOMagFjj2y+wBOMSvtwI49oydBjiT0qAGOOOE3wE40sPiBDibgY4BOK++
	2AU4+/icBjibxd4HQCVIw+zvA0i0qdkCSLma3QdIoLJ1SLOoKkiK2NIDSLKqiQZIsvKSB0jc
	1rwGSMiY+wRIubjzAkiNg+4GSPHl2gRI777VBkij6PACSK+01QRQEloKPGRlbGl2ZXIvPmAK
	aIaI5AFwmD54pe3sA4ABhDGKAQgIGBA0GImKFooBCQgGECcY2Nj5A4oBCQgUEDEY8+LHBIoB
	CggDEK0GGMSs2weKAQkIExA+GOKixgSKAQkIBBAlGML7rgGKAQgIDRA1GLueUYoBCQgYEB8Y
	q7DAA5ABCKABAKoBFGludm1haWw1LnNraHluaXguY29tsgEGCgSmffyRuAH000fCARAIASIM
	DdBnbmgSBWF2c3ltwgEYCAMiFA34WGxoEg1kYXl6ZXJvX3J1bGVzwgEbCAQiFw1KV2VgEhBn
	YXRla2VlcGVyX3J1bGVzwgECCAkagAFStUMQj1PjVdNoZT/OAPt2AocD97vLFII+h6s91m0S
	mF7sKLoCf1VxcIeIcprXRwHV6mIkqOm1liZtnc8x0/RpYbEGNPseRI+eggTUBb90OjNmVkDC
	24ml8nD574OJSsUKMQnwxFiTr62AkyD/0l+qqLwXM54ldy5MlpvIN5SFDSIEc2hhMSoDcnNh
	GcRSGa8CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hi all,

The MM subsystem is trying to reduce struct page to a single pointer.
See the following link for your information:

   https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

The first step towards that is splitting struct page by its individual
users, as has already been done with folio and slab.  This patchset does
that for page pool.

Matthew Wilcox tried and stopped the same work, you can see in:

   https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/

I focused on removing the page pool members in struct page this time,
not moving the allocation code of page pool from net to mm.  It can be
done later if needed.

The final patch removing the page pool fields will be posted once all
the converting of page to netmem are done:

   1. converting use of the pp fields in struct page in prueth_swdata.
   2. converting use of the pp fields in struct page in freescale driver.

For our discussion, I'm sharing what the final patch looks like, in this
cover letter.

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
Changes from v8:
	1. Rebase on net-next/main as of Jul 10.
	2. Exclude non-controversial patches that have already been
	   merged to net-next.
	3. Re-add the patches that focus on removing accessing the page
	   pool fields in struct page.
	4. Add utility APIs e.g. casting, to use struct netmem_desc as
	   descriptor, to support __netmem_get_pp() that has started to
	   be used again e.g. by libeth.

Changes from v7 (no actual updates):
	1. Exclude "netmem: introduce struct netmem_desc mirroring
	   struct page" that might be controversial.
	2. Exclude "netmem: introduce a netmem API,
	   virt_to_head_netmem()" since there are no users.

Changes from v6 (no actual updates):
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

Byungchul Park (8):
  netmem: introduce struct netmem_desc mirroring struct page
  netmem: introduce utility APIs to use struct netmem_desc
  page_pool: access ->pp_magic through struct netmem_desc in
    page_pool_page_is_pp()
  netmem: use netmem_desc instead of page to access ->pp in
    __netmem_get_pp()
  netmem: introduce a netmem API, virt_to_head_netmem()
  mlx4: use netmem descriptor and APIs for page pool
  netdevsim: use netmem descriptor and APIs for page pool
  mt76: use netmem descriptor and APIs for page pool

 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  48 ++---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
 drivers/net/netdevsim/netdev.c                |  19 +-
 drivers/net/netdevsim/netdevsim.h             |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c      |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
 .../net/wireless/mediatek/mt76/sdio_txrx.c    |  24 +--
 drivers/net/wireless/mediatek/mt76/usb.c      |  10 +-
 include/linux/mm.h                            |  12 --
 include/net/netmem.h                          | 183 +++++++++++++++---
 mm/page_alloc.c                               |   1 +
 12 files changed, 231 insertions(+), 98 deletions(-)


base-commit: c65d34296b2252897e37835d6007bbd01b255742
-- 
2.17.1


