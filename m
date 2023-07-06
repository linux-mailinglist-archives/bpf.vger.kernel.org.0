Return-Path: <bpf+bounces-4197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B080C74974A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E100C1C20D27
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10A7490;
	Thu,  6 Jul 2023 08:17:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480613072;
	Thu,  6 Jul 2023 08:17:07 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309561BD3;
	Thu,  6 Jul 2023 01:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiVWv1qRUk+57Ru4j7BGi/KS4RGhFMmH19z1y2zRHNA+FP5emv9eIlJSRqOQcm4zpYQA7n//wI+MZk+r9i8qD+6tGm487hk/8Udt1+C7DmYnVd7w+BqrBxrZiEHRIjByeBXISTSPiaYw9mlKrlEpKa3QUy/ucohEvehc4Im1kc4HohuHQ1bW1EsJ2uj8xxxFGQ/kh3vC/V6Q7vY63do97DaHoihxPdtdyoPF0FaUmI+1AZrTLV5iPnPUnS6vKiKiujIVSZJt3dgT/hRukC6GjujdNzmxHRh/QYIz6z5C5Lw0v8y05+os88YS8ce4sFbUxG1xks393VBq2DXCi1cm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs4qsLvA4I1EDVqaUbosKk+vfTqETBtDOnTvr6bjeeg=;
 b=bWxOAIHh0uGS8Uidlw0NeLPrpTXKwq523BRRf2s+yTcX1PivnYHtGEWqMYUNUK5EA4rlawjTXjrnEkaj8YSNlS7kvketSZHe8Y066a7V0wmJSfaF61ty1sSaa51xZkrrPZRGFAJSfAUewNZzlbdKwESxGw/TVyBNgLspIhIMpRC5ckDZiQwB7FCZNFQvckezBf2ofP4P9PMkJj1yzN4PmFgRj6CzBvCyn0rubn3/FozqifS5MVd3DhfL4U0dcMurUCwt59in9LpcltyMurndQygZoddqxtBbF0f0phQx7e4pkcZN0bxnjW1mk28lEKsPbUXwkRSJiUgMm7H9ELpd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs4qsLvA4I1EDVqaUbosKk+vfTqETBtDOnTvr6bjeeg=;
 b=BMcp4QvMZGHcsorLjp49qL42jDoojm8k/FRpfXd6q2JO1c+MM2GZfpZPuw0BSlfl8AIKKi0PxkN5rFR/WcqYab+qvPQ2Tjwz2tPf8Fjwbe8ZYdfKG+HuPQXpdKRjnyHNLG+7uDyWdtmVwyGEEBZOtSzVYIG64Hj/JkFGFMBzYmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:17:00 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 08:17:00 +0000
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
Subject: [PATCH V2 net 3/4] net: fec: increase the size of tx ring and update tx_wake_threshold
Date: Thu,  6 Jul 2023 16:10:11 +0800
Message-Id: <20230706081012.2278063-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57d93597-865b-4b38-73ed-08db7df95f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JB8J4T4OnHgNGN9UBp2wOykthXpOI4zfhZg/OpTCVhKY6VaFSPU4o/ZV3EB4cDGJOf/IYup6OavXDUUq1zWBiGcJrcXcpwvkYycDnmU+2PezLaNY8503ao/sAN6T+UtyvtAHbzP82Bw0RoPPwyOK/uMXchbXIyROw18GuXcJqib8Mldxd3sFFTWQ1l4zn6f5N3KJUReRvQDNuh9sQRxOq7u0cZav0TCjgSw0po51M3Iujk7BPI2Hai41XpHUbsjtdqhU4wa4ipGQmct1VNMzHjIUK3Ew3pkKr9/4vOTcpfhjSnkKAYfUSaXDCm8kaCxTND32sGvE6xDtx47N0xUZVZo5AKbJLxvd2Wr/C6WppmWmD8ORdFh2ykhOTD/QPkDel3MFt8eXKlt/xybn0fFcghDWiQGxED9ns0c91FCLixAu/S1r0Rz2AjExcUxtqDx9j2e0p8ORFZ37d5qYELOjrwYgBejvJ3jRKtun5uzRVttGiIefKzaYqmVliBddOELKUttpAx+iF8cpMIFIPgYGmhjswOohZ/971oMnBtZUm+AZON8jZza6jUFMVGfBWHX73f9pTWAdJIPzHLCKoF8dC8x9ot2/KmfwrzbO+t6B8j4h4SwBtysMHvSzVUULtMSf9gCO45E5ijsNlcSj2e9NEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(186003)(8676002)(8936002)(6506007)(26005)(2616005)(2906002)(66946007)(1076003)(5660300002)(15650500001)(7416002)(41300700001)(36756003)(921005)(6486002)(4326008)(316002)(66476007)(83380400001)(6666004)(66556008)(6512007)(478600001)(9686003)(52116002)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NsLzbDFU2q7ZspDxpja/sZ2RoQ034+O+wtoNO/YypxA3S6ioi5B5pau829gk?=
 =?us-ascii?Q?BDK65Gw5unVX1SIjAbst0xDNpTgxkTXCMz4n9ccOl3AesfLQVdOwStISUC6r?=
 =?us-ascii?Q?70s4joynDDzcXKRxm7Rc1d/6Fix5VSehx0Y9UbfpIHWEuuroiKyXWVKRbC96?=
 =?us-ascii?Q?Y09PwobBBeWOwHSFmmSACR8M320/OKf8MayRlQOOBrouNUOUXamG6j98h9dB?=
 =?us-ascii?Q?dcPFlViBkb3Qn2070LMmDMOeflIiM/5peag8ICPHsO5DJr6I3F3qVug0AkNA?=
 =?us-ascii?Q?vwXcshe2OYkcyLweaW1kNN8vr9fbuZcw+LCawPSfZQAEjSgaG2tn8tSWscSs?=
 =?us-ascii?Q?a7vWVJaEIL3j++nzm4kCbAEK1QRxxUxgeXyxd9ZeylusVq3r7IhjgVvH9DJz?=
 =?us-ascii?Q?PiwRS1PRXktv5tPc4ln+KLbDkolDtMITV7SvLEFP675i0CZ3z/SPQL67UJTL?=
 =?us-ascii?Q?nKqxtVGsqpAp1EXqwRBrh91P5WzxzV3LyR8u+zTideyo7ejmUsWwYYkAjUFL?=
 =?us-ascii?Q?8pw31CZHuOhcNbA6uuAPKypxAmzuSPtR83G4/rUc9WZ/TsNsHb323cTw5xJs?=
 =?us-ascii?Q?zmclvY2N/3MTW1Km0+6O/aLFVMeTr/TGUGhp0VXrjqulrcB/TZ6N6QSezycN?=
 =?us-ascii?Q?7rucQzaybDzAD6o9myr2nA/gn0Ld5q/8vDfHH8z+sgBLmAL1Q4sj4ZpmNZy6?=
 =?us-ascii?Q?CrwZQzCPcu0kza4pVZDwOHnvBfaPswo+/+DPWPA0mtNSm8P7YEZEGF4bzBtc?=
 =?us-ascii?Q?IPSHTpwMydRipuS321QsdIInfOqH5gbFJjWJbGnS1IVoFTbWo+Z3QCI3rn8R?=
 =?us-ascii?Q?+HlQKSN/JkbyNWvEdn4fhIZLrdeVIG11v/xdigAGOdn07gVRR1NWuL6j3ORq?=
 =?us-ascii?Q?ZZbcHOz10meavRc6Q27qm38fWTdyHJMXfEVq03UbhExssC15wZBUUxCLu4Om?=
 =?us-ascii?Q?0mKwQhP7BrSCkf0yWeIPVM240DJ8FHYL0XJiKVFx+0BJmMaa76WIq3nNQY9R?=
 =?us-ascii?Q?qPG4AaZvyt8xgYYf2RRdgnmuCfrGmq2z62zkzdvBboTjxhfKwzIKRjFbCt8l?=
 =?us-ascii?Q?Bnjj6dcxmK58cJTwDv1jidgAsnRvoPFBikFXG28vPAaM0Yrlvvy1kfT0o8mi?=
 =?us-ascii?Q?D+UTWaG+eQKL6ShrV0VUM9uup9gxFvsRHVDO5sUoVMfJs08cj3xnD8MYU9aU?=
 =?us-ascii?Q?Xy7rMruOU1u4SIp6dufFN/CTiuHdzLjV7YJyqGOLKJ9GeJ9tVl3glAYWmmRz?=
 =?us-ascii?Q?WMQHBTfakC4+gkCw1lcU/Nk2gKmcZkN36CTPJmqGhzFPLZ6fgg3NktvtqnF7?=
 =?us-ascii?Q?7aO+Wu0RisfDj02iOwVnRvsajj2YjwRLUjvFd9cJFR4xbhwoyXLHfmjJ/9A+?=
 =?us-ascii?Q?NAyhbQ6P/WncKCK+WqfZbKJOBzP8lKFjfssC9n/Wyj9L5Xi4DoV0g2x+HbdR?=
 =?us-ascii?Q?Y1ZthIF86ht/x8QH3l/jPNAJDi7F3xC/HBdjltTJnFPh3k3arjn93vtXRsLs?=
 =?us-ascii?Q?9a1DgLjJBP3zEUOv3wxggFVSm7CxLu9lsJwsW5MNi7OOXswIslhkn4Rgcw/n?=
 =?us-ascii?Q?Al+EhdXfSSbrEPeQcRFZ/lLQunCxjUED6P1v4Yih?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d93597-865b-4b38-73ed-08db7df95f86
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:17:00.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpMMIuojwzE0BzkjX+gYbJTV+qTZ9MqA0Qrj9UifvHwMAEjIKcgFLbIwpLPSgvunkMQFWA9a5dET6DvtDCHD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
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

This patch also updates the tx_wake_threshold of tx ring which is
related to the size of tx ring in the previous logic. Otherwise,
the tx_wake_threshold will be too high (403 BDs), which is more
likely to impact the slow path in the case of heavy XDP traffic,
because XDP path and slow path share the tx BD rings. According
to Jakub's suggestion, the tx_wake_threshold is at least equal to
tx_stop_threshold + 2 * MAX_SKB_FRAGS, if a queue of hundreds of
entries is overflowing, we should be able to apply a hysteresis
of a few tens of entries.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 change:
1. Keep the tx_stop_threshold unchanged and change the
tx_wake_threshold to tx_stop_threshold + 2 * MAX_SKB_FRAGS.
2. Split the change, the netdev_err_once() is moved to a
separate patch.
3. Modify the commit message and subject ppropriately.
---
 drivers/net/ethernet/freescale/fec.h      | 2 +-
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

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
index 940d3afe1d24..c59576ab8c7a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3349,8 +3349,7 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 		fep->total_tx_ring_size += fep->tx_queue[i]->bd.ring_size;
 
 		txq->tx_stop_threshold = FEC_MAX_SKB_DESCS;
-		txq->tx_wake_threshold =
-			(txq->bd.ring_size - txq->tx_stop_threshold) / 2;
+		txq->tx_wake_threshold = FEC_MAX_SKB_DESCS + 2 * MAX_SKB_FRAGS;
 
 		txq->tso_hdrs = dma_alloc_coherent(&fep->pdev->dev,
 					txq->bd.ring_size * TSO_HEADER_SIZE,
-- 
2.25.1


