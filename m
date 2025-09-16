Return-Path: <bpf+bounces-68517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2BAB599C7
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F372A180B
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3FA3314DE;
	Tue, 16 Sep 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="salepO/2"
X-Original-To: bpf@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429732F764;
	Tue, 16 Sep 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032024; cv=fail; b=K0Q2eAFtZ0TRqAc5pineTbN05j51od/0XCMOI/Z99pb+SNiHWJBQO8FQGaA3yvWLNA+G4kj5V8kQZ+VWlbjz97HXNulbJSe3Q2oUVlhdPlhcMWPWSwQYHxMGIj+Q8VyRHXFQyUbBu5pZq73vLY275+FvZfpoM2Znw85z+bGMrjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032024; c=relaxed/simple;
	bh=g2UsnAoFM1uGSxHLVD1b+TM9SdLskAGHhu7TWbueCp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEMFj1/RB/Fb1M1Un54a2xkP3v/ss74kqTAG1CCgCQNtQhuJEgASauL7XC4VkT674Zr4TTNj4CzB9RUqBAC/Q8lY8KICpwly78BUzF1Nhn1tv76GQhjw1/2N2fvB0A99pOx3bf4/YzwBaQfdc10z09fOw4i/r2lzd302jR0+NOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=salepO/2; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNS6YmF/LST/9sVSLIYwi4CpFPjXLiZUrjMmEX+czhbQX+OAJIQK6pVNqqKSYXb1VMukYqFq4v4NGZmJ/1YucqvtYHZbNyEq3vw6kGFtTB6DgW0uVGsk3+qLN4xD2NZpVpTzqSubttAwoxQL0b6pmOGt5xLbU6qeqGjnraxF/T/8XjBKqANhjj1w1enjNpy+Blt3Duwm055xMR2SwRw4Bcl+P1p6a3YzoIkwsz6+d9lsExTyIAN6ooDyHAlVa5yc3/W0DBy6DPDKiQ36b0S4XN76w4AomVIs6e5akNGhyP9ssxfDWKBlZy+DraUP7/rw68ilVe3L3NboU7ABj+ucfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4emDy4wWg40kPhpe+Y0WaPzCvtL0iyUKGiWhT3HX2sw=;
 b=tQ1EytX7n8T4n1bnG0zYJ5har4DD4+nz4n21lLu7Q97g7iqI5VitFaLccKlUmXSRMJy0GDchoDF4Wlxcpj653zJHIwtDVf9FLkKCBautuAo8IF0DMBCLedmm0le6p3zLN1DfvumijQVL+0cyuHPwii0v45bHm/BmxdmrsM5QAAF3iO5vJdi8i2nXPCgU9AGoZI8zSZFGhlKdkVca9AfXu7Wi6fqpVzxjJgEPvG1nhQWybbfavIw0TZfZTGf5zS/yuWxDgWZJFlISq5Nbdikcq1a/TG4w4cFmoL8zfJFC3Rg4ZVBEhWJkyTYxHnkB0kIM7ZCBZ8GQRaauFSg5GoHp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4emDy4wWg40kPhpe+Y0WaPzCvtL0iyUKGiWhT3HX2sw=;
 b=salepO/2o4Zmc1i2dwY5QtdLSCY1SVuGhd2sb0HC9Hm7BjhpvhGZvNNk+4TDiwPXS8PdNheo8rT3sMI0RVoNtjhxa2zkEUT2F1DMpal0HLH+tPgZl6Yw3yuGrthFpY6lkJkNazLnXBu2rJAf+AO+Fr1cv57aDYpZ2Vw1JIwlreO3oz3BhjsEHqnMShbUC0KisEjBGAbHgzfHayapPbtFd+OUd3IwXtGH513U2ns5wO3E1WZdUELXb9fgyfI9WDKlDzt04UwASp/QakhVEVxdlHMMDfyKDAhOiwVr4dgecxGA9KwKaE+YVPyXm6HHuFQfLg6OUJDC0qsPl+Vp867ypw==
Received: from CH0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:610:119::33)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 14:13:35 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::11) by CH0PR03CA0378.outlook.office365.com
 (2603:10b6:610:119::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 14:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:13:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:13:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:13:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:13:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH net-next V2 10/10] net/mlx5e: Use the 'num_doorbells' devlink param
Date: Tue, 16 Sep 2025 17:11:44 +0300
Message-ID: <1758031904-634231-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 229de53d-6546-40eb-137a-08ddf52b398d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wG+DLEIUjCic/K9qAln3+RmkVqNuEf5TCizD+qXuJOBblbmE6ZWMXGsV1Ldh?=
 =?us-ascii?Q?5AQ3tMZi40sKz4gMVyZ15mwFsNb3N38jUKiEsxJr2GWxUAy5BfFY4fStgVZY?=
 =?us-ascii?Q?geCl8SkSI3Ck9f/akTr32bkpndE+hME0I9pFpRiieIk/KqZioADvUb7bc/Rm?=
 =?us-ascii?Q?h6bZxclX15abXHlmiF9BOPI/xMcun1anzCUdQMvlE1nKvhrXy60VhpfxFC8a?=
 =?us-ascii?Q?JuOLjmeMZ21DIPPtr2xkcfm4Ac4vjtdeYBpKUwX5SKGn373y43d0UEgRXuqE?=
 =?us-ascii?Q?mIPJ9sM/053++P1UW36eG0hIwQi03gIredk8zNxMKXkhOf0FeDrT4ZMsOUZt?=
 =?us-ascii?Q?BDfp6b9EeM4PcVxrcrxzux95CC/hPQiM19oyX3GzxckJ4dULNCwkzIswVuSp?=
 =?us-ascii?Q?o5I2Pw2ozpMpVrJCW2zypj5oYtnFDS7jnr9hLaUbjWubgT3fFhaACXBP0fy8?=
 =?us-ascii?Q?CPR4o1xw/0p3XP5q59Kk32WoFtNeEbtKcZra8y8fRfC2ASGKkxbF6u71Zmhm?=
 =?us-ascii?Q?6zzkVxLH9g0vWlHwDYlurLIdC+Ny1PeG8MEW96fIatCDoxvkRFEdI/smb+ye?=
 =?us-ascii?Q?5+u32xoFvIAdrvE5dang6VZTko+C6XJiPMNJfyrpVZG0lUpIkazAWnVd077F?=
 =?us-ascii?Q?RGDuED3C+vgW78PhbF4dB7MIFvvgq0Q8UwWao49ddHSlza3N4m75BaA+t/+m?=
 =?us-ascii?Q?b4nPEyb/HJcjPlF48CtpLhsNhuu1qQ+qCTatnY6XVTxzb7bszSm60tg1VCaa?=
 =?us-ascii?Q?s+2VZNMJtT+Yj3z0Y5u3W93x6maFSJX0S3Y0R4WsT9wreiZdtf5Ag2U0eXzD?=
 =?us-ascii?Q?j8YMfcmpr7od0WQS/05aqv3870AX/9WmwJ92qd6lr4LHwI8Q9qtzbRLkcAgY?=
 =?us-ascii?Q?wJL5lABLOsky1WlRFStam2F+G+nM73EquAf7PDby6cjEYKFArThDiZmTXU6E?=
 =?us-ascii?Q?VcJP3ENGwmOZxdOfB+NJxnF3Z5gC4S1osAX23Dw0WvwyNZc3RyQuqI45NOOK?=
 =?us-ascii?Q?EZiCZTT07tv0nTamOwUNudsxcDdSL3WjtKKtj/V/EzAnby8qDOLRXT1OwB1r?=
 =?us-ascii?Q?d2hylpbGW2Ae7zE44TJ8cYYDU8n6pUe1eMrH+cQsDpelG9B9RsDdvSpaEaG8?=
 =?us-ascii?Q?M2sDa2xmZOE79M64v1p+u8u7lYRKqdvGht1F0J54LnAfLDn+cbKUlJz7ep98?=
 =?us-ascii?Q?o/Wcuq4jJISdJQCzniROIG60ZsAVmSdGBaZOicDD6M8Qwkca91hsFb07ICpa?=
 =?us-ascii?Q?gPTVakwTCiI6xHAkFmbRa2CT4H4b/uCEgDRvVDY/si8jRy7ZrvPVAZPjE+1w?=
 =?us-ascii?Q?PFVlKSyJiyP1cWix33gzMie5cv7fDCZSGvlekZgo8g0yRLpNbhCGwoQRTCYC?=
 =?us-ascii?Q?1mU7BrSVvWUVWKamqCJB3dg7/ovXz0ZY9KeaowWc10bsuQJej1CTyK+MUS8Z?=
 =?us-ascii?Q?Hi4+Vm4iAmJD9frEy0ZhpHlD/BJwTs1YPD6Te8QUQpXGb4QUZDbbEmi/TfAt?=
 =?us-ascii?Q?/t8VCKfA4DEglmJX4TVcih8O2VeIzL4pEKkF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:35.2794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229de53d-6546-40eb-137a-08ddf52b398d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

From: Cosmin Ratiu <cratiu@nvidia.com>

Use the new devlink param to control how many doorbells mlx5e devices
allocate and use. The maximum number of doorbells configurable is capped
to the maximum number of channels. This only applies to the Ethernet
part, the RDMA devices using mlx5 manage their own doorbells.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  9 +++++++
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 26 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_common.c   | 15 ++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 60cc9fedf1ef..41c9b716699e 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -62,6 +62,15 @@ Note: permanent parameters such as ``enable_sriov`` and ``total_vfs`` require FW
    echo 1 >/sys/bus/pci/rescan
    grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
 
+   * - ``num_doorbells``
+     - driverinit
+     - This controls the number of channel doorbells used by the netdev. In all
+       cases, an additional doorbell is allocated and used for non-channel
+       communication (e.g. for PTP, HWS, etc.). Supported values are:
+
+       - 0: No channel-specific doorbells, use the global one for everything.
+       - [1, max_num_channels]: Spread netdev channels equally across these
+         doorbells.
 
 The ``mlx5`` driver also implements the following driver-specific
 parameters.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index a0b68321355a..bd4cb8861218 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -535,6 +535,25 @@ mlx5_devlink_hairpin_queue_size_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int mlx5_devlink_num_doorbells_validate(struct devlink *devlink, u32 id,
+					       union devlink_param_value val,
+					       struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *mdev = devlink_priv(devlink);
+	u32 val32 = val.vu32;
+	u32 max_num_channels;
+
+	max_num_channels = mlx5e_get_max_num_channels(mdev);
+	if (val32 > max_num_channels) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Requested num_doorbells (%u) exceeds maximum number of channels (%u)",
+				       val32, max_num_channels);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void mlx5_devlink_hairpin_params_init_values(struct devlink *devlink)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
@@ -614,6 +633,9 @@ static const struct devlink_param mlx5_devlink_eth_params[] = {
 			     "hairpin_queue_size", DEVLINK_PARAM_TYPE_U32,
 			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT), NULL, NULL,
 			     mlx5_devlink_hairpin_queue_size_validate),
+	DEVLINK_PARAM_GENERIC(NUM_DOORBELLS,
+			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT), NULL, NULL,
+			      mlx5_devlink_num_doorbells_validate),
 };
 
 static int mlx5_devlink_eth_params_register(struct devlink *devlink)
@@ -637,6 +659,10 @@ static int mlx5_devlink_eth_params_register(struct devlink *devlink)
 
 	mlx5_devlink_hairpin_params_init_values(devlink);
 
+	value.vu32 = MLX5_DEFAULT_NUM_DOORBELLS;
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
+					value);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index d13cebbc763a..96b744ceaf13 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include "devlink.h"
 #include "en.h"
 #include "lib/crypto.h"
 
@@ -140,6 +141,18 @@ static int mlx5e_create_tises(struct mlx5_core_dev *mdev, u32 tisn[MLX5_MAX_PORT
 	return err;
 }
 
+static unsigned int
+mlx5e_get_devlink_param_num_doorbells(struct mlx5_core_dev *dev)
+{
+	const u32 param_id = DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS;
+	struct devlink *devlink = priv_to_devlink(dev);
+	union devlink_param_value val;
+	int err;
+
+	err = devl_param_driverinit_value_get(devlink, param_id, &val);
+	return err ? MLX5_DEFAULT_NUM_DOORBELLS : val.vu32;
+}
+
 int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 {
 	struct mlx5e_hw_objs *res = &mdev->mlx5e_res.hw_objs;
@@ -164,7 +177,7 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 		goto err_dealloc_transport_domain;
 	}
 
-	num_doorbells = min(MLX5_DEFAULT_NUM_DOORBELLS,
+	num_doorbells = min(mlx5e_get_devlink_param_num_doorbells(mdev),
 			    mlx5e_get_max_num_channels(mdev));
 	res->bfregs = kcalloc(num_doorbells, sizeof(*res->bfregs), GFP_KERNEL);
 	if (!res->bfregs) {
-- 
2.31.1


