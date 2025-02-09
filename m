Return-Path: <bpf+bounces-50895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21397A2DC47
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9633A73EE
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE41C2DB4;
	Sun,  9 Feb 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WJoMrI0B"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED241C07F3;
	Sun,  9 Feb 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096396; cv=fail; b=InoBvzCDXLuQu7MrdOgMDabmVOdcVlfWzG91+ekIVpnxvookZJuNVkfWA1pnTxWgdG69Q/x3bcBCWN8FK3IqV1odV2cppuqtMj+Nqwjv74un42XKVkXZHx3p5esU1rLhP4z2zf+Uq4WF+qHpY74+TPr7Cas48HPVpwk5AO2lg4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096396; c=relaxed/simple;
	bh=Rsq8cRevFqQ1dJakWbjsVUxOtgZa1ITmNleLJt3RSck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omGHI9dmMUiEuuv9ayuUh4RfvsVB2W6TiaBpQhdIHFjoJXTIk+wWj5xW7ObEIbMN+93UZ2EQpkvyM0Isf4Iy1pypFByPvMC+LwE830jHb3A0rkC6PNQkX4B/VVquvhjUjQjvdNwRB3DkyhH+mq+NVeB4GA5FpJxjTN4wKvpL6wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WJoMrI0B; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deeKuLUExF7y998/VvJmX2VwQugnE653EO6oUfDkoZHPr6oSod4Ka/BwHP42hqP1TDzpBtXwlIUzTz3vm1OnZ91W7WnTuGTK1MBTjxwZILDpJG+V7FEKik8joR1aysEMC0hENvSV9BTHOqrNifLDsJbYcW0D6Krg30avLMlGWw5dQoTiz1JfQAbkQHMZlOt6mrmBWW1vIb9Ih44Hyj/oNLS/1p0bSKnYCt+MWyx+yAClkbhuy4YByPSaEO9D77iM0ZpFQgL1hz9yXYRGYapB6Vh9gXTsz6gRb7sGAJjS1GPIhrUJb6aYQrF72/ZMqAIpJ0s7V9CDoT8rwJF6Nhh8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL0VxAaoDRj3cc8vIfPy+cK8eZ5xb2P6nRX4zgoWc5c=;
 b=o5BqKObhM/fu2hkX1TLSHMOapHQ6794bvJ0J4EtwmH+Ag2kgMKc7KtfBX/TGNpgnzf45fWZQ0dci4ipI7+UmGbQD98tATsyboX3p4pFzl+xSXsC53AXO6X3ieFkTvtG+Xm+sz6pQJvOf+YSLdgj6x5jfvw6ONm09D9kajvR8BxIgJnFllnad4yFNsGw3nljz7fK6txVAIYclBmGFFMpbmzMcEYBPpqI0gL+42Y3QfkPnuhr+g4TuGqKHndRneOa4fDlVWcoPJtp+UU1f6jcp69jr9Ba+XBR4hESt3qknwcJ0Nhh5umsS9jmKlwedBa/tA/O6iVEC88srLCDNUE/qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL0VxAaoDRj3cc8vIfPy+cK8eZ5xb2P6nRX4zgoWc5c=;
 b=WJoMrI0BwV2j844GpgrWou7o5tadn5TfEqwACwgYckWH6yrPuWBOH/5rQfR1VbgT/OarofHaCqL1PzDS/VkZEqGhp5X+9e9u/uEb9edunBDSoFrIPSASMsJhOTDzoKRRcq2ZyUM3v0biKYR/mv00n3M8ZdrdNWYhxUj9I7uk8VufPR+sKuL3MHUbfGClDoe4x1h1Bi6skhPy4JuCDoNbEfN1GP/IE/X4/9butZLWTyJKNvJ64FXCwiAB5HdRpJV8dBLEfDwEbQraIQv4gF+3nfTeQGuGiZHXUtZItPcvz+mjdNXP0RY6mI30h3GHWcL8DSwR2iHI5s2YhmBhCiGU6g==
Received: from SJ0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:a03:333::18)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 10:19:50 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::46) by SJ0PR03CA0103.outlook.office365.com
 (2603:10b6:a03:333::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sun, 9 Feb 2025 10:19:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:44 -0800
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
	<bpf@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>, Aya Levin
	<ayal@nvidia.com>
Subject: [PATCH net-next 11/15] net/mlx5e: Move RQs diagnose to a dedicated function
Date: Sun, 9 Feb 2025 12:17:12 +0200
Message-ID: <20250209101716.112774-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3711b5-8129-4713-e6f5-08dd48f3493d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PtFl8iUnfNO+nayXkmYoZZ7vzMnU22+MsgqbiUN09LufV90bW0FxRS74685d?=
 =?us-ascii?Q?dEE9CN5RpM3yNeUu6wY6z0+INA2hrYYTEgpBwPBbKmsJqCxokiQ/GEROy/YK?=
 =?us-ascii?Q?0CZ7mU/WJaU+XxDGbKrA0SEVxQCpQHSN7XuxIZOtudc3ksFCdP0F4QbYXrVn?=
 =?us-ascii?Q?46H4lZHyKFWVBCtsJ4XY201kyqRMraXPQeW7rMkSW0B4qejbS+yUBIFJcbKR?=
 =?us-ascii?Q?j+C9rve+izjGgzGhFpBaxgACKH/bNXNeyCmGYAFkpuBvemhPFMGxs0hWaOGz?=
 =?us-ascii?Q?QWR+nXCc/3xKE+eTE4conXceCfPdLb+kjcqnpbnFgNEpp8+blj8T9M8e6VTC?=
 =?us-ascii?Q?hTCetjxhN9qp3b1LOg7nyQrK6mny0Z5hiuwyuodvKh71HAcpvDZG3qRJ/zOK?=
 =?us-ascii?Q?ME0qgkW0++PTn1cLVZa6D0XXR4ikrYU9/39xXHbKVaR9zHWP2mkgEpF1qyjI?=
 =?us-ascii?Q?qjFBD7tLCvJ1bGCYiPLXrSOVEhnqVcfHgrT+7kpLGZ4uTiiTA/tyudp6djIw?=
 =?us-ascii?Q?ZwbE2RDXZTzEE/AmXbWrXOpngj7UxMvb5tMYKpfPuzUzlZsMANVTvqVabtm7?=
 =?us-ascii?Q?vxOXj8PbSPKpQw96D6uOZsYs7bH2tuAvSl5BwOyYGRNhzn+9yQfJUvKuC8hO?=
 =?us-ascii?Q?5isrAqMlvuI5IPuH4VYcDTCS8MJr/tqNWPWMvUGStUpmeG+K3p5gbb8mjrp3?=
 =?us-ascii?Q?pCtRqa/dYlBepDXgYeom9Z25k9ztNmnOjgNXViJVRsTPwFKSIilhfYmlF5+s?=
 =?us-ascii?Q?6eoML4kel63qPBuw7Zp2UUYiLMaCjRG0ep/83fu+hIu7JQVoUJawXwLF8Whz?=
 =?us-ascii?Q?dm5cgUjfYtYODjTTbM34JFoYQslQ3boyYxY5lgfdWxZZ0g/M06kR+9gN3aQq?=
 =?us-ascii?Q?emNuYLKzur3kMIfAeScHOckHge0xdwmhM436pAmOiupdK3SkJvSe/A8YMWLD?=
 =?us-ascii?Q?3ulcYVlcB6jSsp43eFj4M/IV4g6H/g4yCTjJEPLXUiyGhGgt67BfOq6OyXZc?=
 =?us-ascii?Q?R3gDKykD1iKrTXZRPn7NkIq9tMh6VEd/N4hCXC2PsDlSQUP4egL2OTj3vTwc?=
 =?us-ascii?Q?jMCUQa+GttjJhV2Lu9DoKD9NkYeeRmqIkGTdoTNilV+2QwZMl+VIwD5/jNl/?=
 =?us-ascii?Q?VQyvwxwSQfvdea6hI7LHYncxX2yM3zUwrr9hB9wlz/ZZk6jABdXighmyPKt0?=
 =?us-ascii?Q?zenJqdu6oW9pR523IYM+u0nQdHOGQSllNS93Nu2X3BfvQHQ8G8CzozdF/Nmc?=
 =?us-ascii?Q?WBXd5998UoDLCwFuMioheLJlvO2I8j3/mwLrkx5r9ZmzEl44po3OXUc3/3bo?=
 =?us-ascii?Q?pm7MB+Rg0Xcx1s7ZikINjba/uD98tcUQY/vKUd8PsHvoraO61GDw5If/eRhj?=
 =?us-ascii?Q?ASMuPNFTS1L2Xge/cLmzh62lGCN5/o0mFlRsE+6O1m76XP6ZzqPe2xK8MhDv?=
 =?us-ascii?Q?69EPZpUfxgarzT8aI3zxtubNT6RPnNravZIQhHD+tM/nB/GvbrAQ6SPP71KU?=
 =?us-ascii?Q?MWjgYF5tXwdu1gY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:49.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3711b5-8129-4713-e6f5-08dd48f3493d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

From: Amir Tzin <amirtz@nvidia.com>

Move rx reporter RQs diagnose from mlx5e_rx_reporter_diagnose() to a
dedicated function. This change is a preparation for the following
series which extends diagnose output for the rx reporter. While at it,
also pass a mlx5e_priv pointer to
mlx5e_rx_reporter_diagnose_common_config() as this is the argument the
latter actually needs.

Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/reporter_rx.c       | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 25d751eba99b..9255ab662af9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -317,10 +317,8 @@ mlx5e_rx_reporter_diagnose_common_ptp_config(struct mlx5e_priv *priv, struct mlx
 }
 
 static void
-mlx5e_rx_reporter_diagnose_common_config(struct devlink_health_reporter *reporter,
-					 struct devlink_fmsg *fmsg)
+mlx5e_rx_reporter_diagnose_common_config(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg)
 {
-	struct mlx5e_priv *priv = devlink_health_reporter_priv(reporter);
 	struct mlx5e_rq *generic_rq = &priv->channels.c[0]->rq;
 	struct mlx5e_ptp *ptp_ch = priv->channels.ptp;
 
@@ -340,20 +338,11 @@ static void mlx5e_rx_reporter_build_diagnose_output_ptp_rq(struct mlx5e_rq *rq,
 	devlink_fmsg_obj_nest_end(fmsg);
 }
 
-static int mlx5e_rx_reporter_diagnose(struct devlink_health_reporter *reporter,
-				      struct devlink_fmsg *fmsg,
-				      struct netlink_ext_ack *extack)
+static void mlx5e_rx_reporter_diagnose_rqs(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg)
 {
-	struct mlx5e_priv *priv = devlink_health_reporter_priv(reporter);
 	struct mlx5e_ptp *ptp_ch = priv->channels.ptp;
 	int i;
 
-	mutex_lock(&priv->state_lock);
-
-	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
-		goto unlock;
-
-	mlx5e_rx_reporter_diagnose_common_config(reporter, fmsg);
 	devlink_fmsg_arr_pair_nest_start(fmsg, "RQs");
 
 	for (i = 0; i < priv->channels.num; i++) {
@@ -367,7 +356,23 @@ static int mlx5e_rx_reporter_diagnose(struct devlink_health_reporter *reporter,
 	}
 	if (ptp_ch && test_bit(MLX5E_PTP_STATE_RX, ptp_ch->state))
 		mlx5e_rx_reporter_build_diagnose_output_ptp_rq(&ptp_ch->rq, fmsg);
+
 	devlink_fmsg_arr_pair_nest_end(fmsg);
+}
+
+static int mlx5e_rx_reporter_diagnose(struct devlink_health_reporter *reporter,
+				      struct devlink_fmsg *fmsg,
+				      struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = devlink_health_reporter_priv(reporter);
+
+	mutex_lock(&priv->state_lock);
+
+	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
+		goto unlock;
+
+	mlx5e_rx_reporter_diagnose_common_config(priv, fmsg);
+	mlx5e_rx_reporter_diagnose_rqs(priv, fmsg);
 unlock:
 	mutex_unlock(&priv->state_lock);
 	return 0;
-- 
2.45.0


