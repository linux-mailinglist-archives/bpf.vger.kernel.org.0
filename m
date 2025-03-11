Return-Path: <bpf+bounces-53814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B4A5C0B7
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8823AA4B3
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA6B259C80;
	Tue, 11 Mar 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYyjIwf0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B849258CD2;
	Tue, 11 Mar 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695549; cv=none; b=STWEc5Qeyk8PYLkI7rHFkTsOl6moyZX52170EHbwhfFZ8zjmQVc41pDsUPI8wxsg83Zr/Ytb9JeA/RbYJ3yqnV2lTYgwNtKCPY0kxQvTSco4lvwNrZUoLgb9ipTPYQdXTOv6VaJjUo0F8PRCdLaxBBj/0sfoMEmgOOIBij52HdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695549; c=relaxed/simple;
	bh=LSjQ49wR95nB5Q5G/AIMKk08CggQRNScXhe5BjJKpeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNKMjmZHps6Huy6chBluYz0iQjscpD4i8HjvQlCTv4aAXBQ14gSNx1uPFgsfXLjWFd4TYLkkNc7dfPQ11lHMLUAD1XTf8sed+is7QUksQm5RP5L4ze/oaVyRoAPkwoLLIpVqCPkTd2WvawoqVlc2arG+Rtrzk8uawpkHLmWRz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYyjIwf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF8DC4CEE9;
	Tue, 11 Mar 2025 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695549;
	bh=LSjQ49wR95nB5Q5G/AIMKk08CggQRNScXhe5BjJKpeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WYyjIwf0NKoI9nJPBCgY1Bv65NklpAR8eJ8qZ8zW2R0VyFs6VlCIkgkVLsrRdX0kd
	 vduu59iVdLoyGQzlh8+Vi+1XTCx8VslZ0Nstm8soITPVVeStTNVpt1pU+9/y8AcgO4
	 uUYIKFcAhgR/cD0T2oxWvkg1ik/eljslHbTv6u229C83Pyq9hiGOsWNfXlYhxvQg16
	 FY1k6EFypst6J/6Qy58gV4rAZMAUfn4+nGf9w5d0Zz1JtKa3jZTPUwFtNUO+Fvt8Ev
	 LMkzqqtEld2lNu2aQEWixc1OatPITJIhoYARMzYTJjKxBDOlXFl1SR1DLnGZCrPEBj
	 8f1dzz9unFnww==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 13:18:36 +0100
Subject: [PATCH net-next 4/7] net: octeontx2: Add metadata support for xdp
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mvneta-xdp-meta-v1-4-36cf1c99790e@kernel.org>
References: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
In-Reply-To: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
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
 Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Set metadata size building the skb from xdp_buff in octeontx2 driver

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


