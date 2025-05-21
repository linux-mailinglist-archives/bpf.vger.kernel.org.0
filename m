Return-Path: <bpf+bounces-58654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFCABF3DF
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 14:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CCB4E1C19
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B026B959;
	Wed, 21 May 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AhEHjJRo"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276002676C9;
	Wed, 21 May 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829439; cv=fail; b=UYUNHsz03N3eGGBvXunc7l6NiRvZEVw8aba/Zs01jvgLhQzJ1N+DNVNGO9rAOeFci/j3OB+u0zyASGqc7bQ/Te4FLdxULa84shJaNVMNfDDcs2WgcrEku73br3zwm/TKJKSW3pQ/a7lGU+zupQKk67McgLvqYTqUX0rSR3IhYoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829439; c=relaxed/simple;
	bh=cMOGa0k6VC5c/RIcAqQsGu03YSP/AF21k524egpdoMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddH7eljg1ivM8foTUrAizZj+4akkkjIlCBfuVG4YFUK/DkZcaW9Mnpz+N5wb9L4MuVfgEeICn/IO34ypeMCQi9VUmVIihOx/hCQQbCjPZ1K+ZKQr5sFEP8HkTWUSN5nNeXtQUCx9ezLZKYaTT6TxcElGYbfkz+mlCuQaYUtP4/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AhEHjJRo; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T04qKx/YKDdPmd664Go7xr+4dj2cc6qYlSWOS+A/VqekS9JwudqCDakwpg82TmLljRMd1klSNFYolw0meywqGl0K0yPC3may+DZrjFLctUkM0633ty0nVhUsiH751/BMQJ8lMFkbjq7iLw3Pf/ALkCafuuclOswhcDQWnHfcdv7S8DGWQDcALGETRjTPT780drDBHzIUA4pbMiiqE0jf3TBDHkNU6QGGH6YwKeFer37vfO9U77jjeHnSBAO1hWCXv9tnJyJ75zemC4HkcbZb+qQ09YaFL+lyjlOl80Qdu9X1LRrEjVl95UrL6bZ2uDtH4VL+A0F1Ep6Y0m2U5ogC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5/YPWv0JZXMaFpwlhKhwox14+IksW3VTa2ylH5jCDE=;
 b=lGIU5kjKweRuDUONXjegyt39rRQWDOSdFX7SDMOLbJCSZrMXay+Wl0Co21KwVHPtbkBavd2LzCgUO+oZCNVhRumsTkS6omyzeSjF5RS03Mm4u4ikJXqstsuUeeUBn/ei5KgGJ/ds6Sxfj3kyhLx8G72WE99OQumdplcOQoBGpE0kcQezOP86l81db77FdWnip1ISsxYDVNXNXsf0HsPcBAdE1TVX+Hfn+GKcsgIQK+i/D0hJVOsQ/Z7y14BIi3vitqPOB1UaPdEkHuaq2xaaVGO6fhOzkSqgpvE+YlF9I9QOWu3grH/eKXiCMYWI8cBWcl5qrsfZS6MuISU8kkr0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5/YPWv0JZXMaFpwlhKhwox14+IksW3VTa2ylH5jCDE=;
 b=AhEHjJRot+pjQxAzFUd1k5FMX1gRhhm5ZLrSqsSL3T4HaChUE9/aVkZNl+vDSGXytC6HLA+P/ufddfOTVjnrupYQgCAwXqLmUMHb+549tITph4DwCArrXiE8QFYpihJLxCVRuVvwPqk0fQ4wH6MxC91JVXLjM6bFwFPJVQmR7yk1HQlrOEXDumJpg6oFUMFixfv8O5hSx333a1CxO7GLunYBFu3dO2kwJDfoLdT6D5gPQRbS/8PDjs6ockAj38cF6AZascq4QUISc3S74LjVlCK/vcqBMK0bGV+LH9UTulvb8MurFJHeyIM3hB7r8zSI+sHNKwPwS6NBZHwAZ6XbCg==
Received: from SJ0PR13CA0148.namprd13.prod.outlook.com (2603:10b6:a03:2c6::33)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 12:10:29 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::d5) by SJ0PR13CA0148.outlook.office365.com
 (2603:10b6:a03:2c6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 21 May 2025 12:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 12:10:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 05:10:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 05:10:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 05:10:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: Convert mlx5 netdevs to instance locking
Date: Wed, 21 May 2025 15:09:02 +0300
Message-ID: <1747829342-1018757-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e85b425-6928-4887-5bcc-08dd98607a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?91v7fhnpsXPzQIjnRSbybYzoUAVffHISpTBYxtM5wWCHdSRcfwN4/sliDc7e?=
 =?us-ascii?Q?keSr1CNtUkN4pz67wtYfJtbh6HAQzzb0vRvlUJSN6jtfkD1/ZMNLMLdlYk/E?=
 =?us-ascii?Q?1FI6tbdea6Yy5mcsroP/kUbzELjaABdqGhttTj3H8XcXHzUCs3XzEDVw2t2a?=
 =?us-ascii?Q?C65yjosD09lgMucPYsHeKWaESJ2FQa1fMars5UNXpYLgAViiJhfEfgpkwmJz?=
 =?us-ascii?Q?bnjRiNQf7fAvKc80PI9Sb+ho4+W8Sy18bGcuWSh4Oii4iTF6KiMBD+wCCxNR?=
 =?us-ascii?Q?UTB5OqGBgnxzaq5E0GlEUefHHLTh+X4gizbnnhXIjBANRWpZQUpwKZ1WrYJC?=
 =?us-ascii?Q?XjFbBng5RXYx7mjpVco00dTFTdqjGFqaupx7jnQFSdoHCNKnBvZvJK5wuB5Z?=
 =?us-ascii?Q?/gyHjNENgZpzms4QIGfc4iBDx2lB31qI3/QCj01pqKpq6TJ9Ll/norsgFU5+?=
 =?us-ascii?Q?5qnF+nnRhZ8wo8RaJTkrDvDzMnwYK6hULflgEtgGvlZHiDHU8nZxvBugj+ml?=
 =?us-ascii?Q?F5K/vzlYbhDbdDEX+TxWlkLPjTK/SH+98gHRdeidvhcAksB7OFhbl11GFEwf?=
 =?us-ascii?Q?Si9jTes8gP89ZQsxPdPwBtV1z+JMb+QFlkVJW662jy5qT/etBBXaEvLj3byT?=
 =?us-ascii?Q?/vZRG7WcEBfe9RMlXWK79d1rPhpqjBrS0q8VQWrKsFIMuP+dtuAVXawSI9xf?=
 =?us-ascii?Q?eb9zC+SW0XUxeEOLmfXiImQDIRA2+oWdKJ01MB0giKuguKgzalltbmO+egPk?=
 =?us-ascii?Q?Ffc07oYBpTvhDdaZhtbS4l5sPy7aIeSTaOu5xCtfHN2XPZWvnpvMWUiSIhgK?=
 =?us-ascii?Q?8Lb0PUdFcUEY/ForsUKZHjHf4+QkjUbAsmbbtnOPTC7ENCIyagZjjvZNcqsk?=
 =?us-ascii?Q?aPw2H53UMFCJ6PT/1EDo333VVCpx3Ybar/x+kkvUBcLXJHc+lXdX9J0bgitj?=
 =?us-ascii?Q?aHiC4VXV89jMV4uWsq94H164ZlZXmd1HATMhb57kiZAugx1aRwA/7rUbHYDA?=
 =?us-ascii?Q?uaOAnwrvbAHgUUmtMU4LaW0Q31DSSXCc8yNGzR8x6VrYYMALIOgWfIrLY5Kt?=
 =?us-ascii?Q?O5Z/XblkQlD1U0VIoS7L0JmLs9Jm4qZAJDb2N+KD+E5dHSD13fvXJO6mL8nL?=
 =?us-ascii?Q?Z6XCT0iOeiiF43zm/uBtprAh4wgjM3kzwyL+7R9BIKUOIf5b78f9Cr0E3hxi?=
 =?us-ascii?Q?dj4Q9ONFItFrDWxbJCYqwzuyjK8ScMxQXFxQRrmuQ68nDaOmWmL5LrieFKjN?=
 =?us-ascii?Q?adyUscERwDFcxvhHwi8S1Z7pH+3zAWo9MP6Nt+GNdhS0V5ByUfX1Pb1i9CGX?=
 =?us-ascii?Q?EHiuKHc/1/q+7NFYMRhmpeZ2GfHm2lmUxjEEIOGvB3QRgudQpuQBOkXNPkjc?=
 =?us-ascii?Q?KjH3VXHZBXSCFa7ZXIGCyIDaM+rXHHfD766kW/3UqKMr8uN+j2iV9F52OjXp?=
 =?us-ascii?Q?GtVlFtHbT4JMNj5gdqRSlHbOOXY0nPwWY2ulgFy2BUjmAmNVHFKO1Movltnx?=
 =?us-ascii?Q?0q4mUJgjQfXHGHigpQIzQ1OseQ0pr2pL+q3G?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:10:29.2341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e85b425-6928-4887-5bcc-08dd98607a4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

From: Cosmin Ratiu <cratiu@nvidia.com>

This patch convert mlx5 to use the new netdev instance lock in addition
to the pre-existing state_lock (and the RTNL).

mlx5e_priv.state_lock was already used throughout mlx5 to protect
against concurrent state modifications on the same netdev, usually in
addition to the RTNL. The new netdev instance lock will eventually
replace it, but for now, it is acquired in addition to the existing
locks in the order RTNL -> instance lock -> state_lock.

All three netdev types handled by mlx5 are converted to the new style of
locking, because they share a lot of code related to initializing
channels and dealing with NAPI, so it's better to convert all three
rather than introduce different assumptions deep in the call stack
depending on the type of device.

Because of the nature of the call graphs in mlx5, it wasn't possible to
incrementally convert parts of the driver to use the new lock, since
either all call paths into NAPI have to possess the new lock if the
*_locked variants are used, or none of them can have the lock.

One area which required extra care is the interaction between closing
channels and devlink health reporter tasks.
Previously, the recovery tasks were unconditionally acquiring the
RTNL, which could lead to deadlocks in these scenarios:

T1: mlx5e_close (== .ndo_stop(), has RTNL) -> mlx5e_close_locked
-> mlx5e_close_channels -> mlx5e_ptp_close
-> mlx5e_ptp_close_queues -> mlx5e_ptp_close_txqsqs
-> mlx5e_ptp_close_txqsq
-> cancel_work_sync(&ptpsq->report_unhealthy_work) waits for

T2: mlx5e_ptpsq_unhealthy_work -> mlx5e_reporter_tx_ptpsq_unhealthy
-> mlx5e_health_report -> devlink_health_report
-> devlink_health_reporter_recover
-> mlx5e_tx_reporter_ptpsq_unhealthy_recover which does:
rtnl_lock();   => Deadlock.

Another similar instance of this is:
T1: mlx5e_close (== .ndo_stop(), has RTNL) -> mlx5e_close_locked
-> mlx5e_close_channels -> mlx5e_ptp_close
-> mlx5e_ptp_close_queues -> mlx5e_ptp_close_txqsqs
-> mlx5e_ptp_close_txqsq
-> cancel_work_sync(&sq->recover_work) waits for

T2: mlx5e_tx_err_cqe_work -> mlx5e_reporter_tx_err_cqe
-> mlx5e_health_report -> devlink_health_report
-> devlink_health_reporter_recover
-> mlx5e_tx_reporter_err_cqe_recover which does:
rtnl_lock();   => Another deadlock.

Fix that by using the same pattern previously done in
mlx5e_tx_timeout_work, where the RTNL was repeatedly tried to be
acquired until either:
a) it is successfully acquired or
b) there's no need for the work to be done any more (channel is being
closed).

Now, for all three recovery tasks, the instance lock is repeatedly tried
to be acquired until successful or the channel/SQ is closed.
As a side-effect, drop the !test_bit(MLX5E_STATE_OPENED, &priv->state)
check from mlx5e_tx_timeout_work, it's weaker than
!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state) and unnecessary.

Future patches will introduce new call paths (from netdev queue
management ops) which can close channels (and call cancel_work_sync on
the recovery tasks) without the RTNL lock and only with the netdev
instance lock.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/health.c   |  2 +
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 25 ++++--
 .../mellanox/mlx5/core/en/reporter_tx.c       |  4 -
 .../net/ethernet/mellanox/mlx5/core/en/trap.c | 12 +--
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    |  2 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |  4 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 82 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  7 ++
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  3 +
 9 files changed, 96 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/health.c b/drivers/net/ethernet/mellanox/mlx5/core/en/health.c
index 81523825faa2..cb972b2d46e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/health.c
@@ -114,6 +114,7 @@ int mlx5e_health_recover_channels(struct mlx5e_priv *priv)
 	int err = 0;
 
 	rtnl_lock();
+	netdev_lock(priv->netdev);
 	mutex_lock(&priv->state_lock);
 
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
@@ -123,6 +124,7 @@ int mlx5e_health_recover_channels(struct mlx5e_priv *priv)
 
 out:
 	mutex_unlock(&priv->state_lock);
+	netdev_unlock(priv->netdev);
 	rtnl_unlock();
 
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 131ed97ca997..5d0014129a7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -8,6 +8,7 @@
 #include "en/fs_tt_redirect.h"
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <net/netdev_lock.h>
 
 struct mlx5e_ptp_fs {
 	struct mlx5_flow_handle *l2_rule;
@@ -449,8 +450,22 @@ static void mlx5e_ptpsq_unhealthy_work(struct work_struct *work)
 {
 	struct mlx5e_ptpsq *ptpsq =
 		container_of(work, struct mlx5e_ptpsq, report_unhealthy_work);
+	struct mlx5e_txqsq *sq = &ptpsq->txqsq;
+
+	/* Recovering the PTP SQ means re-enabling NAPI, which requires the
+	 * netdev instance lock. However, SQ closing has to wait for this work
+	 * task to finish while also holding the same lock. So either get the
+	 * lock or find that the SQ is no longer enabled and thus this work is
+	 * not relevant anymore.
+	 */
+	while (!netdev_trylock(sq->netdev)) {
+		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
+			return;
+		msleep(20);
+	}
 
 	mlx5e_reporter_tx_ptpsq_unhealthy(ptpsq);
+	netdev_unlock(sq->netdev);
 }
 
 static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
@@ -892,7 +907,7 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 	if (err)
 		goto err_free;
 
-	netif_napi_add(netdev, &c->napi, mlx5e_ptp_napi_poll);
+	netif_napi_add_locked(netdev, &c->napi, mlx5e_ptp_napi_poll);
 
 	mlx5e_ptp_build_params(c, cparams, params);
 
@@ -910,7 +925,7 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 	return 0;
 
 err_napi_del:
-	netif_napi_del(&c->napi);
+	netif_napi_del_locked(&c->napi);
 err_free:
 	kvfree(cparams);
 	kvfree(c);
@@ -920,7 +935,7 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 void mlx5e_ptp_close(struct mlx5e_ptp *c)
 {
 	mlx5e_ptp_close_queues(c);
-	netif_napi_del(&c->napi);
+	netif_napi_del_locked(&c->napi);
 
 	kvfree(c);
 }
@@ -929,7 +944,7 @@ void mlx5e_ptp_activate_channel(struct mlx5e_ptp *c)
 {
 	int tc;
 
-	napi_enable(&c->napi);
+	napi_enable_locked(&c->napi);
 
 	if (test_bit(MLX5E_PTP_STATE_TX, c->state)) {
 		for (tc = 0; tc < c->num_tc; tc++)
@@ -957,7 +972,7 @@ void mlx5e_ptp_deactivate_channel(struct mlx5e_ptp *c)
 			mlx5e_deactivate_txqsq(&c->ptpsq[tc].txqsq);
 	}
 
-	napi_disable(&c->napi);
+	napi_disable_locked(&c->napi);
 }
 
 int mlx5e_ptp_get_rqn(struct mlx5e_ptp *c, u32 *rqn)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index dbd9482359e1..c3bda4612fa9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -107,9 +107,7 @@ static int mlx5e_tx_reporter_err_cqe_recover(void *ctx)
 	mlx5e_reset_txqsq_cc_pc(sq);
 	sq->stats->recover++;
 	clear_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state);
-	rtnl_lock();
 	mlx5e_activate_txqsq(sq);
-	rtnl_unlock();
 
 	if (sq->channel)
 		mlx5e_trigger_napi_icosq(sq->channel);
@@ -176,7 +174,6 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 
 	priv = ptpsq->txqsq.priv;
 
-	rtnl_lock();
 	mutex_lock(&priv->state_lock);
 	chs = &priv->channels;
 	netdev = priv->netdev;
@@ -196,7 +193,6 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 		netif_carrier_on(netdev);
 
 	mutex_unlock(&priv->state_lock);
-	rtnl_unlock();
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
index 140606fcd23b..b5c19396e096 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
@@ -149,7 +149,7 @@ static struct mlx5e_trap *mlx5e_open_trap(struct mlx5e_priv *priv)
 	t->mkey_be  = cpu_to_be32(priv->mdev->mlx5e_res.hw_objs.mkey);
 	t->stats    = &priv->trap_stats.ch;
 
-	netif_napi_add(netdev, &t->napi, mlx5e_trap_napi_poll);
+	netif_napi_add_locked(netdev, &t->napi, mlx5e_trap_napi_poll);
 
 	err = mlx5e_open_trap_rq(priv, t);
 	if (unlikely(err))
@@ -164,7 +164,7 @@ static struct mlx5e_trap *mlx5e_open_trap(struct mlx5e_priv *priv)
 err_close_trap_rq:
 	mlx5e_close_trap_rq(&t->rq);
 err_napi_del:
-	netif_napi_del(&t->napi);
+	netif_napi_del_locked(&t->napi);
 	kvfree(t);
 	return ERR_PTR(err);
 }
@@ -173,13 +173,13 @@ void mlx5e_close_trap(struct mlx5e_trap *trap)
 {
 	mlx5e_tir_destroy(&trap->tir);
 	mlx5e_close_trap_rq(&trap->rq);
-	netif_napi_del(&trap->napi);
+	netif_napi_del_locked(&trap->napi);
 	kvfree(trap);
 }
 
 static void mlx5e_activate_trap(struct mlx5e_trap *trap)
 {
-	napi_enable(&trap->napi);
+	napi_enable_locked(&trap->napi);
 	mlx5e_activate_rq(&trap->rq);
 	mlx5e_trigger_napi_sched(&trap->napi);
 }
@@ -189,7 +189,7 @@ void mlx5e_deactivate_trap(struct mlx5e_priv *priv)
 	struct mlx5e_trap *trap = priv->en_trap;
 
 	mlx5e_deactivate_rq(&trap->rq);
-	napi_disable(&trap->napi);
+	napi_disable_locked(&trap->napi);
 }
 
 static struct mlx5e_trap *mlx5e_add_trap_queue(struct mlx5e_priv *priv)
@@ -285,6 +285,7 @@ int mlx5e_handle_trap_event(struct mlx5e_priv *priv, struct mlx5_trap_ctx *trap_
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
 		return 0;
 
+	netdev_lock(priv->netdev);
 	switch (trap_ctx->action) {
 	case DEVLINK_TRAP_ACTION_TRAP:
 		err = mlx5e_handle_action_trap(priv, trap_ctx->id);
@@ -297,6 +298,7 @@ int mlx5e_handle_trap_event(struct mlx5e_priv *priv, struct mlx5_trap_ctx *trap_
 			    trap_ctx->action);
 		err = -EINVAL;
 	}
+	netdev_unlock(priv->netdev);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 8705cffc747f..5fe016e477b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -1147,6 +1147,7 @@ static int mlx5e_set_trust_state(struct mlx5e_priv *priv, u8 trust_state)
 	bool reset = true;
 	int err;
 
+	netdev_lock(priv->netdev);
 	mutex_lock(&priv->state_lock);
 
 	new_params = priv->channels.params;
@@ -1162,6 +1163,7 @@ static int mlx5e_set_trust_state(struct mlx5e_priv *priv, u8 trust_state)
 				       &trust_state, reset);
 
 	mutex_unlock(&priv->state_lock);
+	netdev_unlock(priv->netdev);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 05058710d2c7..04a969128161 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -484,7 +484,9 @@ static int mlx5e_vlan_rx_add_svid(struct mlx5e_flow_steering *fs,
 	}
 
 	/* Need to fix some features.. */
+	netdev_lock(netdev);
 	netdev_update_features(netdev);
+	netdev_unlock(netdev);
 	return err;
 }
 
@@ -521,7 +523,9 @@ int mlx5e_fs_vlan_rx_kill_vid(struct mlx5e_flow_steering *fs,
 	} else if (be16_to_cpu(proto) == ETH_P_8021AD) {
 		clear_bit(vid, fs->vlan->active_svlans);
 		mlx5e_fs_del_vlan_rule(fs, MLX5E_VLAN_RULE_TYPE_MATCH_STAG_VID, vid);
+		netdev_lock(netdev);
 		netdev_update_features(netdev);
+		netdev_unlock(netdev);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9bd166f489e7..ea822c69d137 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -39,6 +39,7 @@
 #include <linux/debugfs.h>
 #include <linux/if_bridge.h>
 #include <linux/filter.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
@@ -1903,7 +1904,20 @@ void mlx5e_tx_err_cqe_work(struct work_struct *recover_work)
 	struct mlx5e_txqsq *sq = container_of(recover_work, struct mlx5e_txqsq,
 					      recover_work);
 
+	/* Recovering queues means re-enabling NAPI, which requires the netdev
+	 * instance lock. However, SQ closing flows have to wait for work tasks
+	 * to finish while also holding the netdev instance lock. So either get
+	 * the lock or find that the SQ is no longer enabled and thus this work
+	 * is not relevant anymore.
+	 */
+	while (!netdev_trylock(sq->netdev)) {
+		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
+			return;
+		msleep(20);
+	}
+
 	mlx5e_reporter_tx_err_cqe(sq);
+	netdev_unlock(sq->netdev);
 }
 
 static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
@@ -2705,8 +2719,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
-	netif_napi_add_config(netdev, &c->napi, mlx5e_napi_poll, ix);
-	netif_napi_set_irq(&c->napi, irq);
+	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
+	netif_napi_set_irq_locked(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
 	if (unlikely(err))
@@ -2728,7 +2742,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	mlx5e_close_queues(c);
 
 err_napi_del:
-	netif_napi_del(&c->napi);
+	netif_napi_del_locked(&c->napi);
 
 err_free:
 	kvfree(cparam);
@@ -2741,7 +2755,7 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
 {
 	int tc;
 
-	napi_enable(&c->napi);
+	napi_enable_locked(&c->napi);
 
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_activate_txqsq(&c->sq[tc]);
@@ -2773,7 +2787,7 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
 		mlx5e_deactivate_txqsq(&c->sq[tc]);
 	mlx5e_qos_deactivate_queues(c);
 
-	napi_disable(&c->napi);
+	napi_disable_locked(&c->napi);
 }
 
 static void mlx5e_close_channel(struct mlx5e_channel *c)
@@ -2782,7 +2796,7 @@ static void mlx5e_close_channel(struct mlx5e_channel *c)
 		mlx5e_close_xsk(c);
 	mlx5e_close_queues(c);
 	mlx5e_qos_close_queues(c);
-	netif_napi_del(&c->napi);
+	netif_napi_del_locked(&c->napi);
 
 	kvfree(c);
 }
@@ -4276,7 +4290,7 @@ void mlx5e_set_xdp_feature(struct net_device *netdev)
 
 	if (!netdev->netdev_ops->ndo_bpf ||
 	    params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
-		xdp_clear_features_flag(netdev);
+		xdp_set_features_flag_locked(netdev, 0);
 		return;
 	}
 
@@ -4285,7 +4299,7 @@ void mlx5e_set_xdp_feature(struct net_device *netdev)
 	      NETDEV_XDP_ACT_RX_SG |
 	      NETDEV_XDP_ACT_NDO_XMIT |
 	      NETDEV_XDP_ACT_NDO_XMIT_SG;
-	xdp_set_features_flag(netdev, val);
+	xdp_set_features_flag_locked(netdev, val);
 }
 
 int mlx5e_set_features(struct net_device *netdev, netdev_features_t features)
@@ -4968,21 +4982,19 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 	struct net_device *netdev = priv->netdev;
 	int i;
 
-	/* Take rtnl_lock to ensure no change in netdev->real_num_tx_queues
-	 * through this flow. However, channel closing flows have to wait for
-	 * this work to finish while holding rtnl lock too. So either get the
-	 * lock or find that channels are being closed for other reason and
-	 * this work is not relevant anymore.
+	/* Recovering the TX queues implies re-enabling NAPI, which requires
+	 * the netdev instance lock.
+	 * However, channel closing flows have to wait for this work to finish
+	 * while holding the same lock. So either get the lock or find that
+	 * channels are being closed for other reason and this work is not
+	 * relevant anymore.
 	 */
-	while (!rtnl_trylock()) {
+	while (!netdev_trylock(netdev)) {
 		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
 			return;
 		msleep(20);
 	}
 
-	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
-		goto unlock;
-
 	for (i = 0; i < netdev->real_num_tx_queues; i++) {
 		struct netdev_queue *dev_queue =
 			netdev_get_tx_queue(netdev, i);
@@ -4996,8 +5008,7 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 			break;
 	}
 
-unlock:
-	rtnl_unlock();
+	netdev_unlock(netdev);
 }
 
 static void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)
@@ -5321,7 +5332,6 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	struct mlx5e_rq_stats *xskrq_stats;
 	struct mlx5e_rq_stats *rq_stats;
 
-	ASSERT_RTNL();
 	if (mlx5e_is_uplink_rep(priv) || !priv->stats_nch)
 		return;
 
@@ -5341,7 +5351,6 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_sq_stats *sq_stats;
 
-	ASSERT_RTNL();
 	if (!priv->stats_nch)
 		return;
 
@@ -5362,7 +5371,6 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	struct mlx5e_ptp *ptp_channel;
 	int i, tc;
 
-	ASSERT_RTNL();
 	if (!mlx5e_is_uplink_rep(priv)) {
 		rx->packets = 0;
 		rx->bytes = 0;
@@ -5458,6 +5466,8 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->netdev_ops = &mlx5e_netdev_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
+	netdev->request_ops_lock = true;
+	netdev_lockdep_set_classes(netdev);
 
 	mlx5e_dcbnl_build_netdev(netdev);
 
@@ -5839,9 +5849,11 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	mlx5e_nic_set_rx_mode(priv);
 
 	rtnl_lock();
+	netdev_lock(netdev);
 	if (netif_running(netdev))
 		mlx5e_open(netdev);
 	udp_tunnel_nic_reset_ntf(priv->netdev);
+	netdev_unlock(netdev);
 	netif_device_attach(netdev);
 	rtnl_unlock();
 }
@@ -5854,9 +5866,16 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 		mlx5e_dcbnl_delete_app(priv);
 
 	rtnl_lock();
+	netdev_lock(priv->netdev);
 	if (netif_running(priv->netdev))
 		mlx5e_close(priv->netdev);
 	netif_device_detach(priv->netdev);
+	if (priv->en_trap) {
+		mlx5e_deactivate_trap(priv);
+		mlx5e_close_trap(priv->en_trap);
+		priv->en_trap = NULL;
+	}
+	netdev_unlock(priv->netdev);
 	rtnl_unlock();
 
 	mlx5e_nic_set_rx_mode(priv);
@@ -5866,11 +5885,6 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 		mlx5e_monitor_counter_cleanup(priv);
 
 	mlx5e_disable_blocking_events(priv);
-	if (priv->en_trap) {
-		mlx5e_deactivate_trap(priv);
-		mlx5e_close_trap(priv->en_trap);
-		priv->en_trap = NULL;
-	}
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
 	mlx5_vxlan_reset_to_default(mdev->vxlan);
@@ -6125,7 +6139,9 @@ static void mlx5e_update_features(struct net_device *netdev)
 		return; /* features will be updated on netdev registration */
 
 	rtnl_lock();
+	netdev_lock(netdev);
 	netdev_update_features(netdev);
+	netdev_unlock(netdev);
 	rtnl_unlock();
 }
 
@@ -6136,7 +6152,7 @@ static void mlx5e_reset_channels(struct net_device *netdev)
 
 int mlx5e_attach_netdev(struct mlx5e_priv *priv)
 {
-	const bool take_rtnl = priv->netdev->reg_state == NETREG_REGISTERED;
+	const bool need_lock = priv->netdev->reg_state == NETREG_REGISTERED;
 	const struct mlx5e_profile *profile = priv->profile;
 	int max_nch;
 	int err;
@@ -6178,15 +6194,19 @@ int mlx5e_attach_netdev(struct mlx5e_priv *priv)
 	 * 2. Set our default XPS cpumask.
 	 * 3. Build the RQT.
 	 *
-	 * rtnl_lock is required by netif_set_real_num_*_queues in case the
+	 * Locking is required by netif_set_real_num_*_queues in case the
 	 * netdev has been registered by this point (if this function was called
 	 * in the reload or resume flow).
 	 */
-	if (take_rtnl)
+	if (need_lock) {
 		rtnl_lock();
+		netdev_lock(priv->netdev);
+	}
 	err = mlx5e_num_channels_changed(priv);
-	if (take_rtnl)
+	if (need_lock) {
+		netdev_unlock(priv->netdev);
 		rtnl_unlock();
+	}
 	if (err)
 		goto out;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 2abab241f03b..719aa16bd404 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -33,6 +33,7 @@
 #include <linux/dim.h>
 #include <linux/debugfs.h>
 #include <linux/mlx5/fs.h>
+#include <net/netdev_lock.h>
 #include <net/switchdev.h>
 #include <net/pkt_cls.h>
 #include <net/act_api.h>
@@ -885,6 +886,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 {
 	SET_NETDEV_DEV(netdev, mdev->device);
 	netdev->netdev_ops = &mlx5e_netdev_ops_rep;
+	netdev->request_ops_lock = true;
+	netdev_lockdep_set_classes(netdev);
 	eth_hw_addr_random(netdev);
 	netdev->ethtool_ops = &mlx5e_rep_ethtool_ops;
 
@@ -1344,9 +1347,11 @@ static void mlx5e_uplink_rep_enable(struct mlx5e_priv *priv)
 	netdev->wanted_features |= NETIF_F_HW_TC;
 
 	rtnl_lock();
+	netdev_lock(netdev);
 	if (netif_running(netdev))
 		mlx5e_open(netdev);
 	udp_tunnel_nic_reset_ntf(priv->netdev);
+	netdev_unlock(netdev);
 	netif_device_attach(netdev);
 	rtnl_unlock();
 }
@@ -1356,9 +1361,11 @@ static void mlx5e_uplink_rep_disable(struct mlx5e_priv *priv)
 	struct mlx5_core_dev *mdev = priv->mdev;
 
 	rtnl_lock();
+	netdev_lock(priv->netdev);
 	if (netif_running(priv->netdev))
 		mlx5e_close(priv->netdev);
 	netif_device_detach(priv->netdev);
+	netdev_unlock(priv->netdev);
 	rtnl_unlock();
 
 	mlx5e_rep_bridge_cleanup(priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 0979d672d47f..79ae3a51a4b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -32,6 +32,7 @@
 
 #include <rdma/ib_verbs.h>
 #include <linux/mlx5/fs.h>
+#include <net/netdev_lock.h>
 #include "en.h"
 #include "en/params.h"
 #include "ipoib.h"
@@ -102,6 +103,8 @@ int mlx5i_init(struct mlx5_core_dev *mdev, struct net_device *netdev)
 
 	netdev->netdev_ops = &mlx5i_netdev_ops;
 	netdev->ethtool_ops = &mlx5i_ethtool_ops;
+	netdev->request_ops_lock = true;
+	netdev_lockdep_set_classes(netdev);
 
 	return 0;
 }
-- 
2.31.1


