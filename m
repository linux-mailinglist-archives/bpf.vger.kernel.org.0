Return-Path: <bpf+bounces-61147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABDBAE1224
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 06:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEE819E359D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 04:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B620127D;
	Fri, 20 Jun 2025 04:12:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B331DC997;
	Fri, 20 Jun 2025 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392758; cv=none; b=O65uuWd9SiQibA6MQr6RrELF7BnHKt0PW8sUn6HhLJcArnQjqMzGJSrs6cJ3BfNLNpJZr5yx8KS/cHn8lSQyp8ejAxHvZ9wrJKLGLuDGMxWisyCKjUoC1vwI+OM4eAiGm5mb+4FK9UV0RgXDJnYfDpoxNqCbqgHpI/a9cBXnzIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392758; c=relaxed/simple;
	bh=AXKtdvnZAsd8KdK5cQFxVAKW+3xp3S98SAL+hOwHAzc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XGl0FYpmcGbYPFdJEdWTq4TEb6/2O+n16u6g8iiSVDOi4QifkXJGGJ9673r2IhasH3DU/goekYAcx7dQcaA79d52tPKKLgAO17uIYecqJ0JIyJ3MEYJR1hYvspiJZ2wU/WJ0qbG79Xla3gzWa2LKgGBiDxMRwza1ib4hs6gSunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-48-6854dfb26dca
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
Subject: [PATCH net-next v6 0/9] Split netmem from struct page
Date: Fri, 20 Jun 2025 13:12:15 +0900
Message-Id: <20250620041224.46646-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnXNcDk7L8qhQtAprmGVM+iFh9iE6BIag9cEIW3powzlt
	6pqBqCmI1+yK15hZy2uLKToveZnXSEgNY2Y6mWlZXkpteaNySt8e3of3/fJSmKgZd6cUqjhO
	rZIpxYQAF8w5lx4zWkPkJ9LavKHYUE1A1YoWXkyY+FBcWY9geXWUhKWuXgLKSu0YFL9Lw+GX
	YQ2DqR4bCVXGQLDqp3FoSW/AwHa3j4CctHUMXq/Ok3DHVM6DgfpcPjxce45BQ/IECe+bigkY
	r/7Lh2lzDg5vCitwsOYGQI9uL9jfziLoMjTwwJ5dQsCDIR0Bk2lWBEOdNhyKUnIRGFotfFhf
	2dwo6h4nAw6xnbMLGFtXMcJjGwvHSFZnjGdryyVspmUIY42VGQRrXLxPsp8+tBBsX/46zjaa
	lnhsTuo8wf6c+oizC63DBGuoG8bZfl0XGbQrVHA6glMqNJz6uP81gbzvySQ/ZtpXm/J0A0tG
	i5JMRFEMLWXSTZGZyGkLy77M4A4maE/GYlnFHOxC+zBLtt7NXEBhdA3BdFWPkg6xm/ZnRjvG
	CAfj9GHGXtO9xULalxmZGeNtj+5nql61Y44yQ8+RzMzgI/62cGM6yi14HtqpQzsqkUih0kTJ
	FEqptzxBpdB6h0dHGdHmpfrEjSsmtDgQbEY0hcTOQtNysFzEl2liE6LMiKEwsYuwrO+iXCSM
	kCXc5tTRYep4JRdrRh4ULnYVnrTfihDRN2RxXCTHxXDq/5ZHObkno6PNTlel09edVaEJX/1M
	2bP7orPy97SfeRni9SeswNZUqASr5Jm72fOyNqm2dDTyQOI5wWJG1nLTt+83ay7kecRrhQeT
	SofOJwaGNYn5rq3Op5JL/Ky/TYNemim3BenM8ucfuRr9gib1rD4/RfI46J5bVVu4/kj/pZIC
	r9SiEXedGI+Vy3wkmDpW9g/ZxSwrzgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRyHe3fOzjmOBoeledAP5UoiIS+Q8O+CCUG9BV4oQfJDespDW943
	XVMovEWkaWYFpfOONnWyXKKzVGre6YOlWDPzwsQbmaau4VQqLfr28Hvg+fJjCFk56cEoE1MF
	VSIfL6ckpCT0VM4x01SEwn+13wN0RgMFjRtaeDFtFoOuoRWB3TlOw3pPPwU1VQ4CdEO5JPw0
	bhIw22ejodEUAlN1cyR03GsjwPZwgIKC3C0COp3LNGSb9SLoLhsUw4fWQjE82awloC1zmoaR
	1zoKJg2/xTBnKSBhsKSehKnCYOir3A+O90sIeoxtInA8KKPg8XAlBTO5UwiGu20klGYVIjB2
	WcWwtbHTKO2dpIO9cffSCoFb6sdEuL1kgsaVpjT8Su+D86zDBDY13Kewaa2Yxl8/dVB44NkW
	idvN6yJckLNM4dXZLyRe6RqlcM3CDxE2toyS4bIoyelYIV6pEVR+QTESxUD5jDh5LlCbVb1N
	ZKI1nzzkwnDsca5mfpHcZYo9wlmtTmKXXdkAbt3Wv7NLGIJtorgewzi9K/axQdz4uwlql0nW
	m3M09f5lKRvIjS1OiP5FD3CNL98SRYipRHsakKsyUZPAK+MDfdVxivREpdb3elKCCe28Vnd7
	+5EZ2UfOWxDLIPleqdl+WSET8xp1eoIFcQwhd5XWDIQqZNJYPj1DUCVFq9LiBbUFeTKk3F16
	MVKIkbE3+FQhThCSBdV/K2JcPDJR1CX7UGxE/uybjo3vGr/ouxlF+Ue7zhxUFIe515V63XFD
	bkHnsheM1cGHKvxqU7IdtCHlii4kvXk4kvlYFbvdfvbpwQvarRRbbWZzuKR7u+fk4eciz9Um
	k36lxct1if+Vcyvvs/KaF77p0qTU+5c4Peybqd/ms4OvdobZ+I4TFXJSreADfAiVmv8DwegM
	EbECAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hi all,

In this version, I'm posting non-controversial patches first.  I will
post the rest later.  This version has no update but adding given
'Reviewed-by's and 'Acked-by's.  See the changes below.

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
	1. Rease on net-next/main as of Jun 20.
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


base-commit: 4f4040ea5d3e4bebebbef9379f88085c8b99221c
-- 
2.17.1


