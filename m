Return-Path: <bpf+bounces-6669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1676C32C
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3731C281B92
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894FEA5;
	Wed,  2 Aug 2023 02:55:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229AA3D;
	Wed,  2 Aug 2023 02:55:56 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E834911D;
	Tue,  1 Aug 2023 19:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU7kwchQ7m5NUJBQLUYuBjdwdPtqSWvhKSgpbouQCVKYk6JN+Uv/pNxio2b7iK8q2uBm2Q5ywgqEACWO8JmAvZrA4wiR/6jtT5Hnx7pDqW8pBG0Inu+YmT9xFsQSRrXGJr1amNjRuPCeBXHzyeKr5P/k/3zhKqkWA//mPXOU5sAOqlEpwcySgAQWJJJLexM453G5jfhxW1OX+KmUxN19tn6kT/DyxxMve5448pzEAaN8J7R9QCUjziKK1BnC2sWn6Y/YEeBFDAdKSjHlgqgV030X356zCWhsNGVH7gqz4nJ9JwiPMgNGg5ITLTYRJnCHZagVzLtKqX5MbXH1gCCWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7WaR13L1Ab7xt4VRyVdr5+WZtindxaly4GUZocf1Jc=;
 b=Oh2JJtSuetFINqqHdqNRlX7pXHmZpWaoS29//FDnpOvswhHeuv7UTDqcDEvnYXpX9gERvO+X2JkVkLog8eioV8Lppj8KqDHgmQ1OAJthkJ9V3bJ90cafoV1EWxqBMaeKlUKqjTHl7lJEqc/F3VHeF0yN87CY6ZjRf/yuVYKKkid7rmnPfcHNDd/ogzjRc2HQQItiBSluHmNT/1yu3dwJhY6TKXEKojnsNBbgl4A39y0lvW/GP1k508asQzDDD4h3J2BKH9ZQ/8y0nExprBy0THpEKIR7kJ9l4UAJ2VgIa7LL0OwD8hPsPjNAcrP9++LheDaf9oMhazDZOy34rKIFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7WaR13L1Ab7xt4VRyVdr5+WZtindxaly4GUZocf1Jc=;
 b=auzJv0UVf9tpTmW7JibmlxrXQ22uE92Z0JuoNzXOAnb3wHiBfRtUoI1Zz80SU+HCDBT47DOZmIuZzdnD2Uf6u6saUuTffnXYHjCcFX6juAb2JmuqLBQRuVdtL0+0veRA9daacagxu6m4FCNK0gxd2IpzbQzu0VjKTEW4GKdZKQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 2 Aug
 2023 02:55:51 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 02:55:51 +0000
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
	netdev@vger.kernel.org,
	larysa.zaremba@intel.com
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH V4 net-next] net: fec: add XDP_TX feature support
Date: Wed,  2 Aug 2023 10:48:57 +0800
Message-Id: <20230802024857.3153756-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|PAXPR04MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 36626516-e642-4260-442a-08db9303faf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5gjEqDNaqX51UsdCZXBXXJ0qTL5PJNf6GRHstyDRHqoV/ejXKpZZhIPBzuMr9YKGEjf3OPj4t6HQGOzNqUWbxHawycm+eezbA+gBhe3JEBhH+3260f0Oy9x7V7d10jqtW9obWUnezhSf+8mR61ltjee1QYHFlWkExr+Xm/J+7q3j+KkEVuUqn3npB6nscH9E+vdgt3+Akm06OFxSquHI8U3F5ydza1C7s7ZQk+FckRytuv9Xz9D9gAf18ZNbFV4FBWgxNJnq/gMieBplJ0HfAW+T1fqY2LW2rLeBytyxvc/vYIAcqFd9DHe5U6/uh4wII/7CjlsdABRT7B60MzhBu3pHDiHN4uy/eBj5+B5WoxUL1YgnA/c9EJDjMGLXFFokOE7tgO7P4xOAvbK2wlTrMpda+Yj/KIp21nIf2ueiNnx9cdZOBV+l69ZM9k1eRw2eLHkvYDXFq75C3xqisXksJeC3PHbVDon0U8eoyUCJsckN4l6jtWHZ5s4vxLz+HilAKQ3MP/dsVu1VIS13VrfTT46J18RAL5PIG7SYPrFFeeAFmILkuOYv4G+DHN8IuMvZixju6X/LEHCEPzJ8Mz/ZIG2AUJV6VSGP0mdAdb3y3T3A9trIG7r3MGlF1qa3RiAA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(316002)(2906002)(2616005)(83380400001)(4326008)(66556008)(66476007)(66946007)(966005)(52116002)(6512007)(6486002)(41300700001)(8676002)(478600001)(36756003)(86362001)(921005)(38100700002)(186003)(7416002)(38350700002)(44832011)(6506007)(8936002)(26005)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WKt9n6+7oV6XlFsuKrbTfUEXYnlk14whCiXtAgcMuiBaGcrjbtKtPGGPH3/L?=
 =?us-ascii?Q?XmTryaVIqId6HVAJFn3k8xY04ZsjmX/DUIeJ4fi8bpW4Lz+O2C/AKS3wuDc0?=
 =?us-ascii?Q?Neass0MNaDt9PM/IBAD5k5Old3X4GBQdMSntQQkOWLy/0985DyWWuIvdQqPw?=
 =?us-ascii?Q?w/3om2fuSX0LEr942VBpUq0ssWCy5wVSEsuHoJsINCf18SSavWBxp2IVH2fQ?=
 =?us-ascii?Q?iADUoyl4qYdS2mpD8YW8cxmKz1DE2XOWc5ZTW5tOelYJuo3pxYZHyjvZKWHb?=
 =?us-ascii?Q?jno30CcT4alfRJvF0jbR5v1qSmKP17zA1M3JcR/JETn/emR7LfDguELhwoN7?=
 =?us-ascii?Q?aBroVl2mZZnIls6Ufz2kIPAZbi4b8bFEqkGHUH9R6O3PqEyD74h8SYGy57Ka?=
 =?us-ascii?Q?mCY6UAOyaBJf0leNoC+jc2cFhbjojGwfoV6nQlYxaKzmGqerKvg4pseiijRs?=
 =?us-ascii?Q?0SeD3ulFXnbQiDo0pdmQd/451pjpaIo7FdgqeRdXvz9KwRZcmPH5EbxU74OP?=
 =?us-ascii?Q?tUmDt2IVkFpjUlyFqwe5yb18g2gl4ghIk5MULkKZBMlg94Id7RjP/hNh1On3?=
 =?us-ascii?Q?MHCEQE4EUxRifk6fJDrcylEqlMTK4rrw9CC5TUUJATItF8eMri6n/rha8m3D?=
 =?us-ascii?Q?CK7sVZSi5uNmwP+tJ529OerdLpvs4mziWJG6yD4znijF6nSaT5j9U2rx4V92?=
 =?us-ascii?Q?fLutohlJ7S5Xzmjzl+FhT1w9oI2WBcQKa/vtRyhuzFv3xTmBrRcUzWAyu/28?=
 =?us-ascii?Q?B0q4Q1ucvmwR1AjVUgM30+hZWGhHuV5RP0xm+ebqVlo71uYBiapyySPLwCwB?=
 =?us-ascii?Q?HcetvYhLBMXVSeywBNZiBAJf9TchoUboiEv5U2Pnw3nCOzU47uuEU+Zxn/SS?=
 =?us-ascii?Q?kNLtNomZOAof7gkCm6vFmNUmsJXlJHOfj0F4EzkWY5EDMM6JGxo21utkIuL8?=
 =?us-ascii?Q?IZXeCPJy8ySfcT95Fv1iRJOmuhL+pJ9cf9zN1Hn1jHQqSiqPtorpvPFLEi6S?=
 =?us-ascii?Q?d1wi09JVKe/xIeMgL+b4aBl1kFIhah5iUo0VpGaGzGbstz9qS0NLU3abw/H0?=
 =?us-ascii?Q?FgUkjcEQv68VNapOEF4R+iDz3Fj0gzbPpMkZRY2UQYu1XkRB8hbCEChArKXX?=
 =?us-ascii?Q?JgDYZdqIcj5tmOkQC+c7xLxW3lfy8yBlPxg9dMxJFTOmbL47x4y3nKL+NTsr?=
 =?us-ascii?Q?8OjKVu2JUFIaGuM7iHFinuf+a3r+V+WTdL/RcYivs+Bw9ieH7Mn4/4Svp2z+?=
 =?us-ascii?Q?FojLsXKd0HNjAkgRHYX4QO357QFMcIpz8xLjkSoZYIiZOdF8eC3aa4NHkjlF?=
 =?us-ascii?Q?gbzBl2LWKVcmVi90UXzy3nK8VO55KSyKx3V/LhAq0xTFOB09zYdzyEeqpiOX?=
 =?us-ascii?Q?avVCTr0udsG3T/zyf802kK5RmDwzwLQzZWamMUHuCMszx87E5uiDvxQG3jKZ?=
 =?us-ascii?Q?PNGBaJs3dOpTjS2CvlPpIfMe6hOT9ie8r+PQpOpIWO3Vq8KX3np+3/m7aaXm?=
 =?us-ascii?Q?zYwXzCKcdDh2HfTEfOqMkTidPAGblcfT6ULeIH239f6tqyljgDd0eFOsKykh?=
 =?us-ascii?Q?ruf7uLaUgy7rvaxmz052uJzw6HIqXHFNOY5S2FOd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36626516-e642-4260-442a-08db9303faf7
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 02:55:50.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO0t2It18Q+ecCOT/4mXViLxG2sJp2vdmBgzxzkxwgq+JlhI4UgxzelTB1fmMPLi43JGqOkxQmFZoCb/5bpIqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
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

V4 changes:
1. Based on Jakub's comments, add trace_xdp_exception() for the
error path of XDP_TX.
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 82 ++++++++++++++++++-----
 2 files changed, 67 insertions(+), 16 deletions(-)

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
index 14d0dc7ba3c9..c8484ef090e1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -68,6 +68,7 @@
 #include <soc/imx/cpuidle.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 
 #include <asm/cacheflush.h>
 
@@ -75,6 +76,8 @@
 
 static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
+static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
+				struct xdp_buff *xdp);
 
 #define DRIVER_NAME	"fec"
 
@@ -960,7 +963,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 					txq->tx_buf[i].skb = NULL;
 				}
 			} else {
-				if (bdp->cbd_bufaddr)
+				if (bdp->cbd_bufaddr &&
+				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
 					dma_unmap_single(&fep->pdev->dev,
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
@@ -1423,7 +1427,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				break;
 
 			xdpf = txq->tx_buf[index].xdp;
-			if (bdp->cbd_bufaddr)
+			if (bdp->cbd_bufaddr &&
+			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
@@ -1482,7 +1487,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			/* Free the sk buffer associated with this last transmit */
 			dev_kfree_skb_any(skb);
 		} else {
-			xdp_return_frame(xdpf);
+			xdp_return_frame_rx_napi(xdpf);
 
 			txq->tx_buf[index].xdp = NULL;
 			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
@@ -1573,11 +1578,19 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
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
+			trace_xdp_exception(fep->netdev, prog, act);
+		} else {
+			ret = FEC_ENET_XDP_TX;
+		}
+		break;
+
+	default:
 		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
 		fallthrough;
 
@@ -3793,7 +3806,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
 
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
-				   struct xdp_frame *frame)
+				   struct xdp_frame *frame,
+				   bool ndo_xmit)
 {
 	unsigned int index, status, estatus;
 	struct bufdesc *bdp;
@@ -3813,10 +3827,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
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
@@ -3835,9 +3863,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		ebdp->cbd_esc = cpu_to_fec32(estatus);
 	}
 
-	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
-	txq->tx_buf[index].xdp = frame;
-
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
@@ -3863,6 +3888,31 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
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
@@ -3885,7 +3935,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
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


