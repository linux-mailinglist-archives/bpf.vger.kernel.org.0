Return-Path: <bpf+bounces-54561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBDA6C6D2
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 02:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A41848242A
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 01:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E11C695;
	Sat, 22 Mar 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cmZzwRqN"
X-Original-To: bpf@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023096.outbound.protection.outlook.com [40.93.201.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A524C6C;
	Sat, 22 Mar 2025 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742605564; cv=fail; b=QDLj3yJYpEl2NGZ7jxqI8COeJ3f10I01tNq/l0VWokkXRUzwj22DBJLRgTQAvn1P/U/0N/HhSMV61YhUReqIFQZAp75oRAKUXWwgKAmWHwvRUd0D9C9RjUyOhrLK3A5J18043JsCFusmhi+WFF5KinwueWBqHQPsi6J7hAGZDX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742605564; c=relaxed/simple;
	bh=T9OaDFTIVjBAf83a3Kd05cxOu/tYttk0rQGzXEB7KRk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Gd94oiRTaFlvIklf1HyRygh9PDicp4tMSbrL+k4jhCuI7l9SDt8rqSCcOeRCdA686fZeFX8WercR0PMEtxicrUg2Cr5huWisCTPZG7nkdl3N5Eq3ZDBWGSDITGoPGM0WJGlWaB+PbQFtRjYzfNXOsuG9g6VYNP1Tibe/koEodIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cmZzwRqN; arc=fail smtp.client-ip=40.93.201.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+17DA6+nw5gQhjDWXY5YiiEAHO4O+AqlYUcNJ+AKjZsBw/SobvVoiOVkVxquADdsV3zBvAEJz39fKQRue+iSE/EB5vOkfW/qLvstVCoKoH9KOJ9th5cptnyFh4NfUbd1fIEmxSRWWWpnQNNqICZK/kjF0EkEhNrKdQSHUZJt96xYsuJJrlD9Nb8jT/czZdbT3+JIVxn0BcwpwH1wEOSLwcM4/yUzOUp+wnhp+4I5rBEf3UC7TOx/b11id3aYN9Y3jEnr01NxRouvyv48SgzXu2rWHtSgwwnlLXpZWVDiuB0l7Nl7RRsLvkxnmmzwPOK5TlQLMl9yKrw5dUbvAT/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xegJ0NO/MVmktzMwDUyry+l/r2M7CwRTtmi3eL5XC+4=;
 b=sI4yj25vcSQHksWi5FTnVK6T6v+7ZiuyrrYgLo+yc4ikeNOLnfBxZtE/rP9kF0km8uE/mEXvpYEq7GFfIf1mNgSD8oQXWNOhHc2SFvuia1D1kajS0Gk9O2+JbKw8dQGXqwA+1HBlAHyAK7evP8Rzoh4t+u1phsTkbboQKGcgulB8YBxfNeUz1F1SpUbJ/UCUWCb1K8m458cUMWyNen/DAXmEp/LI2nlFPgw5A2A/i2XrQi2u+6PVvLcFby1TdIhJR7QDHxIel9JrGPOwP/UOFoLOIy3195Mh/zyBHEeeLRxuqGSapez7Xu0vKSnWZAFP6IFP2unnRLNeaHEOl4KaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xegJ0NO/MVmktzMwDUyry+l/r2M7CwRTtmi3eL5XC+4=;
 b=cmZzwRqNLAg2GQkkR00GkZtJivNVSQJ1yVQygQUr7f0BGRJ2rlSBZWDyhqpcQOOZgxdgKUH+6IywmY9dNlmM5+fHyXpILbYGHR8E1+O5et6ZpaaN1c/XJzwggPvM1a9g/Z2weT+4rgIjSZaDTRWp6AzVBFCrU+oX4EVWbqeJ7eM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY1PR21MB4491.namprd21.prod.outlook.com (2603:10b6:a03:5ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8558.31; Sat, 22 Mar
 2025 01:05:57 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f%7]) with mapi id 15.20.8558.035; Sat, 22 Mar 2025
 01:05:57 +0000
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: mana: Switch to page pool for jumbo frames
Date: Fri, 21 Mar 2025 18:04:35 -0700
Message-Id: <1742605475-26937-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BY1PR21MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b50967-dfab-44e5-4d04-08dd68ddb402
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?eRadEBdMXUwEVRg1+Ssc2nDUynlpbIefv7pP6FWbsgU03KZXTVn2aQW5aBmi?=
 =?us-ascii?Q?QXUiL+lgpgRIf0+JZVt8xPWY3a0eDnNwN9MIynPF/eCB29dO5nldhppur15R?=
 =?us-ascii?Q?S/pKp3G4otJzVf5/G1jD+SJ+IQPkqWrsRgs9skg0ZJIQz0GwwzelbLebqqME?=
 =?us-ascii?Q?O70WNd5TJBtzGZutaL1HwcthxWx1mcK/ngzjcGBQnyZiKPgaQERKVPrdMzf5?=
 =?us-ascii?Q?5R+lEF1nMYoJFwOKCpenSCe9+avjKWRVw5Y4BvHROu5DCrrZtMmoiN0dDpAL?=
 =?us-ascii?Q?cNnFxDImSZG/B8/GaZbKYELpqqj1f4c8mvwRRehchTieh2bvxysk89om4buC?=
 =?us-ascii?Q?a5eZGBxm7+zQ/BKDmN8KmIspWzMVG3KAggMg3bcZdoI3PL5/EhROVdTxa8Hu?=
 =?us-ascii?Q?Q3vycZCId0Xp87BnXNH7dGtqpJFBkbX4krCKIOKavGlm+cP6HS1rp4YnrcEI?=
 =?us-ascii?Q?6cmd8u5/0C0nMIxSfORL2IHoDWV7ESOFHPJV0TIkHLed0BJ2HDYdtYTme2CC?=
 =?us-ascii?Q?F3AJZHd2pUEGLcgXfeAc7gK5PE5cQzQHrXk6NabmIcGSyMJZCjSjJ2D+aGtN?=
 =?us-ascii?Q?Mz+3wgfHcAV3LeMyzMOTalcQDbuHDwudE5O4XsAJRSN9EzJWV3HOs3eZQlob?=
 =?us-ascii?Q?PGU9SAynRVGYOntEQpkwH5baWInvAu8FvXfvPN7JMhnUilqQ0yo3d6AH1DdG?=
 =?us-ascii?Q?aAc6nMcZfHHcXI20SQ1KuYBz+S1NJUaOo3HuJ2QmF2ogRemIuW7kiVL285kb?=
 =?us-ascii?Q?1kpb5p2BOemJpUuLSBRMD6Let/gY0BnPbRuskZXd5XA8fXtRVJ/jXEr5Vlyq?=
 =?us-ascii?Q?j7DsBomX3BEdeuDDZR4+Bnyihcgl+yWfNWRf/VVwRr0qROMYp9RKj7DyjcQ/?=
 =?us-ascii?Q?u+/bJOXYIGYRAWuFKSfylPv8L6VGfYaAvkl+FNoVxvsryg0Ezv5BAwzsobtf?=
 =?us-ascii?Q?NAiZkuv11Bxah53mr8ec9EvqUqqR1XSDMWTsw+0TwHGFBzzug+Auma2BOlnp?=
 =?us-ascii?Q?OcoFRpxNrkC/oiGEL6tJrsvz+vTue/NTmrsFbX1M9IEPfLHjBR35Y9ofPJyA?=
 =?us-ascii?Q?NyQF8RljnFGcte/SEKLanKxfId0iHf3dGrM3V31XA5sr6GKnk5by5c4wbCU7?=
 =?us-ascii?Q?N7/uafT+cpB7XD+ndfl8eRawikBO89fbDVj9c4/jM5u9Jq66UUTPeldjdT4k?=
 =?us-ascii?Q?PAj19shydHvBLSkqtZWR0YW2D3kryqEf9ju6s8UvN0YPbZY8qnS2247vD89S?=
 =?us-ascii?Q?FavNDZKyZvta7mJYkmCPa5adMCIxAxG9NMoY6h9/Mspr6HRS1+k8Y/VKet+c?=
 =?us-ascii?Q?uoM/RS2Km09lwhhjm7+QlwKZz+gNlMjkp+hmjPm/8a4wnrdnyfXy0YjmqcsO?=
 =?us-ascii?Q?ckKBvTacNhHGJ5mU5tlkvryMm4ixHPjRlIGgIVhMPRi/gU7zidc1X+eaYnSt?=
 =?us-ascii?Q?o3BfN9jsKNK+8c+Au59WjWo3PP9rqK15NQ3efdAlDxcUcFg+sE5KtA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?iVeST/goRArhs/WAMZTFv4DcyRfdeDQDuyqPmL8dxKPvCL/zNdW4hLFpbG1R?=
 =?us-ascii?Q?vZkCw67pf+Tb3Ent4iaWIEeCyoLJj+HJHYt7Cqn0ZAojrm8ggPZKIT6IulbV?=
 =?us-ascii?Q?v65a9uBxTZLckLY7h4CXdgJUKHFpw7pn3MSXzTMbHmNllqH938/e6NKAknEp?=
 =?us-ascii?Q?PQd3sVCVrAW0sih4+w+QCr7C+0idDLP/kqUH8ngS5YbZ3m4LDr02mFknXifG?=
 =?us-ascii?Q?4S9/K1XDnn1l95mRGMy7wAQUfZYeBcMfryDVijZvPyftpM7iZH+iXJ2zfAJU?=
 =?us-ascii?Q?uOr+vlWViSVFbw9vwQdbf+2ZBsZZZ7XWiqnNOXPJ+/wZRSoq+Z+vY/d+TKpe?=
 =?us-ascii?Q?LEW1oX9OMxQ1PMx/A4djXgAfqwpwRvX5jOcG//QHDUVWdSrB/aV+/C4KNEVK?=
 =?us-ascii?Q?MpkmduwBtu3doA9BHVJBYydGTuX6plXN8jK8QtDOG0ykX6f/twdjWTRk4Xnd?=
 =?us-ascii?Q?AmHBbTg4SrUx3xKjcRK58Pqv1mPH8OEb36H6Be8/Awbu7V3G0oVRb+LjqUeg?=
 =?us-ascii?Q?ApYo9AlXdvpxdPs9nx0aB7vi0J8quvun5OKBs0IzhsNux09v5hktNVE0BVki?=
 =?us-ascii?Q?jqd/Fd+WK9BAkaq8jLiIIREckuZlVgSX4nw9BAp4qwkqQToLwCbrCHbdCfl+?=
 =?us-ascii?Q?B8JA0Oxx9EGZpNNZE6xgFTYMnmpYUVoG5aGQ8Vis9vXJlZfRb+H4sAdf+RsG?=
 =?us-ascii?Q?LoZfGZJ3fJXTBxF5peDPNX0VUIpuur5TNjmAcZk9epVxCIKWL9z9y9gf8wva?=
 =?us-ascii?Q?5mK9yRAw58SC4FYPNpl/sHUDNb6yB5uffqeb+lTTzUQOCLoZkuKotGKGZsaf?=
 =?us-ascii?Q?uctHRSZ5IkzGqsgduq2/o21a/nY2qGQuZrx49dc2IsTA0ckJx2tTZgUxpmnJ?=
 =?us-ascii?Q?mOdal/2fEn/+/Qg/tdRKaZ1t6X8bmZxc+xW6OnyV3Q4nJAItX3twDM8tdci6?=
 =?us-ascii?Q?KqzPnSediY6+mxq99qEkdFhlbu3MqDFQqS9ovxp2Y+MD/OfY2IZ0VvYNxNsI?=
 =?us-ascii?Q?HjJoESPh50TCkC3wyNnkR4N36FcqqtzQaYUDap6o80tTp+Thm+ctAFU064VS?=
 =?us-ascii?Q?k3goks6g624k0Xglz8pEv0QzgOB/R5QSuprnfYLuElq9qPteGXxaxC1rMYWc?=
 =?us-ascii?Q?F6/wf24UqNYCt2O0wxkdjlbi5k7MadcsdT1N4moS1oFoJI0jhMWzK6bAOs+V?=
 =?us-ascii?Q?IufN+qgCWZ77SMAYIvSUsO324jdvK82mioIhnk1ye14Q3FDUwJgGIWAN/nUM?=
 =?us-ascii?Q?e/vJ9PWw355GO2d0PtSzlGNDk8eEwShNqUj/Q2UkMGMi0v9swLI/eK8pY9np?=
 =?us-ascii?Q?1TCzvl3DHw2VNz3J8TGq1e2e7FLmWTeDqCbRuiCbVRAybFB4ehm1R5dk7oBG?=
 =?us-ascii?Q?UZVggSpBo8jUHX168X4brlFilupVezNoHG4uDI31/WLO3IlcsefHMZ+dLcbk?=
 =?us-ascii?Q?DcMpeSONQJ8Tsa4yxxnatM7/GGIijQOfyAobRSmMeXaOoSJ9TlsTJME7Jo6N?=
 =?us-ascii?Q?4g0hKFgwUeHY6+msKWKskmhUsoOe3oYBEH2jWtDLKLbtGDZ8H5IgToRinLED?=
 =?us-ascii?Q?jSG18ujwARPpZLqniI3pAo9WDYl4vGuTYsI9L3Bm?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b50967-dfab-44e5-4d04-08dd68ddb402
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 01:05:57.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAWaO4RnYZSCkqrhphL30NdDUTzq5f7ncpQ2HAB34UGEAwQ7lvfyQWMdixDe+05HIQN33cSZE25TltcteDF6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB4491

Since commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
page_frag_alloc_align()"), the netdev_alloc_frag() no longer works for
fragsz > PAGE_SIZE. And, this behavior is by design.

So, switch to page pool for jumbo frames instead of using page frag
allocators. This driver is using page pool for smaller MTUs already.

Cc: stable@vger.kernel.org
Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
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


