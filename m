Return-Path: <bpf+bounces-50891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFB0A2DC30
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC413A63E1
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513471B85EC;
	Sun,  9 Feb 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="geAA06AI"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB31B3934;
	Sun,  9 Feb 2025 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096378; cv=fail; b=PFB90g41VjDJM10s9sitmFpe1UHP59y+fehy6SBcKueHgYg1RETYWBBzv5QhbKYpf3N6y2ATe/Fwj6Bw7yNDPqOD1yX00jGWcjNGWa16Uhxdh+PbxtKcmwgzhGlrfs2IqegumThFcA2LMGEsAmd12B5Cmaad7JMMT/MJQvmBUe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096378; c=relaxed/simple;
	bh=TgQWt33rAOJBDd8PlXsSc4Gh/qR2QvwOgXOLeInwBX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQIr0ZsBU7A2Pw8OdBVH13uPq9BePkT/STs6/ASrGInQe8kSMfHo5SROqBhpwwtpUeGvaePiBuwLzlx1l8lE05Q6Gxv0ODAXP5+U0qtJ8j8+2kysL9edJHnZqpwDWemmJF4TAv9Trfbz26fzbdBP0YPv5Vk6EVJNqn/guXA3Sj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=geAA06AI; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/jBrRSfDvP+or1hqH/RHYgF0tyEWf6g/oXEDtO8GuzEdrR7V8KUx8W0Z9uueqMJ4Vqsf4/4D0REPoIECIEKJ5zITCjHR6niNY8ohEEQvngqm+R2HYlS/pbgeyZpwSIK0ay6mUkIwj0OL30GmhSqWaa4h7IxB9eGu1VmJVayaxn/oHSbvmi4QyEZBH5roeeUpkJjd7YzY8VOtJ88FP3k530MuTXzSLKR+h6/csljhK8jcBaymYRQi6Lp3T0lY+ePAhllYI6DtHzgtfxWzh/o6xHzK+cll8hhJQGXpD8YNLOnVcbD1qcubsnB8HjfKxupHM7I4YV7IpRsavZQ5p+vjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GWS5JXCsTWSTgDnmfyt4PME8KrCpmeWLMMhx44O+NY=;
 b=v3+kyk2dFbJOP+W/FOQTenzNndqkAiXdbxnuVJoJjf93DYMlQUXnkGj4iqnV/6AjTA3XGgfYd2WHrfz0KxU677kPCAcATJPTq7eA3gSPk35lKVXYOXsIjOVI250BYGkEUB/mQAK6IBX7SpA1/I01iR1Sdn2EeQ0tDEl/T1QgNhLrl52DSQqFu04LT2sS9Im9p5mX5XoiTb8DtiUP3rjRaAzuojytHKpj/dHAIA1O4k6NQjuQQnLWWG28uGaWDR52W2xCWdJRrN0PvzbtsfBdBYpwbFzmEZpr/Ukk336Yh/99I7hTP9QugsuAKssTsTNpEDEK3e41NzZP3lz+E2ByLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GWS5JXCsTWSTgDnmfyt4PME8KrCpmeWLMMhx44O+NY=;
 b=geAA06AIpcjIGs3KOuaMUMpwe5UhFqQ1lC0gxSlSnVJ1AdKLgQyTughz8YscuycK3G21XXNyinzy7Wdg2DYfJZRPl3wwwo8mLwJEjcgbf149wC0ynaB56FbXgSu9DIGqBQMGS7r9Ua3JoHX+3ooWR0VNobDqvNbdoudWZ3jFXhAIASb68XuA6gJTIyayGPdRNv0rU8+mDfEYUzI19jvBOqfN3vERRM6Ql+x+iQd701ONyKYmWmCrmLt6ECSGY/5v+6KLYLDhWQPJVcA48KFuD15zxGvXuHti24DG+mR+DKze0sp7S8Yh3sSjQQF+8ZZ6YZ09bZtfGFfsyeVEnmMsgg==
Received: from SA1P222CA0167.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::15)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sun, 9 Feb
 2025 10:19:34 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::fd) by SA1P222CA0167.outlook.office365.com
 (2603:10b6:806:3c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:19:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:20 -0800
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
	<bpf@vger.kernel.org>, William Tu <witu@nvidia.com>, Bodong Wang
	<bodong@nvidia.com>
Subject: [PATCH net-next 07/15] net/mlx5e: reduce rep rxq depth to 256 for ECPF
Date: Sun, 9 Feb 2025 12:17:08 +0200
Message-ID: <20250209101716.112774-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 652bce22-6188-4e1a-250a-08dd48f33f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjf8PseNISQ7QzEOXksMWrhZ8tORiueyRyp9nL+cx8RINL0WBaF8Udplmx/+?=
 =?us-ascii?Q?++wVv12uInSpTxPq16FltEftWZfuZJBcQcHvEgNIoAdWJ286gDZ0IlhMQVYp?=
 =?us-ascii?Q?4Glt+NAJE3AVhJlIYD8sXYIFIPAR6evQ2xm2H8jcxB6g/CegXoxR6ImNGeQC?=
 =?us-ascii?Q?Kcy1dpFzXCjO/2uLz3vk4Tn/oQEIGBoX+KsN9IukfkRkQynBWVINi3PRbfZR?=
 =?us-ascii?Q?SIntsJ0HNGKoxpJBNWv4pTScFSjxXGleUHbmdB1AiXqB1HakBOZxBYTqqwKS?=
 =?us-ascii?Q?zZKe80IlukyjKm6pOmAnsZxdsHQ3u6ykgzw6DMsm1gD4kmlS7/4lzyAjPuO7?=
 =?us-ascii?Q?yDmsoU07WIBXVabYR5fYI9b/M8N732nNa2QHbZL4oEYLkXc2UiiFUGQ3QOMZ?=
 =?us-ascii?Q?1NkjsWIlQs8xuaLHEeFUA0PjTTpaMXzK3RnkWZ3EoFoWjVfWpt8JmilnSq1/?=
 =?us-ascii?Q?5kSRQ5CJkgOw+8biLiU2HB5l+hUXHXkL4Rai3I8616Jdu7dZK7aA3HSqI+uf?=
 =?us-ascii?Q?SJwdQkfpsG+3GrPqd/r/BAct/3BonUKCI+jvg55z8PjzQ6RjQTA9sHC58Tl+?=
 =?us-ascii?Q?Me9zALCIV5YxmQGQ+u88JfXUNBH2mWMANhNk7JfzK69UBiBujFvuEWdUxgfS?=
 =?us-ascii?Q?9VCwFotWe/gdh1aL4uZIlLI1yxo/M50YXw0LEGk6VggNvrkrpDWFZb85+Ojc?=
 =?us-ascii?Q?dz1oGgC1c2vibrS5RhMYr0CvKHbPQ86RAleR8H16I5A7zA/hMtHryqxnqm8l?=
 =?us-ascii?Q?tumtEqblewXobn3emGaXAnRfSKWEozB2HOJQFnV8q/7abCyKkzYLWp/amKgS?=
 =?us-ascii?Q?35cPj6Vjv8fCHLTyeAbPMs6b/Qj8MhGpeDxGlXY2VJamAI4dhxyfa1XhDRj/?=
 =?us-ascii?Q?Gq/bMSinbLqn/MbdQvlbR5eI0SrwbVA6KazR2/bnPngfQYAYPbSuZFyX/Rw9?=
 =?us-ascii?Q?Mywl4I+rlwnaWDgjGfvw2iKljufw6hZnF6+tAGOPGcokKdehYksM0ZOIbS1b?=
 =?us-ascii?Q?naPW/vXFULeupUqTVWn+QMV8ZgmZxsRWk9mNrZgxjkZJ1WxjxiFq5ApDWKsT?=
 =?us-ascii?Q?E1YnbRLJZb1ZYlGUYQP5UM4rRxIDUBEiSijt9SUq7LleQqiluVnSU87muvPi?=
 =?us-ascii?Q?gGpuswZse2kq9mDz3QPmOHfVfUkdFIKOBIYpumz7o7r7fgWeW4IL7OW5oIN/?=
 =?us-ascii?Q?r6lLDGfm0DFhKu5bUfzv22OW03l04om0afOfkwFNBe2bmtzO7M2gryi3SWf3?=
 =?us-ascii?Q?U5IqXjIJq/utkHtRLekYbvF5rp9eMO7m3miOnV2y/fYXNAwLDuQQ9fIOz61y?=
 =?us-ascii?Q?5iRKPOdlynB1YfD0FM9Xu3VCMa5FoLVrxkyxLU5ZlMC9gQqc63GvG3vq8YiU?=
 =?us-ascii?Q?XMQ9aY6IHvQHXXgYzEShLmgd72BDRze56OAN7ZIjYEkBj2AP23vHR6+rzDP4?=
 =?us-ascii?Q?Zv/wf8rtS8ryBCKbL3+Kai5GO8jb3Tf1CzMkNdYazvqqTA29Y4NMVSYelk63?=
 =?us-ascii?Q?fHyhOfx2ZgC65Ew=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:33.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652bce22-6188-4e1a-250a-08dd48f33f92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

From: William Tu <witu@nvidia.com>

By experiments, a single queue representor netdev consumes kernel
memory around 2.8MB, and 1.8MB out of the 2.8MB is due to page
pool for the RXQ. Scaling to a thousand representors consumes 2.8GB,
which becomes a memory pressure issue for embedded devices such as
BlueField-2 16GB / BlueField-3 32GB memory.

Since representor netdevs mostly handles miss traffic, and ideally,
most of the traffic will be offloaded, reduce the default non-uplink
rep netdev's RXQ default depth from 1024 to 256 if mdev is ecpf eswitch
manager. This saves around 1MB of memory per regular RQ,
(1024 - 256) * 2KB, allocated from page pool.

With rxq depth of 256, the netlink page pool tool reports
$./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
	 --dump page-pool-get
 {'id': 277,
  'ifindex': 9,
  'inflight': 128,
  'inflight-mem': 786432,
  'napi-id': 775}]

This is due to mtu 1500 + headroom consumes half pages, so 256 rxq
entries consumes around 128 pages (thus create a page pool with
size 128), shown above at inflight.

Note that each netdev has multiple types of RQs, including
Regular RQ, XSK, PTP, Drop, Trap RQ. Since non-uplink representor
only supports regular rq, this patch only changes the regular RQ's
default depth.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Bodong Wang <bodong@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index fdff9fd8a89e..da399adc8854 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -65,6 +65,7 @@
 #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
 	max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
 #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
+#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
 
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
@@ -855,6 +856,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* RQ */
 	mlx5e_build_rq_params(mdev, params);
+	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
+		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
 
 	/* If netdev is already registered (e.g. move from nic profile to uplink,
 	 * RTNL lock must be held before triggering netdev notifiers.
-- 
2.45.0


