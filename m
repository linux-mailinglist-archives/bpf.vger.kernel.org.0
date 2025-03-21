Return-Path: <bpf+bounces-54513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D14AA6B249
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36FE19C3F36
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF919D080;
	Fri, 21 Mar 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpscTMen"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B518DF6E
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516975; cv=none; b=hxrT+AoTfnig1rJPyPJlgrrDzVFDZWB1Nn/h7fVMAC547xKRv/hfxre5kdV1dB+OwdXSEZxaf7+xTmESNQ/aB/YIzXcsomOj0PckeK23SkS5Q5OTeoytsV4TQyYk/WXBxn9DzDl0MaW4bHlM87MfbUfc578ld0BwypMzSY+pWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516975; c=relaxed/simple;
	bh=RpEz+u3qtPZ/8waeYzrQDWIqd2UbyuttbigwM1gEpkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tkmz4TxFKx8c3UBdevPUHkdAT5SCdrFqIOEku6tIb/aI6FGroqn3DP9R+pOJHiGGQFlEpg9+d3VKtjpU8aJlyiKandLmcoBVsnjwiI/WI9uGC7xe9vrMkQA6a12jnNKEk4m/yJbUuvoVnHi+TEOiY38VQyHeO34L2+6oyWkcnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpscTMen; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso1812033a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516973; x=1743121773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rlZnJtOZOC8zdaIIteZz+tI3tXKlAzww+3aDYH87JYo=;
        b=GpscTMenyG2o6O82EkGmFPFszBIZh2uM2lOsQL/utyGqQhsnQI6CXbLipPHu9WxZx7
         cCj5ja5zXCruRrddRyAmA5RTXqg5b1csSY9Mg9jhvNUj1giOlJYgQ6sYab9qdP1KU27v
         r+eqnvMkjpF/sDLJfVnX2LO5nVMpEfB86cCXX80a0siCM8BBKbs5g1cqrwYH/ZXCUGUt
         z2mg9kVn0gGLA95wUyxVsr7yZdIHJImkChGmWsFwbm4x/ojhWoPfWCPrH0Eif5UWS+d/
         d1UVGOHNaOAfOTOMay5fKejPc826n93z/P223qz+sKgfot4VtWN9tgd24sx8odV54UD6
         6B9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516973; x=1743121773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlZnJtOZOC8zdaIIteZz+tI3tXKlAzww+3aDYH87JYo=;
        b=mMXa4WoxlTBovEpKDwkP7A9rqhW3lOqHvzrP7kzO0St4oLgVlTgfepumeKh5/rzoN/
         ssmDDvPopKx9TB1Fb6KrepGR+y6ygklIDJXRwo7qwAVY8x6pZ0O2gZ7ibm4GpeS3T1xK
         D2EaJV7E43GK3qH1xyhLovvjbSnYw8OifOXnfE/45zKBYiYgTaqdrs5rQyKtf6csTnpW
         VB70Xy7ui9d4NuUWIfmrdV3hONOuVbNmHXnhcO9sqqj0wsvVJhg3hmMZhi38pusZzoyq
         rPh14atlHbD3sLA0leO+9+6CVQLuWKx6bjmN4iOPasb1An7cYOIk2fYCCWOCtKh2MATO
         vkmA==
X-Forwarded-Encrypted: i=1; AJvYcCUS0ckFo9nxLYaPmyPb6s+T6vh4aYifwkg8dqKt20/h4bVJ9U6pdk0gH7zddAgUH6pPU0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoItxvLxzEdHRfMd6acGeW9YZ6BuC2r75S4FE3Q4CX5I2ZIMHc
	iVhmrbnGkYqsU3zWzonqwO83pn6zVGi8lFeeEgMq2JhUzrX+dOxd7BTKYxvK/KjKv6gqZAtOpes
	/FDc7SdycIXmfi5r1AENawg==
X-Google-Smtp-Source: AGHT+IH1nlwYcmOy5sZiXKr1QY8fZy7y4pP1oqlNvVdbwry/tdlf+1eaNcltRq2LySc5zCPsOzTHnmuLrPfxcJnWqg==
X-Received: from pjur4.prod.google.com ([2002:a17:90a:d404:b0:2fa:2661:76ac])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d48:b0:2ff:6e58:89f5 with SMTP id 98e67ed59e1d1-3030ec2648cmr2514328a91.6.1742516972855;
 Thu, 20 Mar 2025 17:29:32 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:09 +0000
In-Reply-To: <20250321002910.1343422-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321002910.1343422-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-6-hramamurthy@google.com>
Subject: [PATCH net-next 5/6] gve: update XDP allocation path support RX
 buffer posting
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

In order to support installing an XDP program on DQ, RX buffers need to
be reposted using 4K buffers, which is larger than the default packet
buffer size of 2K. This is needed to accommodate the extra head and tail
that accompanies the data portion of an XDP buffer. Continuing to use 2K
buffers would mean that the packet buffer size for the NIC would have to
be restricted to 2048 - 320 - 256 = 1472B. However, this is problematic
for two reasons: first, 1472 is not a packet buffer size accepted by
GVE; second, at least 1474B of buffer space is needed to accommodate an
MTU of 1460, which is the default on GCP. As such, we allocate 4K
buffers, and post a 2K section of those 4K buffers (offset relative to
the XDP headroom) to the NIC for DMA to avoid a potential extra copy.
Because the GQ-QPL datapath requires copies regardless, this change was
not needed to support XDP in that case.

To capture this subtlety, a new field, packet_buffer_truesize, has been
added to the rx ring struct to represent size of the allocated buffer,
while packet_buffer_size has been left to represent the portion of the
buffer posted to the NIC.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         | 12 ++++++++--
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 17 +++++++++-----
 drivers/net/ethernet/google/gve/gve_main.c    | 19 +++++++++++++---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 22 ++++++++++++++-----
 4 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 9895541eddae..2fab38c8ee78 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -59,6 +59,8 @@
 
 #define GVE_MAX_RX_BUFFER_SIZE 4096
 
+#define GVE_XDP_RX_BUFFER_SIZE_DQO 4096
+
 #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
 
 #define GVE_PAGE_POOL_SIZE_MULTIPLIER 4
@@ -227,7 +229,11 @@ struct gve_rx_cnts {
 /* Contains datapath state used to represent an RX queue. */
 struct gve_rx_ring {
 	struct gve_priv *gve;
-	u16 packet_buffer_size;
+
+	u16 packet_buffer_size;		/* Size of buffer posted to NIC */
+	u16 packet_buffer_truesize;	/* Total size of RX buffer */
+	u16 rx_headroom;
+
 	union {
 		/* GQI fields */
 		struct {
@@ -688,6 +694,7 @@ struct gve_rx_alloc_rings_cfg {
 	bool raw_addressing;
 	bool enable_header_split;
 	bool reset_rss;
+	bool xdp;
 
 	/* Allocated resources are returned here */
 	struct gve_rx_ring *rx;
@@ -1218,7 +1225,8 @@ void gve_free_buffer(struct gve_rx_ring *rx,
 		     struct gve_rx_buf_state_dqo *buf_state);
 int gve_alloc_buffer(struct gve_rx_ring *rx, struct gve_rx_desc_dqo *desc);
 struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
-					  struct gve_rx_ring *rx);
+					  struct gve_rx_ring *rx,
+					  bool xdp);
 
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index f9824664d04c..a71883e1d920 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -139,7 +139,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
 	buf_state->page_info.page_offset = 0;
 	buf_state->page_info.page_address =
 		page_address(buf_state->page_info.page);
-	buf_state->page_info.buf_size = rx->packet_buffer_size;
+	buf_state->page_info.buf_size = rx->packet_buffer_truesize;
+	buf_state->page_info.pad = rx->rx_headroom;
 	buf_state->last_single_ref_offset = 0;
 
 	/* The page already has 1 ref. */
@@ -162,7 +163,7 @@ void gve_free_qpl_page_dqo(struct gve_rx_buf_state_dqo *buf_state)
 void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 			 struct gve_rx_buf_state_dqo *buf_state)
 {
-	const u16 data_buffer_size = rx->packet_buffer_size;
+	const u16 data_buffer_size = rx->packet_buffer_truesize;
 	int pagecount;
 
 	/* Can't reuse if we only fit one buffer per page */
@@ -219,7 +220,7 @@ static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
 {
 	netmem_ref netmem;
 
-	buf_state->page_info.buf_size = rx->packet_buffer_size;
+	buf_state->page_info.buf_size = rx->packet_buffer_truesize;
 	netmem = page_pool_alloc_netmem(rx->dqo.page_pool,
 					&buf_state->page_info.page_offset,
 					&buf_state->page_info.buf_size,
@@ -231,12 +232,14 @@ static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
 	buf_state->page_info.netmem = netmem;
 	buf_state->page_info.page_address = netmem_address(netmem);
 	buf_state->addr = page_pool_get_dma_addr_netmem(netmem);
+	buf_state->page_info.pad = rx->dqo.page_pool->p.offset;
 
 	return 0;
 }
 
 struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
-					  struct gve_rx_ring *rx)
+					  struct gve_rx_ring *rx,
+					  bool xdp)
 {
 	u32 ntfy_id = gve_rx_idx_to_ntfy(priv, rx->q_num);
 	struct page_pool_params pp = {
@@ -247,7 +250,8 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 		.netdev = priv->dev,
 		.napi = &priv->ntfy_blocks[ntfy_id].napi,
 		.max_len = PAGE_SIZE,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = xdp ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
+		.offset = xdp ? XDP_PACKET_HEADROOM : 0,
 	};
 
 	return page_pool_create(&pp);
@@ -301,7 +305,8 @@ int gve_alloc_buffer(struct gve_rx_ring *rx, struct gve_rx_desc_dqo *desc)
 	}
 	desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
 	desc->buf_addr = cpu_to_le64(buf_state->addr +
-				     buf_state->page_info.page_offset);
+				     buf_state->page_info.page_offset +
+				     buf_state->page_info.pad);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 20aabbe0e518..cb2f9978f45e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1149,8 +1149,14 @@ static int gve_reg_xdp_info(struct gve_priv *priv, struct net_device *dev)
 				       napi->napi_id);
 		if (err)
 			goto err;
-		err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
-						 MEM_TYPE_PAGE_SHARED, NULL);
+		if (gve_is_qpl(priv))
+			err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
+							 MEM_TYPE_PAGE_SHARED,
+							 NULL);
+		else
+			err = xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
+							 MEM_TYPE_PAGE_POOL,
+							 rx->dqo.page_pool);
 		if (err)
 			goto err;
 		rx->xsk_pool = xsk_get_pool_from_qid(dev, i);
@@ -1226,6 +1232,7 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->ring_size = priv->rx_desc_cnt;
 	cfg->packet_buffer_size = priv->rx_cfg.packet_buffer_size;
 	cfg->rx = priv->rx;
+	cfg->xdp = !!cfg->qcfg_tx->num_xdp_queues;
 }
 
 void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
@@ -1461,6 +1468,7 @@ static int gve_configure_rings_xdp(struct gve_priv *priv,
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 	tx_alloc_cfg.num_xdp_rings = num_xdp_rings;
 
+	rx_alloc_cfg.xdp = !!num_xdp_rings;
 	return gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 }
 
@@ -1629,6 +1637,7 @@ static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 static int verify_xdp_configuration(struct net_device *dev)
 {
 	struct gve_priv *priv = netdev_priv(dev);
+	u16 max_xdp_mtu;
 
 	if (dev->features & NETIF_F_LRO) {
 		netdev_warn(dev, "XDP is not supported when LRO is on.\n");
@@ -1641,7 +1650,11 @@ static int verify_xdp_configuration(struct net_device *dev)
 		return -EOPNOTSUPP;
 	}
 
-	if (dev->mtu > GVE_DEFAULT_RX_BUFFER_SIZE - sizeof(struct ethhdr) - GVE_RX_PAD) {
+	max_xdp_mtu = priv->rx_cfg.packet_buffer_size - sizeof(struct ethhdr);
+	if (priv->queue_format == GVE_GQI_QPL_FORMAT)
+		max_xdp_mtu -= GVE_RX_PAD;
+
+	if (dev->mtu > max_xdp_mtu) {
 		netdev_warn(dev, "XDP is not supported for mtu %d.\n",
 			    dev->mtu);
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 5fbcf93a54e0..2edf3c632cbd 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -225,6 +225,14 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	rx->q_num = idx;
 	rx->packet_buffer_size = cfg->packet_buffer_size;
 
+	if (cfg->xdp) {
+		rx->packet_buffer_truesize = GVE_XDP_RX_BUFFER_SIZE_DQO;
+		rx->rx_headroom = XDP_PACKET_HEADROOM;
+	} else {
+		rx->packet_buffer_truesize = rx->packet_buffer_size;
+		rx->rx_headroom = 0;
+	}
+
 	rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
 		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 	rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
@@ -254,7 +262,7 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 		goto err;
 
 	if (cfg->raw_addressing) {
-		pool = gve_rx_create_page_pool(priv, rx);
+		pool = gve_rx_create_page_pool(priv, rx, cfg->xdp);
 		if (IS_ERR(pool))
 			goto err;
 
@@ -484,14 +492,15 @@ static void gve_skb_add_rx_frag(struct gve_rx_ring *rx,
 	if (rx->dqo.page_pool) {
 		skb_add_rx_frag_netmem(rx->ctx.skb_tail, num_frags,
 				       buf_state->page_info.netmem,
-				       buf_state->page_info.page_offset,
-				       buf_len,
+				       buf_state->page_info.page_offset +
+				       buf_state->page_info.pad, buf_len,
 				       buf_state->page_info.buf_size);
 	} else {
 		skb_add_rx_frag(rx->ctx.skb_tail, num_frags,
 				buf_state->page_info.page,
-				buf_state->page_info.page_offset,
-				buf_len, buf_state->page_info.buf_size);
+				buf_state->page_info.page_offset +
+				buf_state->page_info.pad, buf_len,
+				buf_state->page_info.buf_size);
 	}
 }
 
@@ -611,7 +620,8 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 
 	/* Sync the portion of dma buffer for CPU to read. */
 	dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
-				      buf_state->page_info.page_offset,
+				      buf_state->page_info.page_offset +
+				      buf_state->page_info.pad,
 				      buf_len, DMA_FROM_DEVICE);
 
 	/* Append to current skb if one exists. */
-- 
2.49.0.rc1.451.g8f38331e32-goog


