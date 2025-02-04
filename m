Return-Path: <bpf+bounces-50401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A39A26FE0
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E480C188761C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3D20C492;
	Tue,  4 Feb 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eCCLJ26+"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77A20C46C;
	Tue,  4 Feb 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667234; cv=fail; b=LU4WIP1tX6nbb0VqAlhP68YqK4oRxCqEAztiOMcKRXP9Es/Ij7kxr198oyfZUXn2E3PlWNKNU+kCU8Jou6KUrhUlPXB3erbCKrxY7HO+NPs8TTvf3kv6TWLsT9jSXAuxwfP8a9wtmPkjOxGBNzoCMm/ZPEukrobKCp/QC4RkjWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667234; c=relaxed/simple;
	bh=/4DQILyiYr6xSEbWMvmwCNBaJv+b8ZydWRBm3vnyDu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTqNQWYNrpMMrNjK1Qrae8YwNzNSF2j9TRq1bprNzmfdy0q6SvJ7MxNI9tsSHQ4XQnlnPXrXr0vS89EPfOeCV2LHHEs+JOyZw6SlTfjm7nrhp6c8o47Aw2gusR3QMWL9SLEpZS10glm2TLZK5Oof2+OJ97oLRSWTEx69LG372ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eCCLJ26+; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emrygqkVq7KiK3FHmU6CdnR20GXeFvCsp6zIquaXKLh9fxtpxuyFwcCENPyGoWc4LQIsHvgYbk13IX+cs8r5vTObM3GVUjnapmKH+0GJlC5l09w1G/rFsiFbORH5+Df534xDZ1K//0m2mz7tt2YabsMlSWTWfxVe2gAVSBznJMcuoRURft22GGYphX8QVuGYOWnS+tPwDfZKWbAqRS6js3QIPNxXinz0ZL0iy9aCu0TzBa10jJFd5B5EVvfYiCFUj70Gg003g37s5f9sRB8AA93ZfR+ZtQJF2AYGHKJZ178NlQeQRJveU/ooCh7NG0DWEALXLzAVVbJDp2H/p9DLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ryObpfP71WFliXgb7BYRkftIYS3PuzKT+O8xOaezig=;
 b=mC2u5DTE3lmjTnCmcDxcTwgZGjpitKIOR+eGfs3DhcXKrD6VhqTUL0+2Al+5O0q20tOCHnJZst7BQMCR7oAGmAGLcAXALp6+23JJFjx4v8OtPGhXCMmXD+IQCXWB2bIIVgXC/fcWuRgZUekJBLhiy4fBY+0rjAKwMwSy44PnxnG6dZfCusKukeOdmw1vOnERAEhYni0KM7uRkusTgLOYU6sEsbiTj8JstLHn9NtWO3lFM3FhLk8nfwSqRqtpN65rdENLt/fkhYTkk3sf5NiF9rFjDw0VbInZ7ovuayEF6mXT2Ey/W2JSiJPdBl73kiZ+xvnbFxbJXefuFQmPsYLjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ryObpfP71WFliXgb7BYRkftIYS3PuzKT+O8xOaezig=;
 b=eCCLJ26+Ag05mw9/lwZr7jgCE0jNpyU5V/qc9teIVjNbzzF+R11+1Xgnk+ePqe6hWoGHGukvfYuowZ/HU3di4cCtHR1EVb2OXnBqBSIdok9WyLcsr6z98E/y0ixxjjXVRgc/IXE8l7aghp/UgIjX2Sv9PqhEJIw4uwdc9Q2GX5pSxaFSUExCKZVFqSDqaWAkOObf0c7wJ2v//NokYxgu/vgRpdgjhaklGQe98s/grDu7AIxdqb3bD5krPeDO7HMDs6TkRHnHRzlKK8SGfchulRSkSP+1awlNl7GS63c2NnRgKxWhPzH+okJBpLPwU2EyLtKO7Z1m+DZrQR2xMGOC9Q==
Received: from CH2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:610:5a::27)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 11:07:08 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::d4) by CH2PR08CA0017.outlook.office365.com
 (2603:10b6:610:5a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 11:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:07:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:06:58 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:06:52 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 07/12] mlxsw: pci: Add PCI ports array
Date: Tue, 4 Feb 2025 12:05:02 +0100
Message-ID: <45fad23a5d21df36ef77b3a5c3e8f9d8e09540f9.1738665783.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738665783.git.petrm@nvidia.com>
References: <cover.1738665783.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbf0236-4c16-4d23-e94b-08dd450c10ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3JEwqJC4OdJBk5iVyc5wnIP9f4DbtqE7EaUi5zPx+qpaAPlceUt5UUnUY41?=
 =?us-ascii?Q?Pwuku8cUQEdPNxgnXHgTs6EnX8aiYn/dZ67v6wnkejpfbkLhg0ZGsH9RKGcX?=
 =?us-ascii?Q?xqLAGIwnHBzy/2O6lZ1Lk4iJWfnurd0mI9vkCatImFMCnRjBSWe4WmXEtsfh?=
 =?us-ascii?Q?t1d7ZNZ8RL4GH0riSJFj7v1LX9RbdSowrZH8QmduzdSjtJdayDVugSxhMrhU?=
 =?us-ascii?Q?uL4vrA84MYgkS6zhVEIh7bqbwPUsXm6KaiPPiNSXbG78+bDNJ53+J6yy3b8y?=
 =?us-ascii?Q?T0YuZWiUT+/VkoA1NrSHw2Vr+DQBsuj7/ue4d0nLdn+lx23hmjaTyeQzcMdx?=
 =?us-ascii?Q?aTysg6ybLhkfB+m8ueSk8eeGk39lBdrsJJW4B/xwm7CxjCSWdThMVPcnxo9g?=
 =?us-ascii?Q?4JVFjLhR4nLIQrNfbOHCmzvLbotQSJL8Ke9kpZN8oBlAB6XT7DfPd2zC3xA8?=
 =?us-ascii?Q?JbnB3xqz2mba8ARyjv4+unzxYDwEGbX910tHIRaj7p8dcA1h5yifaU/xv0a/?=
 =?us-ascii?Q?WDFJzA40bRqOP9Lq5/+CESAf05L2f2Bihp/sH6tUckyhSMxXrMku9/LYjDjw?=
 =?us-ascii?Q?fMIK9fN4OBRdZXsfkev4f/yb4437gP12O6Z1/rC6BLaiMqxsZrdzkDF26YX4?=
 =?us-ascii?Q?Lh25OAaSiZ7SIt7z063AU3njsNQh3EJp7OGfCbNr2YnWys8jdeFM6cnQiOMB?=
 =?us-ascii?Q?6YBqkEo2aIH97q1PXNjewMGVjhzh7AiPZH+KtWrFcqL/GfsNszRdvhLgyUji?=
 =?us-ascii?Q?CL59Sky47Di8qhH0a5690IvfJkW7vjdXNl+anhAdFlDhg6/SOVOhc6E39J/d?=
 =?us-ascii?Q?Fs/zMlMhtkGZDMuq9i1JRSg0+9EoGdFUzWQCz5YBy/i4UJ+7NrPrs89vlDbd?=
 =?us-ascii?Q?9XKWfgkEJmL+do/n90oIBLBSbmFR+9d6nthZjnYW5LHphWLLjQJDnVKRTbfA?=
 =?us-ascii?Q?C5yeGiEEqewUW6AMcnL/NJZNDKa6Z18R2y9CzuHtkitYpbqBYkk9G+zkAuuz?=
 =?us-ascii?Q?H3VtDVjuExHtAPXSe5EE3b44Hf4V/xC9dGsW06xlLhJ+vofUQGDu3+aJ8xPC?=
 =?us-ascii?Q?tZUx/z+nTjxIWIodb6At7P+noGzYEendpCMo/dRlnzOSy9Gxp9kEg0Ku53Rx?=
 =?us-ascii?Q?HUO7lJ2O+Jp644frHLU4ktS2FbUtNtVTiU/duCJI/i7I3ciFtJrYxN1hDEGI?=
 =?us-ascii?Q?JZqcrQTfN5O52RgSKZlXARVum5DbAjpAdiq02Ww/CsdbMpohOCgWqfsmU0k7?=
 =?us-ascii?Q?mYj6WvgAYTNCg+GlzaKDKGfnsBoXLM5TStSCS1fwL6yr9mf59YrPTT1wx9WA?=
 =?us-ascii?Q?UxxRR/vqa3dCpyv+kch3eCtwZHUflCTUhVJp3LSfOnDIQiA1nHbm4BUimCRS?=
 =?us-ascii?Q?Vw4VI316CQGULuKHOFdLkf34WxEgMKi8q4XEYJ8eiNfdrwTTwvG9KZYWdi3s?=
 =?us-ascii?Q?jdOP9URYVhCYo2PAxiFdWxmZGNuQCwTKdatg4zao0hBN/92zV12Mmr+JJSPg?=
 =?us-ascii?Q?XlJXoBY5gjg93oE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:07:08.0998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbf0236-4c16-4d23-e94b-08dd450c10ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247

From: Amit Cohen <amcohen@nvidia.com>

A future patch set will add support for XDP in mlxsw driver. When a
packet is received, the Rx local port is provided by the CQE, and we should
check if an XDP program is configured for this port.

To allow quick mapping between local port to netdevice and XDP program,
add an array of mlxsw_pci_port structure. Allocate the array as part of
init, according to maximum number of ports. For now, this structure only
contains pointer to netdevice. Next patches will extend the structure.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 8af4050d5fc6..563b9c0578f8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -102,6 +102,10 @@ struct mlxsw_pci_queue_type_group {
 	u8 count; /* number of queues in group */
 };
 
+struct mlxsw_pci_port {
+	struct net_device *netdev;
+};
+
 struct mlxsw_pci {
 	struct pci_dev *pdev;
 	u8 __iomem *hw_addr;
@@ -138,6 +142,7 @@ struct mlxsw_pci {
 	struct net_device *napi_dev_tx;
 	struct net_device *napi_dev_rx;
 	unsigned int max_ports;
+	struct mlxsw_pci_port *pci_ports;
 };
 
 static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
@@ -186,6 +191,24 @@ static int mlxsw_pci_max_ports_set(struct mlxsw_pci *mlxsw_pci)
 	return 0;
 }
 
+static int mlxsw_pci_ports_init(struct mlxsw_pci *mlxsw_pci)
+{
+	struct mlxsw_pci_port *pci_ports;
+
+	pci_ports = kcalloc(mlxsw_pci->max_ports,
+			    sizeof(struct mlxsw_pci_port), GFP_KERNEL);
+	if (!pci_ports)
+		return -ENOMEM;
+
+	mlxsw_pci->pci_ports = pci_ports;
+	return 0;
+}
+
+static void mlxsw_pci_ports_fini(struct mlxsw_pci *mlxsw_pci)
+{
+	kfree(mlxsw_pci->pci_ports);
+}
+
 static char *__mlxsw_pci_queue_elem_get(struct mlxsw_pci_queue *q,
 					size_t elem_size, int elem_index)
 {
@@ -2088,6 +2111,10 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	if (err)
 		goto err_max_ports_set;
 
+	err = mlxsw_pci_ports_init(mlxsw_pci);
+	if (err)
+		goto err_ports_init;
+
 	err = mlxsw_pci_aqs_init(mlxsw_pci, mbox);
 	if (err)
 		goto err_aqs_init;
@@ -2105,6 +2132,8 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 err_request_eq_irq:
 	mlxsw_pci_aqs_fini(mlxsw_pci);
 err_aqs_init:
+	mlxsw_pci_ports_fini(mlxsw_pci);
+err_ports_init:
 err_max_ports_set:
 	mlxsw_pci_napi_devs_fini(mlxsw_pci);
 err_napi_devs_init:
@@ -2135,6 +2164,7 @@ static void mlxsw_pci_fini(void *bus_priv)
 
 	free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
 	mlxsw_pci_aqs_fini(mlxsw_pci);
+	mlxsw_pci_ports_fini(mlxsw_pci);
 	mlxsw_pci_napi_devs_fini(mlxsw_pci);
 	mlxsw_pci_fw_area_fini(mlxsw_pci);
 	mlxsw_pci_free_irq_vectors(mlxsw_pci);
-- 
2.47.0


