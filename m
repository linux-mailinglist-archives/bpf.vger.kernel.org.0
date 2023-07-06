Return-Path: <bpf+bounces-4196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CAD749745
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43A51C20CF8
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A2539B;
	Thu,  6 Jul 2023 08:16:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664B13064;
	Thu,  6 Jul 2023 08:16:59 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2075.outbound.protection.outlook.com [40.107.15.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6AF1BEB;
	Thu,  6 Jul 2023 01:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdduhFNOoaYdYL4RnnsrUOR2zM2E8hPLvQxc248HsFSj0t5oWx236sGZDhjABALYQThGuU9ZjsXTNBLBqUNjhRlMj1UFO/04m6tElUHlxPQWQXAIfl5etKo+GWhjQDeFn+bTgu+DYL69e+4XDS4kaaplCccafy+YArKWfJCSrRK45Nf4XxtRrPhztWcIc6nAchJQJhqQQd+luGhAEDg5pReqG+xx34NkzP5DUjh1/gZ588DsxSOz/jg0gt9+R3Ckono5wZVKCn6iv48w7B9c9zP/kE1+WlH2GYHyZ4i3RJy7aG/mkkCJAxJZQpEHV9XkFgqyyatPqx7K6xum6vsVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALHnrNUVR0r6vkOh6Qg2LeUMUThQ/qrbFVs+hSXhMBQ=;
 b=A3k/GQETsIXK7WE806RarBYgCCAfx7EpXrwqudlUYvvYfMdI9JfBgatdVnoypoBzPIOlDy/9dSbIRDwX3QPF32NPEI8IRhwYeAuggwPkvCZaQWCDCD3CDOxCOhxbpG8mWegxozTLT7rnxiVcucmQfsLDgeYiQ1lbgRMl3akk0MTLRcPip7/lqplvXJUcMSo87pF+RrKPSC+pgKQoUCG8vG2E0nirqEL6WBjJq5LwPEzG4XQT5qjL5EJZltK8W0rtS1h/2OGx+wB6zsEDqPIpC9GyL8iBmtXOhhHhBl+L6C8zByp7kYG62sQn1vYIOO5A82XYxNWc/hjr+7MqA6yIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALHnrNUVR0r6vkOh6Qg2LeUMUThQ/qrbFVs+hSXhMBQ=;
 b=jPKl58/j0haALTYorvkdBD+JfTs6WBrOW8vx18WeONvFLSHDxnv3wjqp7NJe1kAnxx+SKJE5FuhJAOOmEfBNA7wKparIVo/2ww0fLnkRHD5/asu6Ni9GkkpbIpDOCHMJiwuUF947cqwozX0+Y+KLgcvKYYyvaduNFod4ItEiwRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:16:55 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 08:16:55 +0000
From: wei.fang@nxp.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	netdev@vger.kernel.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH V2 net 2/4] net: fec: recycle pages for transmitted XDP frames
Date: Thu,  6 Jul 2023 16:10:10 +0800
Message-Id: <20230706081012.2278063-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230706081012.2278063-1-wei.fang@nxp.com>
References: <20230706081012.2278063-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fb4d4f-cf03-4017-5f70-08db7df95c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4OlyeJtU/PHVKS0waF9+3lF29WXkUH25vH22nhSDc47v5q7A3OX7Fa3IwaCNvZhukxyRdk0ku0hddbLv8boIzYACmxp9E40Zi44XA7v8c+m69nr+0bMW4Q3rJZmOVg/pv3yNet5DmVn8PTfbcW0ld4cadcgTPdssDDWnFT5AjZf1Ig5n9PRmsoRu/TCaxWHBIN+nBxwF4p6PV/UoLCd/CZWNm/2+wgcHz71vrcc0I/KUkJ3ENuK+CsXRc6Eu7LlmD+bVaTZGeR6VfF5jHgeWZmTdiWgE3uMc5V19dzv1W6KAleTz+xQTUk0obZe36cipz83/kZvnT1exWAPP3hPP1jQAEiNzG4oRfYqGGWh51yfz9uUDWmmnv08TGJz+99ESL5G5a/hCgWTxIdjnuezReqrPVuOcxmcm11FHgkCXb/ND91R52ngGtRb6Ai3Klm1+Fme4r9YfyAK1zSXCszaGd18IYZZWDYpqXrYaViZxMIwKtwpmNhMLBQZGBfBTmbUs6SThuHEey+BB1eI+54Vp80ASH1bh+RStHWIRkoT4Err5hnLacKzgajDibicftqPnOTtxxybQs3xR78RL8hs6Gyg9lLhv0XBzMZT5yIodhnPJvCjpBHopjAnH4y2C2oHLWXbFegdRDqy2bxAI3fr/ZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(186003)(8676002)(8936002)(6506007)(26005)(2616005)(2906002)(66946007)(1076003)(5660300002)(7416002)(41300700001)(36756003)(921005)(6486002)(4326008)(316002)(66476007)(83380400001)(6666004)(66556008)(6512007)(478600001)(9686003)(52116002)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0AC6w4k/JnzsKCYyEG4m16U5620k0zXSha2LaQi2CUTzxwH74ABWTyfhQTK7?=
 =?us-ascii?Q?qiL4/AAhuDQmxiWmJuuxlIZHGjAhtOw9kWl1CF5jgA4+AK4i6MLkbw6prwCH?=
 =?us-ascii?Q?/P6o/VG+5xwBg0ltH/HbbzC/Fz2bMbqD714G+NzuczqjSIVj1R3FeqFLZYwp?=
 =?us-ascii?Q?cFEMbl5nGXsm5cMy9Ky2aVaTO7QmtQvK86Nq+0J0jiJxd3aIl+95Txw+hGf1?=
 =?us-ascii?Q?YdLQzRZ8gFEoMg1cXwIlYVmxj7YvFwZIM/GHbLc2hD5XrXNPeYDsa63qW+CF?=
 =?us-ascii?Q?5rjDOE5VPDrjnDfqrAnIfiUpmKidAQdN7LZXVYkTVB+5YnjCpk4aHIAsPSur?=
 =?us-ascii?Q?wJBXH4ndkkKC8YExDV1XHreNXXfNHKkltZRklZfvNSSWm3gk9j0q+DrlDQAI?=
 =?us-ascii?Q?TdZQda/XB3x47rMkKEMmhQ4RVrZg+7lX0nKWHfxzSUw/81KFc9x6JExSFoS2?=
 =?us-ascii?Q?eIScVIgIMF9JUJhYnusIcwtGN1ECuFq9RXIhfqnQ6gFmBqM1we8m4OJ5r5HD?=
 =?us-ascii?Q?chMwWwgPCllu9GcmHo62rIM+G8DIZo45i0E3dPYsQbajE/VWmPwcbbC+2B4Z?=
 =?us-ascii?Q?zitA/aI172+4AqDkJ6TrZiYnaPaPHsMeigmHao+NQS5QC/gKMBo/S1onE/v+?=
 =?us-ascii?Q?USuLVo6WQ7Qe8I5Ks8xCL3k6p45dL69q8kZ6Dk56Ds8PQtbf4XTut+JPaPsT?=
 =?us-ascii?Q?X1iGXBS0l1Y2cvj60qeswKK9PC48iyD8eNvR/t/hJCZzkyHDB3vC2GtoOYcZ?=
 =?us-ascii?Q?otj8d1XnKoHXBmnSHBaiSrg9z7Q9TvBxn85VPmZhOb/EvE9RJRa3ud4oKssO?=
 =?us-ascii?Q?Km8u/0J6Sh9G8OIE09Xj563Ny5s2U+VUjg26AP3rYV+Ptb7V4Tkzs+Mza3OM?=
 =?us-ascii?Q?4Xq7BhDMvZYfwSFByH4uXHhVBadYaHDBlUK56urPF1wKNYJn5jtu3cZh6uE0?=
 =?us-ascii?Q?4/6wf/b7NkeqQnu59Ms5AaATB9NwnpZNhxUJq5UM1AKyVPi0WmK0kw8yNwG0?=
 =?us-ascii?Q?rr4b2KjWgOnDz18yqnBM5pOEpHGXhPt15iOajv6Pbxn1xmki8B2KYl6xDC69?=
 =?us-ascii?Q?tqvoI1ss+rvsWJAL9XTmeyuayvSAy9tSbNeVILuhCVdyPf5E/6FdFP9/7LUj?=
 =?us-ascii?Q?p/SZYcZMWN1CQ+ZzLFEDJ7mpzm9Y0QztNrXvlU/3oZmKRg3wuwb4mVx3BYcm?=
 =?us-ascii?Q?wcIXogm+ngvEnUg/4vc1fxaLscAbB2cAR5jP4J2Yi385llEbWq6PBV1XiuCQ?=
 =?us-ascii?Q?uhv+x+7sefyireRC6KT9BUC7UDn5oe0hVMmPCVw1H+u/YXQVR/QmlkiT2XdV?=
 =?us-ascii?Q?XVllD5WR9KVWHjlzPYB+nDbYBO027SzV9KXfGLGVLEF8W6e2dM8KzmhEzuAs?=
 =?us-ascii?Q?ymfPXAuWkPF4LRYOrhPxfccP8m3YyE9kSKV2GOwV1LvNc5qJjxAYhJLIB8N8?=
 =?us-ascii?Q?ucEsRt4XfJfTDr20riIxBsnq2ns2hAe51+xs/ldkZMd6Yh7zxcEk90jJ3AQj?=
 =?us-ascii?Q?AB26RzrodO7acEaRwSYEz2sQJrBRTM2dyN0S7QW6fAfXXpwnF0rfwsQ3y/J+?=
 =?us-ascii?Q?DGGJbj1NzlgE+ZCkwfhuLyuQbQzg00NcEwjGXB6O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fb4d4f-cf03-4017-5f70-08db7df95c14
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:16:55.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYiU2CuJ2f2Y7j8jxBoUzWxcCj7sESj2wXquN1uAFbiVNtQhqU9w2HZdM1sVuSLJaLk/CAx8xPfx2GwTG0AAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>

Once the XDP frames have been successfully transmitted through the
ndo_xdp_xmit() interface, it's the driver responsibility to free
the frames so that the page_pool can recycle the pages and reuse
them. However, this action is not implemented in the fec driver.
This leads to a user-visible problem that the console will print
the following warning log.

[  157.568851] page_pool_release_retry() stalled pool shutdown 1389 inflight 60 sec
[  217.983446] page_pool_release_retry() stalled pool shutdown 1389 inflight 120 sec
[  278.399006] page_pool_release_retry() stalled pool shutdown 1389 inflight 181 sec
[  338.812885] page_pool_release_retry() stalled pool shutdown 1389 inflight 241 sec
[  399.226946] page_pool_release_retry() stalled pool shutdown 1389 inflight 302 sec

Therefore, to solve this issue, we free XDP frames via xdp_return_frame()
while cleaning the tx BD ring.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 change:
No change.
---
 drivers/net/ethernet/freescale/fec.h      |  15 ++-
 drivers/net/ethernet/freescale/fec_main.c | 148 +++++++++++++++-------
 2 files changed, 115 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 9939ccafb556..8c0226d061fe 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -544,10 +544,23 @@ enum {
 	XDP_STATS_TOTAL,
 };
 
+enum fec_txbuf_type {
+	FEC_TXBUF_T_SKB,
+	FEC_TXBUF_T_XDP_NDO,
+};
+
+struct fec_tx_buffer {
+	union {
+		struct sk_buff *skb;
+		struct xdp_frame *xdp;
+	};
+	enum fec_txbuf_type type;
+};
+
 struct fec_enet_priv_tx_q {
 	struct bufdesc_prop bd;
 	unsigned char *tx_bounce[TX_RING_SIZE];
-	struct  sk_buff *tx_skbuff[TX_RING_SIZE];
+	struct fec_tx_buffer tx_buf[TX_RING_SIZE];
 
 	unsigned short tx_stop_threshold;
 	unsigned short tx_wake_threshold;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9ce0319b33c3..940d3afe1d24 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -397,7 +397,7 @@ static void fec_dump(struct net_device *ndev)
 			fec16_to_cpu(bdp->cbd_sc),
 			fec32_to_cpu(bdp->cbd_bufaddr),
 			fec16_to_cpu(bdp->cbd_datlen),
-			txq->tx_skbuff[index]);
+			txq->tx_buf[index].skb);
 		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		index++;
 	} while (bdp != txq->bd.base);
@@ -654,7 +654,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 
 	index = fec_enet_get_bd_index(last_bdp, &txq->bd);
 	/* Save skb pointer */
-	txq->tx_skbuff[index] = skb;
+	txq->tx_buf[index].skb = skb;
 
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
@@ -672,9 +672,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 
 	skb_tx_timestamp(skb);
 
-	/* Make sure the update to bdp and tx_skbuff are performed before
-	 * txq->bd.cur.
-	 */
+	/* Make sure the update to bdp is performed before txq->bd.cur. */
 	wmb();
 	txq->bd.cur = bdp;
 
@@ -862,7 +860,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	}
 
 	/* Save skb pointer */
-	txq->tx_skbuff[index] = skb;
+	txq->tx_buf[index].skb = skb;
 
 	skb_tx_timestamp(skb);
 	txq->bd.cur = bdp;
@@ -952,16 +950,33 @@ static void fec_enet_bd_init(struct net_device *dev)
 		for (i = 0; i < txq->bd.ring_size; i++) {
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (bdp->cbd_bufaddr &&
-			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			if (txq->tx_skbuff[i]) {
-				dev_kfree_skb_any(txq->tx_skbuff[i]);
-				txq->tx_skbuff[i] = NULL;
+			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+				if (bdp->cbd_bufaddr &&
+				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
+					dma_unmap_single(&fep->pdev->dev,
+							 fec32_to_cpu(bdp->cbd_bufaddr),
+							 fec16_to_cpu(bdp->cbd_datlen),
+							 DMA_TO_DEVICE);
+				if (txq->tx_buf[i].skb) {
+					dev_kfree_skb_any(txq->tx_buf[i].skb);
+					txq->tx_buf[i].skb = NULL;
+				}
+			} else {
+				if (bdp->cbd_bufaddr)
+					dma_unmap_single(&fep->pdev->dev,
+							 fec32_to_cpu(bdp->cbd_bufaddr),
+							 fec16_to_cpu(bdp->cbd_datlen),
+							 DMA_TO_DEVICE);
+
+				if (txq->tx_buf[i].xdp) {
+					xdp_return_frame(txq->tx_buf[i].xdp);
+					txq->tx_buf[i].xdp = NULL;
+				}
+
+				/* restore default tx buffer type: FEC_TXBUF_T_SKB */
+				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
 			}
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
 			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
 		}
@@ -1360,6 +1375,7 @@ static void
 fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 {
 	struct	fec_enet_private *fep;
+	struct xdp_frame *xdpf;
 	struct bufdesc *bdp;
 	unsigned short status;
 	struct	sk_buff	*skb;
@@ -1387,16 +1403,31 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 
-		skb = txq->tx_skbuff[index];
-		txq->tx_skbuff[index] = NULL;
-		if (!IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
-			dma_unmap_single(&fep->pdev->dev,
-					 fec32_to_cpu(bdp->cbd_bufaddr),
-					 fec16_to_cpu(bdp->cbd_datlen),
-					 DMA_TO_DEVICE);
-		bdp->cbd_bufaddr = cpu_to_fec32(0);
-		if (!skb)
-			goto skb_done;
+		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
+			skb = txq->tx_buf[index].skb;
+			txq->tx_buf[index].skb = NULL;
+			if (bdp->cbd_bufaddr &&
+			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			if (!skb)
+				goto tx_buf_done;
+		} else {
+			xdpf = txq->tx_buf[index].xdp;
+			if (bdp->cbd_bufaddr)
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			if (!xdpf) {
+				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+				goto tx_buf_done;
+			}
+		}
 
 		/* Check for errors. */
 		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
@@ -1415,21 +1446,11 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-			ndev->stats.tx_bytes += skb->len;
-		}
 
-		/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-		 * are to time stamp the packet, so we still need to check time
-		 * stamping enabled flag.
-		 */
-		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-			     fep->hwts_tx_en) &&
-		    fep->bufdesc_ex) {
-			struct skb_shared_hwtstamps shhwtstamps;
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-			fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-			skb_tstamp_tx(skb, &shhwtstamps);
+			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
+				ndev->stats.tx_bytes += skb->len;
+			else
+				ndev->stats.tx_bytes += xdpf->len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1438,10 +1459,32 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		/* Free the sk buffer associated with this last transmit */
-		dev_kfree_skb_any(skb);
-skb_done:
-		/* Make sure the update to bdp and tx_skbuff are performed
+		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct skb_shared_hwtstamps shhwtstamps;
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			dev_kfree_skb_any(skb);
+		} else {
+			xdp_return_frame(xdpf);
+
+			txq->tx_buf[index].xdp = NULL;
+			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
+			txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		}
+
+tx_buf_done:
+		/* Make sure the update to bdp and tx_buf are performed
 		 * before dirty_tx
 		 */
 		wmb();
@@ -3249,9 +3292,19 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		for (i = 0; i < txq->bd.ring_size; i++) {
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
-			skb = txq->tx_skbuff[i];
-			txq->tx_skbuff[i] = NULL;
-			dev_kfree_skb(skb);
+
+			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+				skb = txq->tx_buf[i].skb;
+				txq->tx_buf[i].skb = NULL;
+				dev_kfree_skb(skb);
+			} else {
+				if (txq->tx_buf[i].xdp) {
+					xdp_return_frame(txq->tx_buf[i].xdp);
+					txq->tx_buf[i].xdp = NULL;
+				}
+
+				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
+			}
 		}
 	}
 }
@@ -3817,7 +3870,8 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		ebdp->cbd_esc = cpu_to_fec32(estatus);
 	}
 
-	txq->tx_skbuff[index] = NULL;
+	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
+	txq->tx_buf[index].xdp = frame;
 
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
-- 
2.25.1


