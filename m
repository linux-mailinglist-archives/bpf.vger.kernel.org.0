Return-Path: <bpf+bounces-9509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695F87988DE
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA371C20E68
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13E125A6;
	Fri,  8 Sep 2023 14:33:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105DE579;
	Fri,  8 Sep 2023 14:33:38 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7002105;
	Fri,  8 Sep 2023 07:33:05 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694183573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh05XGtLXhLN5T36SW/OhdNSqCvOXuejQtTeC9Puzes=;
	b=mUtStbNRdNu15whmlkGmFJaOmAZSuzDrrkxXGv0W6DVRmhDyu6j8cFg5lEFvn+USTHJomP
	Ww4fQl9pr8q0MBQ8X6rkTc0lLiUmOON9YatK6oag6qJyV1tQewtkbWtuQ5/VLO+ulY2g1Q
	25uxr9w4OaOPwb/E6FaXdisqcY3kgf7Q/ELOQUlqxwZ84T8pGtjSgnBaTLCnXpxueP+SA/
	2QLUkcmKg6A+6AjziaIcsTFrsbWWdjLy4Cy7Gr8JKdyXnya+tK7h6eH/7635rVLxFKFQCx
	3tL6XDDO3d8Uw7hZnhLHEJXxC+Fh7T7yGuc5v34VCJAkao7aM1c3IVrOujCySw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694183573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh05XGtLXhLN5T36SW/OhdNSqCvOXuejQtTeC9Puzes=;
	b=T4X3OhWk4PenHb4A4H8riO0USzYskyAss63LdHJAV0NyTsujbNIuTQs2ygInH7LrVr85Qh
	9kEn3pRrLqInZiBQ==
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	David Arinzon <darinzon@amazon.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Crispin <john@phrozen.org>,
	Leon Romanovsky <leon@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Noam Dagan <ndagan@amazon.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Bishara <saeedb@amazon.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH net-next 1/2] net: Tree wide: Replace xdp_do_flush_map() with xdp_do_flush().
Date: Fri,  8 Sep 2023 16:32:14 +0200
Message-Id: <20230908143215.869913-2-bigeasy@linutronix.de>
In-Reply-To: <20230908143215.869913-1-bigeasy@linutronix.de>
References: <20230908143215.869913-1-bigeasy@linutronix.de>
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

xdp_do_flush_map() is deprecated and new code should use xdp_do_flush()
instead.

Replace xdp_do_flush_map() with xdp_do_flush().

Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arthur Kiyanovski <akiyano@amazon.com>
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: David Arinzon <darinzon@amazon.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: John Crispin <john@phrozen.org>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Mark Lee <Mark-MC.Lee@mediatek.com>
Cc: Martin Habets <habetsm.xilinx@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Noam Dagan <ndagan@amazon.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Saeed Bishara <saeedb@amazon.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Shay Agroskin <shayagr@amazon.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c     | 2 +-
 drivers/net/ethernet/freescale/enetc/enetc.c     | 2 +-
 drivers/net/ethernet/freescale/fec_main.c        | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c      | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c    | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c     | 2 +-
 drivers/net/ethernet/marvell/mvneta.c            | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c  | 2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 2 +-
 drivers/net/ethernet/netronome/nfp/nfd3/xsk.c    | 2 +-
 drivers/net/ethernet/sfc/efx_channels.c          | 2 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c    | 2 +-
 drivers/net/ethernet/socionext/netsec.c          | 2 +-
 drivers/net/ethernet/ti/cpsw_priv.c              | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index ad32ca81f7ef4..69bc8dfa7d71b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1828,7 +1828,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring,=
 struct napi_struct *napi,
 	}
=20
 	if (xdp_flags & ENA_XDP_REDIRECT)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	return work_done;
=20
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/eth=
ernet/freescale/enetc/enetc.c
index 35461165de0d2..30bec47bc665b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1655,7 +1655,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *=
rx_ring,
 	rx_ring->stats.bytes +=3D rx_byte_cnt;
=20
 	if (xdp_redirect_frm_cnt)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (xdp_tx_frm_cnt)
 		enetc_update_tx_ring_tail(tx_ring);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 77c8e9cfb4456..b833467088811 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1832,7 +1832,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget=
, u16 queue_id)
 	rxq->bd.cur =3D bdp;
=20
 	if (xdp_result & FEC_ENET_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	return pkt_received;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_txrx.c
index 0b3a27f118fb9..d680df615ff95 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2405,7 +2405,7 @@ void i40e_update_rx_stats(struct i40e_ring *rx_ring,
 void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res)
 {
 	if (xdp_res & I40E_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (xdp_res & I40E_XDP_TX) {
 		struct i40e_ring *xdp_ring =3D
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/et=
hernet/intel/ice/ice_txrx_lib.c
index c8322fb6f2b37..7e06373e14d98 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -450,7 +450,7 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, =
unsigned int xdp_res,
 	struct ice_tx_buf *tx_buf =3D &xdp_ring->tx_buf[first_idx];
=20
 	if (xdp_res & ICE_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (xdp_res & ICE_XDP_TX) {
 		if (static_branch_unlikely(&ice_xdp_locking_key))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_main.c
index dd03b017dfc51..94bde2cad0f47 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2421,7 +2421,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *=
q_vector,
 	}
=20
 	if (xdp_xmit & IXGBE_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (xdp_xmit & IXGBE_XDP_TX) {
 		struct ixgbe_ring *ring =3D ixgbe_determine_xdp_ring(adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/eth=
ernet/intel/ixgbe/ixgbe_xsk.c
index 1703c640a434d..59798bc33298f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -351,7 +351,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vect=
or,
 	}
=20
 	if (xdp_xmit & IXGBE_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (xdp_xmit & IXGBE_XDP_TX) {
 		struct ixgbe_ring *ring =3D ixgbe_determine_xdp_ring(adapter);
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/m=
arvell/mvneta.c
index d483b8c00ec0e..7b2aa30de8222 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2520,7 +2520,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		mvneta_xdp_put_buff(pp, rxq, &xdp_buf, -1);
=20
 	if (ps.xdp_redirect)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (ps.rx_packets)
 		mvneta_update_stats(pp, &ps);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index eb74ccddb4409..60c53f66935a6 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4027,7 +4027,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct n=
api_struct *napi,
 	}
=20
 	if (xdp_ret & MVPP2_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (ps.rx_packets) {
 		struct mvpp2_pcpu_stats *stats =3D this_cpu_ptr(port->stats);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethe=
rnet/mediatek/mtk_eth_soc.c
index 6ad42e3b488f7..0b8ee35d713d1 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2209,7 +2209,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int =
budget,
 	net_dim(&eth->rx_dim, dim_sample);
=20
 	if (xdp_flush)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	return done;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net=
/ethernet/mellanox/mlx5/core/en/xdp.c
index 12f56d0db0af2..cc3fcd24b36d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -893,7 +893,7 @@ void mlx5e_xdp_rx_poll_complete(struct mlx5e_rq *rq)
 	mlx5e_xmit_xdp_doorbell(xdpsq);
=20
 	if (test_bit(MLX5E_RQ_FLAG_XDP_REDIRECT, rq->flags)) {
-		xdp_do_flush_map();
+		xdp_do_flush();
 		__clear_bit(MLX5E_RQ_FLAG_XDP_REDIRECT, rq->flags);
 	}
 }
diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c b/drivers/net/et=
hernet/netronome/nfp/nfd3/xsk.c
index 5d9db8c2a5b43..45be6954d5aae 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
@@ -256,7 +256,7 @@ nfp_nfd3_xsk_rx(struct nfp_net_rx_ring *rx_ring, int bu=
dget,
 	nfp_net_xsk_rx_ring_fill_freelist(r_vec->rx_ring);
=20
 	if (xdp_redir)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (tx_ring->wr_ptr_add)
 		nfp_net_tx_xmit_more_flush(tx_ring);
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet=
/sfc/efx_channels.c
index 8d2d7ea2ebefc..c9e17a8208a90 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1260,7 +1260,7 @@ static int efx_poll(struct napi_struct *napi, int bud=
get)
=20
 	spent =3D efx_process_channel(channel, budget);
=20
-	xdp_do_flush_map();
+	xdp_do_flush();
=20
 	if (spent < budget) {
 		if (efx_channel_has_rx_queue(channel) &&
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/et=
hernet/sfc/siena/efx_channels.c
index 1776f7f8a7a90..a7346e965bfe7 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1285,7 +1285,7 @@ static int efx_poll(struct napi_struct *napi, int bud=
get)
=20
 	spent =3D efx_process_channel(channel, budget);
=20
-	xdp_do_flush_map();
+	xdp_do_flush();
=20
 	if (spent < budget) {
 		if (efx_channel_has_rx_queue(channel) &&
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet=
/socionext/netsec.c
index f358ea0031936..b834b129639f0 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -780,7 +780,7 @@ static void netsec_finalize_xdp_rx(struct netsec_priv *=
priv, u32 xdp_res,
 				   u16 pkts)
 {
 	if (xdp_res & NETSEC_XDP_REDIR)
-		xdp_do_flush_map();
+		xdp_do_flush();
=20
 	if (xdp_res & NETSEC_XDP_TX)
 		netsec_xdp_ring_tx_db(priv, pkts);
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/=
cpsw_priv.c
index 0ec85635dfd60..764ed298b5708 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -1360,7 +1360,7 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, stru=
ct xdp_buff *xdp,
 		 *  particular hardware is sharing a common queue, so the
 		 *  incoming device might change per packet.
 		 */
-		xdp_do_flush_map();
+		xdp_do_flush();
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(ndev, prog, act);
--=20
2.40.1


