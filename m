Return-Path: <bpf+bounces-54511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53855A6B245
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA686189C3A1
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87011411EB;
	Fri, 21 Mar 2025 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqHOlz6t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663A13635C
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516969; cv=none; b=E+LsHWCR8iIU6Bf3yMlHnCb2XXaH6C1H/DXVh3Hl4N+G5PGyrTTe06ZbITsBXs6/pBKKI6Q/uyADM+8cFnQPSCof3/LnHEoUnxSxQfN3J8KGJsA9VPOxKwL0wpkmFNfSe2funrCGhPab5nNnrHAkDIxCYGxaj8kquHqd9mu8Jao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516969; c=relaxed/simple;
	bh=QnQjmOUMdu0LaJsPwkMYaV067bT5nlIwdVbWjgqde2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kIASTOIq7iF+BepMEQXi1yzsf90fO1DFMp/HwElzXZdp8tRwPmAkdJidETZRyj14wCzn1VspZTT8bJUTK3HMS6+WKhvBryaVyp3Ye1mFzeP3UHsLuA2SYZfb6AOrNvjcQVyadyW7Y+ep1ZaVfqFTXjXXAxjLSuHKqsD77BDfGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqHOlz6t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2feb47c6757so1494591a91.3
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 17:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516967; x=1743121767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1LG5VQljoMlrOtBLZUnQ7XLakC4CYuuHpRrE00Qlhw=;
        b=NqHOlz6ty4pwNBdXNiXKEI7A6Rh4eIcw6/cxKVLPKjKYFpcD7vtacIornRVpQKq12C
         KQmo2/fl+uNgwNxGYHMEZUu6KiycgRygWlFS43qTzlXyrd7oV99dsP23yOpzlzYEtQpo
         fVTQBBKskhB3M1wmsJ8ib4v50h0ikd6jq7pCip9uXqrujzdhWsoWgIpbRuWjNdgJA6dE
         /SVE01DFerm86lrHZ62LrLZHoQdZp2uEwGZKsv8CRWvv11CuTLB8pRt1tmOoUX8bSlcr
         dN09KZQ4HarXQO9WJOHFiaCxN5ze3SC7fpf7twFQxCAjtU8cAk51Bxz3uL5GxMKDm9lf
         ZNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516967; x=1743121767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1LG5VQljoMlrOtBLZUnQ7XLakC4CYuuHpRrE00Qlhw=;
        b=XqydfgACad7/8CYAzqIFUJQPhrnc7LslK85X6GFHDDTqy4V0Tu76IWuIk9rejyzLkv
         uq9l+gpc5LCEx4pDGvZJ6+CTvgjWAon3wAoEq6Aji4bqRuWFswlp3yCoYCNatXRwaXkW
         VacCvmNDVyGwJ0dvNyKmn0AhHNCWZDBU211S5FyGGDzZgDdFrPONaLP2+4URXsuAjF59
         vPYuGvUEhN6sYSFWlbmGweHpOJCqHF//Rys8V3TsAibHr2fkntk2GAlzsVrDNWqVrzpX
         88xH9OZDMslVRJp5bHRPNoKnwBe6ddJkZonAV07FfY6DbqK9WFwlrJJTkSwJt+gN5GQU
         ODXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQSHrs2nv1CWaJ8T1YaXYxWp7FnFGaNdcgPpm1VLPGiQP/o9av123gnisx4OgTS8y1PIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRyO5dGPcHyGEjHhxcRGrOJ9a9OpFFJRgXJGa9k2Q2TbyFYeb
	4ik36BoEX7keKw2fSkGbmoPT+aZ/ht6BikTY8PEFt2WwW1JbfOTIhmQVAmHWzE3M2kjPo9JU3S1
	j3GoLXW5StwmNdqTG9qr6lA==
X-Google-Smtp-Source: AGHT+IEadiXXjxt2+O81sSe0Uw9K8c8HTLQIJNQsl41h2NtHb9fpJuhccsgilZ6lbCG9EgWhslLn69uR/jdkP0Xg1Q==
X-Received: from pjbpl11.prod.google.com ([2002:a17:90b:268b:b0:301:1bf5:2efc])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:38cb:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-3030ff0d9f3mr1421101a91.29.1742516966814;
 Thu, 20 Mar 2025 17:29:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:07 +0000
In-Reply-To: <20250321002910.1343422-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321002910.1343422-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-4-hramamurthy@google.com>
Subject: [PATCH net-next 3/6] gve: update GQ RX to use buf_size
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, pkaligineedi@google.com, willemb@google.com, 
	ziweixiao@google.com, joshwash@google.com, horms@kernel.org, 
	shailend@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Commit ebdfae0d377b ("gve: adopt page pool for DQ RDA mode") introduced
a buf_size field to the gve_rx_slot_page_info struct, which can be used
in the datapath to take the place of the packet_buffer_size field, as it
will already be hot in the cache due to its extensive use. Using the
buf_size field in the datapath frees up the packet_buffer_size field in
the GQ-specific RX cacheline to be generalized for GQ and DQ (in the
next patch), as there is currently no common packet buffer size field
between the two queue formats.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 7b774cc510cc..9d444e723fcd 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -141,12 +141,15 @@ void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
 	netif_dbg(priv, drv, priv->dev, "freed rx ring %d\n", idx);
 }
 
-static void gve_setup_rx_buffer(struct gve_rx_slot_page_info *page_info,
-			     dma_addr_t addr, struct page *page, __be64 *slot_addr)
+static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
+				struct gve_rx_slot_page_info *page_info,
+				dma_addr_t addr, struct page *page,
+				__be64 *slot_addr)
 {
 	page_info->page = page;
 	page_info->page_offset = 0;
 	page_info->page_address = page_address(page);
+	page_info->buf_size = rx->packet_buffer_size;
 	*slot_addr = cpu_to_be64(addr);
 	/* The page already has 1 ref */
 	page_ref_add(page, INT_MAX - 1);
@@ -171,7 +174,7 @@ static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
 		return err;
 	}
 
-	gve_setup_rx_buffer(page_info, dma, page, &data_slot->addr);
+	gve_setup_rx_buffer(rx, page_info, dma, page, &data_slot->addr);
 	return 0;
 }
 
@@ -199,7 +202,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 			struct page *page = rx->data.qpl->pages[i];
 			dma_addr_t addr = i * PAGE_SIZE;
 
-			gve_setup_rx_buffer(&rx->data.page_info[i], addr, page,
+			gve_setup_rx_buffer(rx, &rx->data.page_info[i], addr,
+					    page,
 					    &rx->data.data_ring[i].qpl_offset);
 			continue;
 		}
@@ -222,6 +226,7 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 			rx->qpl_copy_pool[j].page = page;
 			rx->qpl_copy_pool[j].page_offset = 0;
 			rx->qpl_copy_pool[j].page_address = page_address(page);
+			rx->qpl_copy_pool[j].buf_size = rx->packet_buffer_size;
 
 			/* The page already has 1 ref. */
 			page_ref_add(page, INT_MAX - 1);
@@ -283,6 +288,7 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 
 	rx->gve = priv;
 	rx->q_num = idx;
+	rx->packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 
 	rx->mask = slots - 1;
 	rx->data.raw_addressing = cfg->raw_addressing;
@@ -351,7 +357,6 @@ int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 	rx->db_threshold = slots / 2;
 	gve_rx_init_ring_state_gqi(rx);
 
-	rx->packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 	gve_rx_ctx_clear(&rx->ctx);
 
 	return 0;
@@ -590,7 +595,7 @@ static struct sk_buff *gve_rx_copy_to_pool(struct gve_rx_ring *rx,
 	copy_page_info->pad = page_info->pad;
 
 	skb = gve_rx_add_frags(napi, copy_page_info,
-			       rx->packet_buffer_size, len, ctx);
+			       copy_page_info->buf_size, len, ctx);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -630,7 +635,8 @@ gve_rx_qpl(struct device *dev, struct net_device *netdev,
 	 * device.
 	 */
 	if (page_info->can_flip) {
-		skb = gve_rx_add_frags(napi, page_info, rx->packet_buffer_size, len, ctx);
+		skb = gve_rx_add_frags(napi, page_info, page_info->buf_size,
+				       len, ctx);
 		/* No point in recycling if we didn't get the skb */
 		if (skb) {
 			/* Make sure that the page isn't freed. */
@@ -680,7 +686,7 @@ static struct sk_buff *gve_rx_skb(struct gve_priv *priv, struct gve_rx_ring *rx,
 			skb = gve_rx_raw_addressing(&priv->pdev->dev, netdev,
 						    page_info, len, napi,
 						    data_slot,
-						    rx->packet_buffer_size, ctx);
+						    page_info->buf_size, ctx);
 		} else {
 			skb = gve_rx_qpl(&priv->pdev->dev, netdev, rx,
 					 page_info, len, napi, data_slot);
@@ -855,7 +861,7 @@ static void gve_rx(struct gve_rx_ring *rx, netdev_features_t feat,
 		void *old_data;
 		int xdp_act;
 
-		xdp_init_buff(&xdp, rx->packet_buffer_size, &rx->xdp_rxq);
+		xdp_init_buff(&xdp, page_info->buf_size, &rx->xdp_rxq);
 		xdp_prepare_buff(&xdp, page_info->page_address +
 				 page_info->page_offset, GVE_RX_PAD,
 				 len, false);
-- 
2.49.0.rc1.451.g8f38331e32-goog


