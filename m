Return-Path: <bpf+bounces-68512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D09B5992A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2034E73A4
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF434166B;
	Tue, 16 Sep 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2Zg/3YX"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D613314B66;
	Tue, 16 Sep 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031988; cv=fail; b=S9EYqVi8uXQuW3/mBFyrCcpkmh1OS/wzFIlIfjNHDf+B+0Wns+eUjiNh71pjVqueaGgdUp3eUMi+ssOiJKzHEXkUHpN0qi40mNa4ubPKu974Rw1bSwTAGpKU6eQrn7OSlCnDa6OZnEJq39mtm43kP+IeAAgMis7qiNaKF3SBR4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031988; c=relaxed/simple;
	bh=cAaqKBoxnbEhz+yra4VDImmUtw46PoymDKTYMEersnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhSllhYMIZiDEgv1D1Mx/QjcBHkFlZVUu4VCVs2AywwSifDAONI/dZhDPMeXdN9aZjSbIyyM19JOLt7geLSZyk6TdOH+elhy9SRWQlKMaKtcMnGmL7NTlZ5scGjBCedKQV42Ls3f19wRGYOe+fVqV8+gEXxx2tSr571abQ32b6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2Zg/3YX; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFARYR3VwHaRZmunDMHmBOPWXfZgSbBGue1AoIepKhXz3A2PBXny2GcI+u+kXYO1fMBcHtq2f7emQfCWhG3j0/785Pn9eeLejXe4WA4wdaV35gwrdoPTN1+3+KPHmphjuzh9et/yQFdSYmKBPW7BKJQw7hbWd/93gXQitqG1bsVhAxRdJLTFSnRDwwW4d/p5YVlva+/QiPMpXJcCYrP0YLskhA00WKGLhVbWwyhNyA0D2sGozEptQndHAnIrd1GbQNUlQSNAggvRKvuh+WTwaYGXm34i/zkkkP3yLmoEfmg9oFGcdKFKy3+8wQHpAWSJKlkuKy24R4G3sdNgVFkKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxhb0YwSQptaFEa/268dyDggWbw63UzW76xYEwJR+nM=;
 b=I/zoueV5r6ChD/SmimLVCBr7PpZ8DEQWv1HaQ2/EHi53ARi/mlo3XY3UaMPtHER7r4Pt3qOdkYf9sBmm0zrBOtpvSeVYWYxDYyo+S/TPSxkPVepnqCIqtsGiOZ9oXIM5Qbhk9JPcDU+nLC9MiVe9frPTbrnUkzxr+ewefV0ub3m3PttD83IcBdkYJmMnJb9jYVb/fZ5NFd9BhrqtPdFyKjqL9xxIYT1KeiXg8+1mvrR2mXzMtteTBpsCsDEsrZ4ne9+pCvW4MybwPoes1pxIFPeFb3XJoOWuDrmxknlJQ9zU8PhBx9j1FPGQ3pY6MpWsWG216y6t8HLWUUP2Z7nabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxhb0YwSQptaFEa/268dyDggWbw63UzW76xYEwJR+nM=;
 b=F2Zg/3YXvd07JhVsd6lDookFOAsO4+AHJMFYye1er56uUTmfRVpYycxfU9c5tV771O0vHtbtKr3sg42BdMIm2lnP6Tja/k3aQCDdCQE4N1qRGLqK1WygaK583nt80j2tKgnORu7uC9c3RTmjX2SS+unOvxWZJOO4ZcNVwWbeUsljhSHxDJ2aYwD5dekOU0bi+B87Ag2t2g6/nf65HzOUs7/551AD5e1V8dJMNEoaEBniWTFgK23gAPP6Wjr6i3RGEMQUzjH5T0A+0yR5mfOxjd1JyiA0SjZO6mg2bfNu4gFXxdHEFW4oQCUxo52vAHDNp9D+G0F4L4wVWId2TIpgQQ==
Received: from SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) by SJ2PR12MB7865.namprd12.prod.outlook.com
 (2603:10b6:a03:4cc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 14:13:00 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::ca) by SN4PR0501CA0109.outlook.office365.com
 (2603:10b6:803:42::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Tue,
 16 Sep 2025 14:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:12:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:12:35 -0700
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
Subject: [PATCH net-next V2 05/10] net/mlx5e: Prepare for using multiple TX doorbells
Date: Tue, 16 Sep 2025 17:11:39 +0300
Message-ID: <1758031904-634231-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2db74e-1bc0-425a-f4bd-08ddf52b247a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8i4CdJ+ZxnjEXMtYrS3w8qkMiAmVrk1sP8VCBWEKy47oEd/U5+qAoPtLdXWb?=
 =?us-ascii?Q?tyJpiAnYGKbICpa8UBgqGgu0ddYSbgfgGPJXK423T+aV/4j0BdxsC1nqXusf?=
 =?us-ascii?Q?xM+dB7ok1TxaQkzbCY6dIL2ACAqVWb11QZAx4OWNbdzFZV1T+CWfM3l7lSA2?=
 =?us-ascii?Q?PFNoOBfcsJjdL+pDUmJhowXROPIV/WzjwN+ZZc/F1k7Q6dn8pPBhKMrjp8J8?=
 =?us-ascii?Q?ml41PveOBX2vGH40MXgrWL3gvwp/PPJ/OimJzWEu6qvPyq8CRzqKzMPxeEDJ?=
 =?us-ascii?Q?m2bATqwIjncG+ek3p3vDWRED12K9urnpCj2suFn7pam0s4n4OSP8yz6hreA1?=
 =?us-ascii?Q?giAFyTTa3jQc0QSMDZtD2MuKkpabn7dy4LJwS8CB34mjt2m6bxTeqcbK13pX?=
 =?us-ascii?Q?9P7dJvE4vYUbk1ymPkG/sxvqfrCbbe7cYqPXr9wa9uUkMvuQ1iaEgY+xmZDA?=
 =?us-ascii?Q?+G800ka34G4sYB1jbmG1sYxE53HcDfOFo9RHWd2coL/g94QmCnyuUmEooAs/?=
 =?us-ascii?Q?WyniiuXMQr/UWc/Gswy7iIzcG+AxRfFkW5wzEqQykog3LrPoiHa9NsPUeN04?=
 =?us-ascii?Q?1RFyAVOrVs70fjj/Zz7m78VQLV1HJYQvD1lNhiLTB/NV1/nDpO1gbp0DOUqp?=
 =?us-ascii?Q?+nSyNJpmmbNgBJObHJcnIfqeIDNn0OobjsaMRMN0rqtKqQ+zzbS08Yuu6Ie/?=
 =?us-ascii?Q?vto193cyQvSp3Ot408u1PkGnFKgZmlbY+E9cgTAFV/yCjf3qv+9ftuM30K8p?=
 =?us-ascii?Q?TCKqke2FurzF8mexOJq1wdBMhUzHuinWSdUYD+4IDubWSEM718aWXwoZI858?=
 =?us-ascii?Q?HfFjA2LBBd4aIrdeRbIlS3PWyfWytdTe0ZrRQjcOlpk/voFAJlr03XqRv/G2?=
 =?us-ascii?Q?J45XVqu67a3AAEbWInAdSUGa5sb1iSL/ZFC4rzzbp2M/TiGrJbdeS9wIPnhg?=
 =?us-ascii?Q?zkbxpylCkTNcH01KyDHxNnRedUfKHDVLo/NX9I+dug8kWvdTE6vfSyeSBOOK?=
 =?us-ascii?Q?O9bOFRCCXRfiT0VcEk6SeEnTZJj1PvfZC733eXuPh1sWfINBw/bcCzKagij3?=
 =?us-ascii?Q?xvfA4oxSvNso6bctBWRH2yF92y4Pbcv+EMyZ09R2vYRGnkrOZRRYqM/W0aNd?=
 =?us-ascii?Q?iUZW0BrvxM/7dnl8fNcfkOvxWVA+EzcZO8H+7z57a3vsepv+o9QVFfrzgYIB?=
 =?us-ascii?Q?qnxERt51qwo60ENBLyjXxWU71JNp5UEg+jHNMN9AL9T4sPr7FWbCt6yUM+8X?=
 =?us-ascii?Q?mnKMmcAUHXratpa89jTd+Jfo00tT9+4qo7/b6a6bdMTIrE7N62ChdKRBqR1q?=
 =?us-ascii?Q?oT34ganbxD7vWNWl7w+/X7yGaMkDhlCHMdzEwOBxdc4TivMCuYvnGTYZ4ond?=
 =?us-ascii?Q?TIj4/deyMg98v4Tm/ZFPZH99uTUtnS2adxpWDsMq11Bq3SSZCjjHNuoKvMip?=
 =?us-ascii?Q?hLjuBAqKsJHbHX+0cC1ssJdJI5y1YqVXyChCr2cm33NWk9x/jPiKVefi17JP?=
 =?us-ascii?Q?pW3P06QDmyLW1ZIhbi1VI/Vf2PuuCAim8WAq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:59.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2db74e-1bc0-425a-f4bd-08ddf52b247a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865

From: Cosmin Ratiu <cratiu@nvidia.com>

The driver allocates a single doorbell per device and uses
it for all Send Queues (SQs). This can become a bottleneck due to the
high number of concurrent MMIO accesses when ringing the same doorbell
from many channels.

This patch makes the doorbells used by channel queues configurable.

mlx5e_channel_pick_doorbell() is added to select the doorbell to be used
for a given channel, picking the default for now.

When opening a channel, the selected doorbell is saved to the channel
struct and used whenever channel-related queues are created.

Finally, 'uar_page' is added to 'struct mlx5e_create_sq_param' to
control which doorbell to use when allocating an SQ, since that can
happen outside channel context (e.g. for PTP).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h   |  1 +
 .../ethernet/mellanox/mlx5/core/en/params.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c   |  4 +++-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 18 ++++++++++++++----
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 0dd3bc0f4caa..9c73165653bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -788,6 +788,7 @@ struct mlx5e_channel {
 	int                        vec_ix;
 	int                        sd_ix;
 	int                        cpu;
+	struct mlx5_sq_bfreg      *bfreg;
 	/* Sync between icosq recovery and XSK enable/disable. */
 	struct mutex               icosq_recovery_lock;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index e3edf79dde5f..00617c65fe3c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -51,6 +51,7 @@ struct mlx5e_create_sq_param {
 	u32                         tisn;
 	u8                          tis_lst_sz;
 	u8                          min_inline_mode;
+	u32                         uar_page;
 };
 
 /* Striding RQ dynamic parameters */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 7c1d9a9ea464..a392578a063c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -334,7 +334,7 @@ static int mlx5e_ptp_alloc_txqsq(struct mlx5e_ptp *c, int txq_ix,
 	sq->mdev      = mdev;
 	sq->ch_ix     = MLX5E_PTP_CHANNEL_IX;
 	sq->txq_ix    = txq_ix;
-	sq->uar_map   = mdev->priv.bfreg.map;
+	sq->uar_map   = c->bfreg->map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	sq->stats     = &c->priv->ptp_stats.sq[tc];
@@ -486,6 +486,7 @@ static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
 	csp.wq_ctrl         = &txqsq->wq_ctrl;
 	csp.min_inline_mode = txqsq->min_inline_mode;
 	csp.ts_cqe_to_dest_cqn = ptpsq->ts_cq.mcq.cqn;
+	csp.uar_page = c->bfreg->index;
 
 	err = mlx5e_create_sq_rdy(c->mdev, sqp, &csp, 0, &txqsq->sqn);
 	if (err)
@@ -900,6 +901,7 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 	c->num_tc   = mlx5e_get_dcb_num_tc(params);
 	c->stats    = &priv->ptp_stats.ch;
 	c->lag_port = lag_port;
+	c->bfreg    = &mdev->priv.bfreg;
 
 	err = mlx5e_ptp_set_state(c, params);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 883c044852f1..1b3c9648220b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -66,6 +66,7 @@ struct mlx5e_ptp {
 	struct mlx5_core_dev      *mdev;
 	struct hwtstamp_config    *tstamp;
 	DECLARE_BITMAP(state, MLX5E_PTP_STATE_NUM_STATES);
+	struct mlx5_sq_bfreg      *bfreg;
 };
 
 static inline bool mlx5e_use_ptpsq(struct sk_buff *skb)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 02a538ec2ecb..0425f0e3d3a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1532,7 +1532,7 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
 	sq->pdev      = c->pdev;
 	sq->mkey_be   = c->mkey_be;
 	sq->channel   = c;
-	sq->uar_map   = mdev->priv.bfreg.map;
+	sq->uar_map   = c->bfreg->map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu) - ETH_FCS_LEN;
 	sq->xsk_pool  = xsk_pool;
@@ -1617,7 +1617,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
-	sq->uar_map   = mdev->priv.bfreg.map;
+	sq->uar_map   = c->bfreg->map;
 	sq->reserved_room = param->stop_room;
 
 	param->wq.db_numa_node = cpu_to_node(c->cpu);
@@ -1702,7 +1702,7 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	sq->priv      = c->priv;
 	sq->ch_ix     = c->ix;
 	sq->txq_ix    = txq_ix;
-	sq->uar_map   = mdev->priv.bfreg.map;
+	sq->uar_map   = c->bfreg->map;
 	sq->min_inline_mode = params->tx_min_inline_mode;
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	sq->max_sq_mpw_wqebbs = mlx5e_get_max_sq_aligned_wqebbs(mdev);
@@ -1778,7 +1778,7 @@ static int mlx5e_create_sq(struct mlx5_core_dev *mdev,
 	MLX5_SET(sqc,  sqc, flush_in_error_en, 1);
 
 	MLX5_SET(wq,   wq, wq_type,       MLX5_WQ_TYPE_CYCLIC);
-	MLX5_SET(wq,   wq, uar_page,      mdev->priv.bfreg.index);
+	MLX5_SET(wq,   wq, uar_page,      csp->uar_page);
 	MLX5_SET(wq,   wq, log_wq_pg_sz,  csp->wq_ctrl->buf.page_shift -
 					  MLX5_ADAPTER_PAGE_SHIFT);
 	MLX5_SET64(wq, wq, dbr_addr,      csp->wq_ctrl->db.dma);
@@ -1882,6 +1882,7 @@ int mlx5e_open_txqsq(struct mlx5e_channel *c, u32 tisn, int txq_ix,
 	csp.cqn             = sq->cq.mcq.cqn;
 	csp.wq_ctrl         = &sq->wq_ctrl;
 	csp.min_inline_mode = sq->min_inline_mode;
+	csp.uar_page        = c->bfreg->index;
 	err = mlx5e_create_sq_rdy(c->mdev, param, &csp, qos_queue_group_id, &sq->sqn);
 	if (err)
 		goto err_free_txqsq;
@@ -2052,6 +2053,7 @@ static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params
 	csp.cqn             = sq->cq.mcq.cqn;
 	csp.wq_ctrl         = &sq->wq_ctrl;
 	csp.min_inline_mode = params->tx_min_inline_mode;
+	csp.uar_page        = c->bfreg->index;
 	err = mlx5e_create_sq_rdy(c->mdev, param, &csp, 0, &sq->sqn);
 	if (err)
 		goto err_free_icosq;
@@ -2112,6 +2114,7 @@ int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
 	csp.cqn             = sq->cq.mcq.cqn;
 	csp.wq_ctrl         = &sq->wq_ctrl;
 	csp.min_inline_mode = sq->min_inline_mode;
+	csp.uar_page        = c->bfreg->index;
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
 
 	err = mlx5e_create_sq_rdy(c->mdev, param, &csp, 0, &sq->sqn);
@@ -2740,6 +2743,11 @@ void mlx5e_trigger_napi_sched(struct napi_struct *napi)
 	local_bh_enable();
 }
 
+static void mlx5e_channel_pick_doorbell(struct mlx5e_channel *c)
+{
+	c->bfreg = &c->mdev->priv.bfreg;
+}
+
 static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 			      struct mlx5e_params *params,
 			      struct xsk_buff_pool *xsk_pool,
@@ -2794,6 +2802,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
+	mlx5e_channel_pick_doorbell(c);
+
 	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq_locked(&c->napi, irq);
 
-- 
2.31.1


