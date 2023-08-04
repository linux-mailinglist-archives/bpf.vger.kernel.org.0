Return-Path: <bpf+bounces-7038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406E07709BF
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E791A2826BB
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982C1BF0C;
	Fri,  4 Aug 2023 20:34:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183219891;
	Fri,  4 Aug 2023 20:34:20 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C552A4C3B;
	Fri,  4 Aug 2023 13:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYRWdgg7+jmqWVIDBGCJRMVUMAx4h8+Gxbx13hG3gQnXxUzKRc/VKJNKRoXFye0NmrJs9V0Xs5eorzOavFSzLDq1sM53HKk4AVrv/mfKjzzxczS50OKcfDSr+S97UvI2K8h0uqI8EemuO9cTO9FxaqpeT5joZN6Y8fTuDTUcH+dCJ3JcZlGe9tWtaluY8qLwU05W0Lq3Gnm1Mow3LiD0EUD6on2WYgdTx/FFfP1cFbYExwA0MDw/NkDZ8Yq/zO+V6RwU/UDZS3LGg2ac1pbRByS1Mk6pfyMiFzGK65Lsuw580fogkZF1yIhu+9CmS1bTJYPiDAaXalzRTENsF5Kehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xcd8feX6zZR9kDfyxS/LMzI4K1T2dST6F5r9HwtbY8=;
 b=kLQWgZCftGJRnyXRkMhRUhzVT9Bn0FHzpGZ7pT3qTBwlMewj5++VV1cazTh4WMhNyaTWDjCDZZw1jiUjF2luIsxJ7YirVrWWf2mEAhxrDl9c+0EKf5LwRmRfoJAtLmAKMoklyBI+z4YgAMvnGWntt3wBY/qyNg9Tkp96JmgU3yNTfWfB7tQqW8+D67hYpO0djNa44P+bxs1PR+wO7nUcFywYNKn9MPpu/16BKmf+PDvwiSy94y+Xka3lbwrGnSeIYVZKB83O7EU0K/PpXlNe4uIZ9JDZehF2GwSAX/USpiNMoQrJv0jdTMEEWLxHtj7YplO12UOFc8i8LTAXGFWJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xcd8feX6zZR9kDfyxS/LMzI4K1T2dST6F5r9HwtbY8=;
 b=QM5cs5i5c1OHP/WiHNGZ5keLXFpYPVvsYKUX9iooXtqgkiOXiw9Il0N5sth2DG+Xp5m5CiUhaKqn0kYX13SlJ65swYeIBilsXQCo7M5fgx8ZRz7u9g+yVud+kx5SF/ZFKwPadcX99vB1gqJs8e0xV5TQ7RMISisDpiVaMFNDSkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by PH7PR21MB3310.namprd21.prod.outlook.com (2603:10b6:510:1db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.7; Fri, 4 Aug
 2023 20:34:14 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::3df1:3a64:3388:9f97]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::3df1:3a64:3388:9f97%6]) with mapi id 15.20.6678.010; Fri, 4 Aug 2023
 20:34:14 +0000
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
Subject: [PATCH V6,net-next] net: mana: Add page pool for RX buffers
Date: Fri,  4 Aug 2023 13:33:53 -0700
Message-Id: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:303:dd::11) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|PH7PR21MB3310:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fb8771-3360-4830-19d4-08db952a2aca
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 /yiyYX0JYRvvp8hV5x4XZQ1qVLwifNhBnRN4RQyoQIhEX0pgEHs/wIdQoCnRCezYePD8AIjfRaflyWNryDbgNvnXi1PI+zYmYXY+ITGLWAWO/jzd6EwBcHmDJuktnsDiobYj7u8Maa/f7I8aeda016aZTEzpNm/uOpQDn4XJe7+kxr9ltynNH9VEFu1urdotJ6q3QYN9j2Yj6i9kGlPvkThNIBd9n1AJmROWBUGIf3AFU8JPi/zR27QreLBbGW0cpP7HwmetJE1R/7a90NnvvKkhTcjilIjwhQI+VczvyOITRRb+ag5RnYcNOWJhLDaVKMDvzIaYvpkdmMuVgBRr9n9pnD0jR/QVaPt+ury9rrEe/YxsMeKBhCMeLLDcdFFMj3ctN/2M73zAIozT3DAcNme76mvrneaFStP9sCT70TsUbk4U2CjBHPoS7CyWEpvAiObpfFRSHBFSANIbA1WxU6DF0qJ3P8ZrErlM0n5q+NrxJjYaf70j57pm/7QAiQl+SEP6rfkeDWP4xh5RT6VxAAUIXEMuW5r0+eRD0D8EiG6wTVuVQReUGdF1TJVVH/GVPFEqUvrjs5kILRvGZ/kI/BZIaPAu8nXAiV2O37q6THIkdMBRqJt43OUSTKQCi9b2WcSChcMezQtRuoy3AIuj1mAZ+GkJCtvSTnXYzY6NYlY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(186006)(1800799003)(451199021)(10290500003)(2906002)(7846003)(6512007)(6666004)(478600001)(6486002)(83380400001)(36756003)(52116002)(2616005)(82960400001)(82950400001)(66556008)(316002)(786003)(66476007)(4326008)(66946007)(8936002)(38100700002)(8676002)(7416002)(26005)(5660300002)(6506007)(38350700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?LG+SJOvNWriqYAEPfNHg4d9HYmfDYOY7uo8eQykvaiHxbK1tftXZqP/B9HIY?=
 =?us-ascii?Q?lrSP/dg7QuMJ2CwAaGgaQXSS8B/qsC2Y2k4zvy2NwnwA63s9e1MeN4bmyPX6?=
 =?us-ascii?Q?DA72aC8wAVI0SsUyCmSBhEe6+RDA5TCRjSIAiLHKEIOh7/lx/ROD8un8bRuG?=
 =?us-ascii?Q?NfIxkXp3n3z2gkmZxbIEQ/vvU4TDbbDcuI79zjmc7O5WHhKEUBjN8AmpxmtM?=
 =?us-ascii?Q?DUQ7VNX/ycN2nX38V1fm1nzdNNBWIwvOATKIgOIHcCiz4CFEV99Up+Fos1+F?=
 =?us-ascii?Q?hH0dhlvX9RWHmBHY67vZ6KowoXzRrZXoOhHTNl1O0gSEXobd4XEvbFx0kkR5?=
 =?us-ascii?Q?vgfHjlDQEycAAp11X7L+mfX7FmFnIHQR8S6nmLfpFRZP32sD/CNh7k+oM/eU?=
 =?us-ascii?Q?2NvIex672rGqKRQYh+jAYAcq3yG0VBQg4Az/avEOnpb4IOnOuhhPyt+CwtaO?=
 =?us-ascii?Q?DesZbHa/iXfqGdJrvftm1vdrNrd+IQJ/PsquAjHHNE5CZBf1L9GATHNlOxMx?=
 =?us-ascii?Q?zWMEGztAQOMSIJYAWtmhJcWNmTDmbw1zSo0NNBwrZctG/kNW4rfTg7P05QSg?=
 =?us-ascii?Q?wcIKzFCF992A6ywfDPhP5R4CQKKGFm+fN1Fd2oSp98KV59K07xzvJpx25BtZ?=
 =?us-ascii?Q?DiM/S3yH/p/kh+ELW9zik0De1GyQrZiERA0mSV9brsQLSfWSvOZB3omSlceu?=
 =?us-ascii?Q?iCwiKHiqllH2jhtd4K4APH0sCxqsxGq9Zwe7/9mT+pxUFL7MghVaMrRi6XK7?=
 =?us-ascii?Q?HNwwrBRQyCUpzNQwdMFiRIkTmU6U2E7UWbnSKI6gR7AxFen+TnWY+lt1Ro1Z?=
 =?us-ascii?Q?8/Pa+e0E/yET4qi6WYFErb8G/OLN/rdzvQSxlE4W8ju3X+BGl/mAhABK6vpK?=
 =?us-ascii?Q?EH8PWdHuImxXzVW3j7WqTSksVigtJl7xgF5MWF8vXZPJ9Pk7Nv4QZw7Jgq3u?=
 =?us-ascii?Q?VGNlj4VsZ+qZ8sZ0oBApNqonHKPGLX8cecdUy1ZVOZ9iGvru5Lc1GC9VOLYo?=
 =?us-ascii?Q?mXp7xCB5K4C2Nv49SA0O4Ye4hVzYxwunnEUh9nrzZBEJ5MDvBTnXdGSeyrv2?=
 =?us-ascii?Q?zgxXBBlovOqBsfZomwTCqOL1drm6SbkIkvV2RdFKrHZdrB9PY9DSwqK/s3g6?=
 =?us-ascii?Q?i1GCBztS+V1dGO/E/sgSxq+Veq6ETQEmVVXy7wjMEuMPp0//1K28OD6WM36k?=
 =?us-ascii?Q?Fk8tygQyif3BS+Pzv0ybPqVxVq+ZOfUpsSva0hhlhv4O7A8S3XtMxIeh0ZZj?=
 =?us-ascii?Q?7RA9fwS2SYbuq7RjGICh9u4tgF1/CZlohXwyQGMoN9KYQBcsOZYAH5XssNja?=
 =?us-ascii?Q?WP/6LdKcwGFVIZpcMZUhgsiav4Hp0XSoADQ8sDhxNgl3xiha7TZGLr6xDk8X?=
 =?us-ascii?Q?DAcieLZxdcIMNcOzP2zMvj8RNvwiypgMVgb5BXeGVBXhGoAopXEaiYq0IjpZ?=
 =?us-ascii?Q?9zXwfUavT3Nj+ktcmvpVkYqwvNEVBjlCPybD9W9iW2JlOiNjH7eFRmlH6QM9?=
 =?us-ascii?Q?LpNlVgnMuFPmw92FdMyQpsAzPJtHs9C/3vjgOmdNwTf/yXQjXDlUfNbIAhIX?=
 =?us-ascii?Q?BYOofwryluo9ahJ/CI4kbgyjQzKy65d0mNzrDAGC?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fb8771-3360-4830-19d4-08db952a2aca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 20:34:14.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iv6HxReqQYc63d5Ot9PM02Pr8Bnb6Oiji+px2+7iUaWcalH+oGBneRLqADrU4bn9fXefnURdAX8L2+h2RSG12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3310
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add page pool for RX buffers for faster buffer cycle and reduce CPU
usage.

The standard page pool API is used.

With iperf and 128 threads test, this patch improved the throughput 
by 12-15%, and decreased the IRQ associated CPU's usage from 99-100% to 
10-50%.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
V6:
Added perf info as suggested by Jesper Dangaard Brouer
V5:
In err path, set page_pool_put_full_page(..., false) as suggested by
Jakub Kicinski
V4:
Add nid setting, remove page_pool_nid_changed(), as suggested by
Jesper Dangaard Brouer
V3:
Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
V2:
Use the standard page pool API as suggested by Jesper Dangaard Brouer
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 90 +++++++++++++++----
 include/net/mana/mana.h                       |  3 +
 2 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ac2acc9aca9d..1a4ac1c8736e 100644
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
+			page_pool_put_full_page(rxq->page_pool, page, false);
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
@@ -1887,6 +1907,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	struct mana_recv_buf_oob *rx_oob;
 	struct device *dev = gc->dev;
 	struct napi_struct *napi;
+	struct page *page;
 	int i;
 
 	if (!rxq)
@@ -1919,10 +1940,18 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
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
 
@@ -1933,18 +1962,20 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
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
@@ -2014,6 +2045,26 @@ static int mana_push_wqe(struct mana_rxq *rxq)
 	return 0;
 }
 
+static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
+{
+	struct page_pool_params pprm = {};
+	int ret;
+
+	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
+	pprm.nid = gc->numa_node;
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
@@ -2043,6 +2094,13 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	mana_get_rxbuf_cfg(ndev->mtu, &rxq->datasize, &rxq->alloc_size,
 			   &rxq->headroom);
 
+	/* Create page pool for RX queue */
+	err = mana_create_page_pool(rxq, gc);
+	if (err) {
+		netdev_err(ndev, "Create page pool err:%d\n", err);
+		goto out;
+	}
+
 	err = mana_alloc_rx_wqe(apc, rxq, &rq_size, &cq_size);
 	if (err)
 		goto out;
@@ -2114,8 +2172,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
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


