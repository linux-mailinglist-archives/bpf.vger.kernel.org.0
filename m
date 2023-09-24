Return-Path: <bpf+bounces-10704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5DB7AC62F
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 03:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B93E8281E80
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 01:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721E63F;
	Sun, 24 Sep 2023 01:33:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538457ED;
	Sun, 24 Sep 2023 01:33:47 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B520B113;
	Sat, 23 Sep 2023 18:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgOTnok+d/IUxP5niH7/Wnbnb6FI+2+6Q8NhA4hkMz9LpN0tZ74MFHCgMv+NNniVeYvaiM5eGYmM98Muexh0qFtiDkiWE6rfmI06pA47YHE2E/fUKm4QYTamnmycuaqTj/9FT217C2Cn/3ngg3+ueaeYz+wHksAzsIJ1AkL4DK+LVv2emcncOv6PvgXgJ6fIBFnYlYnTyVgXPFRPXIa1tavlBgXkjM1dQ9hZ3z3Kv/B242oOQwACyHabGztRgWqMedVYPQHIIk2Imgu8DXUg6JuYPuTtc3sMpqVkiAUPE4+v8D6+R4DcxejriMB/fxgdxdUctxA4JXh0u9aZK7Wlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvcaYKE7Rt77HnfuS3vgkr4C4LVsxQtewIxQCeXXFvw=;
 b=BArMEOBIw3ShyFEN0ma12Cf+l123lID3dGYHaU9MZOzCmFSNTrEXJbwqX7frct/IQIiYvsjZ15sr5RB4rGRH7IYbSa3n7H8tNWPwt6EyeSggkGtaPOLONXP9Zr/sXpus4uI+dCE3+RTsR2kpBJK0n05N/sAUw0b4Ehuu/zmn+IWS9Qdx0IxBiD/2BYd6zXvoR+Lv/D4hwUiUMERlDRCvLIdriJvlXtKokHBeAD5nOK27/Mjb927XsEfYaSOklE0fXRVY8fK48/neOfvTPtv/Xq2gp7cgVzqejBOVA7r6lz49+fTZ0zGshjYIxxUBEZAxeCg4Y+YUuJMPZE3gIDmx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvcaYKE7Rt77HnfuS3vgkr4C4LVsxQtewIxQCeXXFvw=;
 b=cCZ0dIZl/9oM0/wjGZXC7qBRcUdheiiTYOaNT4KoheRc6rImBEBz95sQbrJJSLdoDlzpR9Ql84KRakJJFrNwh2liPYeTugpN+q1K8SbmgHwvDIrBkXlQOFeyWx4/7Po69DNH97K7/zs9LI9nQNPTDfk85cIu8cIOkslSXJvJuWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16)
 by SJ0PR21MB1323.namprd21.prod.outlook.com (2603:10b6:a03:3e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.14; Sun, 24 Sep
 2023 01:33:42 +0000
Received: from DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::827:4af:136a:236e]) by DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::827:4af:136a:236e%3]) with mapi id 15.20.6838.010; Sun, 24 Sep 2023
 01:33:42 +0000
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
Subject: [PATCH net, 3/3] net: mana: Fix oversized sge0 for GSO packets
Date: Sat, 23 Sep 2023 18:31:47 -0700
Message-Id: <1695519107-24139-4-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To DM6PR21MB1451.namprd21.prod.outlook.com
 (2603:10b6:5:25c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1451:EE_|SJ0PR21MB1323:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b20246-629f-4d07-ec99-08dbbc9e48f8
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 2kP0CA/PvOpkel397RWubNooHdOVB7pAL/wMJSDqqyqIzj5tsgQ5X5yMvrdYNeKlfyJ0lVSYpyKr0mUaHmvPPUHTkl1eYev4gphSNbuwcVE3jgom9L7Lqd4ERMpeyYwRE5Te9F5MEeL9wVfHtjlPODkigOiL/sFEWTuBvk5RQK+1++rKwj8oENhWGPpogLnGKSsaMolkgZf6hUX5QagA69wuIkvapSOxthXf3/xRB0I0eB2YxYJWEwWm/tCjdux0VtWuJ3RO0YGd+drQwktqseehthDzAuGJMwdxr3rxvUrbEbD78ioJRrbse2qrhaN74oIVfS8JdKghsdCocyY6uH7iERJLdEhz8uoeNOiEnBUHTPT9AINc3g/j44XAlzbsrDllehwhkuTfSLxlcYoYLu+hKlau15ZiSOp8IxE2b7FLaCJ+fbH/gT9utX2zFBfIKGTEw7Mi4at7vQy2hGpTA/eo/xp2EPgjZxmUeCtxCxMJGtayU0acOZH73LjVBqIv+ezvMVkmqY+/3+WWFMVTKUiQ2XGh8uSaIJYgUbcA+vZUBeiP20dEbT+5IJQjRXfL5r8lMXB89QDBScvq8Rlz9Ta6ilHzmORAO2oaDrv8hvt7NN6tTG1R4d1k1EXujs0wABZyOZw0Ii2kCgaCfwCmpA04Y+79KO5nCte6sEBi+k0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1451.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(52116002)(10290500003)(6506007)(6486002)(478600001)(83380400001)(6512007)(26005)(2616005)(7416002)(2906002)(41300700001)(66476007)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(5660300002)(36756003)(7846003)(82950400001)(82960400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Vh2BtkZvN2tLvEh9wPsA8AEgur2GW41aeFnHlBmBfV/0I8vdzUKKDnwRdVhZ?=
 =?us-ascii?Q?xW47toO+T4mlsPDp7Lpc+KmveVcG8UlQho14N4OZ+Ik7OVW5tmfwQbuRGvmd?=
 =?us-ascii?Q?yps02x0i8Ssvt+b5YO/nFofnJjH7QcrKw0HrS62YcohhXKbsU9BQZYuSp0b9?=
 =?us-ascii?Q?otcLxipsjx4bnzrEk0eXRNBpnVxqVa3yRH0Ehi+h/sTcXs6lRAKALlqQZbZC?=
 =?us-ascii?Q?shpiqdQ3XIKNTqvXy4rIFHuKb8UJPoG/1+QxHtWxLCJOsOe0H0V7DOi0ulVY?=
 =?us-ascii?Q?5ErhrxdLJiau7GVbJntLR7rAX7aad4bxFoFDeFcyjAB1CXqpZRITPe7xoWOK?=
 =?us-ascii?Q?TLDXYIwBn8uBm80qxd3/hNZL7mtwqUlhE8wo/YrWC4nfalZ7AuCD8XXawBX3?=
 =?us-ascii?Q?cj0zDdPCRwB3E3ocRiXlR3X9/g+QRUWL3BofUPi62LiUt+n6jOlK+Ttb4dcu?=
 =?us-ascii?Q?/epZ+LykN7DX/0wVSyzKZSekmQKo16+C8STDxLeJRJLmutL6s+0+tA2W+uHm?=
 =?us-ascii?Q?nbNMcXwQKkxmOIYq1pEc1sFNw7zWq8ZHyr/HvaK9Yyzz+QuIXz5ftMFbI/g3?=
 =?us-ascii?Q?oyviAcyWRRHkEAxjQvO1GN2y1u7mM1SafF4lYtfq2Pl6ql2YlbZqjqxH9EEU?=
 =?us-ascii?Q?VyA0KvC5oz/DhodgpbHsd876WQ63oEfqAogvFB021Ul7J8ThvkgGGHHjipdJ?=
 =?us-ascii?Q?Y9tr6+h0deUvCHWNcR1AkGHIEVcS9ovDXhQmn0A8fLU5GhQLxrkTOQoWrb8o?=
 =?us-ascii?Q?68YZr2yZuWRTI54In52GdfA2J85yhQ/T9gRlKyLUU59zeEIoxAOgHpSGY7zI?=
 =?us-ascii?Q?vu7ilCBh3T1Lv3ILcAHYaqtIXKvLH3njEzPON54cM91IQUMsM9lSPVck34YM?=
 =?us-ascii?Q?Uh2qf6D7hZn8tvnEs5bZSt1mkNYMMEhnLlVwLmIklPi5veyLhnW5yOZ1xnf9?=
 =?us-ascii?Q?8WY9hrvuJsYpzW6vlptgRQ5IMeaj1Zf28oc4Ck+mI88pbXCVBKRfNb7nLrH4?=
 =?us-ascii?Q?5pDFTqRDrphAoxqkr3lOjJADjPRAbYUovfNvpUW91VmdItO9Iap40HoIOSL5?=
 =?us-ascii?Q?tf6BbUZibKKhdQh4MQVMuxngzS4D6sUDiPqy1KfM8a2tNyPRe61HS+DpHgcG?=
 =?us-ascii?Q?8nbJ4GPRDht3+3NoRI3zN8SXP1w5c2YYtEZZXl1OXjWzK+U0XH38z0mC65rl?=
 =?us-ascii?Q?OILlzKUqnDCkn84tfWo4Mcwl3KN6inIr6PvFp4/JmzWtyBLWwYADrvtsvUHa?=
 =?us-ascii?Q?tyXbHdrK692a4jTPkmo6R4kwYG77PUQ9pRmdwLtBL4BE8bAL6uq0E9cauf3Y?=
 =?us-ascii?Q?nEFDBTFs+517uINg+TQaGYsgoETEjj+u/pBxbZKtYrGhdpsNrIOyiWMSPXMT?=
 =?us-ascii?Q?2xf9hy/Aj/RW7+1alVcT8kvWBNhF5dG/4jd9aSA/KzUwXj0g32d+pRbq7J6I?=
 =?us-ascii?Q?BR6sK6p0UFdZdAVZH7PZt1BaiZOWGVUHSFuj2lktP6jdgTJOpLmTgqbpgqbS?=
 =?us-ascii?Q?auYWuSGPDSRuTeMqgGPwuUphkioXJWdP7kUNMi8eb9CrcjJ5gZbbPou3uxch?=
 =?us-ascii?Q?2RK1drGDycOh0jBeKYol6SVoPdpkB6ley4Fof5FZ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b20246-629f-4d07-ec99-08dbbc9e48f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1451.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 01:33:41.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb0d0ixjrkhIcXp741v4WBeLw8j92q7vBBd5ZLh5pOwilob2HTiz6W0V0W0MvkN5g8RIJLBK4TZJKOF2GX5aXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Handle the case when GSO SKB linear length is too large.

MANA NIC requires GSO packets to put only the header part to SGE0,
otherwise the TX queue may stop at the HW level.

So, use 2 SGEs for the skb linear part which contains more than the
packet header.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 186 ++++++++++++------
 include/net/mana/mana.h                       |   5 +-
 2 files changed, 134 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 86e724c3eb89..0a3879163b56 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -91,63 +91,136 @@ static unsigned int mana_checksum_info(struct sk_buff *skb)
 	return 0;
 }
 
+static inline void mana_add_sge(struct mana_tx_package *tp,
+				struct mana_skb_head *ash, int sg_i,
+				dma_addr_t da, int sge_len, u32 gpa_mkey)
+{
+	ash->dma_handle[sg_i] = da;
+	ash->size[sg_i] = sge_len;
+
+	tp->wqe_req.sgl[sg_i].address = da;
+	tp->wqe_req.sgl[sg_i].mem_key = gpa_mkey;
+	tp->wqe_req.sgl[sg_i].size = sge_len;
+}
+
 static int mana_map_skb(struct sk_buff *skb, struct mana_port_context *apc,
-			struct mana_tx_package *tp)
+			struct mana_tx_package *tp, int gso_hs)
 {
 	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
+	int hsg = 1; /* num of SGEs of linear part */
 	struct gdma_dev *gd = apc->ac->gdma_dev;
+	int skb_hlen = skb_headlen(skb);
+	int sge0_len, sge1_len = 0;
 	struct gdma_context *gc;
 	struct device *dev;
 	skb_frag_t *frag;
 	dma_addr_t da;
+	int sg_i;
 	int i;
 
 	gc = gd->gdma_context;
 	dev = gc->dev;
-	da = dma_map_single(dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
 
+	if (gso_hs && gso_hs < skb_hlen) {
+		sge0_len = gso_hs;
+		sge1_len = skb_hlen - gso_hs;
+	} else {
+		sge0_len = skb_hlen;
+	}
+
+	da = dma_map_single(dev, skb->data, sge0_len, DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, da))
 		return -ENOMEM;
 
-	ash->dma_handle[0] = da;
-	ash->size[0] = skb_headlen(skb);
+	mana_add_sge(tp, ash, 0, da, sge0_len, gd->gpa_mkey);
 
-	tp->wqe_req.sgl[0].address = ash->dma_handle[0];
-	tp->wqe_req.sgl[0].mem_key = gd->gpa_mkey;
-	tp->wqe_req.sgl[0].size = ash->size[0];
+	if (sge1_len) {
+		sg_i = 1;
+		da = dma_map_single(dev, skb->data + sge0_len, sge1_len,
+				    DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, da))
+			goto frag_err;
+
+		mana_add_sge(tp, ash, sg_i, da, sge1_len, gd->gpa_mkey);
+		hsg = 2;
+	}
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		sg_i = hsg + i;
+
 		frag = &skb_shinfo(skb)->frags[i];
 		da = skb_frag_dma_map(dev, frag, 0, skb_frag_size(frag),
 				      DMA_TO_DEVICE);
-
 		if (dma_mapping_error(dev, da))
 			goto frag_err;
 
-		ash->dma_handle[i + 1] = da;
-		ash->size[i + 1] = skb_frag_size(frag);
-
-		tp->wqe_req.sgl[i + 1].address = ash->dma_handle[i + 1];
-		tp->wqe_req.sgl[i + 1].mem_key = gd->gpa_mkey;
-		tp->wqe_req.sgl[i + 1].size = ash->size[i + 1];
+		mana_add_sge(tp, ash, sg_i, da, skb_frag_size(frag),
+			     gd->gpa_mkey);
 	}
 
 	return 0;
 
 frag_err:
-	for (i = i - 1; i >= 0; i--)
-		dma_unmap_page(dev, ash->dma_handle[i + 1], ash->size[i + 1],
+	for (i = sg_i - 1; i >= hsg; i--)
+		dma_unmap_page(dev, ash->dma_handle[i], ash->size[i],
 			       DMA_TO_DEVICE);
 
-	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0], DMA_TO_DEVICE);
+	for (i = hsg - 1; i >= 0; i--)
+		dma_unmap_single(dev, ash->dma_handle[i], ash->size[i],
+				 DMA_TO_DEVICE);
 
 	return -ENOMEM;
 }
 
+/* Handle the case when GSO SKB linear length is too large.
+ * MANA NIC requires GSO packets to put only the packet header to SGE0.
+ * So, we need 2 SGEs for the skb linear part which contains more than the
+ * header.
+ */
+static inline int mana_fix_skb_head(struct net_device *ndev,
+				    struct sk_buff *skb, int gso_hs,
+				    u32 *num_sge)
+{
+	int skb_hlen = skb_headlen(skb);
+
+	if (gso_hs < skb_hlen) {
+		*num_sge = 2 + skb_shinfo(skb)->nr_frags;
+	} else if (gso_hs > skb_hlen) {
+		if (net_ratelimit())
+			netdev_err(ndev,
+				   "TX nonlinear head: hs:%d, skb_hlen:%d\n",
+				   gso_hs, skb_hlen);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Get the GSO packet's header size */
+static inline int mana_get_gso_hs(struct sk_buff *skb)
+{
+	int gso_hs;
+
+	if (skb->encapsulation) {
+		gso_hs = skb_inner_tcp_all_headers(skb);
+	} else {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
+			gso_hs = skb_transport_offset(skb) +
+				 sizeof(struct udphdr);
+		} else {
+			gso_hs = skb_tcp_all_headers(skb);
+		}
+	}
+
+	return gso_hs;
+}
+
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	enum mana_tx_pkt_format pkt_fmt = MANA_SHORT_PKT_FMT;
 	struct mana_port_context *apc = netdev_priv(ndev);
+	int gso_hs = 0; /* zero for non-GSO pkts */
 	u16 txq_idx = skb_get_queue_mapping(skb);
 	struct gdma_dev *gd = apc->ac->gdma_dev;
 	bool ipv4 = false, ipv6 = false;
@@ -159,7 +232,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct mana_txq *txq;
 	struct mana_cq *cq;
 	int err, len;
-	u16 ihs;
 
 	if (unlikely(!apc->port_is_up))
 		goto tx_drop;
@@ -209,19 +281,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	pkg.wqe_req.client_data_unit = 0;
 
 	pkg.wqe_req.num_sge = 1 + skb_shinfo(skb)->nr_frags;
-	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
-
-	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
-		pkg.wqe_req.sgl = pkg.sgl_array;
-	} else {
-		pkg.sgl_ptr = kmalloc_array(pkg.wqe_req.num_sge,
-					    sizeof(struct gdma_sge),
-					    GFP_ATOMIC);
-		if (!pkg.sgl_ptr)
-			goto tx_drop_count;
-
-		pkg.wqe_req.sgl = pkg.sgl_ptr;
-	}
 
 	if (skb->protocol == htons(ETH_P_IP))
 		ipv4 = true;
@@ -229,6 +288,23 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		ipv6 = true;
 
 	if (skb_is_gso(skb)) {
+		gso_hs = mana_get_gso_hs(skb);
+
+		if (mana_fix_skb_head(ndev, skb, gso_hs, &pkg.wqe_req.num_sge))
+			goto tx_drop_count;
+
+		if (skb->encapsulation) {
+			u64_stats_update_begin(&tx_stats->syncp);
+			tx_stats->tso_inner_packets++;
+			tx_stats->tso_inner_bytes += skb->len - gso_hs;
+			u64_stats_update_end(&tx_stats->syncp);
+		} else {
+			u64_stats_update_begin(&tx_stats->syncp);
+			tx_stats->tso_packets++;
+			tx_stats->tso_bytes += skb->len - gso_hs;
+			u64_stats_update_end(&tx_stats->syncp);
+		}
+
 		pkg.tx_oob.s_oob.is_outer_ipv4 = ipv4;
 		pkg.tx_oob.s_oob.is_outer_ipv6 = ipv6;
 
@@ -252,26 +328,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 						 &ipv6_hdr(skb)->daddr, 0,
 						 IPPROTO_TCP, 0);
 		}
-
-		if (skb->encapsulation) {
-			ihs = skb_inner_tcp_all_headers(skb);
-			u64_stats_update_begin(&tx_stats->syncp);
-			tx_stats->tso_inner_packets++;
-			tx_stats->tso_inner_bytes += skb->len - ihs;
-			u64_stats_update_end(&tx_stats->syncp);
-		} else {
-			if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
-				ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
-			} else {
-				ihs = skb_tcp_all_headers(skb);
-			}
-
-			u64_stats_update_begin(&tx_stats->syncp);
-			tx_stats->tso_packets++;
-			tx_stats->tso_bytes += skb->len - ihs;
-			u64_stats_update_end(&tx_stats->syncp);
-		}
-
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		csum_type = mana_checksum_info(skb);
 
@@ -294,11 +350,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		} else {
 			/* Can't do offload of this type of checksum */
 			if (skb_checksum_help(skb))
-				goto free_sgl_ptr;
+				goto tx_drop_count;
 		}
 	}
 
-	if (mana_map_skb(skb, apc, &pkg)) {
+	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
+
+	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
+		pkg.wqe_req.sgl = pkg.sgl_array;
+	} else {
+		pkg.sgl_ptr = kmalloc_array(pkg.wqe_req.num_sge,
+					    sizeof(struct gdma_sge),
+					    GFP_ATOMIC);
+		if (!pkg.sgl_ptr)
+			goto tx_drop_count;
+
+		pkg.wqe_req.sgl = pkg.sgl_ptr;
+	}
+
+	if (mana_map_skb(skb, apc, &pkg, gso_hs)) {
 		u64_stats_update_begin(&tx_stats->syncp);
 		tx_stats->mana_map_err++;
 		u64_stats_update_end(&tx_stats->syncp);
@@ -1255,12 +1325,18 @@ static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
 {
 	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
+	int hsg = 1; /* num of SGEs of linear part */
 	struct device *dev = gc->dev;
 	int i;
 
-	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0], DMA_TO_DEVICE);
+	if (skb_is_gso(skb) && skb_headlen(skb) > ash->size[0])
+		hsg = 2;
+
+	for (i = 0; i < hsg; i++)
+		dma_unmap_single(dev, ash->dma_handle[i], ash->size[i],
+				 DMA_TO_DEVICE);
 
-	for (i = 1; i < skb_shinfo(skb)->nr_frags + 1; i++)
+	for (i = hsg; i < skb_shinfo(skb)->nr_frags + hsg; i++)
 		dma_unmap_page(dev, ash->dma_handle[i], ash->size[i],
 			       DMA_TO_DEVICE);
 }
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 9f70b4332238..4d43adf18606 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -103,9 +103,10 @@ struct mana_txq {
 
 /* skb data and frags dma mappings */
 struct mana_skb_head {
-	dma_addr_t dma_handle[MAX_SKB_FRAGS + 1];
+	/* GSO pkts may have 2 SGEs for the linear part*/
+	dma_addr_t dma_handle[MAX_SKB_FRAGS + 2];
 
-	u32 size[MAX_SKB_FRAGS + 1];
+	u32 size[MAX_SKB_FRAGS + 2];
 };
 
 #define MANA_HEADROOM sizeof(struct mana_skb_head)
-- 
2.25.1


