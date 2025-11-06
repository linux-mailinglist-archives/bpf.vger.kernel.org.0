Return-Path: <bpf+bounces-73900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284BC3D3E6
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 20:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390263B8584
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9C350D41;
	Thu,  6 Nov 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nuipWcF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501BC3557F5
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457299; cv=none; b=MAaTBhPYvypVq+hA9wisFQX4zqeOQ/Fiy4dpvKL/PWzbv7Xg2oMmu7NdC5nu6B6fTnqcfTtCIvaZTFlHDnMBOrZCSnA0FJuGJCfU0Y3Z/ni50yxskLnRZyykAigcU+P3CNXvpOH6A2plobSLSEHK6j9pFE2XAxyrYRRi22b8yKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457299; c=relaxed/simple;
	bh=Xb4EfJdY6bPJY5RRiIfdF/NTZ7iibhgTGr5o3oPF3g4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lva5cedpvm9AB9GpUtHpVxkAWZYbcfwl4mzgfNyNW7HheOhujKWwXH2+zWaCZGi87x1zvBvU0Mn2k0Dd0y+eyaEFZSktDw0A/paPp08lR5SYcLbXcyxO2a1loWZbOirk6Xz/oo3ImavsxmKj0wbNW5/GRGIJT037kcle6HIcue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nuipWcF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba795c4d4a2so975257a12.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457297; x=1763062097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JM9jdZzTWd6aLiHrXhH8eGJ9TVRerOe4nqWwRUMVsg=;
        b=2nuipWcFo49jIv9Iv2llln7A70bCFjYdz1Bk3nKkpbomUK6i9r7zGcu8Mnb2V2xEWc
         zm0kTah+sYnHqcHtXwnoFjhc7Yt4aYMn600D2awCjouzJeM2GaIhCcr3tAMAOpH0ynA5
         p46QszYhZExLydXFxfMgmFdigKiSkHEMEwpUklO8cCDjbhlbaxuc0k97Eqn57rC+uSZS
         eXJCMK6plNOtoo8IlQInP+BTv+huvLYZPVl9NNDe6SJ6rEMNO1u+l1vf+bYVdkuqZslP
         r3aGFKnhMN9Z0PnXsRLPYA/59TewJ0/OxtnfEfjfpPxiBk4EzV6zgeMK+xy7sANsGewe
         N/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457297; x=1763062097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JM9jdZzTWd6aLiHrXhH8eGJ9TVRerOe4nqWwRUMVsg=;
        b=AujLneSBe6cz7DBzjyr2R3b7APGY+g7Dwtj/1viyqZUDAcBgll9Ev0lFJUCRf1/ou3
         31EKj42OP4TUCLABDBnUgnIpvsO5VOUyXeHbogys8rZ/0caKKIpmmF7jFwKqq+LCNYYi
         t8VrGmCFRcnyRKKSqqHhazy1CqDszD5QfPRkD6ZCOaAbhDfK21CrM5OOIaG03ILMydQ3
         0RZ6gTeNKrkLgtyGiapCnk/30UwnreULQxPU+CYq7gyRi1l9Orgp7d2VOYtoNgBxr6mY
         qkvC5QRALluPAK4jTehVV9Laf+JWYzaclgpmZNpAn1+aSAWlKsNqAqDJKIi+XqHnHDYI
         7GXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR3X6RcvLgWZvvyr6wyM2e96Q6TseWf86vNgki1bCVofkO4hS8dtLzsctKsTn1bVLd5DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRG9/usP3GmMp1/8a+Fni0eHvlKhWSsWLNbxeSiKh5aqbEOHu
	TMi9JE69PgwdVhFETYVKUD9DEagIp7Tp7+vg9iJVjFuBTqLIE3jcs3lzHrQO0K3xRRJfMkmyl1P
	v6sG0Ne7ZhyFCYg==
X-Google-Smtp-Source: AGHT+IHGM7JVCPtaPwEFgfbgQR8t2tAo11fskdg8fmXe8PTIoLmsll2rbUTNi7cuelWzWi1tOatyEbKa4QTqwQ==
X-Received: from pjty1.prod.google.com ([2002:a17:90a:ca81:b0:33b:51fe:1a89])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3885:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-3434c4fa855mr370694a91.14.1762457297556;
 Thu, 06 Nov 2025 11:28:17 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:45 -0800
In-Reply-To: <20251106192746.243525-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106192746.243525-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-4-joshwash@google.com>
Subject: [PATCH net-next v3 3/4] gve: Allow ethtool to configure rx_buf_len
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Add support for getting and setting the RX buffer length via the
ethtool ring parameters (`ethtool -g`/`-G`). The driver restricts the
allowed buffer length to 2048 (SZ_2K) by default and allows 4096 (SZ_4K)
based on device options.

As XDP is only supported when the `rx_buf_len` is 2048, the driver now
enforces this in two places:
1.  In `gve_xdp_set`, rejecting XDP programs if the current buffer
    length is not 2048.
2.  In `gve_set_rx_buf_len_config`, rejecting buffer length changes if XDP
    is loaded and the new length is not 2048.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
* Removed newline from extack messages (Jakub Kicinski)

Changes in v2:
* Refactored RX buffer length validation to clarify that it handles
  scenario when device doesn't advertise 4K support (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve.h         |  9 +++++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 ++++++++++++-
 drivers/net/ethernet/google/gve/gve_main.c    | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 872dae6..bebd1ac 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1165,6 +1165,12 @@ static inline bool gve_is_gqi(struct gve_priv *priv)
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
@@ -1246,6 +1252,9 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
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
index db6fc85..52500ae 100644
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
index c1d9916..2a24b3a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1725,6 +1725,13 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	if (priv->rx_cfg.packet_buffer_size != SZ_2K) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "XDP is not supported for Rx buf len %d, only %d supported.",
+				       priv->rx_cfg.packet_buffer_size, SZ_2K);
+		return -EOPNOTSUPP;
+	}
+
 	max_xdp_mtu = priv->rx_cfg.packet_buffer_size - sizeof(struct ethhdr);
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT)
 		max_xdp_mtu -= GVE_RX_PAD;
@@ -2056,6 +2063,38 @@ bool gve_header_split_supported(const struct gve_priv *priv)
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
+	/* device options may not always contain support for 4K buffers */
+	if (!gve_is_dqo(priv) || priv->max_rx_buffer_size < SZ_4K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Modifying Rx buf len is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (priv->xdp_prog && rx_buf_len != SZ_2K) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Rx buf len can only be 2048 when XDP is on");
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
2.51.2.997.g839fc31de9-goog


