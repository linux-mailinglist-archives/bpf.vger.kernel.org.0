Return-Path: <bpf+bounces-37711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32016959C8B
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE01C21860
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E7519ABBE;
	Wed, 21 Aug 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EcZRSpGE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E8199944;
	Wed, 21 Aug 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244938; cv=fail; b=MbcQi67x46C/zC1wOwpky6zzqzgqzDMXlPJKZ3vFXIm4jlQUC/x+0a1Ky6lyQPs828d/ZVM1JVfL9/wm4Yx5PpzdqWQQP8yCteAsXlKEB3Zvvs/iWDgZzqejy8EWxBmdWf9oC9LZZPsKOTtP11S5AU8rV/9afLfT4mCOnWLj+WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244938; c=relaxed/simple;
	bh=rfhVXhu6QFDE28XK8Nege6IOzpxnYynVh4Jn27fKWAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqPhitgqcL3s4SKTvzTfV0Td5nxHfseBnnfXoVQuL586MTCwGpOUm5wO87D/smtLRVPlb7MxNlTT9lYSMIy78DrdhoP/wm7YfplfmhQreD8UwnuBz2vXKlgxOeJ/7TWYwU3Ir0KyadcRt5f9P1FYc8c9QdiL3B85S2+lYR5IPyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EcZRSpGE; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbEALlCePT44W/mTaDdbwen5Kin+OsALBNgUkrhH5hp/NBS1U9Fxz+6CSCMSVOZCiWbOVpiEQfhSK1j6cng/HiKqnEZFaATZfz4zDOkXhBU1n23WfgoGstbX9M2qacIS35pGjdn6ryyl8v2Xv9pSkiKPcUZ1XACqjiJk/la1WGgV2RBNRH7ZqcN0WKYFtdse9oMCfE8AVI2X/mcSM9EoUjnLz9Givf/RrPKJ3WMwH/fLpCFMnbOgcYVn5nkZOrtxx36BxrQRPtN7SY0K+6eKqz+t4xaSOLYU3vB67UH8VgDLhTJJ3IG2Wt55hOf1iTBU+iqcAhLIv04J7m+nER4Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L75AY9HdQyZxQKxk+MHTelA+77qU3H83oviLZjg66LM=;
 b=hmrCUf9RusNES4wkZVCSeLLguLSjKWJJRKLGBFbd7MnlpMqgOT3Dx4AbElAUxc2BpQhe14rOQIB7dzUVkfEh5uy0qmeGcBKomudvQL6Y5laaKG901CVS6MQTQhiN2eY060vQiKRw6FCyJp8nEx5iNMbbZwVqpPUcNNjQ3dipG2g8dQulPobx22iAyI4x7zbaPMZBTyPoZqGXF9dOEze/f7ZA+PRQb3hTNnltHK8Rg2nkJTzGsiGSPQFXp2Aju/QOqhQNBd0WmmQ5r7dkFHfaRd6xCnZuAdcnj1FK0SbtI6hx9/3WTZCvFTLaWZt6QL2aoD2te+VUN1kvSAElodJz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L75AY9HdQyZxQKxk+MHTelA+77qU3H83oviLZjg66LM=;
 b=EcZRSpGERPLBPBD/70/gCTNnx0iYJRJhjwusFp48Rzy/frvuzdrFKMMhibpzHLsyS7LPBuOnhEguOWQZAKEpCyezVdaFUtG/zAb5SbU/8uJWhuZxzPnuVH9uMb63AwgRmYy0AsIdWILD/s/qpg2/aoVx3IL74kF601uo/xl4JaW6IXU8kdSX9cN2zfKDaLbckvCcjBDQKtYfNb269T/MioDQ9jwfiDMTDuo8Rhz00S4LJQ56rabx4NhkHhpXPunMQbQl2YWF/6rNETXiLhrJDID7bPKtefxaLAcDrxHq0ZcNj5/7jg+P1KrxjAC4nKQoRAY/NTVV/6oAkloCfmqMrg==
Received: from SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19) by
 DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Wed, 21 Aug 2024 12:55:33 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::7d) by SN6PR01CA0006.outlook.office365.com
 (2603:10b6:805:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:09 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:04 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 06/12] ipv4: ipmr: Unmask upper DSCP bits in ipmr_rt_fib_lookup()
Date: Wed, 21 Aug 2024 15:52:45 +0300
Message-ID: <20240821125251.1571445-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821125251.1571445-1-idosch@nvidia.com>
References: <20240821125251.1571445-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 412209b3-3db8-45b7-1e56-08dcc1e08b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oddBt9kE4LhpqHM7VIYfJpVKXbQSF0JowIvHQxV0YpPE/KkIwYiy5PW8TBO0?=
 =?us-ascii?Q?74CaF4qE7o+STqlQTbrR45F+1rx73grFF7UFwQAE3l8MKL1vvWu3jF/Og9jq?=
 =?us-ascii?Q?8zt65l0yxnBfwGS7xEHLHmGnnsjTUgwZXxapD0U5h8+PrHsYRmes3A+pBfkz?=
 =?us-ascii?Q?bTeSvsfFIKIaT7Lzp96GBSczeWdbcuRAWhk285LQh80PPxTENQGa+t0Z0DbB?=
 =?us-ascii?Q?a5KRh8mrMkK3z5CrJrW5fjaAo0ILLtmJWN/ZrEl+lCJAx0DoyiKuRzCH3jsW?=
 =?us-ascii?Q?Zt9/eaAPtdvHBfPEPNS/OU8U+OPXlixOGrSE5K7CMeuE741b9jbZtMbHaZGX?=
 =?us-ascii?Q?rPK5ZOe6z3NjRQyilltyil3eJWdeTJP87dJFFTVo/9O6pY6l8z7Xh6qkEDnV?=
 =?us-ascii?Q?dC+DoY01AqBOUbOm9h9YZ1PQgITJwkkbkygEK/idCqp7kMUkiO2mC1DO2JcR?=
 =?us-ascii?Q?wrHSq3JGB/W67IeRZmpdned0NeyJJlrX8lDJjHkv4fMlK0REul81ugCBKSd6?=
 =?us-ascii?Q?QIEVZqTXd+dOYj1fr1yB8mfoFrIRaefMoUhOBGLQxR3fTxWIoUaMsaZ399I9?=
 =?us-ascii?Q?EXwZ0Z9OCngiKq3rZnjcYv0v82m+jlGVkJSbpReTI2OoCEkbFr0Na0eVDO5O?=
 =?us-ascii?Q?ZJpgy8jcDz1kvGDomEwLVYXuR3D1mKw1nK0J9Aa3VPQ732hz28KFrITjrph8?=
 =?us-ascii?Q?4Rw+4vTe9vaSu+pVf7MAXUs0L3rTQJErp92PLK1qSzrhdwd7geuospgtzfcd?=
 =?us-ascii?Q?Pk+M9b6rNzF+Hx5O02E0AmdOZYzqcqthEuR8k7LF5dEU9S4zeZDdnTDM9V0+?=
 =?us-ascii?Q?I7zMbVjwy3pMtrqUym/3qo1eOvvD4O/beShoH3ooatQFfZkvGr2/Ovdk/YwA?=
 =?us-ascii?Q?Xrq0x9vLHDEnNnGg+M7j2FLmOtnUUf3+OYt+KV2EamgVjyQMwxPLYq2Ol/4q?=
 =?us-ascii?Q?G7ugZsQCHW4p/JnoHUQU/RRPeLVFGWJFWauRsiqGHSiKw286SIcVoo22iyvJ?=
 =?us-ascii?Q?aqT48O8sT228qOd7IOK25tcW9drjhisixQBsGPpm6Mlxk+RWDh16EM1mWArX?=
 =?us-ascii?Q?pn94k2BWbUei6EiKyrlXB6wbkkepblsob84q9zllGshdxxChmF44nJVPzCQB?=
 =?us-ascii?Q?fAIF2B6ui0uU+ne91iwqY75/YG9uKjdYnaZBUrOQHNPL3dqQfgG6iTKnFZtA?=
 =?us-ascii?Q?cNOUS2kdcd2FBzL1a+69DRXVZune3kZ6DGxc/JZB5k1MHxZ9m782clC1W/xF?=
 =?us-ascii?Q?/kIX5Rw+6CPUlysKw3UVvpnSXEcgkSC5nXg8Vpaw1F/EtWKCoWRH3Ehj/SO8?=
 =?us-ascii?Q?Z7ed/RgIWYPU6JE7lc6Z1qXCzF5GI7gKz2CTGlxZhMz/txSAdZU203RqtBTU?=
 =?us-ascii?Q?+dD6i/Dnyng61grHBvZh8dWaI4n2FZgcggYZUGekfTIpsKQTnW0YPkAVIYGQ?=
 =?us-ascii?Q?pKg4ScILPcaU8gfBXmMyIVpAPmjlNSGW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:33.3070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412209b3-3db8-45b7-1e56-08dcc1e08b59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071

Unmask the upper DSCP bits when calling ipmr_fib_lookup() so that in the
future it could perform the FIB lookup according to the full DSCP value.

Note that ipmr_fib_lookup() performs a FIB rule lookup (returning the
relevant routing table) and that IPv4 multicast FIB rules do not support
matching on TOS / DSCP. However, it is still worth unmasking the upper
DSCP bits in case support for DSCP matching is ever added.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ipmr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6c750bd13dd8..d5295b69bc0a 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -62,6 +62,7 @@
 #include <net/fib_rules.h>
 #include <linux/netconf.h>
 #include <net/rtnh.h>
+#include <net/inet_dscp.h>
 
 #include <linux/nospec.h>
 
@@ -2080,7 +2081,7 @@ static struct mr_table *ipmr_rt_fib_lookup(struct net *net, struct sk_buff *skb)
 	struct flowi4 fl4 = {
 		.daddr = iph->daddr,
 		.saddr = iph->saddr,
-		.flowi4_tos = RT_TOS(iph->tos),
+		.flowi4_tos = iph->tos & INET_DSCP_MASK,
 		.flowi4_oif = (rt_is_output_route(rt) ?
 			       skb->dev->ifindex : 0),
 		.flowi4_iif = (rt_is_output_route(rt) ?
-- 
2.46.0


