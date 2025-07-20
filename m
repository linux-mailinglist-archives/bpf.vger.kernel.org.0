Return-Path: <bpf+bounces-63830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E599B0B489
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81547AC749
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64D1EB5CE;
	Sun, 20 Jul 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSyBGzye"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804513D6D;
	Sun, 20 Jul 2025 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002715; cv=none; b=mNdZbWWALOsauHGP5zu3wnfSrO61JmA+WSlGVPVLgYwCU/w8DFsK/Z3WR8TEx3PBTcgnlp7a/d9FeU+N0PvUszZZ8ORVBTAeKUGE8vSJb+LWyWn4EovyGWVWxcu/D09cyrG1Gi64PVv34UWXZETvmfQ46xDmpL8frA2w39OxNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002715; c=relaxed/simple;
	bh=vvKrXvD9m8CHq33RulmBOZfcELAk0cPPHjC5hRe0Y1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHRAXyoYMz76Wj2YUxKattgg6GYlI5O/m26H9qjXmWigGZhCYGKcPgxpwwAPtkvk5/lan55sEDt+vf/k1w6pXQdLvBageaILZ78iUHsoc1DMylrZe51NEYVdWHYshuqVch2bSiTHrIy6iUh2hlAI5qy37hMFU7vWCuVnIuoDyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSyBGzye; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748feca4a61so1902812b3a.3;
        Sun, 20 Jul 2025 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753002713; x=1753607513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSUZaotcK6F1L2ahR58XYB1HWdRYHUo7Ql3E/8Mqj5U=;
        b=gSyBGzyeUodusfkI/Azdk9b8isg8Kri+Rb9o8M3uSUvo6KTz5zRnu5OcoJC6eEYK1L
         yMeHCB4pj5y/S5gmgMpsMMm5DVAj2J8fZBIGlDe20e1weuVLdidz81qf3lmu0Nsmbk7M
         +tanIVmoj/RbRZNCjuFeBw9G8mS0QZ7KrzCR0mMH2fpFz3HC1X73gE0Zc+HQgaX4QatG
         C8cYN2YFbat2VQj5GF7wLZ1WU4uavfZj9J5FICalMBCmuItpoXpYbB2pEKHkje5eh9oI
         P1tUhrJCDBT4wcw2xS8MrppGjaRze0aRLU+SkAMbY0DZSLc4M3X66AqbstS6cyb63Fxz
         TVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002713; x=1753607513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSUZaotcK6F1L2ahR58XYB1HWdRYHUo7Ql3E/8Mqj5U=;
        b=qUPgNEqAJponR8LrkvjudTkY0f3fcv05i1UtPsLvynI7u6XA2qU5bf+QR3o6K5/9ot
         Px2xaWRvIw7jIAOfgXIHOr/PvrBTbZgaryIB9fbyNt6MTCSK/BF/Ks7hqNXuZZ9Gfi/s
         Vb28OB3n0uTvgIKCC+EJl98EBzo85ZNB1EhzMxqXeWmNj9/CjaqdeRYXWYNt5xGA4zqX
         ZkSBt6II6FUEE7vp26/EHYynGaVoQuBfL1tnZywEgrR/ciO7YFY4UE8BHGuuGe3epdxJ
         InIVPi2n6jwl0L9s4kZNv/Z6WXiFt4g35ZlyU8zJRZF8um9FQvKA7D+SjEa6wYCFuUvF
         yj/w==
X-Forwarded-Encrypted: i=1; AJvYcCUk0wcePZLj6uUqmHiHrNYbh6b/cojTjCKxVmoh9O9DNTPmjurEJxJs85Co3OQ3J2pGCiQbNaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQ0KgXkWquxEFvge63emJotynSf7l3Tbr/Dt4IYmHXmgd/FpE
	xCTpt2NmnU63xy34Bs+1prdGAd2AF3XuzX/DnDWQ4+fLMYwiDWZCa7dP
X-Gm-Gg: ASbGnctLB2SvyJ8Rv+HrUakTDTHk8rIt6BHiSqkm9pWj6fJp/yJ+E3wYk0IfVnzlxld
	j+3FRu41t1MwbHfpQEn7C5yubA4SVcNBK7OlJEHczqbUHCC63GxdNuR5KOwxTEN9K0UGdHrHHdu
	3S/MMMOcYyua+8DNhNSQMA8i1IpN29XiZfGBhy2TDWDVuL4OorKopZDYCNFU82JIF54V0DSsOWd
	rhS9VqAbIJEq4+fr3EhAL1NHC73Xsjn8p7AI7ghPJsI20T62dFU9axNsdk1fOffSroQrTVFHIfc
	EY0RrQkP0jZV/nWi+tRsJMfeuls2fbek2AXKJF7WSzqmRn1FwgHOadWwH4Oa9ofu1wO448CejGk
	j6GvINBBouF9OKsGQrYlE8EYvo2yJhQtgz2wcmALGbgNxcjY7cqqeurjd5qOFhcACp4TRWg==
X-Google-Smtp-Source: AGHT+IEra553OLR9Wt+3ggRMepnkqBz8W2d+vtlnTjf8GjUJtXbtNVC9HcE+mFBzjIfueWvlQKSB9g==
X-Received: by 2002:a05:6a00:10cb:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-757242790admr20643963b3a.16.1753002712650;
        Sun, 20 Jul 2025 02:11:52 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm3902585b3a.105.2025.07.20.02.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 02:11:52 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 4/5] ixgbe: xsk: support batched xsk Tx interfaces to increase performance
Date: Sun, 20 Jul 2025 17:11:22 +0800
Message-Id: <20250720091123.474-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250720091123.474-1-kerneljasonxing@gmail.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like what i40e driver initially did in commit 3106c580fb7cf
("i40e: Use batched xsk Tx interfaces to increase performance"), use
the batched xsk feature to transmit packets.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 106 +++++++++++++------
 1 file changed, 72 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index f3d3f5c1cdc7..9fe2c4bf8bc5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -2,12 +2,15 @@
 /* Copyright(c) 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
+#include <linux/unroll.h>
 #include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
 
 #include "ixgbe.h"
 #include "ixgbe_txrx_common.h"
 
+#define PKTS_PER_BATCH 4
+
 struct xsk_buff_pool *ixgbe_xsk_pool(struct ixgbe_adapter *adapter,
 				     struct ixgbe_ring *ring)
 {
@@ -388,58 +391,93 @@ void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring)
 	}
 }
 
-static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
+static void ixgbe_set_rs_bit(struct ixgbe_ring *xdp_ring)
+{
+	u16 ntu = xdp_ring->next_to_use ? xdp_ring->next_to_use - 1 : xdp_ring->count - 1;
+	union ixgbe_adv_tx_desc *tx_desc;
+
+	tx_desc = IXGBE_TX_DESC(xdp_ring, ntu);
+	tx_desc->read.cmd_type_len |= cpu_to_le32(IXGBE_TXD_CMD_RS);
+}
+
+static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc,
+			   int i)
+
 {
 	struct xsk_buff_pool *pool = xdp_ring->xsk_pool;
 	union ixgbe_adv_tx_desc *tx_desc = NULL;
 	struct ixgbe_tx_buffer *tx_bi;
-	struct xdp_desc desc;
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	if (!budget)
-		return true;
+	dma = xsk_buff_raw_get_dma(pool, desc[i].addr);
+	xsk_buff_raw_dma_sync_for_device(pool, dma, desc[i].len);
 
-	while (likely(budget)) {
-		if (!netif_carrier_ok(xdp_ring->netdev))
-			break;
+	tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
+	tx_bi->bytecount = desc[i].len;
+	tx_bi->xdpf = NULL;
+	tx_bi->gso_segs = 1;
 
-		if (!xsk_tx_peek_desc(pool, &desc))
-			break;
+	tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
+	tx_desc->read.buffer_addr = cpu_to_le64(dma);
 
-		dma = xsk_buff_raw_get_dma(pool, desc.addr);
-		xsk_buff_raw_dma_sync_for_device(pool, dma, desc.len);
+	cmd_type = IXGBE_ADVTXD_DTYP_DATA |
+		   IXGBE_ADVTXD_DCMD_DEXT |
+		   IXGBE_ADVTXD_DCMD_IFCS;
+	cmd_type |= desc[i].len | IXGBE_TXD_CMD_EOP;
+	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
+	tx_desc->read.olinfo_status =
+		cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
 
-		tx_bi = &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
-		tx_bi->bytecount = desc.len;
-		tx_bi->xdpf = NULL;
-		tx_bi->gso_segs = 1;
+	xdp_ring->next_to_use++;
+}
 
-		tx_desc = IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
-		tx_desc->read.buffer_addr = cpu_to_le64(dma);
+static void ixgbe_xmit_pkt_batch(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc)
+{
+	u32 i;
 
-		/* put descriptor type bits */
-		cmd_type = IXGBE_ADVTXD_DTYP_DATA |
-			   IXGBE_ADVTXD_DCMD_DEXT |
-			   IXGBE_ADVTXD_DCMD_IFCS;
-		cmd_type |= desc.len | IXGBE_TXD_CMD;
-		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
-		tx_desc->read.olinfo_status =
-			cpu_to_le32(desc.len << IXGBE_ADVTXD_PAYLEN_SHIFT);
+	unrolled_count(PKTS_PER_BATCH)
+	for (i = 0; i < PKTS_PER_BATCH; i++)
+		ixgbe_xmit_pkt(xdp_ring, desc, i);
+}
 
-		xdp_ring->next_to_use++;
-		if (xdp_ring->next_to_use == xdp_ring->count)
-			xdp_ring->next_to_use = 0;
+static void ixgbe_fill_tx_hw_ring(struct ixgbe_ring *xdp_ring,
+				  struct xdp_desc *descs, u32 nb_pkts)
+{
+	u32 batched, leftover, i;
+
+	batched = nb_pkts & ~(PKTS_PER_BATCH - 1);
+	leftover = nb_pkts & (PKTS_PER_BATCH - 1);
+	for (i = 0; i < batched; i += PKTS_PER_BATCH)
+		ixgbe_xmit_pkt_batch(xdp_ring, &descs[i]);
+	for (i = batched; i < batched + leftover; i++)
+		ixgbe_xmit_pkt(xdp_ring, &descs[i], 0);
+}
 
-		budget--;
-	}
+static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
+{
+	struct xdp_desc *descs = xdp_ring->xsk_pool->tx_descs;
+	u32 nb_pkts, nb_processed = 0;
 
-	if (tx_desc) {
-		ixgbe_xdp_ring_update_tail(xdp_ring);
-		xsk_tx_release(pool);
+	if (!netif_carrier_ok(xdp_ring->netdev))
+		return true;
+
+	nb_pkts = xsk_tx_peek_release_desc_batch(xdp_ring->xsk_pool, budget);
+	if (!nb_pkts)
+		return true;
+
+	if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
+		nb_processed = xdp_ring->count - xdp_ring->next_to_use;
+		ixgbe_fill_tx_hw_ring(xdp_ring, descs, nb_processed);
+		xdp_ring->next_to_use = 0;
 	}
 
-	return !!budget;
+	ixgbe_fill_tx_hw_ring(xdp_ring, &descs[nb_processed], nb_pkts - nb_processed);
+
+	ixgbe_set_rs_bit(xdp_ring);
+	ixgbe_xdp_ring_update_tail(xdp_ring);
+
+	return nb_pkts < budget;
 }
 
 static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
-- 
2.41.3


