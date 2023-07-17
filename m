Return-Path: <bpf+bounces-5083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF887560C5
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 12:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8306A2814CB
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08DAA924;
	Mon, 17 Jul 2023 10:43:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8748498;
	Mon, 17 Jul 2023 10:43:49 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24F9BC;
	Mon, 17 Jul 2023 03:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djvMu9p/P+FwVFcLjw4BjEGnp6NInFASfWtdUg+BiJMJKwxXpdWwqzUA3gy68V62QM8/ukFEhC2GrfuG9ImJ4Zq+2KX2koe2vWepeV0M6+Uq5nmZHkIIKMIQ8TwxCr4Zn7KKiFdpaGs9UA3NEWN53+jTTlhvvZHL7/kV/KXvHoBwPJSnAExUbjUHRBJvz5A2NDMSqBAYdv4SQrm4pfAAFAwFHgdDtjpoWv0gketgXT1JfUDYBQQV5p5yBlFDlATllsPnSbEt7qTjqJ2X0NAmaeK1LSOO7ZsDkQ7VdgiuP6nxU5ztbRMgqhen9qzuJf2pJQG6VWFKbv6Dp8m2l7xeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82Hb7Ma7lLyNap+NY9PXPewj31porzQZ/+ywsiEhb/E=;
 b=oQzJkTbYizZMnm20Ta125+stAi42oTIqLFyFhOL1q5GScuBBL7jhZwbPstDv0T5mJl/88TOyImX++McTo5MjpqWksvSYeuLaqVtB5C0zq52CPSAn6pZA0z+r0V9UH4rB96qw279AvpXK0emoDDmRF6C2NQylpvIGJzG0wlSC6JcfEFbrysBpXl1CkkzxA8WFOrK9T3GhN+7WAZ8Ab9AdJBPm3TQUJn47knbTrOJRrulPp4r6lvACb0ABMlOJgjSzfn6vLHixbazWWXyiLB8IGtbK6GAlQIMLnVRuwSyiO91I4YultZSFqQq96NpMbUYUa4RvaoLBqr6yfK2ipA51og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82Hb7Ma7lLyNap+NY9PXPewj31porzQZ/+ywsiEhb/E=;
 b=f00ELre9gK8MxnODojQIcTTDE/hnjjWoNJbytGZvL/JCQVVbZbyFdru9y8PRb+jo8rhbyN8xuC6gWuBdElt5qAf4tWMSRf6xzoJMccwRNrQUllbQmKPoevrt4tPWhoO3TtPCaFCiJOccC6NV72BLLbzQearO18NY5bwbpeKJNV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by VI1PR04MB6864.eurprd04.prod.outlook.com (2603:10a6:803:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 10:43:44 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:43:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	xiaoning.wang@nxp.com,
	shenwei.wang@nxp.com,
	netdev@vger.kernel.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] net: fec: add XDP_TX feature support
Date: Mon, 17 Jul 2023 18:37:09 +0800
Message-Id: <20230717103709.2629372-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|VI1PR04MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 12831e76-0c14-48f6-700d-08db86b2b12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZUD8sUx9BDX5aQCw+NxB6YJ22wZaBeVbBsD/PH7LKDLvgEo3X4qWA+MJDTN/ODxDmBjzrhmipWiev0WGuJDs++ie8dsxXh666sJr4HtGrvptRom8wsd1ha+Vlii7YNo6YgFoZUlQVr26y9AoXMFhQXnynB785oxy30WkJ4MRkQdJdwiY8k8FdB1BDKG83kaSmenktz2Ey0XzhVf2Y8bxJPKrzqdyTnjoZRaa99/69CLsazR/J/XzZwis0Qdje9XEBePIRbcmfuNL5G0QINOGz6LO1LDTmP1tBbjYTtt51uuCLMDTC/TL4p4QV9u3oDfNdK1CZ5Mr5ciXKDPBm3K3pet8IgfHt7TZuItU1rG2izWdR7MymRKsBmpp3b8Wg3xssWrWSch7BCV1cw7zyGvQ7bHXY7Y6aZAsQBgwaLRspSaELSBj/lAdCNvrhtmIeOipxCt+hVYow3XX9kLPh2GO+4xfWvdRZ49SEzNYCS7TOhqWRrOBN9DA5Sd81wIm/TpJ2t1yt4Txz5smvqiRr9wKtNvfvZAmDEoJe3nZXcFordKvHoSsGsDJ94KoKEppbCFiWvA0RiIWb0eZzufDTyr5UtaSwZ5rt/kqFEJhLNhw1hyeRwxiJxVgiWqibDMH1BpG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(41300700001)(478600001)(44832011)(8936002)(8676002)(6666004)(2906002)(316002)(5660300002)(66946007)(66476007)(7416002)(66556008)(4326008)(6512007)(26005)(52116002)(6486002)(6506007)(1076003)(38100700002)(186003)(38350700002)(921005)(83380400001)(36756003)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5xTqIYTNwAr+t5MOAdW0b7vbRI8Mv2CXpQwSUIXQE2kJdOBG4T9QfLBKx91X?=
 =?us-ascii?Q?PLG2sCSE+OiFf3/qmM87z0Yw7I7V2TdIhC/+iVoLbqe3FqaPyQTyeE84GDiN?=
 =?us-ascii?Q?ufl30jvlefGlQHKyIUNEkwic3xallg+wz31oXM07VOLF5xUB58tAqJ8bqAgP?=
 =?us-ascii?Q?fpSk1RARZ9jluG8PKPG+OCROp4bBw5e6qdPf1HgryAVWbmcGaNFRXlINgUuy?=
 =?us-ascii?Q?o8T9ZYR6OV7DomzudAkrpxjKy6rPXZS1Z+5JREglOns0H37nhT12WsdW34QX?=
 =?us-ascii?Q?7/l0Vl31tayq1YDMtI8dZG0TusSKdHY+8vBYbNmGWIF9sFi1ak5je9hHPVUC?=
 =?us-ascii?Q?MvcAzrnpPZHFav8EZlXhf3tS8weuAEvN69yd82elM5gD+9fXHr3tpHcejO66?=
 =?us-ascii?Q?d6Dq6mOs+nXnPNwq6ZR5IvO6DXnkHCl5O//JSOUFHn2qRdYpdR07XKvCIMb0?=
 =?us-ascii?Q?/6KAlKhfmAS18EevB3zmvGBT8nM+Z9KKxghnvcQL3TH5yXfYYAYFYgJnRBPH?=
 =?us-ascii?Q?WRj7CUv+6lrVj89HU/ePb8BDwN0egGgpQPgZLjGMGF2P8WWjjBpwtgrnYEmI?=
 =?us-ascii?Q?2m2wMMH/qR56YH5JZsNpUJo3BKotlG6MEjK8E0HHVAGgXb65zRz5F2kWfeXY?=
 =?us-ascii?Q?3hdYbGdPJjYhCcej+YBFkdbdPOOQJvdp2b4DB0XVrvn5ZOKz0ohGV5NPt8MQ?=
 =?us-ascii?Q?9UmQ8tFDGBNlQUu43qNJIOQh+LlH9RWvX3LHr2W0h8SOVdIBBrFArAr94Uex?=
 =?us-ascii?Q?/vlXLvv1JxAVyMIfPICq39kVGqSJa8qt7gni+JNx/jWR95XUUgN35uM/TQJc?=
 =?us-ascii?Q?AU7cR03E71QDl2Gl6mcViVrPQvUZbXiENvgD1AGNiRD9//obJcUcynoHt+Mk?=
 =?us-ascii?Q?UZwHUVvKO5VYMzV9K3G4TxU/P6WcOcIpjRzJy11gE14spzsGZ1t6QrC57kBk?=
 =?us-ascii?Q?O/3cJgT67i1kBvuYyg2IkJ5vPZFnPPxRVrGbpC+F8SU1ZDjuAmmkBhKGgUWQ?=
 =?us-ascii?Q?aTlsI3iMDUKuX4dd3GqxQSOFXdp5GbUlQKS3tHLDE0f+YmtFg3xNapOC3c55?=
 =?us-ascii?Q?0wTt6cH1FiyhM/vy73aIi0xGPeNEtgHeT1JsK8C2SqdTH5Vfx93EbHxTqigK?=
 =?us-ascii?Q?ZgJxbZHyPSvdQ4R1olrEH6DhYOq+eh6W9KReycd7gVRzP0UYPA1eJeh9sJbd?=
 =?us-ascii?Q?Im0EAWBYv49ksPHfLIUV/iYQkOY1IgnSM/5M1xjIhDiOOQeF0loyF59bppb9?=
 =?us-ascii?Q?z/SW52cZnlCNHYs8xfS8GOUcakMNEWNXAPv1p8VNdoq3REjq4AQWVsCjBWe6?=
 =?us-ascii?Q?9xJaw2sW7g5kMkqZxk/8qCJKbSX0jbSdz+aGlQJr2kpvMC2eUCyJytxYI02r?=
 =?us-ascii?Q?ATXfVJuzl0q+7kYx4TlmQDaJ37MdkFXBe1DzAtNBYFEt3ykpRq777Ydl0Zg6?=
 =?us-ascii?Q?Uzjssn97i400wq3JyEq9ObYnkFMivvsTyAVsIrZajnxzSHW+YshYb5B8/fXH?=
 =?us-ascii?Q?AalvO29Xr29GiT5jeyFBq0TzXG+xYwBDINNs6ci+DxD2O4qp3HY0vwcNIZMz?=
 =?us-ascii?Q?DfpSJrtx0kGp83uhP+Gh7qnJ9wJaIBZC/16Bw131?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12831e76-0c14-48f6-700d-08db86b2b12c
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 10:43:43.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhgnxzlXxUAK3WCzGrcJbbss/CUlcYKG7TDDJf2qZMELatd6pgznmQouli4wzszoO0hDEmp/yz0nQkft3yeykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6864
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

root@imx8mpevk:~# ./xdp2 eth
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
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 81 ++++++++++++++++++-----
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 63a053dea819..e4b5ae4884d9 100644
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
index 1b990a486059..1063552980bc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -75,6 +75,8 @@
 
 static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
+static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
+				struct xdp_buff *xdp);
 
 #define DRIVER_NAME	"fec"
 
@@ -962,7 +964,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 					txq->tx_buf[i].skb = NULL;
 				}
 			} else {
-				if (bdp->cbd_bufaddr)
+				if (bdp->cbd_bufaddr &&
+				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
 					dma_unmap_single(&fep->pdev->dev,
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
@@ -1417,7 +1420,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 				goto tx_buf_done;
 		} else {
 			xdpf = txq->tx_buf[index].xdp;
-			if (bdp->cbd_bufaddr)
+			if (bdp->cbd_bufaddr &&
+			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
@@ -1476,7 +1480,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 			/* Free the sk buffer associated with this last transmit */
 			dev_kfree_skb_any(skb);
 		} else {
-			xdp_return_frame(xdpf);
+			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
+				xdp_return_frame(xdpf);
+			else
+				xdp_return_frame_rx_napi(xdpf);
 
 			txq->tx_buf[index].xdp = NULL;
 			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
@@ -1567,11 +1574,18 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
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
 
@@ -3827,7 +3841,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
 
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
-				   struct xdp_frame *frame)
+				   struct xdp_frame *frame,
+				   bool ndo_xmit)
 {
 	unsigned int index, status, estatus;
 	struct bufdesc *bdp;
@@ -3847,10 +3862,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
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
@@ -3869,9 +3898,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		ebdp->cbd_esc = cpu_to_fec32(estatus);
 	}
 
-	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
-	txq->tx_buf[index].xdp = frame;
-
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
@@ -3897,6 +3923,29 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
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
@@ -3917,7 +3966,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	__netif_tx_lock(nq, cpu);
 
 	for (i = 0; i < num_frames; i++) {
-		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
+		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
 			break;
 		sent_frames++;
 	}
-- 
2.25.1


