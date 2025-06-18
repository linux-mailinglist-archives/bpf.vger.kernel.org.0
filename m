Return-Path: <bpf+bounces-60916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D3ADEB32
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243594A062D
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F72E8DEB;
	Wed, 18 Jun 2025 12:00:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FB2E54AD
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248044; cv=none; b=DDkqZ80BWfFMNkSfccf3CLTp36VYFIpSskjusd3lXtD18gaAhMq+ZgFWYoI8aM7ev9xbQyS0+zgeDnXLUvOIv8m9uZsLPQCtJBbaIcukouO7N4zhMeVlI9NjA5Y7C25PE2uzqanQ9eEvWmFfHrhCCStMubhWUddmfg0T4gq3J0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248044; c=relaxed/simple;
	bh=QeKkEP7CAP29y+fcW+jLOVozLyq2xKCYF8wclT9C4qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlFkAksWHnMQdMZgva0sj970Rx++p3eBzIaEtACiwz7nM2YgDYoxCans6XI3w/wTNaaagOAny2L0bGiSFlGF+FD2uNTzS+zzBwRWZC6awXyt4C0gTUAtL1H4bzPnqtUmXWyW3bmlyyPBTKlSsZo1/wdo1PmFOf6E+Hpi5DM5oXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id BE8D066FCFE
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8BA2942B5D5
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 07D1B42B522;
	Wed, 18 Jun 2025 12:00:30 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9fc1adae;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jun 2025 14:00:10 +0200
Subject: [PATCH net-next v4 10/11] net: fec: fec_enet_rx_queue(): move_call
 to _vlan_hwaccel_put_tag()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-fec-cleanups-v4-10-c16f9a1af124@pengutronix.de>
References: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
In-Reply-To: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, bpf@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=QeKkEP7CAP29y+fcW+jLOVozLyq2xKCYF8wclT9C4qw=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpYA9XBfvj93nnhx/7Q5jcyqmRl1R4QTxbXN
 k2GT+kyv4KJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqWAAKCRAMdGXf+ZCR
 nGMTCACDpTpLM++3UmmvDZiKmd3oXJNdtyTshheMzc2enORyzkVNlvr8SoKZAyHHUYWVWuJ5NTE
 MIG0a55434Pb6NRn+jxfRbzNhSQnMNP+5PQ//hd6Vb4Q7tN5Vo/Ym3S65mKTq5AN6tLIxhlpj1M
 oEjm1unv3cpKeQiE6i8oFPFFUFT5bpA7pa8yojSCgarRpQkKY0c/ODCBMyzO/CLjSx03zx3HtXt
 WY0l+29lAwjgmtTamErh49JCah0QUc0kJCX3lOF0GXMzywSrZT5B4CBuYCdmHytVy+myP5VnaiF
 aw/TchvbBR0ljjlDPU+MW0D5GiRhKN66IFiTTXx6yrHcKMo1
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Move __vlan_hwaccel_put_tag() into the if statement that sets
vlan_packet_rcvd = true. This change eliminates the unnecessary
vlan_packet_rcvd variable, simplifying the code and improving clarity.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 84dd08473280..6797aa1ed639 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1722,8 +1722,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	ushort	pkt_len;
 	int	pkt_received = 0;
 	struct	bufdesc_ex *ebdp = NULL;
-	bool	vlan_packet_rcvd = false;
-	u16	vlan_tag;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
@@ -1854,18 +1852,18 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			ebdp = (struct bufdesc_ex *)bdp;
 
 		/* If this is a VLAN packet remove the VLAN Tag */
-		vlan_packet_rcvd = false;
 		if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
 		    fep->bufdesc_ex &&
 		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
 			/* Push and remove the vlan tag */
 			struct vlan_ethhdr *vlan_header = skb_vlan_eth_hdr(skb);
-			vlan_tag = ntohs(vlan_header->h_vlan_TCI);
-
-			vlan_packet_rcvd = true;
+			u16 vlan_tag = ntohs(vlan_header->h_vlan_TCI);
 
 			memmove(skb->data + VLAN_HLEN, skb->data, ETH_ALEN * 2);
 			skb_pull(skb, VLAN_HLEN);
+			__vlan_hwaccel_put_tag(skb,
+					       htons(ETH_P_8021Q),
+					       vlan_tag);
 		}
 
 		skb->protocol = eth_type_trans(skb, ndev);
@@ -1885,12 +1883,6 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			}
 		}
 
-		/* Handle received VLAN packets */
-		if (vlan_packet_rcvd)
-			__vlan_hwaccel_put_tag(skb,
-					       htons(ETH_P_8021Q),
-					       vlan_tag);
-
 		skb_record_rx_queue(skb, queue_id);
 		napi_gro_receive(&fep->napi, skb);
 

-- 
2.47.2



