Return-Path: <bpf+bounces-6736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70776D678
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 20:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8BB1C21225
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C911101D0;
	Wed,  2 Aug 2023 18:08:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF95F9F2;
	Wed,  2 Aug 2023 18:08:06 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90191723;
	Wed,  2 Aug 2023 11:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEdPaU92O5oDKFUuY5gTEp4NIeAJw1K1Y+nyCsiB/GbCtC2lTt0XsNI7j40ZBifQqH4x6+tl2qez5zr6iSrI5laoxC82DvrMrcHmTKjjSVQ3UXyLh5C6Ya5YrAizVyn82ujHaxTq/DOlrvwWnJ3VxZmX2N/HdyXgi8D59zv67baZpYslOdmmyL6oXhnGxTbVjRQKNqdEUmf8SQyhGqSrpnFzjzT79PCrBMbKfcrdwVV5OFO5oyaJ3FwXo+BMUcw19jUeCrHHTy0vMek0ZVRej5WA6CmaVseDCWUra8Cl7kPl7JkR3kXmymfMJcSWXdNKzrQjGzpSmKqjonBLACpi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9AxyLLZnaS8eET+3kF51hJ9qwUS1osRmPdAd/OL0c4=;
 b=Lx/Xb2qPg0umyb2CxmC7lDQYC8so2dpxcVVuVWEZRUZwrDgv3isG6XgYyY4sMCcpg2le3q8lifKqhLG8Oaj15LC4tt5iIswztmCXPtkABqJ4pdwh9tzjk+sc1HiIwsnE8oKd/Mj7Fs0fw4SfWPTiQsgI/CdiWlThHHuV9qLWqZ/RFMP/7pIohangeAq9w5o6X4YHValcvnqJ9WJ8uQpllSBa6/MUyEV7Xku4SwZX/WID5RBZxVTU562UJUXskapCBvSvfcKAkwvFKVQDZJVtZCD7lg7/E12nG3YFvYU0P7ILfUopnwsdj5BzLDqh3qlhR2iq+C5V0rN9/iGUwVWOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9AxyLLZnaS8eET+3kF51hJ9qwUS1osRmPdAd/OL0c4=;
 b=cP4011/E8GdCXVHFITb03TILyoGo43GUtPu2U4HiJCGjMOjVv1OY8OFJOTOUW0/FKOONdv7H7YGG10T80VYbE/rNlSkM/aRZrY/fHgVnHeZ8CfTKKWUGCMnBnKhspcivYrnxWD/wQd1TX+CvIRLsbumcJlSbmCYwTPWVXcz9d2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ0PR21MB2022.namprd21.prod.outlook.com (2603:10b6:a03:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 2 Aug
 2023 18:07:56 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::3df1:3a64:3388:9f97]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::3df1:3a64:3388:9f97%6]) with mapi id 15.20.6678.009; Wed, 2 Aug 2023
 18:07:56 +0000
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
Subject: [PATCH V5,net-next] net: mana: Add page pool for RX buffers
Date: Wed,  2 Aug 2023 11:07:30 -0700
Message-Id: <1690999650-9557-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:303:6b::22) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ0PR21MB2022:EE_
X-MS-Office365-Filtering-Correlation-Id: 307605ea-7059-46a1-0c5f-08db938365a3
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 N5HZFw2qbK9MgOqu0P4EknhH00LoTv/kpdNOExDHQ0gbNirKUM3svtZw0rvkr01/bs5lDOxjHxub8jbd7CceFwRWb8PbCCUkOyWSs8O4eip2dH62pFsRjGvGSgWVX9bMxD4v9KqsLT2Zv4thDWMbn0XBprPABeG4KKThzbTC0cjCGkSrd/giSHaFsu8CrW06z7qBJZZFo5GWV8a/4KLrjgAP7pW0Mhe4K+A7tJcywKnR4HDuigcNwvXBEOVNBTwP/Ri2f3877oznpxLlFw2dqjyVwyvogP9Y3qzYCobYm8DSHeTxxjo/Owygg72IsmejBxkVo2iXap7MZMS4L0tdEmzP+NcgoKn9t0T1qCTAElX/QhovlMccJNcjZncb87eg1YSa3R97B4NdHVGoT+/aP2yVGMOVKKVQD0wGEktx1QtMyEpmtFOx1IH6oe8JrHV+9sqFDJDp3tmrZDjNJ3pT21kyizwLBIlMWRMj7Ch8X7kbeHYPFAVygKnohUs4mqI4i9BzHaAdaeP+5xC2EKCvtyLZ6JKOIABgeWm46Zs8JZMptEGve+7rB/gRNKnQDPJkmArFmXNwj1iGkKt80TDnXThpLNl+9UfpdxMQwrGba/ztsutYSs3kfxu7b0pZFv+TzP0dZXcuhvb79A8TbRsKash4/YZA+1G2vXB7+ILm9jI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(10290500003)(186003)(6512007)(83380400001)(8676002)(26005)(6506007)(66556008)(5660300002)(2906002)(8936002)(41300700001)(66946007)(7846003)(786003)(7416002)(66476007)(6486002)(6666004)(52116002)(4326008)(2616005)(478600001)(316002)(36756003)(38350700002)(38100700002)(82950400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?UMHekO/tZZ6RpfD7e1zw5nRqhPcmuNUqAziCCZ61OLIdIX1lcEMXMGOBZdFL?=
 =?us-ascii?Q?lPg/hDlKO0q/JNnBX5QuDlsajB0Ocb9/gEYX0ygdUbHgXsKEphxJuFYFuLDk?=
 =?us-ascii?Q?fSEgFF+49JhmwJVIl/W2AnfZyypAc21zpHC6ca2WFGXahne36OlhRVKPvmS2?=
 =?us-ascii?Q?2JvS4gQr2F79pXcRdsMWn3Lf96185WXKjriUgFQwY1I7kQEPakuqdbe5PWqp?=
 =?us-ascii?Q?BIFJd6AIGiJit1E8zV8CHULwdGlc5jJDIHUh+ga2osuzl0U4J+YkIKb5TaTR?=
 =?us-ascii?Q?zw7cL7wfvegkywkoQjoMCLHlMKI0hltKkDwzeaC/ziFkYEKD7/uT2u9hA13D?=
 =?us-ascii?Q?revqY9UnX8NLVrAiB9YdkKYtlUC+Kt0z3hG6uPGa8y8RPwa1SGrzRTGYqVnH?=
 =?us-ascii?Q?m1PZYbm6HYrgnZZJ0GE2gRTizJT9NuccGMFBekicAjbXWIZWufCSoKijKSDE?=
 =?us-ascii?Q?qYwC09p0CtBCaZazjcoZ/RE0MnN4nZI5qT5mBtiR2YX3XbQhWXWRm8e0HMcX?=
 =?us-ascii?Q?dnpbn4wLxhaaCk5JHJHPCGH4u9xPDYZ9kvyj9EWK4jbaF04XRwQVwqr74fk1?=
 =?us-ascii?Q?PGSttnYrA+IvK/afZszn5h0v63xdVQkqObQEyrwP9qzOlfPy+0AdbYwQ4iLo?=
 =?us-ascii?Q?r7t1Nf7QE7Eoc03W8uc9iCqgEoYzxQ2K9BslBCvDNDunj3oM4crz1pNq6aAi?=
 =?us-ascii?Q?Xet+T87HmGwe8oEtqPmZ7HqYWElYGT8tT4wbhYrDh9hYlvL8o8OIbwZ76tUh?=
 =?us-ascii?Q?l7K36G1B7uBR9Nv2WzPornQ5aFs8cgE4MDlcHzJsZuqOuAimssd03bWgL9y9?=
 =?us-ascii?Q?brK/PtocrlrrucjJvxEDDxdcJVZuYfkp2VDFo6dGFFDkEzuNZf2+dJl6So5y?=
 =?us-ascii?Q?FXqVasbSGZW45SrkY/4iczn/RA90uGJ44kvCea6riDIq7aVsB6vPcnEPcgNL?=
 =?us-ascii?Q?BDULnW9GuzNrYHekUlUb9FTCZtKD1u8BOYmv5Er1CmEI2Dshr9YoVShyeEnS?=
 =?us-ascii?Q?606/altHxyUu+RXqfpgaFbxJT/y2miYjA7mzVSdyE96kanBh1ZQW35bTLVL/?=
 =?us-ascii?Q?W75DtqFYaIX2+H6VLRgPF6vxZbLsKD33a061EuldWM3shuBEcyN5jxvEhmt1?=
 =?us-ascii?Q?PSLcCZhjrOcPeaSMR4CDBeaUeISRDDR4QK2MU5i8CZS4SmKuHgc7lTMBw4mw?=
 =?us-ascii?Q?HMqAKCpOkFA3/KHwpEELA7+sUXw2O1akGrD7xKEC9F9wPB83b8zYKoxSVmxZ?=
 =?us-ascii?Q?VJcZVOdxT03RqLDrUnweV+G8F+eUNc61qiI3g4VEcKc9j9sFFJDi2dtNlwbZ?=
 =?us-ascii?Q?Al2oJ0w5L51gQuAOnNExYok72S6GmbGdM3seL99+8+FhLftDya67v/k5n5Bv?=
 =?us-ascii?Q?f6SrF//OUiGeN2vShtihTXWnuSQgj94TH3TfrWOS0gML6Fozv65VU4zbX1jP?=
 =?us-ascii?Q?UoYwDwN0AIMnNi1aeq/K14qq3qIo7bhh7SbIiVgBJo+R0ytzra6fOZBE5DpQ?=
 =?us-ascii?Q?2wFabvqFpwhrqmTYJ//JVq5KXq0FRgrRRaYPD0q+t8mTMdMfbuUNkWRRQ37L?=
 =?us-ascii?Q?iPLDllHONWF/a1yR+mG17izShAqWUMX2J8dvbI7P?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307605ea-7059-46a1-0c5f-08db938365a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 18:07:56.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1128oIfRofnTYk3YnQ+dybK1IiK7L1RuZTIovw7qSomnD8HgDghhHFplwMhu9h0X7lnf042VGRdPmNobToZeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2022
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


