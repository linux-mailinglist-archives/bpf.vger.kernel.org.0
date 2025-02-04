Return-Path: <bpf+bounces-50400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0379A26FD7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DA93A3BED
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB7920C00F;
	Tue,  4 Feb 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hb689KHh"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9D20AF97;
	Tue,  4 Feb 2025 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667230; cv=fail; b=UJaXt67T648ZJiyrXcZAHkZtxzRfLsaL9jr18NaAh1x7thOIOYF7U7FN1FYU+KQ6MySQwVCTExkD8LZgXIL+Z+SdNWe8r62Gvgeexrkml09RFgo8Q/G6DqRlNYoysd2C+iRys72CebF1xMZazUXIcJ2TfToCMdsobynWeQGtE/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667230; c=relaxed/simple;
	bh=Ckh8zfEQb+inPbHox5Qa2CUXY089DaUedcd7uWNTaDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0oScLLFCXyBWoOoejWM8F5tblMcUyswLiGrwSqbCfDRVXyBYB5zkJ8cwIjARtbnK6rK76uUWxk2x+oB0QNore6RmhyHosDFgh02+M0lxuzsbcCjvig8bTlYfbUgpN9P/d6Aoimsaaak67QGlLiiVME6O9FqG/nYXQUqplxa7Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hb689KHh; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUkq+fTgL6H3XNYb2yO7tEmkmcZbTjDUcDK6jgRo6CJ0aeRDCiKIIV9rF2gSaQ4gCSi5RfNZLSiBk1T0Uuv6Ie/jl7yc2ljnSJpc8aHV+xiUg5HiCyK2ChqsKiQOG0ZhEFK+360KzY9yOFMnxOJt9vhXD++r0aQHb3qC8ZLvV2z5DoC/g8tdo99fae438sJnsmnpsnobULdU/ZPo9p/2pp4Urhi/oYYuJXXgB4OHBbX8xM9N36tYJAfLXlVPc2+FuBCFibBxWjvr6qFN8Mc1Iem4BHv+L4FQexxEThq4ezdAePd/EzWZZwQpr1DZI0YNjlJaOtoCj+xlpfy9moI70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlSwkE8vrmL8j9yynUwTWhujeRUzs7qaHU02/lj8hkU=;
 b=GPVR/6pdp1k2L9ZN/FNtB8xW5SVmfdw/5YgCY6r8whEo76X2usKWOlnE5o3WlIMWGVXTHY+ZqqemdRCZU1OQEuS1UB9c6UfWb5uzzw8N2mMfU4ZDgQ0U0tY68hY0AW8rkcgWDnxbIzJUgwXOg6nPFDniiew3KlX/AJ2qEq4+44hVZdjLh6n+XtLBlX4oNxa4ky/VDccEWK1nLOzhAWkV/VLLJ1Joa57+OvH2reX9NfzjL74P76YCTfCC0+A8Aolm1VyKfXkGizKRp+ptYjN+OFnHH/3oo5mmoBOjnfmM+viT7k0LM7OajVaAc9Rs91k9Vn4/jgP5egtnK96wLro1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlSwkE8vrmL8j9yynUwTWhujeRUzs7qaHU02/lj8hkU=;
 b=Hb689KHhsH1pewxoifFlXnAnx0YtdTt4uIIFbnHc0wpLIlIGiGSID5YaXekZm5NwBDYmwKP39vis/sUw3UhnR6BvufXm4hhLlhPanBpMz4xZS5JKFdr99jkOI7tspf23lbbSW6HFbntwrnl5Tg/o9fUQ+YEhc5ULRMX2r+nAkzuOJhALnJ+hX5iNIaiLUuF3qV8m4yGUrmFlLAuK1nD6QFFGrhLh0ZPYowQWc4+/6fJG/AM9Ardxbm9ytWXp6jYnRXIsPkFBE1Vndf9z0LvLI3sfTkl5IMc3h7YN7enjGI+OIeMQcOr1LlZg8pGvET6hf7GY6z7FM4//eORJyAuG6w==
Received: from CH0PR03CA0445.namprd03.prod.outlook.com (2603:10b6:610:10e::31)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Tue, 4 Feb 2025 11:07:03 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::fb) by CH0PR03CA0445.outlook.office365.com
 (2603:10b6:610:10e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 11:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:07:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:06:52 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:06:45 -0800
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
Subject: [PATCH net-next 06/12] mlxsw: pci: Store maximum number of ports
Date: Tue, 4 Feb 2025 12:05:01 +0100
Message-ID: <1ae1ff81fcf24324e0371ba983bfbf121f923523.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a97c71-726d-4c01-1bf4-08dd450c0dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Rps/n7+bFovjMWRMwFrRyswOcnijp5lDG17PR4DEQPc5E0s6cDkAMMCbyZN?=
 =?us-ascii?Q?4SJlRwkt9nMokdSgn7k80/Lib+fK2MtYF4hNdsjQk0R2YktI7uti/1+JmPt+?=
 =?us-ascii?Q?BqRUmopEm8w0ATzX6R2kWYYfOYOAMbI+2PvfwLyXk2AswhHVOwJz2GyWc2Nd?=
 =?us-ascii?Q?P8oLooCc+OSEm0b3L8ruyoMW/s7RIKs23aIHwBh4+Kr0/H09eQsCJVslZN9g?=
 =?us-ascii?Q?egLBUvymrhD0UU8c3KPLTUiaDYTsqb/Lu1ALmdhR9NXMTM8KCxO+gzqVetQI?=
 =?us-ascii?Q?qm/lF1x0BLb8YMCNrzy2aiPLb6KWrPhyJqMzf5oOncMWdL8fyiMpyvSd3wfK?=
 =?us-ascii?Q?04+gKQvk6Rb2dl26APDnWZGCPy5QwHLH9J8v/qiLLsEM9NNe5AqZUnS4c1XJ?=
 =?us-ascii?Q?iD/xQOBVJWkTbaC5kpr/HUiO+UJ/sAal0r1PaW25uQsWhCGRqqS7dn1M+WHg?=
 =?us-ascii?Q?KJ4DV+2TOkVZVAPuHz89bu4GpnxwaNNhqYsufqrlLB8P5psXuCRLQeRrDWP2?=
 =?us-ascii?Q?MnOGBPpiqTIJct8ZYGM93S8xWcHT+KNc/xEWp/kin7QXi5xPd0ComLC2SBNC?=
 =?us-ascii?Q?eR+UgkZnpySfL3zZ0yfLRRhTqp0+otZlvmYwJecf0r2Btnyzf6fwym9g1Bpn?=
 =?us-ascii?Q?Ugedr9MQbyC4Y8nztaG2GruM7hxaMX4EoqU05Lgm3WvJOKDeT0bBp/K1qfEm?=
 =?us-ascii?Q?E000LiZr5XOvFc7tjJyjZaPPEEsvXHAC/KK2j6ZXriZUm7Exn2LZ7ExackpU?=
 =?us-ascii?Q?+fs9w/Bbgb2MFYpNwYuy/IBuMm79mONT4a1wAWSIQR2rABKfGhHemxpwG+a0?=
 =?us-ascii?Q?0wGlY/72wEHbI/m5ypjkhcEV6SvicOPHJa42C3At259c/K4v4HV7m14Y0jI7?=
 =?us-ascii?Q?KadycccK+7AauU6TlwRxiMwEBWwqTEZqQ72bKVF3kTATI3rMsmiVAsVF7EEh?=
 =?us-ascii?Q?rSeZcYdPGj60zVF5MoW/hiJZ1rimivOUKWfePup5p+orgB2tgAbtxF0Vngat?=
 =?us-ascii?Q?hJXJYgvlC8YeivlEpbhO8kIazH4Zm9fkWjf4OcgSm7vHP2LBydK5ZPc0kBOS?=
 =?us-ascii?Q?8/WhTkr7M7wCKiwH2U1nZmET53Dcj2ZJFmc6r2TUG0FFjxFxB8ZecGU2N6P7?=
 =?us-ascii?Q?oYCc1GFApe3CWOe0j6OljqFbLF0NnhFKxCFzlyHW6CuegxfLdFcPhW78X7sA?=
 =?us-ascii?Q?IShPtqjpgUAVY9aG1fyuOqAbj5wM/HORmse6ZYZsSdk/GqMaxCM/zYN5gHSR?=
 =?us-ascii?Q?SdySfNJ66+fVnfTMTIYZMLH9L6du3auP6eeiJEk7g/2KODCSyc9ufi8aITaF?=
 =?us-ascii?Q?1/K7PSeXFw9xERNppvoetqNIDGqLwnYYna0XIyE63qppjC6QXunp8RFHCLWB?=
 =?us-ascii?Q?24rHnNoXngXNpHtyuyhZW/aAgbbGtt/LJocNu5bJB80YorsCpPePlzsf741l?=
 =?us-ascii?Q?JNgyA+BtTre7CM1YBqtNUypmFuIMWJCpiYg6ysIWHOVIm8Y7ukbmmJeLUdkj?=
 =?us-ascii?Q?ohi0HA7/nlFV11Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:07:02.8582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a97c71-726d-4c01-1bf4-08dd450c0dd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

From: Amit Cohen <amcohen@nvidia.com>

A next patch will store mapping between local port to netdevice in PCI
driver. The motivation is to allow quick access to XDP program.
When a packet is received, the Rx local port is known, to run XDP program
we need to map Rx local port to netdevice, as XDP program is set per
netdevice.

As preparation, store the maximum number of ports as part of mlxsw_pci
structure, this value is queried from firmware.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 5796d836a7ee..8af4050d5fc6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -137,6 +137,7 @@ struct mlxsw_pci {
 	bool skip_reset;
 	struct net_device *napi_dev_tx;
 	struct net_device *napi_dev_rx;
+	unsigned int max_ports;
 };
 
 static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
@@ -171,6 +172,20 @@ static void mlxsw_pci_napi_devs_fini(struct mlxsw_pci *mlxsw_pci)
 	free_netdev(mlxsw_pci->napi_dev_tx);
 }
 
+static int mlxsw_pci_max_ports_set(struct mlxsw_pci *mlxsw_pci)
+{
+	struct mlxsw_core *mlxsw_core = mlxsw_pci->core;
+	unsigned int max_ports;
+
+	if (!MLXSW_CORE_RES_VALID(mlxsw_core, MAX_SYSTEM_PORT))
+		return -EINVAL;
+
+	/* Switch ports are numbered from 1 to queried value */
+	max_ports = MLXSW_CORE_RES_GET(mlxsw_core, MAX_SYSTEM_PORT) + 1;
+	mlxsw_pci->max_ports = max_ports;
+	return 0;
+}
+
 static char *__mlxsw_pci_queue_elem_get(struct mlxsw_pci_queue *q,
 					size_t elem_size, int elem_index)
 {
@@ -2069,6 +2084,10 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	if (err)
 		goto err_napi_devs_init;
 
+	err = mlxsw_pci_max_ports_set(mlxsw_pci);
+	if (err)
+		goto err_max_ports_set;
+
 	err = mlxsw_pci_aqs_init(mlxsw_pci, mbox);
 	if (err)
 		goto err_aqs_init;
@@ -2086,6 +2105,7 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 err_request_eq_irq:
 	mlxsw_pci_aqs_fini(mlxsw_pci);
 err_aqs_init:
+err_max_ports_set:
 	mlxsw_pci_napi_devs_fini(mlxsw_pci);
 err_napi_devs_init:
 err_requery_resources:
-- 
2.47.0


