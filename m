Return-Path: <bpf+bounces-67998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE871B513D4
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4597F4686E5
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73289316915;
	Wed, 10 Sep 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0MYVZfU"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9330C635;
	Wed, 10 Sep 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499939; cv=fail; b=t8wN9M+nbvUo0vaFw1rwJ99QeyHIm7QZ1Yrc1FXuI7nM4u/57/eTFrven3DhJVxCUlsLTaVod+XZioxO20JeSTZ0MFNIqKguXpMGf2uqIjI228C2GiGAn1BtxPh2QxMqCvYYZW8JnIDrHJz/mAACQlgbhTzPJFspz8Kj8y917qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499939; c=relaxed/simple;
	bh=P1d3K8e9NGosJK3nnxXCFzCCmEtFYZaJXk06dhdy8tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdG5HI4L5cjM14WXe9UinCv0HrAThZtzEN49ze2rNfisVtWlH0kkGn+CSgQQncjwsEq+yPEwKtcE3nrYNvgNM0rFMioBaS02E2yW67YJ95E8Wr+/IyXvsLebdpz4/3O/1YrHuz53tuwaAXuABo1dnk1XE63byfj7ikYG5S9JKi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0MYVZfU; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMklkVw/sh/5t7ijLHVMTYR4Le5GZil3A+mmRDHbkdjsrPdNNGyCUrwvBkUlYJyLmgVnBtUYZclTh4dXNUXI/weOl9yDczTj6hM0s0Z68ij4eikylaqTGd8cZEPp4wMVyepSRBKuEGFWhh1FgfuIE6mTXjZsT70T3x7iKoIhT8aPPPQrmezaCNig8LghYIK4BvYWV2r3R6HrKrG5RTaYvJA1/TpUGf6T0u/M6mgSoSKM7xyzwwkZWtGTDAdqc1uDqE75e/wIsFafVICxvvCTbgYDbFSohBsf2B6ZyUoROA+M+OJMuc4BB47Y1d6DDQXfrawDazG9Zwax74sabZuOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia2pCsiipcnyk81IrtZjBhhe6S2s1pxR3vlzaq3jN2s=;
 b=ns120yF9k0DIZi/uFMVDppVVcTXHjyddFsoFkOviNgS8Ac/0kAyGzV6czTJ9Qz89I0KDZOhq6zCq7OO7V3Uk7RLVL3taP2HKyxbDNV9IY9z/9qhjPqAl5IiNUS8b+7cmi2UXhHj800TIuwg7VvjHDTuG/BCkeJeRqKhbg9N8QABfsSBeJtdou+Hv+9bJimkA8y/lxrSSTLoTxHjC1PtHHlyy7VLeXeUnNBDb+iG6uXWICdPhLWtkXgF9u98OAnmjfAwkU3nwuRACXzblggVMW9Z3t6vocFZdPvBExJ077SDW2SEsz4sU/tUIhfiz37WA08O0PCiis62wxtXHDPJysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia2pCsiipcnyk81IrtZjBhhe6S2s1pxR3vlzaq3jN2s=;
 b=D0MYVZfU28ZNBOQR8Im7Ugzd+IIheBd+ApABUkVyrsXSCrTaHSJRSq5AfTO31GDvqDiOsYnbD3tFTmfYkx0yA2Mbjsup0VFN6tnZ3srr1SrmJb/3JcmH91TP92BcLb/wYhxKaVaUGEF95zCHKjPieMY7jsmJWPYoO35kNir4sv63znKWNmtJc+W7TdTloP1Bm1B5ZsnxGuthnp4JPiuhrTQSCNEegQehF+Wo+97e5yj6hzTAQOE1gpvUtIPcbVm+1+kffsiczokFpD9vEho25jEBhoKZMXpIGEA9mOcphio7Lb07KmrF/QW2011qI6QwKRGy3s8lD4sXVk0x/0/JSw==
Received: from MW4PR04CA0329.namprd04.prod.outlook.com (2603:10b6:303:82::34)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 10:25:34 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::24) by MW4PR04CA0329.outlook.office365.com
 (2603:10b6:303:82::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:25:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:25:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:03 -0700
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
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 01/10] net/mlx5: Fix typo of MLX5_EQ_DOORBEL_OFFSET
Date: Wed, 10 Sep 2025 13:24:42 +0300
Message-ID: <1757499891-596641-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bbc07d-dbe9-46e2-8aa4-08ddf0546099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0EDjjjirK/MTnehGHYP2mGs1R0lln5ZovkYsYOpR2PdOI/7LeIyqSVr8ICzb?=
 =?us-ascii?Q?EyuI6Ppgbks2GFw0c4rTiOeACUkMNc7QX5Eo+YZwc9x3s2j+T/0RsHKskIx4?=
 =?us-ascii?Q?Pbm3rrLe9t70nwSWhQBQ5I2Ev4vVaf6Ap2JLXY1mQsXTDtxhm5TjujUewTuk?=
 =?us-ascii?Q?1C6aTJijJkQr6YxgHVd3KXjJ/Vu7sYD9lvA510X8FhVRHl5v/x74bXypzqXR?=
 =?us-ascii?Q?B+mSOD+TplRAAatKUZLXz4sa6oTWjP7VS0E8vAOhVVAc8uEcXeng6keG0iWU?=
 =?us-ascii?Q?uV88leNRQuI3NE7VVMfH0BEtbj+Wi9w6giBxNmAbX2TBsSbNAcwfq6lvhLsx?=
 =?us-ascii?Q?VZdaf8RM19GXef+/Oka/tdyMWzBWKxmCsSvqct3w6XL4hIycD3R0/i6Tzskf?=
 =?us-ascii?Q?MdYqjZUltd+V/aN0KCqq2xiBozCy3fxVRhbaxYz9jEd1/dmtNkGIR/d0fkaa?=
 =?us-ascii?Q?jSv1rqW9BrDyigoM2KtdJnKO3w7AZf5MAhb1A5Yg0MHR0N2Nrs+9FDYFktW8?=
 =?us-ascii?Q?/2NSd40ArFEPJPObE/Y0gwO7bY7RftovgIFe+wW5+ZSZBUt04BieSByfnWiI?=
 =?us-ascii?Q?xERRYY0wNBydbWVPb70ncY55lQJdw8ZI3JoYNr8T01sXApeTLZlx1KyauYJK?=
 =?us-ascii?Q?6xcdwPyZXrU/Z1IOtpHSBWhwVj6bAOCoO1a4h/jtF98YRpYzIpO0iooDUp+H?=
 =?us-ascii?Q?6OWLbQM7tddGFT7vwCBdrOLdrK3oOI0CIFTo8ongiTkYvVvDiSFdZlm20mhp?=
 =?us-ascii?Q?98gzsA+q9kcsHTK3AdAphaCt+kUrgFi9x5lEzkvfb/1o2snBP5654HMRDd/d?=
 =?us-ascii?Q?aoGLf8urlz1k3pDcM/BLo3qzDzL3cR9SFT68LSn6/Z1e6NjcStLX7pfmBujH?=
 =?us-ascii?Q?4xk7esWSYfDaltYvKFC/twp3Gbtgvzcy/Q2nkcAU0BUnPMbSCke7x4pcj9c+?=
 =?us-ascii?Q?WN980GBfvzFdM9TL/+cihSSyGkOSWCGLVErwP/Cp/g+FFDCyLMtDTsD+KDxQ?=
 =?us-ascii?Q?JlrLw6pgm/cG6ahWy+K02qXXUbBZqSPjbHMIhcMN8OJdzG+0PTw0aWPnbXCW?=
 =?us-ascii?Q?JmXRe+OPLurm2DZuUIQ6xTLaQL0d949Vsn5459ameSR1byLUEruYrQYDSrjZ?=
 =?us-ascii?Q?a2TzmUSceHWK/8sZ7+mYaipnkEMANZTunCp8czEm1wJkGwFcy0Jvb5yzwQy8?=
 =?us-ascii?Q?sri6hEljqynnySPQiRMGcu/USwRl+yvOh5D9K90l96NmQ7duLTgAnRsoHEvI?=
 =?us-ascii?Q?jOLGgiKYP0FAalVCPJ01kzwde6YPPhVRGVnoZTeaUJVeRvDfoN1sEgvnDI1l?=
 =?us-ascii?Q?9BZ9hwZF8DldnvyRUUaJHPoExvuRCwwEn//QBPnLUO2PxctpHaMdA1Zx3mCD?=
 =?us-ascii?Q?swNZgnXPf25PIZ6Wlbf0tmp9Jy0oHO1oTSi0vl+a0LhMaE78WjufJdEFLMZ/?=
 =?us-ascii?Q?8H/mpX9jEmeyu2ZM1bUw3MpezkknQfkbZcQEqF2F5c2+/6k/I4orkaOOXCvH?=
 =?us-ascii?Q?o/3+7VNGG4HHMcy+pxrNmvAdnViuOiDjm/CS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:25:34.3047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bbc07d-dbe9-46e2-8aa4-08ddf0546099
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

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


