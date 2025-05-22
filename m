Return-Path: <bpf+bounces-58762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70EAC1612
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE671785CB
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6925CC45;
	Thu, 22 May 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SZK25Nks"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8925B66D;
	Thu, 22 May 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950177; cv=fail; b=UAZDcbjfOxl1Ov525gggDGLpvGxXvQdZtcFVNOlXxQzFIK8qMCx9Kg9RuHBfewyUkCrPdxkpLOa34PSqtBKDP751b5h93rEx5To5oriitbq+B4npvSQDNOPubPNEVVxEf8ay464WozmINyY1WEP6eGTRocwaY68Dofdc++vdv2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950177; c=relaxed/simple;
	bh=8AZjHu+NzxnrS4Z/nNIB922Y2jfkdoZ2eoMBnCt4kAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRjBcJu6hj0N6uFL2eIz9feJSvHbC+ak0QlRf8oFCJWRisufgzQsQnEUmBNR3QfXTARUS3K9VJRO5UGl54UXg2qVvPglQ265TrH+U23Wztyu0Le8T6HCp6wN5OmS+aFU2kPRccwXrkTA1Md5/sGCdSIaquFMvjqQ3Sdxc6j46zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SZK25Nks; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxQaN0WJPOmRv6uJ9zImF+kaUiI21z3KTfaJHgtz4n5ZU89PcrhXRwjsQp1RQHH1Zm/yLl0I9KKz88AL/6m4hWR5zjTQ2w64cmsV917CWPEIrNIA3MeiRVkEYws1f0tt8hEmnlOqKx9mjLKnFZ+yFpZ1VsCjzwjW7dMyF1IBgXN5L8+OjBXlrVdiJGHTyPn5iF91eIMaqBX6drNV3hZEVZmp2XEZwI/jOLBBIuWZYYKmZAiIdulsBzH3fDusmM3bgePiZQbq6gcSOWbsECdZRA4opSjhGKmvgANUT4avDAk5n5KuDz8lSEqbxtidzH+yltjznhbtYIoGeFWd9Aundw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4eQ6+2bOVtNQj9s1X34a0NGz695fBFWkQnHbDqXy7I=;
 b=vOfr8sXFXG2tcg9sgtWtVXGs982R81Jv5RawANc6aBf7f6v/IKY9ULl8uxWWdQwYbr98lUqlkaktwlh7AVP/yhYcEmW/vdF9KWOmKFLvKJyZiPeJS56Z1EkrFOEiYLeDqDsjO+osK81ZifG2CGtEZ+Np8g1iwxc3CYBaRg6Dh4fwbN6ghRS2ZDh2cW3avF53xzK3F1lvPzkxfvBWzfuxJqJVX0wSXN2AuwPJWv40aBXs7Qs7eLioSGkXghz39AC19rzooMARUu+3LXQIiXxx/Y4YjNnhBN64vThwos8GkTNvplpXTghrX1Tb0ZjBS3Ru0W540rBDPKGmUj+N77LLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4eQ6+2bOVtNQj9s1X34a0NGz695fBFWkQnHbDqXy7I=;
 b=SZK25NksSh6dHcHj+ufTrQSekbI0gnqC61YydTdISyN69Dfy2G7aBSttC+h/WWLOJqZMN7A5XQSLJg/eolLwTI3UhWzcA9VbM4z3zVDX1zE3V1wjB2XEsWdwtard/xkd1rgPvlg5hZ22ShWJPbE1tNL4VHXK4+15vxUJ2iUcpFA8OPuZtkupIvmJpnMgE+yKAaJDdBZqUFi1QUL2i66vKlFBaWKGZTmxbAZ0HLRpp03/63LKpksU0k/GS6/ASPhlYoZ+BhgbHofAnYpE6j47rQtpWWeBU0u3HkjjzDJnOkCAdnSe2lME7ygy4hEn/hlyLMitWMQt0J7qGk4KwvssNw==
Received: from SJ0PR03CA0085.namprd03.prod.outlook.com (2603:10b6:a03:331::30)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:42:50 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::c1) by SJ0PR03CA0085.outlook.office365.com
 (2603:10b6:a03:331::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 21:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:42:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 May
 2025 14:42:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 22 May
 2025 14:42:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 22
 May 2025 14:42:30 -0700
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
Subject: [PATCH net-next V2 04/11] net/mlx5e: SHAMPO: Remove redundant params
Date: Fri, 23 May 2025 00:41:19 +0300
Message-ID: <1747950086-1246773-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 2921db6f-9569-4841-2246-08dd99799963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+exwTjtTyav2+dO4KtIDDTsqC50okMKOeAWMVr6//Q8Z78W0dLoyPAX8y1A?=
 =?us-ascii?Q?MzMvUBLr3byTukqzw3T5JZRz+dUab7F1PL5rzOStpqLPYeFM1IDJVRdftYMi?=
 =?us-ascii?Q?IANvQgBcjLxMUsTtGzKihFIK+6gJ5vTbKtpTo+cp1K/HplhrPye2kaNZx9qB?=
 =?us-ascii?Q?nxH3or0aO9OlWXBDJ31Ns66Zwszx7sDPsZ9N87k8p+NH6o3Nq169nU2ytr/G?=
 =?us-ascii?Q?VCKAzsQ54lOOvlvaQrkmtSZHEfZeLlCS7xJJ2qEfSyl8XeT8jzB7UdMdSiro?=
 =?us-ascii?Q?YUdyqIkYv1iVOdFVxBjamE8NYC7PvtEv/y6njqssid45LPiaEU6YHszKWQRD?=
 =?us-ascii?Q?jsmMLEKm1QvYdk53gHbkjyS35ULrKE4hHwMP4bDASFLVN7oukk9MNuOZfbpx?=
 =?us-ascii?Q?sxixkxcSWqKhzA9yzEm4D+5jHGF+EyU/KSw0qzPtciTotyjtZFLrqCCVmy7N?=
 =?us-ascii?Q?idulDdgVGbw67d49Pqhjvc6bJyNTfudMYiulXfNd+H83uHwDuQ6YStpCtfjg?=
 =?us-ascii?Q?olK82axRiynlSZOCHkPcIccrKiu9d/+F8tNMlCiH1mCGRVN3gOoawuW0nYFG?=
 =?us-ascii?Q?ApDrbxUWF4DuGG+5U5ndRZAGfrIVVw/PRoUERtk2g3s2Kt6R1xCRmVFoTAu9?=
 =?us-ascii?Q?eId9I8n3DAWNoLiGkHiByrdvGACw+gVG3Bp3yD3vn2o/SFic7nz0mKXBc5BM?=
 =?us-ascii?Q?TKoqkGyGxDv8iU1m9tTfmE1qjyuXht+M3oK8GjNUaKEPc6FTnrgkTn5g3AeZ?=
 =?us-ascii?Q?hRvMOX7DzFw391P05uzE2WHlBI7diO74WMTeXONny6izgW2+9HM4JXWU/45a?=
 =?us-ascii?Q?s3guKGGYEmGTXAsC0D9OPrnz/Ud1p7zot9AvDPUY36ylNwuJBPABSbNWSUT0?=
 =?us-ascii?Q?moRMbooBKlexvg630ZwcSPD/N6rA1poEYYqKq7t+Un9MQrqJsDP52r6JTwdc?=
 =?us-ascii?Q?FchfOf6ghgyqdp0qVxgrMrdDaxMyUavA5aynfGUX7FAgK8MMVwB6dbCuLAWu?=
 =?us-ascii?Q?TJPLpKn5xugjzrKPp4XUSfeWIgIGBRaOjrWpSF2tv41ABPhmmOe6Y7bgkLSU?=
 =?us-ascii?Q?Ojx2kExJsKYFkKL+ySUMbR+wovlJv3fMd5SJKPW6272Z23ScdWlYpJUghOPO?=
 =?us-ascii?Q?V0LwI09OWZazBQKIK4Uwf/X9+sWAMizONED6rK/QEN+D3Gs22+SO10CIZ0CM?=
 =?us-ascii?Q?x4uidlTa76kbTmHSZQ4zPjL1cIR4XTzUC6R0rpspYc1fpkQvRudPSk02erQD?=
 =?us-ascii?Q?NsHoDLoeCAOzYldwM5VIQMQMj+68u3+cZsv8ldOfnlNpLeEyXDLKRs9r5s3q?=
 =?us-ascii?Q?I8DQ+202VDMkr5cJXZi9/+G1m0VHfSBqdRcWM88HnahkVyTMcjqXtsQ+Ef9y?=
 =?us-ascii?Q?K3elL2DDSkBrTwItbYlUGVswNeYvNVHi6SaTYhvWWoWEJii50sJZX2/xE4fN?=
 =?us-ascii?Q?i2B4Bti0wUqxvBLxzaIlTv4fqJznkOIts6xe9T9o1/t8mkOWwkvN4hsDO3pO?=
 =?us-ascii?Q?eRqIftn3COLJJyzze3cQ5fPVt0j1HhdIoVI+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:42:49.9105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2921db6f-9569-4841-2246-08dd99799963
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

From: Saeed Mahameed <saeedm@nvidia.com>

Two SHAMPO params are static and always the same, remove them from the
global mlx5e_params struct.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 ---
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 211ea429ea89..581eef34f512 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -278,10 +278,6 @@ enum packet_merge {
 struct mlx5e_packet_merge_param {
 	enum packet_merge type;
 	u32 timeout;
-	struct {
-		u8 match_criteria_type;
-		u8 alignment_granularity;
-	} shampo;
 };
 
 struct mlx5e_params {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 58ec5e44aa7a..fc945bce933a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -901,6 +901,7 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 {
 	void *rqc = param->rqc;
 	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
+	u32 lro_timeout;
 	int ndsegs = 1;
 	int err;
 
@@ -926,22 +927,25 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 		MLX5_SET(wq, wq, log_wqe_stride_size,
 			 log_wqe_stride_size - MLX5_MPWQE_LOG_STRIDE_SZ_BASE);
 		MLX5_SET(wq, wq, log_wq_sz, mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
-		if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
-			MLX5_SET(wq, wq, shampo_enable, true);
-			MLX5_SET(wq, wq, log_reservation_size,
-				 mlx5e_shampo_get_log_rsrv_size(mdev, params));
-			MLX5_SET(wq, wq,
-				 log_max_num_of_packets_per_reservation,
-				 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
-			MLX5_SET(wq, wq, log_headers_entry_size,
-				 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
-			MLX5_SET(rqc, rqc, reservation_timeout,
-				 mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_SHAMPO_TIMEOUT));
-			MLX5_SET(rqc, rqc, shampo_match_criteria_type,
-				 params->packet_merge.shampo.match_criteria_type);
-			MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
-				 params->packet_merge.shampo.alignment_granularity);
-		}
+		if (params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO)
+			break;
+
+		MLX5_SET(wq, wq, shampo_enable, true);
+		MLX5_SET(wq, wq, log_reservation_size,
+			 mlx5e_shampo_get_log_rsrv_size(mdev, params));
+		MLX5_SET(wq, wq,
+			 log_max_num_of_packets_per_reservation,
+			 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+		MLX5_SET(wq, wq, log_headers_entry_size,
+			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
+		lro_timeout =
+			mlx5e_choose_lro_timeout(mdev,
+						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
+		MLX5_SET(rqc, rqc, reservation_timeout, lro_timeout);
+		MLX5_SET(rqc, rqc, shampo_match_criteria_type,
+			 MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED);
+		MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
+			 MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE);
 		break;
 	}
 	default: /* MLX5_WQ_TYPE_CYCLIC */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3d11c9f87171..e1e44533b744 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4040,10 +4040,6 @@ static int set_feature_hw_gro(struct net_device *netdev, bool enable)
 
 	if (enable) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_SHAMPO;
-		new_params.packet_merge.shampo.match_criteria_type =
-			MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED;
-		new_params.packet_merge.shampo.alignment_granularity =
-			MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE;
 	} else if (new_params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_NONE;
 	} else {
-- 
2.31.1


