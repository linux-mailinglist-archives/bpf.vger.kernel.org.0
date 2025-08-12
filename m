Return-Path: <bpf+bounces-65459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B71B23B8E
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF11B607DB
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0912E1C4C;
	Tue, 12 Aug 2025 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLtYCJsG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A92DF3F9;
	Tue, 12 Aug 2025 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036122; cv=none; b=CFiYGpocKpY+PW8v5l/4er3fk0VO5r1tqVBpef8YalyVvYOfFLFgzsaAMAKrBCsC3bHky9wDO+Xzcg/pyqyc3MhQJm39jROM+hh2+J+C7hwtWXFyQSZzbvuU3KHkAJ49KuttkhJNTpII48I+VbDelh7Qb1MmUZ7KviWnCtJdd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036122; c=relaxed/simple;
	bh=diCsuI9hWsPC473mGUixtnjkEdOeHykLqJbaVtFnBMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrU/jPdmwQTbuGWsG+BCo6ClUF4kBwHomX+6JjmeoUHdGebDb8MEveg5PvZwLYJabmqVsnbqCuIKSBW8Snc1OOpyguoVOCOB75adkk1DCcgIpFhI7Xj956rujIhGKw2DpvMZtsFE5aIBsBwZnL+a4QFM2ZisQF6dzGs8rHI1K/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLtYCJsG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459ddf83023so36507535e9.0;
        Tue, 12 Aug 2025 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036119; x=1755640919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzffaNbuaREaEmpag6LLHmQceARFZNpQ4mFVUhH7Bw4=;
        b=VLtYCJsGvAh7tm/6FPSDUwW8jt6pocGHoeB3erpA++8XzrFfgZNRTjED3+Blk7FyTa
         qZagel0Ka9T1Nz7u+EXahL+ENOeLgUESJrh+drSYCDjmNnCb8EMuImbc8MU2MOzmdGli
         JqE3P+Fn2lnNex0eyfiER9h/+bN9RKqBuPo9z7aki2tCJcKe6qhsXz1as/wy+So7Yhtt
         9XaGWxp1X1timy8mhGDVIBzE0qKu0JrjvqpK3S0T08SckLOWajiT/Xfgru5xs6JnCDyR
         gVczvyGd/YPhjK+iC+7QtZG5rr+r2DFrZUYUUgjUsZP4nKygrNl9pJy2p4Lk8xM6N8C6
         relg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036119; x=1755640919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzffaNbuaREaEmpag6LLHmQceARFZNpQ4mFVUhH7Bw4=;
        b=LkeFZgRSLNl6X5Moo6SbohwDQXV15DQx8g23ZZ74UF+MAaaErfacm2uHo9xplYX7/R
         KJyI93P92xOCX5N1aeh/ThGYF93B4WIsTF5iwgjKiw1MU2GxZnPT1w8w1n7MF5RQ/jzH
         3yd2wKugOTw3M5icqcOShT9fLPdk03onATWZ63brq5dsFrLl8Huow8CjQh9Yfp5d8Fnf
         XgNRchCC8zVq8ZpoCUmMzhv9faMrNBEupOh7wnnHfNhQBEoIVnVMKFzz1y04rzgmg9Cz
         qAYL9h7JzklL09A2ryJLu3O8LkkZvXRWOlWzAw//cZTNd4oQSSgfTURTZAQkPUJcGyCn
         eAjw==
X-Forwarded-Encrypted: i=1; AJvYcCU7zV2D+cz7+KEoriQZp5T5HWkkn3iy1TvX7Er59RBzUc8XAEx45jBlplIcScoy6CRXj3M=@vger.kernel.org, AJvYcCUYqT4qaFppWPEkenpAK60VMVKbmp9exD01iAErNHdTORfwJpEo30VDG6I+vogX1LZ0jmpE8QCqGq8J@vger.kernel.org, AJvYcCXX90qZTdZreSQ7O60bdF0LQedyjscKUpF7bLdgpfX+XX7Q1an7TbCh1wg1JarIzOjcM8MXKyNvKqwxdFTe@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAA7OF6wHMZ7XJB/oKE2V4Yl5M3+Pjzk3M3KO3gGGnS/4ipdr
	1XVB4/zblspKd3u0hZ7Hv5RbiyERXBYhtZVvHcRs4g3iTKV800RgC9mfTvfyVXMC
X-Gm-Gg: ASbGncu/KrELrFMrrdMa65hNwMajaHOfd94yRygZqRqXmsUvcKAPW8GStrfaiSKiBAP
	/3DEd6+2mFbtQkfNpzGfyRTuWefLX64qrDQpAj2wUDcRdSZHJA963JGnunr1ofXQvHH/DV8+7iX
	vGH7CfrSKYoezw4L3VUkLHuRX7ZRFeKzMz0jzZIWYkgz1Qb8wP518xpRCf1AocMIXptdwjNwJHT
	pjtkQLJGW/EDk0Rl+ErmDj6xpkPD0nSUy8VJgVPbMSlh7qbPpUc6CTYMLVJbQ+FMVCHiOTEVc6B
	3n3pjlyFLAyuUrGwVx2/no35ME1ofsntY/rT7nDJJOjWfsHnAvut3J5NsHxZ9mixf0GBFrttjlS
	4+qEtQDbMFYFLLOT0T2Q=
X-Google-Smtp-Source: AGHT+IH3JA4WbqL1N6he/EKnsddNNP6veu13mG8TokVbOj3RbB5aL/gjO0AFzS4DbjR0SKhj6tkppQ==
X-Received: by 2002:a05:600c:5246:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-45a165b2cb7mr5259715e9.8.1755036118502;
        Tue, 12 Aug 2025 15:01:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16de760fsm3399505e9.17.2025.08.12.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:01:57 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V3 1/9] eth: fbnic: Add support for HDS configuration
Date: Tue, 12 Aug 2025 15:01:42 -0700
Message-ID: <20250812220150.161848-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812220150.161848-1-mohsin.bashr@gmail.com>
References: <20250812220150.161848-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring the header data split threshold.
For fbnic, the tcp data split support is enabled all the time.

Fbnic supports a maximum buffer size of 4KB. However, the reservation
for the headroom, tailroom, and padding reduce the max header size
accordingly.

  ethtool_hds -g eth0
  Ring parameters for eth0:
  Pre-set maximums:
  ...
  HDS thresh:		3584
  Current hardware settings:
  ...
  HDS thresh:		1536

Verify hds tests in ksft-net-drv are passing

  ksft-net-drv]# ./drivers/net/hds.py
  TAP version 13
  1..13
  ok 1 hds.get_hds
  ok 2 hds.get_hds_thresh
  ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by ...
  ...
  ...
  ok 12 hds.ioctl_set_xdp
  ok 13 hds.ioctl_enabled_set_xdp
  \# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 21 ++++++++++++++++---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 17 +++++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  7 ++++++-
 5 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index dc7ba8d5fc43..8ae2ecbae06c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -2,6 +2,7 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <net/ipv6.h>
@@ -160,6 +161,7 @@ static void fbnic_clone_swap_cfg(struct fbnic_net *orig,
 	swap(clone->num_rx_queues, orig->num_rx_queues);
 	swap(clone->num_tx_queues, orig->num_tx_queues);
 	swap(clone->num_napi, orig->num_napi);
+	swap(clone->hds_thresh, orig->hds_thresh);
 }
 
 static void fbnic_aggregate_vector_counters(struct fbnic_net *fbn,
@@ -277,15 +279,21 @@ fbnic_get_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	ring->rx_mini_pending = fbn->hpq_size;
 	ring->rx_jumbo_pending = fbn->ppq_size;
 	ring->tx_pending = fbn->txq_size;
+
+	kernel_ring->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
+	kernel_ring->hds_thresh_max = FBNIC_HDS_THRESH_MAX;
+	kernel_ring->hds_thresh = fbn->hds_thresh;
 }
 
 static void fbnic_set_rings(struct fbnic_net *fbn,
-			    struct ethtool_ringparam *ring)
+			    struct ethtool_ringparam *ring,
+			    struct kernel_ethtool_ringparam *kernel_ring)
 {
 	fbn->rcq_size = ring->rx_pending;
 	fbn->hpq_size = ring->rx_mini_pending;
 	fbn->ppq_size = ring->rx_jumbo_pending;
 	fbn->txq_size = ring->tx_pending;
+	fbn->hds_thresh = kernel_ring->hds_thresh;
 }
 
 static int
@@ -316,8 +324,13 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		return -EINVAL;
 	}
 
+	if (kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot disable TCP data split");
+		return -EINVAL;
+	}
+
 	if (!netif_running(netdev)) {
-		fbnic_set_rings(fbn, ring);
+		fbnic_set_rings(fbn, ring, kernel_ring);
 		return 0;
 	}
 
@@ -325,7 +338,7 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	if (!clone)
 		return -ENOMEM;
 
-	fbnic_set_rings(clone, ring);
+	fbnic_set_rings(clone, ring, kernel_ring);
 
 	err = fbnic_alloc_napi_vectors(clone);
 	if (err)
@@ -1678,6 +1691,8 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_RX_MAX_FRAMES,
+	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+					  ETHTOOL_RING_USE_HDS_THRS,
 	.rxfh_max_num_contexts		= FBNIC_RPC_RSS_TBL_COUNT,
 	.get_drvinfo			= fbnic_get_drvinfo,
 	.get_regs_len			= fbnic_get_regs_len,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index e67e99487a27..a7eb7a367b98 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -695,6 +695,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbn->rx_usecs = FBNIC_RX_USECS_DEFAULT;
 	fbn->rx_max_frames = FBNIC_RX_FRAMES_DEFAULT;
 
+	/* Initialize the hds_thresh */
+	netdev->cfg->hds_thresh = FBNIC_HDS_THRESH_DEFAULT;
+	fbn->hds_thresh = FBNIC_HDS_THRESH_DEFAULT;
+
 	default_queues = netif_get_num_default_rss_queues();
 	if (default_queues > fbd->max_num_queues)
 		default_queues = fbd->max_num_queues;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 86576ae04262..04c5c7ed6c3a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -31,6 +31,8 @@ struct fbnic_net {
 	u32 ppq_size;
 	u32 rcq_size;
 
+	u32 hds_thresh;
+
 	u16 rx_usecs;
 	u16 tx_usecs;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index f9543d03485f..7c69f6381d9e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2232,13 +2232,22 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 {
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 log_size = fls(rcq->size_mask);
-	u32 rcq_ctl;
+	u32 hds_thresh = fbn->hds_thresh;
+	u32 rcq_ctl = 0;
 
 	fbnic_config_drop_mode_rcq(nv, rcq);
 
-	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
-		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK,
-			      FBNIC_RX_MAX_HDR) |
+	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
+	 * be split at L4. It would also result in the frames being split at
+	 * L2/L3 depending on the frame size.
+	 */
+	if (fbn->hds_thresh < FBNIC_HDR_BYTES_MIN) {
+		rcq_ctl = FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT;
+		hds_thresh = FBNIC_HDR_BYTES_MIN;
+	}
+
+	rcq_ctl |= FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
+		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK, hds_thresh) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,
 			      FBNIC_RX_PAYLD_OFFSET) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 34693596e5eb..7d27712d5462 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -53,7 +53,6 @@ struct fbnic_net;
 #define FBNIC_RX_HROOM \
 	(ALIGN(FBNIC_RX_TROOM + NET_SKB_PAD, 128) - FBNIC_RX_TROOM)
 #define FBNIC_RX_PAD			0
-#define FBNIC_RX_MAX_HDR		(1536 - FBNIC_RX_PAD)
 #define FBNIC_RX_PAYLD_OFFSET		0
 #define FBNIC_RX_PAYLD_PG_CL		0
 
@@ -61,6 +60,12 @@ struct fbnic_net;
 #define FBNIC_RING_F_CTX		BIT(1)
 #define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
 
+#define FBNIC_HDS_THRESH_MAX \
+	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
+#define FBNIC_HDS_THRESH_DEFAULT \
+	(1536 - FBNIC_RX_PAD)
+#define FBNIC_HDR_BYTES_MIN		128
+
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
 	ktime_t hwtstamp;
-- 
2.47.3


