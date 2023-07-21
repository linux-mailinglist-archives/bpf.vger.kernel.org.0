Return-Path: <bpf+bounces-5581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F675BEDC
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 08:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C874F2821B2
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB3F20E3;
	Fri, 21 Jul 2023 06:28:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A810FC;
	Fri, 21 Jul 2023 06:28:56 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A739330E7;
	Thu, 20 Jul 2023 23:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkhFGa/xjxjVG/TCSPZmgx3uQZ5fyBCdIFOfZP+IvYO1q/vWYsLRun4VMu3uOmeThHn68ZnzmXKrK23ExI+uiJYHk7qPd/ksRbmIYX3FacdIwb+fKmns3lnF5c4AtsBw1sCq+BYW/BAbmajs43Y6IElvr057O9Z38ZhQ4VaAZAAjp8mk7Guh2oLBI1Rd4oRNo00HFpyJUH3/eA6DT5UD/wDjWEpCfTrlnJg5uW2ugkVPeZapo9orcQ0RONcvXaBWnoZ44EkGWxA7ht7+cnDWNZtDdEAF1T1yS9hrewZhX0ofxJVZPDvZ48Rl9OTlH2BD8uenN5ncP3pmXzprjff/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHQBNIBKNifFE8ModVELoKeB3NDGWe3ccMDRpAJERNI=;
 b=PXRVbP859r5cYpsZMgI5SJU6IZ5rXwtrNBArmZQyRleI6+KlBvB4/znr5tbR1JhwsIdnVAXrgWiihjH8bECC6OB3YQwOz/Dsok+y6MeISsB6H6udzGafipCRVdmyfRUNaUVExDXtDBxKiwmTR7H7+yVnzTnCp4GrjDGuIPjMOKG6BhrANPQXuLvbUzyYIPUUXAIdmNcfMZsAYiJtUDic4FPFp95aZ5PxUPXFHjZF61CgHtsDnxv5nuaR2JNgZ6kLXfjvoj6rWS7ppR1u3vQvmfhL51b/qbLyI3TuOMOwaI/5zZkp2/7PihX4ElC8JHvvfcInCSmNkT9x13wK1qXaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHQBNIBKNifFE8ModVELoKeB3NDGWe3ccMDRpAJERNI=;
 b=m3gYbcJxYQP/Q6dwdX1305m8pMGeGTDqD9yRyv47Sj+4SapDWAdrU4CRxsofIIYJ9DRGr94sR5AzRarBHVqlUjqcubEwG+dFBoldaDS39/iL15Uxe8gn5KHz5HUsnTntKzijBveIpKZ9pUref/NWEkBM45xdnAKOf4lj2KPLoU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB8072.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 06:28:48 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 06:28:48 +0000
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
Subject: [PATCH V2 net-next] net: fec: add XDP_TX feature support
Date: Fri, 21 Jul 2023 14:21:53 +0800
Message-Id: <20230721062153.2769871-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS8PR04MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5e7a10-55e7-4afa-ff2e-08db89b3be17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pHszNJ4NPd3B2OqMAgU5HoLHJX/V0RuTfwQLuJKEMOGW2ACzNGjabgzesSh2hYIjFUOFagdu3QTRUiqPjvYPuXSvDfqk4iRkIa0HZz62NLDSewfAYjh6n/zsbmAbc2IR/pdnkzYn8cGU/vziiWjsc1uWvsQT+Nb68ucuBF8ROyCyYzWvulm2am/h9Dl724kU2Qf09KlWc7W7Ftvxr0zFsKWju/oN2mY1UboiLH99jBA8krFUjV9/2l4bOCHf9T+7fkZJWFbjM41Z/Hr9Byn48sKRdjeqPjOcDODWun8SY/J/TuJfgLY63HcTyA0kgO62c48Bsw/bm0UevKlqVeNjOZrnbX1QUCuaCG/UPxNJ9DV5F0pXo+ZKbysyGEExdwx2s8FAR2zxFpyczz/K/0pN7ILF3jetxC0aIsZkHafEMInG/9xvECkQAGNRuznqakIyhlvjQRQkdElhWgXvbSoWYjCJRE5YPxqXnlRrwrn+JspujFLllgT4/FQOpZ5HxnyIh7VfjhaijUAdXKabaBwOxXtcjqRaGI3slPZfX0Xg5UdDCDa6idkyUZEbh5w/jOptEPbl4Dm4SKbMa8sMBCQz0FJHqXKB+9zj7aX55c1qlHNLx/mh5vXfhmkvHKlYSnwK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(6506007)(26005)(186003)(1076003)(41300700001)(5660300002)(36756003)(316002)(4326008)(66476007)(66556008)(66946007)(478600001)(44832011)(8936002)(8676002)(7416002)(38350700002)(38100700002)(52116002)(6666004)(966005)(6486002)(6512007)(86362001)(83380400001)(2906002)(2616005)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxriO++9spf1mDBjbtPX+UCgiAnf0FuY/Yny0kncTN2zHctPIMJsGQ56+rtq?=
 =?us-ascii?Q?ceQxmiV3ecCvOP9jJjNMJYmUnT1WdbwAlBd22zGdLrS4lBQxzaVLckbueaOi?=
 =?us-ascii?Q?WMM72dWvv1H3lveNBEDcdhjo7g72Os3viqs0OZwATphRVLwzxOFKRf54kyUX?=
 =?us-ascii?Q?oOkkeSBUUvYl5PHjqAXUoRhDuaKzlOTyNolNPJWtp49UyJgGN0RvsUmWtE6o?=
 =?us-ascii?Q?/dTrKoD9XsFOjGBIFwJSkJ99MvDt/1yZMRX5C05lxGl7ie8I3opzV5fnBs7x?=
 =?us-ascii?Q?Vh3PqNbRrnCJMq5/Aw3Ra0PFGpaF7Ko5uJAKu3bK4xGUO17mFMXiT0thn+wd?=
 =?us-ascii?Q?qd9LKIp8KAyvEDvXcH9jM91EPn4ri3s2/256ihnxI5LM6V3JIxYera4ZUGbz?=
 =?us-ascii?Q?HexBsYL50NpiiyVzddwsbA5XFAFmGSquhYBEPI4deBMJF+Ypzy7orxs17TJG?=
 =?us-ascii?Q?doAalrkXGFAzWcRS647PCZU7wjtWJfEJXEstTp/fBzPLTH0z6ZmO13FFjrjP?=
 =?us-ascii?Q?7xy/sF0Xot2gDu7nTLjC2ima4I/2YgBOCWp3I8A5gtoBt3dQs/edVX+EoCGo?=
 =?us-ascii?Q?cp4UqSVkG9b3WiKL0P6FQbKcY9t0dYYu6lQCnaLibgAbXUvzZLeVXiq/0T4D?=
 =?us-ascii?Q?eWrhJogP0zLU5jiK9jp0xhCrikFTI+sdPrVKHIip3rfJWAbvGdB9PMBs0qUk?=
 =?us-ascii?Q?yOUGYAhM/iG0RCkbtWjKR1VtfuxXDBQ7GvzreFm3k+AoYqi6+gmJoYYQwpdW?=
 =?us-ascii?Q?n5e022FqhCQEv46CalhWgrzShXb/sBI0FirjJMsWj/Sgg+895kCBIrphXN5J?=
 =?us-ascii?Q?6t51IBbXhWlNYrKlIw48+WUyJ0lMrI5zSEadaO1eXN3e3MsDw0IkhDDD+2qH?=
 =?us-ascii?Q?YwnDqhfI5CMmYcGcNS6hGRHY9s7QYW9ZdI82ighb+8dtmSxwQpXIY1/MqjxT?=
 =?us-ascii?Q?6SXF2yJArHpLnHvfOJeH6AEO0lksRCa2VKPLME18zIgfo040dB4b05tWwnEo?=
 =?us-ascii?Q?1IZPHkzA/6ZUJwknZv0OKMd92XDl4Jb1obZXru0BLp8k9+T06pQNKORrjgHN?=
 =?us-ascii?Q?g+wEpCkhzYxPMQdtpjQ6klRkxZxpbY+d4a8co4fEbf0mAtpZsjh1Q9MkKQ25?=
 =?us-ascii?Q?v3b7zyIv10nqlrSpXLJ61Y7K5jofig0HMwoaPQl/95BQ7bHh3uNd/JlJR9bQ?=
 =?us-ascii?Q?wEMYAssgKYc5dp+Dlz8WeegAmlvK5EyOjqcFpjla8X2RxzQYpghlDCWfEHQ3?=
 =?us-ascii?Q?m/QBucSRnPI2b+0SN4oNdPvh0RhWRtjYsHCD8rxU1u4+x3t7BS/Y0f4tCt1z?=
 =?us-ascii?Q?Jn7sORmoHX7EBWdFy8kkQXF9H0sCnPHGCBoKmZgYxP32f9ru+OjOBnGEMa3M?=
 =?us-ascii?Q?+DmXR6oLF02dNwO4MypLbFM7pFn7niHLsIqHSowhVOFXo9lvZ9Yx7TFBn3wp?=
 =?us-ascii?Q?05ag+uSYwKuuHgeFvseapAmDRW/jdaBbTF3lyZetP6Zr+tfdTn+Yz2qCFqnS?=
 =?us-ascii?Q?0wgLhMIY6ldQ8srZn/qswDuVCIPREwcoxe6kEUDVGWz4mF+jFeDOpgneVUIZ?=
 =?us-ascii?Q?ufj5SIKvY+K+Ml48kaDHR5Ca0D9V9BB5qGNF6ziN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5e7a10-55e7-4afa-ff2e-08db89b3be17
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 06:28:48.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuDjtBueGDJdWVnNFUQtOGj5dxZKqk1Idlq/lulU1IQaUcDFB25rVXuYbIZSdwsh+D890EOJtxHoeuLhmzPTKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The XDP_TX feature is not supported before, and all the frames
which are deemed to do XDP_TX action actually do the XDP_DROP
action. So this patch adds the XDP_TX support to FEC driver.

According to Jakub's suggestions, the V2 patch adds two changes,
one is calling txq_trans_cond_update() in fec_enet_xdp_tx_xmit()
to avoid tx timeout, because XDP shares the queues with kernel
stack (slow path). The other is that tx processing cannot call
any XDP (or page pool) APIs if the "budget" is 0, please refer
to [1] for more details.

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

[1] https://lore.kernel.org/netdev/20230720161323.2025379-1-kuba@kernel.org/T/

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
According to Jakub's comments, the V2 patch adds two changes.
1. Call txq_trans_cond_update() in fec_enet_xdp_tx_xmit() to avoid
tx timeout as XDP shares the queues with kernel stack.
2. Tx processing shouldn't call any XDP (or page pool) APIs if the
"budget" is 0.
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 99 ++++++++++++++++++-----
 2 files changed, 80 insertions(+), 20 deletions(-)

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
index 03ac7690b5c4..7f3471b1f658 100644
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
@@ -1370,7 +1373,7 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 }
 
 static void
-fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
+fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 {
 	struct	fec_enet_private *fep;
 	struct xdp_frame *xdpf;
@@ -1414,8 +1417,17 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 			if (!skb)
 				goto tx_buf_done;
 		} else {
+			/* Tx processing cannot call any XDP (or page pool) APIs if
+			 * the "budget" is 0. Because NAPI is called with budget of
+			 * 0 (such as netpoll) indicates we may be in an IRQ context,
+			 * however, we can't use the page pool from IRQ context.
+			 */
+			if (unlikely(!budget))
+				break;
+
 			xdpf = txq->tx_buf[index].xdp;
-			if (bdp->cbd_bufaddr)
+			if (bdp->cbd_bufaddr &&
+			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
@@ -1474,7 +1486,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
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
@@ -1506,14 +1521,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 		writel(0, txq->bd.reg_desc_active);
 }
 
-static void fec_enet_tx(struct net_device *ndev)
+static void fec_enet_tx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int i;
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(ndev, i);
+		fec_enet_tx_queue(ndev, i, budget);
 }
 
 static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
@@ -1565,11 +1580,18 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
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
 
@@ -1856,7 +1878,7 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 
 	do {
 		done += fec_enet_rx(ndev, budget - done);
-		fec_enet_tx(ndev);
+		fec_enet_tx(ndev, budget);
 	} while ((done < budget) && fec_enet_collect_events(fep));
 
 	if (done < budget) {
@@ -3785,7 +3807,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
 
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
-				   struct xdp_frame *frame)
+				   struct xdp_frame *frame,
+				   bool ndo_xmit)
 {
 	unsigned int index, status, estatus;
 	struct bufdesc *bdp;
@@ -3805,10 +3828,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
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
@@ -3827,9 +3864,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		ebdp->cbd_esc = cpu_to_fec32(estatus);
 	}
 
-	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
-	txq->tx_buf[index].xdp = frame;
-
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
@@ -3855,6 +3889,31 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
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
@@ -3875,7 +3934,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	__netif_tx_lock(nq, cpu);
 
 	for (i = 0; i < num_frames; i++) {
-		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
+		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
 			break;
 		sent_frames++;
 	}
-- 
2.25.1


