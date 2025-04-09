Return-Path: <bpf+bounces-55516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD18A8227B
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AECE1B61FAB
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71AD25D918;
	Wed,  9 Apr 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQmuXzfv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AC1DDC23
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195308; cv=none; b=njGSHCpzWSVxoQxbjw9DmPZ0FKc8kbsEerZrVVTc9nMDhct8WEVQr+2qVvnFmDqqjE/5YwcCW6dH3aLqakkYTTiPKVoiFkPpw7PdCsC4VDRLkDtZxaO11bWWTY0jNwqQU6sHi9Fsp/HOe0ZKN3f6bC+w3JsUwkUf38klSr+Adsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195308; c=relaxed/simple;
	bh=rdkXoHwTQcpe9kpBuP+FM1rCbP3lpsXVEfw3XrDdl/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FftNK2xh+UPsFcUwYkUHpEVvpGrvk8IBEjCkW8VQ7/EKC5Vjg0q1M3kLY2ep5GGIahVlRTABoN0TS6jQA1hhdYxBbeEhittR5Le9Md+4K9L4863L7wh99NRg3bVjG3N1uLTRBt9IsBHp+CgnmKlNWnHzy11Gs6o8mEmC/2d17Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQmuXzfv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744195305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keCS6rkE8az6FRDrj2tr4grUSIWZ80Zg56Gr6+MNAxk=;
	b=CQmuXzfv3vBT8M0H3o5aO1CzrCbvqAlDYMzMxQ52PXYS9kJJ8PNNj5USIPnNwFgGWgCgQJ
	TIV75VSXIjuyDtFm8BBMshk37/re/LgPICmsAEDVdmFYaN9v80kpPY+OJ0sguE5/s/QWIX
	opEbYkVX8O3F5hh01WNQ4lKj6Q4D2Nc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-VLGjr5IcOPSDXpnHo61lpA-1; Wed, 09 Apr 2025 06:41:43 -0400
X-MC-Unique: VLGjr5IcOPSDXpnHo61lpA-1
X-Mimecast-MFC-AGG-ID: VLGjr5IcOPSDXpnHo61lpA_1744195303
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so672420966b.3
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 03:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195303; x=1744800103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keCS6rkE8az6FRDrj2tr4grUSIWZ80Zg56Gr6+MNAxk=;
        b=Ijd8p7EV+H12szfvIdNmCf3F3RDmh7boLHiIcX3kd6KiUCKDcyFgw78bYobZQbi1kd
         pOAw7scnIilZncA7ztnZfUpRiidUdrJx+kJsENuufkji43Hmxn+s0ZARpo8MqWYYcyaZ
         LJD4AY23J0CSGV/FofsygN1Sc+5zs80DHWoqurb7qH9evFsxw7v8SvvBolteOpUcdBho
         CjYjnbqjIaANd8E7p/bK2KbtNDSLK8k7+40vzAImF0tlMm/cmJD/VgHe/lw2LcIrvqMy
         4jHAs6OlJzfmBpLXzo2vh/FzLvmPmdQngzp9BS9imGfobC18WNYEIWH+ej/0omcZCZP3
         SU+A==
X-Forwarded-Encrypted: i=1; AJvYcCUHsZAIU6ALv/0jF/5KjHVVHj8H4Jprbn9eL2QwnX9ldK27l6974gnL8omYZsUh9ev6XS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNa4d9JBqog0IFKWmmS5w8BaCtJZUj7bwBT6QbwSh7ylJiZ8I
	BlHPYdGXbLAiIxit+T6P8rInRYJdOJ7Ow0M+NyINQh6NIlfkTJIWHQwos8sTMLs1awbNboKgRn0
	VY7YHafQNdsddgXVtsIZCGTveYM4Tg6xldTM10/BGgmSOtfgcMA==
X-Gm-Gg: ASbGncsFrFRxaAtwAOfR+JiWrcTjRnBMSsX9rzZiDTEJEfaiw5hCC3rKyeBYYFvV06y
	zY4rkGUwThpADPkWB4imIBZS64Pg+Z0a2ktyv32LQepkyosV0A7yRDVCx0Tpm8x/ur2J/7fZL9G
	TEdmOM2mt6I801XSD0EKtbaLmyIM8xECjp+EYq6EjhEcCS2ZnYOCfjDUQcfAoZKq4cZUvzgzoYe
	QmZJA8pZLM1JFsnyTZvv9Ss/wp7fWLLmk0xBMh4mcYJ1f8J4NznBntCjIGymlTqCS3csGGXR88y
	BllceIxE
X-Received: by 2002:a17:907:720e:b0:ac4:2a9:5093 with SMTP id a640c23a62f3a-aca9d6f41dcmr186462766b.41.1744195302601;
        Wed, 09 Apr 2025 03:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvXfYaDU2Kyv+qRtvaLu6bEQaj3q0t+O2IP75KWdM7fnM3F+iGoU29BBOyApnxG3CDOcUWTg==
X-Received: by 2002:a17:907:720e:b0:ac4:2a9:5093 with SMTP id a640c23a62f3a-aca9d6f41dcmr186459966b.41.1744195302155;
        Wed, 09 Apr 2025 03:41:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1c02227sm74617066b.81.2025.04.09.03.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:41:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9F09E19920B1; Wed, 09 Apr 2025 12:41:40 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 09 Apr 2025 12:41:36 +0200
Subject: [PATCH net-next v9 1/2] page_pool: Move pp_magic check into helper
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250409-page-pool-track-dma-v9-1-6a9ef2e0cba8@redhat.com>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
In-Reply-To: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
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
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
 include/linux/mm.h                               | 20 ++++++++++++++++++++
 mm/page_alloc.c                                  |  8 ++------
 net/core/netmem_priv.h                           |  5 +++++
 net/core/skbuff.c                                | 16 ++--------------
 net/core/xdp.c                                   |  4 ++--
 6 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index f803e1c93590068d3a7829b0683be4af019266d1..5ce1b463b7a8dd7969e391618658d66f6e836cc1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -707,8 +707,8 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 				page = xdpi.page.page;
 
-				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
-				 * as we know this is a page_pool page.
+				/* No need to check page_pool_page_is_pp() as we
+				 * know this is a page_pool page.
 				 */
 				page_pool_recycle_direct(page->pp, page);
 			} while (++n < num);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7f13f087954bdccfe1e263d39a59bfd1d738ab6..56c47f4a38ca491b2457b46660782ebe04c30046 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4248,4 +4248,24 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 #define VM_SEALED_SYSMAP	VM_NONE
 #endif
 
+/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
+ * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
+ * the head page of compound page and bit 1 for pfmemalloc page.
+ * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid recycling
+ * the pfmemalloc page.
+ */
+#define PP_MAGIC_MASK ~0x3UL
+
+#ifdef CONFIG_PAGE_POOL
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
+}
+#else
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd6b865cb1abfbd3d2ebd67cdaa5f86d92a62e14..a18340b3221835bc81a4db058e5b655575ef665c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -897,9 +897,7 @@ static inline bool page_expected_state(struct page *page,
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
 #endif
-#ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
-#endif
+			page_pool_page_is_pp(page) |
 			(page->flags & check_flags)))
 		return false;
 
@@ -926,10 +924,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
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
index 6cbf77bc61fce74c934628fd74b3a2cb7809e464..74a2d886a35b518d55b6d3cafcb8442212f9beee 100644
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
2.49.0


