Return-Path: <bpf+bounces-6397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2A768B87
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 08:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE35F281554
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13496ECB;
	Mon, 31 Jul 2023 06:07:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756A7F8;
	Mon, 31 Jul 2023 06:07:28 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A8E7B;
	Sun, 30 Jul 2023 23:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCyWudsAy1rsojiIfTmAYYpx29uAMJoAG1uCVNGsoP5ZicjS8Kj7F8VclxjMkWHCvqXi/Q5guNBBG+yFwIrLPtFIUfPw5ce2vpACWtLxEl6FI23OXS3OvamyT+ZuRUXM0LrTX+u6qRX52Gw9uZj96e8x8svIVxvmiiZVI4XH/39+a/N4KgspoM0rPHVOSpCWcqM0GxgOHHfFvBuMU7KcglnLH21M1W/HPkV7mji9NUmtou40AEUqphz8/OifWuyRrK9Y50cTm1mGXfi9B7JcdmnVUphaR/a8O4GEh274dsbsFAOfnS9HRNcjTS8cAlKMFYH3dpe4dxqv0JhE2SBMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4TSKTs6B/8PO4prMoleSl/XH3LCa8reANhebeEZFHA=;
 b=bBkXrtSYthftVanGMufDosCvCkoX5hR6UicjhJuH8evBreFqBIQmP1BjYtF3WmDSKcgb0yS2pZkSM3/VvIywfgM12i8Oauije6zsPjnrtKAhWkPNAsehbUnyYGYafecVrjvRGylOlPZuMBos0mC7BSHy/ulktlKGnqk/5DUplGY835JEvkBeNsyLapwNEt8Pd5CDd7tx0kzk3vCoA+rRjbTdXafGrUZ0AbVXbwDcJqU6KJaqxNqVq4BC7vQtqoPgqEliCEbzhasiSXqib6oYM2cXww98ZbPglqJly15PIh9t6gn8NniM+7WlF6ThHzJaGI92FzeBP4yRWTKoxyLnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4TSKTs6B/8PO4prMoleSl/XH3LCa8reANhebeEZFHA=;
 b=T0azMbwR4RCGsOJt99Oio/Wk0OHq2so8Glyir7Z7qMazg+bCgsQEmzVk8kJEVn75pIQnI3snU4U9KYnGUcqcJEWM/NbfYXvSG2e8qebEVy6Hn10MkZtXiSTev/U4YgkmFy4xN/Xf2wNXG0Jp2n4eJRqaffd+G3y0v5K7pjneVCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:07:23 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:07:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Date: Mon, 31 Jul 2023 14:00:25 +0800
Message-Id: <20230731060025.3117343-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DB8PR04MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6da819-b374-4dca-6f36-08db918c683f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fCrbsnrxS7Nx4gPBOYAl2MMGbHASE60tUrbf47ghFeoM/e4Zhl2ZthczTt3gwpPcURUBWfWK3oO7Pc6YIm0GhQypWPuLBlXYKGOTkjm7LQdB9QGb6EjdRIJqjcSZrm2ivSIdJCLLtCWRdzAtufU3GvnMBoy2i9s6CYyg/oZ3Vt9znlpHUe2ki5o1aVZF2X7bpPyPZIguvdL/Os003ucMfnd6LB6fV00kYsAga1LLkzCbsKcrc0pK8n2LEULVpaTAbsQKOc8zpuJ2vWOiiKMmcyQwUg+l1yxpfNV+ARVzmwxI5UOo/Ll9+akRtvxivWUUGt69kPdkPeHQ4E5b6Z0sCxwgXYJGNEVrNBG+ukA78ZinjHr7HIxytUWpru2H+ISraBHym28sJ1lmmCIiVpMFlmc8KOeVpRvT4NObhlZxi4CNMwkCcFYFHxXao3GBUEOyiovuPV/RYisvK8L1UW28baOB5jXETrAJYqEAnqdtAW3sWUn5xQjlGS60ijKWbSom4VSsTm5jqZOFiePmENFIJL1FWwUD8r0iaii6PTU51VXu2UqhA3/A5EUovFj89/JfzsriL3h86T3PZY81st6OmsmoJYmi1xTNyyHYUdC/KM/CHS+PQ3b/Q7Lt/gOKWf4x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(6512007)(966005)(6486002)(52116002)(36756003)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(44832011)(66946007)(66556008)(7416002)(921005)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oKTPwStJOjhiDnwrnz4alhuuLIoqPgTCObaeLMudL+MUW8jwWiGzn+cJxoUO?=
 =?us-ascii?Q?xncDN5kZi2Lxnc4MA7NSXejC7JguQdeIBtUzJD7KU2afne8mIODkVF6j3FyB?=
 =?us-ascii?Q?LORQdQGIre5Dzlsshtun00h2s3iuOvNioOzegtMq41MSH1Ia4U8FMUzcne+A?=
 =?us-ascii?Q?gSTG3jXTsNtsBQo4Q9PgixUF30OjEBUwmQGofVpY9uJR7n53Kvsks0OMXnWt?=
 =?us-ascii?Q?xn/lCkSpf8+OPVWrkyl5J/rbh3/5uWzdKSfOy+j8yjgH2OnUgjMv+OItecjv?=
 =?us-ascii?Q?hW98HROOzVKeIDfXBpAMabP2JCKLbjDnC22Yu6yeaw38GMewz5ErNrA9+w6T?=
 =?us-ascii?Q?Cqb024aogJ9eye2xaYSeH1Dqfjvs5vY78pSxkLJIBjmTit2KkyvZHPV63Sie?=
 =?us-ascii?Q?YLYq0MRBMLwgP6v5v0MzR3wCEpEBBd/GYT2PYp+vlhfuxJ/ner2zSLft1vnJ?=
 =?us-ascii?Q?ye9hIUozT13aPwhrFs5w2Yr5yjbx1WIHQDBXb4M+GAsr4pD/WmYnTXcDAwOi?=
 =?us-ascii?Q?0XEXDob5QevpmU3vt4HVN/57RJRbuOS6M6TeFx1KW/m2lpj65whIKVqC7mpQ?=
 =?us-ascii?Q?aSl7RNhj6kdittm5aBQlQnpPOl6KmVZRf4GRBYTaWPkKSCYP8Yl6JrzAPDKB?=
 =?us-ascii?Q?NILSjzwX7jcVjemLWwn8cFyDSlpeXZL7UagYUvS6iPcD65Q9DrcQOHMDEBhv?=
 =?us-ascii?Q?vr4fUg1trdIQjOBFcROvUhIxIQ2H3cJwpARDfHHLwXyeKm+f8OdHMGmkWLZd?=
 =?us-ascii?Q?hwJfDH/8Pcak9wjOBZ4egkB9CMVU+DnbpD/uW1NUSiz05ZX0ylDQhmcsf8xJ?=
 =?us-ascii?Q?9VuGSyZHtC9seHm4t95pEzV58YJR1SF/BSBjOIeO7T0QHvscNxzAueu4ijDJ?=
 =?us-ascii?Q?enIX39wz5vdXxFkNPJbhI3LDJLFNHeCvK2EyIS38rbBsUje1gDy6VnX6fwbX?=
 =?us-ascii?Q?5bALpsvstV2kMlyx8JHW3ex4DD2B664/DwOEY67uz1OimeIgaSX1Gcow8v6y?=
 =?us-ascii?Q?meGkvrTfcAuHB3PDV0m4uaiJqgLCxRcGhW/+qLOz6MZsrj+ikXimX906sRXf?=
 =?us-ascii?Q?2AhXsNMxn5AIpcwkE/9bFFEmDz5+8dgMeZ5Em7RFWx9n3gKTSvHr8cgVM5H8?=
 =?us-ascii?Q?L3hytUYkb5yL8FipLLz/yG4LQDhVt9am7pG9XmEvXid1N2eTS1kK0EjQjFeP?=
 =?us-ascii?Q?TKGd7keVDKMBWThOFTp271gA8pTGP2oWMmcW3bxdqAjamhGmBYw4V8oQCEo4?=
 =?us-ascii?Q?JpgDwScKFTTsAfgmOI3ueDJzMHUHo/5g1lUspz2h3F7msRuaaYwSAgSohb+R?=
 =?us-ascii?Q?D1pDuMR6KNwxc/IK3tCOf7Ftr5RNizf03VENGvUY01DhhLraMYCYSAoEt3qD?=
 =?us-ascii?Q?cd7EbRHUe27kW22JH0FfXvyiyoXu1vNR4vLlQziF2ut+/vH1fXkEpIK2rGd2?=
 =?us-ascii?Q?Z9jElV2qUpp/lWxaipatCctxeXY25akeVndb98gpa40UxSRLXtqoaTOWadcX?=
 =?us-ascii?Q?ddBQuEvqiKkCv1fheTKd64bdb2OX0rI2LJNTIOBt3o/5w8UGerYzBsmO7U/7?=
 =?us-ascii?Q?CpSz8NM6rbmp0263uSmzIN8LGndphrXV15bjaomk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6da819-b374-4dca-6f36-08db918c683f
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:07:23.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yut4euRf/vTMJoggThDsOqjs4kgJbsQRjOQC620gQM4qzyyX0GYZkzbL/FlgQ7NaY/DOB8EAEKuU6YSq4P7EHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The XDP_TX feature is not supported before, and all the frames
which are deemed to do XDP_TX action actually do the XDP_DROP
action. So this patch adds the XDP_TX support to FEC driver.

I tested the performance of XDP_TX feature in XDP_DRV and XDP_SKB
modes on i.MX8MM-EVK and i.MX8MP-EVK platforms respectively, and
the test steps and results are as follows.

Step 1: Board A connects to the FEC port of the DUT and runs the
pktgen_sample03_burst_single_flow.sh script to generate and send
burst traffic to DUT. Note that the length of packet was set to
64 bytes and the procotol of packet was UDP in my test scenario.

Step 2: The DUT runs the xdp2 program to transmit received UDP
packets back out on the same port where they were received.

root@imx8mmevk:~# ./xdp2 eth0
proto 17:     150326 pkt/s
proto 17:     141920 pkt/s
proto 17:     147338 pkt/s
proto 17:     140783 pkt/s
proto 17:     150400 pkt/s
proto 17:     134651 pkt/s
proto 17:     134676 pkt/s
proto 17:     134959 pkt/s
proto 17:     148152 pkt/s
proto 17:     149885 pkt/s

root@imx8mmevk:~# ./xdp2 -S eth0
proto 17:     131094 pkt/s
proto 17:     134691 pkt/s
proto 17:     138930 pkt/s
proto 17:     129347 pkt/s
proto 17:     133050 pkt/s
proto 17:     132932 pkt/s
proto 17:     136628 pkt/s
proto 17:     132964 pkt/s
proto 17:     131265 pkt/s
proto 17:     135794 pkt/s

root@imx8mpevk:~# ./xdp2 eth0
proto 17:     135817 pkt/s
proto 17:     142776 pkt/s
proto 17:     142237 pkt/s
proto 17:     135673 pkt/s
proto 17:     139508 pkt/s
proto 17:     147340 pkt/s
proto 17:     133329 pkt/s
proto 17:     141171 pkt/s
proto 17:     146917 pkt/s
proto 17:     135488 pkt/s

root@imx8mpevk:~# ./xdp2 -S eth0
proto 17:     133150 pkt/s
proto 17:     133127 pkt/s
proto 17:     133538 pkt/s
proto 17:     133094 pkt/s
proto 17:     133690 pkt/s
proto 17:     133199 pkt/s
proto 17:     133905 pkt/s
proto 17:     132908 pkt/s
proto 17:     133292 pkt/s
proto 17:     133511 pkt/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
According to Jakub's comments, the V2 patch adds two changes.
1. Call txq_trans_cond_update() in fec_enet_xdp_tx_xmit() to avoid
tx timeout as XDP shares the queues with kernel stack.
2. Tx processing shouldn't call any XDP (or page pool) APIs if the
"budget" is 0.

V3 changes:
1. Remove the second change in V2, because this change has been
separated into another patch and it has been submmitted to the
upstream [1].
[1] https://lore.kernel.org/r/20230725074148.2936402-1-wei.fang@nxp.com
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 80 ++++++++++++++++++-----
 2 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8f1edcca96c4..f35445bddc7a 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -547,6 +547,7 @@ enum {
 enum fec_txbuf_type {
 	FEC_TXBUF_T_SKB,
 	FEC_TXBUF_T_XDP_NDO,
+	FEC_TXBUF_T_XDP_TX,
 };
 
 struct fec_tx_buffer {
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 14d0dc7ba3c9..2068fe95504e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -75,6 +75,8 @@
 
 static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
+static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
+				struct xdp_buff *xdp);
 
 #define DRIVER_NAME	"fec"
 
@@ -960,7 +962,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 					txq->tx_buf[i].skb = NULL;
 				}
 			} else {
-				if (bdp->cbd_bufaddr)
+				if (bdp->cbd_bufaddr &&
+				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
 					dma_unmap_single(&fep->pdev->dev,
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
@@ -1423,7 +1426,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				break;
 
 			xdpf = txq->tx_buf[index].xdp;
-			if (bdp->cbd_bufaddr)
+			if (bdp->cbd_bufaddr &&
+			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
@@ -1482,7 +1486,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			/* Free the sk buffer associated with this last transmit */
 			dev_kfree_skb_any(skb);
 		} else {
-			xdp_return_frame(xdpf);
+			xdp_return_frame_rx_napi(xdpf);
 
 			txq->tx_buf[index].xdp = NULL;
 			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
@@ -1573,11 +1577,18 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 		}
 		break;
 
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
 	case XDP_TX:
+		err = fec_enet_xdp_tx_xmit(fep->netdev, xdp);
+		if (err) {
+			ret = FEC_ENET_XDP_CONSUMED;
+			page = virt_to_head_page(xdp->data);
+			page_pool_put_page(rxq->page_pool, page, sync, true);
+		} else {
+			ret = FEC_ENET_XDP_TX;
+		}
+		break;
+
+	default:
 		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
 		fallthrough;
 
@@ -3793,7 +3804,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
 
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
-				   struct xdp_frame *frame)
+				   struct xdp_frame *frame,
+				   bool ndo_xmit)
 {
 	unsigned int index, status, estatus;
 	struct bufdesc *bdp;
@@ -3813,10 +3825,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	index = fec_enet_get_bd_index(bdp, &txq->bd);
 
-	dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
-				  frame->len, DMA_TO_DEVICE);
-	if (dma_mapping_error(&fep->pdev->dev, dma_addr))
-		return -ENOMEM;
+	if (ndo_xmit) {
+		dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
+					  frame->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(&fep->pdev->dev, dma_addr))
+			return -ENOMEM;
+
+		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
+	} else {
+		struct page *page = virt_to_page(frame->data);
+
+		dma_addr = page_pool_get_dma_addr(page) + sizeof(*frame) +
+			   frame->headroom;
+		dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
+					   frame->len, DMA_BIDIRECTIONAL);
+		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
+	}
+
+	txq->tx_buf[index].xdp = frame;
 
 	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
 	if (fep->bufdesc_ex)
@@ -3835,9 +3861,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		ebdp->cbd_esc = cpu_to_fec32(estatus);
 	}
 
-	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
-	txq->tx_buf[index].xdp = frame;
-
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
@@ -3863,6 +3886,31 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	return 0;
 }
 
+static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
+				struct xdp_buff *xdp)
+{
+	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_tx_q *txq;
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+	int queue, ret;
+
+	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
+	txq = fep->tx_queue[queue];
+	nq = netdev_get_tx_queue(fep->netdev, queue);
+
+	__netif_tx_lock(nq, cpu);
+
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
+	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
+
+	__netif_tx_unlock(nq);
+
+	return ret;
+}
+
 static int fec_enet_xdp_xmit(struct net_device *dev,
 			     int num_frames,
 			     struct xdp_frame **frames,
@@ -3885,7 +3933,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	/* Avoid tx timeout as XDP shares the queue with kernel stack */
 	txq_trans_cond_update(nq);
 	for (i = 0; i < num_frames; i++) {
-		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
+		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
 			break;
 		sent_frames++;
 	}
-- 
2.25.1


