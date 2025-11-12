Return-Path: <bpf+bounces-74279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E10C515D1
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E753D1889EC5
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FC1301011;
	Wed, 12 Nov 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGcvvkk5"
X-Original-To: bpf@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2452FE06B;
	Wed, 12 Nov 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939902; cv=fail; b=F2ptqkNh2g+YerwbEC7GV6kJto2i2rss8JF1TWtxDM4FZXvhI4Euq/8eLCbVi6NTarFG3DI+JM2gUKtScHmCYcH6sKDUac7tyhDe2ENifpixEhYVg7yQbIMriYzdzDSN6Nw24A3TvayFPEnCvsCFucojwcIJRUoBpdPK+Rk+tYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939902; c=relaxed/simple;
	bh=J3Swvh0uX+8obndKAfPz/3RCJVB+hnjNGQeGv3B517c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mm2pAEFKHU8U93a4ZP1DzrAKbtBPpIpC3JWJKVMP1Y9WwH1jvIa1YJvtGcSUSmSWpHjtSoV5ADc72wnzKgtQmAkKTK5OP4SFJXMbKERzEChwXkwIa6ve+zP0fCry8OGeliyF/1tRSDLDteYiVTvpF+eFH8v35ouL6k7uc28JOIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGcvvkk5; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoM7n+XgX8Vqy4/hEw5ky71PHYXhxnPOgDhcgbdz7MbRLHoRbpJDrARtMcGREfmnLgCJ4EQiQehohGi6Q7BYEwk3dw8oLIOk4zJanFR74hGVVdG+gATs2Al+4lhoeYF0ykHX6Ev9Qk7tlA9KZIPl89hc07v71QyWMIpRO5MSt6MLVz5Mdqcx9zEkeE/PVWgQQSR2CFZGSlPogrWw53Vz5vIEPz3grHTTaISwLb6vXTdAYL6Nebm9z89oIE801aeVQEVJcxdsIHYjGawNGVJnNbI3riXsscclyJOKj4ddRObF2Ps2RnCvkZBztKaSWaYkBGeBVpO7st+H87CDt8+txA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylF1vSLCYdN+Xfo7XgPHkRU4aWcrKoy6cjaiV07jgpA=;
 b=WDBOXQlm5E5VsE7rHJ+STA5jmXzFRpwoXSIdtkEVaDth3cjgnMYr8P7SVqTpw+lFS4soNsPLnNZSfOagwO3qdL3JFi2lZeQV8UDWyPemWXcvhLEOtgLPcYwoSyCD9Kq6vdcugptkKogwlruqohxXORgGf8dWyWKpybjFOOLzJzkgfUcDMzn8/qbMyhv14z9sS8HnxI5mdTjbJf1jp4NcG0BQoNdTuHzTlofFlUs3OicgK5IDsS4esETXndnGYlrF638tpSBgw3KEns9MtEnoHRbgPX6Rev/Ns0auwq6oW0t6qjO8cN/YL6E2gPRmMXbJhBuGi6qVXzJgremzv+VXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylF1vSLCYdN+Xfo7XgPHkRU4aWcrKoy6cjaiV07jgpA=;
 b=RGcvvkk5q3vnKUDd9DcCkbTAM+KcBfg4hsuwzx1qdV77GYo6Ewjjz+IKB6cV4QVZBPBvBkg5ojIjrA2VSE6raaiXZtf3RyDfNER0aR9us3uIKxh1OGvvXrJ41TlOea03Nvx4KvxebpiktEg3fvYRal0RwqOAA+5xfz1zXhoSwV0nZQeA4ev7fNr1+y+q0cRQwDpe5x1t2+vquMOh/whdoNEkTPu2ww8C4tjNqOX+uElzSlizj88VpaxjLfF1pP4Cw4JsCNb4PskIvivdB0ZR7zkvZ+OGTkfHBtYIgBS6aMJGYluGIAwduKFpEzdie3N4VhzDm30v+kFMsShkAWriug==
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 09:31:34 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::c4) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 09:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:31:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 12
 Nov 2025 01:31:06 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, William Tu
	<witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
Subject: [PATCH net-next 2/6] net/mlx5e: Use regular ICOSQ for triggering NAPI
Date: Wed, 12 Nov 2025 11:29:05 +0200
Message-ID: <1762939749-1165658-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e0811a-7b0c-4687-f397-08de21ce4535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8HrCiriXOxgSU41ZPkWUSKyUTjk9Nx6WR5WFe1gqgQXzo8L53MCyWBAUUFr?=
 =?us-ascii?Q?a2VWeo0LfrbewJ7lOwlwuGCAI7oCwxtXtIjk6wo8VcZaOK3IWOZ0XvwtuORG?=
 =?us-ascii?Q?0PcTpsMoYPVBsDzOPPPRGF1RtZxFETbCftKxJAYWq85JhhZSc4ZIo1RVU+DR?=
 =?us-ascii?Q?MLu9h2HxctbFhlHethKsOeNmdyCSrDArZbD0YFM03zmb6oNRjjC3X3WLvOOS?=
 =?us-ascii?Q?lQZzu/CJO5hl6uW3jONSYTPbNFvPOVkJYzAQ8gImO5++DwK1vOXwEAbJvrIn?=
 =?us-ascii?Q?v91zhYquCnX8s8BPe1VgSBYE5i4ZImPNAUEX3kNG1KQQJ1xbrN6JWgS7us3B?=
 =?us-ascii?Q?+AR8ccLLwoGJYWbg7/fKGasB+C8LqI2hCuL4jDfcRXbETWoEoeIbapxQoCRS?=
 =?us-ascii?Q?oyUdFSFxZiFKcS23+m8wuKZVvIdxAmeJfSeXpqxdJFuwvt1Rpow04gP2At4L?=
 =?us-ascii?Q?pHYZn87W89Wd9zySNhieTfaKoredIN26qOV4coIRZp6soHCr1hPHNjRGeWtl?=
 =?us-ascii?Q?TkSD0ka2sVaVxrUoCANUsdG/rxoKFIM6W09LMvQM3y74mEe6sSSGJzR6cTcl?=
 =?us-ascii?Q?bA3zfpy7eBWXOtL8nrhX6Yq+qszTABkez9IXir82H3XDIREeSnLWhPVhaSos?=
 =?us-ascii?Q?B9CTg+NI5YBTjtY/GacqJoNtiVveihZyPxVsUxWAKU6LSP8JOPfesUbubHHy?=
 =?us-ascii?Q?8N/uCsyyR/yp1y2oumy6W6J6sbOXRpZDvJuucS+/t4JXtP41HVADYl+JK0Tn?=
 =?us-ascii?Q?+YpWTRoLOnct1+PIZMi3V8WOPUqgUVEs6cCp8PVmyB/QfRd+t16vBfQobiu5?=
 =?us-ascii?Q?lRA0yrbGIe46nJ38UCrWgu82Pn7+aE03+iePaQdP7npa0hEQ9z4Wrgi55SVY?=
 =?us-ascii?Q?bZtx5wmzONkRJJF++xmj8u3tHvL25YDa9lnxLUTlvvNv3NYX5zcRA/S5RRQb?=
 =?us-ascii?Q?DB+U58J6pVhH1EP8b+vS/OTRvJ/N2Z/fNR392Rfu5PAkmZ4DInhaKPtcOMCh?=
 =?us-ascii?Q?ogrc3drf4ehn+En3qWw/RepEUcA+YHK1ZEOI/f2H/CPTghdZ8uKk5Xlci3h+?=
 =?us-ascii?Q?VbVS7hGU2T8nAe8QQhoY4g2syYMYhb6kp9GGrL9g/Zww0Du1H/8q6py343Zz?=
 =?us-ascii?Q?2ixnenzw/drxgpgFWmqZjZ68y1IT992hAW7XDUY72RuZ6i+NnfWw3j2BVLsQ?=
 =?us-ascii?Q?pAH5KgTDbaF4M8HdEboWEJ2d0SVA1sqpFPi3Ldi2n/pv6FNgnhqz/otShLoL?=
 =?us-ascii?Q?vZG2kN/DKusfOgo4TKYk162IDUm9T/1Y3gMzeef4NdBXKJqLss3USr73RArF?=
 =?us-ascii?Q?xm6kZxLilcYs/GFcL8GYi5g7wQX4UBzD86ihauRVzJpcMDkY9siSNc1KJSLG?=
 =?us-ascii?Q?OeHeTgAylD2+lhNLTWJ0sEqp6Hndzs39XsY12gK/g84jaxPq5sEJG5r2cdVL?=
 =?us-ascii?Q?XOVW89o0UXlmkUagfxGS3Sg8urNFgstnjxME0dr3yAZxBjqRMaPhBo7cTN9Q?=
 =?us-ascii?Q?pcjjkn8aJuqRHodKCu+uTy3RiPCrc48O56F21NNxrn/MaKYYhmkChZs8DzUn?=
 =?us-ascii?Q?4OVoUFEW4ZVfBhUJQ6k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:31:34.0336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e0811a-7b0c-4687-f397-08de21ce4535
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268

From: William Tu <witu@nvidia.com>

Before the cited commit, ICOSQ is used to post NOP WQE to trigger
hardware interrupt and start NAPI, but this mechanism suffers from
a race condition: mlx5e_alloc_rx_mpwqe may post UMR WQEs to ICOSQ
_before_ NOP WQE is posted. The cited commit fixes the issue by
replacing ICOSQ with async ICOSQ, as a new way to post the NOP WQE
to trigger the hardware interrupt and NAPI.

The patch changes it back by replacing async ICOSQ with regular
ICOSQ, for the purpose of saving memory in later patches, and solves
the issue by adding a new SQ state, MLX5E_SQ_STATE_LOCK_NEEDED
for syncing the start of NAPI.

What it does:
- Switch trigger path from async ICOSQ to regular ICOSQ to reduce
  need for async SQ.
- Introduce MLX5E_SQ_STATE_LOCK_NEEDED and mlx5e_icosq_sync_lock(),
  unlock() to prevent the race where UMR WQEs could be posted before
  the NOP WQE used to trigger NAPI.
- Use synchronize_net() once per trigger cycle to quiesce in-flight
  softirqs before serializing the NOP WQE and any UMR postings via
  the ICOSQ lock.
- Wrap ICOSQ UMR posting in en_rx.c and xsk/rx.c with the new
  conditional lock.

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 40 ++++++++++++++++++-
 .../mellanox/mlx5/core/en/reporter_tx.c       |  1 +
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |  3 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 14 +++++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  3 ++
 5 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 70bc878bd2c2..9ee07fa19896 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -388,6 +388,7 @@ enum {
 	MLX5E_SQ_STATE_DIM,
 	MLX5E_SQ_STATE_PENDING_XSK_TX,
 	MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
+	MLX5E_SQ_STATE_LOCK_NEEDED,
 	MLX5E_NUM_SQ_STATES, /* Must be kept last */
 };
 
@@ -751,7 +752,7 @@ struct mlx5e_rq {
 
 enum mlx5e_channel_state {
 	MLX5E_CHANNEL_STATE_XSK,
-	MLX5E_CHANNEL_NUM_STATES
+	MLX5E_CHANNEL_NUM_STATES, /* Must be kept last */
 };
 
 struct mlx5e_channel {
@@ -801,6 +802,43 @@ struct mlx5e_channel {
 	struct dim_cq_moder        tx_cq_moder;
 };
 
+enum mlx5e_lock_type {
+	MLX5E_LOCK_TYPE_NONE,
+	MLX5E_LOCK_TYPE_SOFTIRQ,
+	MLX5E_LOCK_TYPE_BH,
+};
+
+static inline enum mlx5e_lock_type
+mlx5e_icosq_sync_lock(struct mlx5e_icosq *sq)
+{
+	if (!test_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state))
+		return MLX5E_LOCK_TYPE_NONE;
+
+	if (in_softirq()) {
+		spin_lock(&sq->lock);
+		return MLX5E_LOCK_TYPE_SOFTIRQ;
+	}
+
+	spin_lock_bh(&sq->lock);
+	return MLX5E_LOCK_TYPE_BH;
+}
+
+static inline void mlx5e_icosq_sync_unlock(struct mlx5e_icosq *sq,
+					   enum mlx5e_lock_type lock_type)
+{
+	switch (lock_type) {
+	case MLX5E_LOCK_TYPE_SOFTIRQ:
+		spin_unlock(&sq->lock);
+		break;
+	case MLX5E_LOCK_TYPE_BH:
+		spin_unlock_bh(&sq->lock);
+		break;
+	case MLX5E_LOCK_TYPE_NONE:
+	default:
+		break;
+	}
+}
+
 struct mlx5e_ptp;
 
 struct mlx5e_channels {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 9e2cf191ed30..4adc1adf9897 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -15,6 +15,7 @@ static const char * const sq_sw_state_type_name[] = {
 	[MLX5E_SQ_STATE_DIM] = "dim",
 	[MLX5E_SQ_STATE_PENDING_XSK_TX] = "pending_xsk_tx",
 	[MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC] = "pending_tls_rx_resync",
+	[MLX5E_SQ_STATE_LOCK_NEEDED] = "lock_needed",
 };
 
 static int mlx5e_wait_for_sq_flush(struct mlx5e_txqsq *sq)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..a96fd7f65485 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -21,6 +21,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, ix);
 	struct mlx5e_icosq *icosq = rq->icosq;
 	struct mlx5_wq_cyc *wq = &icosq->wq;
+	enum mlx5e_lock_type sync_locked;
 	struct mlx5e_umr_wqe *umr_wqe;
 	struct xdp_buff **xsk_buffs;
 	int batch, i;
@@ -47,6 +48,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 			goto err_reuse_batch;
 	}
 
+	sync_locked = mlx5e_icosq_sync_lock(icosq);
 	pi = mlx5e_icosq_get_next_pi(icosq, rq->mpwqe.umr_wqebbs);
 	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
 	memcpy(umr_wqe, &rq->mpwqe.umr_wqe, sizeof(struct mlx5e_umr_wqe));
@@ -143,6 +145,7 @@ int mlx5e_xsk_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	};
 
 	icosq->pc += rq->mpwqe.umr_wqebbs;
+	mlx5e_icosq_sync_unlock(icosq, sync_locked);
 
 	icosq->doorbell_cseg = &umr_wqe->hdr.ctrl;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 590707dc6f0e..80fb09d902f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2751,11 +2751,17 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
 
 void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c)
 {
-	struct mlx5e_icosq *async_icosq = &c->async_icosq;
+	enum mlx5e_lock_type locked_type;
 
-	spin_lock_bh(&async_icosq->lock);
-	mlx5e_trigger_irq(async_icosq);
-	spin_unlock_bh(&async_icosq->lock);
+	if (!test_and_set_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state))
+		synchronize_net();
+
+	locked_type = mlx5e_icosq_sync_lock(&c->icosq);
+	mlx5e_trigger_irq(&c->icosq);
+	if (locked_type != MLX5E_LOCK_TYPE_NONE)
+		mlx5e_icosq_sync_unlock(&c->icosq, locked_type);
+
+	clear_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state);
 }
 
 void mlx5e_trigger_napi_sched(struct napi_struct *napi)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1f6930c77437..b54844d80922 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -776,6 +776,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	struct mlx5e_icosq *sq = rq->icosq;
 	struct mlx5e_frag_page *frag_page;
 	struct mlx5_wq_cyc *wq = &sq->wq;
+	enum mlx5e_lock_type sync_locked;
 	struct mlx5e_umr_wqe *umr_wqe;
 	u32 offset; /* 17-bit value with MTT. */
 	u16 pi;
@@ -788,6 +789,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 			goto err;
 	}
 
+	sync_locked = mlx5e_icosq_sync_lock(sq);
 	pi = mlx5e_icosq_get_next_pi(sq, rq->mpwqe.umr_wqebbs);
 	umr_wqe = mlx5_wq_cyc_get_wqe(wq, pi);
 	memcpy(umr_wqe, &rq->mpwqe.umr_wqe, sizeof(struct mlx5e_umr_wqe));
@@ -835,6 +837,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	};
 
 	sq->pc += rq->mpwqe.umr_wqebbs;
+	mlx5e_icosq_sync_unlock(sq, sync_locked);
 
 	sq->doorbell_cseg = &umr_wqe->hdr.ctrl;
 
-- 
2.31.1


