Return-Path: <bpf+bounces-11308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22C7B723E
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CDD74281890
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F633CD1D;
	Tue,  3 Oct 2023 20:05:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280C3CD1F
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:37 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB53AB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:35 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c746bccbdcso12581865ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363535; x=1696968335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkYrfMEROl+nnKl4VmaP3DUpmKO4TmiY5HQ7B/WMMw4=;
        b=vMEdzyNDznXvLlD8jRLloaYH//kXE997i/iyJQ0ie6ocOFMJUyNRJ5kenL5MO172w7
         VHbQ8i38Rf5GsyMw0EyMmO4jaxxKWu0weOcvHPvPcahZzI1VGGwpyZPjoAU9vfTphTwY
         Ov+E9WK+f8nQMnH+DbEo/MDKuM9pyFyc7CWwPrVDUUQ5XmatUFHJ54AObdmtCkQXpbxM
         kNuXpJlKcx520jaC0MyTg/K0NSbNhWM9ryNTjr9IXzljtSLROtSdNp7sI+NBp/6SMBu+
         m8wPDw7T6TnWyvqkqbM0U1VeNgUhw6WSjK4SSp31w9zz5rXvrJM6bY/ZR5YTWe65Q/Zz
         YwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363535; x=1696968335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkYrfMEROl+nnKl4VmaP3DUpmKO4TmiY5HQ7B/WMMw4=;
        b=PqtdwHbq7AdhhfBD10ESylN6tE5IvBN/TjahyxNCaL2Q20hz9VLJ4yRNHl/jCb3Zuh
         gHdN6PdvJHgqHqJy2i8vx294glSvYk/HjibCJ59zE04WP7TzQ4UwjmT1kRAM2S1Feigo
         COJe0ms9F8nY8sqFYLv7U38MVcuyLoaQD1zORPmxWaYjfLRl833jiHYvtfkgK9Wz3fES
         a7FMsq3hS5bWC8Zysvrjl3mr5dvcnp3pSkbfbq0Vy3NZe6UKarJ7Mo00I7+1qTbTmCwc
         PQga3KF95F3l1YGcgwcG5Ew1hauNg+PSuxKaoo7BJVkykiKmsj2tfXhdQUqtvuCqKKlJ
         uTTg==
X-Gm-Message-State: AOJu0Ywye/a8jpSZJuSAEa7615YcrtO/4mah1NKO1HTYnixnRvt1h2L/
	Hr/Ee9eGHOdkzDOiGjdYaNONoCjGhKLEZor1XiTDNpzlLdQWg7H7hqUSk6hs3FdjKW5JvZFMG9f
	o54s7p666NIVLwKomwzOQ2urQmFyNj1G+0qb7pO3XUuAp3GmewA==
X-Google-Smtp-Source: AGHT+IE3V09XJvSx/etSdyrMzjtPZenYBzBBURkff+I6OS9q5ablh3krJeZx98BpAhypkLreVbj4lYc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d2cb:b0:1c7:55ff:858d with SMTP id
 n11-20020a170902d2cb00b001c755ff858dmr8340plc.8.1696363534449; Tue, 03 Oct
 2023 13:05:34 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:17 -0700
In-Reply-To: <20231003200522.1914523-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-6-sdf@google.com>
Subject: [PATCH bpf-next v3 05/10] net: stmmac: Add Tx HWTS support to XDP ZC
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Song Yoong Siang <yoong.siang.song@intel.com>

This patch enables transmit hardware timestamp support to XDP zero copy
via XDP Tx metadata framework.

This patchset is tested with tools/testing/selftests/bpf/xdp_hw_metadata
on Intel Tiger Lake platform. Below are the test steps and results.

Command on DUT:
  sudo ./xdp_hw_metadata <interface name>
  sudo hwstamp_ctl -i <interface name> -t 1 -r 1

Command on Link Partner:
  echo -n xdp | nc -u -q1 <destination IPv4 addr> 9091

Result:
  xsk_ring_cons__peek: 1
  0x562e3313b6d0: rx_desc[3]->addr=8e100 addr=8e100 comp_addr=8e100
  No rx_hash err=-95
  rx_timestamp:  1677763849292380229 (sec:1677763849.2924)
  XDP RX-time:   1677763849292641940 (sec:1677763849.2926)
                 delta sec:0.0003 (261.711 usec)
  AF_XDP time:   1677763849292666175 (sec:1677763849.2927)
                 delta sec:0.0000 (24.235 usec)
  0x562e3313b6d0: ping-pong with csum=561c (want 08af)
                  csum_start=34 csum_offset=6
  0x562e3313b6d0: complete tx idx=3 addr=3008
  0x562e3313b6d0: tx_timestamp:  1677763849295700005 (sec:1677763849.2957)
  0x562e3313b6d0: complete rx idx=131 addr=8e100

Additionally, to double confirm the rx_timestamp and tx_timestamp are taken
from PTP Hardware Clock (PHC), we set the value of PHC to a specific value
using tools/testing/selftests/ptp/testptp. Below are the test steps and
results.

Command to set PHC to a specific value:
  sudo ./testptp -d /dev/ptp2 -T 123000000

Result:
  xsk_ring_cons__peek: 1
  0x562e3313b6d0: rx_desc[7]->addr=9e100 addr=9e100 comp_addr=9e100
  No rx_hash err=-95
  rx_timestamp:  123000002731730589 (sec:123000002.7317)
  XDP RX-time:   1677763869396644361 (sec:1677763869.3966)
                 delta sec:1554763866.6649 (1554763866664913.750 usec)
  AF_XDP time:   1677763869396671376 (sec:1677763869.3967)
                 delta sec:0.0000 (27.015 usec)
  0x562e3313b6d0: ping-pong with csum=561c (want d1bf)
                  csum_start=34 csum_offset=6
  0x562e3313b6d0: complete tx idx=7 addr=7008
  0x562e3313b6d0: tx_timestamp:  123000002735048790 (sec:123000002.7350)
  0x562e3313b6d0: complete rx idx=135 addr=9e100

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 12 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 63 ++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index cd7a9768de5f..686c94c2e8a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -51,6 +51,7 @@ struct stmmac_tx_info {
 	bool last_segment;
 	bool is_jumbo;
 	enum stmmac_txbuf_type buf_type;
+	struct xsk_tx_metadata_compl xsk_meta;
 };
 
 #define STMMAC_TBS_AVAIL	BIT(0)
@@ -100,6 +101,17 @@ struct stmmac_xdp_buff {
 	struct dma_desc *ndesc;
 };
 
+struct stmmac_metadata_request {
+	struct stmmac_priv *priv;
+	struct dma_desc *tx_desc;
+	bool *set_ic;
+};
+
+struct stmmac_xsk_tx_complete {
+	struct stmmac_priv *priv;
+	struct dma_desc *desc;
+};
+
 struct stmmac_rx_queue {
 	u32 rx_count_frames;
 	u32 queue_index;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 81b6f3ecdf92..697712dd4024 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2422,6 +2422,46 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	}
 }
 
+static void stmmac_xsk_request_timestamp(void *_priv)
+{
+	struct stmmac_metadata_request *meta_req = _priv;
+
+	stmmac_enable_tx_timestamp(meta_req->priv, meta_req->tx_desc);
+	*meta_req->set_ic = true;
+}
+
+static u64 stmmac_xsk_fill_timestamp(void *_priv)
+{
+	struct stmmac_xsk_tx_complete *tx_compl = _priv;
+	struct stmmac_priv *priv = tx_compl->priv;
+	struct dma_desc *desc = tx_compl->desc;
+	bool found = false;
+	u64 ns = 0;
+
+	if (!priv->hwts_tx_en)
+		return 0;
+
+	/* check tx tstamp status */
+	if (stmmac_get_tx_timestamp_status(priv, desc)) {
+		stmmac_get_timestamp(priv, desc, priv->adv_ts, &ns);
+		found = true;
+	} else if (!stmmac_get_mac_tx_timestamp(priv, priv->hw, &ns)) {
+		found = true;
+	}
+
+	if (found) {
+		ns -= priv->plat->cdc_error_adj;
+		return ns_to_ktime(ns);
+	}
+
+	return 0;
+}
+
+static const struct xsk_tx_metadata_ops stmmac_xsk_tx_metadata_ops = {
+	.tmo_request_timestamp		= stmmac_xsk_request_timestamp,
+	.tmo_fill_timestamp		= stmmac_xsk_fill_timestamp,
+};
+
 static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
@@ -2441,6 +2481,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 	budget = min(budget, stmmac_tx_avail(priv, queue));
 
 	while (budget-- > 0) {
+		struct stmmac_metadata_request meta_req;
+		struct xsk_tx_metadata *meta = NULL;
 		dma_addr_t dma_addr;
 		bool set_ic;
 
@@ -2464,6 +2506,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 			tx_desc = tx_q->dma_tx + entry;
 
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
+		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
 		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
 
 		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XSK_TX;
@@ -2491,6 +2534,11 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		else
 			set_ic = false;
 
+		meta_req.priv = priv;
+		meta_req.tx_desc = tx_desc;
+		meta_req.set_ic = &set_ic;
+		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops, &meta_req);
+
 		if (set_ic) {
 			tx_q->tx_count_frames = 0;
 			stmmac_set_tx_ic(priv, tx_desc);
@@ -2503,6 +2551,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 		stmmac_enable_dma_transmission(priv, priv->ioaddr);
 
+		xsk_tx_metadata_to_compl(meta, &tx_q->tx_skbuff_dma[entry].xsk_meta);
+
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
@@ -2608,8 +2658,18 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 			} else {
 				tx_packets++;
 			}
-			if (skb)
+			if (skb) {
 				stmmac_get_tx_hwtstamp(priv, p, skb);
+			} else {
+				struct stmmac_xsk_tx_complete tx_compl = {
+					.priv = priv,
+					.desc = p,
+				};
+
+				xsk_tx_metadata_complete(&tx_q->tx_skbuff_dma[entry].xsk_meta,
+							 &stmmac_xsk_tx_metadata_ops,
+							 &tx_compl);
+			}
 		}
 
 		if (likely(tx_q->tx_skbuff_dma[entry].buf &&
@@ -7444,6 +7504,7 @@ int stmmac_dvr_probe(struct device *device,
 	ndev->netdev_ops = &stmmac_netdev_ops;
 
 	ndev->xdp_metadata_ops = &stmmac_xdp_metadata_ops;
+	ndev->xsk_tx_metadata_ops = &stmmac_xsk_tx_metadata_ops;
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_RXCSUM;
-- 
2.42.0.582.g8ccd20d70d-goog


