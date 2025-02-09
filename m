Return-Path: <bpf+bounces-50898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA9AA2DC51
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B37C162C38
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443891CEAC2;
	Sun,  9 Feb 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dTlmyaym"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E91991CD;
	Sun,  9 Feb 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096420; cv=fail; b=dU6x38bh8By9cviJNVJ/7Q9QAK54xVJtmKUfT3q2YYL9KhslxH6RJkE2UXUxhUdLlfGckgpeWQBq7glztL2zixx6uPyAOBlKx033z0isRqgUfgnDrtv71kQicqarxBEUBiRmfFDJBMEsE+ZgpJiRiQOVwubNG80MiYsPoG0OtUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096420; c=relaxed/simple;
	bh=crmBcZNjO/U0ic52M5f4OkDKN1chMTsXSyAuybUGJ3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4mPM+FlqEvh5n/IXafbEA9dXdzxFKO7PwmULxMh0pjp4iZGIJNsDc1GzxM7HSLd/49DF/d2O8H50M4fvCQHWeuH0zDRNX8cY9KpwsV83e1tf5TyLZ0uAreyHbPtGffQaQCLywSoN2lF93CCFspHJ9EsWN8Jqt1nvVgvd6bUv28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dTlmyaym; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMiW9CTltnrc28J1XLyLNadff22i4rjEClDA+jtS65j4YoMeP5gXrSM11RX+Gp3XnQ0MjpuMSoPRceDpMoSISKUSexCNuwGMKgKQyEFvjrLzO34/am6M6z4+FCg20zFoLYxN5FpYLMk2hmYBvsCOH4bJnq2Sff/OVSTyM17rO87Sd/RHtQqPEH1m6PHuG6S5tyaf7ubb5BGE6W7y0DwwbJYCk1hlEfHaiCm17dVwTd0A4VEeJdgiMveOjEXc4Odt4louP5nqgong25UA+WgMLFsthdGYDJuzRee/pmc04nn2h7kYO4Rzdiilpwwmm+6+2ZODTamEW027sMMrDgbI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/cG9Vx2V6eiCq31/r+Ssw1l3oTTLglzykKTkqoos8w=;
 b=KbjeNrXORyKrwCOyWgdsaBVoOH4167i95REDwNLvZeJFXUnpY/O+/fLXAvRwbN5haBMdHQoC/DU3owj8cvzJQm6vmKhHN63NmbLN4ozpI0whcjos6gjaD5jc4KwtAgVkhZVj5mmCl0oITGA/+zZkdCmPvNGyT3SdaN5CFy7bdTSxYPiZm0uGOOAUayPLbxRS5bAvlfc4k3Pd3GXOnBLiVhGyUsFTebIvApNpBa5cnQB8148Cm1/5g3av7ogK1XIuVQL4+TR51tshMtmG68nLpp8Q0BS9Oj3iHy03gKcLuRAhSp4n7cgrQYVkYciEALGNwfiGRjfQe/2e4U0rE38EOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/cG9Vx2V6eiCq31/r+Ssw1l3oTTLglzykKTkqoos8w=;
 b=dTlmyaymOacg6WO4A/PJxMbdb3h/QyxHNmKI/WNmaMLmXlZAInSK8zb5JOifyrUDi2sZZTB7q0nIs9OSMomgzJOwV4ds2ka0G4GLbWneY0IQpKbjSXRf2qDOwu0ItCSLtE0O4MfiZxaCb7c7AKfLaPA8drfSMjZRD4GwVSBCCqhKRAI2YQQCP2aQ5xjC5kwt8tEkpSWLLBkQ3V5UqAhZkJtWk1w6waSoVuit0zLEBlQ9muqhJ5QQpeaB3YcqVfQBYXnXsC4CEvNSUJXO0NRfku2qJSIxjRHPeJCK0e328yz3K3imF75tTk0wgBVo0og9bPLsmbt2ePWdfes7bQ9OWw==
Received: from SJ0PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:33f::25)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sun, 9 Feb
 2025 10:20:14 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::eb) by SJ0PR05CA0050.outlook.office365.com
 (2603:10b6:a03:33f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Sun, 9
 Feb 2025 10:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:20:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:20:07 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:20:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:20:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Richard Cochran" <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, Alexei Lazar <alazar@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 14/15] net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
Date: Sun, 9 Feb 2025 12:17:15 +0200
Message-ID: <20250209101716.112774-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250209101716.112774-1-tariqt@nvidia.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: bc05cd9c-672e-4038-a5e0-08dd48f357bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qMnPYYyKGBujYZr/9aWf3jy4xSYaEFaUun1PQBL1HlPOyzxdXjCPDVyFNunO?=
 =?us-ascii?Q?xGeci+yKiJQu7PKLxDu4ESx5mXHfi78NcIMzgMHB+8RAA1Se9yjS7mFn0o+b?=
 =?us-ascii?Q?e8df5QWqww2R3Jj0Q2wVg3Z92t25ikN5rCrVE6QVm6Wtp2rhDZRMGm3M5EK+?=
 =?us-ascii?Q?K9mRt2Pr8ZtxsXZh4deDX4eyc34Lb60gPHRomHAYq9c5Z/QnIme61IpGOGkA?=
 =?us-ascii?Q?snuS5UAO6I8wfKf29rOFwpS6kXM7hJYAxOphxryShaZbPGWnzy3jjnkgRMiN?=
 =?us-ascii?Q?okWwPh1tTsTthZW7oE/xqX29Z4ykht3NQM9yekw26DneSD1DPNxd5/0HTk7X?=
 =?us-ascii?Q?y0bj8G94XwvrwUhO1Vyn084rJqYAnssc6BVAiD5BxOA+ht60jvdlbTyoGaSw?=
 =?us-ascii?Q?c+IZGFP3EDV6eX/evp6ZR3SPCBQGJrOK7XOZc4ARk9fK5vSZcZZyMuQb3xiE?=
 =?us-ascii?Q?5ROtEks8MgHgIEXJqnIIhJVI3CHMEAtamoujUfedYTeFNSaXKhDYYnQg/D3Z?=
 =?us-ascii?Q?jtxBfQrOvP/0As0mBbgyLwuIRWZiUNXbYZdC0J4w6d9qmPi73Tpj0CuutdYP?=
 =?us-ascii?Q?cInldVJdYc7FYFCChWq2hroJk+YQWfQmxCQ5CfNLJOcGnUiVbG7DkLVkaHsf?=
 =?us-ascii?Q?bZCvyDYNxX/QseMUy2j/cBjUmhf4LMw3vFpL1scexDLgxjL0YSFMFYVUZfgz?=
 =?us-ascii?Q?s+p4o3QT1YZg6MjiqsA4GlwUraFhAn+q9bBgOZKEnNped7KlwQRPT0eUUv13?=
 =?us-ascii?Q?zOGcKEwk6C1IbSCYMaMWzUZkdDZYy4cK0/+Nf9NHNND6VrCPYscXwl2gDV2I?=
 =?us-ascii?Q?4B4SpKjJECDZqfUHfqKWvO4LUgEhgLN6barHNODYEGWAMiPveQapWjdVNb0B?=
 =?us-ascii?Q?EEGVgroxpuHOj/g01xhPZ/XU2XQam9HHDkDuSQkfbfIOYTrsfjZeAlCTh66/?=
 =?us-ascii?Q?Y9qjDI3veimbh2D/ITjjkQZ/nm4BbSYTcylUEWFq9/qQekDPZt/MeSvqw3RA?=
 =?us-ascii?Q?qgHlq7Tv5TE8UAUw6XFmLGjXraz0nPUprZqb4IOiHbdt3mmO8wa9CPKZC3go?=
 =?us-ascii?Q?xseh//VeRAV+KaPpfemAid5JTa8K4xuaKtRI8e6hu9nhCSNL4bbyUXepIjlV?=
 =?us-ascii?Q?lOj7ohWvhSxQDKZB/Odh8/aWQsKz2KoAMNqQJ2wzoT5p8De4dPO3Z0uztwrm?=
 =?us-ascii?Q?stMHKIDneyMQn8SI4nsf7WkuYk/h0zexovUV18ahC9TlxkvkFrofeW+K2XcT?=
 =?us-ascii?Q?BgTdk7KxMyM2JatHGN5KOAlpzenwMuH91AjNoAI4aQiXtOaPxZWx5jRtM/YX?=
 =?us-ascii?Q?TqB9R8lk8EfqIrwWAstDmgrJpOvFIw+DNJlF+6DrJgLlzOLB+Vhzu+hu1AfJ?=
 =?us-ascii?Q?XQLN5DH4OPAxvCPnzCtI9elyFYEjShePMtq2ut56uNSv9SQChy/LsgnW8vDs?=
 =?us-ascii?Q?v2y0KVp/gCWu0Lifp3RudJLJ1NtQvZLJhBPECWFwbdjI9w/o/gZnk4DhcsRb?=
 =?us-ascii?Q?PFW8t6WfrHJSwyY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:20:14.1396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc05cd9c-672e-4038-a5e0-08dd48f357bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

From: Alexei Lazar <alazar@nvidia.com>

Current loopback test validation ignores non-linear SKB case in
the SKB access, which can lead to failures in scenarios such as
when HW GRO is enabled.
Linearize the SKB so both cases will be handled.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index 1d60465cc2ca..2f7a543feca6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -166,6 +166,9 @@ mlx5e_test_loopback_validate(struct sk_buff *skb,
 	struct udphdr *udph;
 	struct iphdr *iph;
 
+	if (skb_linearize(skb))
+		goto out;
+
 	/* We are only going to peek, no need to clone the SKB */
 	if (MLX5E_TEST_PKT_SIZE - ETH_HLEN > skb_headlen(skb))
 		goto out;
-- 
2.45.0


