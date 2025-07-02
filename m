Return-Path: <bpf+bounces-62069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F9AF0ADD
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67BF7AE6E2
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622B1F4C92;
	Wed,  2 Jul 2025 05:48:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED7199FAB;
	Wed,  2 Jul 2025 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435297; cv=none; b=l0M1fK20M9AtvbPzKIV3uJ9kVMNDK0/DomV/ME8gQEvLXeIZv5AIS0Iay5eF4S0t/oBvAh/j/oagJqymg3ZTmvXjNTxHD1jw/U6/KBjLXmVgFb2nHCDzoiU0CIKGmR8QUYe6wwFJYXLhIhM3DRyR/UuUUmCbr6hLmmrpCpaBfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435297; c=relaxed/simple;
	bh=4hD4MOimnEYWCD4hSnlRjGStBdpJEfn2L1ZQnbN4BHY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=t5kH1dl+FDfcKy0hjKevXxNH0kYnAWKlrlLSx7MgKjxHBSJiUw8/JWNksvT2vge4yDyTU3YidBIYzdXh15B0kczDffQC3bRlysOSwDj6uWFGh0J2CKvLLeOT9TEwFTv8plJ5NYBsfC6yHS33Ud5K74aj29ynuDz2iB64FYxLOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fd-6864c492d922
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
Subject: [PATCH net-next v8 0/5] Split netmem from struct page
Date: Wed,  2 Jul 2025 14:32:51 +0900
Message-Id: <20250702053256.4594-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzXRW0hTcRwHcP87Z+ccl4s1xU6OMpYhSa60GT9DzB6C40MQ6kv5oMMd3Eg3
	mXfpYjmShi7TCtMZs8jbrMW8TTGrudTQSixr5WWy0oK8kNrw1sV1efvw/cL35Uthwi48gFKq
	sliNSpYmJng4b87nTmi5Xa44WFwfAgZzMwGmlTyon7JywdDUjmB5dYyEJXs/AXdr3RgYXmlx
	+G5ew2C6z0WCyXICnHUzOHQXd2DgujpAQKl2HYNHq/MkXLI2cGC4Xc+F62v3MOgonCLhdZeB
	gMnmX1yYsZXi8LyqEQenPgb6jP7gHpxFYDd3cMBdUkNAxYiRgI9aJ4KRXhcO1Rf1CMw9Di6s
	r2xuVD+bJGOCmN7ZBYxpbXzPYTqrJkjGaMlmWhpCGJ1jBGMsTVcIxrJYTjLjb7sJZqByHWc6
	rUscprRonmC+TX/AmYWeUYIxt47izJDRTp7cdpoXJWfTlDms5kB0Mk9hqGjnZBRBnsN6CytE
	s/t1yJuiBVJ6ftJM6BD1xz9WhZ6YEATTDscq5rGfIIxecvXjOsSjMMF9grY3j5GewlcQTbeM
	rxEe44K9dH1zPfKYv7kzMfwT+7sfSJsePvnnOZKuqYv/6x300wYHXoa2GJFXExIqVTnpMmWa
	VKLIVynzJCnqdAvafLTu3EaiFS0Ox9uQgEJiH/7AmxSFkCvLycxPtyGawsR+/K07NyO+XJZf
	wGrUSZrsNDbThkQULt7OD3fnyoWCVFkWe4ZlM1jN/5ZDeQcUIto4P1CmP/pZGnEqcGUpLoLS
	T+VmqKWlgZ8GbyepbMHvEo7vERVdiNq3K9IZ8UXygJ96rS3ucLTqpXmjIPx80Vl1kr9FgSWl
	y2PnDEEBQy+IY6HhIqMmeVkbENs27qt5PJRrK5dc3jANiqjIyhKp68gNV8LX2puHvHY75LQx
	UYxnKmRhIZgmU/Ybuabfrs0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRyG+++cnR2Hi8M0O2kWjCSw1IyCH6VD6UOnQJEKor7k1IMbblM2
	NTUEb91Ep+kC0wkLSd2cTKboDBOZ84ZU4o2VVxZKgqmpTTcz24K+Pbwv7/PlJTFhIx5MypTZ
	rEopkYsIPs5PvF4aUWNPk14yHZ0CndlEQNt+HrQsW7mgM3Yj2HXP8WDHPkJA01sXBrrPZTj8
	MnswWBl28qDNkgBLzas49D3vwcBZNUpAZdkBBh/cGzwosbZyYLBxjAsT3RouaD3vMOgpWubB
	1HsdAYumIy6s2ipxGKs34LCkiYNhfRC4xtcR2M09HHBVNBJQO6kn4FvZEoLJQScODcUaBOZ+
	BxcO9r2OhqFFXlwYM7i+iTFdhi8cprd+gcfoLTlMZ2s4U+6YxBiL8SXBWLZreMz8bB/BjNYd
	4EyvdYfDVJZuEMzPla84s9k/QzBN37c4jLlrBk8SPuTHpLFyWS6rihIn86W62m5OVinkOaxv
	sCK0frEckSRNXaEP3cJy5EcS1Hna4XBjPg6koukd5whejvgkRrUTtN00x/MVAZSY7pz3ED7G
	qTC6xdSCfCzwehYm/vwb09RZuq1jAKtGpB4dM6JAmTJXIZHJr0aqM6T5SlleZGqmwoK8pzUX
	/n5lRbtTN22IIpHIXzDwMVUq5Epy1fkKG6JJTBQoOB7qjQRpkvwCVpX5SJUjZ9U2FELiopOC
	2/fZZCGVLslmM1g2i1X9bzmkX3ARyiI1a9IfFxRhuo5707sljwPaP7WaomOnE18DfQKT9hvO
	nD7X/1SVnrK8528UxnfHxKQUJBmGiPHRJzvXDivsjllbQry2ulNYl5ozv7aoFWv3CiOCjC2u
	8X1P8VZghPRBX6ygK/yZcPuFouIWGRpyeauq3T+q4cZd8ZbrjsYgwtVSSXQ4plJL/gLMc8aZ
	sAIAAA==
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

Byungchul Park (5):
  page_pool: rename page_pool_return_page() to page_pool_return_netmem()
  page_pool: rename __page_pool_release_page_dma() to
    __page_pool_release_netmem_dma()
  page_pool: rename __page_pool_alloc_pages_slow() to
    __page_pool_alloc_netmems_slow()
  netmem: use _Generic to cover const casting for page_to_netmem()
  page_pool: make page_pool_get_dma_addr() just wrap
    page_pool_get_dma_addr_netmem()

 include/net/netmem.h            |  7 +++----
 include/net/page_pool/helpers.h |  7 +------
 net/core/page_pool.c            | 36 ++++++++++++++++-----------------
 3 files changed, 22 insertions(+), 28 deletions(-)


base-commit: 8dacfd92dbefee829ca555a860e86108fdd1d55b
-- 
2.17.1


