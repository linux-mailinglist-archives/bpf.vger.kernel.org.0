Return-Path: <bpf+bounces-61002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6548FADF835
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A744A3155
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D72B221277;
	Wed, 18 Jun 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXLLIdcM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9821FF46
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280184; cv=none; b=J5BsvthbJvUaJk3KbykTc63Omy704Pys2z2GLSaYN51VpVGG+GfcLWkqVaIcCjpLaCr9BnNSJLJ1KLUtPSrl1KDg6vSk2BDkrP83qJwOhffCgZg4x0n24622F5n1fQnrHGHjJW8ceNWkogQzf3LXZX1uAxxg7V2vhSbEyYDOY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280184; c=relaxed/simple;
	bh=sPufrTRob6bCxlzDBGKebkE9RWh4wT2NIx2gNwHAvdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+0rcHrJKNeRIZDBlf7QesKO3p5DfTo1TMiDabUG2cSjtrB4LYK3+iBEFNSCYrm5frPM5D7frjyUxY1ks+Mlc7Cdu9JvuHadltNYZDWgHPpeE+PlWeSikEFnBqdw0k1/TIVmF5prjdmn389wB7jgJGEnprSCR/R/UhD4lDBc4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXLLIdcM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748d9802b0eso36181b3a.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750280182; x=1750884982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DVQGjAEUNRl6E9b6KuNXb6Zgj9FbhXYzX0ArJg4zk8=;
        b=OXLLIdcM64sF0ONKY2a9HUNR4exUH6wWv9Y4p11CdRj9UlcJTlY8ecR0WPoo6RQanr
         VBh1uOt7epAWftMow2yNZaQF3CeWJTVQFvBJR3p8T9MlTaVZppn8oIbXvmM1eFUybjBY
         RMbUlGWE8VpELsTl8KNd5/e9RSkgtKxwF1Rl0L9jKZnxGGSM35ifj+LTaXuKye6JNpZ8
         vFvG1IBp9NgsSO1f0R+hJcMbnsAIpwLRdgmcwPvse/ZnkPPfvdPkmmRapccEJtwFo3u+
         h/QXy7i0oYq66xxLol/MAVYXIwMAZB1XIWfg0hRpvDZWmPBXZJjJPPjE+3W0J1AsPKI+
         amFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750280182; x=1750884982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DVQGjAEUNRl6E9b6KuNXb6Zgj9FbhXYzX0ArJg4zk8=;
        b=nI39v3cqGhuRn60FI83NJAkP+dpnlcq0vV2V+JjcTPJdhvsevTlTz9lsGyX0Tgujug
         k2JsivnG+QgYDdIqI/ijQx46C9kRwNbFPxzQEQDMNq7FsfJABmxRicOw5l6cfRzhNjbb
         oMjoUVw1gSHtebPziuM692w53PMW/HDTbESYOYiXfX8jb5d06aWO3PP5qyAFcVmzkPF0
         sMHnkTcT+AdfvQjJoPyOIUSg6aakhjHRM//38UtvygD5FVsHEiEOIhHc042IrHyYdeOZ
         ZRsI+ggMeOpP4MQ8GlkmKsOmmDZpGDusC4YDCclT3sDLDY6+MA+j3behehCJD6jG0bPG
         KnnA==
X-Forwarded-Encrypted: i=1; AJvYcCW46ReFrWpTnsTyor6wlRhUE+eNBo7klk+z/GDscSZQreQU6yHbNcm2fHHZ7FNfciVAtc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIJMG3LHFxWXUp+3goDxfjUAZczP2bmGntKCD2L+TwUBwR+4E
	bOJ6gwlgsRPhbtiEkWd1oownGRo4EgKEpOWQRDmpNldrpsVkK4NEc42KcxXyuhOTRVIbcHF3g68
	XztsRz484lAS0dPcFfx+eGnFtbg==
X-Google-Smtp-Source: AGHT+IGojNIXWw+HaIud0fqe/k9295saEOdAelSgNunbrU0/I3QfsLHf930Pz8YdfdtnZIBd76oW++wEqe5G0Yr1Nw==
X-Received: from pge23.prod.google.com ([2002:a05:6a02:2d17:b0:b2f:5023:640d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:158b:b0:21f:994e:7355 with SMTP id adf61e73a8af0-21fbd668cf5mr33349072637.36.1750280182015;
 Wed, 18 Jun 2025 13:56:22 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:56:13 +0000
In-Reply-To: <20250618205613.1432007-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618205613.1432007-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250618205613.1432007-4-hramamurthy@google.com>
Subject: [PATCH net-next 3/3] gve: add XDP_TX and XDP_REDIRECT support for DQ RDA
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	ziweixiao@google.com, pkaligineedi@google.com, joshwash@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch adds support for XDP_TX and XDP_REDIRECT for the DQ RDA
queue format. To appropriately support transmission of XDP frames, a
new pending packet type GVE_TX_PENDING_PACKET_DQO_XDP_FRAME is
introduced for completion handling, as there was a previous assumption
that completed packets would be SKBs.

XDP_TX handling completes the basic XDP actions, so the feature is
recorded accordingly. This patch also enables the ndo_xdp_xmit callback
allowing DQ to handle XDP_REDIRECT packets originating from another
interface.

The XDP spinlock is moved to common TX ring fields so that it can be
used in both GQ and DQ. Originally, it was in a section which was
mutually exclusive for GQ and DQ.

In summary, 3 XDP features are exposed for the DQ RDA queue format:
1) NETDEV_XDP_ACT_BASIC
2) NETDEV_XDP_ACT_NDO_XMIT
3) NETDEV_XDP_ACT_REDIRECT

Note that XDP and header-data split are mutually exclusive for the time
being due to lack of multi-buffer XDP support.

This patch does not add support for the DQ QPL format. That is to come
in a future patch series.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  23 ++-
 drivers/net/ethernet/google/gve/gve_dqo.h    |   2 +
 drivers/net/ethernet/google/gve/gve_main.c   |  34 ++++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  77 ++++++++--
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 151 +++++++++++++++++--
 5 files changed, 254 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index de1fc23c44f9..cf91195d5f39 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -402,8 +402,16 @@ enum gve_packet_state {
 	GVE_PACKET_STATE_TIMED_OUT_COMPL,
 };
 
+enum gve_tx_pending_packet_dqo_type {
+	GVE_TX_PENDING_PACKET_DQO_SKB,
+	GVE_TX_PENDING_PACKET_DQO_XDP_FRAME
+};
+
 struct gve_tx_pending_packet_dqo {
-	struct sk_buff *skb; /* skb for this packet */
+	union {
+		struct sk_buff *skb;
+		struct xdp_frame *xdpf;
+	};
 
 	/* 0th element corresponds to the linear portion of `skb`, should be
 	 * unmapped with `dma_unmap_single`.
@@ -433,7 +441,10 @@ struct gve_tx_pending_packet_dqo {
 	/* Identifies the current state of the packet as defined in
 	 * `enum gve_packet_state`.
 	 */
-	u8 state;
+	u8 state : 2;
+
+	/* gve_tx_pending_packet_dqo_type */
+	u8 type : 1;
 
 	/* If packet is an outstanding miss completion, then the packet is
 	 * freed if the corresponding re-injection completion is not received
@@ -455,6 +466,9 @@ struct gve_tx_ring {
 
 		/* DQO fields. */
 		struct {
+			/* Spinlock for XDP tx traffic */
+			spinlock_t xdp_lock;
+
 			/* Linked list of gve_tx_pending_packet_dqo. Index into
 			 * pending_packets, or -1 if empty.
 			 *
@@ -1155,6 +1169,7 @@ static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
 {
 	switch (priv->queue_format) {
 	case GVE_GQI_QPL_FORMAT:
+	case GVE_DQO_RDA_FORMAT:
 		return true;
 	default:
 		return false;
@@ -1180,9 +1195,13 @@ void gve_free_queue_page_list(struct gve_priv *priv,
 netdev_tx_t gve_tx(struct sk_buff *skb, struct net_device *dev);
 int gve_xdp_xmit_gqi(struct net_device *dev, int n, struct xdp_frame **frames,
 		     u32 flags);
+int gve_xdp_xmit_dqo(struct net_device *dev, int n, struct xdp_frame **frames,
+		     u32 flags);
 int gve_xdp_xmit_one(struct gve_priv *priv, struct gve_tx_ring *tx,
 		     void *data, int len, void *frame_p);
 void gve_xdp_tx_flush(struct gve_priv *priv, u32 xdp_qid);
+int gve_xdp_xmit_one_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
+			 struct xdp_frame *xdpf);
 bool gve_tx_poll(struct gve_notify_block *block, int budget);
 bool gve_xdp_poll(struct gve_notify_block *block, int budget);
 int gve_xsk_tx_poll(struct gve_notify_block *block, int budget);
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index e83773fb891f..bb278727f4d9 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -37,6 +37,7 @@ netdev_features_t gve_features_check_dqo(struct sk_buff *skb,
 					 struct net_device *dev,
 					 netdev_features_t features);
 bool gve_tx_poll_dqo(struct gve_notify_block *block, bool do_clean);
+bool gve_xdp_poll_dqo(struct gve_notify_block *block);
 int gve_rx_poll_dqo(struct gve_notify_block *block, int budget);
 int gve_tx_alloc_rings_dqo(struct gve_priv *priv,
 			   struct gve_tx_alloc_rings_cfg *cfg);
@@ -60,6 +61,7 @@ int gve_clean_tx_done_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 			  struct napi_struct *napi);
 void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx);
 void gve_rx_write_doorbell_dqo(const struct gve_priv *priv, int queue_idx);
+void gve_xdp_tx_flush_dqo(struct gve_priv *priv, u32 xdp_qid);
 
 static inline void
 gve_tx_put_doorbell_dqo(const struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index eff970124dba..27f97a1d2957 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -414,8 +414,12 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	bool reschedule = false;
 	int work_done = 0;
 
-	if (block->tx)
-		reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
+	if (block->tx) {
+		if (block->tx->q_num < priv->tx_cfg.num_queues)
+			reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
+		else
+			reschedule |= gve_xdp_poll_dqo(block);
+	}
 
 	if (!budget)
 		return 0;
@@ -1521,8 +1525,11 @@ static int gve_xdp_xmit(struct net_device *dev, int n,
 {
 	struct gve_priv *priv = netdev_priv(dev);
 
-	if (gve_is_gqi(priv))
+	if (priv->queue_format == GVE_GQI_QPL_FORMAT)
 		return gve_xdp_xmit_gqi(dev, n, frames, flags);
+	else if (priv->queue_format == GVE_DQO_RDA_FORMAT)
+		return gve_xdp_xmit_dqo(dev, n, frames, flags);
+
 	return -EOPNOTSUPP;
 }
 
@@ -1661,9 +1668,8 @@ static int verify_xdp_configuration(struct net_device *dev)
 		return -EOPNOTSUPP;
 	}
 
-	if (priv->queue_format != GVE_GQI_QPL_FORMAT) {
-		netdev_warn(dev, "XDP is not supported in mode %d.\n",
-			    priv->queue_format);
+	if (priv->header_split_enabled) {
+		netdev_warn(dev, "XDP is not supported when header-data split is enabled.\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -1987,10 +1993,13 @@ u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hsplit)
 		return GVE_DEFAULT_RX_BUFFER_SIZE;
 }
 
-/* header-split is not supported on non-DQO_RDA yet even if device advertises it */
+/* Header split is only supported on DQ RDA queue format. If XDP is enabled,
+ * header split is not allowed.
+ */
 bool gve_header_split_supported(const struct gve_priv *priv)
 {
-	return priv->header_buf_size && priv->queue_format == GVE_DQO_RDA_FORMAT;
+	return priv->header_buf_size &&
+		priv->queue_format == GVE_DQO_RDA_FORMAT && !priv->xdp_prog;
 }
 
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split)
@@ -2039,6 +2048,12 @@ static int gve_set_features(struct net_device *netdev,
 
 	if ((netdev->features & NETIF_F_LRO) != (features & NETIF_F_LRO)) {
 		netdev->features ^= NETIF_F_LRO;
+		if (priv->xdp_prog && (netdev->features & NETIF_F_LRO)) {
+			netdev_warn(netdev,
+				    "XDP is not supported when LRO is on.\n");
+			err =  -EOPNOTSUPP;
+			goto revert_features;
+		}
 		if (netif_running(netdev)) {
 			err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 			if (err)
@@ -2240,6 +2255,9 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 		xdp_features = NETDEV_XDP_ACT_BASIC;
 		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
 		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
+	} else if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
+		xdp_features = NETDEV_XDP_ACT_BASIC;
+		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
 	} else {
 		xdp_features = 0;
 	}
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 0be41a0cdd15..96743e1d80f3 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -8,6 +8,7 @@
 #include "gve_dqo.h"
 #include "gve_adminq.h"
 #include "gve_utils.h"
+#include <linux/bpf.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/skbuff.h>
@@ -570,27 +571,66 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 	return 0;
 }
 
+static int gve_xdp_tx_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
+			  struct xdp_buff *xdp)
+{
+	struct gve_tx_ring *tx;
+	struct xdp_frame *xdpf;
+	u32 tx_qid;
+	int err;
+
+	xdpf = xdp_convert_buff_to_frame(xdp);
+	if (unlikely(!xdpf))
+		return -ENOSPC;
+
+	tx_qid = gve_xdp_tx_queue_id(priv, rx->q_num);
+	tx = &priv->tx[tx_qid];
+	spin_lock(&tx->dqo_tx.xdp_lock);
+	err = gve_xdp_xmit_one_dqo(priv, tx, xdpf);
+	spin_unlock(&tx->dqo_tx.xdp_lock);
+
+	return err;
+}
+
 static void gve_xdp_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 			     struct xdp_buff *xdp, struct bpf_prog *xprog,
 			     int xdp_act,
 			     struct gve_rx_buf_state_dqo *buf_state)
 {
-	u64_stats_update_begin(&rx->statss);
+	int err;
 	switch (xdp_act) {
 	case XDP_ABORTED:
 	case XDP_DROP:
 	default:
-		rx->xdp_actions[xdp_act]++;
+		gve_free_buffer(rx, buf_state);
 		break;
 	case XDP_TX:
-		rx->xdp_tx_errors++;
+		err = gve_xdp_tx_dqo(priv, rx, xdp);
+		if (unlikely(err))
+			goto err;
+		gve_reuse_buffer(rx, buf_state);
 		break;
 	case XDP_REDIRECT:
-		rx->xdp_redirect_errors++;
+		err = xdp_do_redirect(priv->dev, xdp, xprog);
+		if (unlikely(err))
+			goto err;
+		gve_reuse_buffer(rx, buf_state);
 		break;
 	}
+	u64_stats_update_begin(&rx->statss);
+	if ((u32)xdp_act < GVE_XDP_ACTIONS)
+		rx->xdp_actions[xdp_act]++;
+	u64_stats_update_end(&rx->statss);
+	return;
+err:
+	u64_stats_update_begin(&rx->statss);
+	if (xdp_act == XDP_TX)
+		rx->xdp_tx_errors++;
+	else if (xdp_act == XDP_REDIRECT)
+		rx->xdp_redirect_errors++;
 	u64_stats_update_end(&rx->statss);
 	gve_free_buffer(rx, buf_state);
+	return;
 }
 
 /* Returns 0 if descriptor is completed successfully.
@@ -812,16 +852,27 @@ static int gve_rx_complete_skb(struct gve_rx_ring *rx, struct napi_struct *napi,
 
 int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 {
-	struct napi_struct *napi = &block->napi;
-	netdev_features_t feat = napi->dev->features;
-
-	struct gve_rx_ring *rx = block->rx;
-	struct gve_rx_compl_queue_dqo *complq = &rx->dqo.complq;
-
+	struct gve_rx_compl_queue_dqo *complq;
+	struct napi_struct *napi;
+	netdev_features_t feat;
+	struct gve_rx_ring *rx;
+	struct gve_priv *priv;
+	u64 xdp_redirects;
 	u32 work_done = 0;
 	u64 bytes = 0;
+	u64 xdp_txs;
 	int err;
 
+	napi = &block->napi;
+	feat = napi->dev->features;
+
+	rx = block->rx;
+	priv = rx->gve;
+	complq = &rx->dqo.complq;
+
+	xdp_redirects = rx->xdp_actions[XDP_REDIRECT];
+	xdp_txs = rx->xdp_actions[XDP_TX];
+
 	while (work_done < budget) {
 		struct gve_rx_compl_desc_dqo *compl_desc =
 			&complq->desc_ring[complq->head];
@@ -895,6 +946,12 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 		rx->ctx.skb_tail = NULL;
 	}
 
+	if (xdp_txs != rx->xdp_actions[XDP_TX])
+		gve_xdp_tx_flush_dqo(priv, rx->q_num);
+
+	if (xdp_redirects != rx->xdp_actions[XDP_REDIRECT])
+		xdp_do_flush();
+
 	gve_rx_post_buffers_dqo(rx);
 
 	u64_stats_update_begin(&rx->statss);
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index ba6b5cdaa922..ce5370b741ec 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -9,6 +9,7 @@
 #include "gve_utils.h"
 #include "gve_dqo.h"
 #include <net/ip.h>
+#include <linux/bpf.h>
 #include <linux/tcp.h>
 #include <linux/slab.h>
 #include <linux/skbuff.h>
@@ -110,6 +111,14 @@ static bool gve_has_pending_packet(struct gve_tx_ring *tx)
 	return false;
 }
 
+void gve_xdp_tx_flush_dqo(struct gve_priv *priv, u32 xdp_qid)
+{
+	u32 tx_qid = gve_xdp_tx_queue_id(priv, xdp_qid);
+	struct gve_tx_ring *tx = &priv->tx[tx_qid];
+
+	gve_tx_put_doorbell_dqo(priv, tx->q_resources, tx->dqo_tx.tail);
+}
+
 static struct gve_tx_pending_packet_dqo *
 gve_alloc_pending_packet(struct gve_tx_ring *tx)
 {
@@ -198,7 +207,8 @@ void gve_tx_stop_ring_dqo(struct gve_priv *priv, int idx)
 
 	gve_remove_napi(priv, ntfy_idx);
 	gve_clean_tx_done_dqo(priv, tx, /*napi=*/NULL);
-	netdev_tx_reset_queue(tx->netdev_txq);
+	if (tx->netdev_txq)
+		netdev_tx_reset_queue(tx->netdev_txq);
 	gve_tx_clean_pending_packets(tx);
 	gve_tx_remove_from_block(priv, idx);
 }
@@ -276,7 +286,8 @@ void gve_tx_start_ring_dqo(struct gve_priv *priv, int idx)
 
 	gve_tx_add_to_block(priv, idx);
 
-	tx->netdev_txq = netdev_get_tx_queue(priv->dev, idx);
+	if (idx < priv->tx_cfg.num_queues)
+		tx->netdev_txq = netdev_get_tx_queue(priv->dev, idx);
 	gve_add_napi(priv, ntfy_idx, gve_napi_poll_dqo);
 }
 
@@ -295,6 +306,7 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 	memset(tx, 0, sizeof(*tx));
 	tx->q_num = idx;
 	tx->dev = hdev;
+	spin_lock_init(&tx->dqo_tx.xdp_lock);
 	atomic_set_release(&tx->dqo_compl.hw_tx_head, 0);
 
 	/* Queue sizes must be a power of 2 */
@@ -795,6 +807,7 @@ static int gve_tx_add_skb_dqo(struct gve_tx_ring *tx,
 		return -ENOMEM;
 
 	pkt->skb = skb;
+	pkt->type = GVE_TX_PENDING_PACKET_DQO_SKB;
 	completion_tag = pkt - tx->dqo.pending_packets;
 
 	gve_extract_tx_metadata_dqo(skb, &metadata);
@@ -1116,16 +1129,32 @@ static void gve_handle_packet_completion(struct gve_priv *priv,
 		}
 	}
 	tx->dqo_tx.completed_packet_desc_cnt += pending_packet->num_bufs;
-	if (tx->dqo.qpl)
-		gve_free_tx_qpl_bufs(tx, pending_packet);
-	else
+
+	switch (pending_packet->type) {
+	case GVE_TX_PENDING_PACKET_DQO_SKB:
+		if (tx->dqo.qpl)
+			gve_free_tx_qpl_bufs(tx, pending_packet);
+		else
+			gve_unmap_packet(tx->dev, pending_packet);
+		(*pkts)++;
+		*bytes += pending_packet->skb->len;
+
+		napi_consume_skb(pending_packet->skb, is_napi);
+		pending_packet->skb = NULL;
+		gve_free_pending_packet(tx, pending_packet);
+		break;
+	case GVE_TX_PENDING_PACKET_DQO_XDP_FRAME:
 		gve_unmap_packet(tx->dev, pending_packet);
+		(*pkts)++;
+		*bytes += pending_packet->xdpf->len;
 
-	*bytes += pending_packet->skb->len;
-	(*pkts)++;
-	napi_consume_skb(pending_packet->skb, is_napi);
-	pending_packet->skb = NULL;
-	gve_free_pending_packet(tx, pending_packet);
+		xdp_return_frame(pending_packet->xdpf);
+		pending_packet->xdpf = NULL;
+		gve_free_pending_packet(tx, pending_packet);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
 }
 
 static void gve_handle_miss_completion(struct gve_priv *priv,
@@ -1296,9 +1325,10 @@ int gve_clean_tx_done_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 		num_descs_cleaned++;
 	}
 
-	netdev_tx_completed_queue(tx->netdev_txq,
-				  pkt_compl_pkts + miss_compl_pkts,
-				  pkt_compl_bytes + miss_compl_bytes);
+	if (tx->netdev_txq)
+		netdev_tx_completed_queue(tx->netdev_txq,
+					  pkt_compl_pkts + miss_compl_pkts,
+					  pkt_compl_bytes + miss_compl_bytes);
 
 	remove_miss_completions(priv, tx);
 	remove_timed_out_completions(priv, tx);
@@ -1334,3 +1364,98 @@ bool gve_tx_poll_dqo(struct gve_notify_block *block, bool do_clean)
 	compl_desc = &tx->dqo.compl_ring[tx->dqo_compl.head];
 	return compl_desc->generation != tx->dqo_compl.cur_gen_bit;
 }
+
+bool gve_xdp_poll_dqo(struct gve_notify_block *block)
+{
+	struct gve_tx_compl_desc *compl_desc;
+	struct gve_tx_ring *tx = block->tx;
+	struct gve_priv *priv = block->priv;
+
+	gve_clean_tx_done_dqo(priv, tx, &block->napi);
+
+	/* Return true if we still have work. */
+	compl_desc = &tx->dqo.compl_ring[tx->dqo_compl.head];
+	return compl_desc->generation != tx->dqo_compl.cur_gen_bit;
+}
+
+int gve_xdp_xmit_one_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
+			 struct xdp_frame *xdpf)
+{
+	struct gve_tx_pending_packet_dqo *pkt;
+	u32 desc_idx = tx->dqo_tx.tail;
+	s16 completion_tag;
+	int num_descs = 1;
+	dma_addr_t addr;
+	int err;
+
+	if (unlikely(!gve_has_tx_slots_available(tx, num_descs)))
+		return -EBUSY;
+
+	pkt = gve_alloc_pending_packet(tx);
+	if (unlikely(!pkt))
+		return -EBUSY;
+
+	pkt->type = GVE_TX_PENDING_PACKET_DQO_XDP_FRAME;
+	pkt->num_bufs = 0;
+	pkt->xdpf = xdpf;
+	completion_tag = pkt - tx->dqo.pending_packets;
+
+	/* Generate Packet Descriptor */
+	addr = dma_map_single(tx->dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
+	err = dma_mapping_error(tx->dev, addr);
+	if (unlikely(err))
+		goto err;
+
+	dma_unmap_len_set(pkt, len[pkt->num_bufs], xdpf->len);
+	dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
+	pkt->num_bufs++;
+
+	gve_tx_fill_pkt_desc_dqo(tx, &desc_idx,
+				 false, xdpf->len,
+				 addr, completion_tag, true,
+				 false);
+
+	gve_tx_update_tail(tx, desc_idx);
+	return 0;
+
+err:
+	pkt->xdpf = NULL;
+	pkt->num_bufs = 0;
+	gve_free_pending_packet(tx, pkt);
+	return err;
+}
+
+int gve_xdp_xmit_dqo(struct net_device *dev, int n, struct xdp_frame **frames,
+		     u32 flags)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_tx_ring *tx;
+	int i, err = 0, qid;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	qid = gve_xdp_tx_queue_id(priv,
+				  smp_processor_id() % priv->tx_cfg.num_xdp_queues);
+
+	tx = &priv->tx[qid];
+
+	spin_lock(&tx->dqo_tx.xdp_lock);
+	for (i = 0; i < n; i++) {
+		err = gve_xdp_xmit_one_dqo(priv, tx, frames[i]);
+		if (err)
+			break;
+	}
+
+	if (flags & XDP_XMIT_FLUSH)
+		gve_tx_put_doorbell_dqo(priv, tx->q_resources, tx->dqo_tx.tail);
+
+	spin_unlock(&tx->dqo_tx.xdp_lock);
+
+	u64_stats_update_begin(&tx->statss);
+	tx->xdp_xmit += n;
+	tx->xdp_xmit_errors += n - i;
+	u64_stats_update_end(&tx->statss);
+
+	return i ? i : err;
+}
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


