Return-Path: <bpf+bounces-50896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AC2A2DC46
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B0F18870D5
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5BE1C54BF;
	Sun,  9 Feb 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAQTAPTk"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513071632CA;
	Sun,  9 Feb 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096402; cv=fail; b=gGQbqg8tmJ8zmdtvx2tPfoLWhdLkYG8c26nnRvAuJMkPILWvLuZOmj4/k/6Nt84E7EM9Jjwtg8C0/7eXnIQO9NtoqnNWNf0orhlNNgNhNGb/o6/UD7rQK1J5d44SO08yRibOgyGsvQpb84K1FK84+IEVncR2dTsGdUprYujuBko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096402; c=relaxed/simple;
	bh=8yxiMWQrM/4YsFWl9P5Cf1xj9cskLAhWehgNwQmkJAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DO3n2ITd4nq+oWusrTQRMpIpmtwvbaGgdoJueF3P8Zi9APseFbMn3zhi7hTsqintSpoAbqwjsm0j+f4iFQjc+ZzZRMRfsosFbDxBoX9pD2hXaVl8+NkNiyYaBV6t9YXDWfWYsu1EgpPo2FUGa31XZa9DasA4nuPmqfkdzq1hqdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAQTAPTk; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjheUbLeZWPdFhGafdXpxzyNxr9vSThRgBhxb4mT6stxX1kOM/ANqurVrbJtOIM1QWEmvmSq40E2DKoVAH0gV3UZv1KmNuiS5eGqTXzMOFkqm8lOs5KG37UneJ6Y2smmQdJVzUmEMR5CereLiBRo4o26h00KxwxTlaSc5OeQPovvWtgeajOuAm62kD//sTD2XY54U/wEpwHNAANF5gigseJFwbj7W+DVsQKzSbDukJ8VP78Km9Y4v5fX7S4YoGPw5lgzYpS5j3DBk26Q5Q3lpDnQJlREVRBkjKc8J06+9CDqKhMCl6Ih+dFxrQN19vCY/xFohDO/ZwFRcWd6yKgmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+pBSAJWrUyVPddSTLcqC8g6AQVKZkYAzdB5JH7FPZ0=;
 b=D6bcVpQyyjU6tsk7ana99gWy8ii/if81WJjKiuH5nbLxnllWZDhJnWpph3X+5kSk/yKB9tg8Th9363OFOqax0p9xu35iPBrRgofGykeQBFqU673Y61Ve4CUZVXgNJd8zcTC34v3JaWkDfLPJydpmt/U+uPtKmjdd0P8ZgFC45i0wAjegj/OLLUBV9+0h8bxIW49SkTQd/ymTjSvPX7L6nJvM4tOo/+IxBfrH4qsAUbaaD0PZK4PEkziYnK+6ocQ195Wz7dijcI2URM61CuVGR6OrFXrkL/E40p3qF0ShHUdzYHrOzleTwc30SAhtVez9gu15vZogLuJ8vrzlfBkawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+pBSAJWrUyVPddSTLcqC8g6AQVKZkYAzdB5JH7FPZ0=;
 b=iAQTAPTks+Bo0ODeBfPFig4TfC8xebeN0wnWUWhQfqF7SeIHLCUMpxjvWnExtUi3GTpUZC9oe4mj5JT1dNeGvX/8aO1j6I9XhQ/W6AO+NABC9Ewo+GKpfHjF6e8TerVEwch/0Z1SkLw6oobdoEd0he594sNQB1sUDDlsIbXlYJDKm5wByOtC91qBZGz8QWJR/COCMFgi09mA5EwlmWHgf+cS/6MCSz4bosBwbCeP71pv9IWnHlvVLj96BYzE9OKNhLHVBV9aK0VfqGGPgdacvbH/4t/rFjqlHGEhDkXKTYrtxDVQ2ab8kCBdfY+m2N5TBWcdz6YgWiYyoBdpkqHQkQ==
Received: from PH8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:2cf::6)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sun, 9 Feb
 2025 10:19:56 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::d2) by PH8PR07CA0032.outlook.office365.com
 (2603:10b6:510:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 10:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 10:19:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 02:19:55 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Feb 2025 02:19:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Feb 2025 02:19:49 -0800
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
Subject: [PATCH net-next 12/15] net/mlx5e: Add direct TIRs to devlink rx reporter diagnose
Date: Sun, 9 Feb 2025 12:17:13 +0200
Message-ID: <20250209101716.112774-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f9041f-2c68-46d8-a218-08dd48f34cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SsyLwBcfLiIhqceJ1FKZfJA9nPry+nZfJucn1/+EKpyidFZVGmwG+k668Atc?=
 =?us-ascii?Q?WKdLenERtdc1d2ciVXoVn6Jl0lksAB0vVxVIFnfFLzQ5D60RywE54F9Rv7v8?=
 =?us-ascii?Q?HtBxdose49sn66kuYJUpbHa0t/3hEUaHDDsQhTGCoYiviw86/rkA899SaQwl?=
 =?us-ascii?Q?rQRM8SAdUM4wldrDoeDq67LlBSQ5OfAMnhOMQeEK3RgcQxbhGpxW2+MZBpko?=
 =?us-ascii?Q?FpTD5vKqlkXJMuTDhTxW3wCpxdxATU0OdLg0IXDqqpI39PsTawvROVRwxb01?=
 =?us-ascii?Q?J+SbuoE//jVQjTUSGIknusVRRls6Ubf5zCFUfJX20JNN9N7U9l+029Y7fncD?=
 =?us-ascii?Q?Mn/HwrGuulwD7bN3oH/AWBJXS30Zlbbee12Gfr0kkf4n0IH+Yn3Gz/VUQ6mX?=
 =?us-ascii?Q?2z1lIT9dZ9LYc3bNB/y8N5srcMJsNMBqciylRCJE+oDM4k0akNg6YvrEFTpK?=
 =?us-ascii?Q?AWsWtMA790tS5sogAkS0RPWv/SnO1UvCHmVAw7brqxwBwoaXKHfuCInFLQge?=
 =?us-ascii?Q?Eke089Gal+i2EtbMSokFO4fi7Bf071S2hk5GVLAnyVh1bRJJpaApVOL9A9Br?=
 =?us-ascii?Q?gCecDktjWSPoqjW86rPcyMCY9kd7ortLklEqZVUFO0d9hMeLDF/mqeSbz7M3?=
 =?us-ascii?Q?p2yq93PLOxDdmxAgIvWOGvJi6kIvJv9K96SCnEmE9WfbP7QfS7vA9HaNOjV9?=
 =?us-ascii?Q?uQEtNAAtRPoue2m2SJEh2wOldeGVVFK2qu+O+VztdkKx+n6M5MfELj9MhZ6t?=
 =?us-ascii?Q?DgndZ7OrG7O3WmUq6wmCASjnoXrc+/QyP+qtnxoPBKNfUV9qPrMYu7dk1BSc?=
 =?us-ascii?Q?V1OgTPn7fY6LdrQN3oFSwUIGp82fcZsuqC6L+KQ8Mu99rCCCG1rdA6yZstSH?=
 =?us-ascii?Q?TUeJp1psFpZI0VZBFGNGETacsoHM084aNF8n2DBR5iitaDyedCFwQMZoV/oC?=
 =?us-ascii?Q?zhtCPoLGhfzkN9laUUTch1U7rOP+fpVGtzJJgSL/zOwpENFBbcRzJs/pSAKW?=
 =?us-ascii?Q?4vYK8XR3ISeV6rza7YjSbF/qbx/YGll1/X+5C+Yqkefywa8uCjnnGYhzAJlP?=
 =?us-ascii?Q?d1j3tdr8e7tWnYmDuay4q1FNzcRLOuzVz3WOxLVY1ExiFgjRvzsIE6tg7pAF?=
 =?us-ascii?Q?j26wZ9Q7h3WRNvWPgBeRZGeWMxU4syrZoaXijoKjwFkJmZsHEY4TkdcN72AR?=
 =?us-ascii?Q?MuLJ2gIpjUYpnI58L/83kJVWaMzWtO5dlcPzQ2U4PSTrQB+6rCwU8aHBNH4Q?=
 =?us-ascii?Q?CnoiZu/xxOysI673POBPNaS3ZMxIcJJJ85eKa31iMVfHXBKdBUYB8XBlL2Ud?=
 =?us-ascii?Q?w4OlelNc80lR2sPApUSoYQZ9BmezLLjwCyZrFNWATVjJG9v8esXjrVEF/kLM?=
 =?us-ascii?Q?NzwVAz7MgMI5KbU1D6B1v/cKFB/ivB/FY7gQlT68WbSgiTTE4hrFiwwa/Ym2?=
 =?us-ascii?Q?yew3zofWIzcxn1eKWpiIafky/Ir9asfrn4fYfv3OPtXb2/FbGnJMHBLdXlsm?=
 =?us-ascii?Q?Q8dJueFtP9jNThs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 10:19:56.0229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f9041f-2c68-46d8-a218-08dd48f34cf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

From: Amir Tzin <amirtz@nvidia.com>

Add "RX resources" tag to the output of rx reporter diagnose callback.
Underneath add tag for direct TIRs, for each TIR expose its tirn and
the corresponding rqtn.

$ sudo devlink health diagnose auxiliary/mlx5_core.eth.0/65535 reporter rx
 ....
 rx resources:
   Direct TIRs:
       ix: 0 tirn: 20 rqtn: 1
       ix: 1 tirn: 21 rqtn: 2
       ix: 2 tirn: 22 rqtn: 3
       ix: 3 tirn: 23 rqtn: 4
       ix: 4 tirn: 24 rqtn: 5
       ix: 5 tirn: 25 rqtn: 6
       ix: 6 tirn: 26 rqtn: 7
       ix: 7 tirn: 27 rqtn: 8
       ix: 8 tirn: 28 rqtn: 9
       ix: 9 tirn: 29 rqtn: 10
       ix: 10 tirn: 30 rqtn: 11
       ix: 11 tirn: 31 rqtn: 12
       ix: 12 tirn: 32 rqtn: 13
       ix: 13 tirn: 33 rqtn: 14
       ix: 14 tirn: 34 rqtn: 15
       ix: 15 tirn: 35 rqtn: 16
       ix: 16 tirn: 36 rqtn: 17
       ix: 17 tirn: 37 rqtn: 18
       ix: 18 tirn: 38 rqtn: 19
       ix: 19 tirn: 39 rqtn: 20
       ix: 20 tirn: 40 rqtn: 21
       ix: 21 tirn: 41 rqtn: 22
       ix: 22 tirn: 42 rqtn: 23
       ix: 23 tirn: 43 rqtn: 24

Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/reporter_rx.c       | 32 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  7 +++-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  2 ++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 9255ab662af9..bb513a22dc66 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -338,6 +338,37 @@ static void mlx5e_rx_reporter_build_diagnose_output_ptp_rq(struct mlx5e_rq *rq,
 	devlink_fmsg_obj_nest_end(fmsg);
 }
 
+static void mlx5e_rx_reporter_diagnose_rx_res_dir_tirns(struct mlx5e_rx_res *rx_res,
+							struct devlink_fmsg *fmsg)
+{
+	unsigned int max_nch = mlx5e_rx_res_get_max_nch(rx_res);
+	int i;
+
+	devlink_fmsg_arr_pair_nest_start(fmsg, "Direct TIRs");
+
+	for (i = 0; i < max_nch; i++) {
+		devlink_fmsg_obj_nest_start(fmsg);
+
+		devlink_fmsg_u32_pair_put(fmsg, "ix", i);
+		devlink_fmsg_u32_pair_put(fmsg, "tirn", mlx5e_rx_res_get_tirn_direct(rx_res, i));
+		devlink_fmsg_u32_pair_put(fmsg, "rqtn", mlx5e_rx_res_get_rqtn_direct(rx_res, i));
+
+		devlink_fmsg_obj_nest_end(fmsg);
+	}
+
+	devlink_fmsg_arr_pair_nest_end(fmsg);
+}
+
+static void mlx5e_rx_reporter_diagnose_rx_res(struct mlx5e_priv *priv,
+					      struct devlink_fmsg *fmsg)
+{
+	struct mlx5e_rx_res *rx_res = priv->rx_res;
+
+	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RX resources");
+	mlx5e_rx_reporter_diagnose_rx_res_dir_tirns(rx_res, fmsg);
+	mlx5e_health_fmsg_named_obj_nest_end(fmsg);
+}
+
 static void mlx5e_rx_reporter_diagnose_rqs(struct mlx5e_priv *priv, struct devlink_fmsg *fmsg)
 {
 	struct mlx5e_ptp *ptp_ch = priv->channels.ptp;
@@ -373,6 +404,7 @@ static int mlx5e_rx_reporter_diagnose(struct devlink_health_reporter *reporter,
 
 	mlx5e_rx_reporter_diagnose_common_config(priv, fmsg);
 	mlx5e_rx_reporter_diagnose_rqs(priv, fmsg);
+	mlx5e_rx_reporter_diagnose_rx_res(priv, fmsg);
 unlock:
 	mutex_unlock(&priv->state_lock);
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index a86eade9a9e0..4e301bb5e305 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -497,6 +497,11 @@ void mlx5e_rx_res_destroy(struct mlx5e_rx_res *res)
 	mlx5e_rx_res_free(res);
 }
 
+unsigned int mlx5e_rx_res_get_max_nch(struct mlx5e_rx_res *res)
+{
+	return res->max_nch;
+}
+
 u32 mlx5e_rx_res_get_tirn_direct(struct mlx5e_rx_res *res, unsigned int ix)
 {
 	return mlx5e_tir_get_tirn(&res->channels[ix].direct_tir);
@@ -522,7 +527,7 @@ u32 mlx5e_rx_res_get_tirn_ptp(struct mlx5e_rx_res *res)
 	return mlx5e_tir_get_tirn(&res->ptp.tir);
 }
 
-static u32 mlx5e_rx_res_get_rqtn_direct(struct mlx5e_rx_res *res, unsigned int ix)
+u32 mlx5e_rx_res_get_rqtn_direct(struct mlx5e_rx_res *res, unsigned int ix)
 {
 	return mlx5e_rqt_get_rqtn(&res->channels[ix].direct_rqt);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 7b1a9f0f1874..391671b09c91 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -34,6 +34,8 @@ u32 mlx5e_rx_res_get_tirn_direct(struct mlx5e_rx_res *res, unsigned int ix);
 u32 mlx5e_rx_res_get_tirn_rss(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt);
 u32 mlx5e_rx_res_get_tirn_rss_inner(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt);
 u32 mlx5e_rx_res_get_tirn_ptp(struct mlx5e_rx_res *res);
+u32 mlx5e_rx_res_get_rqtn_direct(struct mlx5e_rx_res *res, unsigned int ix);
+unsigned int mlx5e_rx_res_get_max_nch(struct mlx5e_rx_res *res);
 
 /* Activate/deactivate API */
 void mlx5e_rx_res_channels_activate(struct mlx5e_rx_res *res, struct mlx5e_channels *chs);
-- 
2.45.0


