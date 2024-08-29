Return-Path: <bpf+bounces-38378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FA963C1D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB4F1F2349E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6017334E;
	Thu, 29 Aug 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MSOC4AxC"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585D16B754;
	Thu, 29 Aug 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914678; cv=fail; b=DgqUcPRmzBMC+b6qt7RoIANIMfa5S+LTal4rpN6Q4rQgtFsSXeMQWjAZiV0vW4+boQP92YQij/aiZNmi6aVQKWur06R5bEAoBYNVKEUmM7vX3FaB57JAJxUn4gpnmsYJmjt9Lc03IQFcHAPFgE89JfTWwAtT3I6E6CRiPTU0mm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914678; c=relaxed/simple;
	bh=gT5axdLBSY6BKd+4OpmK3jt0qETi9shp93KBgabuCLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPxUYkbgHPwsWTKYU8/BjMeEdooNpYsPF4vbLTTYBdhKRkv7EPl5uAIkHT9kYYoy8o8H/m1hbaN8iz+d/4ZqQuAdPHU2s4MjOjL7ifm1Eem9k/pSqnmvGJle1Fo80DsWHv4iZMxYsnTU37fffZVi78RCpPjPQIEj7TED6oE+jYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MSOC4AxC; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZI349x7jm9hdNQRzP4uil48qrsJMcOQCs7CP2JNpCVCN4Gzw0l0X0Bj8GJl90aAcDq7GZeezfa/tM+EBuBp2x11++KYn8+UwXbntJ75ktuwg0BY8A0ExAUN0qS4HTKrhy7Kq4PmClHiWhFhXUah05GjYiujBs5Mdwxc22DhqcnaJ9rFGCJ60t0T8gGybCl+9YuTeqRzIAqtPBnPTiKuuz/wtFQUM92XrXoZDo1U9nLX/ryk9Uin2TaZkyj9zvhyiWL8xSxQEm225Dx8bSw02IKmaupLUEy3rMmxZrutpNfwCq25DK0MwzFvPvmXe8K2+dk8mdzR8dCVGX+wdlG1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InKboZipqUsKJt2itvVoXND0Mya+GeP3Sk0rjUoSLOI=;
 b=G1OljGWUWdfgtAVpXoEkVdYhxMmw9T0YGrPEFGZO06piHqPfutRtayqwgIF0Rb71Dhym1JQs8cTZG74bVw/YUIptW6rYWgXvVSfOm6PggqxLapJVy1rKRXU2/2TMDZ7bw3aDG94LIWmxx61cHpvEkDRUThzoLeAvuWRyQDIv2nNHD2BWmd7D2QLXY4Fp3/mSVhSdXTIK/Cc0yfaqrPBV8bOqkpVCQQdoValEt3Wzgvr+/d+A1vzdAtJqq9SE1HY5zzDM01+WNfLBaqzHx2s+FZqPpsPAMhG0a58gztw5KA93koXV7/agNGA8NSc6dkbDU80SiqX2DBGyEK6IPLACzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InKboZipqUsKJt2itvVoXND0Mya+GeP3Sk0rjUoSLOI=;
 b=MSOC4AxCnvhUH0bxI+hVrTpPyuVFu4QzIsmeoqWhsjhyO0k+093686eIXCaNHtQvdKDbdm2tzeybSGhIeOsXrMg98R21hNEnJayQg43UAoUqdQIa1wuvTWODDzrF1+Yw1lzAyi4ro0tmdYdpnkfMG/GnAAbxIYFjSogqR/Gyzyz/UEUY9lskIn3IG6GrpAZ4gfU77pRZl0IgXVl5S5pQym1BNXdxyzZSHa2YyZv6pM5/oyh3ejAannHasoMqLMMcOklCcXIeYwnzYertP4GQvB+lvUqmR5MbnjyJsNKgs4yKJZfJ3hZfiShoeua68DjYSTno1XkpJIdOTjhljPofiQ==
Received: from BY3PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:39a::32)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 06:57:53 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8) by BY3PR03CA0027.outlook.office365.com
 (2603:10b6:a03:39a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:36 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:29 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 11/12] vrf: Unmask upper DSCP bits in vrf_process_v4_outbound()
Date: Thu, 29 Aug 2024 09:54:58 +0300
Message-ID: <20240829065459.2273106-12-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829065459.2273106-1-idosch@nvidia.com>
References: <20240829065459.2273106-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 310c74fe-89d9-4144-6275-08dcc7f7e6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dn1QRxnhaK4NhS/zXU0zeRfm8fzUcKiT0glJ1B3E1kQlsxotcFO4xWjyL087?=
 =?us-ascii?Q?nvT3+0FDWf1fAxfc33/6sPfojMJkjRp0hyGMRKuUYLQb50vwMy/VyA28CSBc?=
 =?us-ascii?Q?X5GweapZ9sDPa37NEUC+wpUOvcWGdyFTOyGx7DQMFR4AAMDk7bZrLqcng/cR?=
 =?us-ascii?Q?eKy41BJumRJLEvd65viaMZpkem4rIiT8Rh4IUK2fXxLmwb4sLBtRdoCADDD1?=
 =?us-ascii?Q?qwjBrmIyh2eyy/yeZPyH2czpV52ifpXxkcll06qT/8PiwviSOuM77ogavhLX?=
 =?us-ascii?Q?rS+kaCpcTMOuL4az4GJKZlu2QgvfhQuJZYuE01MZlt28q9hzAzXb/seBFxnR?=
 =?us-ascii?Q?cl2g0TVW9/7CT8uSJ3ghXiyVclNxee6hfT8GV9Z4U/kWxkT9jo3qK14MO2KB?=
 =?us-ascii?Q?0jqPOmfb7ofuRz1nSoLS0DpEirr+xJWNbyOmV8U999pnJn0GcgKQ/9pYSCQ4?=
 =?us-ascii?Q?kTvQ66uyfmtaQgn4NMgwwIAxrhdQvv68DsTZc5kcRmmlZi1Pc19vFF+D8cDn?=
 =?us-ascii?Q?ksj6B7ff3l74z5BM3c2oipP/BnwPpb77s99Cdk6Iy3hUrndGZ1UTELUeYk2e?=
 =?us-ascii?Q?bu6I0Ok2o/nd1ajP52Y7JAiZqSkyPX7GsSCLymFnvMn2VDaPZggCa/5uZZKu?=
 =?us-ascii?Q?b56OnRjc7NzvhpB79H4XqhGZCxjHL+1/zvdEl+t6EkBvVM0OKWbnhFlF+e9Q?=
 =?us-ascii?Q?WMApM1ySQnCIESPtIghnCIyywAb0wKHp1m3QfaaYX2N3rQHTax7C5YzHgVrL?=
 =?us-ascii?Q?3waLl0D6MHszzlDWbkJOFKJiq+Q8L8KO26w8g4PL/y/1Ffd82N/phhgFQzZ0?=
 =?us-ascii?Q?iJ4fQ1b36DMBWnq4qIYB1/LR7cDUPQ6NiNaXsQ7UdVCoht6o6M7F+4K+aOAn?=
 =?us-ascii?Q?jNpWrnMpXML60xzQWmu8rjF0EbrUQ5UDdqBbX4C+OaFB6yciQy0MBaHhBHBG?=
 =?us-ascii?Q?vMPLA/EaA/YcE/zuzpUQxW2PIlNh+Hsjpmmob4898/aBJAIa2tI2DB4Gjb9j?=
 =?us-ascii?Q?yt4uzFciWtly/R5jQKqvxUHTCg666U4JpeLOAeLFQ39HFiTT2KvlphAEeKkN?=
 =?us-ascii?Q?y89kS1ZkwGkwMWKghKSKf1rdYy0TNUxnrxxV5Jis/5Li7pc+WALcXDzcu6j6?=
 =?us-ascii?Q?gzk10m0At6QvA6lQme0ao53RwXPTqauovWQKMBC5Is8gybakyVmgsalKtufZ?=
 =?us-ascii?Q?4PqPxQwK/0gRKBiyfzNKRDW5ULtQbbr5gBRXsAR2H6Z7QBE3S5UbqYztMom3?=
 =?us-ascii?Q?JBJ5RoE19j4eZs17S/9pFJUplOf8B3adZXGjEnlrqlR1JGxFaM6Fdyps0gLB?=
 =?us-ascii?Q?byad3FBvBWaZC9FLq8mE6zpT5OD27zqd7CIVycm/avcSBbKjo3uMJUFbCe48?=
 =?us-ascii?Q?44BpH17CA5AGcMl1ORtpbcUbzeH1V8t3UySyXWwlGx90EAoSSBIv4vz2kpvi?=
 =?us-ascii?Q?w3ZczBt4mqpS13+3y5rvp7KdH3O9z2zI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:52.1702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310c74fe-89d9-4144-6275-08dcc7f7e6ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483

Unmask the upper DSCP bits when calling ip_route_output_flow() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/vrf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 040f0bb36c0e..a900908eb24a 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -37,6 +37,7 @@
 #include <net/sch_generic.h>
 #include <net/netns/generic.h>
 #include <net/netfilter/nf_conntrack.h>
+#include <net/inet_dscp.h>
 
 #define DRV_NAME	"vrf"
 #define DRV_VERSION	"1.1"
@@ -520,7 +521,7 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
 	/* needed to match OIF rule */
 	fl4.flowi4_l3mdev = vrf_dev->ifindex;
 	fl4.flowi4_iif = LOOPBACK_IFINDEX;
-	fl4.flowi4_tos = RT_TOS(ip4h->tos);
+	fl4.flowi4_tos = ip4h->tos & INET_DSCP_MASK;
 	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 	fl4.flowi4_proto = ip4h->protocol;
 	fl4.daddr = ip4h->daddr;
-- 
2.46.0


