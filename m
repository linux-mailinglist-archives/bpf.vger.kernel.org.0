Return-Path: <bpf+bounces-6269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE927677E5
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560612826BA
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405331FB28;
	Fri, 28 Jul 2023 21:46:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A251F173;
	Fri, 28 Jul 2023 21:46:43 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED11E19A1;
	Fri, 28 Jul 2023 14:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VusV71Qf2Hwih2+NkjfEfdzHbh6NoKNwElxy8eCzyDbaDdGcz5/xR+cpiJqP7StQdmSX3Gzg330MSr9LVBABnDTA6NPOpZbmpVhPAKpcJnlTjEJn8hauft4Vohn6JN49QGKBe1NnimBB1NlRugNm+LFXNr1JR6DhlGK5+pNNDdd2DXCqkWcKH8La8jiZIyLpSaSG8AsVfizc0wmVvuAde+RU8YrWIQbQk35r84L/uWqRuj58FBEM9ArTKnN0zhrt4cCiTNLMjtv9BxlzEAX6YhI8mRcpNZLyCtx03OYm+Hnpm4sIApUlCswP/ND20IbjCTkAiN0ips+FRMWNJdxtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wBGYDyEPO9xyGmiRe697BUaLkkIuCy0CpfkYipYyEs=;
 b=m+j4e7FgDyvQeO+GDRRGsYCOyLpBp+NPRryHIGYXsRafYbIbhu8tEgGvvkgEO81koe2J5s8etEITiDXV9guCWYwydoCTqHK4yWhY6Cp7I2tQ++s39ID8JBQ1XKZguU3T+Pt62NOV5FzAGR+Ebjh5SdXAZbafnCpmv1AyAMfHMOV6VhAK+vIn6isjQsQslGIjCRh5Y5+G/4+YRbqqmwbLHvrT6di/svMOoNB6ScGOJ69J6D7CThENDmjv2TbfG3pKhdRzO8GzHdQyb3p8NL/FZ+osj6aJ4KYeom8A36HITkXD6uUJjiMToLxx5ireq6NUrssF2fb1woEwuCVDZ8mDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wBGYDyEPO9xyGmiRe697BUaLkkIuCy0CpfkYipYyEs=;
 b=Q5kGAIfXy72/QexbG0HmkRpMXw8ToIVvwhebc6aqnJSfP73X8eg121vbCyaXJsu1illLu0sOmdWmzeax+Ixqz3Fa91FOaCjWFq62akD61viBNFk+F3YZxIEtnrN5Jvx8ZYl+Bw0XW2WElQ29X99/pLZLoG8gfP5ZEZ0gqK8RDtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DS7PR21MB3102.namprd21.prod.outlook.com (2603:10b6:8:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Fri, 28 Jul
 2023 21:46:38 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::3df1:3a64:3388:9f97]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::3df1:3a64:3388:9f97%6]) with mapi id 15.20.6652.004; Fri, 28 Jul 2023
 21:46:38 +0000
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
Subject: [PATCH V4,net-next] net: mana: Add page pool for RX buffers
Date: Fri, 28 Jul 2023 14:46:07 -0700
Message-Id: <1690580767-18937-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|DS7PR21MB3102:EE_
X-MS-Office365-Filtering-Correlation-Id: 1418ac22-3f57-4921-58af-08db8fb41f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pd0HHZT4wbXrvVU/BmJ1qNhom2V8RGyYtcH2PGlUSHhdc0gjKIEkkBY70SU8K9I+UYQXCrgxA4KBeuRRWpvOeWQKlGZbZjP0FOx/28xHK/8azZWHV060KPY3prVHcUYFCqGjELUaob8X+IfLob83eNBozntosUv+iUCjjQBnWiVQNtrs83cQXT7sX2wXzMw3V5gRSlF4ksj7+zU+6XuB8IGxG9UpqlYsrSd3oOZECWg34Ehob950NnfOtkMrIns/bWlh8WhowVpJ9evzXjsiuplPeSSRMVRaIsVl3i21IAY+aSIvs+xOeQX6xQ4llH8wnlUCl7ixNoZ0tGR5TO7DQEVCTAQ6MhM+pg+BrOaa/uSp7v/gS1O0WW2FhUdOwiZVug0VfWpzc0huT9fwMAHB5WHLG9C2SR+uA70ALsfSzDBvlXHiFTHeFupgSdzJ6X8Y+iClyY5oVoz5QothZTKZYigPh4ZZOxqwcRp1v6Qzia0PrqI8zcDjebEsCDDoIGFe1c2ZdLvOpNN47bq/36/0/dy1n+HS8qhDyKk2Z5JCi16c02uNMnMsv5oVAUsrEmtp7MF/R7JSyHBck4akoUhxmBMz6qRxDX3PVvgUgl1stcInwbeTKUmnV6vC+9BnaDT1c1REVfPin+WIjrm1Ne3xAf8R4Y0TtatP0I80/rKOdeo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(38350700002)(38100700002)(82950400001)(2616005)(6666004)(4326008)(52116002)(36756003)(82960400001)(6486002)(6512007)(83380400001)(26005)(7846003)(186003)(10290500003)(6506007)(316002)(66556008)(66476007)(7416002)(478600001)(41300700001)(5660300002)(8676002)(66946007)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WJosE6ox6UzeRZhHKGMVqRaGvOsiMxcpf+qLq2v29NLK3xMYekEBtk831GD6?=
 =?us-ascii?Q?SpHeJAOerFyZ+7leE52EiZH8FYQwBp4Fdpz7JPzh22cVDtjc06IkNIQcTwBS?=
 =?us-ascii?Q?+4b+T7elL+vNKh+dWMiI0GWkSAbSngfIhnhVP6w0Vh4QNWR9TPpZnUk388o0?=
 =?us-ascii?Q?lISW38gIDHeLwl3ctza5tAnYJt7dDr1F9AzKfsC8YY4rHYatYWuw1OiseNk+?=
 =?us-ascii?Q?O2UWGSbQhdw3QTJK8gzILQA7pQKzmU1QbPMP/Y4oOVotnjIGBghxYLPsD7q5?=
 =?us-ascii?Q?j5bbXjBkDUPcW8tGyDgwF2tvHpneOtQKJcCgN6ncg+dV42kjUDq9Ry7IeGc/?=
 =?us-ascii?Q?ZGX1D4XW0+UpMymFx3dBQTEiw0o2Xzfm89xk3sciu1dGnlGxDo0S+NNBgEiY?=
 =?us-ascii?Q?scGGZKxsQ5zSK8l5schmKgwEbJRKNTxSgXFJLyQR1WdelE2D976qY1Zb2wF9?=
 =?us-ascii?Q?0PVW1aHgeTLOrKNABw4QFIuv/3SzQopm5Nm4D81j4SBiEtjPgTDKZytfBbv3?=
 =?us-ascii?Q?lo2WCAwzXKn9BvM4PI9WYqZycVTpVFCeFCMIaLVR/85RS1W/EZgk8eHGDQKx?=
 =?us-ascii?Q?99vgePwJbAd7K4Gx5i2qU4+RFDtD6RfsBfTRboUu1PvJk5T7n33rHS1ZdDaJ?=
 =?us-ascii?Q?XaYElzV+FTpLWLMVS+Ct/yAgpHGpQlNdJdEALQCJn5gMCw9nV1lxiuQZqAMp?=
 =?us-ascii?Q?KwUxRHsXLG367AG1h+DGwQCTHe6wVOirhgqavuQjv47G560UM7e3TCtQP1Qh?=
 =?us-ascii?Q?aDFACm4A9iZxjjiIQom5+pUk5G0ZsPRcJk6rSLdkH3cHFC5Zvgm2f7+n7BDh?=
 =?us-ascii?Q?81QuBbqfU1mDqzkZRKXs3Bno7aygitk8hq/uNp/4PKXFDEeWuC9SOl1XT+eS?=
 =?us-ascii?Q?WrG7WnDkmxnwRciabeO5Hymzf1DtnUJUiwEr+hY9K+7Oz6pcrz95Sa3gplQM?=
 =?us-ascii?Q?qzh3uQEEfFrtXy5Wxi8vn+qVKcjOQCUS3CLQGUiHnKOmkM+A7Qvl/5f0iunK?=
 =?us-ascii?Q?0cUNbEESDtsfcVfu2Hcl63/7D930G8KpTna+Yk9+EL2DdFE5qSja7mFOwdIV?=
 =?us-ascii?Q?LKEnxZlec/bycjHjmg5plnjhDD6E7JYrgJcFkXUagrBSoHFTv582FflwEmXW?=
 =?us-ascii?Q?gcREqjHDLvffoiGSFqhGRXlYpaCzhFhv+QdAjmrbwtHUXtCQ96RW/oT3Lkkq?=
 =?us-ascii?Q?Km6mwdrkMCJx9fspBxA80loxAuF+Vpe5XoG7l2wfMJjDHdq+gHUxywODdhpP?=
 =?us-ascii?Q?SkZJXqrBmWsbAsB9drxk96zYDmJ8O+0tsOelsrPtDDRWyXSnegdjyCZCMSSi?=
 =?us-ascii?Q?p1McT5ckcz6LWP7zY4/O0AH5tKpYEg1NkuLoTQIW/nsrV8E52eJunDwOuDhn?=
 =?us-ascii?Q?KT6b0s7y+pF42wPypTVPqA5dNH8AeXQV8XdsGfdnGRtDhAgKql/qUNFixlFm?=
 =?us-ascii?Q?gnHhukOnv9U7NTudgbCZk+CbBeWLtDlxtUnu61H0xC0kYINeuP25imNDK/Qw?=
 =?us-ascii?Q?d0PRj4fsxobdswRtZVE1ukZvC80uXtvTJpYcvfqiOIUzCR8l1oWCOOK+fOZ5?=
 =?us-ascii?Q?a9y+/odO/FNaQqsNqZSJ1SPb9EaHgyZ5CZzhfOX2?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1418ac22-3f57-4921-58af-08db8fb41f1d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 21:46:38.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9R6CHQXn5jLtTTcrc7ASGbck4rVCL9kh7gTkQAkwN76T3Pei6fBrmkqwIRMy+i1k3KDl7zstg21x//piumTiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3102
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
index ac2acc9aca9d..83f2ac132990 100644
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


