Return-Path: <bpf+bounces-71836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72CBFDCF5
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3384E18C8AB3
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F62634B67A;
	Wed, 22 Oct 2025 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoEjOc9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD36345CC1
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157423; cv=none; b=Yh4COHU5zax/QW6v70FS5yN3FA4l9IJfjJdL1KkyZ0trE7iuWcOUQtMvf8x5d8s0oTnb5ej4EbRCrpzg5v/CMzb0w6Q28ERRNzwG69yT27e/pTWY/CuXtjYSRtHitpQ0gix5QQ96h0HGOkG4Ei2ATz5GOBnzWeO8p60a3HrznDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157423; c=relaxed/simple;
	bh=UVZI17h7HLb/ZMhJZ55NqWT18DZ8rBDoglUJXsA63X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nbDyGKw0vYa76px1vA5TgGxyxNiAbHP61BlRXH7EddOBDcAKpt4XIqZpFTxjCtMQdN+FANfhEi0HtlZ0i1Wgyq9kO3QRPCEN1ae3/RRT9opMn4OvSPAKkzakfs3TYc3IgJkj0rzR7JKHV3MD7shb0V3U+tZYqMN0sZ04UIZXwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoEjOc9y; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a26a53a4faso637138b3a.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761157420; x=1761762220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iktq7Wn5pIoCwGAvXL7/BQYzOTmxLjXbBR6x1OGDLzQ=;
        b=hoEjOc9y1T0RnT+QPSBUuvJvkqhLAbQioNZRERr0kj+egfj4DmBR4jdZmTDToq0nFk
         +JlsCmgmYD94dlDnVBk2D/RjS+hY+UdYW2TARh+uUH4ASyXOkedNCOcPfNiN/tqbP8jH
         IgvvtJjnFn09D5BO+5/bz9AKGJa+E3FYDv47kOv6wRB807LQXSyni8ApHMYUoIoZrXtS
         oZKoEsDP2VTIhSdVaDAt2RBiAH6vp9hKjyLRwSbzPQdbUJe4+xvEcRL4Gj5T+s4I/P2S
         oF8rDycLKcKvw/MqAz+THE1TUdmU997XhhBgs5SDkSfwUUpE0xVRIKOJlqvs0pvpVVQ2
         hIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761157420; x=1761762220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iktq7Wn5pIoCwGAvXL7/BQYzOTmxLjXbBR6x1OGDLzQ=;
        b=Qb/iMzBXtPBo0vjri4PjRdQHql09dqvPjtKza/uafXGpByQOZ2OAyKkgu18WOUSIxS
         MFC3bVJGjrkuoT39KOINI/etpWmEwvtxanLYLHKVTXs+Stis1k7N3MuqioKoVowj0HIk
         RjQdns9wcWN9WZnufuzZ8adF0FEslDxH5V+eGbx5VOjHz38KzITzsHNFu6tuUNCJf9jP
         Iaq1ganjfzAy3IwN1e2Tc7MiT37Qz5jbTz4oVryZI8MvzQbNO9LbTvyHUAPoaKuU3PeE
         B7LdRg43AxiXC/yPAOmPj299+EQymUX4/ToWXibBwmrs64IKi7158uqChuQ0K2n4c2Hx
         Tx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEVz/jJkEaYWo1GpqFY9fWIPljnDMXgGgh6PzSsn50uWHYwSqD/zA4rTfddsB3zGZ6mPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvW37E1CnGeaESgiDKbF09K30AoSVCOAPklFsNPGWk5k14T+fg
	1FjqYaWfR/xxJkJJo74d3XaRpSH2oMawLhhChUjTzu5snHSi8psYUaLA1AV9cQbEA1Y2Nn3AARC
	06TU8yCDcN2TyNA==
X-Google-Smtp-Source: AGHT+IGY8k93vtQ43TFG6C5KrT1OedrQTPkyFUfuTJOTRGOzReM/XDp/D9+KnHM0koEIxyjI0OoJHbVRRiPa7g==
X-Received: from pfbfw12.prod.google.com ([2002:a05:6a00:61cc:b0:7a2:6aaa:30c5])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4311:b0:246:d43a:3856 with SMTP id adf61e73a8af0-334a857d6f3mr26831189637.22.1761157420128;
 Wed, 22 Oct 2025 11:23:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:22:24 -0700
In-Reply-To: <20251022182301.1005777-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022182301.1005777-3-joshwash@google.com>
Subject: [PATCH net-next 2/3] gve: Allow ethtool to configure rx_buf_len
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Ankit Garg <nktgrg@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Add support for getting and setting the RX buffer length via the
ethtool ring parameters (`ethtool -g`/`-G`). The driver restricts the
allowed buffer length to 2048 (SZ_2K) or 4096 (SZ_4K).

As XDP is only supported when the `rx_buf_len` is 2048, the driver now
enforces this in two places:
1.  In `gve_xdp_set`, rejecting XDP programs if the current buffer
    length is not 2048.
2.  In `gve_set_rx_buf_len_config`, rejecting buffer length changes if
    XDP is loaded and the new length is not 2048.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  9 ++++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 +++++-
 drivers/net/ethernet/google/gve/gve_main.c    | 45 +++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c237d00c5ab3..a33b44c1eb86 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1167,6 +1167,12 @@ static inline bool gve_is_gqi(struct gve_priv *priv)
 		priv->queue_format == GVE_GQI_QPL_FORMAT;
 }
 
+static inline bool gve_is_dqo(struct gve_priv *priv)
+{
+	return priv->queue_format == GVE_DQO_RDA_FORMAT ||
+	       priv->queue_format == GVE_DQO_QPL_FORMAT;
+}
+
 static inline u32 gve_num_tx_queues(struct gve_priv *priv)
 {
 	return priv->tx_cfg.num_queues + priv->tx_cfg.num_xdp_queues;
@@ -1248,6 +1254,9 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
 void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx);
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
 bool gve_header_split_supported(const struct gve_priv *priv);
+int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
+			      struct netlink_ext_ack *extack,
+			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 /* rx buffer handling */
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index db6fc855a511..52500ae8348e 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -529,6 +529,8 @@ static void gve_get_ringparam(struct net_device *netdev,
 	cmd->rx_pending = priv->rx_desc_cnt;
 	cmd->tx_pending = priv->tx_desc_cnt;
 
+	kernel_cmd->rx_buf_len = priv->rx_cfg.packet_buffer_size;
+
 	if (!gve_header_split_supported(priv))
 		kernel_cmd->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
 	else if (priv->header_split_enabled)
@@ -589,6 +591,12 @@ static int gve_set_ringparam(struct net_device *netdev,
 	int err;
 
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
+
+	err = gve_set_rx_buf_len_config(priv, kernel_cmd->rx_buf_len, extack,
+					&rx_alloc_cfg);
+	if (err)
+		return err;
+
 	err = gve_set_hsplit_config(priv, kernel_cmd->tcp_data_split,
 				    &rx_alloc_cfg);
 	if (err)
@@ -605,6 +613,8 @@ static int gve_set_ringparam(struct net_device *netdev,
 			return err;
 	} else {
 		/* Set ring params for the next up */
+		priv->rx_cfg.packet_buffer_size =
+			rx_alloc_cfg.packet_buffer_size;
 		priv->header_split_enabled = rx_alloc_cfg.enable_header_split;
 		priv->tx_desc_cnt = tx_alloc_cfg.ring_size;
 		priv->rx_desc_cnt = rx_alloc_cfg.ring_size;
@@ -944,7 +954,8 @@ static int gve_get_ts_info(struct net_device *netdev,
 
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
-	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+				 ETHTOOL_RING_USE_RX_BUF_LEN,
 	.get_drvinfo = gve_get_drvinfo,
 	.get_strings = gve_get_strings,
 	.get_sset_count = gve_get_sset_count,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8d825218965a..8009819c73f2 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1722,6 +1722,13 @@ static int verify_xdp_configuration(struct net_device *dev)
 		return -EOPNOTSUPP;
 	}
 
+	if (priv->rx_cfg.packet_buffer_size != SZ_2K) {
+		netdev_warn(dev,
+			    "XDP is not supported for Rx buf len %d. Set Rx buf len to %d before using XDP.\n",
+			    priv->rx_cfg.packet_buffer_size, SZ_2K);
+		return -EOPNOTSUPP;
+	}
+
 	max_xdp_mtu = priv->rx_cfg.packet_buffer_size - sizeof(struct ethhdr);
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT)
 		max_xdp_mtu -= GVE_RX_PAD;
@@ -2050,6 +2057,44 @@ bool gve_header_split_supported(const struct gve_priv *priv)
 		priv->queue_format == GVE_DQO_RDA_FORMAT && !priv->xdp_prog;
 }
 
+int gve_set_rx_buf_len_config(struct gve_priv *priv, u32 rx_buf_len,
+			      struct netlink_ext_ack *extack,
+			      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+{
+	u32 old_rx_buf_len = rx_alloc_cfg->packet_buffer_size;
+
+	if (rx_buf_len == old_rx_buf_len)
+		return 0;
+
+	if (!gve_is_dqo(priv)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Modifying Rx buf len is only supported with DQO format");
+		return -EOPNOTSUPP;
+	}
+
+	if (priv->xdp_prog && rx_buf_len != SZ_2K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Rx buf len can only be 2048 when XDP is on");
+		return -EINVAL;
+	}
+
+	if (rx_buf_len > priv->max_rx_buffer_size) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Rx buf len exceeds the max supported value of %u",
+				       priv->max_rx_buffer_size);
+		return -EINVAL;
+	}
+
+	if (rx_buf_len != SZ_2K && rx_buf_len != SZ_4K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Rx buf len can only be 2048 or 4096");
+		return -EINVAL;
+	}
+	rx_alloc_cfg->packet_buffer_size = rx_buf_len;
+
+	return 0;
+}
+
 int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split,
 			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
-- 
2.51.1.814.gb8fa24458f-goog


