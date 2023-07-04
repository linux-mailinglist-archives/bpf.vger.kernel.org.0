Return-Path: <bpf+bounces-3945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47C746C17
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0851280254
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8646BC;
	Tue,  4 Jul 2023 08:36:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9E2109;
	Tue,  4 Jul 2023 08:36:16 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9511E6D;
	Tue,  4 Jul 2023 01:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hb8TePXrNloDZf4lFHA0T7o3aQbEbBiRy1Sk6uOdJJB1fcJG+Yv7YY/6uG0Ysqq+5XBW0qibwbvoZc8sd0b87AbqOYig7Qe2E9LqECRZiRLOtvl02RrOBueadNkpoxDAgOPanWPjD3erHX3SgPGSx4AMYFzW+OH0fRN73iAYVAwewhNpmInyfr0krsnbfYAI2sM8s4YIjRUk9J3f721CeBSNKCKHhocDsxwcq/QkCSQN64LjbBWxOQSKXaM+fyMb7AAFN9HI6Jge+OmuAOhTJRL5KK8UXqmgYjhj0NHcRV8jYQ/jcYBmsSF6s7EyT2XzOsk260iAREaeyrtiKJ0puQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TWwRRQcHEQ7tvYFsKYoBGP06TNaHnyF++a8BaZNPbU=;
 b=lwVo93rE4Yh58xAQgiCZzqv9yoiVLJG14lxzrz2UWQc1cpVnQrIeqsYEK599572tVlQA1S52LAqqzU7P7ABiVP/R+epPL50cFbgCx5M0RVEtIbLtjPz73kb/Z6Hjrq9Aruiu9S4lKDhyYR7meePFy5+Vn0nQ02prX+Qn0ZxxDkijyCM0JHvkY8H5XgQfX4s3hZKWmmFs7InEphsB9r4kUvJzlobi7QHTIV1nSh2SiCLpyeQGYMOG8Y6xQ5qV1x9Lo1w+5jXL5A3NQG1rENHX4LTqUaCmhKWFCzFES7uFIPxvrTBNGBFJ7xj22vreueTYbDWbRfqALK+zt7Sw1fibCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TWwRRQcHEQ7tvYFsKYoBGP06TNaHnyF++a8BaZNPbU=;
 b=MiVJqOLnxnzngr/jn+Csq6hTHbKaPZ+C9q3en2lxHAD3hV8ayItrEUyMZGPRvAEFCgflFbRv0m+m8bPZbAcpQwYxG8eVtxbH3UKos8LN8kAOGT3dDz3Mo2XlvSxHNBhFE6XLXFV5QMNUUksvht1enurdy7t9AxSHMopbwhOrAHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB8PR04MB7081.eurprd04.prod.outlook.com (2603:10a6:10:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:36:11 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:36:11 +0000
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
Subject: [PATCH net 3/3] net: fec: increase the size of tx ring and update thresholds of tx ring
Date: Tue,  4 Jul 2023 16:29:16 +0800
Message-Id: <20230704082916.2135501-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e74ae782-50f9-465b-1f20-08db7c69b8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ONEYQpDOAA/ZtLHExvvzJ5EyWkJf1AuFICdWkPdCTjxcv5EpxBKZMoQyN9RUhB4TrrNZb2XRbvSrXKigbXPXwHKnjhsP7QU0sVTZ0BSlxUjXyD5wQR3yqKN7QwR2oqdyY8LXqbIXFu28WvWQ8v6rCLl3a/CM0y/h6jKli+BClQMkC8b9FNQXOjEF31djDBhW6r8S/ZA2HxePZKBwQanYawCZWBWjT1DECrll1seh7DHD/NnjwfTQDv9X4SlbZ4SSqaQEK2EQhzyDvVA3DwKajqY9z9ZtMr1MObDH6FN7jUzjpYnB3DnWemChctCrlUx/NOVcBwdAw+BYkIJzy2GI2/QwQPbzXlDJ/d7jCNs27OTltKOrKC85VMH1kelJsO86AoXQBS8KSUaBqT0aYHMacQhOPRB2u709HngPjUKhPvBXq5iKGwSJV60Of+x1eeeiRj+PPxqWA3sIiR3pc0AtZjtrAjTbZ4oBxPVaAB0Iy7om9qd+jyvYtXaPx3gvRkMwcPJpP736MfEaV93Gjqcnyn3tcPv2WXZ8hTy4IculL5favyweAD2jUi8gMaK9CWs90cEqQq+0EPHqj9j/vjECyjeU+m0CbcTn9exr6kHG9Qk14rR+D6heZSwXf/ANlJbL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(316002)(41300700001)(6486002)(6512007)(52116002)(26005)(83380400001)(186003)(9686003)(1076003)(6506007)(2616005)(38350700002)(478600001)(921005)(38100700002)(66556008)(66946007)(66476007)(4326008)(5660300002)(7416002)(15650500001)(86362001)(2906002)(8676002)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iBvaE2AoEFD/xTYfghkPrDO0bwSUs4BLeQV8bN9NpSvvjZ5Xs2bwJO7PlZUx?=
 =?us-ascii?Q?Gi8hU0f+fprUkXrZ6/QXkExV78EaSuEyk3Rhagm7vvpJt7Ub12IkhYALmdEW?=
 =?us-ascii?Q?bmCZxkMf41hWrIELpUYMh/NELVnevR3gaGBI9bxZM5YggbRhyoyC1iiadzG+?=
 =?us-ascii?Q?A3rk9HY0YzT1v0jRB4fpHxdhQX5HcCMIRGJ9o9CuqFbb56x74e/k3pXQilw4?=
 =?us-ascii?Q?B7Inw7FL17NpnlIh4Z4dBJzrLbbhude5bp1nL+Oom9lXD77k8AdU7LdYp2Kx?=
 =?us-ascii?Q?M1SxsqesnEvhTboIq5g2Yfc/aLvvkWiL090ZeujPd3ZcIHb2f/skDheUEVeJ?=
 =?us-ascii?Q?22mZHaeW2FG4qHT1qOCAw8ROPA285iGFa2tPNRgFxVzyu2WMlhJujUKRN+W9?=
 =?us-ascii?Q?bxdglhr9o4SsSEhZvXA/2aKJPT0O+SwHPlbTBT+zxTTy9pocMvcDY4V+xrUM?=
 =?us-ascii?Q?vSg05MzQlyvwFA/Sde85WYFLbtkr+9jqMBTnVqpOU1Phgp+m+Hp0GNTQzR3n?=
 =?us-ascii?Q?fvaTaemSn2aPGZx+eN7a9GnYSjUU6MXJdc42w3C+4zx8usnJdvDDzYdX17M6?=
 =?us-ascii?Q?kfkdq8O9LUoJwTWw/CU75s2lTaJzLJm3cTkDShOIGPPu6rSzSr5qviS0wwnA?=
 =?us-ascii?Q?d7kVXbcsvh7Fc4UIEuZSlDIgC4wanVNjY6Fis+n1ydTr6qhhkB5OU0FbsWwr?=
 =?us-ascii?Q?Y6MWvLfiOhILMxiHjTFzrggL6kMZJVwArXIMTroKGDiTqfaaTnrXQUcm3r8D?=
 =?us-ascii?Q?UbJMPLCFaNVnkJk2IO73JgR4WXCMAPAn1TDBWoKnk6QazVDQgG4rHo7tfL05?=
 =?us-ascii?Q?g16EUMKRK5VmiX3+1ZLCB6LaMxKjd5vThYno90oo03nhCPAfHAxfJrgXz7+b?=
 =?us-ascii?Q?6F+/t8AVBJpH+YXgPqAiuWqhszw3ieaP6q/1wAHZhVHgZrU/D/y7GTA7RvNI?=
 =?us-ascii?Q?ERSNKDLoFeffBtWMzcilGYjGGIySvM40i9hFfibkeDC4lkQxbPvDhCtXPJE0?=
 =?us-ascii?Q?gbT28sDZE5mkZdYoqlytur4fzOJDxhQZJUc68TAO/XL8iVWnyPBIz5asRoRT?=
 =?us-ascii?Q?q8J12v5wkzybD5CvtN/VrIg8eTKWPDe6K8HZ00/LjQe6AwRmkLiBgGsiEG5Y?=
 =?us-ascii?Q?jbGWR+tJ2bkdcdvy6HVn+AYNTur0pjeC1Xc3BNMYt/9gtfJ7jesU65IFV7Pr?=
 =?us-ascii?Q?5wKXE7JGlBbePjjNOPVXu19y9ZjlPoqea4/3tPjYqU0mLEEooUjgABUaABON?=
 =?us-ascii?Q?VUiXK5f23v/mZe5oHAstwzbImxHHW948Kjp8A5DSgw+85bYX01J7PASL7ZUI?=
 =?us-ascii?Q?vomYl1waf+4FPHtrItuDo89Wo97yc4jtF/sLuzr9Ffel0QN3FoE2S8gSCkKc?=
 =?us-ascii?Q?BPDQv1XO1ws3kDJ/j0nNUUA1wPLo55i8rqXEH1IGYqVZuoWSAvMmTLm2XNQz?=
 =?us-ascii?Q?LscCpq2yYIkSSwuxrlhG6eiHiMKM8OM+zaV69ZuDqwsXl2E6lLHG8+VOKwya?=
 =?us-ascii?Q?hyRK1R6eG538D0MDOoo3i+SR5uQiqwxXui6/UaiQGObzMM9m7Zsa7+9J0uTw?=
 =?us-ascii?Q?GQFVdgLU4xeZFMEMihcgWb3rUIPZ8js/QzuGYBza?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74ae782-50f9-465b-1f20-08db7c69b8ca
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 08:36:11.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcvOK+JsauLRIkJ3FBlrZuj18+/KuVtxZQDaMPCRl+O4Lq/BTM73hHxCKDa2PUdCCZMBVRKWVKmgF3ShGo7aKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>

When the XDP feature is enabled and with heavy XDP frames to be
transmitted, there is a considerable probability that available
tx BDs are insufficient. This will lead to some XDP frames to be
discarded and the "NOT enough BD for SG!" error log will appear
in the console (as shown below).

[  160.013112] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.023116] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.028926] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.038946] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.044758] fec 30be0000.ethernet eth0: NOT enough BD for SG!

In the case of heavy XDP traffic, sometimes the speed of recycling
tx BDs may be slower than the speed of sending XDP frames. There
may be several specific reasons, such as the interrupt is not
responsed in time, the efficiency of the NAPI callback function is
too low due to all the queues (tx queues and rx queues) share the
same NAPI, and so on.

After trying various methods, I think that increase the size of tx
BD ring is simple and effective. Maybe the best resolution is that
allocate NAPI for each queue to improve the efficiency of the NAPI
callback, but this change is a bit big and I didn't try this method.
Perheps this method will be implemented in a future patch.

In addtion, this patch also updates the tx_stop_threshold and the
tx_wake_threshold of the tx ring. In previous logic, the value of
tx_stop_threshold is 217, however, the value of tx_wake_threshold
is 147, it does not make sense that tx_wake_threshold is less than
tx_stop_threshold. Besides, both XDP path and 'slow path' share the
tx BD rings. So if tx_stop_threshold is 217, in the case of heavy
XDP traffic, the slow path is easily to be stopped, this will have
a serious impact on the slow path.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 2 +-
 drivers/net/ethernet/freescale/fec_main.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8c0226d061fe..63a053dea819 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -355,7 +355,7 @@ struct bufdesc_ex {
 #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
 #define FEC_ENET_TX_FRSIZE	2048
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
-#define TX_RING_SIZE		512	/* Must be power of two */
+#define TX_RING_SIZE		1024	/* Must be power of two */
 #define TX_RING_MOD_MASK	511	/*   for this to work */
 
 #define BD_ENET_RX_INT		0x00800000
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 940d3afe1d24..6c255c0d6f41 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3348,9 +3348,8 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 		txq->bd.ring_size = TX_RING_SIZE;
 		fep->total_tx_ring_size += fep->tx_queue[i]->bd.ring_size;
 
-		txq->tx_stop_threshold = FEC_MAX_SKB_DESCS;
-		txq->tx_wake_threshold =
-			(txq->bd.ring_size - txq->tx_stop_threshold) / 2;
+		txq->tx_stop_threshold = MAX_SKB_FRAGS;
+		txq->tx_wake_threshold = MAX_SKB_FRAGS + 1;
 
 		txq->tso_hdrs = dma_alloc_coherent(&fep->pdev->dev,
 					txq->bd.ring_size * TSO_HEADER_SIZE,
@@ -3837,7 +3836,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	entries_free = fec_enet_get_free_txdesc_num(txq);
 	if (entries_free < MAX_SKB_FRAGS + 1) {
-		netdev_err(fep->netdev, "NOT enough BD for SG!\n");
+		netdev_err_once(fep->netdev, "NOT enough BD for SG!\n");
 		return -EBUSY;
 	}
 
-- 
2.25.1


