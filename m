Return-Path: <bpf+bounces-37715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ABF959CA0
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F01F22B13
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2CB199FAF;
	Wed, 21 Aug 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LPC/QFJE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C9196C86;
	Wed, 21 Aug 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244967; cv=fail; b=jp4hQuyNP82JaTOWoVf3zfxEJvKmauPZOHvZnOEziDgma/7PyBDcY9ix6j5m9CDWz8XOuZsdz6skRxoWpGWjFKxgnRT4kBmQ460R7Fb948iVRMndmDd2nRIY0FuDEqY1REKFfDHskNw3t+N0SxZGBYns78+IlQV9F2bmYExRvw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244967; c=relaxed/simple;
	bh=OaCIPvdfGbSfPL7cuj4kEaXsJcxZk4jrdEt+Ny/6l74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qt1fZ8xUzQPl1vySxj5zBad1XJvricQr4Dj4hNqXfvscvNlMQEveu5AF4OXLsHC2uBphaPcQoIls2WL+ZWUpjtDnUtk2cX6HRJ46/Zzb8+KDxTV/7CqdAu0Ze8njfjnRXS4mD2rNzr4PsZ5X26IW2/64Fx5pNgv++mpI9M1X9zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LPC/QFJE; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFEnW135qKh/6ErNet0owxq69veSLvzHCHTq3WNLapxdgBZNUMAkkyHGlren1OiUKYS6g6+KESX2IGkxggvy7gV7fODPtScH7AAAHcL0UC2hb/H7xOf28HtawA/D4TZhcuh8XrYuLBWrAK6yc2fpFKy7EI0Hustq+zcfQGpJBrkOybvEBCEU3CQ0unDMF5/1YXVsztPUJ4gICLDSmXQ2Yv2qHXaENt06CRY+6jmOsse/SC9iYtuzu0fksF6v2NVrUaTQjwLsjo8idGkyPnrXfMO+e0/7LFjQZ2aDy0UOnBxaefWyhSu9b3YFM8/n2n/ZJ2rNMWhPw91yd8vLSlVOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQGhjVTGOjUmV6hAdHsV+LhebKoICUXQVOD7UoLmzeM=;
 b=dTH+qQxN4SG0dGNy7Xx6UmYuuAUwUWml7QbSL4uGjJixupUVl1uolMa3roE85b+JOwYmIKrdIoyvUg/M8WzMnIdGuYF9MqOvSbF3+8TExyt9tOIOX4GOw9wIlASM9aFmi9zJjFHD2lSOqxtRriiGeAEEscp4l8h3zMykDzV1iK2YQjqaadoBpSGLhE2PbwCUiDIvB5bHcjUMpfw2fuEg3ScZr2sjODmk8m62FG9fii7vYR5ko0ZFHw+PIJ8KRb74K8Qy7cGLgEo4JMQ+j8gSemJ8N6julNvDkrKxKQv6JQ3nxcQbff1KjuST8oP6MumxRxPLctQM4lJGQqb7ncLJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQGhjVTGOjUmV6hAdHsV+LhebKoICUXQVOD7UoLmzeM=;
 b=LPC/QFJET5op+1kX/RpOf4SerYbC3ebIzq8UiTNDL0ejGPcqqCbteIsVrNnpGCaoa7Hezkw9Ux6FugMTSsZU/EZ7KhV4Z/5EUw/I8cbwptGhnOuUpq7EFDAOTv+Idem/6dY70T6NEtO3nqM4brzGqsn7Oyc3dLTOF01TH3VQC+lVxkRxfGdUBtCj1EATljof892rsz2pWcPBNwqJMlHsbO09mzLKMSmPxwwtIeOm0hRLYXeJKg791MOvHlXjVetjZfcdDNsuiqvhLZ1/lqisx0hp46jZ7sECCS+GQzX5zKQOHYqG2uA61ZhErJdQoE1dSlEnayDV96DmABUEMokItg==
Received: from SA0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:130::31)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 12:56:01 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::aa) by SA0PR13CA0026.outlook.office365.com
 (2603:10b6:806:130::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Wed, 21 Aug 2024 12:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:56:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:41 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 12/12] ipv4: Unmask upper DSCP bits when using hints
Date: Wed, 21 Aug 2024 15:52:51 +0300
Message-ID: <20240821125251.1571445-13-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: a68853a6-98c3-46e2-ce20-08dcc1e09bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JT9ULoowq3f/F48FAi1WeGrdU7WtNR/Rf5+4q3prVMKq0cp/nSD3QGlUMbfg?=
 =?us-ascii?Q?1/8N7e4gQI+RbtNKnxaM7Lp9I+OPKSYfpLYRxBpFt5eqy4t8+1LggmAjss0q?=
 =?us-ascii?Q?Ybe7Sevt3QIInp1OuWw2RAi/U0QlWF1M9tbiidmzdVazvBFo+6z5ZVIMLeNn?=
 =?us-ascii?Q?rnUZxz1lleOqD/9iDdKQshVDymjdvUwFrn3RVMZT+LVygfb+xXDMwWpcOp9v?=
 =?us-ascii?Q?ymazcQVciZcU6+JT0sOwCSj1EvQtXyZt3EAgm3qKRcJKe37HeXFy4XEAaf6Q?=
 =?us-ascii?Q?No1LulL9M3qzTolkMwqgJz98wigmgbu2+b90WnbqAoYxMsZKXnddMeW9LoZg?=
 =?us-ascii?Q?b3QoCTnW4Es9ypa8+mzkEZkM3lKsovdH9/548cm9BfTs9H0eHkCdkTl97qIW?=
 =?us-ascii?Q?U+cE1R6m7ixk0zSQtdwKwoBub95MySNPMO4uCz6hO0kU8fpduioyIkFeKNJY?=
 =?us-ascii?Q?tOXaY0Uw/skinZV2PkpJXmkZP/j4hLhgKbwXrVJP8vjsgNCK31y6v5no2XzH?=
 =?us-ascii?Q?raTsm1frcRGOUEI/cRqBeij6simy8pMI0d5gs+rdHVF1Vr45GF6q+6xe+m0s?=
 =?us-ascii?Q?D5PJw+eS4gQxtAJg8WGGAINpS2G1ijmzCXGax60oDo5rZW1n1UIN5FHz5iGH?=
 =?us-ascii?Q?nFp2Qje8pdLDIiudxb3w0vtB7WX6MOmAcNZmmvTVonN1l6latvwpB+SG4LgP?=
 =?us-ascii?Q?iWFIeM7OeUY5jrgNNFTerRoh3TKgMgfpTMdLR5fDDpZwoF3xYfuL9cnWMmgb?=
 =?us-ascii?Q?00S/kHrMop+aYqOgQ1Hn+YSJCzLWV/5HbiFwYU6OX+A2WTgNid9EnQ9OwPKR?=
 =?us-ascii?Q?hX5e4RAnLyXeq/i332eWB89BCufP3RKS8RIe5F2otSpWaWuZWWkApy/iB7E2?=
 =?us-ascii?Q?DNeqygaMhqcMgo4lNSopOTF4TrIzmfkkFBIRixno0QmswUEPtGEK16Ygbsk6?=
 =?us-ascii?Q?kMlafZMx9HgwTR6CtkUcE0fjKKaqZzfHYrjzckTIFh3vz+H4ul691k35GVCh?=
 =?us-ascii?Q?BhMxSjHY9tJSrsF5c/bKkoIDCBvmvkoPKrOVNQhk5gkrejMjDJhRArtm2Wvg?=
 =?us-ascii?Q?CpHd+DaVxka0iwX1K0fIvLsLnBL+UlzLnXKxXtm/TZVAqobkHym8l/WxjnL6?=
 =?us-ascii?Q?+jY6PwM7a1ZurIYAs46xyMP7sAzmDOX90RChvkuNS3FM1ut8Re2KGpufpgQ+?=
 =?us-ascii?Q?Xdb65ZKF7AfS2WHPLUKv9MPA2njHsE+tG8cn8v79VqDsu8gtm6hqOmGCcswJ?=
 =?us-ascii?Q?p6uXnYw984Y3IR9ASWKJGzX8Jg9gY+nuQw/WJlPH3kYoOUV2aziKxN1e384d?=
 =?us-ascii?Q?QAXON1nY8HEgxGeyNSE4RErveoDq2rRrzC7k11TRbZZuELOGirYdA5oswbsr?=
 =?us-ascii?Q?j9b/0/FtkVn4ESv5hKliTkLs5GOS74hwbjNFUmjFX0bZwwFt1RFAYJyO5t4y?=
 =?us-ascii?Q?vT9jXs6/K2iyfp5N2O23Tk4TcOKd7tpR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:56:00.7554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a68853a6-98c3-46e2-ce20-08dcc1e09bb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034

Unmask the upper DSCP bits when performing source validation and routing
a packet using the same route from a previously processed packet (hint).
In the future, this will allow us to perform the FIB lookup that is
performed as part of source validation according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 524b70ab77a0..f6972b24664a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2160,7 +2160,7 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
 
-	tos &= IPTOS_RT_MASK;
+	tos &= INET_DSCP_MASK;
 	err = fib_validate_source(skb, saddr, daddr, tos, 0, dev, in_dev, &tag);
 	if (err < 0)
 		goto martian_source;
-- 
2.46.0


