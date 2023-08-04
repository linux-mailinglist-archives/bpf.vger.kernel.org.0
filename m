Return-Path: <bpf+bounces-6964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9302F76FC32
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C8B28251F
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1604947F;
	Fri,  4 Aug 2023 08:41:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569569453;
	Fri,  4 Aug 2023 08:41:20 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2134.outbound.protection.outlook.com [40.107.14.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD2030EB;
	Fri,  4 Aug 2023 01:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKBT9MD8R5oIQuGjUv0rUudp0pq7qgliShUDc3VNZXrR/u48HQppVzuExg9q2hF5dSRqun+6ZzhYeuyAOn9X0nYapAeXbwuHRnhNj7EVRlmi2GVJI+/8Xk/qLOQUBs9Tdelp+3+kA+GYRF/i/nOiqbZ5jTgzM+gmZkjEyEgj+pKGR6RV/mCFB1pYUCi4hdEqDB887nmmdMrM+ksKg1J2KA+Le/TxzbX+TA0Id2DEAqbzOwk87DRG8ehnb+/CNTyygPrKVW1doBO/fDuK9Dp1Z16VjBYhbpHVMnAH33NxoSz103hpsri+xhYkSA4zkW+3zRjwdLasrDXMNSyl8OKeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0NmAlm4XOC2HDTtLjkZ3VYozmsL6PBGqVMMw9QZMhI=;
 b=DKLELfN0mSVUVy7fcZPs2li/D0/qkBYh28rwqhBCHOzox6lNI1A8uyc/8pRYW7A3JP1JbFznJrBSUFz81VFCndO8do6Q+3Pk4FKyWOLnH8mUfFuVHYp8qHRZgTlUTglVApJh+11SYfcfMXJu04xZcyrFxbpNt1uHyRoqv24VQS2IGcwYyIdF1Vk/3jp4HgUZp2nFdrmYkmCGCZddh+OZ6YEliJM8PpKQ4u+30w1cKsLNHvimq9jT4lUhQP1fnl493OvfdmCUw/ibZXtm9B6UaBWOYnehjv4x5mFM3ImVsQBgxiWDFUtIOqGZqWBH9Llthw4gjr8a3Kh/gGR1v/S0Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0NmAlm4XOC2HDTtLjkZ3VYozmsL6PBGqVMMw9QZMhI=;
 b=JqUueiu50/kGtv5Fu/rv0XYm9F1FL/TkvUHF65hnwXEzVTaLLbXSxPy9Wnt8XEiAo5h0mbTxyHWdU6oX+yk7cXUTog72uFsm+cbYJpiCOQA1Lokhecjf6ZE5tucDhGasPKLUIMZH6bYYRLFJdJAME41+S0xIWl/EPs3CNxHgXro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VI1P18901MB0736.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 08:41:15 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6609.032; Fri, 4 Aug 2023
 08:41:15 +0000
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
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH iwl-next v4 4/4] igb: add AF_XDP zero-copy Tx support
Date: Fri,  4 Aug 2023 10:40:51 +0200
Message-Id: <20230804084051.14194-5-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000D2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:14) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VI1P18901MB0736:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4b7bc1-4a52-42cf-8da7-08db94c6903c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W2J7cy+oKcmyzNIM25qyrubUe0xzQAiC4GAg9bcd9Q8bSwF9febeLm4RO/g9AZoWHvSQQ6MPUxl9Fj6eTMWZ8GH0TnA2LQs911j/z9U0kXJ2hQvaLUzGCmcn8Q7U1gqbsmpTII6c3DcGttndxwoZGhK9+jEz94FIpOTe2+7f0ggPD0D82tJevFFb9R4Te2nQbhZJXufC36kb+8D2KeRlza4snlZU57hT/PessltbNtToW+hs5EpoKzs6ZQ9WK5BkVj+n+QzZXxtMIBhiKiiho7CSUXX2Lc7D4cn1zKqo/f5b5l+IiaOHOvHul+IBd6U/jI24EJH06odvZzeWhfoU2hedwfNcbayl7W5jewxrd5NzpVOg7pBJrL9EeMIKOvRKDS3RoS0v8yt5uyumBJddVceOVLQhaPuk+yYVAhHz2j2RBfaNj8jMJcjnIW88fYC2Lb99qlNymdwrzbX2F/6ITbYf/jCFZ9V5MbWrA9UfQPlNDgtf+N5fTbfrVRdXTGZ/pa0fbnRFnzVD4AKSlXi3CBDuonBS73TUnaFMb1109kr+5CvBBy+t5frTo7h7jThEa7B6or2EQYRdkpajdrjTNRrpbpZqYd7S5yBjFCtS2ikWqXN07OKZs6gPh+uvkOhDUV4Hz637QwIKNKrCBmyr61dBI5BEy28oRnhiA9E8U1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39830400003)(346002)(451199021)(109986019)(1800799003)(186006)(6506007)(1076003)(26005)(38100700002)(2616005)(83380400001)(36756003)(2906002)(5660300002)(7416002)(44832011)(8676002)(478600001)(54906003)(86362001)(6512007)(6666004)(6486002)(41300700001)(316002)(8936002)(4326008)(66556008)(66476007)(70586007)(66946007)(266003)(37730700002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p2DdxCcty0dIRlTEW0Rfg1osManC+KAmSQ7fyW63mDr6OIKMLz9YXoZIxkRS?=
 =?us-ascii?Q?uVEk/EQ2HXBwpolTc81SLz2WrIiVKKLwoHvVOt6NQwo23+4/h5BSq/DZueCg?=
 =?us-ascii?Q?slatM4Tn0hKabSxKn/TkD+9AYdquvJSkbAPnXb53Oly9s0mVkxbveW5BuHDk?=
 =?us-ascii?Q?azq3nF8RkFErqP2rT+Sx6Q75viVT7+wOR8wMyVOqtsY3Cnh9154nqEXPHeAs?=
 =?us-ascii?Q?o6OwHLXlVOQW10WMb+iOnKUi7so71ymwKDNUrC5Gi/6fu5+SOMFTwYFhYE/Y?=
 =?us-ascii?Q?p4PovPFa8tdfB9kLK1Zj7//eSOgYsYmYkOmlbYfGz43tyFPuYWuW7dR85iKJ?=
 =?us-ascii?Q?u0A18Pe9oRjRIclejduhV1qO2rTOqvdliXBdovKB5GiY7OrHYIxUkpkixqz1?=
 =?us-ascii?Q?/QR+k6uTAWmNzrEDuVbt1tantnFYqVT3QyOC9K7O39KTrr10m1gLpLydA2PO?=
 =?us-ascii?Q?tLBK4WtFt2N+t1GMUne+YiMhHbmKhV0e2xMB7mygz/6ucAK4vzNQ/9YZbtN+?=
 =?us-ascii?Q?H9+IAuOTDv9bU0ZL34QjgCVxkM5BO7cRWL25Dtjd4j8VbmSIbBGgzM0ChrVS?=
 =?us-ascii?Q?GccrKIMZaEvOf+Ihj9rjOibx2MbGtS8sdtTROPPUjiaPFa6mMMpVawcF1940?=
 =?us-ascii?Q?/segqyCBVUTbK1ETnrB7V02T1739JcVf0czFWg5V4P3f7aR0EkAOqWml0Vqp?=
 =?us-ascii?Q?HtBCQPty72K6Yx2I7zj+IqQvsUvRvuSf6kvIhig6YfHOmxEgkkWOoHaY84SE?=
 =?us-ascii?Q?2RhM6B3F2WrHo/hIjnYUCgp4c5WsmoQtRjjXsYOAqepHXl4jPRhqnsclOp+y?=
 =?us-ascii?Q?HTqLnXy02J76GZZeN9aSzn4sSA3xoS1tvQEUeF5CB+Te6ZAd/5sosU5iTsHo?=
 =?us-ascii?Q?0sWkTQzq4CXB45V24R0YmOqaHJsXA/Zuwqxpl1F5mo2K6ppJHF4tLTydTLo4?=
 =?us-ascii?Q?O0e8suPFFgVdp21lgGUXbgVWPIAnVowqrMdFB0QRA2MDB7zrvNGsA1syH3jU?=
 =?us-ascii?Q?iZBBaNX4pdC1XkQxQ3HtZc9JhyyGMvvxKpQEypqzqaolaT0j1Bm5w1UI87WL?=
 =?us-ascii?Q?0SSAhFLa3Np/yhDo3Z1ugPASOAhsietNawAuHcFv6KDC1cTvBj96V3f1jo6I?=
 =?us-ascii?Q?FQWuUP4VuMDvM0pZhWr9CL3d91OS4QZY1LTD6EMcep32sceuQj7hUJWEXPvu?=
 =?us-ascii?Q?HhCW/tVUhY1GssY4D3WObRI8l0nmUg095h0XfWxta7LucxTb1lvDqJfX/edA?=
 =?us-ascii?Q?0jlepOPKlZzzZoYstw1sWwBP0SYLKhi7eJ+7h4szQJ4v3b7yp9w0BuIx51Po?=
 =?us-ascii?Q?Z7Yd2xdVt3M3LSdNppwqHLCgfM2+RyA37epijLCwdeifz0vIh4zAh284Lh3n?=
 =?us-ascii?Q?BbwCDTc2mThA63Mtz91+kFUBVPYah8Kl34BHSRPDscHp5DapTK0FIS2W+1Tr?=
 =?us-ascii?Q?6JW7boEwYJZVsvwh7wjok9tRx5vs/InUVwvX5BX+r5TWR1n2dm5IPwHenOcp?=
 =?us-ascii?Q?9+rclhDBKAeN1maHnPzYhV2ZEwfGvkmjC1opeDIwSgyk6g4gl7kZ2w6BmfaX?=
 =?us-ascii?Q?gHLRx8NxSYVkNv5sIAN6pE8CJdfnwqz9n5Jt9/b/dabTdk0Zus6y/WcpC5Sf?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4b7bc1-4a52-42cf-8da7-08db94c6903c
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 08:41:14.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc/nKZr6OG3Pa0nD7jx5ACqopeUXubLx6O2TPmsY03AKYnFBg43Yp9/47yxN37WklhnB5D6vR+JUoSz+vlSb4qveFqA/Tgfk8UbUQpN0fOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0736
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index b13cc94ac178..117c3d883529 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3021,6 +3021,9 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 	if (unlikely(!tx_ring))
 		return -ENXIO;
 
+	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
+		return -ENXIO;
+
 	nq = txring_txq(tx_ring);
 	__netif_tx_lock(nq, cpu);
 
@@ -4934,15 +4937,20 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
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
@@ -4973,6 +4981,7 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
 					       DMA_TO_DEVICE);
 		}
 
+skip_for_xsk:
 		tx_buffer->next_to_watch = NULL;
 
 		/* move us one more past the eop_desc for start of next pkt */
@@ -4987,6 +4996,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
 	/* reset BQL for queue */
 	netdev_tx_reset_queue(txring_txq(tx_ring));
 
+	if (tx_ring->xsk_pool && xsk_frames)
+		xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
+
 	/* reset next_to_use and next_to_clean */
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
@@ -6520,6 +6532,9 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
+	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
+		return NETDEV_TX_BUSY;
+
 	/* record the location of the first descriptor for this packet */
 	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
 	first->type = IGB_TYPE_SKB;
@@ -8293,13 +8308,17 @@ static int igb_poll(struct napi_struct *napi, int budget)
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
@@ -8330,10 +8349,14 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
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
@@ -8365,6 +8388,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 			}
 		}
 
+skip_for_xsk:
 		/* move us one more past the eop_desc for start of next pkt */
 		tx_buffer++;
 		tx_desc++;
@@ -8393,6 +8417,20 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
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
 
@@ -8455,7 +8493,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
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


