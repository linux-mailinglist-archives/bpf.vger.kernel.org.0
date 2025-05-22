Return-Path: <bpf+bounces-58759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D62AC1601
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72271C000F6
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D56A2580F8;
	Thu, 22 May 2025 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ey+a/wjG"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CD25744A;
	Thu, 22 May 2025 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950161; cv=fail; b=IvGCaMSk5mZz8sfN3hzeQEZX/1NMD1Lhhb3hoO7ZJJGMS38uTlZ5CWqLlunIyqiwiuHIXp3dABa/O4fZ2/ewiyrEi5SIn71c7YZ4cY0kMaWfp9HcE7emKkt6+UOaJ9QVEJ2BkV3cE0PSsLv7gaMTRCHObchwYu4q/wtJO5v+kVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950161; c=relaxed/simple;
	bh=eeorNchPn5Q7iDgIdDIIIvG2C8GL8CTHNMeDxQK2amc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5KOFS15Yorzj5GziQJ0u/M1xWFthb5hk6buHrPfCH1Vu47e1OxAxJdeWr1AB5YVwosM30pqSP5O3B3UNYbUZLfYd75uAi+vTizDm/uMpxujC2qPfJq8gpvKMOJBjxDspg+evkv+JeJ2jWDIblXchyGSTuR+NsL4bqiBUafMa4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ey+a/wjG; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ta8kG4jYYD5+iCcil9JfSmhhq3Et5IcvhNpjugwcAYGReNOMFAc54/cqSkArlSS1ar9ihXKV2KJ3xugRJs24Ws3MHWkAm3Hd3q43DPnBw11IDtfrDRakFkK07TyXQ644+qvMCxax9biGnRRBvqc7w/AtDx2pwmpr5v38TCLt5qA9QJ1tfAX9r9DxMcTrRiBETmsNOyRFX2/hE33zt2RF1/382Nv9cRNrs8e7+NZn1VVeWMWIwGgQtBhXvOBjP8QpsDbx90bNehdxpX9LXf6S6DfoPkAid5neLAP0sMMcjevZNhvXYtoAbz41ydgM4fXjGHE/ehWP2a7/p0+3j6aH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGesV2KuBUPV7qJD0M9vvIiKIIdIqmTIxCgRU9ZHCYw=;
 b=L4r2MDWx+d3a4z21VZOszboKIkSQoC3kPu21jSyxqHbH9I7ix+upFrA6yMqAfmGW8n+NMqKcj6MO6JHnVWP927G5Mu7ARP7KWnYlkTmh1LeZqCpGI0YU4xEpKGPq/vuTndI1PbvW+InTaMaJ+raoE20VckPvMHNUtyC/oW2ei10zT+9wLsh3fhGUpvrUv/UkXd76KX4Z+S96h5y5DNoZJtNx5OivLavtyhrU4LC6GrVn8xl6wyBIEazSnXbnDJ3PSOKaPs+a+QRaAXjNpTRkDXPAGVjwMtsqtyd6QEBJeZ75Ukmqr/DCiyd5PdgMe3X9tZ0oMLLlMWK8EcMVSwmXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGesV2KuBUPV7qJD0M9vvIiKIIdIqmTIxCgRU9ZHCYw=;
 b=Ey+a/wjGUl+0JLm3HTA+UDIzN8XgTmp6qAPZb/KlYaviNLqCt7tHXB8UF2Xaxh7WZhGPIARbEVaLygxsTmCeWnqtHqAxZtVGkZ0tfgt/uySqN5nuudhBHDeZawYcGHolvjn2P2QDHW41YAxUpRbkE5q84EMVx+FmPz1ck71c2Jt/d233SbDBPWfDVD9Du2Egokv8/FaUUgshivAEI2X7k9O7gEZiKiiI4n8GeZmrkhyTfZL5u5fI+McgwJkPfbSc3X/cac004ypfwi5iGiNeWP2tIQ0zOwsgFx2qJy7wq3tWAcQYMb42gLNKz1MZfBAIXeR7Alf2vo+MRkdP9ZvI+w==
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.36; Thu, 22 May
 2025 21:42:35 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::d4) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.20 via Frontend Transport; Thu,
 22 May 2025 21:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:42:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:42:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 01/11] net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR
Date: Fri, 23 May 2025 00:41:16 +0300
Message-ID: <1747950086-1246773-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: e73bf655-bf87-49f5-608f-08dd997990c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ym52WiLZbfU4QYCzSu/rrOY/JAsw9RRFnkj4Q4MBLtTcLtIWrqByCaX2RZLw?=
 =?us-ascii?Q?HoUudy2Gki8vTKH6X2DunCr/rnSoH91Mg0bXXp6kaO0bgUeSp5i51SEGfQ3V?=
 =?us-ascii?Q?PiwGYIM0qfQUNv0jd8Uh9+wFOIxWU6LMzRalUzLrPdq9CrsMd0eC1A1QMT61?=
 =?us-ascii?Q?ntgM02vzVZnSDYu7JMMWKyXcm+6toUSWoOqjpSfwKx2Xn1a/1pAby4O78ye1?=
 =?us-ascii?Q?JkDudVOYkHbQVPDrdcX5VMkI8Qmy5+GPYLbgzIjRJWClohQ4x6Mk2RxfBUjJ?=
 =?us-ascii?Q?RUz4U01iK2ZVlzb9R4VbpM468dpDIL2LOoUuwWgpVAIQJmpADPfWNdTYnrv3?=
 =?us-ascii?Q?Uan0NgdihU+FJRnyHrMaeLkZ88n0q5E1R0FcU4Mje4tTNanifcPnRlv/O5Ew?=
 =?us-ascii?Q?REi7Y5qSedB8Bej92hN8csZHRym5+CUl4G9GLQ4V2Pb/3FXignms7+HYxTSx?=
 =?us-ascii?Q?n9LqK3dNmKwFgmudkTbFDE2I8mQxgp/7jdxCks6CiFwU5Qbo2Wd7pR+h37tY?=
 =?us-ascii?Q?/Ee6FAUeM8+A6adBIBqo4/joNrxeM4QhvzICjXnnQC8yqSYCWtpsHAQmRgUc?=
 =?us-ascii?Q?E3z/9uVRrm8oYRnZrQAm7qDOzPzs9p+qVmpIEuJTlc8mUgeFW2704qhJeiTX?=
 =?us-ascii?Q?yPuylku3qUNY/QpOgfOWHUiG1k5D7WqB6wA9dhQQj6uXHeycHkRn4LJmbYJs?=
 =?us-ascii?Q?gQcWfXwHM8vkVwrGR08a/Uf+FfZLWe2XD9f9YItryTtJJhmvutd/GY3glZM2?=
 =?us-ascii?Q?Mkvb4mtYmCurZun7sMUG9hGPqQje7goT7F3a6uBXguMsvwWHThHX/WK8ZZ64?=
 =?us-ascii?Q?UJD3h59t3MVDDP50VFcczPDhSGR4JgFx4et6RKJnk0Abedk+swuXoCLVLaS3?=
 =?us-ascii?Q?G/tASQYmY3KfbGoL+SYdIWOucSGP9E7QYv5G/nBwfNnbSjI85MwzbCddAhux?=
 =?us-ascii?Q?uZcpCeScO2H11Puc+PAqJ2FdC77FNVpyHBL58PHptH+E0AjutR/zD+eTwb8n?=
 =?us-ascii?Q?5sdKOMlCzIo3o7cEF7zDCDqS6pSmWXrLYHYMK4/UkI9F406+Qmevy0t51A5o?=
 =?us-ascii?Q?XwAiLCnmD5E5f6qoCarkgkueobw825n810ynmxJEpreSUSlMPz18yUTAj58E?=
 =?us-ascii?Q?wC3kGyM0CoVW0dhw3NgdB4arEl/rTwCwMyAuZUzk2wv3XVbRx46fJq9Qml5h?=
 =?us-ascii?Q?TWUUbkLY5vhtbjkft9y5VISvF2WKcLSJeMnJ7QH+7o/ECc7nAIRMokrkX3og?=
 =?us-ascii?Q?maclioY0ElFm4Tcjs51KDK8sh4cIaV0acCuwOIDSMsgAbItvtqd4a5infpa0?=
 =?us-ascii?Q?Fk64fu40WAhkqEf0/vdiq87rhp+HWRUWawUtkj+diFLjbouzx6xBqnHCdcyd?=
 =?us-ascii?Q?QXT/FOb74MKDTWd95KGaO2jEUOwtaylHLWCMmbe9HS98gM1UlIDr68Bkge7K?=
 =?us-ascii?Q?RoZVxY9YMDzWfa5gihVJaGbzWV+wHWRTcj38gG9bw1dBOnd7/o0Isi3BsAdV?=
 =?us-ascii?Q?vd6IOcwitiTsWePUNsAWLoDn+O2SSvCVv61d?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:42:35.3744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e73bf655-bf87-49f5-608f-08dd997990c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

From: Saeed Mahameed <saeedm@nvidia.com>

GENERIC_ALLOCATOR is a non-prompt kconfig, meaning users can't enable it
selectively. All kconfig users of GENERIC_ALLOCATOR select it, except of
NET_DEVMEM which only depends on it, there is no easy way to turn
GENERIC_ALLOCATOR on unless we select other unnecessary configs that
will select it.

Instead of depending on it, select it when NET_DEVMEM is enabled.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index 5b71a52987d3..ebc80a98fc91 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -68,8 +68,8 @@ config SKB_EXTENSIONS
 
 config NET_DEVMEM
 	def_bool y
+	select GENERIC_ALLOCATOR
 	depends on DMA_SHARED_BUFFER
-	depends on GENERIC_ALLOCATOR
 	depends on PAGE_POOL
 
 config NET_SHAPER
-- 
2.31.1


