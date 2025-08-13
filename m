Return-Path: <bpf+bounces-65571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6034B25651
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5C1C249F0
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B882FFDDE;
	Wed, 13 Aug 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFO+Zd4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599842F99BF;
	Wed, 13 Aug 2025 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123214; cv=none; b=Ul32e9p6Wi8YGbiDooeNRSotJTsiZuMoY4ZQFmOAN//M7XfSuzaD+wLZfRd1F50yxFzXybi+h+8um5oDxnAKRffupbrmzNdPdepDN+Z8Fphs9y7JevFY394QLPZrRWavhWBYdij9b/voCmP+zXr8+ygvqTYgohzIp0aIIuIXmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123214; c=relaxed/simple;
	bh=diCsuI9hWsPC473mGUixtnjkEdOeHykLqJbaVtFnBMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+vzj7R+4yynvkGHQqMi8+lGuAdoewyoh1HAbIzmz3G5QtdR35fFu0ZDtbJ0NMDoy7M4UicssZ9lzfqONA4frB8fj7Zo/sDrZM9R9tLFx5ydJQZS+yGC9NgQVyHh60oG83+/sSF+KCuJE4J+ObTKiNQZqudGXIH29o9do/sKANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFO+Zd4d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e414252dso156780f8f.3;
        Wed, 13 Aug 2025 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123210; x=1755728010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzffaNbuaREaEmpag6LLHmQceARFZNpQ4mFVUhH7Bw4=;
        b=KFO+Zd4dqo4PzYwUIeke/EJ1FtC9L5TMQjbzF4tPWNJcfa6g/mAJSw+9QA+smPHJ4n
         gve2VaL+IrHLORtq/4GUIyU1+1FVTA+TBEzS9NvLOVfQYKyNbPyrG0Ox0oAW/vwj44cM
         MywInX7L+XI3RNCPwyu5eGC7st6fQqLLXvC/9jXF37X7a60WxKb+ElT1x1ACySInJpTO
         d2L7qltZtrghyaS6UaynbqXeY9ji3k6OINrkQmRb1OnEnLI0oH0hqq8/Pa820mZrtzWb
         LOcBIwpkfMvAxwULWccg15SQj7SON0jgYZOGeHF6aISppEFBvZHbnAoUb/fEapowfmoB
         ZoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123210; x=1755728010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzffaNbuaREaEmpag6LLHmQceARFZNpQ4mFVUhH7Bw4=;
        b=Adfmk4whojDFm/wUpZOgA/QnlL83XQLhUak7yIOPtN88hxayRhay8aB9VpJ7cVl9BC
         3HT0ffq6pNtZlvRw211gmzLoW0UmKbCMW5m9k+B+lnnGoChaN7JvC/Vq7S/0Dj1z/tHT
         MZyzJB3hBmxDWO82WrctFniYeOD36n0ACKgQLNE94WI1xHG8WNo7SZ4WdulZSu5cku0h
         XhM4sAGE5vYeEWEVNthhFz1WDY468DQPL05Ap1MbS4w0zi5+mBOsHvx0JeARi/MJb85Z
         XSbLtDV1rrMXYeVTX/WGHAckmeDbFAI5OX1OyooYiUDMvEh81ouCQF/y8qUfhhuHt23K
         wBlg==
X-Forwarded-Encrypted: i=1; AJvYcCVfkl2gJRWqJfrbNUHQTTuBRdHw+oNJE7/Kqe11UDy4blIC9fjh8z5N4Db8dKz/lTfSj07RmMqDBuZ31pXx@vger.kernel.org, AJvYcCWMbjczRo2O8ziP/xHWLxHM4zjRhYNPPpqisGs1soYF0iOWh0sftZSv6uKW+3agLnaysGuwgOCLvASk@vger.kernel.org, AJvYcCX/R/c6zDfIOisTFAimOj+WbfOgQN023mEONmkVKy9XDrs1L0oy/5ZLKoYwu6Py9y7yG/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZw/VO+eIQbsSBWgx4P/b0Lf6ZCEM8HGPYaDbnDgcd3/h9DjV
	gCubT86vNPgXmmykV1y+M/AHtuRKkP9R66lt4cIXlMowCecPuJFeh1+T82G6noHZ
X-Gm-Gg: ASbGnctxZAAS0pOZx1BBV0AylyK9KVSkiZM222T1pPH6CEQrg4GVzR9EXj3PIn7Q2aZ
	lsS/VVdTY6DFemDm+LqDhr9gTvUpfRzke2/8vl9j2gH9opKqG3vpmx9zl3J9NT2zNXo9JgGBp1L
	mOW/Ir28IYKyywFMG7W364TcyiruIMTLYbt/1TiK7VopNpma+Gtt66GujyFwQe0eTa4FUUjno6n
	EUNEtulZtkqZj9+7mxaK/ZzueM2WuMk30BxhX/0b7FrugEQOjKjSB6yRkE++9yuBvww2PwlMY0r
	IpjCGtkhk23N5pkhL3+lt6il8lxCULhCp+zEoYgzPFz/sb5rkF6fZebEH3xWzhKc9sOLGWiQSIX
	P1aRVtK2wqVW5Rm+TSFQwzuPgQYeGYhM=
X-Google-Smtp-Source: AGHT+IEHzjwGMcWiLJKH/d0/fbpHRcxeewf4XshcjjykG8yqXkkKfQIl3An9ZLfRicEOU/R8icUetQ==
X-Received: by 2002:a5d:5f8f:0:b0:3b7:9bfe:4f64 with SMTP id ffacd0b85a97d-3b9fc382c99mr634922f8f.54.1755123209902;
        Wed, 13 Aug 2025 15:13:29 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b91330bfa3sm6616519f8f.29.2025.08.13.15.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:13:29 -0700 (PDT)
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
Subject: [PATCH net-next V4 1/9] eth: fbnic: Add support for HDS configuration
Date: Wed, 13 Aug 2025 15:13:11 -0700
Message-ID: <20250813221319.3367670-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
References: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
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


