Return-Path: <bpf+bounces-3944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5AE746C13
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB181C20A8B
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF5A4697;
	Tue,  4 Jul 2023 08:36:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044C468B;
	Tue,  4 Jul 2023 08:36:05 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FFEE5B;
	Tue,  4 Jul 2023 01:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY4GgjiWaSVnlwwnb7G4ExH9zm6H+D8holf+HcJTEL8yIR9R/GbQB8SNYjGzIg+vjsNSvc9W0NsZyuNfdj5OZ95leFESlUfsqFOBbTmGoxvcydSEXOXj+FrbTGfoM2iZYlvm/Lg+eOStK3M2qbNhCsMP2lz60cqsu5nkP2Av7voWLpJNTk8yI6IjyZS4D9n7xCeWTkqkdMB5ws32RzEHrdcb/w9hBYlo5VJEyXsKpjjR64Kc6zmz4sKFT9qKTC+jC2FFgXL/sBhYQMLhw6b5ZaEsqsTg8B06c3PTeGFCLKuSmLIJCUgZj/bS8zjJip8Bbe7E9gQ2jS6MKgq2p6G1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqmOszEzMjH8Wav47TqQalE35zrvojCmgFRuBx3VYOQ=;
 b=WfKagPL56BcSchnE51/oTBNv14xdfRgHr6GGKP0T+d6hDsBamFv7elCDAked+bQESIgHJiBdFRe18oR5afqS1UCUOw0Wtvo4T+VXW3edM1YyrsOSkOnqqXp2upS9sYXheJ+z30ZYqSgbpyCLc4qhISqkL6SSp0tWTpkoiFyrzVkz+4gP+qRGZ67CwwvugmWEzch0llDFVe1TVBnBRjLJYSCJTmglv/ytic7Sgf8F4JtMbuwROJnOf2XX9UTzjxQZrvW374lY6Wao+NXh207z5sl4Tq9jPsEV24jb98sTAoJlt/vVG2DCpwILPjHb4gSzQwDvED61D90Uw5M2CKwvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqmOszEzMjH8Wav47TqQalE35zrvojCmgFRuBx3VYOQ=;
 b=GzUMMVBG/Sm8+HKazzkbO8R0NE+O0oR6yIGBUo+oI0ADzj9vcYDUrUJWIFfhDX8zvGyLcHfUnmSE7zi1/abEGzqAFF5GnMARM24TX0uu0FM3Yo3EcRWb2z3kLijIQjp9VXieozRV+k9MpUIV8ngiFjd6v7kkvLFhgcS/24HzzUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB8PR04MB7081.eurprd04.prod.outlook.com (2603:10a6:10:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:36:00 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:36:00 +0000
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
Subject: [PATCH net 2/3] net: fec: recycle pages for transmitted XDP frames
Date: Tue,  4 Jul 2023 16:29:15 +0800
Message-Id: <20230704082916.2135501-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704082916.2135501-1-wei.fang@nxp.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DB8PR04MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf89f90-0e12-4a94-6f28-08db7c69b1bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kfiTcpX0AUonnLU4iKjF4Wi3m42tkEeABFq05m5qun+txsr/F0Cf4U/mbf+sKnPpHPYvQAiFmmLSvfZWyXXbbgrS0wuBQiEGkX0G08Ep44O/jojBsMKq8QpHX6qlYsukSaNvVjMjcz8D3Ufs56xc4hI+7+U+KmV9THW+OrTFjaTZWQ6cHBQdYdwAkdLMpNfp6WNttwkloiY1FQBBr9p3nbOr6O6eXbWUbvUNudz+gX+71RE/QWNqkIOaoJzNj3h9Soj59qV53xJ52tkXGwnSaiakwSyerrZrVPiLQP9ztff32p7EuHB7lzOLD8ZJw9wK/FHizp4JrWRg1wDsbZiolEBsqOplPJ8RaL+J1XtkRldbpNCyaD+m3jGCWrvqEb6l/8V6lvlUE01W6ays376CPaJVu6p3VrFd+wp/oymTohT/cJx5z0/rj3Chb6ERHlBYOCucSWaTlo3RkwK15XAUkpaMV5O8432R2XB9718u/9F88c4vlGCle88FMDMLw9ukWRB51C82Qe4x+rZ+7i/3oQcT6ABJWQpWgR+m2LLoAZWv6aF3cMk07KWxTTb5FEbS05CBVR4vxIjJMLx+GE6SA677An7BZ+oUaddlgsn0c16D2yaFGcY31jcSwGxlpNCcnvICBt5GNxzT7JARDebWww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(316002)(41300700001)(6486002)(6512007)(52116002)(26005)(83380400001)(186003)(9686003)(1076003)(6506007)(2616005)(38350700002)(6666004)(478600001)(921005)(38100700002)(66556008)(66946007)(66476007)(4326008)(5660300002)(7416002)(86362001)(2906002)(8676002)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dgyh1aCak651CR4KsbF2qUPvC7sC/6sGyJYOfMTAU1EaIdDZGs7SEajQnFxC?=
 =?us-ascii?Q?wbH3dQXjFuOtUlFKFefMygeiYfSHtZ1d0OOizl4r0Bj6UnXElxxqtXOYyfv9?=
 =?us-ascii?Q?ERv/X5qd2FFQC5N4l2/0gbSWbPEQo1/DsWWc5ln725REXeAL5ZkrHoz+4fsq?=
 =?us-ascii?Q?MoKwlr/5TlCF4qFlf4BQkz4Y1es1aYsvSe7XUSlqAFSVvapGXETOmYPw4B9b?=
 =?us-ascii?Q?c42XW5WSd7Q4wcwPJEoip8oeBZPIQynrgJzwDRvKc7hEezwDO7gamJ4MdfVe?=
 =?us-ascii?Q?LWlc0D9QT1gaZMMvDcFifYtBgxA2+sU+Iiby3Rm+ZgV1Gi4JEBQwxTPEPjZP?=
 =?us-ascii?Q?itMsziUuoZYGUGUWI4/KK+OPcBegPid5w8oDU+ZkDQVstsAsVn9b+BxUSVJf?=
 =?us-ascii?Q?sKnE1Ud3EbldWSKyicl5AQ2AaX8+DqYwHqWsOh/nKOWJ5NaUD0Rb55WeMlnA?=
 =?us-ascii?Q?SBg0G0el7arOeXXRburNulPPj8vXM4fSDvgMKDN8BFGphF7cjc2S9ihUU5sB?=
 =?us-ascii?Q?pZfCVsUQI4i2vJldBCApMn2zoyKjajVQdnWMkTfitaCUO9VLM6dqh0nAOYWZ?=
 =?us-ascii?Q?DPzlqLvSajrLtpBtYAcjP3Do+PEDS6aNWxqz74cXzZAen8tlOhi/KUja8uJc?=
 =?us-ascii?Q?+TlfXd78+5u3B0h6txNS1kfUjuCVB8+wLWe+D3Z7YlLdXaWMZ7fLzUUTA9HV?=
 =?us-ascii?Q?acwckl0hr/iq1IsvAS76VLhGD7dV34nR7gDNFHScOLJVPeFfdZCGvYjVrxg0?=
 =?us-ascii?Q?Wbh7IriIgCWshU0hUIgoo+sVgOwBba/Uocze8i8JYLDw3ujgXte/XLe1C81V?=
 =?us-ascii?Q?Un6Qmc+tzqAJtkxXd1MoZrQgsAf9gO4Lr7w8PFoJSLtzRFx7g+3Np859Wnx0?=
 =?us-ascii?Q?88mM4rKM8M1kzEKxItm6BMBhjfAOVs19E/j4Yo2VDDyKO+0ZzR8FVobo1Lfy?=
 =?us-ascii?Q?LEVGulwZ9tQvQMUoTNU1yyCdLWZpHkfwIuVzObGLdNbfEaafyMeP/jKWWgll?=
 =?us-ascii?Q?OIXtNDDBKy42EhfRiR56vGMi2ZIrpAEWhghKEo/Hd03xzaVYIcreBDP+qTXm?=
 =?us-ascii?Q?zYbqJC3r9+20ywNUZu5FcasVhzShxljANsDOBcBCjE5KKC6eiMf36xyjt3q+?=
 =?us-ascii?Q?iUJUO6FGu79QtNjvsDj11/TC8H51w5fHfLFGqTfOy5LWBknYH3rIukcpS09M?=
 =?us-ascii?Q?CVbEZDPfP8dX1DX5PawD8UN1rX/HeV4BhrDZmNN25To2aGc35qxWgMFPV3l9?=
 =?us-ascii?Q?wM/6olZ5ZAnPAwYsNvI+Q5GDwQkWXGvmwkubk1oJON2V1+TexeltvcfoRupQ?=
 =?us-ascii?Q?vOH17tysXAE7Ce1faNneDCqby+hRIZ599DVB5uCzC1TBIgELBUbKHl7AbMtO?=
 =?us-ascii?Q?oIQdxfzIqEJjGmqqPnJEj5o9n7+7VWdyrCfOer2pQOSwM+wKUM0U4209kfXf?=
 =?us-ascii?Q?OgfjTHWJJC+0Mm+GvgXXgrNtz9eBxOtl6ZVCmJ9J1v6o8bNp25uplA8YPwIF?=
 =?us-ascii?Q?BVDC1KOX2aCchp5rlHxJwnUMNNVV1V229sA6KmsFIZjQG7GfTEYuth265+f2?=
 =?us-ascii?Q?16lkVXIL7LWCYeEpbYiaFA5AsKRBVJDfhm6oORpY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf89f90-0e12-4a94-6f28-08db7c69b1bd
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 08:36:00.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TiF0Iqn4QHdszUX1T0FGTR2g/72CYGLnenuzmTkyaoNPdk01opdGqoY7udnG2UT1FFz7ZB+HPZGvs9w8A4AHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


