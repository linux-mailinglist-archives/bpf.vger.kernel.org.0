Return-Path: <bpf+bounces-68007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EDEB51403
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF76483B50
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED431DDA4;
	Wed, 10 Sep 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qKI4JJlk"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AA315D59;
	Wed, 10 Sep 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500000; cv=fail; b=F0IiV7SI8orBWsBgLraTrtTMK5sFdd2tyLOEVrmpKEGS6HPJFIdU7vz3TC6SP+bAtWP727Na0HYebgjfErzlcWHH0Aded/EU2T0KihjylRLExnW82iUqDDsDwLeB4X2Y19pK+imJstXQ1u3LBHe9WOuDMTRo0xhT7GL8y+Peq+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500000; c=relaxed/simple;
	bh=drY0wh7vF8W7rwicJ2nwWCSRT+L4VtW88sxxNkGRCVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ls5rEwGGP4QaF+axFoh+8JJpk/7x49ZshaB3Qwi2cXI/VGtCj6qIxXCe8N5a/wv9652ddPGpLJS8MJrd97XSA2a51s4QtKxuO4sN5q37ha7R+RoUWqEw0A+8GzgIYaPBJznSFR7bLVpOAPFsiudeDlMJwaiQl5rXlmna+eqCXX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qKI4JJlk; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNsmjrJTkiOTGq92cxtsAR/Iz25aiguX2PylEgYelo7rk3zspNOA8BuERjO6qnPK1X6jvhVdyFvW8dW9zjPqDOmGCNqkUMcM7bj9EEp7rRz9a2mIZpFjbWLJwMB2WrRUNkWWx+9KCJ34g3cO4Vkp7ikHTAvrKdbSQUVKxTa9SRwOq/G6E7JSoGpKN+bwpMfl1DhtGk4PM7qrqFnIR+GPmPFCKZwl0huU49TuVS98hi11tHw1tqfZYnEut5luLU8JjdYew9Obk3+RnuRqymXgCNaSxNAS+yHi/YdCwKoH/2eb7MfW4Ujjne2vYxrfUfW0ulpNlT+/FWaUjn+xiqko8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF2upw563YS/vkETzj0l8V8bdeEftpbxwqTF5u3Pnbc=;
 b=kcwKxNRp8qTmXU1hdRoh0hOEBF04GoCwKhUqa/LfveVhGQRqSATkrJEN3w9oWuyxrSSUzHg6q937m3Xq2dMJy8ilF4wgaqd8yQGyBU/d9hb/nCvHSGPDIR7rqJMc/aq/MvPe4RydnD7pHyLeQlH/o5W03+1a7m09ycRpIp4fS/ppM2PGEPs2ON/nPiG6YQCMtqMv9NLL6LLMUs6g+2Re9uMtl6BwzvYhpQk3Ze3sMGfHNlAWw9oQTMxr/zkZEnCK07fnGO/Z6L7MAmo0kJz8s28EWaeSwA2+N0dNTJ6ocPtWllQqRyl8weOyukdYYFZBHj1KNMCQGfwaQnU4trBWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF2upw563YS/vkETzj0l8V8bdeEftpbxwqTF5u3Pnbc=;
 b=qKI4JJlk3YN8QFRZSd6EnOw3PjJKTmo/JijLjD5vb2pmRIB+q+2R7Y7cSy1HgrN4eONsxAk/Tr1S6IYA/JHZTv3WeTC/PzFai2EZNoOxIFCLTYQandLzils6dYP98auxZMhkuuMugZTCzNV5+DFNSMq6/GrynpXBnC3UCHoWL6QceFfwxBuNEwhIYB85I2NGmKejcKxU0zfKkanJPWvVgBQFr42v33zeWIlsbQwee1SU11JOH70KyPrlYzL9xXmJSxFdibgJzjahCvXPQtPXRrFxGpH7bT+Qlx4GJSjIwTmSZ1pzjZOMmSonbsJyZkGgUaOXE8IWipzos35azqPEcw==
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by BN7PPF02710D35B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:26:34 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::77) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:26:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:26:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:26:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:26:02 -0700
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
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 10/10] net/mlx5e: Use the 'num_doorbells' devlink param
Date: Wed, 10 Sep 2025 13:24:51 +0300
Message-ID: <1757499891-596641-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: a06c17d2-9d71-48e9-81da-08ddf054846d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bzf6hY/+kRWpM/SMT0qWSo5n9X7OVJ/J97IJZfsuson+6+4L6lxKDu0F8LcY?=
 =?us-ascii?Q?IQlLU20bw206fAIeEED6DfHvmk18bUOtk/o51Sv2xTOYr4Wr/7FMjD1kXGtE?=
 =?us-ascii?Q?CNBXPSU9gc6f52KV8jv7RC6T/z5wRRTzezc13CuJZFSFW3mHxdIRWHDXE2Zl?=
 =?us-ascii?Q?sURtQ+tJKjK0Az7jpWMUe8DqNM2ZjM5cgP91j1jj105qRLNI1FZ+lnJ4sd7i?=
 =?us-ascii?Q?RyKBzo/eUXQaJSc1m7RupGQvwOErJ8Dxw/H1jaC5Jd2y030Ec19lZObQOcP/?=
 =?us-ascii?Q?q2x9TjvhVaZVHDunLj0ZGeZUc5f9Jx66yaPE+di1NHJRr/ilQBOjtREAt0fb?=
 =?us-ascii?Q?T9oy+c1pueopeMXAHRawwXPBD10uuEku2wOcTIhDxBtsVePAt10G1Ofhof3X?=
 =?us-ascii?Q?XAT0EY0pAgLaAO0cZG8OWCV3I9qN9cwqwKsc868cyHcZPL+dU51HpD8oXwK6?=
 =?us-ascii?Q?eOsHm9r7qh5n5HIozFJ8BzlAB/B4KDEohkPs/Rv8iwIfp1VKgdmjmeSraI8K?=
 =?us-ascii?Q?++0yNoXnHfAWi3Jh8ukYxfaumnkVAvJ5P62vTHt+i1DQXqsZUEyp/Yy8cRun?=
 =?us-ascii?Q?56nJQRUdoZAg0utCQVpB8pULgJASwyqdU8r2j/9CSFy4GBZBnNa9+xbJJ/7L?=
 =?us-ascii?Q?BDJJMSA81bEZJinNO6WbPtSNnjk+FO1dbT/+H+7ul4rEQVawiQu2SCn8HSYl?=
 =?us-ascii?Q?lVySxSENt9BU4pQG1DQpCrvfK/e45kBJ2+i5SS7PwhnzNGrt8aqAfqbnNSJZ?=
 =?us-ascii?Q?c7wyuu1EmUo2hVeffQ8MeQcpLw+EItD16rYPvVwbpIDloL13HvpENFfCzyd4?=
 =?us-ascii?Q?jcLb35LKhQKY4Ezs15ofk1UnjZ/jB3Nwc4TsBl7nNoRcrpg4w3Xnfl3+Nik4?=
 =?us-ascii?Q?SwxwdgJ0Rk6bqOTQmpiwEGbOyBAR4B0h5VlPZpNAu5Y8c5BfnNhxdAYq79UX?=
 =?us-ascii?Q?K2g1dxxFNO/cQzqNLn6zWdDjQtlTevVZ+L8q3oB/LjWejfYcwMB3DEvZgJ2G?=
 =?us-ascii?Q?pNIEkhjkkrrDZzkRm3zsCkRP7tq00ZLGgr/FdV7gm6mMlwU3HnHnb8PaLWsv?=
 =?us-ascii?Q?mt2dR5HF517ESX29TqMrAB3pfoKvtdB58HIrgo2GRJTlXuHXEHuQBi+//Scd?=
 =?us-ascii?Q?DW8rHYteUIk2Oyt9sLocZ+6u3QV5Zyi8EvQAAtx9A0OUPsuo5+T1xXfSKAN5?=
 =?us-ascii?Q?2QaD3Vrkov8OhHODaWXkwjkfU+8dJynm3IC5SeRMxB5GwUN6YvSvxLDjg7Fp?=
 =?us-ascii?Q?Bo9uHsRdsvBq3Hwd+uPlBq43LQMkBaAdBkbxdo/8w3y7p7j1FTEl1iVO+7N2?=
 =?us-ascii?Q?5tGtNlpDn3kkOy+DulZ2pLtoE8TkuJ3tpUbenztIOiupaFCCxEoOHre6GUKj?=
 =?us-ascii?Q?0CzY0JRKJSuvYbqPc3OVjiPHXqKTmQ32RzfimbHPb+oYjgqHZ46hQpEjsY1d?=
 =?us-ascii?Q?5+9Pc4tH6ieUnYKCXoUbaFgbuF5k4rrbF2I2zTd/a9r5ROGFmKysxfkR1zzQ?=
 =?us-ascii?Q?4u7C2geWCV2Vd9iRN7Y/mpF91Riih12rX3Ar?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:26:34.4079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06c17d2-9d71-48e9-81da-08ddf054846d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B

From: Cosmin Ratiu <cratiu@nvidia.com>

Use the new devlink param to control how many doorbells mlx5e devices
allocate and use. The maximum number of doorbells configurable is capped
to the maximum number of channels. This only applies to the Ethernet
part, the RDMA devices using mlx5 manage their own doorbells.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  8 ++++++
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 26 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_common.c   | 15 ++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 60cc9fedf1ef..0650462b3eae 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -45,6 +45,14 @@ Parameters
      - The range is between 1 and a device-specific max.
      - Applies to each physical function (PF) independently, if the device
        supports it. Otherwise, it applies symmetrically to all PFs.
+   * - ``num_doorbells``
+     - driverinit
+     - This controls the number of channel doorbells used by the netdev. In all
+       cases, an additional doorbell is allocated and used for non-channel
+       communication (e.g. for PTP, HWS, etc.). Supported values are:
+       - 0: No channel-specific doorbells, use the global one for everything.
+       - [1, max_num_channels]: Spread netdev channels equally across these
+         doorbells.
 
 Note: permanent parameters such as ``enable_sriov`` and ``total_vfs`` require FW reset to take effect
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index a0b68321355a..50b8cc9bc12b 100644
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
+				       "Requested num_doorbells (%u) exceeds maximum number of channels (%u)\n",
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


