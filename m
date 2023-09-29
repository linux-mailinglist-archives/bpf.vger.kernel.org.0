Return-Path: <bpf+bounces-11135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC57B3B6E
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 81C89282491
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B54521C3;
	Fri, 29 Sep 2023 20:43:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61815849C;
	Fri, 29 Sep 2023 20:43:49 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020018.outbound.protection.outlook.com [52.101.56.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351B2CC0;
	Fri, 29 Sep 2023 13:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn4TiHs7YvVL16wgSl+KCZJHgeon2wHpGX32skHRj4kfW5bCH7xionfc6ETiS3L6+AUTKnU6iKr+mwVIQCw4Wfmiys347UuwhdC+8uZxQ4SZ9ZkRsIirhbwcyYfCsrvCKD0pdkZ/uYA2kq4nFy4D1bOBSBjfXdDHl+d4ZBN9tPGpYbe02ayoBSA/1fZ7jKqkDcZyqYC+LKO4cOTgMrYU0IOdqKHak/JtqT66Q2hE9Wdi0AUe3PnDAkXPSPQ+b6NA+CcD6FdYp/cThLLUGbiihtSQR7O0jAd4DKGsNj57uZjmpLvqNVxCwIlCTcSyHuambQlExE9DqN3s2f1NPARIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqC7/sBy3Pmx8EznfoNj77qtEBuneii4Fl9wNU4LjF4=;
 b=IIV1YT6qZZAOILFffEtWmHhQ9FwShWy+aguUrKIK91J8+2ueR2RgkgH2Lj5A1ZimMI3XQf1yOvkCJLFkNG1GUQy6K8p2pUkGArtTG6vRsXAjpeJ4+sTTi17liW2sw5elI+jaeFX7fcsazmTfYU5TCSlyqUGVC1T5KKbVbiDTm3Ut8p6j18huHK2odE1Kx4xlrmbQPWUsMuxabLBYYQl77ce99qBfKF31xezWVPmnAMqku2miJpLxNUrIrnJxIsFhqsZ7Z1WwtBeeXydxlLbspFbrWuZJ8R7puaj1miULS3SXkWDSaAEuh3DcsaKNsoljPkYmet8I5VhSIs31TMDQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqC7/sBy3Pmx8EznfoNj77qtEBuneii4Fl9wNU4LjF4=;
 b=iFaMMkkqTxMG3m0i4x/+f2YvC8dQE4IT/i0oEpxNRfCXgrNXQKVjDa0rRcbPH3bU/F7Vpyk8Ti0TOlmstWDQEUGrOEtu3NLur4M2FlZZtwJU33jMlnm+mSgcNdGTtUsrIWI9KyQ8wH2d9gBahpMIXrElUN5qi6wCpXxR303njf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DM4PR21MB3178.namprd21.prod.outlook.com (2603:10b6:8:66::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9; Fri, 29 Sep 2023 20:43:41 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::1d4f:5006:aed7:78aa]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::1d4f:5006:aed7:78aa%6]) with mapi id 15.20.6863.016; Fri, 29 Sep 2023
 20:43:41 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
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
Subject: [PATCH net,v2, 3/3] net: mana: Fix oversized sge0 for GSO packets
Date: Fri, 29 Sep 2023 13:42:27 -0700
Message-Id: <1696020147-14989-4-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
References: <1696020147-14989-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|DM4PR21MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc082cd-13f9-4088-9f86-08dbc12cc40d
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 sWcQ6kgEC3IRe2ClVHhWuhx6EbC/qDfHSjueXqXjk7+fJBJ1o7OzuUaiVpuCtCyUZJhNrAPtEuA76ETOWGchhBKcROAljrcqEZ1eTzmWi3kNiMaLHizbce7+vKBp6cnCGbYtfD86Xp25vPFHDrnJVSEouRQwDIZze6Fk+ZPWdnaPoafUif7bwfGD/aWzV4NP9Gsn4XPQs6DvA0/CGXkfYWdEyxaoQnvL61ItmwWS3ipzLNb4ePdApFm198GZHe7Hs5LYCcHIncdXRiYW9r9dfnDrUpjUojCylBjjyhdgT3/pt5tEih+FAxxGsPPr+cNpqtH3zPTG4uoN3Z5zLPT+tn/TGaMr8ImVqZg/3Jcq2I7fbOl3T1aheiQhdnXC1e6iaWlN5sr8tCrZh7AQ5V8Rrh+gcqvwcfq8OBGnoSFjJVKj+W2n34v5cOJjXSiSaPzyqf2GLiqONympbBvJxId5zQASUqn3A0DjRDZYZKK5bg94Bn76vHSdLENgq6nabDw40flwTKwy9phqX3jFq2XFSj1aP/Cy8gLLNJ9AZY9NphW45MsvTPAnLNwSBpsbT4CPxfeh90CcciNZJMVeISIu88CWZZ2fWxcMnbPUigJFaFiwQbOJLRwglzg1qZkdqLfkaGECGbvYvW2k8lR+skxffrhcKxRmPPubr+/Rh0Vvma8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(7416002)(2906002)(6486002)(10290500003)(41300700001)(8676002)(66556008)(66946007)(8936002)(5660300002)(4326008)(66476007)(6666004)(478600001)(6512007)(7846003)(6506007)(52116002)(26005)(2616005)(316002)(83380400001)(38100700002)(36756003)(82960400001)(82950400001)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?dEmOkRGezta3ICeZGoXZXw4A/4zVLXeECbSThETgHKMvSYtwdCusu4+a4JsM?=
 =?us-ascii?Q?lQOxVsblRIJFlUrir1vIphOKF4UJyr4y2Q0n3dpdXBIUWpUYzMgiS/NY6s2J?=
 =?us-ascii?Q?uqn+fy6L3JZNPV29o4iz8sQiNt9xGPHTr2NrBds1RRMOD7GIiCvNlq/L7VKD?=
 =?us-ascii?Q?Ujt3v8Yp/DtSkB3qzhz3vKAWgkCmoSD65v+7BH9fQ0G9G3IhhKBwBWh2Ilqu?=
 =?us-ascii?Q?GNeI0kKrKCang/9ufBm0/c1N7w3zLofn5StUs9KwgqDe0ZWoTzgZTj7Ck2//?=
 =?us-ascii?Q?d+K2xDS/AX3h7YwP7nMwLPv+LFcti9ICeBi1f1ZONs/aUPsknkUF4lpt8rUm?=
 =?us-ascii?Q?MT3KtgeuCgSEKpOZlprKZFuMB7rhigeYQAe9Z134a+alyTLKScOSLQ2ak1C8?=
 =?us-ascii?Q?Y9BkofLP5eVpFM0Dv/jSbRU5jiDlkCxYdxQugjpppLrpgwLQl3yPNERbH9iF?=
 =?us-ascii?Q?lngb4sdXUJBQg+d8hH36LuZVvMjonuqqL54pOE9ApnBOQQ9REfq0F97CGeY8?=
 =?us-ascii?Q?lDpzAaIltZ/yAKlbduHKb4ABc+VpMfz+DNU0OHQxtVpUgzyjSCQZwenkTP55?=
 =?us-ascii?Q?89lzGv+eiP8bdDMpthwjdLV34gz/RSgxWIPmr6Il9rlQVhTxTcGO5elCioAF?=
 =?us-ascii?Q?6NgcrhD2+65aJrN/24E3H8mRvgcSqvuJxMPTl+8FBN7qveR4t9u7o7VjGJXH?=
 =?us-ascii?Q?PN1aFEN6Ya+KqN/3EdjbfU3FeeRR0BnaV1ZHW4LPbpzRpCRJdH/nphnA9os8?=
 =?us-ascii?Q?havdHnfrjyH2gPbs3XfTh2ZKxwV8tDqkaAWcSTe4jPb7769fRvzW//ETHmL/?=
 =?us-ascii?Q?HsVCGvq2xysyoeViBMLkUJzquYinU+DH9ZKMa5+9AipZx9gjDq7bdyOeIJ9N?=
 =?us-ascii?Q?fF/ow8xrHLgsm2xl1e2eSnyIQgFRAsuKFP4ZUNGQcV9iaxNAkPyceqKRXT/X?=
 =?us-ascii?Q?7tPYiQvKS+RYNr4kycnSzqj3U7fIiYHJy8wmlda8/kcLaSM0oZBbYK4qeWVD?=
 =?us-ascii?Q?940zpUKoZav7hoGS4z4CMcKHlXXXKrSXzdAnQINV+XpP9SGts9RcA28Nzjq+?=
 =?us-ascii?Q?CWlu7qykAKgLddde7H+f1HesHtVuoitVGA4Q2ILdlYHjPjhnmhkaZEnekawd?=
 =?us-ascii?Q?/tMvZa4NOAvPxRR66gJF+HLBb8UR5SG0PFzBbvHo01CviaNSxnfc+PWPo5gq?=
 =?us-ascii?Q?XpEb5EjObJd9jOgo8et6G5tJo+GdC78VHZpdMMHHKRDgCBTPwBLgufCYyaP1?=
 =?us-ascii?Q?wh6l9vlB4kJhrW9J6J5e/HvA95B1bxvYI87BkXWGhFvC5turWuFWL1vucS+8?=
 =?us-ascii?Q?QmQxzYmNUOdD2ByrUH1myi6mPAy5azCxWJ0nlfdOsrFM4nneQmclKSvM774c?=
 =?us-ascii?Q?pNXt9M08TJR0AmqA0IktGuCBLCtvTbphBt9S8zHmSRdqoL8Rd2MnBAjl+3HV?=
 =?us-ascii?Q?vN0bPOGvGjHoWl+hXe+ulJ0RHdJb7SNEmkBXvHxWDtnGsFJpkZQt1COPVTM9?=
 =?us-ascii?Q?1kVBxIjNuXngCa3mjtcbrF5fmQV35/Za5oF38F2GDNmzYb+b6IwuhBVfsggf?=
 =?us-ascii?Q?DtRUNlgdv2Y8qnaECNSKKKcQKTQt4hcaTptQ0rL6?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc082cd-13f9-4088-9f86-08dbc12cc40d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:43:41.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOhvLssdInitd9lE6gUZGUTROdJi0qAf1Bn4ranWzLs9QR3p+mr4ypLe8aGu3yTuTPS0pHLBL7TAhkTzq/ExzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3178
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v2: coding style updates suggested by Simon Horman

---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 191 +++++++++++++-----
 include/net/mana/mana.h                       |   5 +-
 2 files changed, 138 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 86e724c3eb89..48ea4aeeea5d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -91,63 +91,137 @@ static unsigned int mana_checksum_info(struct sk_buff *skb)
 	return 0;
 }
 
+static void mana_add_sge(struct mana_tx_package *tp, struct mana_skb_head *ash,
+			 int sg_i, dma_addr_t da, int sge_len, u32 gpa_mkey)
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
+ * Return a positive value for the number of SGEs, or a negative value
+ * for an error.
+ */
+static int mana_fix_skb_head(struct net_device *ndev, struct sk_buff *skb,
+			     int gso_hs)
+{
+	int num_sge = 1 + skb_shinfo(skb)->nr_frags;
+	int skb_hlen = skb_headlen(skb);
+
+	if (gso_hs < skb_hlen) {
+		num_sge++;
+	} else if (gso_hs > skb_hlen) {
+		if (net_ratelimit())
+			netdev_err(ndev,
+				   "TX nonlinear head: hs:%d, skb_hlen:%d\n",
+				   gso_hs, skb_hlen);
+
+		return -EINVAL;
+	}
+
+	return num_sge;
+}
+
+/* Get the GSO packet's header size */
+static int mana_get_gso_hs(struct sk_buff *skb)
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
@@ -159,7 +233,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct mana_txq *txq;
 	struct mana_cq *cq;
 	int err, len;
-	u16 ihs;
 
 	if (unlikely(!apc->port_is_up))
 		goto tx_drop;
@@ -209,19 +282,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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
@@ -229,6 +289,26 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		ipv6 = true;
 
 	if (skb_is_gso(skb)) {
+		int num_sge;
+
+		gso_hs = mana_get_gso_hs(skb);
+
+		num_sge = mana_fix_skb_head(ndev, skb, gso_hs);
+		if (num_sge > 0)
+			pkg.wqe_req.num_sge = num_sge;
+		else
+			goto tx_drop_count;
+
+		u64_stats_update_begin(&tx_stats->syncp);
+		if (skb->encapsulation) {
+			tx_stats->tso_inner_packets++;
+			tx_stats->tso_inner_bytes += skb->len - gso_hs;
+		} else {
+			tx_stats->tso_packets++;
+			tx_stats->tso_bytes += skb->len - gso_hs;
+		}
+		u64_stats_update_end(&tx_stats->syncp);
+
 		pkg.tx_oob.s_oob.is_outer_ipv4 = ipv4;
 		pkg.tx_oob.s_oob.is_outer_ipv6 = ipv6;
 
@@ -252,26 +332,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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
 
@@ -294,11 +354,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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
@@ -1256,11 +1330,16 @@ static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
 	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
 	struct device *dev = gc->dev;
-	int i;
+	int hsg, i;
+
+	/* Number of SGEs of linear part */
+	hsg = (skb_is_gso(skb) && skb_headlen(skb) > ash->size[0]) ? 2 : 1;
 
-	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0], DMA_TO_DEVICE);
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


