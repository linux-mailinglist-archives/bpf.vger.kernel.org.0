Return-Path: <bpf+bounces-38371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F7E963C0F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D21B21C6F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D217277F;
	Thu, 29 Aug 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jDSN275R"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC041537CB;
	Thu, 29 Aug 2024 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914633; cv=fail; b=Kk0fg803SGYfXBZwTKqf41bFWJgP1hS4JLt2A/i7WHQQU+u7gr6XoMgNiwvRTS/wmxaWaMZ1mnKSyPwiKCpXIM+9IF6M8ZGVibIYyNhEJxCVVoFteMa8sW6im/A/B+HVQEDRVGQGQV130x8z95VKjyslHM8Ja0Z+h8U/T5TSCkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914633; c=relaxed/simple;
	bh=9JJ6dT6Xthhxqv9n77twnzAhS6+5IEi7Nx6Vz+YqWa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGp7h8zsfNUqSyskXWRHPNn8HyqvrtQ7E2tFS9PFcv1OugfCmqiEOlaPjB8y/CT/jcUQc08p1cfwvR25vGBEfnY/7VSfBqsnRJkQj7qfw4urRkOwexLKWYGuwGG7eFCDC+Hyzef2NBEvO+n59Xq+mKnGdEDeZ/AKeHXLUwxr6hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jDSN275R; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGnHK7zJ9WVJMbjfkHeGbxYu+DC+ntq7ppIwt3zMcdU0b+vD0mFmLepDwydAueep6/Zl9330+vD5GjklnMnE7Vz910i2N+bD+3TtcSQjHS+vdJgVbffgxRnNMLVP8aZCh6vglRsA8CfTIPMedqPUGx+w7jUlvPxPIAfOJXfl15bifw4YgJFxdEwc4djkRZDlbJolu0RSf5YD71S/Kj/h1tRFa9V/hzWYYcjqrPjTtAFMfNSyuLTULAAkymgilUPZYbV8hwCF1x+9KOYrxrIkci6Gj5hH/rvEa7wfr0EK7I8okwkEDOgBRYu49K0ZUxHR6XzkXQpabn5dfx0ujF0HfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOJx0YidO/5xD0gOMtPOoY0QtRMySJjKLD+Rh8m6Bgo=;
 b=TLy4nfI7z6XMWs0z3A/0b1JWk1aKp9csNFp9SG7XNk9awh1ZBw6kpwhiGNwhxyJZtRfQ4cNK0yoJh4m1EcEOzGUHJLv0ZdYGMnaqWC3weUwUpIyOdcHQF/nIuWpIPGj8jeZt/ZsEM04OJze4i246ym6nAOe+/giK7Cr+H+SVjbVXDVT0LfO2YYOqrA7GgaiUVQcMf4k1wYh/MDrQ2/pEtIO8z7gAr2SdWUTsBEQqxnNOhC+acaNlTsT1X/xuaAeHh8l2ic3C1rd1KihjsQtkn42Q8RfzXnDS5qRxXF99qHf7teXrVr4/5IXLMoJrrtbe8zZBbFK3Z8/UQmYQF8VXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOJx0YidO/5xD0gOMtPOoY0QtRMySJjKLD+Rh8m6Bgo=;
 b=jDSN275RbGjPl7nni0l7XU+IBw/lmPg7YXODUpZfxd4VBZQ82Y2B0rEw36gc7tZKnbpux3CTPmSwKfsnIox0M/D6wqBKcxhxQY/j3AC+Bv4iQ08OiD02ObrM5zwSDDGhS5jxIq4+//lQ1usTThaBsGs9QcSVkVpIjIIJ0qn+35H0RxJjyIp7VfuE8QE591S4Htze0gqfpnYtJXdoOVfzehciF7vW5g5dYK0QVf1FX6Za0kVUob7yxJjFvwPrHqKZMECAD7vPvG+ANLwiAqzjQV8dl+KKrH3D6Mz6nm4+JnGFPPYLXhe+bWYesRsxvumiM9W8RCJH1FiKLcjenXC/mg==
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 06:57:03 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::a5) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:47 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:42 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 03/12] ipv4: icmp: Unmask upper DSCP bits in icmp_route_lookup()
Date: Thu, 29 Aug 2024 09:54:50 +0300
Message-ID: <20240829065459.2273106-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d645673-7315-47ab-e66f-08dcc7f7c984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?omM/QV2zWNkGQcrGaenZzCHp/uLXjuLSnpYAbHhMl3f8GrWJBPmildd7jyQc?=
 =?us-ascii?Q?g9ZDpyMcVVz7Fbf33EfF40pXE8L7snr7eSg8u0BX2tFJTdyYsfnJ746jp3CO?=
 =?us-ascii?Q?+QTzXSAMR1jpjQmCtnVSdhEnVGe7/V3d3QKpzRwvvucld9iDBJxIIrCAHTAu?=
 =?us-ascii?Q?kR+BgC802pMUbFTuHYlTgP/Wjfcnyh1chAZ2EA2sNkqz1Z3Vu/B/+wc6+nno?=
 =?us-ascii?Q?ngyB6HlNiBSq2ioOiBlh/bMlt3Lri1x9zTSnE9mGhPCgNzu2UMCn/8f4ibu1?=
 =?us-ascii?Q?cVpqaW5SoNJPNM3KyW4dxalcLXw3DrA6n39igDul6j6lfnH+Db+Nnjpn1Y9Y?=
 =?us-ascii?Q?Wh8Gf0p8IUcvb+GpcANWLuBsLFQLM8MFPaPbsk6/1FejrwBvTKSpUU7qvy3e?=
 =?us-ascii?Q?nIh23742MTeZTs45NvuG1q9ehvvJuTUgoE8aBRdHF1jQkqrRr4uhxf30egks?=
 =?us-ascii?Q?ujhqTF9HKFUvjjzVuLF1qPlgD84Dve+IBoH0ax9D2Gs+lUEqWiLbJxmJuTdA?=
 =?us-ascii?Q?0YoMP4CSB0qwxUMIFiNrvCZI6zOMCvVEZ+t75z1ury8JokjlAqwHnZ1kCUkR?=
 =?us-ascii?Q?qvXyiPl/ye9xguJz1Y5fA2g2TCxlDVKlQCfxzfkNCe1s7pjXDN8ne2DQSdQw?=
 =?us-ascii?Q?p7GSQPVEPlwYySU3+Z6x4ZhnAgF9pB/RAKThmxu1HFD59AEKr9cGDMaGUvHk?=
 =?us-ascii?Q?yQ2b3Hmu1Az4DZu91bj+4e+T5dViZs122uSU4bUlcVELm0axdA0P4n0t3a5x?=
 =?us-ascii?Q?TGWtiitkGTsf1WuvbPFrmxhmSpPrrv4RQPTNmkCHuVYvIx+KYW9fMeiILn85?=
 =?us-ascii?Q?iGih+s32YcT7wItQRIWaNZ72fgWi+55cI5SMLFjeEqKnrec2ebNsGf7zl30K?=
 =?us-ascii?Q?KqXnZYuWsMHmZDJ+eiCf99RNWmK1aypFLgbfKAWmLEqe3/1ECJ3RVh3a/n+S?=
 =?us-ascii?Q?wK107MF0Si+/uhb/WDqRcO1O4kdomQBqa3VBp/0Qmk9DjlV7yLaoVQssm4Ve?=
 =?us-ascii?Q?eV1NXjemLEC9vzWqj+tCR3Rb+i+lo3NinpEkf01cOkr+MDAmGCkgK0ccqz0Y?=
 =?us-ascii?Q?UId8ZNq5coyk/E9/NFwsB2R3cvLBqyNLOF54/aUs/zWiR2DvtAUp0ddTQ6yP?=
 =?us-ascii?Q?X+d2D0zayXFcMui+yaXL8K05a9KV4NKqNLmxDP4v6mdl478ZrMjbpL4jOmh7?=
 =?us-ascii?Q?iK7Dwc9ybBtuspAr6LYOk0OwWRL5aylQysZWYkYLJY69Uo5h+F7TSploaNuP?=
 =?us-ascii?Q?CfYdEOU4i1o04eBDlOqZUGjQYpK0Mfzs5otSAFkQYD5rkvXCMZAqKC7HkhRb?=
 =?us-ascii?Q?BU6qqgZC2xawCFuvYKpCbNdCVZa13WGEqzbDyqeOIV43jyKNbygErbjISZYx?=
 =?us-ascii?Q?akidaYO6sHuk7Jm/SSfkiEBgFJ5NQogKr17xuCMQKn8EfHHb+EWvsXvkoHIh?=
 =?us-ascii?Q?EOcM4npUYDbyz+gqCUDoF+IDILKDr2BS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:03.0453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d645673-7315-47ab-e66f-08dcc7f7c984
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

The function is called to resolve a route for an ICMP message that is
sent in response to a situation. Based on the type of the generated ICMP
message, the function is either passed the DS field of the packet that
generated the ICMP message or a DS field that is derived from it.

Unmask the upper DSCP bits before resolving and output route via
ip_route_output_key_hash() so that in the future the lookup could be
performed according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/icmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index b8f56d03fcbb..441057f2c903 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -93,6 +93,7 @@
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
 #include <net/addrconf.h>
+#include <net/inet_dscp.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/icmp.h>
 
@@ -496,7 +497,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	fl4->saddr = saddr;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_uid = sock_net_uid(net, NULL);
-	fl4->flowi4_tos = RT_TOS(tos);
+	fl4->flowi4_tos = tos & INET_DSCP_MASK;
 	fl4->flowi4_proto = IPPROTO_ICMP;
 	fl4->fl4_icmp_type = type;
 	fl4->fl4_icmp_code = code;
-- 
2.46.0


