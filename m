Return-Path: <bpf+bounces-68508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F4CB59935
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B385171BE9
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACB321F24;
	Tue, 16 Sep 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5Zbu5tQ"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5E2673B7;
	Tue, 16 Sep 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031966; cv=fail; b=mYYJkAjyofJ/g+QQl/ghUfpaV6WJdwKJHLG/gCFXx1HaMzIKQDHmhmmnWagfgBOsQRGQOgMdlA3YDbW6nObF5wL3xayFKCSyJ++RdBjKLUETfL1DQoR803QHRpp0Ext4swkOmG+5nTrOVAlT5qckManoWgMfKe9CzCEOOxsZjb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031966; c=relaxed/simple;
	bh=P1d3K8e9NGosJK3nnxXCFzCCmEtFYZaJXk06dhdy8tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2WUTptQplfEP0XZ9J/nXc3FTJCUkOVnDfrOcTfdnw+QXufqxeI1djKQp/3GtmPlolr1qgpuY1pmLs+jOH0ngpZbFoIcy+oKBiyB1hpQPCXEyWUYjCXsg1LmM63xIQqtquY2YlUcH+It2TI2qPpNgH1npJyOdZvGqOp40vEEaV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5Zbu5tQ; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ods2M4Yl2zbg19ty4dBtQKDYTvOT+WV0uspgvUKKMNWth+qUBL7iA+iLdNiG2ZGV6PwMeQ3vSXJKV0e9zCSC4M/C6iRz+nL86QuuHtzGUSSd93Aup2opIBcrlp4b6uHeqJHtRNyB54C9RR7FHAHHwINi0pnKcnCDvJsEhSG2OFHkWE13OLO/NsBFv1t23C2fTk0Na5tBOPNuf5YvJJEMg0svbuSILXex8JrGlIwwmT+FCQa9YyzBnmW008HM3Y7kncD9BUqpn3+7qZmnam/nH+9i128eH+DHJeC0r05T8SDZIK7AB+f4OzMCf9H5OS2wKtxw8qqZ2ELFIbGGsCycCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia2pCsiipcnyk81IrtZjBhhe6S2s1pxR3vlzaq3jN2s=;
 b=ZJVHXKtxsdgLgsg6aIueFaBNKoX/DQjRjsjwAHgY6NrxkED7tiNTXjNED8LxBL71SfGoB1E1gOsUZxychuoLlhL4nGh8k6Nog27BeOIba/3b3h7YCGkwnqc2sTpOppK6v3J+x8/fbx6yXSo/ER6B9QtzJGBhOA04w0/2ACfcJFqF2VPeawSTvvmJuq9piHvqpWmLQAelGTcUsKsGFNMij0p5ksEGz2bOwGXjnoCleEui29suxiIOBVy24wVUHqgydEFmihxUUXfJb/1hrpdTxm6yG9YnkP9erGbgsmP19rGmeihYiGtfLhEBkLMPa/AiogXpoR0B6i7ZN7Qve5WS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia2pCsiipcnyk81IrtZjBhhe6S2s1pxR3vlzaq3jN2s=;
 b=O5Zbu5tQ3u1131GLkgC+ldHoKrFyI3uxoBjl/agATT7dIgcAbFzhL7jG5MEatmSeLypGJ/yjAX+Jk5XCza/fHpWi4N3n8Dqjg8VVgVqCLaIDe5r+m1aBU5D9lKGlz6JJFYxUceUQPpZFJu41n01E583tkXrVAjG2Me7EI9s/rtfEM3UTE5jHgEFPt3VU2ccPvQ2hDw/gQU0JjvZPim/IPoi6AMIE5T+J/ocKgYL0gcEN3ViLwO7DvxNoP4iesbTqT2Q64buazouyF0u0gXWjnaVnxkD9u0fD1nbai1rV19UmgeA5BEdSpzd/PW8/RG43bIyRofRKQAnrybkrIEjuPw==
Received: from SA1PR02CA0013.namprd02.prod.outlook.com (2603:10b6:806:2cf::11)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:37 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::65) by SA1PR02CA0013.outlook.office365.com
 (2603:10b6:806:2cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 14:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:12:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:12:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:12:09 -0700
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
Subject: [PATCH net-next V2 01/10] net/mlx5: Fix typo of MLX5_EQ_DOORBEL_OFFSET
Date: Tue, 16 Sep 2025 17:11:35 +0300
Message-ID: <1758031904-634231-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a592e60-953e-40a6-de6b-08ddf52b16a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qn7sfnyRLHH0FR8XL6pzVtdoepfZez4RoI7NqucHmZUartgaUcQJyEtX2j5J?=
 =?us-ascii?Q?fNYVFrdp//0FSToAgIVTsxOE2s7RcQDrVI5Kna/DHE3BOdMtFbF6q6PHiwZs?=
 =?us-ascii?Q?zVL6gXXuJow1YhwHd3kMuXlJAEwLME38Onw1mvSOXpodjSBlOjQN/CweYX9o?=
 =?us-ascii?Q?GEnn2yHGOz6AOrcBPqwfmAjqIseFQcXvZXI8Nw4KF818Bp+7VU/gHs8x9GMG?=
 =?us-ascii?Q?O3xA+OmR8RmkjvYVY2yfSVl7zMEF0nFLpT1fzzkoSFpgmMlgY3AzSWHSQiUt?=
 =?us-ascii?Q?VPJGbaCGX1XSB41GV3bIDG/HfBZLqFgRB4E6fFQBUtMDazJjUBjALMIbo3nA?=
 =?us-ascii?Q?m2g/6j1hLaMiub0rTT05ErFSHtBSah3L3UiFwhYJf2D978qdv0ceUk1WlkVG?=
 =?us-ascii?Q?hdUUz6qldQM6sf//8cntVA9JdlkSe5SMKaGI4wEmIdZD9LKVPB2UuaohFuf8?=
 =?us-ascii?Q?ug/BcLhdZ/L4mw6hevreutTP8r4AoaEvouMORVtnSw7aOIECb+5jOw6GFjLI?=
 =?us-ascii?Q?SC0s7W6UODznjDjfBSgCSxVvdOFns5HkE2OGZ1n4PJe7x70E1qtWBsUeZX6R?=
 =?us-ascii?Q?u4cZ/Pcj75EHocdDoMi8b3P1SLy4Sp9dWv6Cz8TPRAVvFFYlAgcievcKWOPV?=
 =?us-ascii?Q?WDvIBOvZps714BI0ATHF+LYPj3UYPthqM3MYzAxiQIzQEvlbXwE81ud+O6T2?=
 =?us-ascii?Q?w4ZVci7LpIGxG/sTPakFWJgOdK0CcZ00Gr+XtF7oY1UxPAraElmBRSD2DUzm?=
 =?us-ascii?Q?0pzhh57pPBnhCuaubeZWWzN3b53v+FTMFBOpfm1zMtqxY3TYfZ7UDuItJ3Kj?=
 =?us-ascii?Q?mVp1IsyqFiMysosd/CP+pgOIP0gxNsHW7df5WE5T+jmPQFy5Ug51n+m0twBb?=
 =?us-ascii?Q?0mIebhuH2Xv99KfUPf1P8RiHsnoeyja2XWCMP5jHeJVQeCStnPB9AriFTTac?=
 =?us-ascii?Q?BuGGv/nmiqY55I7aasvAYhbLoNsa3szWcm2LejP7DQFnMfymjWAMNJcvcas/?=
 =?us-ascii?Q?Q2OMxN3fU+C9RYJwhL1cb6qM8NLnkwJBr7StEmVesxrgR+lmra8pydsJk/N+?=
 =?us-ascii?Q?9kaAIXBrL86QEmnaeY1Qn/dcH8bl9G/dEKowjc0MDLQxeqgZWjD7p6C0SIuO?=
 =?us-ascii?Q?gaBr7Dc7/BnvYxL8hF3mSNG3cjyUyVmXXdrhQdNkQJSfOrCYBUDYqsS41ckA?=
 =?us-ascii?Q?xoySUvMdBiP5KR7uBDS6NUx1OIcwzKbnDYg83LudD7cyOf8LCgJcUU4jXM5z?=
 =?us-ascii?Q?RzYYqLc/nfwxigMLI6AbmGIp1ekm7PvhqjzMIrgP83ASkjvp5EROwOY0WIAR?=
 =?us-ascii?Q?rNepLZlSaQD2Ua6ampqQrhZ0wat2rbIcIGASpTU7kFn9PZ0IHDhdQpTI5TF9?=
 =?us-ascii?Q?NW4DsES7lQ1Ug3cTHy5GQ7Q6zTdkcCUcoqFXCAbn1gyR6+yzNHdwQzdq4PrK?=
 =?us-ascii?Q?U0NZlLK90PCli5EaTFOqKgsQXBd8ITpq3TICT5PNmONg1Z4+h87UBxqKIOsm?=
 =?us-ascii?Q?4i1UMoHUYxQYvG/ci18vaHZle7tvEELyuIzv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:36.7283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a592e60-953e-40a6-de6b-08ddf52b16a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68

From: Cosmin Ratiu <cratiu@nvidia.com>

Also convert it to a simple define.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 1ab77159409d..f3c714ebd9cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -32,9 +32,7 @@ enum {
 	MLX5_EQ_STATE_ALWAYS_ARMED	= 0xb,
 };
 
-enum {
-	MLX5_EQ_DOORBEL_OFFSET	= 0x40,
-};
+#define MLX5_EQ_DOORBELL_OFFSET 0x40
 
 /* budget must be smaller than MLX5_NUM_SPARE_EQE to guarantee that we update
  * the ci before we polled all the entries in the EQ. MLX5_NUM_SPARE_EQE is
@@ -322,7 +320,7 @@ create_map_eq(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
 	eq->eqn = MLX5_GET(create_eq_out, out, eq_number);
 	eq->irqn = pci_irq_vector(dev->pdev, vecidx);
 	eq->dev = dev;
-	eq->doorbell = priv->uar->map + MLX5_EQ_DOORBEL_OFFSET;
+	eq->doorbell = priv->uar->map + MLX5_EQ_DOORBELL_OFFSET;
 
 	err = mlx5_debug_eq_add(dev, eq);
 	if (err)
-- 
2.31.1


