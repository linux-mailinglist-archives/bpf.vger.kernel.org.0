Return-Path: <bpf+bounces-43082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB469AF328
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 21:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98D71F21C7A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CCE1FF7B4;
	Thu, 24 Oct 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwsgc4hE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D917333D;
	Thu, 24 Oct 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799920; cv=none; b=YxOoxmIJlLEwVShCtDOssqq2njbDFagleUc9HpL110FzafoIhBhbqSzGSTwkvTYxv2N1lVAx6L778sD/428NGwy+I8vF82izxQ3ah178tfDWUOuLl95u/ve2Spvjc5dXLbX/kCGDId4YNOsWPqQOSJ6bS3tpozdn0ZCubcO9dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799920; c=relaxed/simple;
	bh=SylD/FPYMPNGXVx/b23+9YAx2tvTUGK4FTCC6Pk4rb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bp2cbPart1rAhKGCbgmgaTXv6NVw4PHu9AgVPpO7NxFPAqLUWkKm6C8Q0MNBpXPvo/NTcwD69szQo2PejnBxUXwILA80i8Ff0ddAqJ3vbt/+hUCdsS2CNHxyfQw3BiMjKX+H2X0qesbtQIHZTXJgAmmB76NKxsbEUM/+49eBANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rwsgc4hE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so1014025a91.2;
        Thu, 24 Oct 2024 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799917; x=1730404717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ0fckIUBSZGYm0Y3cG31DTqbNFeUBeqFQ0n5b8DC4o=;
        b=Rwsgc4hEW4cDCCT/Zp/L+z3+oQ0FihIguaRztALzmY6xrX5JXhAVYfEfHetMZJpHhT
         4NZxRz/fcL+NOtwt7WeqbA8zcYLUOMTh5pVYIuJrzggA2wAjDGPRhbhKBo1nLkFkIjAn
         hTM0UIK0cJJjvQHinP1G4ulwjCfjUE1T16pXZfTM5ihY/JnopE2NGOS7kj+vIvqqNTqt
         /JsQJoX5kJpVDS5MOapSanfAP8GVzq+bg/CMqHIM4FZ80TapWeHtIm9k3VIS8+O3v0ZQ
         CLmR2/f6yKOWSzEvtnlCBMUuePnwmFrEra2UpiHlNESdYo05zDuKdJbOGITiPF3HaODu
         1JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799917; x=1730404717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ0fckIUBSZGYm0Y3cG31DTqbNFeUBeqFQ0n5b8DC4o=;
        b=iTu0Mbbdl70xdV+h6y9l4hklZd/N+MKbWLdjsjeCBKGNQF8xt/cI6gBKNBKrOKyI/G
         DeobxWpbz/xAWprrFUhBwJ+JMt8+9ER5HNEALqQFdtpSu3qC7kPSYKJrxMrbAq4C85jT
         aHZimxkAeglSb2z9tZBW7WpbmfjYBxwv8ej0zWmKYdjyu84HPVJXote72Ar5f3QPZzng
         X+iIpGbi6ZhSyATPjxmqLaG/OFKsE2a4Ngffs1KPWEh3QUX/4tsgEccmj/HwRh+WVgHw
         fEsAiyiTPOk+eumJ66rAsyJjDHfLMo1WnBajEO7DS3fOZ3kQBlvhkdX+viLz9+SefRNE
         FqNw==
X-Forwarded-Encrypted: i=1; AJvYcCW/ii0Gw9zWbj/b28juUSrMJ4A4fseHvQe5v+pmb1itd8jRUE/W78VHfjqngfpgdjJ3cyg=@vger.kernel.org, AJvYcCXYLfXwIYOgVjKBML0GAtvvru8O122E3pcPFVNQwlUn1O9h9oeGf3066L9DE+/Vc19h0Hwl+70lP83jmpol@vger.kernel.org
X-Gm-Message-State: AOJu0YzGf1TzBfl0GWdMGJWoEi42/Y5RZvY4rlczDA6Aoyva7zEyh0JL
	1C2k6NFWK7tC2pLIB9cF+xpKnnELihGxBlTCT0Zigby3OqlfZOmjcFxLKsue
X-Google-Smtp-Source: AGHT+IEYaZRBRpxjeM2dXVVDRby3CtroIFkM9Ji2wlvhOTDjAbPEyy1LR3V313OOqkt63b5yLLwThA==
X-Received: by 2002:a17:90b:370e:b0:2e2:d7db:41fa with SMTP id 98e67ed59e1d1-2e76b711b55mr7685245a91.33.1729799916696;
        Thu, 24 Oct 2024 12:58:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e587402sm1905910a91.48.2024.10.24.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:58:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Rosen Penev <rosenp@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next] net: marvell: use ethtool string helpers
Date: Thu, 24 Oct 2024 12:58:33 -0700
Message-ID: <20241024195833.176843-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter is the preferred way to copy ethtool strings.

Avoids manually incrementing the pointer. Cleans up the code quite well.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 39 ++++------
 .../marvell/octeon_ep/octep_ethtool.c         | 31 +++-----
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   | 31 +++-----
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 78 +++++++------------
 drivers/net/ethernet/marvell/skge.c           |  3 +-
 drivers/net/ethernet/marvell/sky2.c           |  3 +-
 6 files changed, 68 insertions(+), 117 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 103632ba78a2..571631a30320 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1985,45 +1985,32 @@ static void mvpp2_ethtool_get_strings(struct net_device *netdev, u32 sset,
 				      u8 *data)
 {
 	struct mvpp2_port *port = netdev_priv(netdev);
+	const char *str;
 	int i, q;
 
 	if (sset != ETH_SS_STATS)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_mib_regs); i++) {
-		strscpy(data, mvpp2_ethtool_mib_regs[i].string,
-			ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_mib_regs); i++)
+		ethtool_puts(&data, mvpp2_ethtool_mib_regs[i].string);
 
-	for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_port_regs); i++) {
-		strscpy(data, mvpp2_ethtool_port_regs[i].string,
-			ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_port_regs); i++)
+		ethtool_puts(&data, mvpp2_ethtool_port_regs[i].string);
 
-	for (q = 0; q < port->ntxqs; q++) {
+	for (q = 0; q < port->ntxqs; q++)
 		for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_txq_regs); i++) {
-			snprintf(data, ETH_GSTRING_LEN,
-				 mvpp2_ethtool_txq_regs[i].string, q);
-			data += ETH_GSTRING_LEN;
+			str = mvpp2_ethtool_txq_regs[i].string;
+			ethtool_sprintf(&data, str, q);
 		}
-	}
 
-	for (q = 0; q < port->nrxqs; q++) {
+	for (q = 0; q < port->nrxqs; q++)
 		for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_rxq_regs); i++) {
-			snprintf(data, ETH_GSTRING_LEN,
-				 mvpp2_ethtool_rxq_regs[i].string,
-				 q);
-			data += ETH_GSTRING_LEN;
+			str = mvpp2_ethtool_rxq_regs[i].string;
+			ethtool_sprintf(&data, str, q);
 		}
-	}
 
-	for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_xdp); i++) {
-		strscpy(data, mvpp2_ethtool_xdp[i].string,
-			ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_xdp); i++)
+		ethtool_puts(&data, mvpp2_ethtool_xdp[i].string);
 }
 
 static void
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
index 7d0124b283da..4f4d58189118 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
@@ -47,7 +47,7 @@ static const char octep_gstrings_global_stats[][ETH_GSTRING_LEN] = {
 	"rx_err_pkts",
 };
 
-#define OCTEP_GLOBAL_STATS_CNT (sizeof(octep_gstrings_global_stats) / ETH_GSTRING_LEN)
+#define OCTEP_GLOBAL_STATS_CNT ARRAY_SIZE(octep_gstrings_global_stats)
 
 static const char octep_gstrings_tx_q_stats[][ETH_GSTRING_LEN] = {
 	"tx_packets_posted[Q-%u]",
@@ -56,7 +56,7 @@ static const char octep_gstrings_tx_q_stats[][ETH_GSTRING_LEN] = {
 	"tx_busy[Q-%u]",
 };
 
-#define OCTEP_TX_Q_STATS_CNT (sizeof(octep_gstrings_tx_q_stats) / ETH_GSTRING_LEN)
+#define OCTEP_TX_Q_STATS_CNT ARRAY_SIZE(octep_gstrings_tx_q_stats)
 
 static const char octep_gstrings_rx_q_stats[][ETH_GSTRING_LEN] = {
 	"rx_packets[Q-%u]",
@@ -64,7 +64,7 @@ static const char octep_gstrings_rx_q_stats[][ETH_GSTRING_LEN] = {
 	"rx_alloc_errors[Q-%u]",
 };
 
-#define OCTEP_RX_Q_STATS_CNT (sizeof(octep_gstrings_rx_q_stats) / ETH_GSTRING_LEN)
+#define OCTEP_RX_Q_STATS_CNT ARRAY_SIZE(octep_gstrings_rx_q_stats)
 
 static void octep_get_drvinfo(struct net_device *netdev,
 			      struct ethtool_drvinfo *info)
@@ -80,32 +80,25 @@ static void octep_get_strings(struct net_device *netdev,
 {
 	struct octep_device *oct = netdev_priv(netdev);
 	u16 num_queues = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
-	char *strings = (char *)data;
+	const char *str;
 	int i, j;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < OCTEP_GLOBAL_STATS_CNT; i++) {
-			snprintf(strings, ETH_GSTRING_LEN,
-				 octep_gstrings_global_stats[i]);
-			strings += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < OCTEP_GLOBAL_STATS_CNT; i++)
+			ethtool_puts(&data, octep_gstrings_global_stats[i]);
 
-		for (i = 0; i < num_queues; i++) {
+		for (i = 0; i < num_queues; i++)
 			for (j = 0; j < OCTEP_TX_Q_STATS_CNT; j++) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 octep_gstrings_tx_q_stats[j], i);
-				strings += ETH_GSTRING_LEN;
+				str = octep_gstrings_tx_q_stats[j];
+				ethtool_sprintf(&data, str, i);
 			}
-		}
 
-		for (i = 0; i < num_queues; i++) {
+		for (i = 0; i < num_queues; i++)
 			for (j = 0; j < OCTEP_RX_Q_STATS_CNT; j++) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 octep_gstrings_rx_q_stats[j], i);
-				strings += ETH_GSTRING_LEN;
+				str = octep_gstrings_rx_q_stats[j];
+				ethtool_sprintf(&data, str, i);
 			}
-		}
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
index a1979b45e355..7b21439a315f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
@@ -25,7 +25,7 @@ static const char octep_vf_gstrings_global_stats[][ETH_GSTRING_LEN] = {
 	"rx_dropped_bytes_fifo_full",
 };
 
-#define OCTEP_VF_GLOBAL_STATS_CNT (sizeof(octep_vf_gstrings_global_stats) / ETH_GSTRING_LEN)
+#define OCTEP_VF_GLOBAL_STATS_CNT ARRAY_SIZE(octep_vf_gstrings_global_stats)
 
 static const char octep_vf_gstrings_tx_q_stats[][ETH_GSTRING_LEN] = {
 	"tx_packets_posted[Q-%u]",
@@ -34,7 +34,7 @@ static const char octep_vf_gstrings_tx_q_stats[][ETH_GSTRING_LEN] = {
 	"tx_busy[Q-%u]",
 };
 
-#define OCTEP_VF_TX_Q_STATS_CNT (sizeof(octep_vf_gstrings_tx_q_stats) / ETH_GSTRING_LEN)
+#define OCTEP_VF_TX_Q_STATS_CNT ARRAY_SIZE(octep_vf_gstrings_tx_q_stats)
 
 static const char octep_vf_gstrings_rx_q_stats[][ETH_GSTRING_LEN] = {
 	"rx_packets[Q-%u]",
@@ -42,7 +42,7 @@ static const char octep_vf_gstrings_rx_q_stats[][ETH_GSTRING_LEN] = {
 	"rx_alloc_errors[Q-%u]",
 };
 
-#define OCTEP_VF_RX_Q_STATS_CNT (sizeof(octep_vf_gstrings_rx_q_stats) / ETH_GSTRING_LEN)
+#define OCTEP_VF_RX_Q_STATS_CNT ARRAY_SIZE(octep_vf_gstrings_rx_q_stats)
 
 static void octep_vf_get_drvinfo(struct net_device *netdev,
 				 struct ethtool_drvinfo *info)
@@ -58,32 +58,25 @@ static void octep_vf_get_strings(struct net_device *netdev,
 {
 	struct octep_vf_device *oct = netdev_priv(netdev);
 	u16 num_queues = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
-	char *strings = (char *)data;
+	const char *str;
 	int i, j;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < OCTEP_VF_GLOBAL_STATS_CNT; i++) {
-			snprintf(strings, ETH_GSTRING_LEN,
-				 octep_vf_gstrings_global_stats[i]);
-			strings += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < OCTEP_VF_GLOBAL_STATS_CNT; i++)
+			ethtool_puts(&data, octep_vf_gstrings_global_stats[i]);
 
-		for (i = 0; i < num_queues; i++) {
+		for (i = 0; i < num_queues; i++)
 			for (j = 0; j < OCTEP_VF_TX_Q_STATS_CNT; j++) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 octep_vf_gstrings_tx_q_stats[j], i);
-				strings += ETH_GSTRING_LEN;
+				str = octep_vf_gstrings_tx_q_stats[j];
+				ethtool_sprintf(&data, str, i);
 			}
-		}
 
-		for (i = 0; i < num_queues; i++) {
+		for (i = 0; i < num_queues; i++)
 			for (j = 0; j < OCTEP_VF_RX_Q_STATS_CNT; j++) {
-				snprintf(strings, ETH_GSTRING_LEN,
-					 octep_vf_gstrings_rx_q_stats[j], i);
-				strings += ETH_GSTRING_LEN;
+				str = octep_vf_gstrings_rx_q_stats[j];
+				ethtool_sprintf(&data, str, i);
 			}
-		}
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 5197ce816581..2d53dc77ef1e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -85,26 +85,22 @@ static void otx2_get_qset_strings(struct otx2_nic *pfvf, u8 **data, int qset)
 	int start_qidx = qset * pfvf->hw.rx_queues;
 	int qidx, stats;
 
-	for (qidx = 0; qidx < pfvf->hw.rx_queues; qidx++) {
-		for (stats = 0; stats < otx2_n_queue_stats; stats++) {
-			sprintf(*data, "rxq%d: %s", qidx + start_qidx,
-				otx2_queue_stats[stats].name);
-			*data += ETH_GSTRING_LEN;
-		}
-	}
+	for (qidx = 0; qidx < pfvf->hw.rx_queues; qidx++)
+		for (stats = 0; stats < otx2_n_queue_stats; stats++)
+			ethtool_sprintf(data, "rxq%d: %s", qidx + start_qidx,
+					otx2_queue_stats[stats].name);
 
-	for (qidx = 0; qidx < otx2_get_total_tx_queues(pfvf); qidx++) {
-		for (stats = 0; stats < otx2_n_queue_stats; stats++) {
+	for (qidx = 0; qidx < otx2_get_total_tx_queues(pfvf); qidx++)
+		for (stats = 0; stats < otx2_n_queue_stats; stats++)
 			if (qidx >= pfvf->hw.non_qos_queues)
-				sprintf(*data, "txq_qos%d: %s",
-					qidx + start_qidx - pfvf->hw.non_qos_queues,
-					otx2_queue_stats[stats].name);
+				ethtool_sprintf(data, "txq_qos%d: %s",
+						qidx + start_qidx -
+							pfvf->hw.non_qos_queues,
+						otx2_queue_stats[stats].name);
 			else
-				sprintf(*data, "txq%d: %s", qidx + start_qidx,
-					otx2_queue_stats[stats].name);
-			*data += ETH_GSTRING_LEN;
-		}
-	}
+				ethtool_sprintf(data, "txq%d: %s",
+						qidx + start_qidx,
+						otx2_queue_stats[stats].name);
 }
 
 static void otx2_get_strings(struct net_device *netdev, u32 sset, u8 *data)
@@ -115,36 +111,25 @@ static void otx2_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 	if (sset != ETH_SS_STATS)
 		return;
 
-	for (stats = 0; stats < otx2_n_dev_stats; stats++) {
-		memcpy(data, otx2_dev_stats[stats].name, ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (stats = 0; stats < otx2_n_dev_stats; stats++)
+		ethtool_puts(&data, otx2_dev_stats[stats].name);
 
-	for (stats = 0; stats < otx2_n_drv_stats; stats++) {
-		memcpy(data, otx2_drv_stats[stats].name, ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (stats = 0; stats < otx2_n_drv_stats; stats++)
+		ethtool_puts(&data, otx2_drv_stats[stats].name);
 
 	otx2_get_qset_strings(pfvf, &data, 0);
 
 	if (!test_bit(CN10K_RPM, &pfvf->hw.cap_flag)) {
-		for (stats = 0; stats < CGX_RX_STATS_COUNT; stats++) {
-			sprintf(data, "cgx_rxstat%d: ", stats);
-			data += ETH_GSTRING_LEN;
-		}
+		for (stats = 0; stats < CGX_RX_STATS_COUNT; stats++)
+			ethtool_sprintf(&data, "cgx_rxstat%d: ", stats);
 
-		for (stats = 0; stats < CGX_TX_STATS_COUNT; stats++) {
-			sprintf(data, "cgx_txstat%d: ", stats);
-			data += ETH_GSTRING_LEN;
-		}
+		for (stats = 0; stats < CGX_TX_STATS_COUNT; stats++)
+			ethtool_sprintf(&data, "cgx_txstat%d: ", stats);
 	}
 
-	strcpy(data, "reset_count");
-	data += ETH_GSTRING_LEN;
-	sprintf(data, "Fec Corrected Errors: ");
-	data += ETH_GSTRING_LEN;
-	sprintf(data, "Fec Uncorrected Errors: ");
-	data += ETH_GSTRING_LEN;
+	ethtool_puts(&data, "reset_count");
+	ethtool_puts(&data, "Fec Corrected Errors: ");
+	ethtool_puts(&data, "Fec Uncorrected Errors: ");
 }
 
 static void otx2_get_qset_stats(struct otx2_nic *pfvf,
@@ -1375,20 +1360,15 @@ static void otx2vf_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 	if (sset != ETH_SS_STATS)
 		return;
 
-	for (stats = 0; stats < otx2_n_dev_stats; stats++) {
-		memcpy(data, otx2_dev_stats[stats].name, ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (stats = 0; stats < otx2_n_dev_stats; stats++)
+		ethtool_puts(&data, otx2_dev_stats[stats].name);
 
-	for (stats = 0; stats < otx2_n_drv_stats; stats++) {
-		memcpy(data, otx2_drv_stats[stats].name, ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (stats = 0; stats < otx2_n_drv_stats; stats++)
+		ethtool_puts(&data, otx2_drv_stats[stats].name);
 
 	otx2_get_qset_strings(vf, &data, 0);
 
-	strcpy(data, "reset_count");
-	data += ETH_GSTRING_LEN;
+	ethtool_puts(&data, "reset_count");
 }
 
 static void otx2vf_get_ethtool_stats(struct net_device *netdev,
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index fcfb34561882..25bf6ec44289 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -484,8 +484,7 @@ static void skge_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(skge_stats); i++)
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       skge_stats[i].name, ETH_GSTRING_LEN);
+			ethtool_puts(&data, skge_stats[i].name);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index a7a16eac1891..3914cd9210d4 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -3800,8 +3800,7 @@ static void sky2_get_strings(struct net_device *dev, u32 stringset, u8 * data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(sky2_stats); i++)
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       sky2_stats[i].name, ETH_GSTRING_LEN);
+			ethtool_puts(&data, sky2_stats[i].name);
 		break;
 	}
 }
-- 
2.47.0


