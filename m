Return-Path: <bpf+bounces-3954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D0746E24
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2721C20A6A
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895FC5667;
	Tue,  4 Jul 2023 09:59:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8B539F;
	Tue,  4 Jul 2023 09:59:29 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2127.outbound.protection.outlook.com [40.107.21.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BCEE3;
	Tue,  4 Jul 2023 02:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdZ8zNqVbdVPmt3nmC7wb6G8rt32EUEruWsaYoKFZ+f7WZ0CUORAIovKfpb+pQowlB+ZZgy8MY1BOkkW+QNZIf+34wdv2HNciGqTaOsGSvS+1PbjJqXsiOJAHK47ZDCfUtkhUf2JVSXt8Kd3V//A5WpzIGaA3UVom2cCc8Df/HKwcuqg1vErMtqDd55so0BqJF9LYN0qKTBymHUy0+1UkrwosvWWQ35voao2q7o/2MwqFZ0sH6ET8kAIIvby+Iyjg7L93si2lciKtLlOXU71X9u+sLfii6XNH1Oc/GKeDRatkH+SMoidfNTduGCXs9JymlUVAknXG98jI3SRcXnGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVLebntA80EuG73ibgsfp75GvO+YyAx6vaDBJzrEMGA=;
 b=McUgYUIa7mNrn6Uop+CuOoCEw3kFssd/M8RIKCly+FGTCYn2UwYNGgAXRG02o8dkTEY/KBqqyvP+KLYk151uaCs8EEO2qZUWonNCGsiHRWUenMAOdXfwHJdEZGNigy03zF0Es49i+b746UQRpzoERVj07l6AkUkHgyjVHU3CaN6l8ydcl6LwZKKfcIuN4yTh+/xWSvqo3JigXgwQtgN2wsWZaISQlFKQ3MzULa/5UR+V5ejeqe84PXWz1EEb1Zeb99kJMqs/sRe6QICZYSPeVTSKKzWf68H+Dhh4xx8KlOQsPhqOzY3OMh0ZmN4k3ff64BVn2KAzzAezBJlErbB6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVLebntA80EuG73ibgsfp75GvO+YyAx6vaDBJzrEMGA=;
 b=hqqvrIlR7uyTF0kIiOncQyVzhE6NoeImv20WRC/Z/NdZ6n+rGamZMCT8DwPFtpWhUw9pDMPC4RfrDwq7NxT7FtXBdF4QcavDfDsFYFxaRLw4nws6vydSF7wwTg3567259faz7GhqdbD/jVn4JXzH8ryEMjR/R9AnFIn0gvbwCCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AM9P189MB1571.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:306::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:59:23 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:59:23 +0000
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
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH 4/4] igb: add AF_XDP zero-copy Tx support
Date: Tue,  4 Jul 2023 11:59:15 +0200
Message-Id: <20230704095915.9750-5-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704095915.9750-1-sriram.yagnaraman@est.tech>
References: <20230704095915.9750-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00000105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:1c) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AM9P189MB1571:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c385f38-bc44-4d77-9734-08db7c75577c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6XreAdHUQepLfue36w89f/TQfgYJWi2pcdZbQjlfUj9DQB/czh/Xiorq+FaV04ZmZwopk7/h9IPYGMkyiZOa3ufKA3BnKU6CHG0zW+pwi5MY20t+8/2Try2NUZMk9FIM6jtgF4VgAC/VxkWSuUhH2OOJBCzRKyYfiOLOyvjMfOZ8qS9dylTfyarTcw50Rel+Y4133WanxoOcEWlQ3KdgrVswaBBxkYT1lW8drQpr8LQT1aZlKEyzjJquZ19GUa7Ff5q93VYQI6rj3lNcSLWU+ajcN+HJpQwrp1Blu6ZeNC8wTlNoqL70QHbYnuRRtrGXwiULhGpPR/hyCTyAfgJJczRBeP1BpzsAEGdckgYEqRhkindSbUoqbNQZOJ4BRjH4b2krI1MFH9pu6SSyJh6Ie/xWZXheOH5TktDchkJ8Z4E+T98IBl4iRkPNpALI0DAURzAGz2RYNHiiM7mHOFzsRffN5CZJ38PQf9CKBbUf3bAAI0R3inYN5XNCeK2+wjWClZff9NwidnKo4wxyCRYTINQOwGmgT+mhJFIwWlAL3wSqeYMxccfZdMqFSRMIqG4pbX9bTWOfClXPYNkc7WnLKyjig+njB98go9/E7zUCwKbJ0GBntINUVjSuH1Bl/VoOtRj8CzusjddgU0hAgiDNeeIruosHTMK+W6Kp0UJUtYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(39840400004)(451199021)(109986019)(2906002)(41300700001)(7416002)(5660300002)(44832011)(8676002)(8936002)(36756003)(86362001)(6512007)(6666004)(6486002)(478600001)(83380400001)(26005)(186003)(2616005)(4326008)(1076003)(66556008)(54906003)(66476007)(70586007)(6506007)(66946007)(316002)(38100700002)(266003)(37730700002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naV15ASSGc6eAJDwRP1ugPU0gouUMwPouQGcmijJWSAuN1z0+FT+gG5HK1hl?=
 =?us-ascii?Q?J6LBpTQDMweRwjLymSpD/k9/PRR7ui5jPQ57895bZPbFCkhRIfg/ACsleJ8s?=
 =?us-ascii?Q?490JrFik6zRSaSq8HFVm4yvzr2HHHfOT1+sQN/3ayLEMIAGxF9EcCiqgTftT?=
 =?us-ascii?Q?lF5QqOVYr2k9K+dfY/pTfQ1irAJkPGRpHR3rffGHtE8sYO9sptlpSg00yvmb?=
 =?us-ascii?Q?YZXCGEwUEDnL18IpiNY0YdWVrvGpOZfh5O0efkfDcRSHt1Qp1dwZgNa/EgpJ?=
 =?us-ascii?Q?5b833/IFtKOYV96qTa3YEzhlbqnUmbMvXeQMWjtPVK3mhfIfs2M39+V0Y+4T?=
 =?us-ascii?Q?aJ08t+gbqBnWYDI/TqJqkiyWGmj2FtdRQrgOFVpNkdahECqlEhtE8FgCoFfV?=
 =?us-ascii?Q?+H1VQVSdppWP/PDAQfDQtbUR6ZDLCjaBBB2iUctRR49drDpMzdIBZyfC3Fyx?=
 =?us-ascii?Q?4L+CowWYHeWLjOz1az+44gK6RzqfQUHRp/WsHqak/emiRlAaguMGNlB7ls/3?=
 =?us-ascii?Q?dt/WrXaxuJskCY8OxNa6my3WR5SiiGplTItZ3xGyzsXwT13rr2WxWtTmHMmy?=
 =?us-ascii?Q?Qmz2OOklZvghBI8Zgm+OC0B1Sx9z8e88kiiixPClOC5QoYniZLQavkf6LxyT?=
 =?us-ascii?Q?16V0z67avM13uMQwezoyd8Pr6S87DY3Fq/7TjTnGJNnndw1trzTVnV7hOxox?=
 =?us-ascii?Q?Ye98ZPs4AkC200icglJAAkcoJsjNOCeIpIvzOrEuBg0UoaQq4EkNalPiKDl0?=
 =?us-ascii?Q?DwCzqdfa/YdU2xHcx+aAF87Sjacz9ihRvcVAlcwFwVBgfearuTO7D5tcRGmc?=
 =?us-ascii?Q?m4XpYU52LgWqNik4Tgwr+2UIGceLaxYMWQP/KNnvo+8LOIoGSBydE6O4tqSg?=
 =?us-ascii?Q?3jz6zbnNmS3ErANInQ7877rFbeOGpBAxnTngx8PeUDBEcwudFLmeyUCShC/g?=
 =?us-ascii?Q?NeT9XoobwNwbQoEHN6raOXiGDRS7G9gYT+WFDBAlgti6G22EB167j79jv1d+?=
 =?us-ascii?Q?kjlTSnudf5RUCIpusVia5iM7bdiJsGRpXSfOL22aQVUHpNlBunLuhPgzDttG?=
 =?us-ascii?Q?OxfUbqQjteQ3A8qEpmTvS4YTQb8LXNYaU0UFJ0ZqdMzUnXyHKg+5Lkil+Sll?=
 =?us-ascii?Q?6glvuOptXzDNwgy3Q29MqOEj9MVHk/aELdPwnc7sX+yKHSE4nANJNHh8bKdG?=
 =?us-ascii?Q?7lC+M5fVlYhr3kiE3ZSOqyxyoVkoiTxDN8xyecpnpk79OU1BO8JTpYcI6/+p?=
 =?us-ascii?Q?bjxyAJUCMDonnFpQEiTSnrdHH3TyZW+JjxXBAgPTtEh2iJXCc9COWvw4ZYWX?=
 =?us-ascii?Q?SO0L70NfDlyBLVEmVtRYbmQ7nm2wKMukC85XXCXtLVRIo0+dgYrtCZUMngGk?=
 =?us-ascii?Q?yr2c8X22GUScdhxQfT3mpfyFf8jBItxpQeI11H2bMEtyh+e+PGNVw+O+Tue3?=
 =?us-ascii?Q?1RpM3tFmh+A3LXVx/9yTxVaFxjugls+r87m85NsLLstOKpUj2vT1dA6Sgwjp?=
 =?us-ascii?Q?Wv3QKdz/IWzN1F5peHnOkcF6cFjsN1zbu970v4Oqavu/5Lb8e3M16MLkWhVA?=
 =?us-ascii?Q?sfYab1LKnTupUxpUDAtVS0q94WPqGGcCX9ssiafZgMdwUdMuJ+uxkeELfLHY?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c385f38-bc44-4d77-9734-08db7c75577c
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:59:22.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zV2eGMnNxdNkQbhB9Pq5JGPwbVsQNZzdsEP0/0dxJ6xyL8JJpvAT8O8Lz7KcQ3fBY8BThMfTVSweyKzRk7VpsdVS7FmVv0zmv/YLz2dOPeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P189MB1571
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
 drivers/net/ethernet/intel/igb/igb_main.c | 44 +++++++++++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 67 ++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 4f474d7338b5..564706ab0646 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -257,6 +257,7 @@ enum igb_tx_flags {
 enum igb_tx_buf_type {
 	IGB_TYPE_SKB = 0,
 	IGB_TYPE_XDP,
+	IGB_TYPE_XSK
 };
 
 /* wrapper around a pointer to a socket buffer,
@@ -843,6 +844,7 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
 		       u16 qid);
 bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
 int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget);
+bool igb_xmit_zc(struct igb_ring *tx_ring, unsigned int budget);
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
 
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f4dbb75d6eac..c6bb5b1944c8 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4390,6 +4390,8 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
 	u64 tdba = ring->dma;
 	int reg_idx = ring->reg_idx;
 
+	ring->xsk_pool = igb_xsk_pool(adapter, ring);
+
 	wr32(E1000_TDLEN(reg_idx),
 	     ring->count * sizeof(union e1000_adv_tx_desc));
 	wr32(E1000_TDBAL(reg_idx),
@@ -4970,15 +4972,20 @@ static void igb_clean_tx_ring(struct igb_ring *tx_ring)
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
@@ -5009,6 +5016,7 @@ static void igb_clean_tx_ring(struct igb_ring *tx_ring)
 					       DMA_TO_DEVICE);
 		}
 
+skip_for_xsk:
 		tx_buffer->next_to_watch = NULL;
 
 		/* move us one more past the eop_desc for start of next pkt */
@@ -5023,6 +5031,9 @@ static void igb_clean_tx_ring(struct igb_ring *tx_ring)
 	/* reset BQL for queue */
 	netdev_tx_reset_queue(txring_txq(tx_ring));
 
+	if (tx_ring->xsk_pool && xsk_frames)
+		xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
+
 	/* reset next_to_use and next_to_clean */
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
@@ -8330,12 +8341,16 @@ static int igb_poll(struct napi_struct *napi, int budget)
 static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 {
 	struct igb_adapter *adapter = q_vector->adapter;
+	int cpu = smp_processor_id();
 	struct igb_ring *tx_ring = q_vector->tx.ring;
 	struct igb_tx_buffer *tx_buffer;
 	union e1000_adv_tx_desc *tx_desc;
+	struct netdev_queue *nq;
 	unsigned int total_bytes = 0, total_packets = 0;
 	unsigned int budget = q_vector->tx.work_limit;
 	unsigned int i = tx_ring->next_to_clean;
+	u32 xsk_frames = 0;
+	bool xsk_xmit_done = true;
 
 	if (test_bit(__IGB_DOWN, &adapter->state))
 		return true;
@@ -8366,10 +8381,14 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
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
@@ -8401,6 +8420,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 			}
 		}
 
+skip_for_xsk:
 		/* move us one more past the eop_desc for start of next pkt */
 		tx_buffer++;
 		tx_desc++;
@@ -8429,6 +8449,20 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
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
+		xsk_xmit_done = igb_xmit_zc(tx_ring, q_vector->tx.work_limit);
+		__netif_tx_unlock(nq);
+	}
+
 	if (test_bit(IGB_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags)) {
 		struct e1000_hw *hw = &adapter->hw;
 
@@ -8491,7 +8525,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 		}
 	}
 
-	return !!budget;
+	return !!budget && xsk_xmit_done;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index eae616e7608c..8b60285ec242 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -25,25 +25,28 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
 			       u16 qid)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct igb_ring *rx_ring;
+	struct igb_ring *tx_ring, *rx_ring;
 	bool if_running;
 	int err;
 
 	if (qid >= adapter->num_rx_queues)
 		return -EINVAL;
 
-	if (qid >= netdev->real_num_rx_queues)
+	if (qid >= netdev->real_num_rx_queues ||
+	    qid >= netdev->real_num_tx_queues)
 		return -EINVAL;
 
 	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
 	if (err)
 		return err;
 
+	tx_ring = adapter->tx_ring[qid];
 	rx_ring = adapter->rx_ring[qid];
 	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
 	if (if_running)
 		igb_txrx_ring_disable(adapter, qid);
 
+	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
 	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 
 	if (if_running) {
@@ -52,6 +55,7 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
 		/* Kick start the NAPI context so that receiving will start */
 		err = igb_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
 		if (err) {
+			clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
 			clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 			xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
 			return err;
@@ -63,7 +67,7 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
 
 static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
 {
-	struct igb_ring *rx_ring;
+	struct igb_ring *tx_ring, *rx_ring;
 	struct xsk_buff_pool *pool;
 	bool if_running;
 
@@ -71,12 +75,14 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
 	if (!pool)
 		return -EINVAL;
 
+	tx_ring = adapter->tx_ring[qid];
 	rx_ring = adapter->rx_ring[qid];
 	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
 	if (if_running)
 		igb_txrx_ring_disable(adapter, qid);
 
 	xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
+	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
 	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 
 	if (if_running)
@@ -335,6 +341,61 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector, const int budget)
 	return failure ? budget : (int)total_packets;
 }
 
+bool igb_xmit_zc(struct igb_ring *tx_ring, unsigned int budget)
+{
+	struct xsk_buff_pool *pool = tx_ring->xsk_pool;
+	union e1000_adv_tx_desc *tx_desc = NULL;
+	struct igb_tx_buffer *tx_bi;
+	bool work_done = true;
+	struct xdp_desc desc;
+	dma_addr_t dma;
+	u32 cmd_type;
+
+	while (budget-- > 0) {
+		if (unlikely(!igb_desc_unused(tx_ring))) {
+			work_done = false;
+			break;
+		}
+
+		if (!netif_carrier_ok(tx_ring->netdev))
+			break;
+
+		if (!xsk_tx_peek_desc(pool, &desc))
+			break;
+
+		dma = xsk_buff_raw_get_dma(pool, desc.addr);
+		xsk_buff_raw_dma_sync_for_device(pool, dma, desc.len);
+
+		tx_bi = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+		tx_bi->bytecount = desc.len;
+		tx_bi->type = IGB_TYPE_XSK;
+		tx_bi->xdpf = NULL;
+		tx_bi->gso_segs = 1;
+
+		tx_desc = IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
+		tx_desc->read.buffer_addr = cpu_to_le64(dma);
+
+		/* put descriptor type bits */
+		cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
+			   E1000_ADVTXD_DCMD_IFCS;
+
+		cmd_type |= desc.len | IGB_TXD_DCMD;
+		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
+		tx_desc->read.olinfo_status = 0;
+
+		tx_ring->next_to_use++;
+		if (tx_ring->next_to_use == tx_ring->count)
+			tx_ring->next_to_use = 0;
+	}
+
+	if (tx_desc) {
+		igb_xdp_ring_update_tail(tx_ring);
+		xsk_tx_release(pool);
+	}
+
+	return !!budget && work_done;
+}
+
 int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 {
 	struct igb_adapter *adapter = netdev_priv(dev);
-- 
2.34.1


