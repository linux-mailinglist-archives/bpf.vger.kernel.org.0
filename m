Return-Path: <bpf+bounces-7429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F147770C2
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55115281E8C
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04946BC;
	Thu, 10 Aug 2023 06:52:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0821107;
	Thu, 10 Aug 2023 06:52:55 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBBDE69;
	Wed,  9 Aug 2023 23:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmdGZp41xGWmz87u4MewcySAlHcns7yxodI/vfBUUYqLZ2cQ6PdxrcjfNkNlEnkyJF9eyFXhxvrkArNEqoyBTk7ZWXQ4dgJkPAtYX0h3Y+1wxwDwt9lT01lItLKuCB5Qp9BBuB3ngjq5Yfw5EKaZzigXf2wJZG/+YCUa29BLxiALtbIvPOIme0E57lHg50+XZMcWYEWkFQAwqUipjwqFJaQU35g4itXiIelanuw89FcsU5phC895kp7yzbU+B6BgcFLYUFhkuHdJEkZAvaa3xHL/hEa/0Q6RN+8sLhCs/imD0X83vFRQ6DQtgnANbFuR3vQvYmuTjqV/ltQPnyVsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q850qGKycBEqMETvkLu4ATHh1dUJ0UI1oA4PSGUSPmk=;
 b=AWwrJ7XJMm9hLeDjPkwrUB65hTKlHR+CsiINiG45Ty43T5Ll149Wcb3ZVHEN+ug3xQ1kcOtoYZYbp1sho3J3SNbkweFSPwjBUXB8YK3EKYxRS5i4agQ+hiFv10ufptWP98AAQV1yf02oDqPQhDdbuDsIHTpfFpHyEwoifAnmXmyAbz+eQQTp+fbEwFbNuWnD67+v7V+eA3LBFRSMNRAJE4PQzeDJxhrmmwC2wZP3ND3kovoHQ18QY9DLMlS7rM3ETDcPhCSb1hnjAAo2tJ1G0L3HNeRziIddG2sJE5sdpfeo3L0hnt6iOt9ZGOocuKQ0M6cMHdiAtisTXEcegUgxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q850qGKycBEqMETvkLu4ATHh1dUJ0UI1oA4PSGUSPmk=;
 b=WZFPf0J6S2S0p1FdhE0/orHF0zsryCzG0zcyBNtUxOE/fjVa/tvHrI62KUDYRGBk0SZtI1ns38H5FkmRzAA23AH9ahHNZgXOQwlFqkmNm4iZb9ySMPQUGEaNbii2KKwccN2WoQ6Q+J1rdDE9X5xyd1AxDoI2NqaidDRvIc/CWyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB6PR04MB3141.eurprd04.prod.outlook.com (2603:10a6:6:c::21) by
 PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 06:52:51 +0000
Received: from DB6PR04MB3141.eurprd04.prod.outlook.com
 ([fe80::3203:2dba:b6f5:9104]) by DB6PR04MB3141.eurprd04.prod.outlook.com
 ([fe80::3203:2dba:b6f5:9104%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 06:52:51 +0000
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
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	jbrouer@redhat.com,
	netdev@vger.kernel.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH V5 net-next 2/2] net: fec: improve XDP_TX performance
Date: Thu, 10 Aug 2023 14:45:14 +0800
Message-Id: <20230810064514.104470-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810064514.104470-1-wei.fang@nxp.com>
References: <20230810064514.104470-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To DB6PR04MB3141.eurprd04.prod.outlook.com
 (2603:10a6:6:c::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR04MB3141:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: b632746b-2c16-4ebc-eb88-08db996e6971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n+ZolbiW3iooor5eFDLAZABpA9/CnyeDBsgx8LY+b/WZ+FaIicxYzMvmXYJbWGE15y1NZY/8b7djYMMfI7lLYok7rjOZU3mn8TpSV/OPhcKx6GrFM5Bg/PdMORlGS7bMcStEuHdnbmmPsXcOKocpQ0qCcRsdyhTnJgG97a4KosPHml/Fgaws5xgbxcq41uDk/B1aWO3uSr8Iaq09txM1FOfPe1mHiSxhJdnMv0GTUWT/lkROIUUIrazWmcc2mGasexnMHFctAUn+3Uz+rdcEogNobriVGqCd2ylp0RpxqYEpM74+irWdewfDmXjlBu0GHqd+wi18Cn8GhEcT6fAerD6VOazkG0bWBxfkJKwgdpeCr3Siwz8tRmexXd0LpUJFQNu50gyjPNWfBudvrFiRIH4lbjp81JTypN/rDpgXP1BrE8jan0xjVR/GcPa7Wtj5aQfqJARtuuuryr0nvAjmluy5rH2gywzEJvnNOSUYnpPoR1hQ/JfqaVTd43xpqp/X+Swt+0sCIZCrrLK5RNVUl2Y4JRn+ttcEMZPiIsSdkSl2tp+EbblsZARVBDRtiImpNBwvL9CbATr15GDfNeN32A9m1KAJ3dDslFGuF142VD7u1CqY+gBBTP8MFd4hTqZ2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3141.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(396003)(346002)(186006)(1800799006)(451199021)(36756003)(6666004)(478600001)(66946007)(26005)(66476007)(66556008)(1076003)(6506007)(6486002)(6512007)(4326008)(30864003)(2906002)(41300700001)(316002)(7416002)(44832011)(921005)(38100700002)(5660300002)(8936002)(38350700002)(8676002)(83380400001)(2616005)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrqyzB1gUAmPvCsuBeKKlmdW3VhEIzC4dL1EFiueVdninRM6seV37VcP76cR?=
 =?us-ascii?Q?WaVYj83HqABRSycGz1lNPHmVptrdGbWsp4rnXQB9YIoRsqvPvX3VRXbP79M4?=
 =?us-ascii?Q?B9qGfqdX8XFVcPFSzyyC7hEscoXA+6JJal2EPKtgpb9a/HvJlolQneziY+wY?=
 =?us-ascii?Q?YPYzEqKhFcJL/25rW1i6P7uQXbDJii2JWYOStLu6OkfH+iTHwOYfZd3TZ///?=
 =?us-ascii?Q?1Pf7wfTBAMRZwSXStXRAgi5nt4raTa3LgSJLhcx9cC8VneI07CFFFyjKmaV0?=
 =?us-ascii?Q?x6XER71lP+j/NA/8rGQ3f6FWrdpPLulmupWu2GWr44bzt2dqqRgqkTitxFpX?=
 =?us-ascii?Q?3Ym3mXcDvs+hbAdvNhBm6a+Husa/HVjL3gO1yIBfQS3vZ3bXWHVwtmM1V6Ql?=
 =?us-ascii?Q?TH4X8CjFeMx5xG0g2hnnBGNq3LduglwaYknuu9RR/Mu7X8dDfdXtTkHrqJC4?=
 =?us-ascii?Q?o4SQmA+LVnOzmTvo604RNioL0fJpvuiwiMgJWmwB6erao+OG1H6goAPjhW4K?=
 =?us-ascii?Q?2zrcbLAe/qCAwgrHsmghG1xD4amOapeJMiqjMNA6N1j3aTCuhoGC0PxUlBTs?=
 =?us-ascii?Q?sQ4iW6U3y17/6rdqXaoN4gJ6vomBw5LpBA9M08U75N8C6G2IfhBTUNcChFBu?=
 =?us-ascii?Q?6/QGLUu38xWoo8Q0n1GScBNILWsUcBVUKv9mcDJBr0OwxoveC/3dwumeoWvI?=
 =?us-ascii?Q?MgIz2pIonvQdNZ8mPd76kvIcqQhQMS+vXAv0ofPK8RcPRuGPSGIEPaxaX5qG?=
 =?us-ascii?Q?AkwadtrxuAOqODJv57eNhs/gqRQLoKr/Q5HoFpAjdV143QzvQLqCqVqQ81EC?=
 =?us-ascii?Q?T377aliCDpKycIlwMxqGZbE//X3elWCtVlMtOoW2sf3dTGXuR6E8OcdKUahB?=
 =?us-ascii?Q?3E6j5CydNEjfxS5Vup8rsZlqLdaf6stJLbUSYu/4uIiKRijhjeqZz5pXky6U?=
 =?us-ascii?Q?dswSKASogWnWsjslZ2pPtsC8e0ff1+z1PoBJjjgQLRUuuVWYw6jJbCBiVLh5?=
 =?us-ascii?Q?5dKUqqh3NmnwLf6vFbdsva8RvtT24m5HYrybYMStCwJgLxQTdIOxlahWbe7m?=
 =?us-ascii?Q?U/LYOLOp16HwQ/ubLF9NORebrEAf8TOKUUkmJLkNv4lhWmVgsXnNFQnBfUbF?=
 =?us-ascii?Q?FEQXXCov36Bn7pWYrnXThngmNDjgXimBVw/XDAmdFubbWvrJyrruITdLtJdJ?=
 =?us-ascii?Q?3KNL2PF6UVq5f1dQzuqY6Fqn5wqb3J3soXTdyDKr2CI9NjpzTxRlq6ICsUYi?=
 =?us-ascii?Q?m1AEjy/Qx2PnykqgLIbNYqGeWMLrM2gJvfvnPQ8X1SqZMXttYhrM2WqjQWpw?=
 =?us-ascii?Q?K920JEm1h6nxjHSmQiiYCGfZ8ZzGjDGD9YDPspEDSpLvD6a/glbX31fNdtYW?=
 =?us-ascii?Q?JLzDftCs5RRzZnrA0OpIKgn8+vtMY/I62Dih6HU+MWnVXFMeqCgHK/8WyOs5?=
 =?us-ascii?Q?UuLKqj95FLfZ9tQmvkFNx8lN+08KYwEStTR+itHZ5uQ524JAXsi0GIHUDtGQ?=
 =?us-ascii?Q?uuQRxOcNWvorIJxXTZN7Ym+zfoyHjoREitq4nI0LCCvZ2pmbZk0bXw+FA7QT?=
 =?us-ascii?Q?IarasZX9A8n6tcPOf0D6GRChsZT9pnHQxvbIPz/A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b632746b-2c16-4ebc-eb88-08db996e6971
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3141.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 06:52:51.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvgjD/LeBcyKh7DAK6UTbev49hkK/WSvLebexwvcEmPXJfXK8ORXqCSUUXo5Yfqha3SvxsFYD4tVCTmRsLFZDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As suggested by Jesper and Alexander, we can avoid converting xdp_buff
to xdp_frame in case of XDP_TX to save a bunch of CPU cycles, so that
we can further improve the XDP_TX performance.

Before this patch on i.MX8MP-EVK board, the performance shows as follows.
root@imx8mpevk:~# ./xdp2 eth0
proto 17:     353918 pkt/s
proto 17:     352923 pkt/s
proto 17:     353900 pkt/s
proto 17:     352672 pkt/s
proto 17:     353912 pkt/s
proto 17:     354219 pkt/s

After applying this patch, the performance is improved.
root@imx8mpevk:~# ./xdp2 eth0
proto 17:     369261 pkt/s
proto 17:     369267 pkt/s
proto 17:     369206 pkt/s
proto 17:     369214 pkt/s
proto 17:     369126 pkt/s
proto 17:     369272 pkt/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
V5 changes:
New patch. Separated from the first patch, to keep track of the changes
and improvements (suggested by Jesper).
---
 drivers/net/ethernet/freescale/fec.h      |   5 +-
 drivers/net/ethernet/freescale/fec_main.c | 134 ++++++++++++----------
 2 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7bb02a9da2a6..a8fbcada6b01 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -552,10 +552,7 @@ enum fec_txbuf_type {
 };
 
 struct fec_tx_buffer {
-	union {
-		struct sk_buff *skb;
-		struct xdp_frame *xdp;
-	};
+	void *buf_p;
 	enum fec_txbuf_type type;
 };
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 30b01985be7c..ae6e41ad71b8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -399,7 +399,7 @@ static void fec_dump(struct net_device *ndev)
 			fec16_to_cpu(bdp->cbd_sc),
 			fec32_to_cpu(bdp->cbd_bufaddr),
 			fec16_to_cpu(bdp->cbd_datlen),
-			txq->tx_buf[index].skb);
+			txq->tx_buf[index].buf_p);
 		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		index++;
 	} while (bdp != txq->bd.base);
@@ -656,7 +656,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 
 	index = fec_enet_get_bd_index(last_bdp, &txq->bd);
 	/* Save skb pointer */
-	txq->tx_buf[index].skb = skb;
+	txq->tx_buf[index].buf_p = skb;
 
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
@@ -862,7 +862,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	}
 
 	/* Save skb pointer */
-	txq->tx_buf[index].skb = skb;
+	txq->tx_buf[index].buf_p = skb;
 
 	skb_tx_timestamp(skb);
 	txq->bd.cur = bdp;
@@ -959,27 +959,27 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
-				if (txq->tx_buf[i].skb) {
-					dev_kfree_skb_any(txq->tx_buf[i].skb);
-					txq->tx_buf[i].skb = NULL;
-				}
-			} else {
-				if (bdp->cbd_bufaddr &&
-				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
+				if (txq->tx_buf[i].buf_p)
+					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
+			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				if (bdp->cbd_bufaddr)
 					dma_unmap_single(&fep->pdev->dev,
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
 
-				if (txq->tx_buf[i].xdp) {
-					xdp_return_frame(txq->tx_buf[i].xdp);
-					txq->tx_buf[i].xdp = NULL;
-				}
+				if (txq->tx_buf[i].buf_p)
+					xdp_return_frame(txq->tx_buf[i].buf_p);
+			} else {
+				struct page *page = txq->tx_buf[i].buf_p;
 
-				/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
+				if (page)
+					page_pool_put_page(page->pp, page, 0, false);
 			}
 
+			txq->tx_buf[i].buf_p = NULL;
+			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
+			txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
 			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		}
@@ -1386,6 +1386,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct netdev_queue *nq;
 	int	index = 0;
 	int	entries_free;
+	struct page *page;
+	int frame_len;
 
 	fep = netdev_priv(ndev);
 
@@ -1407,8 +1409,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 
 		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			skb = txq->tx_buf[index].skb;
-			txq->tx_buf[index].skb = NULL;
+			skb = txq->tx_buf[index].buf_p;
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 				dma_unmap_single(&fep->pdev->dev,
@@ -1427,18 +1428,24 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			if (unlikely(!budget))
 				break;
 
-			xdpf = txq->tx_buf[index].xdp;
-			if (bdp->cbd_bufaddr &&
-			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
+			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
+				xdpf = txq->tx_buf[index].buf_p;
+				if (bdp->cbd_bufaddr)
+					dma_unmap_single(&fep->pdev->dev,
+							 fec32_to_cpu(bdp->cbd_bufaddr),
+							 fec16_to_cpu(bdp->cbd_datlen),
+							 DMA_TO_DEVICE);
+			} else {
+				page = txq->tx_buf[index].buf_p;
+			}
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (unlikely(!xdpf)) {
+			if (unlikely(!txq->tx_buf[index].buf_p)) {
 				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
 				goto tx_buf_done;
 			}
+
+			frame_len = fec16_to_cpu(bdp->cbd_datlen);
 		}
 
 		/* Check for errors. */
@@ -1462,7 +1469,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
 				ndev->stats.tx_bytes += skb->len;
 			else
-				ndev->stats.tx_bytes += xdpf->len;
+				ndev->stats.tx_bytes += frame_len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1487,20 +1494,16 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			/* Free the sk buffer associated with this last transmit */
 			dev_kfree_skb_any(skb);
+		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
+			xdp_return_frame_rx_napi(xdpf);
 		} else {
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdp_return_frame_rx_napi(xdpf);
-			} else {
-				struct page *page = virt_to_head_page(xdpf->data);
-
-				page_pool_put_page(page->pp, page, 0, true);
-			}
-
-			txq->tx_buf[index].xdp = NULL;
-			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-			txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+			page_pool_put_page(page->pp, page, 0, true);
 		}
 
+		txq->tx_buf[index].buf_p = NULL;
+		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
+		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+
 tx_buf_done:
 		/* Make sure the update to bdp and tx_buf are performed
 		 * before dirty_tx
@@ -3230,7 +3233,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	unsigned int i;
-	struct sk_buff *skb;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
 	unsigned int q;
@@ -3255,18 +3257,23 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 
+			if (!txq->tx_buf[i].buf_p) {
+				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
+				continue;
+			}
+
 			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
-				skb = txq->tx_buf[i].skb;
-				txq->tx_buf[i].skb = NULL;
-				dev_kfree_skb(skb);
+				dev_kfree_skb(txq->tx_buf[i].buf_p);
+			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				xdp_return_frame(txq->tx_buf[i].buf_p);
 			} else {
-				if (txq->tx_buf[i].xdp) {
-					xdp_return_frame(txq->tx_buf[i].xdp);
-					txq->tx_buf[i].xdp = NULL;
-				}
+				struct page *page = txq->tx_buf[i].buf_p;
 
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
+				page_pool_put_page(page->pp, page, 0, false);
 			}
+
+			txq->tx_buf[i].buf_p = NULL;
+			txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
 		}
 	}
 }
@@ -3789,13 +3796,14 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
 
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
-				   struct xdp_frame *frame,
-				   u32 dma_sync_len, bool ndo_xmit)
+				   void *frame, u32 dma_sync_len,
+				   bool ndo_xmit)
 {
 	unsigned int index, status, estatus;
 	struct bufdesc *bdp;
 	dma_addr_t dma_addr;
 	int entries_free;
+	u16 frame_len;
 
 	entries_free = fec_enet_get_free_txdesc_num(txq);
 	if (entries_free < MAX_SKB_FRAGS + 1) {
@@ -3811,30 +3819,36 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	index = fec_enet_get_bd_index(bdp, &txq->bd);
 
 	if (ndo_xmit) {
-		dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
-					  frame->len, DMA_TO_DEVICE);
+		struct xdp_frame *xdpf = frame;
+
+		dma_addr = dma_map_single(&fep->pdev->dev, xdpf->data,
+					  xdpf->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(&fep->pdev->dev, dma_addr))
 			return -ENOMEM;
 
+		frame_len = xdpf->len;
+		txq->tx_buf[index].buf_p = xdpf;
 		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
 	} else {
-		struct page *page = virt_to_page(frame->data);
+		struct xdp_buff *xdpb = frame;
+		struct page *page;
 
-		dma_addr = page_pool_get_dma_addr(page) + sizeof(*frame) +
-			   frame->headroom;
+		page = virt_to_page(xdpb->data);
+		dma_addr = page_pool_get_dma_addr(page) +
+			   (xdpb->data - xdpb->data_hard_start);
 		dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
 					   dma_sync_len, DMA_BIDIRECTIONAL);
+		frame_len = xdpb->data_end - xdpb->data;
+		txq->tx_buf[index].buf_p = page;
 		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
 	}
 
-	txq->tx_buf[index].xdp = frame;
-
 	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
 	if (fep->bufdesc_ex)
 		estatus = BD_ENET_TX_INT;
 
 	bdp->cbd_bufaddr = cpu_to_fec32(dma_addr);
-	bdp->cbd_datlen = cpu_to_fec16(frame->len);
+	bdp->cbd_datlen = cpu_to_fec16(frame_len);
 
 	if (fep->bufdesc_ex) {
 		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
@@ -3875,14 +3889,10 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
 				u32 dma_sync_len)
 {
-	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
 	struct fec_enet_priv_tx_q *txq;
 	struct netdev_queue *nq;
 	int queue, ret;
 
-	if (unlikely(!xdpf))
-		return -EFAULT;
-
 	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
 	txq = fep->tx_queue[queue];
 	nq = netdev_get_tx_queue(fep->netdev, queue);
@@ -3891,7 +3901,7 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 
 	/* Avoid tx timeout as XDP shares the queue with kernel stack */
 	txq_trans_cond_update(nq);
-	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len, false);
+	ret = fec_enet_txq_xmit_frame(fep, txq, xdp, dma_sync_len, false);
 
 	__netif_tx_unlock(nq);
 
-- 
2.25.1


