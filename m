Return-Path: <bpf+bounces-55418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4F4A7E7A4
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 19:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BBC3AA879
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD750217663;
	Mon,  7 Apr 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCvCSyWh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF72135BD
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044928; cv=none; b=C6kvM3ZFqEEU1Us+Bo24gTDjFinjjSTApxHlPYUmpuxquSy4/qHmBkvWos0ebP2v6ZnCUH6rg0d+RJEIzJq5kYuQcmYntMouW1zOzbrXXIyg6+Z8tqtZ8TX2rR+JMTBev4OBikFacH3Yzms7Fn7+JN0FgR7DfLfZWi5HQ36kAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044928; c=relaxed/simple;
	bh=BtnfmSo/pDL7vIDDLNObZDZpUAYRt4VzHUSgexGFvtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOTNdsLLE/U0y2hhk/iUbbyGVSlQt70WkYjA2tTcY61LNzavouKj1DqxYTRb/uQYDZR8X2302eyJwY+OEv4Qi2NGZo6bqYcxvza+/8H+vXqutkSr5rxOPvG5OlOq6jY5J/VSi62CS3MTiYAuglaxkF1U3OSkunXVE4GbVaHuyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCvCSyWh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744044924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uOjWDhXK5MlXVzffQg4sX2fJ7S1/v80HTUaI6iK6sg=;
	b=cCvCSyWhivi41j/V2Fk0Yd52s+OVutXYMX0FHuce3nS5XeVpZM73mSfg0L0ZHeIKaep98X
	gtv61wYkrkTwU2CBtDt1a57YYFWSieEdfx5JeZOhVv0Qjd8jJT4wXGv1Bn/5oHsYhNYeME
	N8DIm5OSTq9su+OV1JU5P6bQNRY1h/4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269--3ZjuFftNcGXrh-XiaRyog-1; Mon, 07 Apr 2025 12:55:23 -0400
X-MC-Unique: -3ZjuFftNcGXrh-XiaRyog-1
X-Mimecast-MFC-AGG-ID: -3ZjuFftNcGXrh-XiaRyog_1744044922
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bf4297559so36696301fa.2
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 09:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044922; x=1744649722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uOjWDhXK5MlXVzffQg4sX2fJ7S1/v80HTUaI6iK6sg=;
        b=oIvNb3h3oq/zoFWDKBc7cvz3dBVVdazAEYL6yNKpn6+z2jWaL29VAoJ/vRbvDaV0Rq
         BOpRYaXW7ajKSav9tmt0GD7P7FNwEofRzjL45L4BAhypnCPCC4BnKfo8ATgj2NXvZQp7
         KD2xnKhhLovQZJ9DBOfIX6bOOWr7wvp9G/5uQLIrz3FutRZpyv4oAF4oqj7KDLDmFhDE
         OEI0b4+NXPI0ozyAeSLh2kSgx6Yp/plUJ7agTrvvnpetXPa0ynKSB2TdzNn3jIXlcX5u
         s8WRRc2vN0CwVTb3BxkvMCCCvSwB+rJpHwCs2gKMSF9kKMC3/TeuMtwMj0CWDViVxuga
         UHOg==
X-Forwarded-Encrypted: i=1; AJvYcCXQPmKPwu/ESGF3u3ou3gOmJ0QeTAm+EtCpDyPWemYACsn1xCDHDVjuFqwTsDXlAeh/8Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4dbcAhIfF9T4DPAOMYqZaDNXZH4lv4IDwpw8SbRjUmtkkoijA
	Xx8Dssq5lTVVNBfSc8XOLYmLNtRry18mHLALoYfAqSbPkjWZLaOJdrWsvoL4vLt0+XB19G3/g7p
	7fEWIhFw7b8pfjLihjVvLuf3gF+OatknwPkxy2SgR8eOKYEFGNQ==
X-Gm-Gg: ASbGnctLOEQMCMjtu4FsffS5MeP46MeVh6/nC7ixB7sZX93Mv9zmvZQ76HWhyYyXuGj
	f2qOinSf8UA1b0bXKO3uoRbsfunu8Ul0K9bUgnuM7MZHFqUmEHZB4dLlCKWbXEgGdc9819Lutjz
	WtMoNz9Xf0wmO6iFiJkbQCnUlkid9ij0ONYb/lXH2nUuQ/GYn+3BYMY3Nf+htfoT5GOUHy8DLWd
	LIsBUL1Bc1RaS3ZJLCXi0Mx9GaZNNWTkFm0T4lbNuiEGmaegzBegQVyCJ7zmqwLPYuIspYtYhzb
	Uu5JqhSoXO1f
X-Received: by 2002:a05:651c:988:b0:30c:15b:1268 with SMTP id 38308e7fff4ca-30f0bf2dd00mr33421931fa.15.1744044921588;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYWY2hL2juUcMMBXHQzWMHhnwy4fPLxZdp5hY7xQD602JPS3wKfPW5WzTGnq7lmui6fdhOTw==
X-Received: by 2002:a05:651c:988:b0:30c:15b:1268 with SMTP id 38308e7fff4ca-30f0bf2dd00mr33421681fa.15.1744044921179;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0313f430sm16057451fa.36.2025.04.07.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4E31619918DA; Mon, 07 Apr 2025 18:55:19 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 07 Apr 2025 18:53:28 +0200
Subject: [PATCH net-next v8 1/2] page_pool: Move pp_magic check into helper
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-page-pool-track-dma-v8-1-da9500d4ba21@redhat.com>
References: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
In-Reply-To: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
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
 include/linux/mm.h                               | 21 +++++++++++++++++++++
 include/net/page_pool/types.h                    |  1 +
 mm/page_alloc.c                                  |  8 ++------
 net/core/netmem_priv.h                           |  5 +++++
 net/core/skbuff.c                                | 16 ++--------------
 net/core/xdp.c                                   |  4 ++--
 7 files changed, 35 insertions(+), 24 deletions(-)

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
index b7f13f087954bdccfe1e263d39a59bfd1d738ab6..6f9ef1634f75701ae0be146add1ea2c11beb6e48 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4248,4 +4248,25 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
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
+
 #endif /* _LINUX_MM_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 36eb57d73abc6cfc601e700ca08be20fb8281055..31e6c5c6724b1cffbf5ad2535b3eaee5dec54d9d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -264,6 +264,7 @@ void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
 void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
+
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
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


