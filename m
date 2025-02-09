Return-Path: <bpf+bounces-50894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58650A2DC3B
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786FB18873AA
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309B1C07EC;
	Sun,  9 Feb 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEmXXu8/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3AC1BEF82;
	Sun,  9 Feb 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096391; cv=fail; b=gXbPNOrIWB9OFa9LUZQQe8GmtdgOiJaL8TSy0pGi6qWGl5EOaRP2/IgM+Z7Cm0yFP7BQA4jVhPUxQHcpfvhDZyPUZtMzT+9pg6Jb9YZ1YFZLr0xlASv+DsXqhJ3m+XuvgvABJU7pCwwqvFJHuTyJ/0lMXxQtIUMnEPumU1seir4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096391; c=relaxed/simple;
	bh=5Y4tF82OaX68Bo+FeBuCWaTSOxNkeIEUA3KLdzZjoos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgScOz9W+nOYdrZYUtARIlhArlHZ4DKWOlCc2uwN+pM4ba/T62KjEQt1mlxd/+QlIXLe6QGaLjQB5PhYWlAp68BzbCpdBxltf8854XW8kw2+ZmE8wn7bkBaD5Y0ChLUDRCblQxSc+H+uWtSi4Cnm7UnSmjevIlxOE9xxBnssT9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEmXXu8/; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQEgXIhhn0NxnMoxZXe7hmeHAN4j2dIhrjsliKs6w4FsjXxCfupCxG7JYOJpEIip0xDhvOD5J8B1+o5uFjZw/VYUHpYrhzPHELKWraaYRcaHSdjmcgwHlRYrRagnjo7AhD5jmQRpjFHMuvb4r0HgLiaYi8WfE2GNIG7bvBt2IguiCGof/LLe2sZL8KXSz0UdzzlVpeqgO6rjXYjHCuOvNxJe+uZu8rHWbO3KNhoAJ2L6TgC4f70CMQeOkS4EuyEkRB03A+spJdDkXZtBeEGpwjKyQ0ZmRo6CIqCakuv18MKITkkdxnt7SgoV+Xi5OFEVfgUJ0Bu7wtFCdcS/q9mruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkAxzzWjsle1KBQZsvaGlIVAQlIYl6CihvtSpklbu0c=;
 b=Pv+jjqtpzD5bMmSRawYcu8WnO+xpVxf7gwq+hrdg1zH5XJOw3uhe2Lnm81GW++oU41i2ibOBVNNo2KHF6bJAre5Xf0lrALDdrxuIkMYTmC8nyK582i3+72MtRW5AJKGLzGhjvlT37aTJoeEuFJmwYlATLJKIndxjxoRM9F675iaqeWQmAJmbNKqKn++QZaMdqsrUNUZ+iQW6r95dJVDb/q6EehapnK9Qa5d8jz8/3IIqoxIWqBsTU6ZRIk8BOdYo0OLxxTl+EpmV5MkFPckhg3ZJbGmqdUAoI9YEcThHVzP1s9b9+r7lyI86mEpDOJ9gnzerkRLXVJ7pjr+v5AwBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkAxzzWjsle1KBQZsvaGlIVAQlIYl6CihvtSpklbu0c=;
 b=oEmXXu8/SmypWmNeWC0QkQO6N2ht76ccC3EfcMfI4wUmd/ZiUpT8PVH+QMbDAhdOIDWw/rSkjTM9hIm3bP7gLeu7Jcy4O119TNNy8S4DmWuxzNTwFj4ixe0G5XAj8+3V1VRGsY4nZOTc8gpRS2wQEtlvRXvy2crTR10/jYUsToqWMBQywSAoU5O44XwSHYZdEbm85B5xHnbO9MyZPaW9Qt9498yOOXzbU0e48Ba1crrHIrhU/HOZ2Uc6didPBA/cow5CxERoHyrCRfuBOawqP6GSVmc0skldMXuBWqNcpF1D/M9R8asvgGAJ7ie/vvZ1X4xSO19sRapI+j8obrRr5Q==
Received: from SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sun, 9 Feb
 2025 10:19:46 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::65) by SA9PR03CA0009.outlook.office365.com
 (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:19:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:38 -0800
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
	<bpf@vger.kernel.org>, Akiva Goldberger <agoldberger@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>
Subject: [PATCH net-next 10/15] net/mlx5: Expose ICM consumption per function
Date: Sun, 9 Feb 2025 12:17:11 +0200
Message-ID: <20250209101716.112774-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 259b7231-5ea8-4584-60c3-08dd48f346b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nIaBCODGO3uEnwnEP2u4T22DB2vU+iY5uMGiqS/62wSF2WnXTB7IfaFgAz2R?=
 =?us-ascii?Q?03TF2bJk6AmCKCaat8uKpXafeo/J/vp+D9fRZo1PZ63wd6Dw9690iBbsIhgD?=
 =?us-ascii?Q?sGfdJLYT9p/XQS2GTFbEUFtDe/K4rn/jHHfullQkkYQ1eq6gizV33pYKpbyi?=
 =?us-ascii?Q?qSxVpL5mPQro3IqIjUTYJmvbw1B4l6Wb8uIDFvbLy8X1fg3Q4myyD/XsH+xi?=
 =?us-ascii?Q?kzURHozOPt+A6YUjiYeivPzV9DPHO5kiiviQm8epj8GKj6MnuzAiNOJ21z12?=
 =?us-ascii?Q?7vuQHJUJFWhz03ohV2OZRO/jrRwZea27gFFmMWySOC+VzRLBrP3mrz72TziB?=
 =?us-ascii?Q?5gHDxFtSAF8uh5Uqn+5smmdUDRTEaWN5xF6ytxX27IsklrsojLMsYCn1fomm?=
 =?us-ascii?Q?9f+yjEVXdRo/KbeqM+R87YfHStiKK1H6cZVouZgOfKvxTc+xyeY/E0MX5B96?=
 =?us-ascii?Q?S5Wx/yWsckDt19Sxgrq6K1sfS/ryjtxu2HSZ3Ay62LiMpHnL/UaLub3S56PW?=
 =?us-ascii?Q?Zs6FC5mkouxbJUKuVH4vEGRYxP+CTlLgiPuCxt9xfjtKBPlOMDoq8ylN2ZR/?=
 =?us-ascii?Q?x0Cyc6R6JVV2+rqPB7MiCHbiT+5D+/1PrcmEcUj73ccIlXVqA+BJkzqJjf48?=
 =?us-ascii?Q?e+LIPu40ZT4laiIhTyG1rO14tLEXE3+P80mmnQvcVv/Y0eky+XqL5kBvH9w8?=
 =?us-ascii?Q?etWg/orrwMifgBUnQCQVUvyIQ99IG6WdEAuHqk+QLBvhIE/MQCCi8NfRwK4W?=
 =?us-ascii?Q?9Hsd5uygQMTU1/8XepEbIUbW6bU+lI53RL067Rx7wXYPHAsUs5KfDGLWaPAh?=
 =?us-ascii?Q?Ik1qbxxmBqma2j2JmItExqvo1gJddGM+MLTt6hhDYP4hP4krCn3OX6hX3/YS?=
 =?us-ascii?Q?1mILd8Zvt9YfXVso8KiC3C0YG36AxdSHwOmwRI+Sd9FQ0oYmS5OA6TV3Ra0/?=
 =?us-ascii?Q?hKCKq785F/hXJgmmak8d9JPcGW2b94BblbyfcSXhTbfAVvDPnNLbWiIQSYUn?=
 =?us-ascii?Q?spozpObq/n2bmFr67QPE7rmnGbxnJ7hUqGRgwS5ZWkSc2zhWYYCtr8eguTRl?=
 =?us-ascii?Q?c/MODjB/O1lPyHDuA+P6zz8Z17N2z/j3mKQkNWj5Bf2krJWcuutVYu/j39sE?=
 =?us-ascii?Q?JLdX/HV7FPjcBL68DtUS636apvU+IRjTE7Ic71jgDgAvpvEaJ2BPfXPTxkrK?=
 =?us-ascii?Q?6+7D1/vv8nNVI7t+57YFV9Bs33Unf/zFRsPzcoRxhM/hCL+UOW+WErpP4xEG?=
 =?us-ascii?Q?6V+7WDCopQktk5OOHGk9lHUgVLmmCsxqj1H+MUKrOkSi1+QrooDo0FhDcMOo?=
 =?us-ascii?Q?QulXcqROyIeyowtYPEUpSpo5ZF07Liv1WF+u3uXDeF0CWmb1itQLhcDHEUyW?=
 =?us-ascii?Q?TLSO6BJNw0lN2kTUw4U4EVIebgAkq03FD0iH5EmBj1p0yDtWorWfenG9n0TI?=
 =?us-ascii?Q?1gr/MyuzT7lgFhwiK1Y4LWIEdX6U8OwKHDyD559H6ZaW70fadXLXhvDmJqw8?=
 =?us-ascii?Q?qnKQio2sYLVxStE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:45.5748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259b7231-5ea8-4584-60c3-08dd48f346b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528

From: Akiva Goldberger <agoldberger@nvidia.com>

ICM is a portion of the host's memory assigned to a function by the OS
through requests made by the NIC's firmware.

PF ICM consumption can be accessed directly, while VF/SF ICM consumption
can be accessed through their representors in switchdev mode.

The value is exposed to the user in granularity of 4KB through the vnic
health reporter as follows:

$ devlink health diagnose pci/0000:08:00.0 reporter vnic
 vNIC env counters:
     total_error_queues: 0 send_queue_priority_update_flow: 0
     comp_eq_overrun: 0 async_eq_overrun: 0 cq_overrun: 0
     invalid_command: 0 quota_exceeded_command: 0
     nic_receive_steering_discard: 0 icm_consumption: 1032

Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  4 ++
 .../mellanox/mlx5/core/diag/reporter_vnic.c   | 46 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 41618538fc70..7febe0aecd53 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -280,6 +280,10 @@ Description of the vnic counters:
 	number of packets handled by the VNIC experiencing unexpected steering
 	failure (at any point in steering flow owned by the VNIC, including the FDB
 	for the eswitch owner).
+- icm_consumption
+        amount of Interconnect Host Memory (ICM) consumed by the vnic in
+        granularity of 4KB. ICM is host memory allocated by SW upon HCA request
+        and is used for storing data structures that control HCA operation.
 
 User commands examples:
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index c7216e84ef8c..86253a89c24c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -13,6 +13,50 @@ struct mlx5_vnic_diag_stats {
 	__be64 query_vnic_env_out[MLX5_ST_SZ_QW(query_vnic_env_out)];
 };
 
+static void mlx5_reporter_vnic_diagnose_counter_icm(struct mlx5_core_dev *dev,
+						    struct devlink_fmsg *fmsg,
+						    u16 vport_num, bool other_vport)
+{
+	u32 out_icm_reg[MLX5_ST_SZ_DW(vhca_icm_ctrl_reg)] = {};
+	u32 in_icm_reg[MLX5_ST_SZ_DW(vhca_icm_ctrl_reg)] = {};
+	u32 out_reg[MLX5_ST_SZ_DW(nic_cap_reg)] = {};
+	u32 in_reg[MLX5_ST_SZ_DW(nic_cap_reg)] = {};
+	u32 cur_alloc_icm;
+	int vhca_icm_ctrl;
+	u16 vhca_id;
+	int err;
+
+	err = mlx5_core_access_reg(dev, in_reg, sizeof(in_reg), out_reg,
+				   sizeof(out_reg), MLX5_REG_NIC_CAP, 0, 0);
+	if (err) {
+		mlx5_core_warn(dev, "Reading nic_cap_reg failed. err = %d\n", err);
+		return;
+	}
+	vhca_icm_ctrl = MLX5_GET(nic_cap_reg, out_reg, vhca_icm_ctrl);
+	if (!vhca_icm_ctrl)
+		return;
+
+	MLX5_SET(vhca_icm_ctrl_reg, in_icm_reg, vhca_id_valid, other_vport);
+	if (other_vport) {
+		err = mlx5_vport_get_vhca_id(dev, vport_num, &vhca_id);
+		if (err) {
+			mlx5_core_warn(dev, "vport to vhca_id failed. vport_num = %d, err = %d\n",
+				       vport_num, err);
+			return;
+		}
+		MLX5_SET(vhca_icm_ctrl_reg, in_icm_reg, vhca_id, vhca_id);
+	}
+	err = mlx5_core_access_reg(dev, in_icm_reg, sizeof(in_icm_reg),
+				   out_icm_reg, sizeof(out_icm_reg),
+				   MLX5_REG_VHCA_ICM_CTRL, 0, 0);
+	if (err) {
+		mlx5_core_warn(dev, "Reading vhca_icm_ctrl failed. err = %d\n", err);
+		return;
+	}
+	cur_alloc_icm = MLX5_GET(vhca_icm_ctrl_reg, out_icm_reg, cur_alloc_icm);
+	devlink_fmsg_u32_pair_put(fmsg, "icm_consumption", cur_alloc_icm);
+}
+
 void mlx5_reporter_vnic_diagnose_counters(struct mlx5_core_dev *dev,
 					  struct devlink_fmsg *fmsg,
 					  u16 vport_num, bool other_vport)
@@ -59,6 +103,8 @@ void mlx5_reporter_vnic_diagnose_counters(struct mlx5_core_dev *dev,
 		devlink_fmsg_u64_pair_put(fmsg, "handled_pkt_steering_fail",
 					  VNIC_ENV_GET64(&vnic, handled_pkt_steering_fail));
 	}
+	if (MLX5_CAP_GEN(dev, nic_cap_reg))
+		mlx5_reporter_vnic_diagnose_counter_icm(dev, fmsg, vport_num, other_vport);
 
 	devlink_fmsg_obj_nest_end(fmsg);
 	devlink_fmsg_pair_nest_end(fmsg);
-- 
2.45.0


