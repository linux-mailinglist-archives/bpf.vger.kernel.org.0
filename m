Return-Path: <bpf+bounces-54700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D9EA70711
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECCE3B0CE7
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95425E806;
	Tue, 25 Mar 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H/FQe3sF"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022097.outbound.protection.outlook.com [40.93.195.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4AB25D8F7;
	Tue, 25 Mar 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920372; cv=fail; b=t1PgePHyAcLqFPQClteY0YoWPc+XS7Z+tZkXZcy9ysNxf06C8bb+uBE58XUC/gUynC2fOyHAG9lw4amviEhftRgJI9Q4+Arqf22NoW+yx83/h+0mjO9/6yQ3MbRdyu4tq5oCUIE5Lc9nZTjHB3bZsbBgyB/pZCxLAKMBA1ff9x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920372; c=relaxed/simple;
	bh=Vrd/lNAUHg+hjPive1rHQK37gtkkMwnJWtQofwGzFZA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WwFgB/CoXdapxOKobn1UrNz3vo5kYLcPiIw6n01uSSEAgQL6o9pr8vbmerK0ZPBson8oD0lLhmLqgTybtIW3JOAxwpOy+CdZawRh6OGjtZFAhY0A9rxl5Y0zYFVDQkCV7rPmpIakF2UnQJ7CPtWr/5ClrUrE4GriPLrS2lxkwpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=H/FQe3sF; arc=fail smtp.client-ip=40.93.195.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDZn/Psgr3YcgJJbL6H8EcfSrokDTvwND2GLMmJ2GdJCiqSSZfgduv8WHOxLz84nmtqTs8tsTS88C0fw0j33mhBqHeQAQE4pdK5Uz83V8ydL1wzPVcpOIL8i46QKWziHnEb2vJu4ZyK/rt/D6/8aQQ1b8Ld6Jw/Y5v0D09cyZGSC12NXgTuC8u+y5O0ct3hGvll78zUSQZai0ftOM+fkVu5u5AjyD4V8rc72S/7vq6PFxjYq2Tqsjtn5adsVqwZYycpJOJ6HlV/TA2vrTuU14ZGN5Omr9wD9nZU/aginm/+8lQhnGiKwbeERisIbZwmkoIb/coGQ1riLcvnOASSIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brrxUtbWjX7nO5Ras2SMBt8NGERj+o1dTL7Zl1QMc4c=;
 b=OvEEsyPcHhkn7ZOfKr5chd9VfpvXf9ZyJ2dimjh23SalB7jj0UgVlmC+54+x2CoVhbfCWoDrNqkXqD/+MWKY0rYiw3iVb6GB6eEb0MeMftY+96ga5BEGfuk98gBiszQO5oE8fum59Hbra5JtMw8bQ7c61XZKjnwiJD7Ro1nY9VAqfjNTY7DPZUVSbu7XIcdcXuYvrH/u8eZQiJKqfd8FTT6DW5GKE0YtJTcKey+fXJ/u99Jee+k9nOKCMzgAm90aWz+gKeG3CNMwU0UbPIU9AaSSk30Ob0hI2OmopSg1JRgezoyd58Btkla25HHAqSB1EkBQ1+gmRbEUw/8wZGoaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brrxUtbWjX7nO5Ras2SMBt8NGERj+o1dTL7Zl1QMc4c=;
 b=H/FQe3sFPn2xSqL90Eleqzv4SibAQRWTyiHxuTLIjc7Pp9CKaaAU8mcZWrXPhSoiA7SOL1oS1dui1c9tqz9bOjZlX7J0xwC7R+zuDzsiQ93CoVKgewOx+EzdQCOP3017/QSxH+I6NlLsEGkoleJuZDBlg/83rKVf8SlHSGUWJI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BYAPR21MB1334.namprd21.prod.outlook.com (2603:10b6:a03:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.25; Tue, 25 Mar
 2025 16:32:47 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f%7]) with mapi id 15.20.8558.037; Tue, 25 Mar 2025
 16:32:47 +0000
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
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	jesse.brandeburg@intel.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
Date: Tue, 25 Mar 2025 09:32:37 -0700
Message-Id: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BYAPR21MB1334:EE_
X-MS-Office365-Filtering-Correlation-Id: cf591600-dcbd-442c-c29b-08dd6bbaacf6
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?nfxU0sYIT8urEOkBlRo5GSYGErta9BgDQyqL5X73xJZL6aYheUTen25cuZhB?=
 =?us-ascii?Q?DO9TgyrEflYaYkoH4fUJy+bY4j/HRP8lHYdxX73bP84g9bypE1qiXtguteQ6?=
 =?us-ascii?Q?wKV1LR5k7yzAAiR6FDwTI0vBbbGzNQddFeLiItFENxaU7PQe/ALK6a5Na0mH?=
 =?us-ascii?Q?UWEUpPkk8WUVMuZ9d3kJcOEb3rSbMKB+F5dTimKHJ48pGaTLx5MSZx1xV1QW?=
 =?us-ascii?Q?2DxJLpmuwkU8PNfIIva53KJ/Y8dROw73XGMxKDc+5W6N7rKpSC+ECNtzse2/?=
 =?us-ascii?Q?M3tkChHd5VnWASV0ScltVinc8NxGs0lpPILkDnTEJKPyVyZJaqtP7JNJCud7?=
 =?us-ascii?Q?GrRbpc68Y4c1EMpc7Hed+zumSPhbj5WtGeE3aLOOpRnxomWysrOYzow9hJsO?=
 =?us-ascii?Q?sMm+vI3KmvNIUiMTnWtw2flELwR/mEnLnfLZKEBnhT9nM2uZX+BjQIE62yUo?=
 =?us-ascii?Q?6kXkREdwlVDbDgR/19mBakE4xdqJbpMDO9gvQ5mmdFnG16q+jRqyVc+QPGZ8?=
 =?us-ascii?Q?6MiE0oOiTezKloiEdt3wL/DKqqJvqwU59iiK8/yLDE+2rZ8W09lENZ6HZGEe?=
 =?us-ascii?Q?CRjQgUDHxrY3ZIm2Sw3ckSoUrhfNpGBE+8cjWz05Rc0NZWMR/EGucd6sDFPs?=
 =?us-ascii?Q?6p8BYgUxWbwilEfj9bmeMzD1oz7KuTNQjEAA+DN4lrKoNaB8s3hgKot7ONao?=
 =?us-ascii?Q?LX1YF5dCnunlxgo18yE4gkg1Y2Tk79hWbwZGAWRJsWOvwcjV2ognRYLc/CGj?=
 =?us-ascii?Q?qkJRtgjaVWiG6yx5LllTVD9nocvKOowvocNMV5ZlVb1FDvIZjEbSrpMS8k45?=
 =?us-ascii?Q?AEqv7/8tQAwN1kcZ0FtTxAPu/zvhdipDbDLW8jBg2zKLueeVI8BT+8FeYlVB?=
 =?us-ascii?Q?V51YBj9Z33uPioX0gP9xH2bWKIxHOTo5ZE5KdFsoc8KqA7/HMfhBer65+6Uh?=
 =?us-ascii?Q?2h+vDFVze2USR1cGdjFN+MQ965jU8bCJNcTw1VN0cjMpcOgkEbRP114CG2Ow?=
 =?us-ascii?Q?aZZZNPzK9OROj8cI0/z5ciDVMaqGs3H6yHyrGHq8PGOxHSuRIyP9diSgbkBJ?=
 =?us-ascii?Q?a8P0stBx4o4W8oFGrLiRVd7LfX6uwDRATg2a/mSsOeK/jmtkOXHO/VwQp/Mc?=
 =?us-ascii?Q?moMX8tkxZNDoAHypKgnH3i7YSzFFuzZaVqjWKlIDqQLQ6x/r93it6xt7SLTC?=
 =?us-ascii?Q?fAkga9H3zDYvbddFZTqLDGzuNdMenYgtkq2nNWOxOeaSHWNgvpHg/rVemR+s?=
 =?us-ascii?Q?3egRXxNhL6TmIf8WCIpNVDXaCiBXiYsLv3QZzY8siyTUHWsQsF8v4wiXz5DA?=
 =?us-ascii?Q?eBDhUqC6WsQHcc92a81QJ8xX3coUUab+hEY60eVjfcW30aQSKVDfbIo8CYOb?=
 =?us-ascii?Q?8Inrkb9Z3fbVVjFebCUTiAiCPvFzGx0PN6jEYPx2OVgou7GYbVcSojnTFytZ?=
 =?us-ascii?Q?8u5gfmnerB5HTBycCS1hp+RUE1UwQ0tnNPqBJSQJMq4hnBrdf8mmqg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?2PkWScBkdajWdMSroHTA4eUVvCqEG1fVkJb3moRJerfzwI9dDaHbQvokJ5ki?=
 =?us-ascii?Q?qU9GHQ96AMXccbKs3gTgFt0gmekaNWJsxCCr18mQmKq2IJPE+ey9Nww4mhO+?=
 =?us-ascii?Q?vl/LShGXi1e5GWqu9MHjF4f/FX3Xebcn1FARUGeHI6sLCGXtA+P7CnwDOJAK?=
 =?us-ascii?Q?g8tlaz9SHmsqxYaxviL2BrWsXJu50t2skmRn6IkyD0IeQ2B7gW8UySC1bvHW?=
 =?us-ascii?Q?Js65KOzNMv9QhxBmb6cXrC/APsKT5T0O4rYlan0zZ6jPhpFlsoZxF7ir54rB?=
 =?us-ascii?Q?YYDGAy5B4azJ1nD73IqcCShw5uoxAjEb7Qq6gnKW2WfL1JQY0mFoffnszq8X?=
 =?us-ascii?Q?Rv1NIueMnQ8sNNCuhboeC9UIcF0oeMvedZ7h1r8GXv4oDq5yl8pSQpeKrPt2?=
 =?us-ascii?Q?jBoeGfAAUEjAl8K0Gj6I0mC58p3B1EiUpBRZO+XY8MZlUCBg+lin1RTHXyKB?=
 =?us-ascii?Q?psbcyj5RyXi7vEicNRkSrWT938YczozWFCCiilG0kwBxUCcg0Xds5XnU9j4L?=
 =?us-ascii?Q?NOrxoeaUvIE9m5CFz0cQK/d16zGKTcknwrujWTXATzF1WUBIuTeKaFLx9fxw?=
 =?us-ascii?Q?5IDa0Ql+3+yFl6RhHSJ7D7VFWcidljurbHxsocCzf3ybxiu9wa6P8Cyr/HIP?=
 =?us-ascii?Q?NkmX9WtFtROsP5yf/f84W4xOyWvJwgcAnoYh1tj/sviebQiU6BCWFKxcyjSc?=
 =?us-ascii?Q?ZfdwPOoufYedQ3Tc+d5jd6fwg0+ErQQ2YeoiZO6xuI0CWtkWU2CHbmzsdH7Z?=
 =?us-ascii?Q?0jJh/7Fv/3du0QsGxyQgGO02i8MYSuWd0bCYZQ44bymNc7akzOY0BUx2lGU2?=
 =?us-ascii?Q?YNLTbfbBIKOI1dotCAFnwrSQnW3ee6hfGa01KHgK00MB1q656HeO/rIrFJ5A?=
 =?us-ascii?Q?2jPPcvCNrkLZmtCBJUQhdeGS94adaHeBZ0kbB6ph4VAndUpNf+nS/VDR1txY?=
 =?us-ascii?Q?hnINaEYlIxQdvTNnTgVpuGJhxbNW9fsfOEubAtN8Xz/gv7Ktf7jtj8gSIW8+?=
 =?us-ascii?Q?MTCeCagb6uRSnjqwE9n7zd8kUFGvVNezRFw7/gYXllJ20UCJfZohn50Vq1z4?=
 =?us-ascii?Q?PoVA53A8pDhPaAb8OGxYOLuFYrQd41UkqgLfUv0zTVReOeeqtxnySjcD+hUK?=
 =?us-ascii?Q?Lre6VCzmqMLEEWYRqosWdRH9B73lTuVmqf2yhoA5hK7Z9TvtkSezOTtVrlIc?=
 =?us-ascii?Q?oDhi8G7rlrOzY/QwmlQgWFUPB37a2CVj3PsRTylL3BF41b5dJEzpHzONAY3+?=
 =?us-ascii?Q?0k5QJqSXld/emWjBX6TqMc/K9RVeLVI/A3N0hrYerRiUCa1u8v1JnYoWBBgP?=
 =?us-ascii?Q?i2ATSctaCIvozr4bga9Y9Gd7dkxoDlmiGePFm1mXptGR8kJS/+wt8fx7gcku?=
 =?us-ascii?Q?hpaHohtZUNWNqU02c5C0IDDwy1hStEITPXqLYqe9VUxR+mAzzabhtG+8r22x?=
 =?us-ascii?Q?izAfAeSasDSRy+Zg/YSqdOct7e9Vzm2f7rfrVknYJxpVAvYJFbfldPFWydHo?=
 =?us-ascii?Q?qH+33ESmbGRMa8k8qZB/+Wkg7x1zKxyUv/2v8MM1/hj9KbTHcndZ+qHRR3Ht?=
 =?us-ascii?Q?FbSpVXwwQUsU8JDQ+PQUwe0sdG8rMn+/S3rfVMTo?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf591600-dcbd-442c-c29b-08dd6bbaacf6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 16:32:46.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NFnc91fx9rI7T86/Y9A9o5+FEuK/+RJ5X25+w3r1Dt4M2P1cJLvfT9q+aQ/39x0fVGqAthznuk4e4ayrvLXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1334

Frag allocators, such as netdev_alloc_frag(), were not designed to
work for fragsz > PAGE_SIZE.

So, switch to page pool for jumbo frames instead of using page frag
allocators. This driver is using page pool for smaller MTUs already.

Cc: stable@vger.kernel.org
Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v2: updated the commit msg as suggested by Jakub Kicinski.

---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 46 ++++---------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9a8171f099b6..4d41f4cca3d8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -661,30 +661,16 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_qu
 	mpc->rxbpre_total = 0;
 
 	for (i = 0; i < num_rxb; i++) {
-		if (mpc->rxbpre_alloc_size > PAGE_SIZE) {
-			va = netdev_alloc_frag(mpc->rxbpre_alloc_size);
-			if (!va)
-				goto error;
-
-			page = virt_to_head_page(va);
-			/* Check if the frag falls back to single page */
-			if (compound_order(page) <
-			    get_order(mpc->rxbpre_alloc_size)) {
-				put_page(page);
-				goto error;
-			}
-		} else {
-			page = dev_alloc_page();
-			if (!page)
-				goto error;
+		page = dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
+		if (!page)
+			goto error;
 
-			va = page_to_virt(page);
-		}
+		va = page_to_virt(page);
 
 		da = dma_map_single(dev, va + mpc->rxbpre_headroom,
 				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
 		if (dma_mapping_error(dev, da)) {
-			put_page(virt_to_head_page(va));
+			put_page(page);
 			goto error;
 		}
 
@@ -1672,7 +1658,7 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
 }
 
 static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
-			     dma_addr_t *da, bool *from_pool, bool is_napi)
+			     dma_addr_t *da, bool *from_pool)
 {
 	struct page *page;
 	void *va;
@@ -1683,21 +1669,6 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
 	if (rxq->xdp_save_va) {
 		va = rxq->xdp_save_va;
 		rxq->xdp_save_va = NULL;
-	} else if (rxq->alloc_size > PAGE_SIZE) {
-		if (is_napi)
-			va = napi_alloc_frag(rxq->alloc_size);
-		else
-			va = netdev_alloc_frag(rxq->alloc_size);
-
-		if (!va)
-			return NULL;
-
-		page = virt_to_head_page(va);
-		/* Check if the frag falls back to single page */
-		if (compound_order(page) < get_order(rxq->alloc_size)) {
-			put_page(page);
-			return NULL;
-		}
 	} else {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
 		if (!page)
@@ -1730,7 +1701,7 @@ static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
 	dma_addr_t da;
 	void *va;
 
-	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, true);
+	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 	if (!va)
 		return;
 
@@ -2172,7 +2143,7 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
 	if (mpc->rxbufs_pre)
 		va = mana_get_rxbuf_pre(rxq, &da);
 	else
-		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, false);
+		va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 
 	if (!va)
 		return -ENOMEM;
@@ -2258,6 +2229,7 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
 	pprm.netdev = rxq->ndev;
+	pprm.order = get_order(rxq->alloc_size);
 
 	rxq->page_pool = page_pool_create(&pprm);
 
-- 
2.34.1


