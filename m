Return-Path: <bpf+bounces-38147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5169960863
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B42843D9
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAA1A00D3;
	Tue, 27 Aug 2024 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AkPRi4J0"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5419EED0;
	Tue, 27 Aug 2024 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757599; cv=fail; b=r0mxpb91pzbFEi1uihkgp8l9AN5ZuPzqDGCFkzEr5QpYtlxk5aOWNMNQjTc9fvxbgQiVaLlXnNpfbfQ/EvXwhoTBxN+s55VZhS134VULCf6T+8gulfun8Z7qCHUxWytTcT5fnj29Z5UI9mw5rEQh20cYtRyT+Xe/cu5UqfPzMvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757599; c=relaxed/simple;
	bh=Fyz52jKHuBm42hP/JTx2nrkGhHqDKj9Wgo8sKy2WQUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGLnLu9CJPvXxBl1EM9tfivMBLsSAPuTHfEKZrauITO3u4BAHXdlwn6beszLPCvxZ3Ja28ieX3M+RWHjuCP3UUp0rgtsyC97qk+90J/Y5Jtwe/Sx2zKPgzcnwYigyZ5em+i404OSSQJ5vaV7bOZAlYTYGJqsYFOtHtlI03f9niQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AkPRi4J0; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ72QJoSMs6Kbq3LfFuwTUOClk6j1x81Ts//Hhx1gJ83FjgEXlaZzzlqJHMGfFxdUEsQfIreEHwVjT71er993P32INaEtIsyPBK8vwxNt/A8sQGn2WIO7Lu3WkodDhxciL6VjvKAPDG68f0YyA/P0uVueRcz3/XticgszgrfgRi3+qHe2aAr9JE8w1j/hDVdlEWDClKWlimxCkyOSnK+OXluqRyRm8ny/pphCiKQ/eai07yIZZ+2KvsqX2RVVv5ys8TBQxpQCfzNWKp/ont12BhpnEyNzxSYDuALWeS67VrXH7u8gQy2FrjaKwC37y2ZkSk3I/Ajvrzuppb0kaE0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qokbfmim53lgb6bEqM4cCVypLveI8YA4aI/FJ9K9xso=;
 b=uJyNdp1p9Oy5vAKBAF3LCskvrVmJmxd3byT/9tKPNzrSPg3T/unjEO9hFl2hjsVh1SQZA6dqYM3gBM+C6tqTHsSealE2+o5IB67E5u+8CuBLU/CNLXVve+olIU/acfF3Lz9rvB0JpAZ/NqjzhXoFaGCCu4W4KbNUL3ldMvPXRwJ+UsW5nWXy7PeZls384wDXcDQDBq2BZYyuCyHgVa+D3oW8lKwCa0BDvclSXZAE0iqO7hLY64zBR6+ZhFLy34qwworbuAnNarCeUaMpMdGFW1SvhYTVgrnyPPT93tev/2Sn6ZOyhz/KxVIuFZWzjuFVNH3M61m8W1ba64U/+gvDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qokbfmim53lgb6bEqM4cCVypLveI8YA4aI/FJ9K9xso=;
 b=AkPRi4J0/niQCc2egDUG9sBCdSAy2loq2G1G3Br8IeWjbCG3BTeoj0PiJLOVcDa4fzG8mDcFvqucRf08/g61+hQJ/RowmIrwpQTrEZiqFAPyT8jPSsWRYtF5ofQ2KsY/Sh8sDac0l2XhROwxZ99nQt60Jw3nWKsqQKWWnfcKR+OygyD7lHDKwMldEbdyiOfNvyeAKb0Gqbjc72Ldd68ElisGLaXFj8njmKpcBOZdTKWXkWbM3awv3BuRl4zRFsVLLc+PNZU2Xu+KwBhr6Hh78ZOOStA1Mu83EFYDIdueBSEGLoER5NSeOm528lJWtfEzFefjF9FcrnRoYl8fhHE7Og==
Received: from BL1PR13CA0194.namprd13.prod.outlook.com (2603:10b6:208:2be::19)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:19:53 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::1a) by BL1PR13CA0194.outlook.office365.com
 (2603:10b6:208:2be::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:35 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:31 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 09/12] ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_xmit()
Date: Tue, 27 Aug 2024 14:18:10 +0300
Message-ID: <20240827111813.2115285-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6a6524-593b-4b67-4446-08dcc68a2c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3RdunSxHZEun7yq/DV6AFFKD8VFCk8H7Zc4PoHfMVG7oBBayWuIFm8+d1WA?=
 =?us-ascii?Q?OgXT4BGAWFo8Iw6I+XkMCf7YN9xNfpo3JmAScVfpWlI61NA47j/h4Sjlb8D9?=
 =?us-ascii?Q?/a6aSjCGmBwp9fxdrH0JPsY2b4mGbv9b+ovqw8bshhofFFLdDVbV20rdZISw?=
 =?us-ascii?Q?h3oTFynsI/2ddjOSvBEdjzFYLv27oFDCTQGv05C8oN2oLj0WoZhBwskasiS/?=
 =?us-ascii?Q?3+gH0wC3QtgUinbln2BrwUyZFpFN8R80QKJgzLZ0yNIiqeX3rHufhORm3l2g?=
 =?us-ascii?Q?HbLixfYpW84hVtTkZj79cHfF+uu0ibUCKPdD/Cy0/t5l3KHleqyuE/Ww8pE4?=
 =?us-ascii?Q?iR96GL3TZHXaerPxCuWbPLol6DHqGIxMfqrW1LOywGAp1VQvXlOYx5Hgn9hq?=
 =?us-ascii?Q?UNHIRB1/iCNcRMc5NJPsx5nW/6w1nAEx5Y0SRFL125D6LDqtVwAq3j1fHPa+?=
 =?us-ascii?Q?qkBIilZzvGFwmZss64RF14DkkJ7vJ6G4bi84AC2C/bLZcXeYd1hupQvZcYwl?=
 =?us-ascii?Q?YzIQG/1yUgewI6pGntmrMtXriP0npQmTx2Ilg0iONv0ERfuBHdjy6wHSIgtW?=
 =?us-ascii?Q?ZxeWJ38EZCfHTbyn4vVhdjuZwj/PcrHw2+VAHNnNEHnOCp3hx1p8VxT43Dz1?=
 =?us-ascii?Q?MI1L4lHmh03dc6GbyZWk42swFvbzVBM2/ksl+E6HLjEZ54/K4zyQa0zB+a6q?=
 =?us-ascii?Q?a790jYRJwc0US+ykLLCagg+4WRzldSp+8ataqXUeKWWI+KnQ13ljlSsYZ+C+?=
 =?us-ascii?Q?ira2UenjAH93JcUqol5PW6ICTc2Bakz45/l5apTwTJX2fhRuRTagANriHt13?=
 =?us-ascii?Q?7akuUGOQfxTa74m53P8Co7HTPst3t7eeHvWF7TXvFwhXbcQGafXHOgPRvjzi?=
 =?us-ascii?Q?RlN312Dg04hQ/MeKyXMKb3HHALd//1uDAK9Nqc5+g89UZ8sIaFnrNEa0o2JV?=
 =?us-ascii?Q?0A3FW7atNMy1FuIIJbzg5/YBjl9y4EA8IYgA9j2uuQvLJkhu2ZeuYeD9A3D/?=
 =?us-ascii?Q?sTeKtmx/Z5J6GKYQKHTWeWlBofKq3U1G2UyzXC6NUOC6LgCRk4TiJ37q8pho?=
 =?us-ascii?Q?2IEJjTvdYr79Qe98E+AMDNGtPec4arULORwRoAFt4XQ76LXLE8P00LmglyI8?=
 =?us-ascii?Q?1mreZnM+fJpQFk+YtccgT6QYO3xHgASddeS64ZeDlisRZpfTrxc1ZhPyYiBC?=
 =?us-ascii?Q?9WQ7HBRzqplN2vfYORQoDsQrlslVOy3gT6PDvVLPNZ/sUeskkwoLgK63Q0I+?=
 =?us-ascii?Q?eH3H2eWonwODz0Az62LoHLO+0MwP+xOStBaUuLuIJ3cDCetjt+fjPAxToD1E?=
 =?us-ascii?Q?htslz89fA7hB1YMT+267ueBeMsnzvXXAOCPnsk07HQ5Ncw7oomkHJcRP0f58?=
 =?us-ascii?Q?Jus71gODe1OqY5LBStBM5Bdi91nsKceCT0ZQByAlZyElOeAxzFjTJ1nxKx/P?=
 =?us-ascii?Q?3MUmjb8G2OVUzPb/mNt1OWQWrF9HzgWU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:53.2781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6a6524-593b-4b67-4446-08dcc68a2c8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

The function calls flowi4_init_output() to initialize an IPv4 flow key
with which it then performs a FIB lookup using ip_route_output_flow().

The 'tos' variable with which the TOS value in the IPv4 flow key
(flowi4_tos) is initialized contains the full DS field. Unmask the upper
DSCP bits so that in the future the FIB lookup could be performed
according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/sit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 83b195f09561..3b2eed7fc765 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -51,6 +51,7 @@
 #include <net/dsfield.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/inet_dscp.h>
 
 /*
    This version of net/ipv6/sit.c is cloned of net/ipv4/ip_gre.c
@@ -935,8 +936,8 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	}
 
 	flowi4_init_output(&fl4, tunnel->parms.link, tunnel->fwmark,
-			   RT_TOS(tos), RT_SCOPE_UNIVERSE, IPPROTO_IPV6,
-			   0, dst, tiph->saddr, 0, 0,
+			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
+			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
 			   sock_net_uid(tunnel->net, NULL));
 
 	rt = dst_cache_get_ip4(&tunnel->dst_cache, &fl4.saddr);
-- 
2.46.0


