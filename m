Return-Path: <bpf+bounces-50893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D52A2DC38
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394E47A1022
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5961BDA97;
	Sun,  9 Feb 2025 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1jYZJ3L"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015318E764;
	Sun,  9 Feb 2025 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096387; cv=fail; b=Isck8X7irMpnl68AjJYNH6nCJ2K79K7KJgD2pYMirdsnBG2Y2TpH/L2g83WJ96rkR3KZ8FXN91402z6PBdVcM4GjN/65XnIGu69Ug00b0BHyo1qoJQnSQ8EPMIdtZtry5yUcHwGXSeUQxKMlmFyTOHT5hE9KOSQbCAHOt3LwNgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096387; c=relaxed/simple;
	bh=4m4ciW03NwtYOo9BVW9sw4arpkXPJ53uCHW9VTKF5YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHcUNfRUZN1mhY/QR0WY/ZUH24SXWQIKi5NJ3AAvAvnQnwZLjo8HZasW4W4+aQ6wZnSWWvxnZnJOM/p5s3pzLA0bEHnErheOlsPkpP+dXwAmGXzSpxWUC4HwBrPXpHNyti+va9mxjrcZB73u6WSj7M8K03hNeM3BtIDW8OmHTBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C1jYZJ3L; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5dNM7nWs52+U3JEKR/z6qGIi/rANJM3KhcZ1hsQYRwQY9G1jZPpYkR5gskWXSiUmyfaUz8eOGYgOIPoRpWH3SAlkbRC9jRf/muqH/kFYq5vfv9gaGM2kt8BcYLsU8V38JzLBE3HGl0G9SV05hySiNF4bg/HEmCIxE/aoTCRNjGdkh2YaUsX9yXmcuHhRZOvJeD0BkAfFpy5DN9vx+8Aj9QkWFNOZRI4CpKKEstIUic+pr2gfpjJtSVYuD++PEZwyTu3yl5BewCMQbQoQT0wl0UlpIJEZD9yoThirUMxk41jziWsOHHTM2eGFEsHB4aY5NCOi31KqeUI/lyaRVl1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmc470bIMvOgWdUT9yAuFL+wM6HfSBZK/SEGFniHyMg=;
 b=IfK5yV+spqvGykhIoaaL7Ft3wcj2bgUjoFewHwbx+Nq1J7/C7V2L7xkWUJBsuEn5oBDzYXIl2X4svPZqN/JerE63X6i/nPGd+SoWOA8H1OUlOfi6OWQb9HFs+M9EyvmkCak08eipzWuhHeXNcOotx7L6U7FMmWrnCoAMNGRZQ57usKA6zp6H8HTAv0+/mcJxzZlyrMpQjNN1cTENyYBrDKFtt38/PPcqSew3I1cAQXi6AFtBysqkwTMNMoEUeUXLkjPUQHvH9ud+uQQ6mW0x3VFIFv0NAd5xNObEHF8mlcrwLwOdo3ai0eNJyBkEQY/vKB2ug7qRTJextYXjswEL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmc470bIMvOgWdUT9yAuFL+wM6HfSBZK/SEGFniHyMg=;
 b=C1jYZJ3LxMNMzbkHOjULmtkk2Xiw4E/GJ8bM0JLyCJsQGnadWNLEcj9jaOpW4qCbq6JwmVHyELU5uWiGfvPOG5Oza6l/aKwzc20v8bWJpHRNbHvutODZETkdi5QyKQ37VIQn8VYDeBu1kFEsgoREmbYEyf9U6NFmGseGy1wY55hXzj/V8hb0DAH94mEt94nlzjJZwQ5vO+lGU2P2l9c+3LCBhOBB+SUCoEoPFIjIqe6WfyemlY6Cu88qBfjG+bHtWUyvQvpy0kv977dT3J341lVGvTZ4jysRbRMmDGxZHPDc3qxBvSQ92Y4CDyX49kdwlAzb4ckfXM2Q9JT0cgfdRQ==
Received: from SA1P222CA0152.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::20)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sun, 9 Feb
 2025 10:19:41 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::bc) by SA1P222CA0152.outlook.office365.com
 (2603:10b6:806:3c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:19:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:38 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:37 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:32 -0800
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
	<bpf@vger.kernel.org>, Akiva Goldberger <agoldberger@nvidia.com>
Subject: [PATCH net-next 09/15] net/mlx5: Rename and move mlx5_esw_query_vport_vhca_id
Date: Sun, 9 Feb 2025 12:17:10 +0200
Message-ID: <20250209101716.112774-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: ee223b19-e1c2-4cfb-7b20-08dd48f343f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmfywPqUAk8UEmDVdXGngoJ8DD3H98gZ1QlUeslnnZeAllj7ANDoVvqLogxT?=
 =?us-ascii?Q?TZcde4tHbHUOq49eXXnI4e+JY591EIIgr9wOoNwtfYaWTSVBtZjma4FC4V3P?=
 =?us-ascii?Q?6CW99wPrWjHvJLdRkNAUGiZDtbEQMt70w9jdoefcZOUQvOazI13I9z2uFYQD?=
 =?us-ascii?Q?aWePjzpjYHzQoeJvKQcp7+g9vdqtJBYnDoizpbvC4BPUdrsnB4+GbEUwKNnW?=
 =?us-ascii?Q?Wjwpwc/3+nBJuI8N+xG6wQSm0M+iyxzKi3rgi3zBgPSQnpxs0g/inwV9m0/B?=
 =?us-ascii?Q?9Rx5RI+UK8RbOmOTCpbQYsoHYFVfZZgiQaNZ56iIDeA3OZV6uHTfYgY+Bmjc?=
 =?us-ascii?Q?MQK7V1hG+lnYYp97CGKrCEIqmg25lIkv/ibG1mDMPGPOnbhGWpWKvHhVJUP4?=
 =?us-ascii?Q?4N+moLgRceX0LgXK5Xc84O305Aio54K8u3L+6gLe5Z1lldwOIfKXBd5Iybgh?=
 =?us-ascii?Q?AooBzXyYafIR9EL+wwxR2ubOSqxPZ3Nzn75z3OkjowSQReyNXx4Nx8+hlcb3?=
 =?us-ascii?Q?KjettVblPBHYZaw1ZHPttqyhs4O8kTOw+ttrelRUX8CtiBs+iRdyWV1xFMu/?=
 =?us-ascii?Q?x124tanAdSWbfODtvTLQsnEilLpNWJ98AA4tFz9yYSIxV5FvcM4TX8ex9I6i?=
 =?us-ascii?Q?2zwpsUY0Lff6Xu10+PWTMb7bS5ayk3ISlkdBhQrhRXK9t0icd+lJaJaB/Yga?=
 =?us-ascii?Q?64HbqPe1w5OuIBdgrEikp+A6u0a6AgdzyEirseGihwT3JDkpKN3WGsxh7Jsh?=
 =?us-ascii?Q?4/inzf4hswuCpDb6vgsLuwg/SoL8bX0LIjoyHPs0PlteGPk+Kxwouif2Vaib?=
 =?us-ascii?Q?K6cXHwseSsyI2bL9Exj53WL/JpTU1hzDMqnTeUd642anhzCjNTSIwC0y/8dV?=
 =?us-ascii?Q?/HdIZ+2RRhc2sAB9uC8tjoydUjuHfvGhRUykGSNThvfRXeHqaLbfFELJTrgR?=
 =?us-ascii?Q?XIbOtIxE3jiEkDmiJsnnC5I8IvJiHngdZIii1TKeuriTarpEvI4NrH7EfYDb?=
 =?us-ascii?Q?LuQt4h7W/5FmZQL63AGqgeRGJS2HW5TF9aSpJ5MI6Wfd1lKMRNLm7uZxEoNv?=
 =?us-ascii?Q?41w0c+UHBPEdaKLoke5ywv3h/V3KGcRTi8wEBJnslswfzdY0blegIteOKneK?=
 =?us-ascii?Q?H6VB85d+DWHHlnSqJhXmSxa0tUKnuc7Fx8aruIwfDXl2N5BahR+S3mD5fuVs?=
 =?us-ascii?Q?vCAdmHYqNPjzg123ug8OS9qFgx9BZqNc4Z9gPpMUyQI/UcpKO+WKv9N1fz9A?=
 =?us-ascii?Q?f7sTNpQWRhH/qpQoIfhaVoUi8LXlov4rSd+BhlTX6lEdkAmK/y8EsxTjy1xE?=
 =?us-ascii?Q?7U1ODLqElQBbtp3DJkPVnpTqY2nX8oj1amkkU/HkvgQurhK5fRbOYUnfD2dB?=
 =?us-ascii?Q?6sBl+IVMg7AKGT8impE3fIaWuARFk1YOfG1foIJbgcUmja0du9uT7Mg3z1So?=
 =?us-ascii?Q?SGibK0PmPg/VB8T2fD7NASH0m887NKbqRQWBotIfIlPC9zWnkoIbGzByQbNj?=
 =?us-ascii?Q?TjacjFYn3bbXVUI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:40.9617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee223b19-e1c2-4cfb-7b20-08dd48f343f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

From: Akiva Goldberger <agoldberger@nvidia.com>

Rename mlx5_esw_query_vport_vhca_id to mlx5_vport_get_vhca_id and move
it to vport file. Also, add function declaration to mlx5_core header
file. This better represents the function's usage and allows for it to
be called from other parts of the mlx5_core driver.

Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 29 ++-----------------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 ++
 .../net/ethernet/mellanox/mlx5/core/vport.c   | 25 ++++++++++++++++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 20cc01ceee8a..0fa0333106a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4157,37 +4157,12 @@ u32 mlx5_eswitch_get_vport_metadata_for_match(struct mlx5_eswitch *esw,
 }
 EXPORT_SYMBOL(mlx5_eswitch_get_vport_metadata_for_match);
 
-static int mlx5_esw_query_vport_vhca_id(struct mlx5_eswitch *esw, u16 vport_num, u16 *vhca_id)
-{
-	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	void *query_ctx;
-	void *hca_caps;
-	int err;
-
-	*vhca_id = 0;
-
-	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
-	if (!query_ctx)
-		return -ENOMEM;
-
-	err = mlx5_vport_get_other_func_general_cap(esw->dev, vport_num, query_ctx);
-	if (err)
-		goto out_free;
-
-	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
-	*vhca_id = MLX5_GET(cmd_hca_cap, hca_caps, vhca_id);
-
-out_free:
-	kfree(query_ctx);
-	return err;
-}
-
 int mlx5_esw_vport_vhca_id_set(struct mlx5_eswitch *esw, u16 vport_num)
 {
 	u16 *old_entry, *vhca_map_entry, vhca_id;
 	int err;
 
-	err = mlx5_esw_query_vport_vhca_id(esw, vport_num, &vhca_id);
+	err = mlx5_vport_get_vhca_id(esw->dev, vport_num, &vhca_id);
 	if (err) {
 		esw_warn(esw->dev, "Getting vhca_id for vport failed (vport=%u,err=%d)\n",
 			 vport_num, err);
@@ -4213,7 +4188,7 @@ void mlx5_esw_vport_vhca_id_clear(struct mlx5_eswitch *esw, u16 vport_num)
 	u16 *vhca_map_entry, vhca_id;
 	int err;
 
-	err = mlx5_esw_query_vport_vhca_id(esw, vport_num, &vhca_id);
+	err = mlx5_vport_get_vhca_id(esw->dev, vport_num, &vhca_id);
 	if (err)
 		esw_warn(esw->dev, "Getting vhca_id for vport failed (vport=%hu,err=%d)\n",
 			 vport_num, err);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 99de67c3aa74..6fef1005c469 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -346,6 +346,8 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 #define mlx5_vport_get_other_func_general_cap(dev, vport, out)		\
 	mlx5_vport_get_other_func_cap(dev, vport, out, MLX5_CAP_GENERAL)
 
+int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id);
+
 static inline u32 mlx5_sriov_get_vf_total_msix(struct pci_dev *pdev)
 {
 	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 0d5f750faa45..d10d4c396040 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -1199,6 +1199,31 @@ int mlx5_vport_get_other_func_cap(struct mlx5_core_dev *dev, u16 vport, void *ou
 }
 EXPORT_SYMBOL_GPL(mlx5_vport_get_other_func_cap);
 
+int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
+{
+	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	void *query_ctx;
+	void *hca_caps;
+	int err;
+
+	*vhca_id = 0;
+
+	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
+	if (!query_ctx)
+		return -ENOMEM;
+
+	err = mlx5_vport_get_other_func_general_cap(dev, vport, query_ctx);
+	if (err)
+		goto out_free;
+
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
+	*vhca_id = MLX5_GET(cmd_hca_cap, hca_caps, vhca_id);
+
+out_free:
+	kfree(query_ctx);
+	return err;
+}
+
 int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap,
 				  u16 vport, u16 opmod)
 {
-- 
2.45.0


