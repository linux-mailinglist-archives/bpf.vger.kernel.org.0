Return-Path: <bpf+bounces-7428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741207770BD
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF6281E78
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B084429;
	Thu, 10 Aug 2023 06:52:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9A1107;
	Thu, 10 Aug 2023 06:52:47 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00010C0;
	Wed,  9 Aug 2023 23:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mflKZrRggIvQ6FeEeRz4V9339OH+n6hoYqYN1TvTnDaXf5SNycekRlME0USKg6OUVgYbl8OREposM/P0pHkXnnTH9M2t2JekGyfod3MNjaGA8uOPxwca69bQvUGvYfU+SD20tmG07CbM0t7XaYl5NVRm5XfJd/J761SWt/DsrJBB3RZWvIcIe6VqOUPu7CD3nWgDgvll5/8A/7mXrGNgQ3qikbjdtSof8BZQ+8zl958GKJgai2U0hBSCjoNdvfOwbHE6N1vq2/iBIkHSkjQNsycuCHTRAKekSiAz8kZ1hR8xkQyi4NtzyprlA8d2HKPX1wWWy0RWwHFC6ev8yImL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOFMU0ocltnjh1rVf6pufFazd5RYSWi/UkGYmkhyAqs=;
 b=Nf1BTmTmSPOZk2Cn3d71rPMuygq4KQ+cJQrAc7uPQjmq8L8py6fTVUgzbos2qDscAiK4QE8p0D3+/axTZgwkcaqj6AtmkI7cqH86VYpChz5+635t6wyUhD6pcfNntOKbMibYox0yy9dl4nnfWeZSsk2qXA1FDFvC90lEOUHhA3MFZiCmpaY6bqHd0KZwj3bZ5HiJ6aCKR6fe4RgpjSFHM7uuDosHG8GGRJBkf0qPeQVi80wqg56EXOzkj5pYutmy3By2KmfM1+2vetmo8i8zhQ4jzPnf7tLNwAE1TFa7kdIkJaA5FE2Rn5H2aRiswAaKblHoX5eGsFLOkgEiFIniPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOFMU0ocltnjh1rVf6pufFazd5RYSWi/UkGYmkhyAqs=;
 b=MFzyvK1mN6Uu6uC56WhD+x61QLwurxqVdaGZI+GSbETahVCzkfLBhGpr8ioK6A/MBd8+w0zQAIRpUS1iNEYkaz0I5dOwz5HJFeplLqYRBlH++s5RtOb02GPDuHF3phl9Y1yDPuXtOq4xzwPW6hM5FTlYFtUIcxmjLQNEuXtXNXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB6PR04MB3141.eurprd04.prod.outlook.com (2603:10a6:6:c::21) by
 PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 06:52:43 +0000
Received: from DB6PR04MB3141.eurprd04.prod.outlook.com
 ([fe80::3203:2dba:b6f5:9104]) by DB6PR04MB3141.eurprd04.prod.outlook.com
 ([fe80::3203:2dba:b6f5:9104%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 06:52:42 +0000
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
Subject: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Date: Thu, 10 Aug 2023 14:45:13 +0800
Message-Id: <20230810064514.104470-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e891bab-553f-4c8d-d6da-08db996e64f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BFIi+YMzKq0QbFJQl64cEmGR2YvSwrDhjRdybbinCuOridrlOxQMr5czeanQgPRVIJPiZIj5lxz7V38uPznTIK3nR8g5R/WK20FXreto1g2lw3kAHAjvQml791HTqIcJE0emJpB9UZV2No+kxPZNTY5WFkKjwHNE+uchGHWGmDdY0DNaAZr2VAjhPHsioCRDgQSIh1RUo0blXa6+cJr8cQWI2KpY0gWJ8UgnWefnSYW6qVaBykUt0eH7GVAPsS1w9ch6EQaTr5kXcUVoeR6c+48WT+5E7Ylf9R2zoiI7Z1XfyRiO5qepsG6OvEcWf1+CSCops3oniKP6KiyOlay9kESVIMuTtiz5N99bPPBP3spLwqmZyjqDCwWNePjxhrqmf2nafI3r00R6SlhLUcW4b1c5NShBI8qtFtH1Xwaa5m9MVIgQAO2pURit6vp5o6Pzt9E1TOxcJnD2t7qk1Ueh4Uv26+dCU1UyEdp4jXseb9VRrvizQuNXSqV3p7Oj6EcrQUFgtCAt6Y0t8ykM3A4cMzywInHBnFoowf8oaiSn12ZHQzaWgZlwnUlsL9bAKQj3RT7GbOlHsXhFZG76czxiVmf5oHYjLE12l2QP3qQwtZZV81yv+ZbgnSeQGluwIjMz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3141.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(396003)(346002)(186006)(1800799006)(451199021)(36756003)(6666004)(478600001)(66946007)(26005)(66476007)(66556008)(1076003)(6506007)(6486002)(6512007)(4326008)(30864003)(2906002)(41300700001)(316002)(7416002)(44832011)(921005)(38100700002)(5660300002)(8936002)(38350700002)(8676002)(83380400001)(2616005)(966005)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwnuhmFYveD46YVWCYob6uRBx5S0cHhK03yja+hIh7owJvgzwX0z6nw2ID33?=
 =?us-ascii?Q?HBCzYJfJzzENqH0hgU/rvEv+NR/I4ul6WghBAjKJ7tV+4r5KWYAXUi1uYoVh?=
 =?us-ascii?Q?y+Cilx50eOBCqbT5xwPkBnwavm4JJOryBcv1U8MGlct9p+4RIqm3Yg5eryFA?=
 =?us-ascii?Q?6v2dEguvv4d0rYCkMPB8C77zHwfViPqbjZ/n5KJzSAVQJTixkOvMWOu6bqrM?=
 =?us-ascii?Q?ZBdqI2yUxNdpNSpYuvCYZrBFR9wy1WFxclds+EWyTVlT1MaQXInR1KLlK1bE?=
 =?us-ascii?Q?RJYBSOJafm7al3ED2DXJDzzQXban0ddna7sXNEP8Q0WZIWIglnrKGNCaEFIm?=
 =?us-ascii?Q?QgiIWPG8hleBAm9Ve5JkW8rJFb0SO2uUYwVhxyxHvAVzpR8/TsCUB5qped1x?=
 =?us-ascii?Q?bRznw1fPYJtlyPeEGXnBlMksmVYf+dR8rWGFUKuaArwTb32oGpS4iXhhcqGk?=
 =?us-ascii?Q?cSeKQUDFdbKaOcupLc2hjpO9yKQBU7PDwIVhZmosHSDsrWzKwgzuJtYCk0oM?=
 =?us-ascii?Q?PK0nOq9aappf9Z0ln4QzSv3TVbIgqxRhqLoN5mL+OOBUs3EwECAmaKQaFEep?=
 =?us-ascii?Q?CJHWDwwsHDWqyBKOuiVlms1WnFnsNPH9HziQ0MFrbQenzoPdfZwNIlF/k5in?=
 =?us-ascii?Q?K2XgvN9H0D99LgEBNOC+DTEeUrTYqT578PYIdRHcF2/e34RkXWc1TZsFeiDo?=
 =?us-ascii?Q?wvn+B00Sex/5IOFJhwKZGhva6NI7pUIK/hUi0SyRf3DPu2xGxSlEqhCwu2KK?=
 =?us-ascii?Q?Qn0ERRRFTeLIloUpWHQaMPP61rGK2iz/BqsYa116Fp7NCujajhVCl3VzZygs?=
 =?us-ascii?Q?Nt+6mBCBqqhDXHww+kFEadFaSZ2Cz1hbwHYJF+PHg1ZyM1CBgZvwLwM1ZslJ?=
 =?us-ascii?Q?C2aTZs/zwKGtbuRQH9CxqRVQa87zcHrf5jDetcU1+kpqKicQtCMCqNd59dzb?=
 =?us-ascii?Q?xcRXpZkJGWWGtcyaV36kE9qZPpyn9JTTsfLUZ5aOGFW12XDME/9/9+2XZcAi?=
 =?us-ascii?Q?iwzloW2vLcJHaXfENq2pk+rxVTodiJqISSHb7QAGEAs0uxyZboM7I/AfqrGZ?=
 =?us-ascii?Q?8tXW+B4djo26+u55eKLRZYcMgXPN0K1jd+H/ljO/F8xXvlEOOueFHGt7Gmw8?=
 =?us-ascii?Q?OBaDHr/QoFcQUnUXnOMnHDop4EA9yG5NYwiQ9/kSsIRrvmdBawpqX+osCxeo?=
 =?us-ascii?Q?D0La62wEPBKEEe8qgQuAv+vzc3cAaqwn7eqmo0agIWCi0dAj8baoR7A2VfYM?=
 =?us-ascii?Q?zSnriCmmwu7uC3LQreCkMdXMNLReV+A1kROait7Drpds14IeDhskU2BUiLiL?=
 =?us-ascii?Q?SoSg7N9mNkF78gyoohNDUta0c9pABzcvmG2uKa2v2fMsDaTKKXXUDM3oVwiO?=
 =?us-ascii?Q?RFpEFIdWfESZq+a9qyld8bgbObJAYBunmCJT6Q+2pCp7q498jpQr8hirDODR?=
 =?us-ascii?Q?5jlSztGIazQLrd3ei1waNC4xDvQ7DC1k9DVjitA6lUITLQ+9peZumMgSta9R?=
 =?us-ascii?Q?HkgMowVkS/pt/6lTgUt8pEPDXaObEDVZnEApfWNlDlHI1YVqmccFgoaUOgpH?=
 =?us-ascii?Q?As6RWHMyPWGyOvYAH0FqxG8+9q2cX+90sT2z6GML?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e891bab-553f-4c8d-d6da-08db996e64f4
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3141.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 06:52:42.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYXM4BPW+jmPx47EtbYKq9x8taMyGLDevzNq+SWQeEo5yzztktllKQ6pIS1pH5aCaZgEp7YTBsYXVjSH6Ymnbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The XDP_TX feature is not supported before, and all the frames
which are deemed to do XDP_TX action actually do the XDP_DROP
action. So this patch adds the XDP_TX support to FEC driver.

I tested the performance of XDP_TX in XDP_DRV mode and XDP_SKB
mode respectively on i.MX8MP-EVK platform, and as suggested by
Jesper, I also tested the performance of XDP_REDIRECT on the
same platform. And the test steps and results are as follows.

XDP_TX test:
Step 1: One board is used as generator and connects to switch,and
the FEC port of DUT also connects to the switch. Both boards with
flow control off. Then the generator runs the
pktgen_sample03_burst_single_flow.sh script to generate and send
burst traffic to DUT. Note that the size of packet was set to 64
bytes and the procotol of packet was UDP in my test scenario. In
addtion, the SMAC of the packet need to be different from the MAC
of the generator, because the xdp2 program will swap the DMAC and
SMAC of the packet and send it back to the generator. If the SMAC
of the generated packet is the MAC of the generator, the generator
will receive the returned traffic which increase the CPU loading
and significantly degrade the transmit speed of the generator, and
finally it affects the test of XDP_TX performance.

Step 2: The DUT runs the xdp2 program to transmit received UDP
packets back out on the same port where they were received.

root@imx8mpevk:~# ./xdp2 eth0
proto 17:     353918 pkt/s
proto 17:     352923 pkt/s
proto 17:     353900 pkt/s
proto 17:     352672 pkt/s
proto 17:     353912 pkt/s
proto 17:     354219 pkt/s

root@imx8mpevk:~# ./xdp2 -S eth0
proto 17:     160604 pkt/s
proto 17:     160708 pkt/s
proto 17:     160564 pkt/s
proto 17:     160684 pkt/s
proto 17:     160640 pkt/s
proto 17:     160720 pkt/s

The above results show that the XDP_TX performance of XDP_DRV mode
is much better than XDP_SKB mode, more than twice that of XDP_SKB
mode, which is in line with our expectation.

XDP_REDIRECT test:
Step1: Both the generator and the FEC port of the DUT connet to the
switch port. All the ports with flow control off, then the generator
runs the pktgen script to generate and send burst traffic to DUT.
Note that the size of packet was set to 64 bytes and the procotol of
packet was UDP in my test scenario.

Step2: The DUT runs the xdp_redirect program to redirect the traffic
from the FEC port to the FEC port itself.

root@imx8mpevk:~# ./xdp_redirect eth0 eth0
Redirecting from eth0 (ifindex 2; driver fec) to eth0
(ifindex 2; driver fec)
Summary        232,302 rx/s        0 err,drop/s      232,344 xmit/s
Summary        234,579 rx/s        0 err,drop/s      234,577 xmit/s
Summary        235,548 rx/s        0 err,drop/s      235,549 xmit/s
Summary        234,704 rx/s        0 err,drop/s      234,703 xmit/s
Summary        235,504 rx/s        0 err,drop/s      235,504 xmit/s
Summary        235,223 rx/s        0 err,drop/s      235,224 xmit/s
Summary        234,509 rx/s        0 err,drop/s      234,507 xmit/s
Summary        235,481 rx/s        0 err,drop/s      235,482 xmit/s
Summary        234,684 rx/s        0 err,drop/s      234,683 xmit/s
Summary        235,520 rx/s        0 err,drop/s      235,520 xmit/s
Summary        235,461 rx/s        0 err,drop/s      235,461 xmit/s
Summary        234,627 rx/s        0 err,drop/s      234,627 xmit/s
Summary        235,611 rx/s        0 err,drop/s      235,611 xmit/s
  Packets received    : 3,053,753
  Average packets/s   : 234,904
  Packets transmitted : 3,053,792
  Average transmit/s  : 234,907

Compared the performance of XDP_TX with XDP_REDIRECT, XDP_TX is also
much better than XDP_REDIRECT. It's also in line with our expectation.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
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

V5: changes:
1. Implement Jesper's "sync_dma_len" suggestion and simultaneously
use page_pool_put_page(pool, page, 0, true) for XDP_TX to avoid
the DMA sync on page recycle, which is suggested by Jakub.
2. Based on Jesper's suggestion, add a benchmark comparison between
XDP_TX and XDP_REDIRECT. So the commit message is also modified
synchronously.
---
 drivers/net/ethernet/freescale/fec.h      |   1 +
 drivers/net/ethernet/freescale/fec_main.c | 104 +++++++++++++++++-----
 2 files changed, 84 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5ca9906d7c6a..7bb02a9da2a6 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -548,6 +548,7 @@ enum {
 enum fec_txbuf_type {
 	FEC_TXBUF_T_SKB,
 	FEC_TXBUF_T_XDP_NDO,
+	FEC_TXBUF_T_XDP_TX,
 };
 
 struct fec_tx_buffer {
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 43f14cec91e9..30b01985be7c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -68,6 +68,7 @@
 #include <soc/imx/cpuidle.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 
 #include <asm/cacheflush.h>
 
@@ -75,6 +76,9 @@
 
 static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
+static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
+				int cpu, struct xdp_buff *xdp,
+				u32 dma_sync_len);
 
 #define DRIVER_NAME	"fec"
 
@@ -960,7 +964,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 					txq->tx_buf[i].skb = NULL;
 				}
 			} else {
-				if (bdp->cbd_bufaddr)
+				if (bdp->cbd_bufaddr &&
+				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
 					dma_unmap_single(&fep->pdev->dev,
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
@@ -1423,13 +1428,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				break;
 
 			xdpf = txq->tx_buf[index].xdp;
-			if (bdp->cbd_bufaddr)
+			if (bdp->cbd_bufaddr &&
+			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
 						 DMA_TO_DEVICE);
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (!xdpf) {
+			if (unlikely(!xdpf)) {
 				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
 				goto tx_buf_done;
 			}
@@ -1482,7 +1488,13 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			/* Free the sk buffer associated with this last transmit */
 			dev_kfree_skb_any(skb);
 		} else {
-			xdp_return_frame(xdpf);
+			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
+				xdp_return_frame_rx_napi(xdpf);
+			} else {
+				struct page *page = virt_to_head_page(xdpf->data);
+
+				page_pool_put_page(page->pp, page, 0, true);
+			}
 
 			txq->tx_buf[index].xdp = NULL;
 			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
@@ -1541,7 +1553,7 @@ static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 
 static u32
 fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int index)
+		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
 {
 	unsigned int sync, len = xdp->data_end - xdp->data;
 	u32 ret = FEC_ENET_XDP_PASS;
@@ -1551,8 +1563,10 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 
 	act = bpf_prog_run_xdp(prog, xdp);
 
-	/* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
-	sync = xdp->data_end - xdp->data_hard_start - FEC_ENET_XDP_HEADROOM;
+	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
+	 * max len CPU touch
+	 */
+	sync = xdp->data_end - xdp->data;
 	sync = max(sync, len);
 
 	switch (act) {
@@ -1573,11 +1587,19 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 		}
 		break;
 
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
 	case XDP_TX:
+		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
+		if (unlikely(err)) {
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
 
@@ -1619,6 +1641,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
 	u32 data_start = FEC_ENET_XDP_HEADROOM;
+	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
 	u32 sub_len = 4;
@@ -1697,7 +1720,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 			/* subtract 16bit shift and FCS */
 			xdp_prepare_buff(&xdp, page_address(page),
 					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, index);
+			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
 			xdp_result |= ret;
 			if (ret != FEC_ENET_XDP_PASS)
 				goto rx_processing_done;
@@ -3766,7 +3789,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
 
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
-				   struct xdp_frame *frame)
+				   struct xdp_frame *frame,
+				   u32 dma_sync_len, bool ndo_xmit)
 {
 	unsigned int index, status, estatus;
 	struct bufdesc *bdp;
@@ -3786,10 +3810,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
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
+					   dma_sync_len, DMA_BIDIRECTIONAL);
+		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
+	}
+
+	txq->tx_buf[index].xdp = frame;
 
 	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
 	if (fep->bufdesc_ex)
@@ -3808,9 +3846,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 		ebdp->cbd_esc = cpu_to_fec32(estatus);
 	}
 
-	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
-	txq->tx_buf[index].xdp = frame;
-
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
@@ -3836,6 +3871,33 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	return 0;
 }
 
+static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
+				int cpu, struct xdp_buff *xdp,
+				u32 dma_sync_len)
+{
+	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+	struct fec_enet_priv_tx_q *txq;
+	struct netdev_queue *nq;
+	int queue, ret;
+
+	if (unlikely(!xdpf))
+		return -EFAULT;
+
+	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
+	txq = fep->tx_queue[queue];
+	nq = netdev_get_tx_queue(fep->netdev, queue);
+
+	__netif_tx_lock(nq, cpu);
+
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
+	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len, false);
+
+	__netif_tx_unlock(nq);
+
+	return ret;
+}
+
 static int fec_enet_xdp_xmit(struct net_device *dev,
 			     int num_frames,
 			     struct xdp_frame **frames,
@@ -3858,7 +3920,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	/* Avoid tx timeout as XDP shares the queue with kernel stack */
 	txq_trans_cond_update(nq);
 	for (i = 0; i < num_frames; i++) {
-		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
+		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], 0, true) < 0)
 			break;
 		sent_frames++;
 	}
-- 
2.25.1


