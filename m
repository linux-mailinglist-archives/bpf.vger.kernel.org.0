Return-Path: <bpf+bounces-50396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ED2A26FCE
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E317D163064
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF520C028;
	Tue,  4 Feb 2025 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EEv/d7pz"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170B16B3A1;
	Tue,  4 Feb 2025 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667195; cv=fail; b=Dhf7O9+eOztuJ3X7Zeio1wBOOVzX9zIJP+MZgVZxoaYo62LRJ7X+ZsP7o+GAua/VMYKuJaZff9nLLvhfLX1C2psmTmjLDOKi0xYeiz0HvsHdV4gSRcRqMuPsfZH3OETwoey99TaQl3TO00mXKyvo9ryQ83WlACBPo5MS4gOFvMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667195; c=relaxed/simple;
	bh=uYJ1mQo3V3GkpW10JyG+o54MVcHYFg/MfzMd/2grJGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLW38ObtrBhb922254TynrZ2zFXe1KbG3kYZBbEXu7ii9GGp8J+jrLrzyprA0LFiDmdNfDMreGY7Fms6TR7p+91dg8xBwWPUfORf1TSMNGvKK+SgKktbtXoMGmwCVtbtdr8si8OpLHiZ/k6syQBhiLuZknWD7NyZAMyHn3pWWic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EEv/d7pz; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNPIc/B/5zYKsej1MPticjS+XRZq11BYj/jcWwMBxRAo0/jSmzDu92vhUR7G0ezmXdEWaydTCJU9yQT6wXfXHlmuxsR34EHpMaUjjpPlo0GIuE7mvE0TuOHi89AutG8oc2+3+omfA/+XYn3aDOzhoWEhR7+YW1yx0VLVH82GgfhFlDVw39+GEHIQGS+0onBcCKGUf8NAGzNYVjG+LR8hr9+d9EstZuB8YBxGAC7Zl1S0dyYiPIoTjtQP/yQQ7NE1pNQ5phaXzLzEX2/OyCkUSVruEetEajQ619Kelriw82xwFRUX3IPdXVEqc9ivRf+xNO68gOixbpO4JsB1UuHCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mybyFr4xYEuGQ8peGpikq7CI8ElNd0hrqP1Mv+tGIUw=;
 b=Ty9NtEmAc/S8SDWS4fILMPKOuWR3X33ytbu+iOqzdlmPkFZrAYdZo0jpFvTcGOAK19XpV1acUdKduAOu4sIjHu8psIHfXrfSKDQG8meqsJYeEweGb0dZe7r/dX04qdpjdyzv6EnPq7C1UKV7wY+xnc5olt3G/vvq45+6AtUWtr1KahpGwvdA/6x/sf768x1hFSBujUObDZp7Krx+3KUqHR6/Jq9MVH/gj5ap4BUaUR40rTOxRSoXh+4colBifUTB6fkz9jTNyOZNI6ASQQbfzUN9X4OUcWsbSH5cwPJaxmjmryEdXX/MQ6St/gY/bmh5SsjIMqDdsT4ZTrxj7J8SDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mybyFr4xYEuGQ8peGpikq7CI8ElNd0hrqP1Mv+tGIUw=;
 b=EEv/d7pzU040VlgZtkEg8cajDjmhhPePb02Dr0RalGSYK8syMNgaDXvpKANjhNId14sq+d6xZaW1/GRAjIMoDOjmo0DGyRXT39wv0TiH98kjOhum9vSPhiGTQCJBuV8l+u2fMVrejh5agV0pEa1pTytwZWcNljGTMtSjWxwPcgROr2hMj5RaiDcS6gCPN+vLJeKvkT8nkYkTr3NTF8AGI7tPaHF8ofeXfW4B3g2mV61EffeHBKqVJyqSV/nOEmb7VYDJcG5X1HOuXhhdRwyIQ3KmAfjHqQLZOU8twuqIju0HnFxMUyBLp/5edGPL6GeYS/ZhSHiWEEdZgd4beysk6Q==
Received: from SA9PR03CA0021.namprd03.prod.outlook.com (2603:10b6:806:20::26)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 11:06:28 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::ea) by SA9PR03CA0021.outlook.office365.com
 (2603:10b6:806:20::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 11:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:06:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:06:18 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:06:11 -0800
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
Subject: [PATCH net-next 02/12] mlxsw: Check Rx local port in PCI code
Date: Tue, 4 Feb 2025 12:04:57 +0100
Message-ID: <1178743340cfb52bb763d5c671d4c9bf320534f8.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 33eb6693-5ad3-46e3-b8fe-08dd450bf928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hB8o8Gq2H+1Ap0ZcLW+dsk78OeDbbE1AL9sudLMAom5m+AhSXCheIKFC2RhK?=
 =?us-ascii?Q?6Q1Ji1aEHsqLAB2HH2AdJKE/dZpzHpeK9izMyLYj61eN9+NlYBoJ1FiccYCA?=
 =?us-ascii?Q?pjFeRwgPBC6+P7LSRMALHOcM2/eFkTizkVyw03xQpH2pQL7DpUW4/aUk7GA4?=
 =?us-ascii?Q?ConkIRzs7thzknq5F4hfIt6fiITUHSjaEllKA3wmBEwG1r7BM22gvaFGI8oX?=
 =?us-ascii?Q?Le0UQgQnI50ltza5kWcnRq2Qe0kOe2S4eIyAISsoWAyZtsGoblEyo6WL1zdL?=
 =?us-ascii?Q?lujxjF/wE5xJrIJIJ0ToV4hg1aFhnTMFcheOHkhhav1t8bLndnq2DZD5Ri69?=
 =?us-ascii?Q?tUjlw8YaTNxTG/AQxEUFMVRIQx6o/z9j+uZvkwfiqpDho9GswxvUh5y8kQA+?=
 =?us-ascii?Q?eZnoF92UmMFAKQoQJGnEYAK87Qt+8DMIB/wwtJQVsEFfXJ9Ku7IR4e96EiJ0?=
 =?us-ascii?Q?IxkBTSPxvQ1xu1pUM61EkiLfIk4WOhjgivvltzdeNX3w7M3JH80cWOqY8GKM?=
 =?us-ascii?Q?35j8SCDcUfThK0A2fvcjS/75dhBtEBTp39PLhWhHE+2286BDXGHnxO1KdMCH?=
 =?us-ascii?Q?P1J3eoG96BGQ4LK0ccBFZ20uuBZisVWvacZVSfnmWM2oCz5/DcWx6ssiHr0p?=
 =?us-ascii?Q?uCTTTLcLEZxoT2pVqDgIElv/rBil9lwV6dYle2Q0nE+dsX1KC5Qec1tz5M6y?=
 =?us-ascii?Q?Ar+nm5GzJ0twGxW0cHLhsaEDyF786ex3/n8gdvo6MZgqS9QrUySLUchUpxzQ?=
 =?us-ascii?Q?Vxzz+9eIKWBQ979rYKnOn4h/BwvtRdi38Y2kQ8uYqpbLEWQuCQY8D5nDjDMD?=
 =?us-ascii?Q?cAgIs2qXGLZ4qCSQc4F30sH5cOIh9ARa5/S6Txkr8nPBrPyqiJdTfEudZEWi?=
 =?us-ascii?Q?LKjit8bfhyy7WdHujS7P86egR8Gnvam5S8gkfj0BscJuRSkNzhn7N34sv3pd?=
 =?us-ascii?Q?z4EEQYUseiKlYDoNOMdUcq/VQAUkAJi6KuAWSJUxl9aTT3TiZy/H0+i2UW2g?=
 =?us-ascii?Q?+hV+yZNC2Kvz+W7FecU7F3h5wk+4Ng6c5bAGYX2gsFgdAbXDTjZJFOIAxHFg?=
 =?us-ascii?Q?mAyws3PgpyP8OS8LAg8wwfYkE9j+qMmUWvc4lOrYiKxuSnZArW22/wJ/vprT?=
 =?us-ascii?Q?vrTs7gnISxufd9UJvDeCryfET+YS+NE5W1c2+wX9auRmc7HX9wxAHGgPudBd?=
 =?us-ascii?Q?9WjzyjxaSa/xkUjk97YuPm1RJmEhbaUkxcLSM4fdXONMBPrkfM5GzLYiugpI?=
 =?us-ascii?Q?6t5mY548JTXNsEvYkBe1Zpgf2LOIkPCQCi6gmPfd0uFRLQV9CfVvU0t60op3?=
 =?us-ascii?Q?rAsRY2o7W6I0AEyi3sjiQGRFBdLioWdpm2GkBOeu+R+TmJGQ1wFv0Gq1qUwN?=
 =?us-ascii?Q?L8xlUAR3dyqWql2GgZcZ0LPyKCk/wkwgyakbbJjsEPEokYn2RyGcCfQgXXND?=
 =?us-ascii?Q?TgTttebwkfq/YFsBicI5vF4gm2suM+fYftQ5s3ZI2aAvqbi7Lb5G1BAKyuNE?=
 =?us-ascii?Q?vvdubjLnP9grZ7E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:06:28.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33eb6693-5ad3-46e3-b8fe-08dd450bf928
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318

From: Amit Cohen <amcohen@nvidia.com>

In case that a packet is received from port in a LAG, the CQE contains info
about the LAG and later, core code checks which local port is the Rx port.

To support XDP, such checking should be done also as part of PCI code, to
get the relevant XDP program according to Rx netdevice. There is no point
to check the mapping twice, as preparation for XDP support, check which is
the Rx local port as part of PCI code and fill this info in 'rx_info'.
Remove the unnecessary fields from 'rx_info'.

Handle 'rx_info.local_port' earlier in the code, as this info will be
used for XDP running, XDP will be handled in the code after handling
local port.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 18 +++---------------
 drivers/net/ethernet/mellanox/mlxsw/core.h |  7 +------
 drivers/net/ethernet/mellanox/mlxsw/pci.c  | 22 ++++++++++++----------
 3 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 8becb08984a6..392c0355d589 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2944,29 +2944,17 @@ void mlxsw_core_skb_receive(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
 {
 	struct mlxsw_rx_listener_item *rxl_item;
 	const struct mlxsw_rx_listener *rxl;
-	u16 local_port;
 	bool found = false;
 
-	if (rx_info->is_lag) {
-		/* Upper layer does not care if the skb came from LAG or not,
-		 * so just get the local_port for the lag port and push it up.
-		 */
-		local_port = mlxsw_core_lag_mapping_get(mlxsw_core,
-							rx_info->u.lag_id,
-							rx_info->lag_port_index);
-	} else {
-		local_port = rx_info->u.sys_port;
-	}
-
 	if ((rx_info->trap_id >= MLXSW_TRAP_ID_MAX) ||
-	    (local_port >= mlxsw_core->max_ports))
+	    (rx_info->local_port >= mlxsw_core->max_ports))
 		goto drop;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(rxl_item, &mlxsw_core->rx_listener_list, list) {
 		rxl = &rxl_item->rxl;
 		if ((rxl->local_port == MLXSW_PORT_DONT_CARE ||
-		     rxl->local_port == local_port) &&
+		     rxl->local_port == rx_info->local_port) &&
 		    rxl->trap_id == rx_info->trap_id &&
 		    rxl->mirror_reason == rx_info->mirror_reason) {
 			if (rxl_item->enabled)
@@ -2979,7 +2967,7 @@ void mlxsw_core_skb_receive(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
 		goto drop;
 	}
 
-	rxl->func(skb, local_port, rxl_item->priv);
+	rxl->func(skb, rx_info->local_port, rxl_item->priv);
 	rcu_read_unlock();
 	return;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index 1a871397a6df..72eb7dbf57ce 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -242,12 +242,7 @@ int mlxsw_reg_write(struct mlxsw_core *mlxsw_core,
 		    const struct mlxsw_reg_info *reg, char *payload);
 
 struct mlxsw_rx_info {
-	bool is_lag;
-	union {
-		u16 sys_port;
-		u16 lag_id;
-	} u;
-	u16 lag_port_index;
+	u16 local_port;
 	u8 mirror_reason;
 	int trap_id;
 };
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 5b44c931b660..55ef185c9f5a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -761,6 +761,18 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	if (mlxsw_pci_cqe_crc_get(cqe_v, cqe))
 		byte_count -= ETH_FCS_LEN;
 
+	if (mlxsw_pci_cqe_lag_get(cqe_v, cqe)) {
+		u16 lag_id, lag_port_index;
+
+		lag_id = mlxsw_pci_cqe_lag_id_get(cqe_v, cqe);
+		lag_port_index = mlxsw_pci_cqe_lag_subport_get(cqe_v, cqe);
+		rx_info.local_port = mlxsw_core_lag_mapping_get(mlxsw_pci->core,
+								lag_id,
+								lag_port_index);
+	} else {
+		rx_info.local_port = mlxsw_pci_cqe_system_port_get(cqe);
+	}
+
 	err = mlxsw_pci_elem_info_pages_ref_store(q, elem_info, byte_count,
 						  pages, &num_sg_entries);
 	if (err)
@@ -779,16 +791,6 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 
 	skb_mark_for_recycle(skb);
 
-	if (mlxsw_pci_cqe_lag_get(cqe_v, cqe)) {
-		rx_info.is_lag = true;
-		rx_info.u.lag_id = mlxsw_pci_cqe_lag_id_get(cqe_v, cqe);
-		rx_info.lag_port_index =
-			mlxsw_pci_cqe_lag_subport_get(cqe_v, cqe);
-	} else {
-		rx_info.is_lag = false;
-		rx_info.u.sys_port = mlxsw_pci_cqe_system_port_get(cqe);
-	}
-
 	rx_info.trap_id = mlxsw_pci_cqe_trap_id_get(cqe);
 
 	if (rx_info.trap_id == MLXSW_TRAP_ID_DISCARD_INGRESS_ACL ||
-- 
2.47.0


