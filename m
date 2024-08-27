Return-Path: <bpf+bounces-38146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B5960861
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB88AB21879
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639019FA8F;
	Tue, 27 Aug 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJUYN1fA"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA69196D98;
	Tue, 27 Aug 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757590; cv=fail; b=UrwX37g4dvzWXlPr4q9MWZbbZremFIpGhgRZC1rx/GQ70bMIz5C20pvwDVr5unEpKaZRaOvkA805GSA4Kdy9pYCsSAG7hQI/G6IDHeCQ389kJ4QyrVWKaiJoHOFrYd2uvGiSJbczC6p/rXgOCqpmn2wDHHQNBUmI8gikTodA2pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757590; c=relaxed/simple;
	bh=BCY9n1j8fvx1aGYorSbpNoSErbYYfHK8bWdnwceLLr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5QjodLu1p0N4ach3ylrr1zDIawQCoMjV5HsBHlfA2foNAvAmZ+3bvUR/+VbXfbvQRHSUitT4+JwYnTF7ZtZuTaoF9VaVdYksgkDMPGh2GFXuma4suzQ4sCGkyvcaYZezP+UCZMI3+/YL90ZLKZZuk394Q+4vwOVk1S8LSX+qTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJUYN1fA; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGIUy9aRfOUKuFwQLrjX4zyCNKlDmktPw2qouJlcDGczOE17HGFNMxnuId1dbO6cKVBgPVvZQdsvciEs7eMDP7Q3JeRtx+fZK3A0Z5+3fuzogcymTYdekZ1HneCLmoZbq7CWyWAgVkXDugV422c4ESnoWU8S3MD0rnsMi8Shyq34hsGggZ7tDjKjJukASrp+gTv0fcpsepueH2ezoCnvF3p6HHQpJYNVHLRbSqLyKdgnFbZgnsPc8MlHzWDxGjokon8Q+zOOKDHDprRZvB5JuALiA84p8aH2Uag6gibKT3+UfB0MTBybPyj/Rh9Oxfeuv8JReiDNENlSZLNOD+qZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE+5zcDGRypOphruptI+RyVAQvxKMK6b2Iu8/PzdycM=;
 b=ujEvthy27qTyAVxNltTxE685GufFDaa0UqLdL0YD5vNIjnPsOafqlczomCBc7q1EOARXdt9/igzqp/Yz1hwidVKKPCkHzTn3f283w98vQnwsi395ZrIAbzB9Vi/UT0EgGqvDMFpRCduo4jtTdqzYK8IEyXvDZerM2939jPqP9JkoL/PgiZh0DfSt5SlzwNgUGh+ClRFbVoTXeyQKAzn8KXcAqL3rmYp4Ko/nCgRUQ1TQ+CnUL0S1heiyPXzwoY4hvXP9yxA0cPufhhhj+opM9VY/57NA66/bQFah4JqXkzrPw1kmZK5TVQ0UaWL2kdDGrEAhPdNHzu50p1Fmgt10Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE+5zcDGRypOphruptI+RyVAQvxKMK6b2Iu8/PzdycM=;
 b=sJUYN1fAypczD1A0UEnlyxDLU01VofciClUX334PuaPiPqFpCWoKR3AGfxhOjU67WzB7Qjd9LDLc/rdO32tEVvmPNpF64iDEegWidFhE4O55QPfeBnFK8F1gK0zjLm4K6tgQfRLYh4SQY2YCZn/0sWofv65gZIeRIOuseHRkesXrOQiVIZh5SIrCGYuxTWSlADr9S7QKjkg+2YmAMz9UN/3Kek6MBcMqufRPqKn1EmOqvudIgOK379PTDytHfVsi4dOQZovyQyRHLY64nmQF5Jn7ukAI+3FXF243KNk9qpiFgmzeWBgyo7XnVTz7S4i2veMXU0xnrdtsR6ta8mk5xQ==
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:19:44 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::e5) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:23 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:19 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 06/12] ipv4: Unmask upper DSCP bits when building flow key
Date: Tue, 27 Aug 2024 14:18:07 +0300
Message-ID: <20240827111813.2115285-7-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: dff27d1a-ea3b-4c5a-50bc-08dcc68a2757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnDjccjSpwovbIby6d07M8RVJOG/EsngP/RTb6sTo8/3LFbcfFUdsnXbcVR7?=
 =?us-ascii?Q?5aYZKYDdOWXRgVCD7XhKCM1sDpibsjo8NdjAYFK+ZYhgyO8BzA0aqclVjqA3?=
 =?us-ascii?Q?Hbr4VcYYvgSRDWIaVvq4IDn8YotL7lB0B/63dxFrQdc7Ze9QBfU76C1Dg8BO?=
 =?us-ascii?Q?BNefyjSK1R3ICVO6eKiwTMXB9l7U/f5W6lhtoO8OWTBEJNi3AZiyOQjyNs76?=
 =?us-ascii?Q?zxZzrN47xEIQ8F8BjW5DsSWnrte3X0nVu1SU4D78s1bfvJ91fmWd6yatctQI?=
 =?us-ascii?Q?n+vZh18QdV9IPsxsZ/r4DtLeNYmSptNqRzfJAzDvxckAWzqAukQck+2jsOnH?=
 =?us-ascii?Q?7gog8kEteKJsmk6DTqbtgHytIH9FeFbyHgFR7xzH3SzjNVNbowiMlMsaSM2Y?=
 =?us-ascii?Q?3W0gjB8lZdF1W3NVdpIsYqUz/QJ4ErQL/pZK7VGmg/88p+4ycrPYdFweuN9q?=
 =?us-ascii?Q?Vyxq8oNdXJDSeTHcRl+uTVpuAIpPrXPi/njyEBwwcIKKSDxkpTtnLQpyUnKj?=
 =?us-ascii?Q?Ik+aMwRyBc5lspFS0R+t8MQ/pqnbGDfUHXdBYgNAQh9Hr0vkJLlsA33wLd/M?=
 =?us-ascii?Q?j5weLGefjU6sgC4s4qz6khHi12SjtN44VkJuCFzI0cBQN3GoKGuNdWIJkHmB?=
 =?us-ascii?Q?xjRm3xgUq+SZd26yt3RneoyM7uAiQjVxmi0mm0G/f3E0gteDAk9jk/w1mSgv?=
 =?us-ascii?Q?kb2hWeUcrGDsjsmlhEvZhn8MCo90CfeGHJ5Vk5hbORupi+pU3ilTvH8pNWBC?=
 =?us-ascii?Q?KACKAz56u4GthgUQtaJe54WE3lOcAR7wz2uKZa1CWZ0wTfgHUkoISWLoS1Z/?=
 =?us-ascii?Q?3vlKFP/3mqFO7ndRmT52Q6fRsN+pNiBPXJxwAlOl7GFz5aJTur1tdFJt8ad7?=
 =?us-ascii?Q?n0wP91uoyWpnDnHEHS9V7XbdVU/tD96V/oZnXYdVGcN7frMMPQZyh3bWu4a2?=
 =?us-ascii?Q?OzS/BkfU73G8ZDX0XakBHJdUVfOrC8NmrtDKjF22rzJUj4HsXVOeajgCVijI?=
 =?us-ascii?Q?X0m86gl03EviNoNxfl3c6RL1+UFoNxhS45jQuoBpz4EpyXme0akcrnbWyfm4?=
 =?us-ascii?Q?H+6Am3R1R0x32uGvvcX/lNG7JKMVud/k8ap2S5BJPJUicRX5e3jieAzsg6Qr?=
 =?us-ascii?Q?onfYsr47h4sqavlm4tmdwSDRWOv1sPJQYPBCzMzE73TOktBAbqLFscFyy59y?=
 =?us-ascii?Q?vZcHaxwWChKhIP3+GEb4O78RUUs9F34D2onBoYlmnZpW6ph8BfYRbjjUr0YT?=
 =?us-ascii?Q?lRcFTgcND/lAV/eAuthaXF8f5x84ZaHxYCZyRK6zZCjd0YkfMIy12660J600?=
 =?us-ascii?Q?AvE2dG/Xb0w7IOaNh1JaE3F3lJkfd2aKZuLB6EwsIDqsJfo3Hli1sy8hyt1u?=
 =?us-ascii?Q?9HUElI6WUKxT3w/sxy5yj8s9qEg/Cn8Ft5HoUW7rkf+Gmmy8XzJ6RSSFJrr7?=
 =?us-ascii?Q?VUHHZFVrOXhue9/2sfo+TGd/i6iiMK23?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:44.5556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff27d1a-ea3b-4c5a-50bc-08dcc68a2757
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370

build_sk_flow_key() and __build_flow_key() are used to build an IPv4
flow key before calling one of the FIB lookup APIs.

Unmask the upper DSCP bits so that in the future the lookup could be
performed according to the full DSCP value.

Remove IPTOS_RT_MASK since it is no longer used.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/route.h | 2 --
 net/ipv4/route.c    | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index b896f086ec8e..1789f1e6640b 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -266,8 +266,6 @@ static inline void ip_rt_put(struct rtable *rt)
 	dst_release(&rt->dst);
 }
 
-#define IPTOS_RT_MASK	(IPTOS_TOS_MASK & ~3)
-
 extern const __u8 ip_tos2prio[16];
 
 static inline char rt_tos2priority(u8 tos)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5a77dc6d9c72..723ac9181558 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -512,7 +512,7 @@ static void __build_flow_key(const struct net *net, struct flowi4 *fl4,
 						    sk->sk_protocol;
 	}
 
-	flowi4_init_output(fl4, oif, mark, tos & IPTOS_RT_MASK, scope,
+	flowi4_init_output(fl4, oif, mark, tos & INET_DSCP_MASK, scope,
 			   prot, flow_flags, iph->daddr, iph->saddr, 0, 0,
 			   sock_net_uid(net, sk));
 }
@@ -541,7 +541,7 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 	if (inet_opt && inet_opt->opt.srr)
 		daddr = inet_opt->opt.faddr;
 	flowi4_init_output(fl4, sk->sk_bound_dev_if, READ_ONCE(sk->sk_mark),
-			   ip_sock_rt_tos(sk) & IPTOS_RT_MASK,
+			   ip_sock_rt_tos(sk),
 			   ip_sock_rt_scope(sk),
 			   inet_test_bit(HDRINCL, sk) ?
 				IPPROTO_RAW : sk->sk_protocol,
-- 
2.46.0


