Return-Path: <bpf+bounces-15970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656207FA98C
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316AC1C20C37
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910063E476;
	Mon, 27 Nov 2023 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToxMr7Rk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F76D63
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:31 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c19a0a2fbfso4775105a12.2
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111810; x=1701716610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OOxlshDL1+qiGyZH7/4x6ZmA5ZmMNeW0Lx+zNtrVXo=;
        b=ToxMr7Rkip/O6fy5cMpQ1HJ+ptmncngkKlKOZOrgHLh3hBFpjMQrEAcKjLE5Ul0M7A
         nkDBmxJ2i7Jt7wyac3PNdXYR4Ru7KZ8GUFUOAFBCWZsUKvaWSuELM9xB6oS0z6+Tg0y7
         YsR6ZSj4s0znrZVn4VW56hDMOM8iqNfivWt9javlB5AbwYGrXyvJ6OaodxF4Vg0MLlPZ
         JD3FeBRx+v/ivkbxJAKVXo+tugoFDe7atmZ94Jr9JOHTtIC2HKBRi8jP6IVo+HKsKzdy
         ll0I7U3++irrKoXvlxuqEjueOnT/E13B8TkG/241DJE8IxNeQBOqnDbGqKwdB7xWBwJS
         n8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111810; x=1701716610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OOxlshDL1+qiGyZH7/4x6ZmA5ZmMNeW0Lx+zNtrVXo=;
        b=stUicTZ/MGuYUcC0dCkphdvmr84lLIOYUkVFA7L4c2zL6T1+LPAT02dI4rZimx5L5X
         CeAZblDpicZ82phCHTWwPSzk3ngsrtitmFhmKTaGbiPHzDIDQ6rEWeQUD1PNgzeip5WP
         BTtC69QUIpBmSV7MsWk0ntmuvb4SJMPOPUt/+lYtSJj1hEuI1bFBxUyN6+imaWbj5BNo
         PFDiJHEzrZYqW/AHuLgnD4iheUT6X9H21NlyONF1RIGrEbivqap9NnPnms7vOKbse1I+
         pg/4vCykyS37f0ywDkNjlfpc3DwG0llQw41GNqDTS1/NGe3aKXv3VKQvTIi7Zq1LQLf3
         X2Aw==
X-Gm-Message-State: AOJu0Yw3zVYCTSIfNVVK/XOKnKaAjztYP2koYDWKbizHGGSpk46JFb55
	Y+LdTcCWjjJi0SXBPwRiFNxjqZy+HbBcqd6twWLJ6nrpdxNL2vAhn9T1fiS0phfU9qPW0jEQK+V
	FI+nulKW69Llp2DolwG17ntx/3VgLW1DCkexYHdRXq0oI9/Skmg==
X-Google-Smtp-Source: AGHT+IEOIzMiS+XOzQc1u4IE3dLr+juJzGGWDgeT/yHSLeJn0FuerExxj/8qzJZKZf0TgtvvLe4Alm0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:211f:0:b0:5bd:4149:a123 with SMTP id
 h31-20020a63211f000000b005bd4149a123mr2141422pgh.7.1701111810604; Mon, 27 Nov
 2023 11:03:30 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:11 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-6-sdf@google.com>
Subject: [PATCH bpf-next v6 05/13] net: stmmac: Add Tx HWTS support to XDP ZC
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
0x55bbbf08b6d0: rx_desc[2]->addr=8c100 addr=8c100 comp_addr=8c100 EoP
No rx_hash err=-95
rx_timestamp:  1677762688429141540 (sec:1677762688.4291)
HW RX-time:   1677762688429141540 (sec:1677762688.4291) delta to User RX-time sec:0.0003 (250.665 usec)
XDP RX-time:   1677762688429375597 (sec:1677762688.4294) delta to User RX-time sec:0.0000 (16.608 usec)
0x55bbbf08b6d0: ping-pong with csum=561c (want f488) csum_start=34 csum_offset=6
0x55bbbf08b6d0: complete tx idx=2 addr=2008
tx_timestamp:  1677762688431127273 (sec:1677762688.4311)
HW TX-complete-time:   1677762688431127273 (sec:1677762688.4311) delta to User TX-complete-time sec:0.0083 (8331.655 usec)
XDP RX-time:   1677762688429375597 (sec:1677762688.4294) delta to User TX-complete-time sec:0.0101 (10083.331 usec)
HW RX-time:   1677762688429141540 (sec:1677762688.4291) delta to HW TX-complete-time sec:0.0020 (1985.733 usec)
0x55bbbf08b6d0: complete rx idx=130 addr=8c100

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 12 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 64 ++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

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
index 8964fc8a955f..c2ac88aaffed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2430,6 +2430,46 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
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
@@ -2449,6 +2489,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 	budget = min(budget, stmmac_tx_avail(priv, queue));
 
 	while (budget-- > 0) {
+		struct stmmac_metadata_request meta_req;
+		struct xsk_tx_metadata *meta = NULL;
 		dma_addr_t dma_addr;
 		bool set_ic;
 
@@ -2472,6 +2514,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 			tx_desc = tx_q->dma_tx + entry;
 
 		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
+		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
 		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
 
 		tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_XSK_TX;
@@ -2499,6 +2542,11 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		else
 			set_ic = false;
 
+		meta_req.priv = priv;
+		meta_req.tx_desc = tx_desc;
+		meta_req.set_ic = &set_ic;
+		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops,
+					&meta_req);
 		if (set_ic) {
 			tx_q->tx_count_frames = 0;
 			stmmac_set_tx_ic(priv, tx_desc);
@@ -2511,6 +2559,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 		stmmac_enable_dma_transmission(priv, priv->ioaddr);
 
+		xsk_tx_metadata_to_compl(meta,
+					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
+
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
@@ -2620,8 +2671,18 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
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
@@ -7464,6 +7525,7 @@ int stmmac_dvr_probe(struct device *device,
 	ndev->netdev_ops = &stmmac_netdev_ops;
 
 	ndev->xdp_metadata_ops = &stmmac_xdp_metadata_ops;
+	ndev->xsk_tx_metadata_ops = &stmmac_xsk_tx_metadata_ops;
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_RXCSUM;
-- 
2.43.0.rc1.413.gea7ed67945-goog


