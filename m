Return-Path: <bpf+bounces-4954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C9751F4E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 12:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32D31C208B8
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E60125C0;
	Thu, 13 Jul 2023 10:47:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24711CA8;
	Thu, 13 Jul 2023 10:47:34 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F63212E;
	Thu, 13 Jul 2023 03:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afjjUNnX/NlEnPrncd1i7X9r/e1jvqHMG+KOSv58m5PhYfEDpuXw9w1D6HvuYNNO23/xWyHiGLI61fZnlzEfc+THT8SJQoXN1v9aBP8fCz2ldz71905490UIN2wMksumO3Z9vKpMwnVPFAE6qz/nKLDrWkAmBCNQii5TvGP4BN52I8DiXRNsHwwEsYbUhsvXPsFgnZB3xE9DCGqMJ6enZkW1625yvqAeyStcbdjf2/vAL9BMNmxLkiIkUrsE9IqUwyP/OUy9G79BIJjcKqZwotZUYZJlnp8N9zv77SavrLD94TYl89Aja0IO5jfU05tU44GXXcF5Y4QtJq5Js74LxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfQ6bEsY+GPjml+M3MPjb5oAA/84KIhUztn1cuJRvHo=;
 b=SumxOmO8uB7gNEpCeNUqE7TOo1YdnnuZfCEcdqLeI01uRLpU5XHhlyOTj8PZwV4JHSY6khHTH9WYqB0sbSPchdkkdG1PIU0sZ0kWkgm7SmRle7umYTvP++TkB3WeMB3grYR2vq0ACucZ2eOqeap/ZEziLEl5aRGj0juBM2rHu4bhKtA2spm6NwJTys3mfm52fa1TLPsfTGeLPqbtlppzBu2N2WpdCLgaOMfEYpyfO2ExbpX66RP5UWMTSfZjM2ylcPKJX56NtJITtSBiPvEaiUq27Hda7IJY1XTjipTOC1gJAHkBCcq7fhaEkX2N+5yS59Jp4uUrLbcm2CAU9KGQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfQ6bEsY+GPjml+M3MPjb5oAA/84KIhUztn1cuJRvHo=;
 b=VkylrR2GMsqrhZKHTaa9pyOXA0hn+mCxUXacyS/AAIkDynZgJ12h10rawpU+EeiUmgVAi2KSiaxgdvIsX6uoEVz15o7lTS0GD8hPSuNwyK/C+TOAkcOJgpvibSFChSw6gO0nD5ByqiWRwm7gaz5rngGRS5nDQ/UBeSF0OgWujYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS4P189MB1917.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 10:47:24 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 10:47:24 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH iwl-next v3 4/4] igb: add AF_XDP zero-copy Tx support
Date: Thu, 13 Jul 2023 12:47:17 +0200
Message-Id: <20230713104717.29475-5-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
References: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000CB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:7) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS4P189MB1917:EE_
X-MS-Office365-Filtering-Correlation-Id: fc111c99-6fa3-4397-4ca3-08db838e8aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5GJicBNI5eg0efPSk5BJrdueb66n8b5Iqh97LrFBVMsFgOUVVEKM569Pudze6L5onWAw8ruB+waEJ0lrAjDNpZU0X0NZyUcId/chbN1VPrBbS9wp/tEvw65RTuG4pn2ljDZxOos3fj83UeSqZF3FW8Y2isqI4duHR1QNIAAC4NoaiPqie6UX9nLS3jXl/rK5fn8ewfJTPlUUh6ep7aAf73hkyF5s4zWYswfbFUAM6mEI0GG5yo8ffcaNIYFY45Mcbtw5LykklC3yPObPsuBfDIC5sYlHGVdIP1908sm3GCTQBDYWisyUE67HTsFP0NzcvZ6zlNEhhUrEIg2Q2jxGoR20ueLuO1gqX0DNJlJT5u4S6Hz/XUR61GiwQDz9MvZ5ppBqYLfaEdknEmcPyXzoD6KMopruoIwghAf8XVkSPMT9rCDduSooZJVJqDBIAog6N6Vh31N8sbsXE5yAft9/wYIxXexlngjnxUvM3ef907TIQIkWdXJU7dQ/f1Q0u+ncNnQYoYZOGNxhYX4kJ+1M4e3ECTY0JYvH0uRkuKgkJuJNOZ80pgaJc/lFukERv/BHm7byviu3Dm939nCQ5R9I2jXeoJ5Mz6pYPBS6Kgr6PjE8zuga9zcWgS33CK733Ezv1jIlCxi/CFOjI565qLIi2JFoM9IZnir5KMwcIO+5PTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(396003)(136003)(346002)(451199021)(109986019)(2906002)(41300700001)(316002)(44832011)(7416002)(5660300002)(8676002)(8936002)(36756003)(86362001)(6512007)(478600001)(6486002)(6666004)(83380400001)(2616005)(26005)(1076003)(186003)(38100700002)(6506007)(54906003)(66556008)(66476007)(66946007)(4326008)(70586007)(266003)(37730700002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQccqWThlEcKhTQ0aXeodeHMKNYiJz5aGRRJ1wluPWXPSPHuFTAWLk0+FI2X?=
 =?us-ascii?Q?wiDVSoBlrAyAyQcxmMZt3tJRz9kRDbxZ0dpncJ+UQc65WTbnsLQ6oU06xVvf?=
 =?us-ascii?Q?nm18BGXVW1k9huzRE6ugXhzfxVms+OPC6n0VN3OI9lM4GPsF4WYgDP+G+W0Z?=
 =?us-ascii?Q?XUXDFNznEWk8Su1uIkJlUNMmamBhmFEEjOzbj35z7kzl4qgMfkdg8oFaoYhA?=
 =?us-ascii?Q?hCYR+C9I+237aCIhCV42MP+JNs+kjUuOY4PTq5z0oeSdb8AHe7NAVysUyyyv?=
 =?us-ascii?Q?PR+qRzW3gVqvh/ocqlraxZlI8BRsQxChKyyYNpJ9DiVId/e5FFWwH2y94pba?=
 =?us-ascii?Q?ZDMC9SFLJR+OtnyftR2LVQz7kZiE4Csr0Sq1t2YFmuU9U2qnjMk9dHxvpED0?=
 =?us-ascii?Q?Ve3JdB2vh2Go2yRHnbGKDjT/mAc58VvQWqcGPwC7GiBprZbbmetwWG6aVWFS?=
 =?us-ascii?Q?vbe20GyN1rWXwde2O46IVCnEQXGK0P4npqH3vQQk3LnwMD3W+WZi5bQKdFpT?=
 =?us-ascii?Q?CbMwyHG8OPc3YcMDCVao7jBNO9Gfv3a4ZoRp7G4sAumylVj7Pv5rK/aiP+OO?=
 =?us-ascii?Q?3mma93dLY+BKZXtyTSLn635wu/Rnsh1Xk3T1nKcLXykOPhhlxdTQxNwScZDs?=
 =?us-ascii?Q?fYQreq3yVt3/MQfgzR74+bevrT9frjnib15uIMCMm9rZH2Cq9y128ll44kfa?=
 =?us-ascii?Q?xtMIZ+u6oLMX7SsA8TQSYcb3BwMOpQGzn+dzzIfxLhlAMIQAm6iG7cvPK2dq?=
 =?us-ascii?Q?MFzmV0g/F6ventx45x2O14H2KN/uBgZUAfki5p8MCS7ol8kYQxMxp4F5cTWg?=
 =?us-ascii?Q?PGS3lD9z+73DPXu0ZsV2biHPU3dK2dWYjUiKRYiVYiarS5XrbmOuuw9f2g0r?=
 =?us-ascii?Q?K8STPTPXhA9J5m11nYZZbIqhJervH8u9mnczEU3iv1VNB7Z9xumKKseKMnw8?=
 =?us-ascii?Q?HvHqNeJlJo5iypLYHQlwWWNmzhinrDSPrjkP5qqsXk/aipk812gosfOIhJtf?=
 =?us-ascii?Q?qthtPxjA3Uo7vM65ml7eB0WENfyebkgn3cvgxyOkFXWs8qtVRrGx6z8RAwlN?=
 =?us-ascii?Q?xw2FVf05hgnni7D1E0LN52z+OpEzJWzw/Af2rioGk+0xnHEcUREPrpzPXVcH?=
 =?us-ascii?Q?HPgkTJ+QrL8jRyQltfqv92JMVrOAGq0gCyx/U6/oXGQm8ANjD2rpXB79DZ0A?=
 =?us-ascii?Q?dZBxn5RM8jv3zcuG7aTldbqgfAWb9XDwcDS9f0C2/p1BC+8H9fRSMEyEDfrJ?=
 =?us-ascii?Q?ussWWvUq8/RLS9ynApYsLIlr/rji3p0vKJlT2MwN5MJqH9VaRVnScYotVmeP?=
 =?us-ascii?Q?o6HRnqlpsdyC0020lDqGB7Xw+xKnBpH4oynhSwAp9dV33BVd0PnggCAHcXdt?=
 =?us-ascii?Q?1XshH21NwPDmEOb+Ty6bsjgYteFh5q91N78kd/eZoQyjvutDgNpi+xi8bt7p?=
 =?us-ascii?Q?5xWxdgRNtb5PY0A/xcD6WUYLXfMG4Wocm91rmKz/hj210dQ1PjyMt3HH6FvC?=
 =?us-ascii?Q?QZsrlZvzVE1yDpjJBiEGxxkTTXbwnK4ETx1XACnjkV5XTrDJyGiIeMWP3Jq3?=
 =?us-ascii?Q?cR6NYDEduhJW+DBj0lxa4glwslsenPshEygYFHBGiYWXMurORj0JPKyybOoa?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: fc111c99-6fa3-4397-4ca3-08db838e8aa6
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:47:23.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEzbViPrb7wtUAYUh2UAYZK19ikOELdO10MF4zIeBl/xClrzouxi4XWk5iW7s8VprRytr6oW5gFO6KIafMwZR0vLFXFpSiBOqAwUiKhUXIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1917
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for AF_XDP zero-copy transmit path.

A new TX buffer type IGB_TYPE_XSK is introduced to indicate that the Tx
frame was allocated from the xsk buff pool, so igb_clean_tx_ring and
igb_clean_tx_irq can clean the buffers correctly based on type.

igb_xmit_zc performs the actual packet transmit when AF_XDP zero-copy is
enabled. We share the TX ring between slow path, XDP and AF_XDP
zero-copy, so we use the netdev queue lock to ensure mutual exclusion.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 drivers/net/ethernet/intel/igb/igb.h      |  2 +
 drivers/net/ethernet/intel/igb/igb_main.c | 56 +++++++++++++++++++----
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 52 +++++++++++++++++++++
 3 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 39202c40116a..f52a988fe2f0 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -257,6 +257,7 @@ enum igb_tx_flags {
 enum igb_tx_buf_type {
 	IGB_TYPE_SKB = 0,
 	IGB_TYPE_XDP,
+	IGB_TYPE_XSK
 };
 
 /* wrapper around a pointer to a socket buffer,
@@ -836,6 +837,7 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
 bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
 void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
 int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget);
+bool igb_xmit_zc(struct igb_ring *tx_ring);
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
 
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8eed3d0ab4fc..db99256ff1af 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3018,6 +3018,9 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 	if (unlikely(!tx_ring))
 		return -ENXIO;
 
+	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
+		return -ENXIO;
+
 	nq = txring_txq(tx_ring);
 	__netif_tx_lock(nq, cpu);
 
@@ -4931,15 +4934,20 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
 {
 	u16 i = tx_ring->next_to_clean;
 	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
+	u32 xsk_frames = 0;
 
 	while (i != tx_ring->next_to_use) {
 		union e1000_adv_tx_desc *eop_desc, *tx_desc;
 
 		/* Free all the Tx ring sk_buffs or xdp frames */
-		if (tx_buffer->type == IGB_TYPE_SKB)
+		if (tx_buffer->type == IGB_TYPE_SKB) {
 			dev_kfree_skb_any(tx_buffer->skb);
-		else
+		} else if (tx_buffer->type == IGB_TYPE_XDP) {
 			xdp_return_frame(tx_buffer->xdpf);
+		} else if (tx_buffer->type == IGB_TYPE_XSK) {
+			xsk_frames++;
+			goto skip_for_xsk;
+		}
 
 		/* unmap skb header data */
 		dma_unmap_single(tx_ring->dev,
@@ -4970,6 +4978,7 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
 					       DMA_TO_DEVICE);
 		}
 
+skip_for_xsk:
 		tx_buffer->next_to_watch = NULL;
 
 		/* move us one more past the eop_desc for start of next pkt */
@@ -4984,6 +4993,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
 	/* reset BQL for queue */
 	netdev_tx_reset_queue(txring_txq(tx_ring));
 
+	if (tx_ring->xsk_pool && xsk_frames)
+		xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
+
 	/* reset next_to_use and next_to_clean */
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
@@ -6517,6 +6529,9 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
+	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
+		return NETDEV_TX_BUSY;
+
 	/* record the location of the first descriptor for this packet */
 	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
 	first->type = IGB_TYPE_SKB;
@@ -8290,13 +8305,17 @@ static int igb_poll(struct napi_struct *napi, int budget)
  **/
 static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 {
-	struct igb_adapter *adapter = q_vector->adapter;
-	struct igb_ring *tx_ring = q_vector->tx.ring;
-	struct igb_tx_buffer *tx_buffer;
-	union e1000_adv_tx_desc *tx_desc;
 	unsigned int total_bytes = 0, total_packets = 0;
+	struct igb_adapter *adapter = q_vector->adapter;
 	unsigned int budget = q_vector->tx.work_limit;
+	struct igb_ring *tx_ring = q_vector->tx.ring;
 	unsigned int i = tx_ring->next_to_clean;
+	union e1000_adv_tx_desc *tx_desc;
+	struct igb_tx_buffer *tx_buffer;
+	int cpu = smp_processor_id();
+	bool xsk_xmit_done = true;
+	struct netdev_queue *nq;
+	u32 xsk_frames = 0;
 
 	if (test_bit(__IGB_DOWN, &adapter->state))
 		return true;
@@ -8327,10 +8346,14 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 		total_packets += tx_buffer->gso_segs;
 
 		/* free the skb */
-		if (tx_buffer->type == IGB_TYPE_SKB)
+		if (tx_buffer->type == IGB_TYPE_SKB) {
 			napi_consume_skb(tx_buffer->skb, napi_budget);
-		else
+		} else if (tx_buffer->type == IGB_TYPE_XDP) {
 			xdp_return_frame(tx_buffer->xdpf);
+		} else if (tx_buffer->type == IGB_TYPE_XSK) {
+			xsk_frames++;
+			goto skip_for_xsk;
+		}
 
 		/* unmap skb header data */
 		dma_unmap_single(tx_ring->dev,
@@ -8362,6 +8385,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 			}
 		}
 
+skip_for_xsk:
 		/* move us one more past the eop_desc for start of next pkt */
 		tx_buffer++;
 		tx_desc++;
@@ -8390,6 +8414,20 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 	q_vector->tx.total_bytes += total_bytes;
 	q_vector->tx.total_packets += total_packets;
 
+	if (tx_ring->xsk_pool) {
+		if (xsk_frames)
+			xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
+		if (xsk_uses_need_wakeup(tx_ring->xsk_pool))
+			xsk_set_tx_need_wakeup(tx_ring->xsk_pool);
+
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
+		/* Avoid transmit queue timeout since we share it with the slow path */
+		txq_trans_cond_update(nq);
+		xsk_xmit_done = igb_xmit_zc(tx_ring);
+		__netif_tx_unlock(nq);
+	}
+
 	if (test_bit(IGB_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags)) {
 		struct e1000_hw *hw = &adapter->hw;
 
@@ -8452,7 +8490,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 		}
 	}
 
-	return !!budget;
+	return !!budget && xsk_xmit_done;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 5e0244772914..c5d01d65e7de 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -432,6 +432,58 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget)
 	return failure ? budget : (int)total_packets;
 }
 
+bool igb_xmit_zc(struct igb_ring *tx_ring)
+{
+	unsigned int budget = igb_desc_unused(tx_ring);
+	struct xsk_buff_pool *pool = tx_ring->xsk_pool;
+	struct xdp_desc *descs = pool->tx_descs;
+	union e1000_adv_tx_desc *tx_desc = NULL;
+	struct igb_tx_buffer *tx_buffer_info;
+	u32 cmd_type, nb_pkts, i = 0;
+	unsigned int total_bytes = 0;
+	dma_addr_t dma;
+
+	nb_pkts = xsk_tx_peek_release_desc_batch(pool, budget);
+	if (!nb_pkts)
+		return true;
+
+	while (nb_pkts-- > 0) {
+		dma = xsk_buff_raw_get_dma(pool, descs[i].addr);
+		xsk_buff_raw_dma_sync_for_device(pool, dma, descs[i].len);
+
+		tx_buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+		tx_buffer_info->bytecount = descs[i].len;
+		tx_buffer_info->type = IGB_TYPE_XSK;
+		tx_buffer_info->xdpf = NULL;
+		tx_buffer_info->gso_segs = 1;
+		tx_buffer_info->time_stamp = jiffies;
+
+		tx_desc = IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
+		tx_desc->read.buffer_addr = cpu_to_le64(dma);
+
+		/* put descriptor type bits */
+		cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
+			   E1000_ADVTXD_DCMD_IFCS;
+
+		cmd_type |= descs[i].len | IGB_TXD_DCMD;
+		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
+		tx_desc->read.olinfo_status = 0;
+
+		total_bytes += descs[i].len;
+
+		i++;
+		tx_ring->next_to_use++;
+		tx_buffer_info->next_to_watch = tx_desc;
+		if (tx_ring->next_to_use == tx_ring->count)
+			tx_ring->next_to_use = 0;
+	}
+
+	netdev_tx_sent_queue(txring_txq(tx_ring), total_bytes);
+	igb_xdp_ring_update_tail(tx_ring);
+
+	return nb_pkts < budget;
+}
+
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
-- 
2.34.1


