Return-Path: <bpf+bounces-38151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD596086C
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81701C2287D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E627A1A08BA;
	Tue, 27 Aug 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eo8NvpkM"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9711A0732;
	Tue, 27 Aug 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757606; cv=fail; b=MxTgQbwjCYb3j0X0ZRmNam5Kr793VuSZX89j6+vux84a8tAAbOt5/X6Trg8BqJd5gItH3IG5QheI6T4vDf9mTBerkxcbSVV4D6BhVNXzQPvXf5dFCLvBgoInQtFc1gooVOKgzZ10Yftf8VeZnACyhVsVglVjPkFGEkgKICkZxF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757606; c=relaxed/simple;
	bh=5KTqU4JntSTsJdIhbrp6bHPxu/XXGn+lkQXKhaVfxFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUsfsYts9AJAHEBn3/99rfbD57QHk06ylGiPyzDFnhs9jtVZeg/rqNH+aSansnvs4rmDoAHre4XjBopFb2T3vAMKdfvrn0ZjXFBoamFyavM9EEWrh4IfgRZLfl/aKqnid0Oruaj0l+56Lw7NUL3Au+8odSRoE7DaNPKeeQBng7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eo8NvpkM; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJKydwOpIT1uLJmGrKOXHq7wFckHX/q9y4QOQ6JDK+9lVlZUTPDOn/ApRmdnhsurRpkUYW+2l22aAl6i/DCWoEKSu/RSUMVSq7D/16oU0W49j1oVwTTGjAxu1LZssx5Lm1IUHTy6qwsTmo3x5QPSrLX4Vaix9k0QEkmZ0EjWltXuBSoHjsPWi63iusHQiFTV/+T7rvMqhN73MKU7TB8Exuxr1BKCQBmAzzkg/JJB/98ph3dPNiGHdhTWfxiHeVN9Ly4Uwm3h1NCCfZcBIJXhy8yZNALxjwpeSYTnItjHuULkTPf2etl4EU7Dl7/6kssOjI2q/IitYoHdXGnu26Kmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alonQpJ9HT9EaR2IMd1Oh85w1Z/2Rn+SvwQrGdHkO64=;
 b=ZvdYuX8801pei7XR0Ul509SVPcH21sMtclfrH/agqdW/YCZ/41rFW8UB+7S++rAp1wL+hNLNFbY0WT+DkFbhp16JM3RGUZ7ycfe3oZx7Iok5INAUoh1fARlKJRdtsxSYvtd1fAXYjvipglJ3q2bEsh3ibe1sq1Z+L4AddLm5q4bPxaf0QMEnOgVWhFOanzKAxqHJNTqhWJYUxqVfJFd2ecSVez1lt11d93YOygHhOqgKB/OdMpkEAAAVcre9EgDWzhW7J84beBf1r7271mgD9Q2Ma+4uJDa6JNo5Y2Tou4ExPVMlMtRTRP2fLvZq2sd5buAwR8J99i5yxGVDm7AO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alonQpJ9HT9EaR2IMd1Oh85w1Z/2Rn+SvwQrGdHkO64=;
 b=eo8NvpkMfzCJPIjOLDpzUY8AnZwzqPRfj4/Ri5o9iIRYre0KlTPfpEbanjQJYLVdMEZ775zuQn87nh7/0sABp6eRouGcCVE30yQlWqViowL25hxEh5N1+5HsSiVGHcpMygNDqqFo/5/inrpsEVD+R2rVUf6eYJYkqoxojg193SZbwiFfkaySio6Rv5xF35nQrUuGyqHRxOEcrODmeDvIc9RL4847/M266dQvoSH2B1hSZlO6gb27+f54A1tYpKXEWexgKA5VxcWh1Q/EJ0M0wdRyLnJ5IlDxYiO2IWb4VHde37pTXhyvRsLwlV4ErwYvwybcfZRRlqysXmg5VBRrOA==
Received: from BN9PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:fb::9)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 11:20:02 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::ec) by BN9PR03CA0034.outlook.office365.com
 (2603:10b6:408:fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 11:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:20:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:48 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:43 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 12/12] bpf: Unmask upper DSCP bits in __bpf_redirect_neigh_v4()
Date: Tue, 27 Aug 2024 14:18:13 +0300
Message-ID: <20240827111813.2115285-13-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b26bcf-e648-4175-6c43-08dcc68a3199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4pStYhWBL7Oul3qv0u6gJ5aFhoZWokKgUByc/n+rbyYUkmlWXOvKXJFQwhWW?=
 =?us-ascii?Q?l/8PRGNDNGswvH8CizApma1dS33gCZIqWDQ47GZQhFVmljgePniFpXAAoQo8?=
 =?us-ascii?Q?qfd6a5fmPijRerxigKlkUV0gu3oS3zJc594HKp27TnwIyDhqmqE5QAz0aZtZ?=
 =?us-ascii?Q?kEGYFX+wDf5wfFZKhTp23T2sBKVPpXeCfJ8mqICehl83WCkSvvDpbSMkQasB?=
 =?us-ascii?Q?kB8MF3LfaLSTyHGodUNIf0oI0Efj3gNxAQMDmQellY87NMXE93D4R0xOtBQH?=
 =?us-ascii?Q?lUOyUYLEvH9oWVoID8El69qQHl6r5p79ZhM4ZWDm72kkR+PYOx6hhMaD7o5w?=
 =?us-ascii?Q?KVjklHFtM92a+4iSVdK18A+j4u+/iOCXmqDYxnNkWfs79cLgmuFYE0BTO3eW?=
 =?us-ascii?Q?R2dKchWwniUO4GqPabRbelOu9tu3T7RHvDMJRp4uGvGf6crqhmzcXkm2p6s2?=
 =?us-ascii?Q?1Nb5vsIie+kPDRy77mjKNQBGgzqArMGw+i9LFl8fNQWBENk4TGtZZa0CVTSS?=
 =?us-ascii?Q?YvIlxVygeMvteXZJ8zFt+VNvWH5pWeiEs5KovDzaED6nOOfnYAEDuUM86SXB?=
 =?us-ascii?Q?uIEYlOomgIUK2JxQGsw+B80asOG42vVi1FJBaNa54Wwo+S64QVzJCMeKPatg?=
 =?us-ascii?Q?LKFwVr0S8ty4fvDPnHHYVUoqmA6j9dGnot1IODpA/aZN9v1xZKCKn15vyeku?=
 =?us-ascii?Q?bXKkJincGHERN/ih+fiNOvybO5ujX4YLjDKiXLnj1AmyDGjmunNT3pEKyH/p?=
 =?us-ascii?Q?8g64kVJsfRtn+4HfFcVpMhdIQ3W8LWjvnCAQ65rnZEqzV1FYI+JDB4T1dFoN?=
 =?us-ascii?Q?dd0XaExyeCEc+4uc/Y1vsfynhHwLJum9ChLZM+yU2LXNE8XydcayDwNGs23W?=
 =?us-ascii?Q?jj9yaCo83R5rIgLtJzDkCMECxP3WbelA2Ijj3NXebHXOfl0X+YpZ7k3y/EhE?=
 =?us-ascii?Q?w5FBFsXDrnzYi37MLEppXN9DVJtWSw/VB0Y59vzk/el+KqRhdFmjtINY7xBy?=
 =?us-ascii?Q?UOXM84RbVJdzsbmtcQSfj0xpw/ySGaXx+1MlHi9jNmvZo09c7Hcy9fKik02a?=
 =?us-ascii?Q?w12u9RoTtff7MPzAagzwS/hhC/RFjEL5bWEaSjhZ49Q++qC3dcA8MbsoMAgS?=
 =?us-ascii?Q?SD9bE95MvZd5VIvTF1eAKWA80GlJ7zsqAShgOAlkp9v8YYF6oLgUo5gQmKja?=
 =?us-ascii?Q?5OD/QXb8q6qzPNohJxBLzqOJZW31qD1ySI9fWHLaFsn3lyaFNCFMCvm/bLBF?=
 =?us-ascii?Q?94neB4zsm6ml+R3F/vgYZW5Wf/dGBlUIixVoHw5u1ALgHmuGqXvkeGBWd9kk?=
 =?us-ascii?Q?NLxfvO0TXct2aUnxZ9XJYK32SaxBe9B+hw0D+mIbkl7PyQ0bPawFDUiiqhxc?=
 =?us-ascii?Q?axiwu/8aJ3Fj4rCJv2ux6k/DleFIEm5SYWJiIklFoQg+XTL1QyIrfxHrpZem?=
 =?us-ascii?Q?lom+8SoLOd30Q5p1WmrTeKG5ln8uQMEn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:20:01.7505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b26bcf-e648-4175-6c43-08dcc68a3199
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

Unmask the upper DSCP bits when calling ip_route_output_flow() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f09d875cc053..8569cd2482ee 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2372,7 +2372,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 		struct flowi4 fl4 = {
 			.flowi4_flags = FLOWI_FLAG_ANYSRC,
 			.flowi4_mark  = skb->mark,
-			.flowi4_tos   = RT_TOS(ip4h->tos),
+			.flowi4_tos   = ip4h->tos & INET_DSCP_MASK,
 			.flowi4_oif   = dev->ifindex,
 			.flowi4_proto = ip4h->protocol,
 			.daddr	      = ip4h->daddr,
-- 
2.46.0


