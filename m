Return-Path: <bpf+bounces-38149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92EE960868
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9322328444C
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA0D1A0721;
	Tue, 27 Aug 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMRB4koE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C0A19FA9F;
	Tue, 27 Aug 2024 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757600; cv=fail; b=ga9VoHMYLi2349WY5ZV1JUXCJkfm5F6DKWBL9a6KkNU9VOHnixbtJS0GEO+bVe3st9joNqkbpeaCNT9fper4Px2dGY0XmjEVXbPZ2KfCvxO/bWkaAPM6flp3geMJ0tWWx2dzrFfki4joPXI9aTmFHHCD3IFjNsGpxGZ2PkaglCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757600; c=relaxed/simple;
	bh=q/5k6ot3xoqd7hlWEV14gY+MzskC1MBhrNI2Mj373Sg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0s+TgPNb+u/Oaj9IcZ2xpA3YReM2AkaaTeXzbWI+idPIm5p/B7UIBiVZWyuqv5BkzrLXNitWzT4eKWb1ykT/Dgwfo/syr98DXWn68EW0jyEQZwPHody44/usMHptozujdd8V9tE8d3VLVKD67lkgLI5tJ0Er0AwIBjJrE2j9Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMRB4koE; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRklrnejhH6guYUHBm/wq1OW44d7KqiW4fOVIW1a7wAOGO5NjHE2pz285NKrxEoGxDoxP0GZdy0MxzOZbvKJCutYPFAS2jNg/MwvVSNvS7S3WViZmT2jztnnkHfPMCue00V1GQgnxiMBBG8NHees3EueQksfygvDbQ4hyIY9IpicHnMNgf3nKIczBUCNq79KngJ3z1kmM7Kua1hagdCaQ3gL+uB296vcimE+RdVKQngWkVQm9huhVlpedwYvHdK05ZRk9AVW/ZGeAmw1mMbsRVNTLR3ADmgiLEaEKhWSP6w3xnIOfBtSmL0gVr3Kh7fULDt4mv7SDwXuBOoruxiBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgdfvZkuelcLLpm1MQ1bLSOfwJX6wvJMkxjScOTmXaM=;
 b=wbd045Bj8hQtcSm5KmRggdRiV0FVNoW39etjCcawko/5lHtUs6Z3CUQQs3ZD62XHfwwLccJBCnpN7d1wpLojDy6oxluO0pR4mmtpUAKzSyzTATYGtpBb5LwZ/wbDKJ79ZBrFIgjrKvDkvDsEWXrSpTwYbUG0UKWzxDIHhUZfHea1VgqcZKgUyVW2F11kKB6YYiQ8s7p8ygsxaNqG6iSNHttoIkV5nkCLj5tKAFNJEJRUeuN1R5l2OemlBSrYQI2TUYs0rsNinFhETVw/CMUsmS9E5f31aJcmaFuL4eAJwXW4JkqCvi3SJlvc1Fhk9xnEZyXU5bglQt8Pa4vjEYychg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgdfvZkuelcLLpm1MQ1bLSOfwJX6wvJMkxjScOTmXaM=;
 b=ZMRB4koE8KiegExDO1mUQ5gEx3i5I4W7axhKoKuXTc6jay3kjpk5edCNIT1xBJzLlmFWdxAxXk9pRMZI8KTFvYbZgzqiNvyrxVp5y8/ERDCMgxTU6UxYf9P74fjk9ylYPUslBMDCYqsNz4D+b+3kSgyB9VE+9yh27NvtCL+QPMCKeCtuXOO0nhoBFU6vkMrNd+0O/ZGae9WIbhjY6/mXQbIGRxSvHXuKYHPP4bcpXSReUN8pWKHK59eF2yWvelaB9Sr8S95mCy2j/njDV2FLBRF2RwPNebPHE/RlI2KvVXOVTEp/sYX1Y9yybzxa47lREP0WYSqUrekz2BMdqYUC8Q==
Received: from BN9PR03CA0644.namprd03.prod.outlook.com (2603:10b6:408:13b::19)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 11:19:55 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::ad) by BN9PR03CA0644.outlook.office365.com
 (2603:10b6:408:13b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:39 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:35 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 10/12] ipvlan: Unmask upper DSCP bits in ipvlan_process_v4_outbound()
Date: Tue, 27 Aug 2024 14:18:11 +0300
Message-ID: <20240827111813.2115285-11-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827111813.2115285-1-idosch@nvidia.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3dd10a-8e75-428e-abc0-08dcc68a2d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SYpYMgU/uUGVWxq7wPjD3gjBSoulDUVJc5fqXNtW4mieFhEF0IOgaNWfY7Lb?=
 =?us-ascii?Q?Gik8+e09rUkctdt/VzNrAgV0Iw3KWrwUL3fuDKvdxptIKvsUdPxI4w143AP4?=
 =?us-ascii?Q?v6Iv7cGfbnEXmTVsYGrAR02U9gPUUv11Gzi0Zi4rQgVRu468DN8Lv9tppn2I?=
 =?us-ascii?Q?IdtpT7sqnAEU17o/HIz8echRVI4jLH3Qp4WdBPBvS5k1txyyXpfKqBRyYIaB?=
 =?us-ascii?Q?9sJd+CjWMZMI2uqCthUkz1CEnI9mWqm2PNC53xYB/ANy1nHBgD+kVMZnqGVX?=
 =?us-ascii?Q?gpoJgBrJKtkDySXjHxNNnyPIDJKFWK65lcbBp8OYGqXrP/XBMt0nq9mRpGNC?=
 =?us-ascii?Q?S7SxN1zZPYkqFVBgiokENTUvCxkDfAPslupIN2NjCt732Jr1Qm2ekgXGqAdB?=
 =?us-ascii?Q?H9QVIqgv6E36Y6/8fWHKqrkcSOhadtolHaJboCuZMbZGR5pV2NVwa6J3i4cK?=
 =?us-ascii?Q?cDRRCEeXXG/TPsBuIG8Op/nZ4jI1W9v86eqdUr2eBmUppv5YpFbyuP3GP4Bv?=
 =?us-ascii?Q?dweNss1TI2yoabbPOIhde9ZedW4JYpn0Sal6c5JTsU7dy+MEKvKwaqfsxAFW?=
 =?us-ascii?Q?Yabj5H+QNdcvdpjJXJcl+s8c+QrEXM9W2ZoM6jhwh8pHncIU8TXpP6dCWVK+?=
 =?us-ascii?Q?TYeRfrYFtp3cu7ahsA/R79fkIt/TEtSCtNlXMH6oia/UJjwJxMQAk9VH/THm?=
 =?us-ascii?Q?LXheRF8TMoR7nAgWduJCgRwRlRWUfWsgiC/+tnl6vtIvGQFmJ7ya1kFPeO+F?=
 =?us-ascii?Q?Gsll/TB621JqDQCbJAdY7gL92OFWM0jslR6Ruso9ZQfEFe925viILf+0ZtVr?=
 =?us-ascii?Q?6RwDRAxJbFvW2O7npnYve+VxTp7pUVruWSWz8QoiMe9I0imetTRIvWygVxb8?=
 =?us-ascii?Q?bZ7EJro/2BQ2ZzebL4c4QeI+Av++TzRY1x1hYENMBKySz9QQvkvhgfiyuEee?=
 =?us-ascii?Q?7bb1/7sHfkDpqm/XOjG6/H/R4T7sp0D2pgbEbQGJBY7mceaFgjYEezCEHDAl?=
 =?us-ascii?Q?ILdfJIZDXDSZH0yrRr+6xhQqGhoxdUCB/9YBaA930+IG6FYa+lMcSl1WCluf?=
 =?us-ascii?Q?5ZZzP55l6wDa7H4KCkPDnmapcFti3csrdMowglIxqL3ik8MlB2aOf5fqZ1wj?=
 =?us-ascii?Q?JozCCIrRB/dDnnDj69m6lXVuHqO6I3EYEoNxzRjUbL7Z6y699mkYGbX2uS8/?=
 =?us-ascii?Q?pHOcd+W0WrH+S0lIDLA0XfNry+a4kUtXkqhoJt+WBMz/tKnN4hCqiUXnpHez?=
 =?us-ascii?Q?lQw0M45Tpszwz0vYdSMMm35CxsR5y9DYlx+KXRsQYpdw9sFyDV8AXXQgSt/i?=
 =?us-ascii?Q?ed3Po91qqFx6X+tHxWgcEMt+M0ChRU2lNU1H6xBCwXHWPQwGCcMft/cWR3t6?=
 =?us-ascii?Q?GPpPC7HZl1Wlm+GF4jxqoa7W628ClHAr/i+ojci7eHypjsCDMp+pSI6Mp1CK?=
 =?us-ascii?Q?ybw2kJIHi4t2l2e/XH4vvjZiNqUdpYST?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:54.9126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3dd10a-8e75-428e-abc0-08dcc68a2d83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

Unmask the upper DSCP bits when calling ip_route_output_flow() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index fef4eff7753a..b1afcb8740de 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2014 Mahesh Bandewar <maheshb@google.com>
  */
 
+#include <net/inet_dscp.h>
+
 #include "ipvlan.h"
 
 static u32 ipvlan_jhash_secret __read_mostly;
@@ -420,7 +422,7 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 	int err, ret = NET_XMIT_DROP;
 	struct flowi4 fl4 = {
 		.flowi4_oif = dev->ifindex,
-		.flowi4_tos = RT_TOS(ip4h->tos),
+		.flowi4_tos = ip4h->tos & INET_DSCP_MASK,
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
 		.flowi4_mark = skb->mark,
 		.daddr = ip4h->daddr,
-- 
2.46.0


