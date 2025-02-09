Return-Path: <bpf+bounces-50887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A4A2DC14
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FA7165913
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AE8192D87;
	Sun,  9 Feb 2025 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLj4bdKH"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E71598F4;
	Sun,  9 Feb 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096364; cv=fail; b=dmYj5rM5A+1H1Y2Xql1itWrq8CK858qqGXUJqH2Uq0Tq9iGLk+iRYGkkiaTzebixm3elkI3hpvgUSo1/LsgnyjH+2Kn9e6q1I1qFe/PrG1i/vKqwHgR1VxdaMAV0x+qH/wMMvipOyUBsykZT9jq7Fq6YbOJrGrKk1xUiYy0Sjws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096364; c=relaxed/simple;
	bh=O9UUxjEdfh/ZujFYDncbW9+opnXzJiOQ12mLCZsxejk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qo/A63tDlAgB/X7MTh9BZzRHVcuABO4eUa58CtmiX5NxqH4VLpjBBwdXaMia65MHMdl2gKSf7GfwXQNTSMA5e5sieRH1rA0RbNnBp4IopapNV1FDB2Ksovs+5uwpulJ+S2CMI5n+zkryv9sq/wtNuY2NRS+a6rNZOpA01bNdbTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLj4bdKH; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSRdnd9roK3+YqCn39HfQ9834WgxXm21ss5bckjfhiviyG/bgn4KxN/btWOcxEPOD/wA8vAapXKgLO+snyASNkFGkNoDo89hflOInBPEj6fpQT6EhNc92RNCdQJ2+gTFJpXlmqiAZoha+a06NjlLaVkjAhKDrv/9LyFOP+omqRNlo8U1rvEx4iYy+74WGQhurvpcB1m4Q/aU9M3PaDU3thNw0hS96kueUpe5qF6qLvlcM+jSxOiKrCVj7YTO+Qth4pZPX5AnuO56yGu74LLE4O3OhuKtJWiZAOOUaZl52QLuTfKHdMDIrPSGXE7FcNgAY9CqL2dok88VA7vW1U68gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfMVPFWorxjt+1cVGBkPA7uYKrHKsbHNopjQxabBpLc=;
 b=xNYYU9/0/XuEPfjvinGzmh71AweBF2OFfRyvxxgvchPuFJWocs/8y2HYwT+SqD52QDru/VtmsE4WTHDHakaKwv3nTdDl+u2f+zBMekFaowLkCBfHlfAukjG0psNN5LBZa18ndDsLjCcZfMqn7q0STBf+cJstBE342e0yrSu6UeRJT6TYTRg+K7wml8L5jT2rICeMjGhuSa8GxLj8ej6SYs888MGj6ICuioSmwLbqQYlyCPc+sfZwiAQpdNXNbJFhEfgPshnaztclvZNgJHsajUgD67df8/mFQb8QBAdDB2WbLIZufbpYxuwb5qe4ClwaAkXQYdnA2ux2QtrGm8DnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfMVPFWorxjt+1cVGBkPA7uYKrHKsbHNopjQxabBpLc=;
 b=dLj4bdKHQE+p/tNyqjrEc8ICQrbbW877FBaDHqAY7JZBKQI9Wfm/HbQsTu/WS9J93nQKtvKa0aBM7C7NM6PZD1I41CzfnSxI6uKf84hnwOJPZxg0j3+i5LvjWBzbySpP0V/urq76XISW6la+dssjFtBCV5igPIrj0bn6DzSZYfjFz1kbT563BBmpdLkkwsVnFtpsjnEgaDvy2tQMjHlnbdECd4ct6cqGknYd11z2s0DLJKUvZyhoV08EJgM9I+FZkcqN+na9Zd7K/GSJU29vHNzyXAzHNXom9z4aUE+fxOdVBZZAl3gNEgz4L4JpbBpnLZ8fRqBpVetoMUWGds9B0A==
Received: from PH7P220CA0166.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::13)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 10:19:16 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::ba) by PH7P220CA0166.outlook.office365.com
 (2603:10b6:510:33b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:19:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:03 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:18:57 -0800
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
	<bpf@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next 03/15] net/mlx5: Add support for setting tc-bw on nodes
Date: Sun, 9 Feb 2025 12:17:04 +0200
Message-ID: <20250209101716.112774-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250209101716.112774-1-tariqt@nvidia.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 4617167a-6a22-4633-65bd-08dd48f3347e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkVIaEMzTS82UVpIVFdBcWE1K056Rm9Fb2Y1dEVITmNwWktibGgxRCtySUw0?=
 =?utf-8?B?Y1F2RUI3UjVQRHp5UitWYmtibmVVV3RrVHNHNUdMTUM4M3BLM1NuY21jakN6?=
 =?utf-8?B?eUlMSFZHUHl0Nm8weHIzTG94NTloRGhGVVAwUnZhb0tGVUtuTFFHall2UGZE?=
 =?utf-8?B?UmpLSGRvaHA3Uzk1MC9qV3gwL3Fac3BPS1RTTUN2Mll5aUR3K3ZiOTljVnpU?=
 =?utf-8?B?akNDbGtxamhVbG1YK2xCd0VQdFNaeFY5QnZXVnJqSllMTVhVa1U1MENkeDIr?=
 =?utf-8?B?MkxRd0pkWHVrSWtFZVh5eVFiQnM5TGVWaTEwK1cya3NzS1pEeFpLQkRBRDUr?=
 =?utf-8?B?aFl1OWpwcUVVR1JzWlBQUFpoSGdKa1c0SVQwbDBrQndVdWVqbjRpK1o2U090?=
 =?utf-8?B?dzkxRUVYbGtRMjJjMGZMaUJGOGRSMC9wS3hZelhPQlVaYVBKQ1pPbmlLeFFr?=
 =?utf-8?B?T2RtZHRidENiRGorVjVqUTBBVktTOWR4Q3lia1p0OEduWjc0QldzNk5Ea1k1?=
 =?utf-8?B?cWU1bUtmaU15VDVIUEtFclo2M1ZtS0FqOGRvN1BGWjNyRXRDN2VNSml0U3Vz?=
 =?utf-8?B?RDdOclhpSUxzMU9BbjVoeGhxZHFhUVl1ZGhNVG1DRXpkOGhSYnphRXpsbGVm?=
 =?utf-8?B?b01janM3VDdBT3UxRWJZRVNna0JyaFJ5L0pISHRVY3kxZUU0NzVFSW10RjV5?=
 =?utf-8?B?THZ1SjBqWjQ1bVZHWDVLN050N3d3bVpydk4vcjZTek51eEhlR1RKcjhsOU5L?=
 =?utf-8?B?QnIvalhzcG1qYlhDTDFyejU2MzJwT3pobVNjdmg5eWgzbDc0a0UvMURSMG9H?=
 =?utf-8?B?RVl5SC8zalR4L1dGV1VwUXg1ZWhsRWo5Uk10UXd3UXByS0pvRDZZVUt6VTNk?=
 =?utf-8?B?K3BJYVBHQnM5MEJ2bTNQMjdVM2RzSVhwdklndjFLemUwL3Bkb3VJTTRSMHZm?=
 =?utf-8?B?SUxMVG1Jc3JKbHJHVWdmM3J2eXdFTnJTcmlOVFA3UlZ0L1puamFxQnFmQkhP?=
 =?utf-8?B?QTIyQjhCN2JRZE5XT1I5N3l2SG1aT1Njc2pkTG92Vk80ODJVYnhKS2NBNWV0?=
 =?utf-8?B?S0RLTkFNWVB6cU5qRzNpR0hSTXFsTWJIemJBVStNSjJBZ0VrZTRMWmtXaDJr?=
 =?utf-8?B?ai9rMGliWHR2ZjdNclBodUI0VnpXMmpZdWR5V1lTQ08zOFVUR1IzL1JnNWF3?=
 =?utf-8?B?U2FnWnREY3hjd0pQS2JPTlRpbzFCai9TZ3Vma2RPSzVvam9QMjNGK3huRWxW?=
 =?utf-8?B?akc3ZHlQZlFZWk53ek5qOUV3RUhrdlVkb2cxLzZzTzR3eFFKWlZXNnIyMWRT?=
 =?utf-8?B?OEVyemRjaVRZbnJQa2gvYVoveDNhY3lRdjVUYS9sZVFTZ3crZzFjbnVnb045?=
 =?utf-8?B?bS9XZ0g1U1dCZzIwdi9zcW5UaWZSQ3QvNS91emptMVgwR1E2dnJOWmFDUWZF?=
 =?utf-8?B?UkZNV25jWFN1dEhJUXMrVjd0VDZvK0JXM1d6UnRDZ2ZhR20zQ1BnN3VWYng3?=
 =?utf-8?B?cW1JNEc0YzBKNXNRd0xGcGxZeXNpTWtSVk44Z2tkOE1XSXJGQWRFUXBGTTJT?=
 =?utf-8?B?UldVcVdnYkJNcGdxZnhWMVJMT0FGWUZFTHhZR0ZGL3ZGMWtjZlMxUmJSQnd3?=
 =?utf-8?B?TGZteUlmdEZ0eS9BbGg2UzRPSWgzMmJmSUpqS0wwcDVYenI0WW44MVFNazQr?=
 =?utf-8?B?Zm1nTUVwTC8wdkp2YWVBSFhOU3BWc3Q3dDBTYitFc2N5TFJzOUFwdFZQeEJs?=
 =?utf-8?B?RTM4SnZmeFhpcHhDWFNFbkhjeXU4NDIzWUJMTW5nN2xsUEZ1Q00zSm1RR0Ev?=
 =?utf-8?B?RXdMQW5kUzNtNVBUYVQvZ0VhRDdsMFFrVnJWZzY3R2h1TktkNUliSzZFYW1a?=
 =?utf-8?B?cFZZRGFoZ3VqOXJ2emhLSGZna0ZoMWNINnVuMG9qeFZGYVdzOHoxcWlJSE5F?=
 =?utf-8?B?VVlMWXBnK1ZKWDNUU0NseHQ0eEhtUjFWL1Byc2laQ0ZvWW9veXVPRVlicWNP?=
 =?utf-8?Q?HAoVOdd+GhRAEkrh2QBfILtN/a0/14=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:15.0492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4617167a-6a22-4633-65bd-08dd48f3347e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for enabling and disabling Traffic Class (TC)
arbitration for existing devlink rate nodes. This patch adds support
for a new scheduling node type, `SCHED_NODE_TYPE_TC_ARBITER_TSAR`.

Key changes include:

- New helper functions for transitioning existing rate nodes to TC
  arbiter nodes and vice versa. These functions handle the allocation
  of TC arbiter nodes, copying of child nodes, and restoring vport QoS
  settings when TC arbitration is disabled.

- Implementation of `mlx5_esw_devlink_rate_node_tc_bw_set()` to manage
  tc-bw configuration on nodes.

- Introduced stubs for `esw_qos_tc_arbiter_scheduling_setup()` and
  `esw_qos_tc_arbiter_scheduling_teardown()`, which will be extended in
  future patches to provide full support for tc-bw on devlink rate
  objects.

- Validation functions for tc-bw settings, allowing graceful handling
  of unsupported traffic class bandwidth configurations.

- Updated `__esw_qos_alloc_node()` to insert the new node into the
  parent’s children list only if the parent is not NULL. For the root
  TSAR, the new node is inserted directly after the allocation call.

- Updated esw_qos_create_node_sched_elem to receive max_rate and
  bw_share values to save the old configuration when changing the group
  type.

This patch lays the groundwork for future support for configuring tc-bw
on devlink rate nodes. Although the infrastructure is in place, full
support for tc-bw is not yet implemented; attempts to set tc-bw on
nodes will return `-EOPNOTSUPP`.

No functional changes are introduced at this stage.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 279 ++++++++++++++++--
 1 file changed, 262 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index db112a87b7ee..efcbd3180317 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -64,11 +64,13 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
+	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 };
 
 static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_VPORTS_TSAR] = "vports TSAR",
 	[SCHED_NODE_TYPE_VPORT] = "vport",
+	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
 };
 
 struct mlx5_esw_sched_node {
@@ -92,6 +94,13 @@ struct mlx5_esw_sched_node {
 	struct mlx5_vport *vport;
 };
 
+static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
+{
+	int num_tcs = mlx5_max_tc(dev) + 1;
+
+	return num_tcs < IEEE_8021QAZ_MAX_TCS ? num_tcs : IEEE_8021QAZ_MAX_TCS;
+}
+
 static void
 esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
 {
@@ -101,6 +110,25 @@ esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_
 	node->esw = parent->esw;
 }
 
+static void
+esw_qos_nodes_set_parent(struct list_head *nodes, struct mlx5_esw_sched_node *parent)
+{
+	struct mlx5_esw_sched_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, nodes, entry) {
+		esw_qos_node_set_parent(node, parent);
+		if (!list_empty(&node->children) &&
+		    parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+			struct mlx5_esw_sched_node *child;
+
+			list_for_each_entry(child, &node->children, entry) {
+				if (child->vport)
+					child->vport->qos.sched_node->parent = parent;
+			}
+		}
+	}
+}
+
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
 {
 	kfree(vport->qos.sched_node);
@@ -126,16 +154,23 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
-	if (node->vport) {
+	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORT:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,err=%d)\n",
 			 op, sched_node_type_str[node->type], node->vport->vport, err);
-		return;
+		break;
+	case SCHED_NODE_TYPE_TC_ARBITER_TSAR:
+	case SCHED_NODE_TYPE_VPORTS_TSAR:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (err=%d)\n",
+			 op, sched_node_type_str[node->type], err);
+		break;
+	default:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s scheduling element failed (err=%d)\n", op, err);
+		break;
 	}
-
-	esw_warn(node->esw->dev,
-		 "E-Switch %s %s scheduling element failed (err=%d)\n",
-		 op, sched_node_type_str[node->type], err);
 }
 
 static int esw_qos_node_create_sched_element(struct mlx5_esw_sched_node *node, void *ctx,
@@ -306,7 +341,7 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 }
 
 static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
-					  u32 *tsar_ix)
+					  u32 max_rate, u32 bw_share, u32 *tsar_ix)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	void *attr;
@@ -323,6 +358,8 @@ static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
 		 parent_element_id);
+	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw, max_rate);
+	MLX5_SET(scheduling_context, tsar_ctx, bw_share, bw_share);
 	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
 	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
 
@@ -358,7 +395,6 @@ static struct mlx5_esw_sched_node *
 __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
 {
-	struct list_head *parent_children;
 	struct mlx5_esw_sched_node *node;
 
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
@@ -370,8 +406,10 @@ __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type
 	node->type = type;
 	node->parent = parent;
 	INIT_LIST_HEAD(&node->children);
-	parent_children = parent ? &parent->children : &esw->qos.domain->nodes;
-	list_add_tail(&node->entry, parent_children);
+	if (parent)
+		list_add_tail(&node->entry, &parent->children);
+	else
+		INIT_LIST_HEAD(&node->entry);
 
 	return node;
 }
@@ -396,7 +434,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 	u32 tsar_ix;
 	int err;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, 0, 0, &tsar_ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
 		return ERR_PTR(err);
@@ -409,6 +447,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 		goto err_alloc_node;
 	}
 
+	list_add_tail(&node->entry, &esw->qos.domain->nodes);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
 	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
 
@@ -463,7 +502,7 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0, &esw->qos.root_tsar_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
@@ -475,11 +514,11 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 		/* The eswitch doesn't support scheduling nodes.
 		 * Create a software-only node0 using the root TSAR to attach vport QoS to.
 		 */
-		if (!__esw_qos_alloc_node(esw,
-					  esw->qos.root_tsar_ix,
-					  SCHED_NODE_TYPE_VPORTS_TSAR,
+		if (!__esw_qos_alloc_node(esw, esw->qos.root_tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR,
 					  NULL))
 			esw->qos.node0 = ERR_PTR(-ENOMEM);
+		else
+			list_add_tail(&esw->qos.node0->entry, &esw->qos.domain->nodes);
 	}
 	if (IS_ERR(esw->qos.node0)) {
 		err = PTR_ERR(esw->qos.node0);
@@ -537,6 +576,17 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 		esw_qos_destroy(esw);
 }
 
+static void esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
+						   struct netlink_ext_ack *extack)
+{}
+
+static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
+					       struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC arbiter elements are not supported.");
+	return -EOPNOTSUPP;
+}
+
 static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
@@ -699,6 +749,158 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 	return err;
 }
 
+static void esw_qos_switch_vport_tcs_to_vport(struct mlx5_esw_sched_node *tc_arbiter_node,
+					      struct mlx5_esw_sched_node *node,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *vport_tc_node, *tmp;
+
+	vports_tc_node = list_first_entry(&tc_arbiter_node->children, struct mlx5_esw_sched_node,
+					  entry);
+
+	list_for_each_entry_safe(vport_tc_node, tmp, &vports_tc_node->children, entry)
+		esw_qos_vport_update_parent(vport_tc_node->vport, node, extack);
+}
+
+static int esw_qos_switch_tc_arbiter_node_to_vports(struct mlx5_esw_sched_node *tc_arbiter_node,
+						    struct mlx5_esw_sched_node *node,
+						    struct netlink_ext_ack *extack)
+{
+	u32 parent_tsar_ix = node->parent ? node->parent->ix : node->esw->qos.root_tsar_ix;
+	int err;
+
+	err = esw_qos_create_node_sched_elem(node->esw->dev, parent_tsar_ix, node->max_rate,
+					     node->bw_share, &node->ix);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to create scheduling element for vports node when disabliing vports TC QoS");
+		return err;
+	}
+
+	node->type = SCHED_NODE_TYPE_VPORTS_TSAR;
+
+	/* Disable TC QoS for vports in the arbiter node. */
+	esw_qos_switch_vport_tcs_to_vport(tc_arbiter_node, node, extack);
+
+	return 0;
+}
+
+static int esw_qos_switch_vports_node_to_tc_arbiter(struct mlx5_esw_sched_node *node,
+						    struct mlx5_esw_sched_node *tc_arbiter_node,
+						    struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node, *tmp;
+	struct mlx5_vport *vport;
+	int err;
+
+	/* Enable TC QoS for each vport in the node. */
+	list_for_each_entry_safe(vport_node, tmp, &node->children, entry) {
+		vport = vport_node->vport;
+		err = esw_qos_vport_update_parent(vport, tc_arbiter_node, extack);
+		if  (err)
+			goto err_out;
+	}
+
+	/* Destroy the current vports node TSAR. */
+	err = mlx5_destroy_scheduling_element_cmd(node->esw->dev, SCHEDULING_HIERARCHY_E_SWITCH,
+						  node->ix);
+	if (err)
+		goto err_out;
+
+	return 0;
+err_out:
+	/* Restore vports back into the node if an error occurs. */
+	esw_qos_switch_vport_tcs_to_vport(tc_arbiter_node, node, NULL);
+
+	return err;
+}
+
+static struct mlx5_esw_sched_node *esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
+{
+	struct mlx5_esw_sched_node *new_node;
+
+	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix, curr_node->type, NULL);
+	if (!IS_ERR(new_node))
+		esw_qos_nodes_set_parent(&curr_node->children, new_node);
+
+	return new_node;
+}
+
+static int esw_qos_node_disable_tc_arbitration(struct mlx5_esw_sched_node *node,
+					       struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_node;
+	int err;
+
+	if (node->type != SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return 0;
+
+	/* Allocate a new rate node to hold the current state, which will allow
+	 * for restoring the vports back to this node after disabling TC arbitration.
+	 */
+	curr_node = esw_qos_move_node(node);
+	if (IS_ERR(curr_node)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting up vports node");
+		return PTR_ERR(curr_node);
+	}
+
+	/* Disable TC QoS for all vports, and assign them back to the node. */
+	err = esw_qos_switch_tc_arbiter_node_to_vports(curr_node, node, extack);
+	if (err)
+		goto err_out;
+
+	/* Clean up the TC arbiter node after disabling TC QoS for vports. */
+	esw_qos_tc_arbiter_scheduling_teardown(curr_node, extack);
+	goto out;
+err_out:
+	esw_qos_nodes_set_parent(&curr_node->children, node);
+out:
+	__esw_qos_free_node(curr_node);
+	return err;
+}
+
+static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_node;
+	int err;
+
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return 0;
+
+	/* Allocate a new node that will store the information of the current node.
+	 * This will be used later to restore the node if necessary.
+	 */
+	curr_node = esw_qos_move_node(node);
+	if (IS_ERR(curr_node)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting up node TC QoS");
+		return PTR_ERR(curr_node);
+	}
+
+	/* Initialize the TC arbiter node for QoS management.
+	 * This step prepares the node for handling Traffic Class arbitration.
+	 */
+	err = esw_qos_tc_arbiter_scheduling_setup(node, extack);
+	if (err)
+		goto err_setup;
+
+	/* Enable TC QoS for each vport within the current node. */
+	err = esw_qos_switch_vports_node_to_tc_arbiter(curr_node, node, extack);
+	if (err)
+		goto err_switch_vports;
+	goto out;
+
+err_switch_vports:
+	esw_qos_tc_arbiter_scheduling_teardown(node, NULL);
+	node->ix = curr_node->ix;
+	node->type = curr_node->type;
+err_setup:
+	esw_qos_nodes_set_parent(&curr_node->children, node);
+out:
+	__esw_qos_free_node(curr_node);
+	return err;
+}
+
 static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 {
 	struct ethtool_link_ksettings lksettings;
@@ -824,6 +1026,30 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw, u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
+static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
+{
+	int i;
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
 	if (esw->qos.domain)
@@ -892,8 +1118,27 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *p
 int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
 					 u32 *tc_bw, struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on nodes");
-	return -EOPNOTSUPP;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
+	bool disable;
+	int err;
+
+	if (!esw_qos_validate_unsupported_tc_bw(esw, tc_bw)) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch traffic classes number is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	disable = esw_qos_tc_bw_disabled(tc_bw);
+	esw_qos_lock(esw);
+	if (disable) {
+		err = esw_qos_node_disable_tc_arbitration(node, extack);
+		goto unlock;
+	}
+
+	err = esw_qos_node_enable_tc_arbitration(node, extack);
+unlock:
+	esw_qos_unlock(esw);
+	return err;
 }
 
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
-- 
2.45.0


