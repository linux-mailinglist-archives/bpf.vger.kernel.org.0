Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534E8160326
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2020 10:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgBPJlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Feb 2020 04:41:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35708 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgBPJlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Feb 2020 04:41:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so15300857wmb.0
        for <bpf@vger.kernel.org>; Sun, 16 Feb 2020 01:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2aGPgxCyTkb7lyWqHCNYOLY4A+q/EdkK6TKZxkHNksE=;
        b=CqLkxbg8MaxERZFcSRKbeDuvF5K2BIEuIGlU5N/dBd7iX33BO+y1iCEJOk/G7hhU8K
         DQ83W0pVBQv1E2k4n+tu9MDyFjGrPef3UsdSPnI+bqzKO41zZ+ihBKLNPjV8i6VPsPsj
         4//+1rfJ7CfA7KgDFtwRh3WWi9XipPffkTrqQDvqV6lYoIMIwbnq8L9pKTidptfjb/BJ
         am/Di2EjI6TQvqw3O3yaV8Mq8t55mIfzDB3B/HC2GiEqn3Tg5qQUGjMGQiddCGczUglm
         uxOL1hr9xSTjeD9aFVWw4TN5abPjhIl4W+hBuua3e0SyF5SLGYsmDMNKp+8cDIsE3bDB
         FwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2aGPgxCyTkb7lyWqHCNYOLY4A+q/EdkK6TKZxkHNksE=;
        b=RQMV971zJFvwCizqj1yh4YUscdV0GSB94+PJ2/679IUbuV5/CCrOx/xhGlZ8SpPgXY
         PfnNW10upzQOOPVttK0/lS5DqYADt09U0a9V/sWcTFmtAuaOStTC7d2+4nQ1kOZvet4o
         YVE9ofiHC14oOPfBEO2yYfcjBP7OI3P9h2aYM7O0weXBl0CuTSObDvSMzT9WNyi9TY54
         uaaJ3uk5St6LbOfkqVPNm0DMj2dzF5/DZskRACKHWq6ZFdbQi93QTNIqjdcdG61w3NBz
         uk6rc3M4AtmdBlzKtLCJzcsk5ruPJ2H0Uov2bzqEftIrNtC44W+K6An/B/hOGFJvGHDy
         ADOA==
X-Gm-Message-State: APjAAAUm+yAYjl+cSYIaUnD5Bs1YzToAhUdkcm+hSEGp2kSeGlpi96iD
        bust4oHZQIA8jSbAoYmXYf1RIQ==
X-Google-Smtp-Source: APXvYqwWL2K28ycs32QjMPPli1XWjok13/+Ul8LX1Ym79PEy/NTKLbyeyAwhNQWPHhQNuor4G/dK6g==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr15621875wme.90.1581846079499;
        Sun, 16 Feb 2020 01:41:19 -0800 (PST)
Received: from apalos.home ([2a02:587:4655:3a80:2e56:dcff:fe9a:8f06])
        by smtp.gmail.com with ESMTPSA id a184sm15471124wmf.29.2020.02.16.01.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 01:41:18 -0800 (PST)
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     netdev@vger.kernel.org
Cc:     jonathan.lemon@gmail.com, lorenzo@kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: [PATCH net-next] net: page_pool: API cleanup and comments
Date:   Sun, 16 Feb 2020 11:40:55 +0200
Message-Id: <20200216094056.8078-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Functions starting with __ usually indicate those which are exported,
but should not be called directly. Update some of those declared in the
API and make it more readable.

page_pool_unmap_page() and page_pool_release_page() were doing
exactly the same thing. Keep the page_pool_release_page() variant
and export it in order to show up on perf logs.
Finally rename __page_pool_put_page() to page_pool_put_page() since we
can now directly call it from drivers and rename the existing
page_pool_put_page() to page_pool_put_full_page() since they do the same
thing but the latter is trying to sync the full DMA area.

Also update netsec, mvneta and stmmac drivers which use those functions.

Suggested-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/net/ethernet/marvell/mvneta.c         | 19 +++---
 drivers/net/ethernet/socionext/netsec.c       | 21 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +-
 include/net/page_pool.h                       | 38 +++++------
 net/core/page_pool.c                          | 64 ++++++++++---------
 net/core/xdp.c                                |  2 +-
 6 files changed, 73 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 98017e7d5dd0..22b568c60f65 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1933,7 +1933,7 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 		if (!data || !(rx_desc->buf_phys_addr))
 			continue;
 
-		page_pool_put_page(rxq->page_pool, data, false);
+		page_pool_put_full_page(rxq->page_pool, data, false);
 	}
 	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
 		xdp_rxq_info_unreg(&rxq->xdp_rxq);
@@ -2108,9 +2108,9 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvneta_rx_queue *rxq,
 		err = xdp_do_redirect(pp->dev, xdp, prog);
 		if (err) {
 			ret = MVNETA_XDP_DROPPED;
-			__page_pool_put_page(rxq->page_pool,
-					     virt_to_head_page(xdp->data),
-					     len, true);
+			page_pool_put_page(rxq->page_pool,
+					   virt_to_head_page(xdp->data), len,
+					   true);
 		} else {
 			ret = MVNETA_XDP_REDIR;
 		}
@@ -2119,9 +2119,9 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvneta_rx_queue *rxq,
 	case XDP_TX:
 		ret = mvneta_xdp_xmit_back(pp, xdp);
 		if (ret != MVNETA_XDP_TX)
-			__page_pool_put_page(rxq->page_pool,
-					     virt_to_head_page(xdp->data),
-					     len, true);
+			page_pool_put_page(rxq->page_pool,
+					   virt_to_head_page(xdp->data), len,
+					   true);
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
@@ -2130,9 +2130,8 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvneta_rx_queue *rxq,
 		trace_xdp_exception(pp->dev, prog, act);
 		/* fall through */
 	case XDP_DROP:
-		__page_pool_put_page(rxq->page_pool,
-				     virt_to_head_page(xdp->data),
-				     len, true);
+		page_pool_put_page(rxq->page_pool,
+				   virt_to_head_page(xdp->data), len, true);
 		ret = MVNETA_XDP_DROPPED;
 		break;
 	}
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index e8224b543dfc..8ad6c971bdfa 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -896,9 +896,9 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, struct bpf_prog *prog,
 	case XDP_TX:
 		ret = netsec_xdp_xmit_back(priv, xdp);
 		if (ret != NETSEC_XDP_TX)
-			__page_pool_put_page(dring->page_pool,
-					     virt_to_head_page(xdp->data),
-					     len, true);
+			page_pool_put_page(dring->page_pool,
+					   virt_to_head_page(xdp->data), len,
+					   true);
 		break;
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(priv->ndev, xdp, prog);
@@ -906,9 +906,9 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, struct bpf_prog *prog,
 			ret = NETSEC_XDP_REDIR;
 		} else {
 			ret = NETSEC_XDP_CONSUMED;
-			__page_pool_put_page(dring->page_pool,
-					     virt_to_head_page(xdp->data),
-					     len, true);
+			page_pool_put_page(dring->page_pool,
+					   virt_to_head_page(xdp->data), len,
+					   true);
 		}
 		break;
 	default:
@@ -919,9 +919,8 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, struct bpf_prog *prog,
 		/* fall through -- handle aborts by dropping packet */
 	case XDP_DROP:
 		ret = NETSEC_XDP_CONSUMED;
-		__page_pool_put_page(dring->page_pool,
-				     virt_to_head_page(xdp->data),
-				     len, true);
+		page_pool_put_page(dring->page_pool,
+				   virt_to_head_page(xdp->data), len, true);
 		break;
 	}
 
@@ -1020,8 +1019,8 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 			 * cache state. Since we paid the allocation cost if
 			 * building an skb fails try to put the page into cache
 			 */
-			__page_pool_put_page(dring->page_pool, page,
-					     pkt_len, true);
+			page_pool_put_page(dring->page_pool, page, pkt_len,
+					   true);
 			netif_err(priv, drv, priv->ndev,
 				  "rx failed to build skb\n");
 			break;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5836b21edd7e..37920b4da091 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1251,11 +1251,11 @@ static void stmmac_free_rx_buffer(struct stmmac_priv *priv, u32 queue, int i)
 	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
 
 	if (buf->page)
-		page_pool_put_page(rx_q->page_pool, buf->page, false);
+		page_pool_put_full_page(rx_q->page_pool, buf->page, false);
 	buf->page = NULL;
 
 	if (buf->sec_page)
-		page_pool_put_page(rx_q->page_pool, buf->sec_page, false);
+		page_pool_put_full_page(rx_q->page_pool, buf->sec_page, false);
 	buf->sec_page = NULL;
 }
 
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index cfbed00ba7ee..7c1f23930035 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -162,39 +162,33 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 }
 #endif
 
-/* Never call this directly, use helpers below */
-void __page_pool_put_page(struct page_pool *pool, struct page *page,
-			  unsigned int dma_sync_size, bool allow_direct);
+void page_pool_release_page(struct page_pool *pool, struct page *page);
 
-static inline void page_pool_put_page(struct page_pool *pool,
-				      struct page *page, bool allow_direct)
+/* If the page refcnt == 1, this will try to recycle the page.
+ * if PP_FLAG_DMA_SYNC_DEV is set, it will try to sync the DMA area for
+ * the configured size min(dma_sync_size, pool->max_len).
+ * If the page refcnt != page will be returned
+ */
+void page_pool_put_page(struct page_pool *pool, struct page *page,
+			unsigned int dma_sync_size, bool allow_direct);
+
+/* Same as above but will try to sync the entire area pool->max_len */
+static inline void page_pool_put_full_page(struct page_pool *pool,
+					   struct page *page, bool allow_direct)
 {
 	/* When page_pool isn't compiled-in, net/core/xdp.c doesn't
 	 * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
 	 */
 #ifdef CONFIG_PAGE_POOL
-	__page_pool_put_page(pool, page, -1, allow_direct);
+	page_pool_put_page(pool, page, -1, allow_direct);
 #endif
 }
-/* Very limited use-cases allow recycle direct */
+
+/* Same as above but the caller must guarantee safe context. e.g NAPI */
 static inline void page_pool_recycle_direct(struct page_pool *pool,
 					    struct page *page)
 {
-	__page_pool_put_page(pool, page, -1, true);
-}
-
-/* Disconnects a page (from a page_pool).  API users can have a need
- * to disconnect a page (from a page_pool), to allow it to be used as
- * a regular page (that will eventually be returned to the normal
- * page-allocator via put_page).
- */
-void page_pool_unmap_page(struct page_pool *pool, struct page *page);
-static inline void page_pool_release_page(struct page_pool *pool,
-					  struct page *page)
-{
-#ifdef CONFIG_PAGE_POOL
-	page_pool_unmap_page(pool, page);
-#endif
+	page_pool_put_full_page(pool, page, true);
 }
 
 static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9b7cbe35df37..464500c551e8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -96,7 +96,7 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 }
 EXPORT_SYMBOL(page_pool_create);
 
-static void __page_pool_return_page(struct page_pool *pool, struct page *page);
+static void page_pool_return_page(struct page_pool *pool, struct page *page);
 
 noinline
 static struct page *page_pool_refill_alloc_cache(struct page_pool *pool,
@@ -137,7 +137,7 @@ static struct page *page_pool_refill_alloc_cache(struct page_pool *pool,
 			 * (2) break out to fallthrough to alloc_pages_node.
 			 * This limit stress on page buddy alloactor.
 			 */
-			__page_pool_return_page(pool, page);
+			page_pool_return_page(pool, page);
 			page = NULL;
 			break;
 		}
@@ -281,17 +281,20 @@ static s32 page_pool_inflight(struct page_pool *pool)
 }
 
 /* Cleanup page_pool state from page */
-static void __page_pool_clean_page(struct page_pool *pool,
-				   struct page *page)
+static void page_pool_clean_page(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
 	int count;
 
 	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+		/* Always account for inflight pages, even if we didn't
+		 * map them
+		 */
 		goto skip_dma_unmap;
 
 	dma = page->dma_addr;
-	/* DMA unmap */
+
+	/* When page is unmapped, it cannot be returned our pool */
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC);
@@ -304,20 +307,23 @@ static void __page_pool_clean_page(struct page_pool *pool,
 	trace_page_pool_state_release(pool, page, count);
 }
 
-/* unmap the page and clean our state */
-void page_pool_unmap_page(struct page_pool *pool, struct page *page)
+/* Disconnects a page (from a page_pool).  API users can have a need
+ * to disconnect a page (from a page_pool), to allow it to be used as
+ * a regular page (that will eventually be returned to the normal
+ * page-allocator via put_page).
+ */
+void page_pool_release_page(struct page_pool *pool, struct page *page)
 {
-	/* When page is unmapped, this implies page will not be
-	 * returned to page_pool.
-	 */
-	__page_pool_clean_page(pool, page);
+#ifdef CONFIG_PAGE_POOL
+	page_pool_clean_page(pool, page);
+#endif
 }
-EXPORT_SYMBOL(page_pool_unmap_page);
+EXPORT_SYMBOL(page_pool_release_page);
 
 /* Return a page to the page allocator, cleaning up our state */
-static void __page_pool_return_page(struct page_pool *pool, struct page *page)
+static void page_pool_return_page(struct page_pool *pool, struct page *page)
 {
-	__page_pool_clean_page(pool, page);
+	page_pool_release_page(pool, page);
 
 	put_page(page);
 	/* An optimization would be to call __free_pages(page, pool->p.order)
@@ -326,8 +332,7 @@ static void __page_pool_return_page(struct page_pool *pool, struct page *page)
 	 */
 }
 
-static bool __page_pool_recycle_into_ring(struct page_pool *pool,
-				   struct page *page)
+static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
 {
 	int ret;
 	/* BH protection not needed if current is serving softirq */
@@ -344,7 +349,7 @@ static bool __page_pool_recycle_into_ring(struct page_pool *pool,
  *
  * Caller must provide appropriate safe context.
  */
-static bool __page_pool_recycle_direct(struct page *page,
+static bool page_pool_recycle_in_cache(struct page *page,
 				       struct page_pool *pool)
 {
 	if (unlikely(pool->alloc.count == PP_ALLOC_CACHE_SIZE))
@@ -363,8 +368,8 @@ static bool pool_page_reusable(struct page_pool *pool, struct page *page)
 	return !page_is_pfmemalloc(page);
 }
 
-void __page_pool_put_page(struct page_pool *pool, struct page *page,
-			  unsigned int dma_sync_size, bool allow_direct)
+void page_pool_put_page(struct page_pool *pool, struct page *page,
+			unsigned int dma_sync_size, bool allow_direct)
 {
 	/* This allocator is optimized for the XDP mode that uses
 	 * one-frame-per-page, but have fallbacks that act like the
@@ -381,12 +386,12 @@ void __page_pool_put_page(struct page_pool *pool, struct page *page,
 						      dma_sync_size);
 
 		if (allow_direct && in_serving_softirq())
-			if (__page_pool_recycle_direct(page, pool))
+			if (page_pool_recycle_in_cache(page, pool))
 				return;
 
-		if (!__page_pool_recycle_into_ring(pool, page)) {
+		if (!page_pool_recycle_in_ring(pool, page)) {
 			/* Cache full, fallback to free pages */
-			__page_pool_return_page(pool, page);
+			page_pool_return_page(pool, page);
 		}
 		return;
 	}
@@ -403,12 +408,13 @@ void __page_pool_put_page(struct page_pool *pool, struct page *page,
 	 * doing refcnt based recycle tricks, meaning another process
 	 * will be invoking put_page.
 	 */
-	__page_pool_clean_page(pool, page);
+	/* Do not replace this with page_pool_return_page() */
+	page_pool_release_page(pool, page);
 	put_page(page);
 }
-EXPORT_SYMBOL(__page_pool_put_page);
+EXPORT_SYMBOL(page_pool_put_page);
 
-static void __page_pool_empty_ring(struct page_pool *pool)
+static void page_pool_empty_ring(struct page_pool *pool)
 {
 	struct page *page;
 
@@ -419,7 +425,7 @@ static void __page_pool_empty_ring(struct page_pool *pool)
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, page_ref_count(page));
 
-		__page_pool_return_page(pool, page);
+		page_pool_return_page(pool, page);
 	}
 }
 
@@ -449,7 +455,7 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 	 */
 	while (pool->alloc.count) {
 		page = pool->alloc.cache[--pool->alloc.count];
-		__page_pool_return_page(pool, page);
+		page_pool_return_page(pool, page);
 	}
 }
 
@@ -461,7 +467,7 @@ static void page_pool_scrub(struct page_pool *pool)
 	/* No more consumers should exist, but producers could still
 	 * be in-flight.
 	 */
-	__page_pool_empty_ring(pool);
+	page_pool_empty_ring(pool);
 }
 
 static int page_pool_release(struct page_pool *pool)
@@ -535,7 +541,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	/* Flush pool alloc cache, as refill will check NUMA node */
 	while (pool->alloc.count) {
 		page = pool->alloc.cache[--pool->alloc.count];
-		__page_pool_return_page(pool, page);
+		page_pool_return_page(pool, page);
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 8310714c47fd..4c7ea85486af 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -372,7 +372,7 @@ static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
 		xa = rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
 		page = virt_to_head_page(data);
 		napi_direct &= !xdp_return_frame_no_direct();
-		page_pool_put_page(xa->page_pool, page, napi_direct);
+		page_pool_put_full_page(xa->page_pool, page, napi_direct);
 		rcu_read_unlock();
 		break;
 	case MEM_TYPE_PAGE_SHARED:
-- 
2.25.0

