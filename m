Return-Path: <bpf+bounces-65387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D022DB21724
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25DA7A304F
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D62E336F;
	Mon, 11 Aug 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUGVuolr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E239311C02;
	Mon, 11 Aug 2025 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946844; cv=none; b=hQsxdLBM+T+DaZaSrYZQPIKZRNGYr5h/nJ/sxUZaBWVDDIyfPZjUTlrpHx7EmPMollOXe4Hw0kFvUo10jtnIgvvxW9JYJdLbpH0W/w9QA4Ffqeuuf1vcTwE6+ypB5y/BoVWSCbLJX+2G9AyoD4AKz7ZCDdw1mUF8Azg/tWWoUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946844; c=relaxed/simple;
	bh=dWuFJvQDINQLKMFQzS+VI5nAxGm2Swmnyhbm8gRSYu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEWfD9UDLpsn0Pc2sTKQp0qzyNJxz0KREGdLLw5xHiuuHjAsICWzKYTptuSrUIhJxiFA+9l4CNsorWStXdkK6oQ/eo6urw+2T3T9MxhlmahFAauFG+d2aQGcpP7OkqZVIrZJAnQLn90L+dP6DOjBN0pUz2beXtCZy1U6Glcf/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUGVuolr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so44339785e9.1;
        Mon, 11 Aug 2025 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754946841; x=1755551641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3IZaUWMwmtUswxPOXQb8q4PT00Ga5igdAqlSCPEgDQ=;
        b=UUGVuolrNXRPDUPrEBA9Q/0si/tRsuCxe1gWCxCTQW8q2vEB9uBm8VbVBJvxOsCyxX
         vfR6hYP0M91Iz+BeqVd8r+Ln8on+IDVEWSlPXokJgiueuBXrZdgNRiKWcMMjNTHqCdd0
         yFo5cZQVE7rQr5DGTHvoH6aEK7eY0pUeR+RCekLzd8EIhLoijf2TRJ2Os3dqCy+qOPlc
         LLHp1GV1XAJaDaXngxCLX+F2kERFLFvw/awBnpI/4tfQMUATUyJi8Ii/gn7xCbW+2R+E
         lqA7CHHkRsvWJVmxWPhE0/jbo+NMFkFB9+H09BLcv23BmC74Vd82J9sCngqIot5rWVmC
         oqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946841; x=1755551641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3IZaUWMwmtUswxPOXQb8q4PT00Ga5igdAqlSCPEgDQ=;
        b=fsncl/aSVNdlvPDtkd+imWL6djwAIxUFiZbLhIQ1TQ/XhWOviMRCUuj7SRVlU9Rt7Q
         v8mWKJp8ivV3dicRnmzij5LFyMNkIBFWZ5nYWBVyDFPhCaW4Drp34BHc5Dceatq7DaqZ
         bTVXIOUOZBm4a3crCwoPJrlijHgWIHOP56aE9CmByMy0UqiEGOClj+XWpW4OdOfNXySz
         4x89eMRZiGy694j/M1UQni9FC8Bdxg7wnr6D68oJbPaT5av+X0BoDVXF+LeplgJHL7s2
         Ig0HRnkxSS+bpurGd2J28J5tmykX/Jsr/SvWX6dtS2LJmCYaFvd6NhvEJ8xD1juepTlx
         kECA==
X-Forwarded-Encrypted: i=1; AJvYcCXPzR4oI7mVTZBGCAJ4Eq53Tjnrz6OBYZjbrRmDW4AGfXPEStngWDQPCz8KatG/OFJyI8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdoH+yc3sCSHa1j4zzCEQvnKfB9a19rku8/yaT+qxsK43SLFe
	bbc7moD57OrDviIUy60s+7J9RUCqujd9h8+KkWos50xuLD7f9i0ymuuVBTN5NQ8O
X-Gm-Gg: ASbGncsVYqH/1Oaxh4NRlJl6QVjTnx9KJAvXg5CqNbj5cGMUlXISjPPlxjzY5P1SDA4
	SxbYwdI8wZVusk8m/EcOe6YewjOZkJLVOZKKbFyJ4jxXwihQQA326NfjOFPT29C+I6+5YGaKFWM
	cimSpNlHdptBk6/YkucR+bQndzD7QINRb2J5BcnCMBEGHtlS/s/XBQTzLQpl2AzA96JXW08Pa7/
	81wJzoU2gcCk4OtMqtHT/jc02IBGp7LNXuZsc0UXoE/a5l3WYexAZwQ4rxFhTotlRnajGSPEXR/
	eUP4eP56flhVVtFe1PsWHnGz9tLlZSvbcAlJ6kxJnlFzhe+FmxOcRpZC2y1y37tZTR3eCGH2Se6
	Dy9vsTdQ2n6pThjNDOwpo
X-Google-Smtp-Source: AGHT+IFiVihKbGbtp4emIw0HWk8Shd/uKTNS9nK1Hg5kJksN3iSnx093pl1VFDcfXWCG4s6XtJjQjw==
X-Received: by 2002:a05:6000:290c:b0:3b7:899c:e887 with SMTP id ffacd0b85a97d-3b900b4f687mr13141754f8f.24.1754946840772;
        Mon, 11 Aug 2025 14:14:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:49::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm42722068f8f.28.2025.08.11.14.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:13:59 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
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
	jdamato@fastly.com,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next V2 1/9] eth: fbnic: Add support for HDS configuration
Date: Mon, 11 Aug 2025 14:13:30 -0700
Message-ID: <20250811211338.857992-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811211338.857992-1-mohsin.bashr@gmail.com>
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 21 ++++++++++++++++---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 15 ++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  6 +++++-
 5 files changed, 41 insertions(+), 7 deletions(-)

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
index f9543d03485f..c80cbde50925 100644
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
 
+	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
+	 * be split at L4. It would also result in the frames being split at
+	 * L2/L3 depending on the frame size.
+	 */
+	if (fbn->hds_thresh < FBNIC_HDR_BYTES_MIN) {
+		rcq_ctl = FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT;
+		hds_thresh = FBNIC_HDR_BYTES_MIN;
+	}
+
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
-		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK,
-			      FBNIC_RX_MAX_HDR) |
+		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK, hds_thresh) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,
 			      FBNIC_RX_PAYLD_OFFSET) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 34693596e5eb..626c8a137720 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -53,7 +53,6 @@ struct fbnic_net;
 #define FBNIC_RX_HROOM \
 	(ALIGN(FBNIC_RX_TROOM + NET_SKB_PAD, 128) - FBNIC_RX_TROOM)
 #define FBNIC_RX_PAD			0
-#define FBNIC_RX_MAX_HDR		(1536 - FBNIC_RX_PAD)
 #define FBNIC_RX_PAYLD_OFFSET		0
 #define FBNIC_RX_PAYLD_PG_CL		0
 
@@ -61,6 +60,11 @@ struct fbnic_net;
 #define FBNIC_RING_F_CTX		BIT(1)
 #define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
 
+#define FBNIC_HDS_THRESH_MAX \
+	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
+#define FBNIC_HDS_THRESH_DEFAULT \
+	(1536 - FBNIC_RX_PAD)
+
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
 	ktime_t hwtstamp;
-- 
2.47.3


