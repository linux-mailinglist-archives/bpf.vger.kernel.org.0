Return-Path: <bpf+bounces-12716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0519B7D00EB
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9CD282263
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147D3985E;
	Thu, 19 Oct 2023 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z7qV/iIM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5BC38DD3
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:49:57 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1BC131
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:56 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9e994fd94so56589765ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737796; x=1698342596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pXJluc9zGIJ1Q7VAMwt5riHK533tCmdCtfRALFlLEM=;
        b=z7qV/iIMdKfocFKJLq4tczhnO9x5WZvydIiEngAP8AThEqySqK7rPTZfB1/8+x30KZ
         7/V4ZGSIRxEHfTRjzTZcEZXsoUCxmJCfk7424RnEr4oYNZH5PEMzKKiE/Rntd7wosdh3
         5p8DlLUXeYszz9m3ls1uVt/k35kKF72oWuRWO0wjmoOEtCDwCpDM21j9BJ4SHHsTBf4Y
         YD92Fo1REGcu1W5AWjnviwS4KUSGoF9WrqYUTnqKZOCtV1FvedeJ068HkqeADBgKnPoG
         85JET5WgBAbeWcScIGFxErgRaM64yv4DckM0e+RRZqsv5BKYNBoih7/uW6nFS0BOrN7P
         PH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737796; x=1698342596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pXJluc9zGIJ1Q7VAMwt5riHK533tCmdCtfRALFlLEM=;
        b=Gj3ZVenVzJbQTIadlj56T+G//D6T1D3u5F5bJv7Q+XC1SVEpH+YsPavM/lxyyYzGBo
         BGzdZ2UohdXHwsHsOK+R9qMFwA+/T+0WAfUsaNDA3mtZv2mXRpHnMuZ+7WxRvFMwrA5V
         ktDc19VF3kw7liPRugxYwgH6Lvp/McE4xuLiEQnCLXaERfjj5NP1T1t090gQ6pBhdly2
         PXfxyrtS3BX2UbFW5nqA1sFNT9kpN/jReylLj6OhS15eq5l9/t1Ss/ertIFjtepOGw/p
         L8Utu/rVLgYU7/gRadGvLaTsIaSiWjaUZejZwaQ3AlUwl9PYQM9944hz4z1gYgMEwD73
         Xymg==
X-Gm-Message-State: AOJu0Yy6Pnx3LemVBuAhJbG/mTTEBshzlQerYURzjMUVa1kCdMTGTn97
	3KyYIgk/CryOoRJ7CIWqDErzK22nplQCFHv7DFqAZ5jacYB+9mb0nRk6HCug7U8UvOtiBBG32kL
	YRF7/0h+R4BtJi23+Y5LmzE36BFSaWm+dlHCRx9v5ZAMtocCBlw==
X-Google-Smtp-Source: AGHT+IFg7H4CBk96QPFsIoAJryAQp6KVWi6UJH5umbpLRIJMOpDq80FSuSwuTK8aFjPaLcrMb4imo8o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:6803:b0:1ca:b952:f5fa with SMTP id
 h3-20020a170902680300b001cab952f5famr36148plk.5.1697737794899; Thu, 19 Oct
 2023 10:49:54 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:38 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-6-sdf@google.com>
Subject: [PATCH bpf-next v4 05/11] net: stmmac: Add Tx HWTS support to XDP ZC
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
index bb1dbf4c9f6c..49fe2f20797e 100644
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
@@ -7414,6 +7474,7 @@ int stmmac_dvr_probe(struct device *device,
 	ndev->netdev_ops = &stmmac_netdev_ops;
 
 	ndev->xdp_metadata_ops = &stmmac_xdp_metadata_ops;
+	ndev->xsk_tx_metadata_ops = &stmmac_xsk_tx_metadata_ops;
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_RXCSUM;
-- 
2.42.0.655.g421f12c284-goog


