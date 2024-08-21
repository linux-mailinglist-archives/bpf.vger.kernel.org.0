Return-Path: <bpf+bounces-37712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15290959C90
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C215028283E
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3871A2863;
	Wed, 21 Aug 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I344A/6C"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5CD192D9F;
	Wed, 21 Aug 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244947; cv=fail; b=GGWW6TncPzUJU74+fdj28nOMPcEY5z+Pm1PpdBrN9V71BUoFxm+7bUzvwMJ6zE5umHcwJvh4v+dUy4PwJroS3Yhi6HDUt/c8HS5pvUUgZ6gKpt4hEP8RRKBiJKgYHMCNd/qMuutfHC0WPCl7Dc/+u3tFcQZxKRW33yK1HkZbXMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244947; c=relaxed/simple;
	bh=LUHUn0mvZj76TcpiV8zMWiz2REV0sO2dCJL3jfm8BIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcFChm8i3+CmQ/DChMQTz0OPdVw/abugG6oBYQa98IOBduA1gElNk536L7IBboniLjBqLOJ0aNBy/bxsQ1bkZBAb48D2nWbFeZoFOKQbt0QxRIds/P/y3uV5MHK9ORAk5X6z1O/kmagLm7Lnd4daX9OWEVIecd0DVqgEc6LpKTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I344A/6C; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdYtxkoAJWW8xJN4PyScrMiPL3Otsp0V3z5eElJJ6WqGa0mUl34kAIxVyKFjR5QV4haNB1wBaJY7tDax+bJXSkbmwYZ5SbHZQ61fJpVc9yP77HAT8zBenW7ZX5Q8ysSkk2CxfvxNEtfcsBXBjMumBDJ6SPaY9FGGfS7FWGVgahR5p7y6Zo2j8F+0oR37X9obCZq39lxEJtCqKshrvoPLGYlsgwSSbuEJiNW6TWWCMAaSRgB3SZsfQFK7s46nGdVhA17LZVYra81CB4KPatEMH3tqFooUB89EQ0pJasOnPqdQxorEUIDM6X7lbXsS9YM7GamPO3pRIZwBcbOuMi+a0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfsxFmnYnhI1bxW4DZrU6kUwJaT1fP31nwBBFv5tni0=;
 b=OU0dxan4rOyOuyCmJ2wYqggEc3Se8XwsN3vxrkBr/aXJ7A+uBzF7Ls1uv/3Q/Z1/GJz5O3/SR3ykNS/vrpnHMNO1JlwFnuk1uBVW9OiITOxr/Y6UUPmIShh9GesZQd1ZLovszB9XdDBnBwrvCqVs4oh/NIBB2W0ORE7zO1Ly0+O7hFQaelvyo8BKgLpLeuS8h5vw5KXf+datAEk943P9Rn7+hBIvD0i9dM1g9XYHLEPJxz/ZUd5nzZzw21URqr0+NPQ/WAJ4bL/GS3twDlIECFIGvopDiNUv40o+LNioo4CHBe5iZhGpFxWCCp/ipsWpzFg9QknrKWpOFyJWQn7yQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfsxFmnYnhI1bxW4DZrU6kUwJaT1fP31nwBBFv5tni0=;
 b=I344A/6CVHmVQzeb1+g01Xi9IonPcJcwRaTgnKZB9iIQDF086peyJasZn4rumkW02IPROZCEiSVITajPwjd3x5Q473BZdDAWFzaqd7ggRwZJx0IGgjPJE5V2bMLSRwD2burReg580k7OA0dodWRfPoQEZ+dRS5pEGq/AD/5M23u9Mh0g+0cDl3k5VqzcI6lamqWVEdf4oyzBpoGFv1W8U0p17a5AbAkZ6FEK6vMMY78hQR1+Ie0Uft0kL/HshtRb2wLT1b13u3yqGdF3dGyRa82AJIF/1tqatejUHBFdkH6U3Y8nHh4CDthCHMpgQXqUloXTxSxsUm4eW+ClP/pdOw==
Received: from DS7PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:3b5::18)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 12:55:41 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::bb) by DS7PR03CA0043.outlook.office365.com
 (2603:10b6:5:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:30 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:25 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 10/12] ipv4: icmp: Pass full DS field to ip_route_input()
Date: Wed, 21 Aug 2024 15:52:49 +0300
Message-ID: <20240821125251.1571445-11-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 9adf0bb5-392d-46fd-0c37-08dcc1e09032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKsB2oKgg222Dmd6/CojTgvAe1ZcRomHU5Xpv1auQoy0YP+Ugvh3Lz5LOjBw?=
 =?us-ascii?Q?j79+Weexh/jwSRzMs3OZeoAsqvzx2b0IuLJbhtZduC5SlKNZRpul0sDOY4Xw?=
 =?us-ascii?Q?hXs84YF/qsSwP61gMJpzK1uI3HBi4nadccjjpzdPCGLwl7yMZGsGKsKyzd2K?=
 =?us-ascii?Q?KFfJMWvYZ7Mm5xKK6H+uW7WbzzQ3WG5VR94w5IP4xMRoXiuQC6VMly73SPLX?=
 =?us-ascii?Q?1VmdNokAo8y+yoVqIF0uKFkmTVuDUDOGyprXdCY4jl+2eiXhzSqg2QmjIAXj?=
 =?us-ascii?Q?LPbDxJGC34EaMqnEH7xbpQmGbry4FdqQUUZbMRKGR+5+GFc5+qBYpzppzglH?=
 =?us-ascii?Q?KEvVlgq16kWZsMBur2TLSeV1mduEQM1iTxkDxRFEsRPCzbHh99x1sTxv8cbi?=
 =?us-ascii?Q?7c0ZNAev0QOWFI7O4FJGuRMBNKoABBZXBlmwGN0AOi1M5fDxkV0kBFLUjcjJ?=
 =?us-ascii?Q?iMMbexlt8MGkyUNExkMgSmW4p5lMVBE7ddD9dkEL7R02czF+JLePynmbcNHM?=
 =?us-ascii?Q?jUoLAEls23vLoFEdAdy6gF+6TBOL5YYj7in62l9nW6pmHZ3pXC/SDSAUV08n?=
 =?us-ascii?Q?W9LNV6q6bymFVCIM+NQdmSk/XDmxN+Qk89Ojck9L4FXZ5ffBkM/ZfbaYTqeZ?=
 =?us-ascii?Q?FY/KaSw+u7QV/gHDM71QPXMOlh0UErmDIJ79WP+UTCt8+Ybj7zd/fomDHHE4?=
 =?us-ascii?Q?OKeqCstR8M82sIrqNU0tNisRlqe9Ksik6ES1QpQyt3Bg/iHiJLwXcNnBm8Cq?=
 =?us-ascii?Q?04rMt69e9gGAMfEzJNDr+4vqI6/e2LhdF7e2eyYcXouPtbxo9qjOV3NcqsQ5?=
 =?us-ascii?Q?yM1yTbxYtFbupxPdBP3mxMEpKccxOd6RPmxQpF6ic6Hqt+8ycOm/0XTH6c75?=
 =?us-ascii?Q?W6CmxrrL/8ZhwgOkC7MKjlogpks8GIcB0JNUTDuedSy29YwMwS814i9y64f3?=
 =?us-ascii?Q?uBwwlgUuIcFQjNOGhCShwd5PEs0dyuNTx/G+B9MIpe6PF1XbVKn8OkqhaEdM?=
 =?us-ascii?Q?zndLsr7ml2z/Yxe8fw1FcQDEwcVoBnBxiofKaC8tnuOR45MkOPb18n5qlvJS?=
 =?us-ascii?Q?0Mt2FC3ryZYYTcbxVXmHDeFuRwb0NRgrdxuB/ghCBhmNYGJyF9QNePVPZl4H?=
 =?us-ascii?Q?Fy5OpS9GBhUrTdyFK/bmVlsU9eE7coYH52qxg3btBCRxcc76ds0ZJMmGzYpU?=
 =?us-ascii?Q?MRYrEvm0RZoj4Gw+/IlR4NFttxRkZArKfptIyVkDY0wsXue4ZFhLvvnlUIqq?=
 =?us-ascii?Q?LIekGE7h9xofiEFiyuX9FiJ8w7Slp2/Sg61mhVFfXb6+lcBIQvUNi/NH0CKf?=
 =?us-ascii?Q?b/QXAp3E1LkQFjdIUJL4/AFZr1hb+MEuMsoGbP2+Ct5lQacGEe+fifCvCsuI?=
 =?us-ascii?Q?eNJBrJDOmT4SNpNcw1Cfw+V39SFG0zYOG/P6LLALqUujM5JHMT7HI+lEAaxf?=
 =?us-ascii?Q?016pB315+6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:41.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adf0bb5-392d-46fd-0c37-08dcc1e09032
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634

Align the ICMP code to other callers of ip_route_input() and pass the
full DS field. In the future this will allow us to perform a route
lookup according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/icmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index ab6d0d98dbc3..b8f56d03fcbb 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -545,7 +545,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 		orefdst = skb_in->_skb_refdst; /* save old refdst */
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     RT_TOS(tos), rt2->dst.dev);
+				     tos, rt2->dst.dev);
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
-- 
2.46.0


