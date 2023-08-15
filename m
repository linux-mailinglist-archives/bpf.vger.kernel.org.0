Return-Path: <bpf+bounces-7790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F9B77C711
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 07:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED72281347
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 05:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2B35699;
	Tue, 15 Aug 2023 05:26:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC35669;
	Tue, 15 Aug 2023 05:26:46 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB73210D;
	Mon, 14 Aug 2023 22:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS/KTShO7RuSEY++mSfbBkF4VxkE2f6B91L0/eACY7Xe4drjheF1+YXrdaLOJszRIh5rHS7fLJd81nQCIYmLNw9DVvjr4mJCNxWwBhjOF7lSLASNAfitRXnlnibYJ+MGUZKp+15GmmVBzwrbcoXLojovwopk+j/ad7J3WuaAYR49Wo9S+2ycz753hIOl+P4IQV/KJ4HBZR3J/Db9uiO+3MoPttURBdyjwkRaoem4AaO45Xx2t+W5WN+fmxtpZD5D+nvhkssY+RwSdOEar0HrVCOiESshLdt7O8qZH6kv2Xis2AIi/XIsFZN2Zy0mIDNGnhP4gwpu0/3Zv/OKPrpnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwuDwos7zmo5ZayMl1rt2WruzhRaVlWPz3mhQjyb3dM=;
 b=W7fcvDPmHcIbrdDv6EwD+a7jY6u8gnV1WcZ/nHHTvjopnf/i0BIvGvmalC/Yl/2pzpcpGH9u86S87EXq0/6BZZqdicsmH1FcjGcJa3qbnfu/lqV3/cPZkNb5PRN2V0cKq0tL2jcXnPhnzOWNJ8c+dzEBArlw3pJcNqRtUiM5dZmPRwQgtVe9UDSyDFhKrtqoEsi2RrsujQRdh34N08gtp0/4Qe5NHAhWae8WkEZ671R6ZovezjIjkhLozw3ECCJL5PlwO/9cNYFqK0ZfHl4TiF8lLIQ63FOwr9xQY7bR9jnbyQUmb/YKo3PxfWDHPx1KBWWg8YnOOGAcosZSeHJjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwuDwos7zmo5ZayMl1rt2WruzhRaVlWPz3mhQjyb3dM=;
 b=RPBbmPTTtevTjaqfsBE3Uot8KPpY/Er/54O+BaK7+ou8Di2sWrNOU+JELUOjy6bZW2GB0kuoPZR9cKJGXzSFTiC8IJ6dCXaS8Yu72r4sfL1i3JssPqGONYi+6/ERVSV1Men9GC8vMwR8q3QazHmqVl/2QAe3l+tKgYp9+jkGRWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB8380.eurprd04.prod.outlook.com (2603:10a6:10:243::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 05:26:38 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:26:38 +0000
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
Subject: [PATCH V6 net-next 2/2] net: fec: improve XDP_TX performance
Date: Tue, 15 Aug 2023 13:19:55 +0800
Message-Id: <20230815051955.150298-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815051955.150298-1-wei.fang@nxp.com>
References: <20230815051955.150298-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DB9PR04MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3f6043-cc67-47a8-e8aa-08db9d50331b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+ePrtfS8JObr6cThr+pkzxOHGdI71j9JT5NgzybC3jDYMsSWoQEJ7yD05HVYuKFBLCpENuXyR0GmcjsrST7ubCbhNSNGDc4L4fLhBsVUoeyyYXp1elBMR5oSHY03eGVTQhBFT9KPREYFK4t+8lRw4tJhQRR5pgIZWGJkXwVZ18dFAQrPQyjhV60Rxtc2EKqN96FgEJ1CtvOXciDEU0vdMjq2Ber7YbMCY9GrCwuefHz5HNKmdj7KuJR60eAZ9ruTg85D5AN9oVADitFMVGqAMhExKvQwWn7DGomiD3AoJZiKVbmtnN4py7I8o1YtlaEtFijqhvcr72QGoEH13r2fNg8uQsUGGWMBOkI4qP6Gj5OObV//fZ7NZNRpjPbs+MsSU50ZcEV/wKhPo7BCovVlfpy9z6BlmkieqlwtJN3132bVeWvs9k0XiON7mlMMgBxOtLHruP1BaYrGxVSawTxAuiPmwKSFjYUBqvR1ufet8m09P2NiupW5xTqfbFe/tFizSVlO8xyw2ZKU4HlLdy68zva95ee1Ju4cM7vfqhFC9BH8XOAlOhc8y6FG3PiTa24EDm5zAMw+hAct+MSu3kFrzm3ngWiFtRseifImpEY5N9YJCVdtyR5FVhHXy8ySeoBZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(186006)(1800799006)(26005)(6506007)(1076003)(6512007)(52116002)(6486002)(2616005)(6666004)(83380400001)(5660300002)(44832011)(7416002)(8676002)(8936002)(2906002)(30864003)(478600001)(316002)(41300700001)(66476007)(66556008)(66946007)(4326008)(86362001)(36756003)(38100700002)(38350700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NYVVK5LyfNJtYfVYmSqDiKBTWNH9GVAD6Lnm9TPrL1vq74ScyUDkn7wt9dIT?=
 =?us-ascii?Q?l0BGfKF0mzhQiwJ7V2o87wbIWqQRVPT3F1/maD9BMtA4laLP8pE7SJ0YTypB?=
 =?us-ascii?Q?u8uvHdN6hn9MKv43ifl7W8cKjM5C8tjTmvxnWQQpoIha/CewATkOuUdyVosE?=
 =?us-ascii?Q?IXD2meHPif0V68zgEfbk4K62gFsKEOc+g/9aYh2CJuTdgTD1KnljbA8kFxeB?=
 =?us-ascii?Q?KGHnlR/15BXNFXoq0cVALmQbiIkDBn501yPmWp1aipn9mCcGbonfpXc+PV0y?=
 =?us-ascii?Q?9BehMRuSktRhxzHULvYmyTlV6meGT8HZRK3hGiK1Ycfx3RSwak2VOwqQFK5L?=
 =?us-ascii?Q?dyp0d6qs3tXW7VxCnGXPDtUrgbyTYuHuXBjlUTDNfzKj/yf09t0tWQunk8+J?=
 =?us-ascii?Q?e58Nv22+oXg/ZfzzA1eqrDqO6V/MyloN7RAC+36Fgnjr/QiIBrMpUsKvMUWL?=
 =?us-ascii?Q?Y7I3H2727dR65t9a9+Nr1DinxROaWtA+Tgy8z7jKSkIppyXL9MaG34BI0dSr?=
 =?us-ascii?Q?lE+pcDVCjuNnc2EaUq6o0y/YakazwPO1yBj2c70jkcEGe44eyKJdcyNchtaF?=
 =?us-ascii?Q?ZKO6YvsJW8TrG8sxJzJxd5aIdvc2pgJYe2OjXHQncCs6R8N6LDeuxijRE6S2?=
 =?us-ascii?Q?PtGsjYrBhMScK6PuICrXKu/nyISgsfPqch+aAILYk/TsBTRG6XsN9EYLlD6J?=
 =?us-ascii?Q?GyrQFXVpCXel3avqFNCkyISH+/SpvFXH05mML4v7X9hBIzKj0KQ0/2mOEEmb?=
 =?us-ascii?Q?Qxr1ysYQZO/UW/4ijpKW/5DyQpgv/Mf/qmm8NxQWNgwZJ4sT2W7ziKRQoeJL?=
 =?us-ascii?Q?qv5McMwtnjMFafElvZIquEc2XjuLBMgIIU6IIV2B69kQ/XZ1iv2wgdQaAU7q?=
 =?us-ascii?Q?MY1N0VnLinsm4nUbuhyY19E7HCyg8sGsrAcGn49dPEzuH4jaTUHGx6/N8jDK?=
 =?us-ascii?Q?Hg+aHsgEMIeulWTMkGV1i3iAg5z4H+Rj3tMaVL+ZDmGt7ACbdmclnH+bl77M?=
 =?us-ascii?Q?Wz5VJMHDG79wpwPD1Z1g7QzctG+Ai+8EeleS8OIhNJtj9EQGnpIvA9kZPz9N?=
 =?us-ascii?Q?h/k7f/c0NRLx7BIPqBPMgODDY6S9z9m4N5uaJ5EvFa5FqaOuq3bqOUi6atJu?=
 =?us-ascii?Q?ZTYP9ZI1eV5698sf53zAkQzt0RDkwavHXc6q/YXcFMTsf2m2p+USqj/qVQUk?=
 =?us-ascii?Q?/R0fSugp7s1K1iG2ERXdrEbjW+x7MMHOZQo6F/U+j80mZ7GMCJcSfbQ85sBL?=
 =?us-ascii?Q?jxlvc/le3kcDmAuyhOV0rniyvC67vAbt1NU04KS5liEisevZ6PaTnm9HVgUy?=
 =?us-ascii?Q?YHzEAahzRUk8krkX8fhdeEv5vTATjRXPfzx1kDEpJoYOFaS26KsHQoYWCApx?=
 =?us-ascii?Q?UYmtzFswNKgR0NU4rFxupGbQ6Zsb+x2UIhsSfYZrRiNQNuZIuL9kEWkfAkyn?=
 =?us-ascii?Q?uAU+PxtQ6IaVAwwvQyQzqfo6PQPTvHzvyvSWHVJPwblUR5AgK/b9xgTpQ1Jf?=
 =?us-ascii?Q?uzpKKFMkgz3OowukvG8QU/3euczv7qnGr2RV3dEi4TihoA0bH/MY/AeZrb58?=
 =?us-ascii?Q?R/n73PFQUBhoXWvv0X/f00iVwvKohbH7Rh/4uZQK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3f6043-cc67-47a8-e8aa-08db9d50331b
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 05:26:38.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3KeaaIhsF1xMph4NXh5HrLBJaJBZSo6Pepm3GMQqM9TOl3t6kxfBVQKw03GL3hRFBLtFfvyyueRY22FfZk0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
V5 changes:
New patch. Separated from the first patch, to keep track of the changes
and improvements (suggested by Jesper).

V6 changes:
No changes.
---
 drivers/net/ethernet/freescale/fec.h      |   5 +-
 drivers/net/ethernet/freescale/fec_main.c | 140 ++++++++++++----------
 2 files changed, 75 insertions(+), 70 deletions(-)

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
index 38301c4b04e2..6739183d4555 100644
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
@@ -1487,23 +1494,17 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			/* Free the sk buffer associated with this last transmit */
 			dev_kfree_skb_any(skb);
-		} else {
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdp_return_frame_rx_napi(xdpf);
-			} else { /* recycle pages of XDP_TX frames */
-				struct page *page = virt_to_head_page(xdpf->data);
-
-				/* The dma_sync_size = 0 as XDP_TX has already
-				 * synced DMA for_device.
-				 */
-				page_pool_put_page(page->pp, page, 0, true);
-			}
-
-			txq->tx_buf[index].xdp = NULL;
-			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-			txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
+			xdp_return_frame_rx_napi(xdpf);
+		} else { /* recycle pages of XDP_TX frames */
+			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
+			page_pool_put_page(page->pp, page, 0, true);
 		}
 
+		txq->tx_buf[index].buf_p = NULL;
+		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
+		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+
 tx_buf_done:
 		/* Make sure the update to bdp and tx_buf are performed
 		 * before dirty_tx
@@ -3233,7 +3234,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	unsigned int i;
-	struct sk_buff *skb;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
 	unsigned int q;
@@ -3258,18 +3258,23 @@ static void fec_enet_free_buffers(struct net_device *ndev)
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
@@ -3792,13 +3797,14 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
 
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
@@ -3814,30 +3820,36 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
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
@@ -3878,14 +3890,10 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
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
@@ -3894,7 +3902,7 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 
 	/* Avoid tx timeout as XDP shares the queue with kernel stack */
 	txq_trans_cond_update(nq);
-	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len, false);
+	ret = fec_enet_txq_xmit_frame(fep, txq, xdp, dma_sync_len, false);
 
 	__netif_tx_unlock(nq);
 
-- 
2.25.1


