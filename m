Return-Path: <bpf+bounces-71145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99215BE54B4
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 21:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 794274E024F
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 19:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F262DFA2A;
	Thu, 16 Oct 2025 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5ulKVC6"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C032DEA80;
	Thu, 16 Oct 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644617; cv=fail; b=gTh8EaksXVMxS3gk8cIC4d8d2w/9OT9SmZmiA/TF9cVrLAZ1Os7knv8yuThuP/uyn4YuYHpwaA9aqZbi2dU5cA/fAtzQNOpIURe0FFsjjoM/UhlMfTTnJ+pD5yRUqBjUpRLLao0k9kmICZlKyBCX/3OM7YjqV0m3uDi0pdwG+k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644617; c=relaxed/simple;
	bh=JmZrnkKS8ApJkHGvKCnDPJta0d3RCENzcEChtUdYEDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQvW25KQx3pRzCxiZoPFMhMDD8RjBXoPbPSeTzrgoExjLfdWmzzpvT7MqDS7ddJ7H/OfJ+2wcQkfo2oc40vWi70L15FG6LZPORRR1Fuwzy2lBrZuzLC8L1hM9vXx2werdnyf4QYL337X2aAYJrSLcBRKJemwqkJDZKxkXQK0zow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5ulKVC6; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jirWAi2BkMFLqm4eOgjCQMuOOucDODDufXIXBpYOCNPAPowMIzLKL65CYNDGOl50ifyTRNurVjSVEriXLRMkB0it4ye1llHZxRADPLiuXIJ0MhcMOttI/FW2vFL75uwpkuXnaW74J/snTRJPaBnwYVieNC/mbh/ClW4+MbcHQNarV4yw7Vhfo/U8behuxGZVYXTD7yNKeZ4+uGf9wo5yE1x9aIc0X6yArcmFuCoTNEVM0bNAJjEd6CN86qik0jFfHnR5Yjg8G+QYkwKNzh+ihDiVIVsHVL3/aDTw8nta7cndiqHt0A/lWx+UrHgD7L1bkQ/9rmbKXbQpE7PjUoDCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqAImUwNoFuzioayIY+u6uFhdWsGvqnKHNJSAB+K92w=;
 b=XEs5XTT371y41RDI/EIhjLLgfabnDnqZ56E9qpc2vxTq7J5ASoT+mf32OgFkgeN+LVrxjJb7Nuy2QcWlYRDqVBiSh5ts6/yKXJiLw/GtGRPYMc/Q4GaFbW+B3P0RZFDTK2SwDkEXED+1eUuPxfvyflhR014ZVjEvZWVlQ4yrcNVIE4gkqMfPV8HUFSEAwhRzW4vukd1awK4OJcXJLgOB6PskfPDC1a/rUG7dF/Z35PJd9lSBU3DF+vfu4eu+1yREugKcNd4i6fohlc4k70DOZdvgYV4jrBIOxWfkg7Io/Zy9c6ZuHDRHDL0XJ7KpKRjc0O2eXhUuN77BoySZRQrp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqAImUwNoFuzioayIY+u6uFhdWsGvqnKHNJSAB+K92w=;
 b=X5ulKVC68m4DQpKOeqK60zWs9wv6/LN/JZ5VRa2UeAmlEnK3eqWY5VhdO4Si4RQZCvLAUuqC+JL/JxeLLuUxBdqA0UnfFinXrXMPCkL1X5Ztsp+LFYUAM2ok/XyP6bQJ3K2/msVSshTo5nIZXKBS5liYLTKWR9oR5+TESQ5XTEam/zPi7yhixutepQieEaY30xsjMr0FKZU6m3pvexmpFvlfsYl89iA9lzN5IABIwSOWZ36JDr/EFSIAorNGp5aVZBk30UPUiD5eGjIqJgx4Zx0t3bdwsBVvQjz138uz/UVJNkI5GXODHuq4L6ezK4J/2MzRrTA9f31fiCemnLIaWg==
Received: from MN2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:208:1b4::33)
 by IA0PPFACF832414.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 19:56:51 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:1b4:cafe::18) by MN2PR15CA0020.outlook.office365.com
 (2603:10b6:208:1b4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 19:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 19:56:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 12:56:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 12:56:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 16
 Oct 2025 12:56:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Amery Hung
	<ameryhung@gmail.com>, <martin.lau@kernel.org>, <noren@nvidia.com>,
	<cpaasch@openai.com>, <kernel-team@meta.com>
Subject: [PATCH net V3 2/2] net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ
Date: Thu, 16 Oct 2025 22:55:40 +0300
Message-ID: <1760644540-899148-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1760644540-899148-1-git-send-email-tariqt@nvidia.com>
References: <1760644540-899148-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA0PPFACF832414:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0789fd-e895-4004-255c-08de0cee2642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tBj5wNy90niIHc1DzOa6RbTTv+YZa4QhT45/a3uZtBjXl8UHVEYHffreiyc9?=
 =?us-ascii?Q?029M21vxScS9vUZB78EdRUa5zmQEmaX+w/8E4DRlkv/iU2jETI144EBDEsji?=
 =?us-ascii?Q?H/IqCuwn+FMUCqANCMERlOevr2T5111aHlCvQmoxtDJR3kiOB/8ZD035yXhH?=
 =?us-ascii?Q?svk2ztMPnt1FJ65rFKj/dNr6LaD5vQ92tDsxyl84EUf5TU97NaDVbRi1E4m/?=
 =?us-ascii?Q?4HJl476O/xhpkZIhVUA/+vCWbwnaFtQOfZJ7Q6pedcXp1tpiq49WKaaitTfa?=
 =?us-ascii?Q?RsV2UAjNm4bRtwY+9LQzK6HBLJsRjW7m3Fw0AYCOvvNwUkG0kDuAf1TodSBX?=
 =?us-ascii?Q?Ahi8QO0WS9cNhQG2fLg3JkjMGpNsWAkaf8akhy3KLku+Fq1nShd6GNUzRHm6?=
 =?us-ascii?Q?HTtg5AR9IH2Rh3O8P8uxMj5smnY9Rr8EIMrYG5oAeMXGCW5eI87/hoFU4wmT?=
 =?us-ascii?Q?Ci1hheC/WDrzluXnIaus1v5DB3BceBYqbldCyXs5/6M95rj/VyjX8k9FlAlE?=
 =?us-ascii?Q?zLQAjFNiu1uRLwOPNVA0zrASug4MvOutuqaG+ACeCEOIWzT5PXOSUw0kKlV3?=
 =?us-ascii?Q?ozQGfQBaIewwXsl22xbeMFQXOVVi/YOSKkeJqkBxy8K9ojUIeZbEHWF3jX/4?=
 =?us-ascii?Q?Wuz+2NpBhnNavquXVLTSKjBoWPKLpBhRgPayAUns44XI8KN6QM0xNB9yNXA+?=
 =?us-ascii?Q?SRoaMGKjFnfBTsbBKxuzOMpZla7vHnUaA9Ya18UKciUJ1Wk1Typ6WtGeoye+?=
 =?us-ascii?Q?L5VWL+qmd6QLVnYOJMB7g4UxDz3TJ1J+OTQn0wHHOdDEY5tle9zhOoZPxQo4?=
 =?us-ascii?Q?2k5MT/gs33njoeII3dFmsR9g+U23Zm7fZAyEEwv3zAPfrK1hr/YnXSP0q401?=
 =?us-ascii?Q?W3qhf5CCdc937xwDp4xj09X2QIsI/4+p43NYaK7KHVS+9pyVEBnNWKOH7kMb?=
 =?us-ascii?Q?2fP211YJNIjFgLezP0wNrJZSzL+w/QzjLqXyqMXaGhA/h8dNGUqqRLufHy8Y?=
 =?us-ascii?Q?/JQJLiHKl4sl4kHpLCULi6OW2KmHk1ZpyAvQhVreXt9QiWG259YH9lU2TOeT?=
 =?us-ascii?Q?kXBzsJaNq96MGizyhV/GzM+38HycrJyBwhv9KPehP8244mR3Mq+C4qrE17im?=
 =?us-ascii?Q?XSYyk2RC+JLmbx6M9PdeXbqIIsslmQoam1K7qbsHjQ2wCTweAwHWRQgJT9OH?=
 =?us-ascii?Q?D/yskNtztFh4kY8S6e+1GK5/B9z8FkZLTVccK7/ekNdh1cznWiRf5slIGB5l?=
 =?us-ascii?Q?EoTX7aJkOf6u4NRpGk8rpW4dW6oQ/2ypjLMNYmhEgNQdaFEM17SKdllOHTqX?=
 =?us-ascii?Q?CjdzjMMFOhpUvBluSoK9F8dq/CK6f8Y/mwVTRXTFCOIEnUXg2jGuniVmgZKp?=
 =?us-ascii?Q?VaXAlJcGunyJmqyjLTFj+xd8W56t7U0RM6sXFsAB0UXoR0APN4Q1EulqADAl?=
 =?us-ascii?Q?58xCO52GCpg9PYFlSSpSBVOQbwFuxzc0J6Mj1NIop5QV7VoxqpCPCnWrDx4t?=
 =?us-ascii?Q?pN7XeHyQAdx1ZufVEp7kb/2ZjU+yZhnQNvMlkdHMYHjvgG3C9yQDlQB/1Sa2?=
 =?us-ascii?Q?928vH4yWgyJ9TsvXIp0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 19:56:51.4765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0789fd-e895-4004-255c-08de0cee2642
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFACF832414

From: Amery Hung <ameryhung@gmail.com>

XDP programs can change the layout of an xdp_buff through
bpf_xdp_adjust_tail() and bpf_xdp_adjust_head(). Therefore, the driver
cannot assume the size of the linear data area nor fragments. Fix the
bug in mlx5 by generating skb according to xdp_buff after XDP programs
run.

Currently, when handling multi-buf XDP, the mlx5 driver assumes the
layout of an xdp_buff to be unchanged. That is, the linear data area
continues to be empty and fragments remain the same. This may cause
the driver to generate erroneous skb or triggering a kernel
warning. When an XDP program added linear data through
bpf_xdp_adjust_head(), the linear data will be ignored as
mlx5e_build_linear_skb() builds an skb without linear data and then
pull data from fragments to fill the linear data area. When an XDP
program has shrunk the non-linear data through bpf_xdp_adjust_tail(),
the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
data size and trigger the BUG_ON in it.

To fix the issue, first record the original number of fragments. If the
number of fragments changes after the XDP program runs, rewind the end
fragment pointer by the difference and recalculate the truesize. Then,
build the skb with the linear data area matching the xdp_buff. Finally,
only pull data in if there is non-linear data and fill the linear part
up to 256 bytes.

Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in Striding RQ")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 17cab14b328b..1c79adc51a04 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2040,6 +2040,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
 	unsigned int truesize = 0;
+	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
@@ -2093,7 +2094,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+		pg_consumed_bytes =
+			min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -2109,10 +2111,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		u32 len;
+
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
+				frag_page -= old_nr_frags - sinfo->nr_frags;
+
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
@@ -2123,9 +2130,19 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			frag_page -= nr_frags_free;
+			truesize -= (nr_frags_free - 1) * PAGE_SIZE +
+				ALIGN(pg_consumed_bytes,
+				      BIT(rq->mpwqe.log_stride_sz));
+		}
+
+		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
+
 		skb = mlx5e_build_linear_skb(
 			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
-			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq->page_pool,
@@ -2150,8 +2167,11 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			do
 				pagep->frags++;
 			while (++pagep < frag_page);
+
+			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
+					skb->data_len);
+			__pskb_pull_tail(skb, headlen);
 		}
-		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;
 
-- 
2.31.1


