Return-Path: <bpf+bounces-74280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA077C516AA
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 10:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D6604F38B7
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16605301495;
	Wed, 12 Nov 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YbX5Zt/y"
X-Original-To: bpf@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21122FE592;
	Wed, 12 Nov 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939911; cv=fail; b=sy3bu+Cqh05qszcNiubrRNrOGcoaVnK7CuIw1r3wCGyrek35DX2OEv4akvSMsyXP9923/bHE6v14Nh0VgIjyqb9zhE3lKNNb3Py320Z02ImW4Qaln+T3x6al9MvR0pI0g6O+iFYr1wAsRrlW3MzNVq+ap5DIbDAG5sYEtb+T5tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939911; c=relaxed/simple;
	bh=fOtTLCDTi0tYO0iZGUaVN1x+9BnyJaA2DtwYUI/98o8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChM58n119eBJOu+wryZQWsVuoLhlaCtzAoLT0XahXBfpuQOBnqSOOJw2f9PAMJ2XwFtIr21ev47BkRyJ/BVn/Q1YbTEB7RMloZUKQPtsbOthNdmgSOyJmd2Yg4EFmlO20N8t9GUibAs4bD2LSDAVePOWbzNBEh4RGC1LvAx1Ofk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YbX5Zt/y; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO0b2aSDv3qvrVnwbkzEuTTFo1RLWHjerifaRl96KFIN2KAJvbmFU9WLNQajehcYiWHCLrYbsJS5z2u8ma9t1YvR7b+n36dBaRzdeMt7j0UIM46v+a8US9c/DSPpZIYmdU1YG5Uz9y1H5e+BpEf4c+A3Nkqw55OGc07KN9/veuErhJ8bc1aStNqW3TEaUd8RSKwjhzqga1/ZFe5dW0bBcT3qrH7dX5kcOZuQ8s9lzRMCPwDdblrJjtFM7qek8vg8OD5JP0JXOxy7mepnVmUO8yNh5EZFEGLjk6JBFn8Ij61uIkjYXyb2mg3ZjsiJSzplw67xImVgEDkAfz7xCryZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv5km9tNukyeRuypQwM6ZYVSnSebQg/GSCSVJkB0ku8=;
 b=DeJOO/pcGqZ0ncyODgSI/aA/l3DMkbu9H9bvV+XuspV8ChMITxlRImQHuw8weOhclfXghhUBByn2hqOlWxMJqrCL3QKktiWDAtdjy3x3ZcEvsAvO/J68wog183LFjpbclUyVklpTDLKMWSnT0Q1hyxn4l/FBze11CLkGWXRRArpbrKGbttyoJqwMYK0U2Gc7Vj5qpEjWMSd6+L0Bc2kSXlztEHHtZSnlARseDQw2NACQmM+eJ56v9l7Yf7XXekLbyh+f2OeMJ1t5A4tnVW5Z6w4rBzJhrZ9vDZ32g9cLClXLMDNILkNaiSbfFBq+qM2yR4f8Cm7V3UrthEBkXXUIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv5km9tNukyeRuypQwM6ZYVSnSebQg/GSCSVJkB0ku8=;
 b=YbX5Zt/yn2rrAL9d3gBYavNcYBqWDdhEnRZCjb9DunoYv2XAprSc9dErdlxGA+yXc0Hq94lumCjJUIQvopHvZNojKvQmhEhoyDGacW2SGL0r6oqJO68+XxvjXrkycibcSjqcCS/OOTg+0vtmBtujyBGEuBIRjZ3/vxa1QxId9SdEpmWxnqd3GsZzfrhJs2myYVop69bqUgXaVMvLZbjqTlQxf2MygoUKu0iBuOH4uveHHiFd9dpp0BbwIqUZ5pl0hNwGyoXW543a0dZeRS38cs5ILiDbAxfNNJxceoET94W5D+GIXKyB5zrwIjheO7wv5/+RRu2B78hWD6r05GGQxQ==
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 09:31:42 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::eb) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Wed,
 12 Nov 2025 09:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:31:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:20 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:31:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 12
 Nov 2025 01:31:13 -0800
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
Subject: [PATCH net-next 3/6] net/mlx5e: Move async ICOSQ to dynamic allocation
Date: Wed, 12 Nov 2025 11:29:06 +0200
Message-ID: <1762939749-1165658-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa89ba3-da4a-4548-72ed-08de21ce4a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U05QR+k3a6gVFMVnQTURllZ1i512F001AKmhS4vQrBU/Z5wAZnG7ra/BoD0f?=
 =?us-ascii?Q?u8WnlGi+CjxGDk1Lfbg9YMlc+VtcUE7CRQpnC/ONZXDPiS2KnsfqcrBA0mQp?=
 =?us-ascii?Q?q/yXcG28CBtdYcF8qjJle5wHkAT/D5lVvj6OJjmWPnQ2aTRZWTMdS9T6BvB5?=
 =?us-ascii?Q?VBmRNpzPDig9m48uwJoXLmvZhYyQJMySvusz8fdlzNQELDYi5U3oLKhqKimq?=
 =?us-ascii?Q?JF3uatpu8jnBWBnHjGFwzEqRsn7j4s5qYm5DLj5AZEtMHUs9fQ0nP4lKmEFI?=
 =?us-ascii?Q?jbZxY9drL/APFI08zjDRtDiYRyOIRMXEh/Xa9Iwdttjs6S5rynsIzeT2Rt/j?=
 =?us-ascii?Q?MGeaVnst5fRzhCrAry6LKpLOMhg/hjclBvV80TUXwfVHAT68KbJyunUQq8fw?=
 =?us-ascii?Q?Orxc6Ntz6ByGKqUfqWf77PXtAHMdWib/YMP1rnodDR3E0v1CWGwQT3FT+J/k?=
 =?us-ascii?Q?Fl5X9P8G79XWg/Wu5FQaTq+8JTGDKMR7ufUfQ+e0ydamnOX+gLyGeQpTSNkm?=
 =?us-ascii?Q?r3OhzZ2qWFcZznkpSgtYdN12MmGD7zy2SRXE8w2R1UiUfUpCtf0F5jtoPksC?=
 =?us-ascii?Q?u6dfXv7iH0tekibmxj21lk26BcAbzl5h9CWLDdh7Yyhg8rTid4S1MYM7SlZk?=
 =?us-ascii?Q?4kKb5AECHPl/1HdEv5YsovoLs4+0hvjPBUbFmEDNYY5rT3rf9ot4YIzjvcOS?=
 =?us-ascii?Q?9doFCkUECGnGLo5aadSHPzbBYsLsQ/KJ60ZJRPeKKEHcDefOOjc6IBVQogDF?=
 =?us-ascii?Q?8sdOoO+7R40vqL/r5JlfSU7qTeLafTnCNwCFhrpQJwz9v0g5mbD/nS+dCL3b?=
 =?us-ascii?Q?0ekFlMWQhFPcmAAA3nSM9d4rtVO8JIWxyUeg185MIaRHX965aSIsy/mfzTh8?=
 =?us-ascii?Q?+wRHjIxn/V61RpuwVmsY1NdRDX46eGwjSeQvIINX0OAPwke5lqpvn2rxQFp/?=
 =?us-ascii?Q?G+CT7FEs2RFpGgDPCkuZyEQNALfyYM0OBHOMXsLfIxvpMxE8GVOn3kOG5Vcc?=
 =?us-ascii?Q?nUAJeTWoVijTUIr4vDDCLsW3wfJmHVQmQP3fB6UtNKMZIxrj9GYUugtsYVHj?=
 =?us-ascii?Q?ZCd1kxEqLWUEIe2ExC3Et0us8BV11/KB/FUFDfwfHJdfDN0J0QfTW5xyKZI6?=
 =?us-ascii?Q?1rqWpxiNVepT3yYcD4+5OBLfZ6GFV5pgJT2TbjwNEpnnBB+KIqqWgTp4qaEW?=
 =?us-ascii?Q?mS3yo5jbidMOsZ8arFxtOxBNdyQ3jsYd4rovaJCFPzWPjNMttXXoGLW9XJ4b?=
 =?us-ascii?Q?ZXJo4yeBUxZierdjCGdkoejp08Bf74u/Mf0NFJpAK13S5nhQv1aKW2Uv4hSy?=
 =?us-ascii?Q?imlq9bNJ69V0Yvfb17UH3z8TIjNuBQDjT0hptxahf5W+oaMsbUa+nlRNs6uP?=
 =?us-ascii?Q?YeULg+GkwxDkVmWbfzdIr0Qv9A8Uj/0Vc4LQcadXVf3Xm7HcIR3yIpmW92Dg?=
 =?us-ascii?Q?intmCarvMZHzjZPevDcM6E8ZH5OEwLGo74DD0Bxa+JxOT2yvcoGHx7jA0gzV?=
 =?us-ascii?Q?Ki5xJVfQsaKPk8WZXRWUEInciO2tE2Q9+PKpQZrpHUZYCNmjLumIR0ZbfxZL?=
 =?us-ascii?Q?NaX4ZM0TvsxOzBrnOfk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:31:42.6097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa89ba3-da4a-4548-72ed-08de21ce4a52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

From: William Tu <witu@nvidia.com>

Dynamically allocate async ICOSQ. ICO (Internal Communication
Operations) is for driver to communicate with the HW, and it's
not used for traffic. Currently mlx5 driver has sync and async
ICO send queues. The async ICOSQ means that it's not necessarily
under NAPI context protection. The patch is in preparation for
the later patch to detect its usage and enable it when necessary.

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  6 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  8 +--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 67 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  7 +-
 6 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 9ee07fa19896..3a68fe651760 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -779,7 +779,7 @@ struct mlx5e_channel {
 	struct mlx5e_xdpsq         xsksq;
 
 	/* Async ICOSQ */
-	struct mlx5e_icosq         async_icosq;
+	struct mlx5e_icosq        *async_icosq;
 
 	/* data path - accessed per napi poll */
 	const struct cpumask	  *aff_mask;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index a59199ed590d..9e33156fac8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -26,10 +26,12 @@ int mlx5e_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 		 * active and not polled by NAPI. Return 0, because the upcoming
 		 * activate will trigger the IRQ for us.
 		 */
-		if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &c->async_icosq.state)))
+		if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED,
+				       &c->async_icosq->state)))
 			return 0;
 
-		if (test_and_set_bit(MLX5E_SQ_STATE_PENDING_XSK_TX, &c->async_icosq.state))
+		if (test_and_set_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
+				     &c->async_icosq->state))
 			return 0;
 
 		mlx5e_trigger_napi_icosq(c);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 8bc8231f521f..5d8fe252799e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -202,7 +202,7 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
 	int err;
 
 	err = 0;
-	sq = &c->async_icosq;
+	sq = c->async_icosq;
 	spin_lock_bh(&sq->lock);
 
 	cseg = post_static_params(sq, priv_rx);
@@ -344,7 +344,7 @@ static void resync_handle_work(struct work_struct *work)
 	}
 
 	c = resync->priv->channels.c[priv_rx->rxq];
-	sq = &c->async_icosq;
+	sq = c->async_icosq;
 
 	if (resync_post_get_progress_params(sq, priv_rx)) {
 		priv_rx->rq_stats->tls_resync_req_skip++;
@@ -371,7 +371,7 @@ static void resync_handle_seq_match(struct mlx5e_ktls_offload_context_rx *priv_r
 	struct mlx5e_icosq *sq;
 	bool trigger_poll;
 
-	sq = &c->async_icosq;
+	sq = c->async_icosq;
 	ktls_resync = sq->ktls_resync;
 	trigger_poll = false;
 
@@ -753,7 +753,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
 	LIST_HEAD(local_list);
 	int i, j;
 
-	sq = &c->async_icosq;
+	sq = c->async_icosq;
 
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state)))
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
index cb08799769ee..abc1d92a912a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
@@ -50,7 +50,9 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget);
 static inline bool
 mlx5e_ktls_rx_pending_resync_list(struct mlx5e_channel *c, int budget)
 {
-	return budget && test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &c->async_icosq.state);
+	return budget && c->async_icosq &&
+		test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
+			 &c->async_icosq->state);
 }
 
 static inline void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 80fb09d902f5..2b2504bd2c67 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2590,6 +2590,47 @@ static int mlx5e_open_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 	return mlx5e_open_rq(params, rq_params, NULL, cpu_to_node(c->cpu), q_counter, &c->rq);
 }
 
+static struct mlx5e_icosq *
+mlx5e_open_async_icosq(struct mlx5e_channel *c,
+		       struct mlx5e_params *params,
+		       struct mlx5e_channel_param *cparam,
+		       struct mlx5e_create_cq_param *ccp)
+{
+	struct dim_cq_moder icocq_moder = {0, 0};
+	struct mlx5e_icosq *async_icosq;
+	int err;
+
+	async_icosq = kvzalloc_node(sizeof(*async_icosq), GFP_KERNEL,
+				    cpu_to_node(c->cpu));
+	if (!async_icosq)
+		return ERR_PTR(-ENOMEM);
+
+	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->async_icosq.cqp, ccp,
+			    &async_icosq->cq);
+	if (err)
+		goto err_free_async_icosq;
+
+	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, async_icosq,
+			       mlx5e_async_icosq_err_cqe_work);
+	if (err)
+		goto err_close_async_icosq_cq;
+
+	return async_icosq;
+
+err_close_async_icosq_cq:
+	mlx5e_close_cq(&async_icosq->cq);
+err_free_async_icosq:
+	kvfree(async_icosq);
+	return ERR_PTR(err);
+}
+
+static void mlx5e_close_async_icosq(struct mlx5e_icosq *async_icosq)
+{
+	mlx5e_close_icosq(async_icosq);
+	mlx5e_close_cq(&async_icosq->cq);
+	kvfree(async_icosq);
+}
+
 static int mlx5e_open_queues(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
 			     struct mlx5e_channel_param *cparam)
@@ -2601,15 +2642,10 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 
 	mlx5e_build_create_cq_param(&ccp, c);
 
-	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->async_icosq.cqp, &ccp,
-			    &c->async_icosq.cq);
-	if (err)
-		return err;
-
 	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->icosq.cqp, &ccp,
 			    &c->icosq.cq);
 	if (err)
-		goto err_close_async_icosq_cq;
+		return err;
 
 	err = mlx5e_open_tx_cqs(c, params, &ccp, cparam);
 	if (err)
@@ -2633,10 +2669,11 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_rx_cq;
 
-	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, &c->async_icosq,
-			       mlx5e_async_icosq_err_cqe_work);
-	if (err)
+	c->async_icosq = mlx5e_open_async_icosq(c, params, cparam, &ccp);
+	if (IS_ERR(c->async_icosq)) {
+		err = PTR_ERR(c->async_icosq);
 		goto err_close_rq_xdpsq_cq;
+	}
 
 	mutex_init(&c->icosq_recovery_lock);
 
@@ -2672,7 +2709,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	mlx5e_close_icosq(&c->icosq);
 
 err_close_async_icosq:
-	mlx5e_close_icosq(&c->async_icosq);
+	mlx5e_close_async_icosq(c->async_icosq);
 
 err_close_rq_xdpsq_cq:
 	if (c->xdp)
@@ -2691,9 +2728,6 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 err_close_icosq_cq:
 	mlx5e_close_cq(&c->icosq.cq);
 
-err_close_async_icosq_cq:
-	mlx5e_close_cq(&c->async_icosq.cq);
-
 	return err;
 }
 
@@ -2707,7 +2741,7 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 	mlx5e_close_sqs(c);
 	mlx5e_close_icosq(&c->icosq);
 	mutex_destroy(&c->icosq_recovery_lock);
-	mlx5e_close_icosq(&c->async_icosq);
+	mlx5e_close_async_icosq(c->async_icosq);
 	if (c->xdp)
 		mlx5e_close_cq(&c->rq_xdpsq.cq);
 	mlx5e_close_cq(&c->rq.cq);
@@ -2715,7 +2749,6 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 		mlx5e_close_xdpredirect_sq(c->xdpsq);
 	mlx5e_close_tx_cqs(c);
 	mlx5e_close_cq(&c->icosq.cq);
-	mlx5e_close_cq(&c->async_icosq.cq);
 }
 
 static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
@@ -2881,7 +2914,7 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_activate_txqsq(&c->sq[tc]);
 	mlx5e_activate_icosq(&c->icosq);
-	mlx5e_activate_icosq(&c->async_icosq);
+	mlx5e_activate_icosq(c->async_icosq);
 
 	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
 		mlx5e_activate_xsk(c);
@@ -2902,7 +2935,7 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
 	else
 		mlx5e_deactivate_rq(&c->rq);
 
-	mlx5e_deactivate_icosq(&c->async_icosq);
+	mlx5e_deactivate_icosq(c->async_icosq);
 	mlx5e_deactivate_icosq(&c->icosq);
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_deactivate_txqsq(&c->sq[tc]);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 76108299ea57..57c54265dbda 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -180,11 +180,12 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	busy |= work_done == budget;
 
 	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	if (mlx5e_poll_ico_cq(&c->async_icosq->cq))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-		clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX, &c->async_icosq.state);
+		clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
+			  &c->async_icosq->state);
 
 	/* Keep after async ICOSQ CQ poll */
 	if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
@@ -236,7 +237,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	mlx5e_cq_arm(&rq->cq);
 	mlx5e_cq_arm(&c->icosq.cq);
-	mlx5e_cq_arm(&c->async_icosq.cq);
+	mlx5e_cq_arm(&c->async_icosq->cq);
 	if (c->xdpsq)
 		mlx5e_cq_arm(&c->xdpsq->cq);
 
-- 
2.31.1


