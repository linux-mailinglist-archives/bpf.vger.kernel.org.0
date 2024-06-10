Return-Path: <bpf+bounces-31747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9665F902A88
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E541C21064
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4DD5B1F8;
	Mon, 10 Jun 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RFq/pg9K"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D5495E5;
	Mon, 10 Jun 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054642; cv=fail; b=ALPQ2fbnykhjyrNmWlMVBsoSKYE3fQc6jal5smYo09/dnyIX12sntz81J/ybiyDzgKuQVCUwW1gYuLgDaQEPsnJaFX/NhbYexrTe1YxpNI7sR+ceVdkIe814Xp77p11827sZiuSHSLoc20+73YemelfrPEMx9IFtObCgtdLkoj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054642; c=relaxed/simple;
	bh=fsI7Py/igBAg1P4pDdKYSCdk7BmtOZBFGC5a8OzCrqo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GdHzwsqTNMn9O208ZwbyJgPdc1o69PIOHARBqFH50G9wCidSyTQ49nyMY7Ak/oiW0oGM41vwsTZoufPuOvQ6swH3VSGFb2/AIsWxBnB4qbBVAadmC//+lwXVZdOquVDDhB0R6hFytfnmpAZDG5kBIezYzoHhEZtUPaYSV08Loq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RFq/pg9K; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzicrn4OObLriRYtDzwOt4AIezmB9+Lg1c+PhWBolnhMFHeyX8sS/DYNFQRulSbY9Hh+WANuRKPd3C2dO891FwB0PsipJWnJegsxDerYqf90cBMuI4Ecqb53xi2Ge92dTOmIdvQ4uHkW9RcUGx9ofYqFsLefLqNLKuwZqMUW0pxp9u4u7g3A8b2QYprQuPDGxU4SYLo+FOhLRPjS5dSyt9Ot+kHUhIIrU6laN8VaJzdwqhV3PI9Iq4Sk16BGVHqBIfsq2gwKd9W70hLgQ1nbkaC0/ah//z9WqytXUFJT/cVjq6e6i8nNFGwGBPLhwC8cmT3+hnJptxWoamYxTPCfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B69dE6bgOmVy8DIKa6aqacXMLDLBE/3EiUNq75fG7M=;
 b=m4jS5WDCYnaD7YxNXqmI0QY1yHOQ476MNr69nTFWpKRmPPLm8FiaQb3kuUhwo18jNnJEDnJraKx2ZP+zcV2vQckI2lNDS3hz/8NyWEwwuTzAvp7eG+QpeUvK8HbN/ijJd2Od42uOdFf0TBM7U9PP5CMRNISdXMZuowQ7XEnNXULWCA/rRmNF+XSlKQP9z+k9w+j9u3h8gizVuBubLAr+1uL8faBgaPRFTEmZFxnyPFylp60TmZq1FO2QUJohnxayBx53WLgitbwhoc0f1/YG7PEVaPtDprJrdmf2evYkUsyWEjEqbGWf0THtJM/SIekbmKS432qHWsfBnDRocr9U8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B69dE6bgOmVy8DIKa6aqacXMLDLBE/3EiUNq75fG7M=;
 b=RFq/pg9KNF/E+zjZs80EagHMiZVT1Zf91KrxERQgi8dNtit6oYq5O0rmabvF+bPEsKRUHtXWXB70xFE8RQ9EM3VV21m1ybDTzS/OK08sT6aUXLmOD6Y7gRCUArRR14dKhicDgsZ8SuCEMBdy0+/tyaKq3jnC0ffQk8tvF33G/MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by CY5PR21MB3662.namprd21.prod.outlook.com (2603:10b6:930:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Mon, 10 Jun
 2024 21:23:57 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%4]) with mapi id 15.20.7677.014; Mon, 10 Jun 2024
 21:23:57 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mana: Add support for variable page sizes of ARM64
Date: Mon, 10 Jun 2024 14:22:33 -0700
Message-Id: <1718054553-6588-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:303:8c::28) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|CY5PR21MB3662:EE_
X-MS-Office365-Filtering-Correlation-Id: 13545593-357c-49b1-1713-08dc8993a27d
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?F4AntR6ea0NL10gq7mjdO1IMA6JQMj+Y9Rh7hcEOxqyM0y7mXXcOb/E2nqbD?=
 =?us-ascii?Q?0WIKFrV7ik9HzId17d9PcKRwdiq/dGO8sxcU7JZyJB4a0mZre+FEH+sBiJQt?=
 =?us-ascii?Q?3VYPxLlmBEes3im7w3GxPvq64Nq5tn7fIPWumsO3WJH6hjJqVmtue3+cnf4q?=
 =?us-ascii?Q?07kQsFCAr6l952T/b5lI1VbWDyp8kG4EZXjOnKTUJc/+JR7LGFfCB0I50cdR?=
 =?us-ascii?Q?epa2p/RdLEry7rhco6mHv0bypZA6rgAVzDlEX/9sTYPHdc3QfKz02EC+d8Mj?=
 =?us-ascii?Q?+DwUm5PH5N/8Rl66CqgLKndi12Bx+TOevlkC3oY5S1c5zsow/7D6myFDZOE8?=
 =?us-ascii?Q?cL0WcvFkFnfIHcCYLw/QNqwm4AQRkVRCDhFRu+PNq2sF3p8D8ru6AnxFXbMg?=
 =?us-ascii?Q?292Vc0GsGJ5rrF9UNaZ7FxdfacQNlZwcxpfChUJq8Lz4likHBBNSxpemfVEN?=
 =?us-ascii?Q?id43YKAxIy8Kg97oORQxTuV4k03oTHf7632NftkzWAbpXtq77nRkBrqTXFQO?=
 =?us-ascii?Q?N3ulh/UjbNvVXDUszrHJVMYFZIeafPLi6udSgaI3cJc40eCZfzAVzeNj/VpM?=
 =?us-ascii?Q?Vebj4/W+NIso6yQgR8sur173n5SLEdORUrx4nn0l7gx2K9h9R45AQYni2jpX?=
 =?us-ascii?Q?u0lfYgdOlWgWF+tN7DzOLCjz9qjFubU67m4JpjSPmpLvW27Pjaeu67Zhwiou?=
 =?us-ascii?Q?UE4S094k2A599tcs3KYDa/7n7fmeKnVnQnrrLu0WeAhev5lss5o/o2OXP0mY?=
 =?us-ascii?Q?raZj5NCm3DwSJ0SoLC2Sxj5e9ZFHfkDHqpHd/vk7s+GbsoesAcX+T3TGCURR?=
 =?us-ascii?Q?/x3lE35tqWX4ruZes5hZf33EOUDgvPSWbzR6NhU9ZlE1gpQkzo2GiLasDomM?=
 =?us-ascii?Q?MVqExICUAXizIahwxDMg2ytSb6uR65kIU6r+STjvxpE6aclw/i3X3pFRxYtI?=
 =?us-ascii?Q?IBphQONMcuD735lMCzAuXMI5VJ6yjkab/jJtu7IDa4Q/xmqSaezinTdJRBUU?=
 =?us-ascii?Q?YYJtEMm+81dP+oOD7gn9eVKBLlEax8s9hYua+SPGCdajdyzc/NAjS8hK4iFX?=
 =?us-ascii?Q?919PjEkylXPVn/yq7HE1whXFbiV8bWxLJDgSiSq4gN1v6n/680fmA5AmQOv0?=
 =?us-ascii?Q?Rko80JLSF8TAYp82yBWOeRC/YkGhwxYoAyrqf23NP3xNFvqWRLmcIJzS91oo?=
 =?us-ascii?Q?Lprmie8UtsoumPZZyfJ99dwloYheMQ4NCqlUiMFdW0hnD13Fd4BzkR2/tRN2?=
 =?us-ascii?Q?NvMKziLBAE+bVjq2uehx0PbjD/Wy+4muToHuFEo2RxwuXDIQv8OAzj4n1up6?=
 =?us-ascii?Q?qfWILgsN9RzTYYjnCASsQw1J0Qs9+mTxYMPvjI6cWwZztflKO5RDCV2r/yVa?=
 =?us-ascii?Q?RscbCk4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?rBGiEmJNTkLEU9FFg8+05zMdfAtjXoGZliq/DhbkIaY+2omjrzHt5yUBN06G?=
 =?us-ascii?Q?JNmFYnyGYJsjqgJeDkmttbtU9x/AO85XkA7suSVrfO/S9+QLaMeJ42umAgSA?=
 =?us-ascii?Q?fOyU0TKOmERwdF1bGoYDtQR72G7jqXQcwRWeCJ9kLiQPLzsOggh6+dbbgoEI?=
 =?us-ascii?Q?W6H/sBCapCZLiqEv4pBjNLyj4SdTtmyPP5YlDZPm8BrbJcfTJYOYjrPZtdc4?=
 =?us-ascii?Q?yPUWKp6vYTUpB2T49AlSPM5sdYugpRBLJQjCxXKj7oRUtsbWiHptYBn4R+BD?=
 =?us-ascii?Q?tg96s3rzb5NPp7SyFnbXQtrRlz/VPDnEHLZdm+8vHdyRdeCmP23v++Jq6ws6?=
 =?us-ascii?Q?HXXWQ5aYtjmyY6XHiGzVKRADfhhjuDc6IAvlv0Kv6GY3Ul4T+f+pOqDjBRV9?=
 =?us-ascii?Q?Bunn5UyNmRculG5ZLw4hLqjMCl1KltzKjGr2T54NtVilii0V+7bN0xkXVVf2?=
 =?us-ascii?Q?ncxPnRQd0bgi/eQxuQBKrXC/tFxfHb7+K82xjtuSkVJMqYYUm/WtjU7eSKha?=
 =?us-ascii?Q?VHI/xBaalYeMoAKFcHYAMMm+02pywn1SjhR+y9/l1kA1vK45BfHkevG5azOj?=
 =?us-ascii?Q?oxT6Ym275AkQMr0LavlYIrwSEhpoakjqYfHPT9DDCWSLAhGgNVIPbY9Y/v4n?=
 =?us-ascii?Q?A9BHfJ9EWcuBzTG/pQC5FLob/KnaIvSOheyRarZKKLK2kOg7xEAAcygLbNKZ?=
 =?us-ascii?Q?Mk2fUgRL+Juxswy1iZ04qSSM9LAUGwKa0ufB3umEEcFdn5IrbNJryc3ISOdC?=
 =?us-ascii?Q?igXqqWvCnjg4+GlMdi5ome8erZrbvsfDQJqdh6Lky0ZRGrRGabJwM8zkfOu7?=
 =?us-ascii?Q?X/XqSTD7QI5DoAr/0Gu+PI3WoOYnhWju0z+vlfInKCrkjM9uDmbrJ/lUBEkG?=
 =?us-ascii?Q?vvGJpfkIYRMM7ZHkQv1f6OwsODP9kTHBFG+fYLG58bUXA/x7HMKqTZ7NgI2/?=
 =?us-ascii?Q?0+W+/F2Avckgo/L9NvlemB6PhfKM3MdMJ4NvtdjAoZEpJ5Ud3NzGGf8lBe7g?=
 =?us-ascii?Q?mkBkjeTBnu7ky2pvct4JnroZYlb4IP0+JQo84hr379oaTNRV2LdDFr3glWe9?=
 =?us-ascii?Q?AOFbB1LNan1PMgrl/vHFD8eSDXdn1dVmnr8S+Z7rz45XgfCo30tfppTYMqmP?=
 =?us-ascii?Q?uJRj98esPy4qmoWkiC/7NPifz11BLSFJD3INp+I+AKvbuR8yCUWiaBv1ztbi?=
 =?us-ascii?Q?Nfvg1n2qBjGYwBc2kBdsX8VjTSCS5eHDDFQ4nGQW+wUubEJgT3b+9yc1ZRKa?=
 =?us-ascii?Q?8GllOqitVhVHmj5FcP+hgELcVHyIoZHC7TQhCgomaowztYWknK2bLAN5dxmG?=
 =?us-ascii?Q?PhadZHhnrIS1sc/sTV4fa4Kgdr9ZjvjCIP9yxdeLOEwzFKpkzm0yKGEaxaZl?=
 =?us-ascii?Q?lY/kaSZRjVjPfU+dabO3F/QDeDCNh9El6KoBonXAp9UvFTjnGVzxJ4Vn13Ue?=
 =?us-ascii?Q?7WPzCRgR6fSQjKXlTbi6zZ+1MEb12JYPMb4SY85DqqyEydo4r1Hl0cwR5L1b?=
 =?us-ascii?Q?LpOo4QP9uF8eweok0kcEPSz8OqFRiDvODTPkChLIjg/fdhf5JBE3XlqZwBKB?=
 =?us-ascii?Q?yzKAnjRVm7kECDFdzkpPYkGYejFcCdmSx9BuFVbj?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13545593-357c-49b1-1713-08dc8993a27d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 21:23:57.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0m773VliSNoNYgtcHRvXM60a3ro4Xi1fJltVFLv3QLrTayNa6cUwd8oPN+jsUaiAohoUXUoBOu7GuLQfjVJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3662

As defined by the MANA Hardware spec, the queue size for DMA is 4KB
minimal, and power of 2.
To support variable page sizes (4KB, 16KB, 64KB) of ARM64, define
the minimal queue size as a macro separate from the PAGE_SIZE, which
we always assumed it to be 4KB before supporting ARM64.
Also, update the relevant code related to size alignment, DMA region
calculations, etc.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/Kconfig        |  2 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   |  8 +++----
 .../net/ethernet/microsoft/mana/hw_channel.c  | 22 +++++++++----------
 drivers/net/ethernet/microsoft/mana/mana_en.c |  8 +++----
 .../net/ethernet/microsoft/mana/shm_channel.c |  9 ++++----
 include/net/mana/gdma.h                       |  7 +++++-
 include/net/mana/mana.h                       |  3 ++-
 7 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 286f0d5697a1..901fbffbf718 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -18,7 +18,7 @@ if NET_VENDOR_MICROSOFT
 config MICROSOFT_MANA
 	tristate "Microsoft Azure Network Adapter (MANA) support"
 	depends on PCI_MSI
-	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
+	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
 	select PAGE_POOL
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 1332db9a08eb..c9df942d0d02 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc, unsigned int length,
 	dma_addr_t dma_handle;
 	void *buf;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
 		return -EINVAL;
 
 	gmi->dev = gc->dev;
@@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region, NET_MANA);
 static int mana_gd_create_dma_region(struct gdma_dev *gd,
 				     struct gdma_mem_info *gmi)
 {
-	unsigned int num_page = gmi->length / PAGE_SIZE;
+	unsigned int num_page = gmi->length / MANA_MIN_QSIZE;
 	struct gdma_create_dma_region_req *req = NULL;
 	struct gdma_create_dma_region_resp resp = {};
 	struct gdma_context *gc = gd->gdma_context;
@@ -727,7 +727,7 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	int err;
 	int i;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
 		return -EINVAL;
 
 	if (offset_in_page(gmi->virt_addr) != 0)
@@ -751,7 +751,7 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	req->page_addr_list_len = num_page;
 
 	for (i = 0; i < num_page; i++)
-		req->page_addr_list[i] = gmi->dma_handle +  i * PAGE_SIZE;
+		req->page_addr_list[i] = gmi->dma_handle +  i * MANA_MIN_QSIZE;
 
 	err = mana_gd_send_request(gc, req_msg_size, req, sizeof(resp), &resp);
 	if (err)
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index bbc4f9e16c98..038dc31e09cd 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -362,12 +362,12 @@ static int mana_hwc_create_cq(struct hw_channel_context *hwc, u16 q_depth,
 	int err;
 
 	eq_size = roundup_pow_of_two(GDMA_EQE_SIZE * q_depth);
-	if (eq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		eq_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (eq_size < MANA_MIN_QSIZE)
+		eq_size = MANA_MIN_QSIZE;
 
 	cq_size = roundup_pow_of_two(GDMA_CQE_SIZE * q_depth);
-	if (cq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		cq_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (cq_size < MANA_MIN_QSIZE)
+		cq_size = MANA_MIN_QSIZE;
 
 	hwc_cq = kzalloc(sizeof(*hwc_cq), GFP_KERNEL);
 	if (!hwc_cq)
@@ -429,7 +429,7 @@ static int mana_hwc_alloc_dma_buf(struct hw_channel_context *hwc, u16 q_depth,
 
 	dma_buf->num_reqs = q_depth;
 
-	buf_size = PAGE_ALIGN(q_depth * max_msg_size);
+	buf_size = MANA_MIN_QALIGN(q_depth * max_msg_size);
 
 	gmi = &dma_buf->mem_info;
 	err = mana_gd_alloc_memory(gc, buf_size, gmi);
@@ -497,8 +497,8 @@ static int mana_hwc_create_wq(struct hw_channel_context *hwc,
 	else
 		queue_size = roundup_pow_of_two(GDMA_MAX_SQE_SIZE * q_depth);
 
-	if (queue_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		queue_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (queue_size < MANA_MIN_QSIZE)
+		queue_size = MANA_MIN_QSIZE;
 
 	hwc_wq = kzalloc(sizeof(*hwc_wq), GFP_KERNEL);
 	if (!hwc_wq)
@@ -628,10 +628,10 @@ static int mana_hwc_establish_channel(struct gdma_context *gc, u16 *q_depth,
 	init_completion(&hwc->hwc_init_eqe_comp);
 
 	err = mana_smc_setup_hwc(&gc->shm_channel, false,
-				 eq->mem_info.dma_handle,
-				 cq->mem_info.dma_handle,
-				 rq->mem_info.dma_handle,
-				 sq->mem_info.dma_handle,
+				 virt_to_phys(eq->mem_info.virt_addr),
+				 virt_to_phys(cq->mem_info.virt_addr),
+				 virt_to_phys(rq->mem_info.virt_addr),
+				 virt_to_phys(sq->mem_info.virt_addr),
 				 eq->eq.msix_index);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d087cf954f75..6a891dbce686 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1889,10 +1889,10 @@ static int mana_create_txq(struct mana_port_context *apc,
 	 *  to prevent overflow.
 	 */
 	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
-	BUILD_BUG_ON(!PAGE_ALIGNED(txq_size));
+	BUILD_BUG_ON(!MANA_MIN_QALIGNED(txq_size));
 
 	cq_size = MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
-	cq_size = PAGE_ALIGN(cq_size);
+	cq_size = MANA_MIN_QALIGN(cq_size);
 
 	gc = gd->gdma_context;
 
@@ -2189,8 +2189,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	if (err)
 		goto out;
 
-	rq_size = PAGE_ALIGN(rq_size);
-	cq_size = PAGE_ALIGN(cq_size);
+	rq_size = MANA_MIN_QALIGN(rq_size);
+	cq_size = MANA_MIN_QALIGN(cq_size);
 
 	/* Create RQ */
 	memset(&spec, 0, sizeof(spec));
diff --git a/drivers/net/ethernet/microsoft/mana/shm_channel.c b/drivers/net/ethernet/microsoft/mana/shm_channel.c
index 5553af9c8085..9a54a163d8d1 100644
--- a/drivers/net/ethernet/microsoft/mana/shm_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/shm_channel.c
@@ -6,6 +6,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 
+#include <net/mana/gdma.h>
 #include <net/mana/shm_channel.h>
 
 #define PAGE_FRAME_L48_WIDTH_BYTES 6
@@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* EQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(eq_addr);
+	frame_addr = MANA_PFN(eq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -191,7 +192,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* CQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(cq_addr);
+	frame_addr = MANA_PFN(cq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -199,7 +200,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* RQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(rq_addr);
+	frame_addr = MANA_PFN(rq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -207,7 +208,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* SQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(sq_addr);
+	frame_addr = MANA_PFN(sq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 27684135bb4d..b392559c33e9 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -224,7 +224,12 @@ struct gdma_dev {
 	struct auxiliary_device *adev;
 };
 
-#define MINIMUM_SUPPORTED_PAGE_SIZE PAGE_SIZE
+/* These are defined by HW */
+#define MANA_MIN_QSHIFT 12
+#define MANA_MIN_QSIZE (1 << MANA_MIN_QSHIFT)
+#define MANA_MIN_QALIGN(x) ALIGN((x), MANA_MIN_QSIZE)
+#define MANA_MIN_QALIGNED(addr) IS_ALIGNED((unsigned long)(addr), MANA_MIN_QSIZE)
+#define MANA_PFN(a) (PHYS_PFN(a) << (PAGE_SHIFT - MANA_MIN_QSHIFT))
 
 #define GDMA_CQE_SIZE 64
 #define GDMA_EQE_SIZE 16
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 561f6719fb4e..43e8fc574354 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -42,7 +42,8 @@ enum TRI_STATE {
 
 #define MAX_SEND_BUFFERS_PER_QUEUE 256
 
-#define EQ_SIZE (8 * PAGE_SIZE)
+#define EQ_SIZE (8 * MANA_MIN_QSIZE)
+
 #define LOG2_EQ_THROTTLE 3
 
 #define MAX_PORTS_IN_MANA_DEV 256
-- 
2.34.1


