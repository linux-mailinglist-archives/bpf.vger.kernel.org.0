Return-Path: <bpf+bounces-50402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED4A26FDD
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877503A3C67
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999C220C03E;
	Tue,  4 Feb 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FcgMVwjw"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBBF20969D;
	Tue,  4 Feb 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667243; cv=fail; b=A9C5xK48DVe2EpfBn3+e8N3HIwq3WKpP8LTJM3YusK1vLSifS73OV5Sgda6HGq41yQJ6pa+EGWfVo7FJT94rZDSJSLZIMSRmiN5kqMzrqS4lf3FtsNK8nGx997yyhSqlCKYu/hK7CfevF3VNn1FdxL0qpQhaBivm3SchjvZ+IYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667243; c=relaxed/simple;
	bh=ryeIPL6uxNrCYKkBt8jIUBY9rakKZpD4OSlVTHbOjwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPRT8+uTZyTRQ8MXKabb3UZaDpEoYvkHiXD1dpzDmqoQJdr9jV0luGPGpt6hTvAPQoL3r+TUxaNifWTQO4wYAbgCqG0KhMCddHS8REITcYxnYCOA5QF9aAVAETjCG58PtTHFRswdVeM1habUGP9dLuAUoD8f/rcR7+PAz/73Amc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FcgMVwjw; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9OSi85w5/yeINLhKC/7gpuOAb2BqjPjewWJfJ5UtDHagewvyXwGhcJHGTgPwivE44Dq9rcz06vUjtgDctkB+ijEnhJpT5PIP1qSuQFXRJi999EVxOXVkEs+uz9Xw1gQ8dacuhUByUvc66NVemo365Zm7nlrrQ3GRsPa5qUF7+sHG8iiETHbumxgIdy+dRyWIlxYUCpfXo4B8DJFjx9BogOIsbuBxuMfKHGkqPqBup988KfTISkHbHCq0XoL6R7Fry/X1/Shvpt82+1rdOodB4PYX8HYpNpJ6pYBm3EmNowMiT7Me70R6JroI8DvnZlTPbzjqAig+GoK1qX+dk3JEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rm/MMOXZF7OfC2s7bPfi47v+1B9lIACY6W+Q777PG4=;
 b=c85Q4stakRtOj5PTB4h1jQcqpNiEE6Ose4jZ/OfEKssGn7n7F15+e12PWnFsr+pR92tjhPtpZUsFUZyMfSIfUgwswsjiqoc4a98tQJO624xpZx/m1IbFxkQxb+FqjUf/hKP3WPZBo0W2/RwthtKmLMDZhEzlo+yrxnaitjhIY1Gfvxtz+kr9RsT53/JKnb42JYl3nHlR77ivkRi0c3hCXs4Prfh5H47mX5C87ndLEl8/i4+SbpM+LzDD/XZrTFst1DocxQepvZXJhfxbZ4Ai622oeRurR1LB3n6JEKxkGpjkn+u3H7xJcP29AWfVb9WRYFWWzhZQ1Q5dpnE+2SbAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rm/MMOXZF7OfC2s7bPfi47v+1B9lIACY6W+Q777PG4=;
 b=FcgMVwjwyAkjazVpSHRO+V5dmi6BbCG6O52F7vgTFd1f+BqMEFTpN2Z5NVHlU5kMLoKGmKcEW0nfTE4aHSXdzuywkNn6bOl7UNLRyIdbMIEPewbCYzsdUOzZUMIKcXPCHyXi/G3V8qirU/Oj86+KjqyhyAwN32BZ1USzKSpA7OogNgYKTy2rcnbm3X+tVmGDoy4nIZ584mKdR8f3dLZ2r/RkYnw0Xscttm2JQ0GAObSxrfgWBdz1C+rb2m9+vKscUqs75WOmlTqG4dTj9xcp33SGr/FD1DQ+gdrqmcUxKUt8kc+TKUT9xFPK3puhL30F3lLtSSSMYMD67nX/rcd57A==
Received: from SN7PR04CA0160.namprd04.prod.outlook.com (2603:10b6:806:125::15)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 11:07:18 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::f2) by SN7PR04CA0160.outlook.office365.com
 (2603:10b6:806:125::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Tue,
 4 Feb 2025 11:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:07:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:07:06 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:06:58 -0800
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
Subject: [PATCH net-next 08/12] mlxsw: Add APIs to init/fini PCI port
Date: Tue, 4 Feb 2025 12:05:03 +0100
Message-ID: <6189497bf72fc28c44c55195f7f7759755014dc4.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: c723be0c-1494-4281-3447-08dd450c16f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tiK21lPUhQJ8C0y7Yeg6e3hBvXgrpH8QWt/x7ZeBLPD9LmRXrymjM6JGsqK9?=
 =?us-ascii?Q?e48hylaFVyNqe2K3a+cqTGMbdE0uygvczxH4TzL/Frb4Kl0auQ7JLEFg7cHp?=
 =?us-ascii?Q?PeddwgxcHadYy9OhvFVD470uvtGiRP6sdojRt6skl6yXoNm5qa6DWSj1FDda?=
 =?us-ascii?Q?th+GQ5wIyBpt1ZUKkSjjv7JYBfP6hy8YdogvtaOEnjzgJsP3cz7qWe9vedar?=
 =?us-ascii?Q?yulC0cCSD3tBppU1tsaXEXZeTGdrzFBgBirJtDKB7UVkFMBHnNBl4yZ3qwef?=
 =?us-ascii?Q?MWZaj1BkkdR5joVZ3gQtAbX7HJ0s2APjQYgbf8pXHxhZLSrCk+KxW0GHsqvl?=
 =?us-ascii?Q?igEcDh3ZHxtBJ+zAWyVOpbfthQkBIIZuE2rBFiiRdbb5tkpWb/oaKoUioX7M?=
 =?us-ascii?Q?oM9yVcJ+cD/+SUPuBnRlcRnnzIBc3H+hCX687ownRBpeTKwzxBU8KNwedpdI?=
 =?us-ascii?Q?/GhPUkEnhyiCzSMwyicFHYpGKpXHFEHxh/E1MWXmHndRoaLiverZxDzfmy3O?=
 =?us-ascii?Q?gwWCX+aMKWynXR0dzAjfQqDml/6pevQrShkkk6IAvrhgIhNNiNNUd7qwqDx1?=
 =?us-ascii?Q?mFV8RszbEPBwlE3OfUrm5d2aDQM8DDn8YVfBfhPGtq5pJtKZBP1VULiti7C7?=
 =?us-ascii?Q?2XESK2QIg1h8cr44mJsqDLUBMDewnMENzoHZqoXjz/xRJ4tEFsnVCqAMrCPL?=
 =?us-ascii?Q?RO6VrzqNXaxfzEqLCnUQzIPdF9BI5xe6xBJOsUyzBJr2Av8/k2Z/M9B7FZdm?=
 =?us-ascii?Q?1gjaZ10ABrHtEvPYuTIN2x5FuHGmsyAN2HA9lSemeaBiGOyX41dIXskiA9qY?=
 =?us-ascii?Q?9BA5J4ncDDb9vK8jmpxWG+VFajVWM8ABEIz+QBeK8f+4GKAhzVbIkpcRVZkF?=
 =?us-ascii?Q?KnCmYr6GV4jy+aYwYm36IBsiUx+hCRyEI9VSBEfTVlCjs8ZDPm176tZa2ujJ?=
 =?us-ascii?Q?GIy5V6bMwOINH277LLV/RZQA6KL4igXsCzTlonpyc+Cs+xfpGVT0ZcE1mB8S?=
 =?us-ascii?Q?fLbRTLayyU2T2zg4hMU1iOQAGS8L+99ESKRbK5iVRlPP2+DRpPpw+qaKGWrp?=
 =?us-ascii?Q?ab/P+QPoIE/c4aaZFm+TrFSaH1vX1kBY0/TRDsV06obrbNt6O5uNIXcZ/0WF?=
 =?us-ascii?Q?DgYMmySyxczjVIuGUSB/rknFFPo9HecvohsrhkruVtJWrdbxh+JhuZY5BwwR?=
 =?us-ascii?Q?qjwPy6F3iT1uEwvHIK7T6VqFh/gk1MKkIrSGtsSFAHqABsEN0G3CmOJMgIxF?=
 =?us-ascii?Q?xBU1mffe+71u7k5PkrvQpii2eIi8GndzX8lM3g80LgHJO8pZB3v42qoalRUa?=
 =?us-ascii?Q?/gaNcHI7y0HPviXlDhZJWDu6DN7lak+L5/7fxA8Xn0EbbRIE+s31wfmqpxuJ?=
 =?us-ascii?Q?0yezKlzRZkavhRvIfZa1/OIzWvFG8hR+sTA3hPAsQAM2xF3iERyHMRALiA8w?=
 =?us-ascii?Q?7IVbtVRBwRP74utx/of6gyWtieaM4P4+B2l3XpEMq/LeVUXpkKRS9Pg8VOJL?=
 =?us-ascii?Q?fvxRHHoC5jKKLdA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:07:18.2033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c723be0c-1494-4281-3447-08dd450c16f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

From: Amit Cohen <amcohen@nvidia.com>

The previous patch added PCI ports array, to store the associated netdevice
for each local port. Add APIs which set/unset netdevice for specific local
port, these APIs will be used from mlxsw_sp_port_create() and
mlxsw_sp_port_remove(). For now, store only netdevice pointer, next patches
will extend this structure.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 13 +++++++++++++
 drivers/net/ethernet/mellanox/mlxsw/core.h |  6 ++++++
 drivers/net/ethernet/mellanox/mlxsw/pci.c  | 21 +++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 392c0355d589..628530e01b19 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -219,6 +219,19 @@ mlxsw_core_flood_mode(struct mlxsw_core *mlxsw_core)
 }
 EXPORT_SYMBOL(mlxsw_core_flood_mode);
 
+void mlxsw_core_bus_port_init(struct mlxsw_core *mlxsw_core, u16 local_port,
+			      struct net_device *netdev)
+{
+	mlxsw_core->bus->port_init(mlxsw_core->bus_priv, local_port, netdev);
+}
+EXPORT_SYMBOL(mlxsw_core_bus_port_init);
+
+void mlxsw_core_bus_port_fini(struct mlxsw_core *mlxsw_core, u16 local_port)
+{
+	mlxsw_core->bus->port_fini(mlxsw_core->bus_priv, local_port);
+}
+EXPORT_SYMBOL(mlxsw_core_bus_port_fini);
+
 void *mlxsw_core_driver_priv(struct mlxsw_core *mlxsw_core)
 {
 	return mlxsw_core->driver_priv;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index 72eb7dbf57ce..506fe50acdec 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -40,6 +40,9 @@ enum mlxsw_cmd_mbox_config_profile_lag_mode
 mlxsw_core_lag_mode(struct mlxsw_core *mlxsw_core);
 enum mlxsw_cmd_mbox_config_profile_flood_mode
 mlxsw_core_flood_mode(struct mlxsw_core *mlxsw_core);
+void mlxsw_core_bus_port_init(struct mlxsw_core *mlxsw_core, u16 local_port,
+			      struct net_device *netdev);
+void mlxsw_core_bus_port_fini(struct mlxsw_core *mlxsw_core, u16 local_port);
 
 void *mlxsw_core_driver_priv(struct mlxsw_core *mlxsw_core);
 
@@ -495,6 +498,9 @@ struct mlxsw_bus {
 	u32 (*read_frc_l)(void *bus_priv);
 	u32 (*read_utc_sec)(void *bus_priv);
 	u32 (*read_utc_nsec)(void *bus_priv);
+	void (*port_init)(void *bus_priv, u16 local_port,
+			  struct net_device *netdev);
+	void (*port_fini)(void *bus_priv, u16 local_port);
 	enum mlxsw_cmd_mbox_config_profile_lag_mode (*lag_mode)(void *bus_priv);
 	enum mlxsw_cmd_mbox_config_profile_flood_mode (*flood_mode)(void *priv);
 	u8 features;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 563b9c0578f8..bd6c772a3384 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -2434,6 +2434,25 @@ mlxsw_pci_flood_mode(void *bus_priv)
 	return mlxsw_pci->flood_mode;
 }
 
+static void mlxsw_pci_port_init(void *bus_priv, u16 local_port,
+				struct net_device *netdev)
+{
+	struct mlxsw_pci *mlxsw_pci = bus_priv;
+	struct mlxsw_pci_port *pci_port;
+
+	pci_port = &mlxsw_pci->pci_ports[local_port];
+	pci_port->netdev = netdev;
+}
+
+static void mlxsw_pci_port_fini(void *bus_priv, u16 local_port)
+{
+	struct mlxsw_pci *mlxsw_pci = bus_priv;
+	struct mlxsw_pci_port *pci_port;
+
+	pci_port = &mlxsw_pci->pci_ports[local_port];
+	pci_port->netdev = NULL;
+}
+
 static const struct mlxsw_bus mlxsw_pci_bus = {
 	.kind			= "pci",
 	.init			= mlxsw_pci_init,
@@ -2445,6 +2464,8 @@ static const struct mlxsw_bus mlxsw_pci_bus = {
 	.read_frc_l		= mlxsw_pci_read_frc_l,
 	.read_utc_sec		= mlxsw_pci_read_utc_sec,
 	.read_utc_nsec		= mlxsw_pci_read_utc_nsec,
+	.port_init		= mlxsw_pci_port_init,
+	.port_fini		= mlxsw_pci_port_fini,
 	.lag_mode		= mlxsw_pci_lag_mode,
 	.flood_mode		= mlxsw_pci_flood_mode,
 	.features		= MLXSW_BUS_F_TXRX | MLXSW_BUS_F_RESET,
-- 
2.47.0


