Return-Path: <bpf+bounces-5648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEECE75D2FD
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEC71C2170B
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF9C20F9B;
	Fri, 21 Jul 2023 19:05:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A2200A6;
	Fri, 21 Jul 2023 19:05:35 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD84F30D6;
	Fri, 21 Jul 2023 12:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djiNATnMOshYIhIVRgnJRenk4a5tB4WTNmSR+BXT/TqsdomZLr5DDcRfVG0qsDvPFxykjDHWIu14rkbOFxPc/NvcYI8JG0l7WhRq9aU+ZJvh7jU5FIo/nJEKLmTjkED1cGE5OhsAU+qiOyf64cgamSSyUiKB3alqiB8Di2T7cWuyo83m+JoLA6BWBzaIYv4aL2GeCoD5cqEhUgFZ8BvWJDHhdwh6W8RrVBJNUxQIlWMDvLV9oL0eJ6gIg2jcteWKO0Gppb7EBtj9NigV7mh43fzWmWqZDHHeDu3PzBLSFYrRFXx6xRnAyo3FDUQ8bu3ko9+APvjY+xYpHs+4ViIVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3g9920JQfVxZeuukjp/9kc93iacgdEZVcwDLp6s+50=;
 b=DxcmznZggrROcFFg9nbw5d4nF+bWzTnq9MWpF9BlqzdXDX9CXMMfaFK1GvV1tmD29HlYi5Lk2jUiw398zhrQyxXeFvNHgibZRlqh3sgValld+eUeYQ661BI7kzTdUoCo1LhkNiaCZ3QaBxB0zkibn6RavHHg0C9nmKnUIuRN1IW2vavz3sihkQT8Aa3XWk2aklrU6NDIStm8fo5g8gVyWJg+ywVt/KLSFekIDJDsT3FCfiHy/1FhcxMo9zRq4ouHeh/6EyCc5KVgDKt8FroMCSxdLH8DsUQf6lB+/jSfSckHkgOLZ22GRCwp3vn4M8JC6YaZ3L16bjHO73gvKolVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3g9920JQfVxZeuukjp/9kc93iacgdEZVcwDLp6s+50=;
 b=N/bp3jEbJGJLJ5nwYkleWMh9GxcISRt7mYT4xZ1fkmKIjaKljKVPV6y7LJ8iVBQXpULL2dzKGJPLKPiloGng1koabXdm4veAcIqx7jK8+nlW2tghuBqTAyYGZGY6dAeKMlZZRNT3hHhHzWmJoZ6j1iPzenQYosyaQtyu+2tOe2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by MWH0PF2418FBE1E.namprd21.prod.outlook.com (2603:10b6:30f:fff1:0:3:0:a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.3; Fri, 21 Jul
 2023 19:05:30 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::9461:c35c:25c5:85cc]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::9461:c35c:25c5:85cc%3]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 19:05:30 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	sharmaajay@microsoft.com,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Date: Fri, 21 Jul 2023 12:05:21 -0700
Message-Id: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:303:83::12) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|MWH0PF2418FBE1E:EE_
X-MS-Office365-Filtering-Correlation-Id: b912c938-06a8-47c8-9048-08db8a1d733e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QxsWxSHKNjT16p6UIKsGg9YwxNMuiROJG5p3XHtT2IuxUNZumL0lNRux1CM9AF12a6k9H+DVF3S9A+BPGHNbmEpdN9YTpRflOsYcIIFddyD7m/PWmNwqA0kc+LXE6z+2xeEjJtk2mUMuvj4CX/lIu4fPpnbf6HqC23eLP/ix7i6JXxQkbLIrcoaHp/l2MHBOyJtJEWIWojQEy2lN3VsqwzaShxpPiDm7jL3UphitTBlMTDbqhspYPwBoSnmw+1tZNvBv4C/OsDCU1Bpj+aeYkeDm+gNte1DVBiYNkCOIGUefz7B9gmQ39v+w40D+Z7AqkfO/89kTMS6MU3p0hMnWHlxPCgBooDMm54QPPdMJycy/EXHbBJXg2fs46u22F9MVbt0Hr/zSAhoGFHeB4UBEzzttXQ1zyxbH4O2PNFxs4uVvt7g/dunekbFVUeHj9p3aE+3/gEFyocY5Q+AZo35oL+HoKI68GY5UYHOGOaDS1snLyYe9uNpXvLc9VaRCGMQsMom+jjRy8cLrg/wR6tcJbTgwmD+/pkvt/VKeh1mjePmc88Hm23iX9Me2pxjH2RDH5y57PzIHFmIO40K8B2UH51o/3LOXL44ycnAhrTAC8kXoJMd5WH6EWCVGw4XeUWZpXaAjkLzzMTMuPPlMWxCiI6c/f7rbgUeTXoJOv1rC/b4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(7846003)(6666004)(52116002)(5660300002)(6486002)(186003)(26005)(66556008)(6512007)(66946007)(66476007)(6506007)(4326008)(7416002)(316002)(41300700001)(8936002)(10290500003)(82960400001)(38100700002)(38350700002)(8676002)(82950400001)(2616005)(36756003)(2906002)(478600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMdnHLaWIEdgL7ZanpV7ZWZueOIkBOv8uwLgbfn+fBj0jHUnC3ZKwyImq3Wo?=
 =?us-ascii?Q?fZFagBCEix96CFV3Sl8lY6zRpmBTawQQCPXoz8Oe9cc9X+mQKLKJp35DqACe?=
 =?us-ascii?Q?0OotXNr7o4Okii9CE16FxFxKcNSg59SKAGB+ZD1UksQWHi94JgX5GyzA+NHU?=
 =?us-ascii?Q?D1Z8hE7/cfq/W4ff6TT/ju9E9knOwwHRXzsuT4fc6Y0tMapya8UAvGfiw222?=
 =?us-ascii?Q?u/a6wuDo+ywfvLR1EzS5g0wsrIGBBt+bTTjXRa/bq9Bt3BDaDGu3IySuJ+zx?=
 =?us-ascii?Q?eDmDh+I5bqUYvBaUIxCfwceNcZlpjF4SpniLse3/a63MyJvV52i8ffyWumP6?=
 =?us-ascii?Q?Ji5uTYZLWou1aQBEMcgxx19Tz7CxMYxzk2S4wI1ABP79h362WXi+ivC7WO6f?=
 =?us-ascii?Q?HOp2ZlE9PDjLKziJ7oChPRlJmjWLpoddKI8wly8hfU0EWW62hoju1aFoHKVc?=
 =?us-ascii?Q?sjoeNSBGztSuRHwOWrVHJJBmJ/voFGu8mBIuvGJOho49gYziXD3lLdutdLwA?=
 =?us-ascii?Q?pRKMG5RgA+5NgDvcTdUReWPbQTrdlpfcATx+rAojESsj+Df9C3LDJEQmoqXv?=
 =?us-ascii?Q?Ex7GSogwtag18Rqm6bqpfBREp2pmsF7VrxWyw9uwf/lb4v4xOvx7p1rGnJQG?=
 =?us-ascii?Q?gTdL65NxlnG0JTRVqWU70LWDzZtOLhEEaKCO+NcQwzQlvyjigdlbqkhdIvAf?=
 =?us-ascii?Q?umXXcZnIknIex+61Gh+B+YPa7CVn0RwxldcvCgBVxZFpEpLwO4jp76x9Rvbq?=
 =?us-ascii?Q?n+zLj8Qk0VYwbshdbteDYyEmxjLtF6J6VriEJXn5redk7B0tbGuU6l4QFoWO?=
 =?us-ascii?Q?fpa/2ebbBNvQIhSFpDZccd/ckTG67DeVp2i01n1bKzYYNSvXwev9i45CYXyy?=
 =?us-ascii?Q?EjNFLkV0N1MMfI/1B4q/Pqn9A+HFG/o+ShKUN8hIRbW1YRbvHjc8mlyLXLB8?=
 =?us-ascii?Q?+P/OgTaJ2VaOp8zVJid9x+MwEocxf5i7JXCAqzTfU0rQOvdlZvS2ggH/py5+?=
 =?us-ascii?Q?geMkNJKYhAbpPyWCkk+O4zZUQ0Y0f93TFG2RdqHbcwJiRkJbcsS1IdNJ2PLp?=
 =?us-ascii?Q?tuSpP/WM6ZUjk9R8rk7gE5SQmbhYGrygHHljiBnceOBwX3gSVZkrN+gQiGWL?=
 =?us-ascii?Q?7JVPXWtmo/OCYcO8ftz59LpG14fQX4KkaOtO2I5WTm5twgUgqZhtRvhLlVjm?=
 =?us-ascii?Q?KNimgkwg/34ZRQBTD0IkVfHhPMuQ56D056uhXbtK+yRsVYVFbSkrf7+GTRIp?=
 =?us-ascii?Q?cW/ujRglIjeuqXFhrtCUC0oXRKwgChOaTsw91nWmo0R2EEQ31XqEKu2awIjv?=
 =?us-ascii?Q?W6XsbUFYZRfauGUemhnQbJa38NjQiRsM5TWDbDsktrpNq0xpgMJ37K1pOHIh?=
 =?us-ascii?Q?qwOz6uGhRHz0DOQrHFvXb/IjA1SfiOqetDx94y6eW8KksHBMgenAOuRYYf5X?=
 =?us-ascii?Q?h3FgCSOVoTuHDU/KHlFcQ1yUNyiFqzXq28MyDl7CMK6N5vPYWeSZAOrCEchR?=
 =?us-ascii?Q?GvLAoiYfZg9zrpr0mUDDSHTIGGHO3jbFYXvcbez7h94HLFlcCddcgmzULiZk?=
 =?us-ascii?Q?91Vtzumy8NVDZWvalkKvx4dAFoInaVeNY45Bz7x+?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b912c938-06a8-47c8-9048-08db8a1d733e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 19:05:30.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HhcBx7jM87wDy4wuqE34bS4nIwdpbk3aRYcuFhJMJ2Jh5V006oEgcxug2r15tyoc3sWrItaOl8qlJRhjU/b7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PF2418FBE1E
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add page pool for RX buffers for faster buffer cycle and reduce CPU
usage.

The standard page pool API is used.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
V3:
Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
V2:
Use the standard page pool API as suggested by Jesper Dangaard Brouer

---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 91 +++++++++++++++----
 include/net/mana/mana.h                       |  3 +
 2 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a499e460594b..4307f25f8c7a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1414,8 +1414,8 @@ static struct sk_buff *mana_build_skb(struct mana_rxq *rxq, void *buf_va,
 	return skb;
 }
 
-static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
-			struct mana_rxq *rxq)
+static void mana_rx_skb(void *buf_va, bool from_pool,
+			struct mana_rxcomp_oob *cqe, struct mana_rxq *rxq)
 {
 	struct mana_stats_rx *rx_stats = &rxq->stats;
 	struct net_device *ndev = rxq->ndev;
@@ -1448,6 +1448,9 @@ static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
 	if (!skb)
 		goto drop;
 
+	if (from_pool)
+		skb_mark_for_recycle(skb);
+
 	skb->dev = napi->dev;
 
 	skb->protocol = eth_type_trans(skb, ndev);
@@ -1498,9 +1501,14 @@ static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
 	u64_stats_update_end(&rx_stats->syncp);
 
 drop:
-	WARN_ON_ONCE(rxq->xdp_save_va);
-	/* Save for reuse */
-	rxq->xdp_save_va = buf_va;
+	if (from_pool) {
+		page_pool_recycle_direct(rxq->page_pool,
+					 virt_to_head_page(buf_va));
+	} else {
+		WARN_ON_ONCE(rxq->xdp_save_va);
+		/* Save for reuse */
+		rxq->xdp_save_va = buf_va;
+	}
 
 	++ndev->stats.rx_dropped;
 
@@ -1508,11 +1516,13 @@ static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
 }
 
 static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
-			     dma_addr_t *da, bool is_napi)
+			     dma_addr_t *da, bool *from_pool, bool is_napi)
 {
 	struct page *page;
 	void *va;
 
+	*from_pool = false;
+
 	/* Reuse XDP dropped page if available */
 	if (rxq->xdp_save_va) {
 		va = rxq->xdp_save_va;
@@ -1533,17 +1543,22 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 			return NULL;
 		}
 	} else {
-		page = dev_alloc_page();
+		page = page_pool_dev_alloc_pages(rxq->page_pool);
 		if (!page)
 			return NULL;
 
+		*from_pool = true;
 		va = page_to_virt(page);
 	}
 
 	*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
 			     DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, *da)) {
-		put_page(virt_to_head_page(va));
+		if (*from_pool)
+			page_pool_put_full_page(rxq->page_pool, page, is_napi);
+		else
+			put_page(virt_to_head_page(va));
+
 		return NULL;
 	}
 
@@ -1552,21 +1567,25 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 
 /* Allocate frag for rx buffer, and save the old buf */
 static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
-			       struct mana_recv_buf_oob *rxoob, void **old_buf)
+			       struct mana_recv_buf_oob *rxoob, void **old_buf,
+			       bool *old_fp)
 {
+	bool from_pool;
 	dma_addr_t da;
 	void *va;
 
-	va = mana_get_rxfrag(rxq, dev, &da, true);
+	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, true);
 	if (!va)
 		return;
 
 	dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
 			 DMA_FROM_DEVICE);
 	*old_buf = rxoob->buf_va;
+	*old_fp = rxoob->from_pool;
 
 	rxoob->buf_va = va;
 	rxoob->sgl[0].address = da;
+	rxoob->from_pool = from_pool;
 }
 
 static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
@@ -1580,6 +1599,7 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	struct device *dev = gc->dev;
 	void *old_buf = NULL;
 	u32 curr, pktlen;
+	bool old_fp;
 
 	apc = netdev_priv(ndev);
 
@@ -1622,12 +1642,12 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	rxbuf_oob = &rxq->rx_oobs[curr];
 	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
 
-	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf);
+	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
 
 	/* Unsuccessful refill will have old_buf == NULL.
 	 * In this case, mana_rx_skb() will drop the packet.
 	 */
-	mana_rx_skb(old_buf, oob, rxq);
+	mana_rx_skb(old_buf, old_fp, oob, rxq);
 
 drop:
 	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
@@ -1659,6 +1679,8 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 
 	if (rxq->xdp_flush)
 		xdp_do_flush();
+
+	page_pool_nid_changed(rxq->page_pool, numa_mem_id());
 }
 
 static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
@@ -1881,6 +1903,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	struct mana_recv_buf_oob *rx_oob;
 	struct device *dev = gc->dev;
 	struct napi_struct *napi;
+	struct page *page;
 	int i;
 
 	if (!rxq)
@@ -1913,10 +1936,18 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 		dma_unmap_single(dev, rx_oob->sgl[0].address,
 				 rx_oob->sgl[0].size, DMA_FROM_DEVICE);
 
-		put_page(virt_to_head_page(rx_oob->buf_va));
+		page = virt_to_head_page(rx_oob->buf_va);
+
+		if (rx_oob->from_pool)
+			page_pool_put_full_page(rxq->page_pool, page, false);
+		else
+			put_page(page);
+
 		rx_oob->buf_va = NULL;
 	}
 
+	page_pool_destroy(rxq->page_pool);
+
 	if (rxq->gdma_rq)
 		mana_gd_destroy_queue(gc, rxq->gdma_rq);
 
@@ -1927,18 +1958,20 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 			    struct mana_rxq *rxq, struct device *dev)
 {
 	struct mana_port_context *mpc = netdev_priv(rxq->ndev);
+	bool from_pool = false;
 	dma_addr_t da;
 	void *va;
 
 	if (mpc->rxbufs_pre)
 		va = mana_get_rxbuf_pre(rxq, &da);
 	else
-		va = mana_get_rxfrag(rxq, dev, &da, false);
+		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, false);
 
 	if (!va)
 		return -ENOMEM;
 
 	rx_oob->buf_va = va;
+	rx_oob->from_pool = from_pool;
 
 	rx_oob->sgl[0].address = da;
 	rx_oob->sgl[0].size = rxq->datasize;
@@ -2008,6 +2041,25 @@ static int mana_push_wqe(struct mana_rxq *rxq)
 	return 0;
 }
 
+static int mana_create_page_pool(struct mana_rxq *rxq)
+{
+	struct page_pool_params pprm = {};
+	int ret;
+
+	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
+	pprm.napi = &rxq->rx_cq.napi;
+
+	rxq->page_pool = page_pool_create(&pprm);
+
+	if (IS_ERR(rxq->page_pool)) {
+		ret = PTR_ERR(rxq->page_pool);
+		rxq->page_pool = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
 static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 					u32 rxq_idx, struct mana_eq *eq,
 					struct net_device *ndev)
@@ -2037,6 +2089,13 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	mana_get_rxbuf_cfg(ndev->mtu, &rxq->datasize, &rxq->alloc_size,
 			   &rxq->headroom);
 
+	/* Create page pool for RX queue */
+	err = mana_create_page_pool(rxq);
+	if (err) {
+		netdev_err(ndev, "Create page pool err:%d\n", err);
+		goto out;
+	}
+
 	err = mana_alloc_rx_wqe(apc, rxq, &rq_size, &cq_size);
 	if (err)
 		goto out;
@@ -2108,8 +2167,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq_idx,
 				 cq->napi.napi_id));
-	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq,
-					   MEM_TYPE_PAGE_SHARED, NULL));
+	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					   rxq->page_pool));
 
 	napi_enable(&cq->napi);
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 024ad8ddb27e..b12859511839 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -280,6 +280,7 @@ struct mana_recv_buf_oob {
 	struct gdma_wqe_request wqe_req;
 
 	void *buf_va;
+	bool from_pool; /* allocated from a page pool */
 
 	/* SGL of the buffer going to be sent has part of the work request. */
 	u32 num_sge;
@@ -330,6 +331,8 @@ struct mana_rxq {
 	bool xdp_flush;
 	int xdp_rc; /* XDP redirect return code */
 
+	struct page_pool *page_pool;
+
 	/* MUST BE THE LAST MEMBER:
 	 * Each receive buffer has an associated mana_recv_buf_oob.
 	 */
-- 
2.25.1


