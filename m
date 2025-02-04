Return-Path: <bpf+bounces-50405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B556A26FE8
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABFA3A2F83
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C220D507;
	Tue,  4 Feb 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHc0yxcz"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4320C039;
	Tue,  4 Feb 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667254; cv=fail; b=mjMlQn0LF/Jhx/1X1USakKf+eqT8o8HXSxTqS6JJ98Zg926Mw1nMQ/JNAZiaOTk5tkSWrhU/+o2gx99TQkcRPuU3Pps/d8jp68SRcanGNpmO/1aMAxXe67UaNDF0zGKsbTaUEoDyvDIhtKuZ6EqTbUc/iOkRmauJHgLB9SoHI5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667254; c=relaxed/simple;
	bh=rkiWfrR+KUFl/NL8q2+zFEPlhRx2fOgQWzbKf+IaWxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbtgiLYAyPj/F96VHJddRckisx1vAqawHhVp9A/HzOgVeOv00OK8m/rS110ZHV3o3CLzFLOGDgxkiOuHNXxm0/UaTSB0VNVYbtMJwVvXBxJcZ5qtrPTwX54X/YesAet/+F5WWIcuLuxmbEEFsCf50SOxO8Ksc7aC/Sz1G2K7xek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHc0yxcz; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtStkQgRjVNtgzpBcdlq/mOmL/9wyhctlMPu/kESH4yK3fH2lO+u/6FEzNV45Yq8Jm4aosMg8qzseGemn/v+XnqaV907jCQj7EZyrkaQLldoB6/G4LkySNOPc9LYYIbWl/N2s/8D/Bj/doDuMLzVRk6n23l1RaQwq5VoHFAYyTxxqu3yNuooxJL65IWk6F8oyYZTYztSS3EJE+EBzXXmlo8aU6kYqCrIYZSUYbh/MB7JssVcfimbtl3xdHC+MeCgXZTgg+V9ngDG5dfBERJl8n6l9i4d/tn3hRYlgoW8HZPKwQ46KNJFgqxTyk5oWWzuImfYRtJiaZ5/b0v9+V+IlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0TK+GU9N+Z3H0axfVgoAKj9kL8zQoZTc0Q0bfD3AEM=;
 b=ETXClXftqHfVr1iOyhx/SgM5/fVaxlto1seLgy9s3hMQ2IUHcLQyktVUd0bqf65ojZb43TNzvvfn3/ij8WD/H15+1cSajuWiAf4GjZzZmkYTr4frM2tDSHtWDuNdK5JKBeVp51NHbGNTRBxh5UvLLvjyF1SvM4bcDxsHbh5GnZNr+vQRt5QgaYZV9ImsbtmDYIqXl3irOxCc51xzDHFywPOZfO8f07Dn5zGBr+/IZ1CfOAiVC4ZY72ZbCo+1VcmRjV43K9fAJmzQRht1gc/1uoY/U6Yg+G4USCRzKXVHCOfszragTFlWnCMDHkKLm4m1UomQ2N3bIBQpjA8OEQB9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0TK+GU9N+Z3H0axfVgoAKj9kL8zQoZTc0Q0bfD3AEM=;
 b=AHc0yxcz6mfJ6kZGOQyT5Dz0H2qULOZS9rxiaIh45p9vOiqRtN4+Bui1VZUG0ESCWlSTiM4l6i1b6cVDMxw+QPO5tmG0kxVmLEsyHfFFO8cXJf2BcyNytpB+9pf+L8E9DpbIy2mS4PC1O2IF1Y0uUG4UhRb8sBTNtXMqrpUqxrL43z8VKK9Bm0Oq3QMSsBvENU46nMPXU/SZtTNqRm/OraNGoac5rihROFqPARkuydsIbkpmyLfAY3CO7bvvxETV3dDsUfZnNrsg6ZwXdnayS5g6PWB9A4ffNA18L0KZq4ViVXLZ8JN/+UGUMB+vf3+mB/MV4g/fNmL7oDwI3uVnnQ==
Received: from CH2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:610:53::32)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 11:07:31 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::d7) by CH2PR17CA0022.outlook.office365.com
 (2603:10b6:610:53::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 11:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:07:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:07:20 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:07:13 -0800
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
Subject: [PATCH net-next 10/12] mlxsw: spectrum: Initialize PCI port with the relevant netdevice
Date: Tue, 4 Feb 2025 12:05:05 +0100
Message-ID: <d78893cf20ae2bf899f474c458998a850a14d27f.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 25979221-4e4f-41b0-2c85-08dd450c1e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XSPFWWOcFILM4QKlGW6pDDk98y9UNIGUmck9llab3jMHSJ5grllyqCf9jkA/?=
 =?us-ascii?Q?1VaOJGCfzOF4yBBsl1YJN+AvVMuDLo832FUEn6lS/ThrOv14W+qy+U3rWY+Z?=
 =?us-ascii?Q?LjdH+Hk0fP8G7VoE6/Cgj6/t32vIILrWrQlcrwllt/y6CGWFPafDAQcqnvq7?=
 =?us-ascii?Q?y84gI4fXPWT4V8MQgOsSz6F03/AR6e1KCKAS8CgKLtevZ6mszC+Fpgx1TK6D?=
 =?us-ascii?Q?ztCN7XWsBzftGdyURGpHo1Ox1wJPHZXEsEe8wHblflXHODwkSiQh8lKkiqXp?=
 =?us-ascii?Q?FvX/fry3+m9eIGGhjyvwCB98GS8RbsTDFiG1LYzOvIuJMvJNyC1S0DJZ8kT9?=
 =?us-ascii?Q?54L0L8HKcm5FmcuEkXDdhdfMYTPT2gvIPRuaEQg45n1O2CGO4QHAv3Hd6OSY?=
 =?us-ascii?Q?eGJ0wd0Z4TxXxERLmDOz08JZB9x20papMg5uptyyXtDboXAAhhBWVAK+itXr?=
 =?us-ascii?Q?taKzaDbJKP2h1Af/EFd87uB4PY7wWVxax/5SWyAf4/+s4T8Yq1NLgqrPX713?=
 =?us-ascii?Q?3Ggp9CUFjDPPXkhYIFqYFUw9efbyAHPL/CcxkGuEHxq6fd+jngRUUm3EhI9i?=
 =?us-ascii?Q?6A+mVvPVpivsEkrQgLkyDIisWNoz1I5ITaILN/sta5PllOVa7uCQAVSXIEs6?=
 =?us-ascii?Q?BeomkN2dcSs0gw/yzr84zlLcyaBw+rkiuODf43rjW6ufEPDtUQKDFKkcvOlK?=
 =?us-ascii?Q?gTb8Xnsu+3AFQQHJ0Cu1o4B6Lw5V/Gz1/29RjgztSfYnN2yOW5CoOx+MSkVW?=
 =?us-ascii?Q?OyJtxJgHciFP+6D64seFYx1+wPP3P7b7Zpry0M4Lslf6pmoKhfmWnJ9fdTlF?=
 =?us-ascii?Q?NhmGFtxOznP6VqJYDOfZ090iKA5b92Z5Js0SB9I5J7LzjcQX2PHk195rzZ5y?=
 =?us-ascii?Q?ypiXxWtp6tRAgce+bb8uoLWqQ3Ip+v5Li3YK+6o82rEbcIBdWUjURPSDCZ3h?=
 =?us-ascii?Q?vGXY1oYpiqZNB8hNpj2OFrVnRrT7g84Slckb+my9YiILP5664XkOXHt/6B0y?=
 =?us-ascii?Q?vzk0Qr2Qib7NezCWSOYX1rZxxmE9JrN1iyv2vEOZWY/53ulmZ+lztpdk3MJ4?=
 =?us-ascii?Q?KwwT5lPF5ZYFrblTFQNV7Ly7B+X5EOGrtb2CIIE9a4gERopF/p2h+7xxkDHD?=
 =?us-ascii?Q?3eoh2JueOHJ0fp5kFitdnmbJpXT6DQwYU2dm3yMno3oPZz/7jL0HcECmDky7?=
 =?us-ascii?Q?POcbNHaF925LzOJrxb2eLHHmmRS4SREq5RRO4/c3LvNmMzFCAWx/Wm97u1J0?=
 =?us-ascii?Q?TvylO5EAcC5RLLYNg2FM66QDgVZE0Y7YcW6c+SdXHfbWINb6HM0dexdosuCu?=
 =?us-ascii?Q?S4z/YRP/kDxqr+oaML3O4FbmTLFRspSoREZ+S39opEIgWkywFSCC4kCYPDey?=
 =?us-ascii?Q?Fq0yqvoLBBLxOEcNIgxDcQGPs4ioHE3MnixS0uTEodlWMfbdCP1aDOtmTLm7?=
 =?us-ascii?Q?07k0pPYt0vy1fkHvByEcaHrHLLJHBJFBeYKkoSBeQUfRMqhNpWI6/ql31BnH?=
 =?us-ascii?Q?nWV8nQuXBouZOXs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:07:30.8672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25979221-4e4f-41b0-2c85-08dd450c1e7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315

From: Amit Cohen <amcohen@nvidia.com>

When a netdevice is associated with local port, set the netdevice as part
of PCI ports array. When a port is removed, unset the relevant netdevice.
This will be useful for XDP support, to allow quick access to the relevant
netdevice given local port from CQE.

Init is done before the netdevice is registered and de-init is done after
the netdevice is unregistered, so there is never concurrent access to the
array between the control path and the data path.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index d714311fd884..6b77e087fe47 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1543,6 +1543,7 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 	mlxsw_core_port_netdev_link(mlxsw_sp->core, local_port,
 				    mlxsw_sp_port, dev);
 	mlxsw_sp_port->dev = dev;
+	mlxsw_core_bus_port_init(mlxsw_sp->core, local_port, dev);
 	mlxsw_sp_port->mlxsw_sp = mlxsw_sp;
 	mlxsw_sp_port->local_port = local_port;
 	mlxsw_sp_port->pvid = MLXSW_SP_DEFAULT_VID;
@@ -1758,6 +1759,7 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 err_dev_addr_init:
 	free_percpu(mlxsw_sp_port->pcpu_stats);
 err_alloc_stats:
+	mlxsw_core_bus_port_fini(mlxsw_sp->core, local_port);
 	free_netdev(dev);
 err_alloc_etherdev:
 	mlxsw_core_port_fini(mlxsw_sp->core, local_port);
@@ -1793,6 +1795,7 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlxsw_sp, u16 local_port)
 	mlxsw_sp_port_buffers_fini(mlxsw_sp_port);
 	free_percpu(mlxsw_sp_port->pcpu_stats);
 	WARN_ON_ONCE(!list_empty(&mlxsw_sp_port->vlans_list));
+	mlxsw_core_bus_port_fini(mlxsw_sp->core, local_port);
 	free_netdev(mlxsw_sp_port->dev);
 	mlxsw_core_port_fini(mlxsw_sp->core, local_port);
 	mlxsw_sp_port_swid_set(mlxsw_sp, local_port,
-- 
2.47.0


