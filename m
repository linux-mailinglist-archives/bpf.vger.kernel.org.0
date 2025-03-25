Return-Path: <bpf+bounces-54692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8469A7057E
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA68A3AFDBD
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D81922FA;
	Tue, 25 Mar 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eM16o6nz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7C1A316E
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917605; cv=none; b=fJYd6FBrE3o/WY5haQQmf6bOn0aJDWISRMdRwm2P4eLmFq5lmQESJk6EfIXCQg5PjOpDJKwSGgU9d6TyHwziz1JQyF2IOjWMEXQ0E5HQU7Q+utGcWsxgVcpu5+q36mpZNVgMTMPfWfTZO1/pZS0sNmx4UXlRfC7Miwapk4lOVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917605; c=relaxed/simple;
	bh=4I05eVH/+uUp2ErZURt+83KwIztisW9+7S+LIhJyfXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IjnG/mUrWzXS2N3O5/jtSstOoYdAG77kpDmy/gc0yN8IPMPMP01TGHEfWwcTms//RQGlnpqRfJlmP/VFsofJc/FjeqdVzSESQNH9krX3TxIB3F0f474+P4xGpEyD0s2w9x5pAIVHUxylycU+HCmA5yvVQDXwcS0823WFiBAH81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eM16o6nz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHU3gd5R+PcFSPJyd+8lTgr7QvXzHN6SGWRXjaUKaHA=;
	b=eM16o6nzZz0/vjwgHZ+teEw9shTtdaMXE1Pduf5QmW3pOzpZpPlWPYymbcU+K7AS7eynRt
	9c1QV1GDKyWX4KKn36ECtBrtMiZHfsv0hjk6TUsl1KWxXUIJ/cPvNx7VvOBONA/Xjvg7M5
	JlgVzMW1kqB8SsuWb19kVK6KCj57YTY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-6c6sUQpDNxyaj2sNSOfXNQ-1; Tue, 25 Mar 2025 11:46:41 -0400
X-MC-Unique: 6c6sUQpDNxyaj2sNSOfXNQ-1
X-Mimecast-MFC-AGG-ID: 6c6sUQpDNxyaj2sNSOfXNQ_1742917600
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac27f00a8a5so443545866b.3
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 08:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917600; x=1743522400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHU3gd5R+PcFSPJyd+8lTgr7QvXzHN6SGWRXjaUKaHA=;
        b=uV9LvZZ0bYVnL4l4RZqSw0Znrg4K3bYDG0+IWogVhOI2i8gjNpm6kMh7U7mh4shER1
         lfT20zlJtqlJQBkya6508ngGl1ler/9kWkE6JgE9T/qHHTHiUtCZHG09neNbc2xTLSai
         fpuNfRCBvuVAvks8mHDPNcRXYtQeHw18phxES7HDlzGqF6vYFmTL/5wuGTmhKPr7xMql
         3k0ufCMCdJmrnWMmjkIyaYnrvL4GBtqxSWpU85FGFmKQFb3wkX+UizUa5v21BaSmXp0k
         aZOu05iJjziCYZ/LFO2/UTlEE+oZOIMRD8oE+UuXzrcJRhHu77pujgvzGlk2bTJT+IBv
         3PGg==
X-Forwarded-Encrypted: i=1; AJvYcCW2GcYBIjJo41XGj0J1v53002VAO5yCXVJKqBtleSGUiAUTwMTxh35cMG11UtnU9RoYzVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTl6HhEXiq++aFC2n8IX03M9V5BvgcLgKSjxi18fw0Ptxl1DcI
	DMuYuIChLEOLieYsdglk5yAR0oSnf0FPCGv4zTKv/XpXFHcTR4swKWNhmYPgP7HLx+qMEgQzryM
	LatcPtOl3nPk8hOy6I+DzTalUBLpHglC0dUOmsAPy/6nqCj3Y3g==
X-Gm-Gg: ASbGncsMRVuhq2I7VzJAQ15t2f8b8LZDH5l7hbjJrrA5DS6nruOBR6O6Mxe5nDysDj/
	sJrYkggZJH1GxHBDa5sBEojgPcjoAYFt9ZBuqJe688zQwOb2K661g2ooM4hvdSoY/JUA2tLHy94
	S93LAa1o50E4CaKg99ULu60L2hugNwod266UcHk+GdIkRFVA2v1ezWNg8A7thP6xtId1P91FJHi
	432k7gK7R2HUPs6RJx0KLcsqR5SV+ty0kXrE5yxQ4K+Oi7Vxu0ZroU+a25eG+WR181NOWyS69w0
	yDJwfIjihXGptTegXzF53URik9CrRzj75DcH+Nzi
X-Received: by 2002:a17:907:d786:b0:ac3:48e4:f8bb with SMTP id a640c23a62f3a-ac3f24adcd2mr2028798366b.41.1742917599851;
        Tue, 25 Mar 2025 08:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHYnNtpCnvUp6kAetaPQVboemrGa0ubCCpu4/locWPfqZN0d+JRIaI57zV4LgX72gZ8HdAqQ==
X-Received: by 2002:a17:907:d786:b0:ac3:48e4:f8bb with SMTP id a640c23a62f3a-ac3f24adcd2mr2028794266b.41.1742917599357;
        Tue, 25 Mar 2025 08:46:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e52c6sm863354366b.70.2025.03.25.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:46:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C703818FC8B8; Tue, 25 Mar 2025 16:46:36 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 25 Mar 2025 16:45:42 +0100
Subject: [PATCH net-next v2 1/3] page_pool: Move pp_magic check into helper
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-page-pool-track-dma-v2-1-113ebc1946f3@redhat.com>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
In-Reply-To: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Since we are about to stash some more information into the pp_magic
field, let's move the magic signature checks into a pair of helper
functions so it can be changed in one place.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
 include/net/page_pool/types.h                    | 18 ++++++++++++++++++
 mm/page_alloc.c                                  |  9 +++------
 net/core/netmem_priv.h                           |  5 +++++
 net/core/skbuff.c                                | 16 ++--------------
 net/core/xdp.c                                   |  4 ++--
 6 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 6f3094a479e1ec61854bb48a6a0c812167487173..70c6f0b2abb921778c98fbd428594ebd7986a302 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -706,8 +706,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-				 * as we know this is a page_pool page.
+				/* No need to check page_pool_page_is_pp() as we
+				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(page->pp, page);
 			} while (++n < num);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb26173135ff37951ef8 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -54,6 +54,14 @@ struct pp_alloc_cache {
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
+/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
+ * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
+ * the head page of compound page and bit 1 for pfmemalloc page.
+ * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid recycling
+ * the pfmemalloc page.
+ */
+#define PP_MAGIC_MASK ~0x3UL
+
 /**
  * struct page_pool_params - page pool parameters
  * @fast:	params accessed frequently on hotpath
@@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
 void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
+
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
 {
 }
+
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
 #endif
 
 void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 542d25f77be80304b731411ffd29b276ee13be0c..3535ee76afe946cbb042ecbce603bdbedc9233b9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <net/page_pool/types.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -872,9 +873,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-#ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
-#endif
+			page_pool_page_is_pp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -901,10 +900,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
 #endif
-#ifdef CONFIG_PAGE_POOL
-	if (unlikely((page->pp_magic & ~0x3UL) == PP_SIGNATURE))
+	if (unlikely(page_pool_page_is_pp(page)))
 		bad_reason = "page_pool leak";
-#endif
 	return bad_reason;
 }
 
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
index 7eadb8393e002fd1cc2cef8a313d2ea7df76f301..f33162fd281c23e109273ba09950c5d0a2829bc9 100644
--- a/net/core/netmem_priv.h
+++ b/net/core/netmem_priv.h
@@ -18,6 +18,11 @@ static inline void netmem_clear_pp_magic(netmem_ref netmem)
 	__netmem_clear_lsb(netmem)->pp_magic = 0;
 }
 
+static inline bool netmem_is_pp(netmem_ref netmem)
+{
+	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+
 static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
 {
 	__netmem_clear_lsb(netmem)->pp = pool;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab8acb737b93299f503e5c298b87e18edd59d555..a64d777488e403d5fdef83ae42ae9e4924c1a0dc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -893,11 +893,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_netmem(netmem_ref netmem)
-{
-	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
-}
-
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -995,14 +990,7 @@ bool napi_pp_put_page(netmem_ref netmem)
 {
 	netmem = netmem_compound_head(netmem);
 
-	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
-	 * in order to preserve any existing bits, such as bit 0 for the
-	 * head page of compound page and bit 1 for pfmemalloc page, so
-	 * mask those bits for freeing side when doing below checking,
-	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
-	 * to avoid recycling the pfmemalloc page.
-	 */
-	if (unlikely(!is_pp_netmem(netmem)))
+	if (unlikely(!netmem_is_pp(netmem)))
 		return false;
 
 	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
@@ -1042,7 +1030,7 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		head_netmem = netmem_compound_head(shinfo->frags[i].netmem);
-		if (likely(is_pp_netmem(head_netmem)))
+		if (likely(netmem_is_pp(head_netmem)))
 			page_pool_ref_netmem(head_netmem);
 		else
 			page_ref_inc(netmem_to_page(head_netmem));
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a77eb63a96a85aa6d068d3e94f077..0ba73943c6eed873b3d1c681b3b9a802b590f2d9 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -437,8 +437,8 @@ void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		netmem = netmem_compound_head(netmem);
 		if (napi_direct && xdp_return_frame_no_direct())
 			napi_direct = false;
-		/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-		 * as mem->type knows this a page_pool page
+		/* No need to check netmem_is_pp() as mem->type knows this a
+		 * page_pool page
 		 */
 		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
 					  napi_direct);

-- 
2.48.1


