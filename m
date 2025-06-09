Return-Path: <bpf+bounces-60062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1A1AD21D1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE03216F7DD
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45E221700;
	Mon,  9 Jun 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQgVYJlI"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82F221262;
	Mon,  9 Jun 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481210; cv=fail; b=ae1j8vbQvevs7nyuf58JCBX7PSTr4dK4eCLCIxrdbPmcBQuPZGjROemNihFKaudPDNyztQQwrbJnq6S8prc/rq2/1nDPKabrDWd4kPysQBUGfNjwkwkWh/7Y/GHSWA3XBf39OSumV1qxdug0DWcrxWFlNYAz9vU1YgTRz90hIMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481210; c=relaxed/simple;
	bh=MkUXqMGdgt99DElX6FuJZK+KH/uecXa9QNcqRYT3UTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCS0W2ZlYX0h9sh8BpdL+KzFCfvZ78yYb/miSflbZhN8YROPvovTYzgZ+tVe+K9UPYF/CI/VNpmRcsXB4JuqaNpE341TEWTVLj06Fsx8SqBRbM+HD+GKt41e7HpAElRBM9FdkAfXHBEGaPM2DTiWCt1o3X2F0xsqn0ituXkOT9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQgVYJlI; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUIG0feATEwyhF0/GSOPdyATISj+zRg2eR9NH/f6YSr4E9inMWSG9tUjp1hlqEMaJ2ZD9QZD0PhxH6OfWMIHK4mcXr3byqf7puDnc6lXk7QufEpPpasQ+SJScZ2VWL1fVt0PZLmpwKH5BQHLXd/nlpfEmEVfsnKsQbhiN4Ai5qeZ8fAKQope3OliWpzHTZA4Y5EFqfHKCNoFp1da4W8Babv+7vWWNIAz6diLl62tAATYLYHkIR4XJna9Grn9vIT9R0PfQNcjZKyxhZZQ/RvdvdfBYDSyQ3Bx4+mlYpTQStxLEmvNdZzxPxxsj2B730dKv1Tb8Mg/lHu2TAhX7nwfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6p1corQwWdCFsKO5166q53shgxvNfvAJzbBGheZUKg=;
 b=ZDmk3U73w3oTXh1znvYns0rnTgvPT+ruMAST4dW8qJmE5MzzFgWzt+tLRj6mA/NhyVIXBNJnHjjptje8jn5LL1Pm0BiQkloaAQwGUM0NsaD7Z2PbNM8vhExUAtv32mn9uW8QYsVrEaQRbL50+yOcup2I8jDu/he3pWT1NkcQyOW8dF+kERD7YWSQnykfXN2ATV5R9dyl8mrSzF0Ix/8Mi2k5Y20xBaHnAimnAJ/zqz31NpvGPh0PmRx3CGs8reLs6+uKb8TFGGAbNIDXOB6BTYhGA4kqxZJ2e02ig/dzY+mW2CavD7aUJ3kk3rPFfX8P975kWshtObMumw52zi8LeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6p1corQwWdCFsKO5166q53shgxvNfvAJzbBGheZUKg=;
 b=UQgVYJlIUZi2upJoDPF8dMcFHHT0OfVTfIkcU9E7Jbdnrw3rgidlZgyaElzJR5zCi8r67a6IMx7/LqkXkCFheWuGFwACgUFfmkKTz0pO9qj66DYdXm3ezHnmH5kvQAXQh1WqRXCmkl1nDCOSX05rOeSb95jqD8QQqsgPuCpF8c705rhzkgX76zcwWtl2y19S3QA8dsbrtYKHNKCgDiHq3PGqfvhgB36qQt0JTbsfUADLnfesUZVMYRlcBG55Se/UR+7/JeFt9gaq27O2S9DnHGWPlmlSiYremSpUDTfJffPhtz9wCAY5i24X+Ae/Gdg56mZVrkkIb3a0pk9yenoxhg==
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 15:00:04 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::cb) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Mon,
 9 Jun 2025 15:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 15:00:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:59:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:59:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:59:42 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Simon Horman
	<horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 09/12] net/mlx5e: Add support for UNREADABLE netmem page pools
Date: Mon, 9 Jun 2025 17:58:30 +0300
Message-ID: <20250609145833.990793-10-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609145833.990793-1-mbloch@nvidia.com>
References: <20250609145833.990793-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 5949e366-a580-42ae-ff70-08dda76650f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTDo5QvDfChh+ePtw0eALMemJyOo+5n4+PYDWSL5l1r/0wlKHiU8g404McQU?=
 =?us-ascii?Q?ZsfCAuk43kXDEd19C61Vv4OxL8SX2dCnOgm3MVTQ8oz7cHNhqqnT+2rzgw7r?=
 =?us-ascii?Q?f0378gbfnnHdWJe+JWO98j+cCrs7f7SzYD0QlJQgr8NL8bzcvDOtnANrOxun?=
 =?us-ascii?Q?PdGWWCgBSqb6MllgwCRfnaBlt0tRP2mQ7kNKfRNQNdWWcT+/MezVPp8AhSaL?=
 =?us-ascii?Q?f4qWLAfOCy+ufmF+skSeHe6CIsmHX0Iayf/kEgZAJ1rNVCh2Z2AqKG5Pkhwa?=
 =?us-ascii?Q?E42gLy2xOF+1GjPxsdrQyoENE1MDicuu5348LXaBwbaZgbqLnuW0/zBjiOyG?=
 =?us-ascii?Q?evI8BMMeSeQI3X74SU/+2L1kttJWUU/t0ff3MCpmcUDDgkJCeMAcpA3JkVSN?=
 =?us-ascii?Q?jVstYMEMKzOBHOAUFHlN7G1ry/w98/PmJoVESvRowIYXglugljjgYnHuncLp?=
 =?us-ascii?Q?7DH0lVGHlzp7rAzlnXW9a5pOdTbT5knzGh08DC+BxfQN5aXCWCg7Lp2+3oiX?=
 =?us-ascii?Q?G1mMwNLOiJnuxiSlox4i7nfGnNOiH5froyEz5eadtWY86inTmL5IAAOQ6f9Y?=
 =?us-ascii?Q?y8znTWqJY+efFOKKdGZU0UU1O0s9stxVGwfEX5okrXhYQ8DxoPNNJrlof0l0?=
 =?us-ascii?Q?4YRIJKxqRf6EitHsOFAlNcxDzYijErTw19QgK+k3inOUxePWfDRVqs++zDM0?=
 =?us-ascii?Q?JZo67GsSQZSsJJSKuiAKlDD3UXdr90lSMiL2oo/OkBkIhOuCbE1dQwJW9neE?=
 =?us-ascii?Q?lSPhDtxn61Aq/SZuGBLmFMe7BApxmVCsZ2uJzA95NYFZM+391XolJ3jJNk0E?=
 =?us-ascii?Q?tN012BLmwPOHKx/OyJ6ldMCu6BpRut7NtHijQ9ViUCwD45dBNmvuNV1KzWcR?=
 =?us-ascii?Q?6YnDBNezUP6B4vr814MaFQNnIcFhxdy+oMZwt2ogu7qTYZ7HkLFeFmC7djf2?=
 =?us-ascii?Q?oBYBs0QZwOuY47CE7q/K4o++T1uMochzH6KwcooMvHaFDtErK1p9THsQL/SP?=
 =?us-ascii?Q?XatPweUQ4EIgqBVpn/1Vln9Y1xmrTKIvcKLOD+4hvEbRvqlYGHmkFMBjtVOw?=
 =?us-ascii?Q?+h+zaVzKWw68+O9VdOKNjhyHNiweJp0sjPgULqmPxbPSLaR3oreFCnxYe6PZ?=
 =?us-ascii?Q?P6V1Ap1RuTKCWD+ihF2FczHwoRzscNHYnaA3yeT+kG4o1oAvXfrfAUlyp8Wb?=
 =?us-ascii?Q?cvoWrSaDYIVrkg/523r7hOgDDYIKQs1Nii2fHIINGYxMxnFU+m63ak3SOvq2?=
 =?us-ascii?Q?WQqKAKAvDfk7ZFoW5LaI2EnSwsDftAhmB5euBdG+w1XnNNeu11786PiRUath?=
 =?us-ascii?Q?Ol5Mb8FwzSsYzN7xkfDV0iQHShsjqWxv3KJMqbHbRDUnvuqZD2bk/iP3FZIK?=
 =?us-ascii?Q?TEuigcJXUsi2WsnmS13kOIOyZaA4cnHFstS/UYI/j9EzPvXDLxqtFWshTNIE?=
 =?us-ascii?Q?ZsMHXMF3t6zdJVcV+2oxFIz6DvLuWRQ7DEQ8QK7YtSYgYJZhQenqNECiHiOJ?=
 =?us-ascii?Q?xxVKLWNbT50Hlzs1MpH/5OwybDDBtM0P7+Ro?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:00:04.1900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5949e366-a580-42ae-ff70-08dda76650f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

From: Saeed Mahameed <saeedm@nvidia.com>

On netdev_rx_queue_restart, a special type of page pool maybe expected.

In this patch declare support for UNREADABLE netmem iov pages in the
pool params only when header data split shampo RQ mode is enabled, also
set the queue index in the page pool params struct.

Shampo mode requirement: Without header split rx needs to peek at the data,
we can't do UNREADABLE_NETMEM.

The patch also enables the use of a separate page pool for headers when
a memory provider is installed for the queue, otherwise the same common
page pool continues to be used.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5e649705e35f..a51e204bd364 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -749,7 +749,9 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 
 static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
 {
-	return false;
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(rq->netdev, rq->ix);
+
+	return !!rxq->mp_params.mp_ops;
 }
 
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
@@ -964,6 +966,11 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.netdev    = rq->netdev;
 		pp_params.dma_dir   = rq->buff.map_dir;
 		pp_params.max_len   = PAGE_SIZE;
+		pp_params.queue_idx = rq->ix;
+
+		/* Shampo header data split allow for unreadable netmem */
+		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
+			pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 
 		/* page_pool can be used even when there is no rq->xdp_prog,
 		 * given page_pool does not handle DMA mapping there is no
-- 
2.34.1


