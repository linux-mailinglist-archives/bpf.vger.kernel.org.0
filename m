Return-Path: <bpf+bounces-54304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A95FA67308
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8883B32F1
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440320C01E;
	Tue, 18 Mar 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kakTF8xz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281920AF75;
	Tue, 18 Mar 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298385; cv=none; b=MuJ4rW+e5+HfvA9yDELw8P1Ly6T8+F8D2051IAG7GYjAA5ftSNB9VnEH7OHQscCeUvUGymWrgBNE7sIf3fd24Kghm2TheDhb+391qClVQpjCstakV/PMX80t2KiVheVPbMncA7v7azli0EbhkebqnFQHbRoK8C8iImkF0youQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298385; c=relaxed/simple;
	bh=dRSfnENYRHZuwLrer5dn2uietYIYGVOL//E5QEzIj7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kF6AUeK6jhY1V7W9r/W8ebMusYjV2MRogklb05OTKb4uB3D7lBMLeXbespjpoZpSTegUUMDf5z4X/gi6ck0rkoo/QWscq5ohEM7no5PhgZhcJJ0EgsBmwiLoQCa7uy557XJa+7i+ooUpyPhTEyzw+Zw3D1ZMmZT1EbH/LPmgCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kakTF8xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C527C4CEDD;
	Tue, 18 Mar 2025 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298385;
	bh=dRSfnENYRHZuwLrer5dn2uietYIYGVOL//E5QEzIj7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kakTF8xznxHOSoYlefG4ova38cxne+CfXCK6RIEWsZvtOCakeIrADtZiggj19G/Kt
	 hG9Tsl/MpSLA5/ofq8qYq9zhgYlawnwrY466ZZZ6BKrvs2M1TKEzD8G6QG4XIF4onX
	 tKDR+5oxV3q/VyS0PhhrFvActDo9NXNMx9172ecIqmhGmdX0CMkAhP8/5r5WYAtWw/
	 jFZhWbLb9sQ2WSna8YID9cJQAGgM+brAmatv/F9ZRJtTd/W3zeOi17Nei8dTh3R3pI
	 2bQCpg6Ouyksuva4wkCeEEJBemnOQkBpI/zIKUHOTpk1A7h+C8cExW0ETq25flAUZJ
	 +RE/svSuLy+IQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 18 Mar 2025 12:46:08 +0100
Subject: [PATCH net-next v2 4/7] net: octeontx2: Add metadata support for
 xdp mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mvneta-xdp-meta-v2-4-b6075778f61f@kernel.org>
References: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
In-Reply-To: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org, 
 Michal Kubiak <michal.kubiak@intel.com>
X-Mailer: b4 0.14.2

Set metadata size building the skb from xdp_buff in octeontx2 driver.
octeontx2 driver sets xdp headroom to OTX2_HEAD_ROOM

OTX2_HEAD_ROOM	OTX2_ALIGN
OTX2_ALIGN	128

so the headroom is large enough to contain xdp_frame and xdp metadata.
Please note this patch is just compiled tested.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 6bc5ce5a9f61cc2830975e7cc5219344760b0e51..af8cabe828d05c8832085d24d183312f24d00330 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -41,7 +41,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct bpf_prog *prog,
 				     struct nix_cqe_rx_s *cqe,
 				     struct otx2_cq_queue *cq,
-				     bool *need_xdp_flush);
+				     u32 *metasize, bool *need_xdp_flush);
 
 static void otx2_sq_set_sqe_base(struct otx2_snd_queue *sq,
 				 struct sk_buff *skb)
@@ -336,6 +336,7 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	struct nix_rx_sg_s *sg = &cqe->sg;
 	struct sk_buff *skb = NULL;
 	void *end, *start;
+	u32 metasize = 0;
 	u64 *seg_addr;
 	u16 *seg_size;
 	int seg;
@@ -346,7 +347,8 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	}
 
 	if (pfvf->xdp_prog)
-		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq, need_xdp_flush))
+		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq,
+					     &metasize, need_xdp_flush))
 			return;
 
 	skb = napi_get_frags(napi);
@@ -378,6 +380,8 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 		skb->mark = parse->match_id;
 
 	skb_mark_for_recycle(skb);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
 
 	napi_gro_frags(napi);
 }
@@ -1482,7 +1486,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct bpf_prog *prog,
 				     struct nix_cqe_rx_s *cqe,
 				     struct otx2_cq_queue *cq,
-				     bool *need_xdp_flush)
+				     u32 *metasize, bool *need_xdp_flush)
 {
 	struct xdp_buff xdp, *xsk_buff = NULL;
 	unsigned char *hard_start;
@@ -1514,13 +1518,14 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 
 	hard_start = (unsigned char *)phys_to_virt(pa);
 	xdp_prepare_buff(&xdp, hard_start, OTX2_HEAD_ROOM,
-			 cqe->sg.seg_size, false);
+			 cqe->sg.seg_size, true);
 
 	act = bpf_prog_run_xdp(prog, &xdp);
 
 handle_xdp_verdict:
 	switch (act) {
 	case XDP_PASS:
+		*metasize = xdp.data - xdp.data_meta;
 		break;
 	case XDP_TX:
 		qidx += pfvf->hw.tx_queues;

-- 
2.48.1


