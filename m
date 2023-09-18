Return-Path: <bpf+bounces-10290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAC77A4CE6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC601C2128C
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD91F60B;
	Mon, 18 Sep 2023 15:42:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BC1D6AF;
	Mon, 18 Sep 2023 15:42:18 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A13115;
	Mon, 18 Sep 2023 08:40:23 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695051379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uItVMOEWNOMCKaEwLwvaBU6x/Cu3Qyaf2heiEbofrg=;
	b=Be5pNv3292IXVjkqNhDEVwevzotC4Yyle9R988mOxRd3j+fLUSaC0+/uJU6vvcUrWn/Q3K
	K5YCpdCUkozlKXuxxXCJBlx1pIzfXP/SxmAn/OFkfQeLNiisYzFSK4u3LgtRjZZqa1xEX8
	zuEgyxdXjQj9Kf1uqfVERd3HEu0HJ2GQR8hdfpElCstC/1sDyubTHV6XD0Nh2MAbNNWIzy
	dxTeq7nMAydejD7+uEgxRxmctEq2IBzdgZQ680d/jXVQqu8OV9EDhC7gfNCk09vSXhlkpl
	i9ZM+Qb4cydBfB7Pg2xdX5sEnZd9CWfBdXzi1B1hcOt3ZpjhmoYdnkSoT03IeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695051379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uItVMOEWNOMCKaEwLwvaBU6x/Cu3Qyaf2heiEbofrg=;
	b=e5KTDeUUKfw5/aBGh8iahBp8Okdv9ax1G6Q5g8Q0/k5yLD9MpFpWqouJcEohHZUtqYZlzO
	8iIn/3MPb6kvKwAA==
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	hariprasad <hkelam@marvell.com>
Subject: [PATCH net v2 3/3] octeontx2-pf: Do xdp_do_flush() after redirects.
Date: Mon, 18 Sep 2023 17:36:11 +0200
Message-Id: <20230918153611.165722-4-bigeasy@linutronix.de>
In-Reply-To: <20230918153611.165722-1-bigeasy@linutronix.de>
References: <20230918153611.165722-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xdp_do_flush() should be invoked before leaving the NAPI poll function
if XDP-redirect has been performed.

Invoke xdp_do_flush() before leaving NAPI.

Cc: Geetha sowjanya <gakula@marvell.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: hariprasad <hkelam@marvell.com>
Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Geethasowjanya Akula <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_txrx.c         | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index e77d438489557..53b2a4ef52985 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -29,7 +29,8 @@
 static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct bpf_prog *prog,
 				     struct nix_cqe_rx_s *cqe,
-				     struct otx2_cq_queue *cq);
+				     struct otx2_cq_queue *cq,
+				     bool *need_xdp_flush);
=20
 static int otx2_nix_cq_op_status(struct otx2_nic *pfvf,
 				 struct otx2_cq_queue *cq)
@@ -337,7 +338,7 @@ static bool otx2_check_rcv_errors(struct otx2_nic *pfvf,
 static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 				 struct napi_struct *napi,
 				 struct otx2_cq_queue *cq,
-				 struct nix_cqe_rx_s *cqe)
+				 struct nix_cqe_rx_s *cqe, bool *need_xdp_flush)
 {
 	struct nix_rx_parse_s *parse =3D &cqe->parse;
 	struct nix_rx_sg_s *sg =3D &cqe->sg;
@@ -353,7 +354,7 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	}
=20
 	if (pfvf->xdp_prog)
-		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq))
+		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq, need_xdp_flu=
sh))
 			return;
=20
 	skb =3D napi_get_frags(napi);
@@ -388,6 +389,7 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
 				struct napi_struct *napi,
 				struct otx2_cq_queue *cq, int budget)
 {
+	bool need_xdp_flush =3D false;
 	struct nix_cqe_rx_s *cqe;
 	int processed_cqe =3D 0;
=20
@@ -409,13 +411,15 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
 		cq->cq_head++;
 		cq->cq_head &=3D (cq->cqe_cnt - 1);
=20
-		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe);
+		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe, &need_xdp_flush);
=20
 		cqe->hdr.cqe_type =3D NIX_XQE_TYPE_INVALID;
 		cqe->sg.seg_addr =3D 0x00;
 		processed_cqe++;
 		cq->pend_cqe--;
 	}
+	if (need_xdp_flush)
+		xdp_do_flush();
=20
 	/* Free CQEs to HW */
 	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
@@ -1354,7 +1358,8 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u6=
4 iova, int len, u16 qidx)
 static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct bpf_prog *prog,
 				     struct nix_cqe_rx_s *cqe,
-				     struct otx2_cq_queue *cq)
+				     struct otx2_cq_queue *cq,
+				     bool *need_xdp_flush)
 {
 	unsigned char *hard_start, *data;
 	int qidx =3D cq->cq_idx;
@@ -1391,8 +1396,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic=
 *pfvf,
=20
 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
 				    DMA_FROM_DEVICE);
-		if (!err)
+		if (!err) {
+			*need_xdp_flush =3D true;
 			return true;
+		}
 		put_page(page);
 		break;
 	default:
--=20
2.40.1


