Return-Path: <bpf+bounces-50407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A0A26FEF
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3351888080
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E320C49C;
	Tue,  4 Feb 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K11egZr/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033520C490;
	Tue,  4 Feb 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667270; cv=fail; b=DdG6KiWUF5RivQGeU4d3dgpE3TLMEcHbxtJZBPXiXeTtHK/qpLty6NG947/YlmUGv19UZYQOvXs155kcI6uLmF/XzZgtqpUeek8qK4HHSTIVIUxbXvgC9uac1+Jl7KLCjw8U6Gs2YH6Mzu57fYilV5i27koO2HPrE6eUwQdlfTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667270; c=relaxed/simple;
	bh=xonwUbA0AUW/8ATJZqhYWL5iGmR1k3sM7RWMA+tCjp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIDcsdH6K61tR0ouBq5gRetD4HnDDNpjhr35bMOcG3gdSTrmk8U2644m7YcrolISzMjlQYbMTbIlDf8VFd4fjvtXgrv/dHOVeQEc8XmMpos35yXVYh7UviSfonfpOr6jn2utOhPiJNr6L0qi0QL6Nen+3kzsC8KC6GXLDq2YKZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K11egZr/; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFf9X2SHx7gx+dwZ7iGR2GPyYW+WnjCQj6huG7/39zADsVscvPCG/wI+I0yGc9DRKjaiHFmXBmANcWIZml5OuHIlS5JvK6ch5P8zYGpxIFi9eLcj4/jqJTrKVSzKes4s+LFErBOkOceX/RaTcTVfpOD/dr99N55aLxXeke19wGlNTmpxWRe2dZucsCKwAvpXoNqsPg5aXDLS/g/yFpw1gPDMydjH8VpGsBy/9x89YuZow11llmne8rfLCj/ZEJ3WG1nkop+YM50+Vs9PrEik1Z+jBDApr+oL1RMs1rh/439Fuc9Id9l6zMS4Y2GQdFZKRrtHQiSm+U5N2qK3d+UaYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fOckC9dX2KZEetfa/W25Tvjz0+kovc+JJ50PYOFsoo=;
 b=LtM3rjltRTeoDn2/tM+Ovo3sSNn/w1WaM4gn0UxuOzdhZIEU3lx9mvj4Wt5iS5nvGUlsQTsgJyWYkaK5JkJf4kCnsB+ok4jXyk5Tvyi2w01TB11FAdZbnjsymHbLqkzhbEzFoBbiLQNyN49hNQlGBBHLckGzhb6FT2KNNQ+RPxwxEoVNIrpDTfDnGTdbeWJq2f2kUP6MvPih8qS3r6u9uM9JdfBk2d6h9G3t9Q7kM57gqnsJmLmZutQA+bJYSL0zvsh33L6kjdGYJOwSj/I9PebboLwweKVS5G/cjHzMjKhXZp83j2cka3an1H8Mq21xKz45q09KQTn8J3RKwQJD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fOckC9dX2KZEetfa/W25Tvjz0+kovc+JJ50PYOFsoo=;
 b=K11egZr/YCYZg5mxshZ+U6jhP+yUCajaEkMNRevCAPST6oV8IzOleekJjMIoRVSL7CriSDGP4DmkG3ee9V3KhmlEgwPLPZWj5CYMGErHqTCfCaAhh1MR32C8paOkU19dq2NMeKpcBmE7breg2bR3T/CxoiXWMP+dA8IbwoPb+jLzRtQHFLu5ZlJHePH+VvwVGDJGD2iO44ZLxSJY2fblyYJfXHoPiaAiyN4u+gipPcdE84OV4gC4LdrabsKXu3jU9BonwwHZi6e00klJSPHq7CfzVyXneYDlDntGLSy0ZMAYj+4O+2wYDZBteDui0eXI/HZH/RCDf4Fj7/5MzzCd1w==
Received: from CH2PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:52::21)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 11:07:46 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::b) by CH2PR04CA0011.outlook.office365.com
 (2603:10b6:610:52::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 11:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:07:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:07:35 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:07:27 -0800
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
Subject: [PATCH net-next 12/12] mlxsw: Validate local port from CQE in PCI code
Date: Tue, 4 Feb 2025 12:05:07 +0100
Message-ID: <0bd312ed629e85a044725080b9f33403bb51ae41.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: efdc2a29-e944-4a7e-60dc-08dd450c27b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UEoeQCWdxyeGXHQYPNpm78DnOIYFXEE3WzoEUgNY85U1mWb8nf/wvWDiNvM5?=
 =?us-ascii?Q?L4N+bzCU6eka4qRpsACKub1+pSAAqz0gMFaRWj+oTwwIns6gKjU6GxB5nZ9Y?=
 =?us-ascii?Q?hNJpuJJTxBgpf6vGrMX1ZAPPngyHCbyq4IB94YnU3wLPm5GKLvUBe0efXU4g?=
 =?us-ascii?Q?L87L0T2GXDGPvSc66TYPmNL5Sll1sucEPfMGBtvjnq+dzuLiEePeoKk9uNu2?=
 =?us-ascii?Q?Hyxx/GM+9CY3i3GxH8rc72zZ+scNjFOgmCTbjh21IIbp/yX3nf4jJ39QnwqU?=
 =?us-ascii?Q?GQgHddRE4P67S9t7nEmxwQGbfZniwsWlqsanb547hxnumumZeXGJZ4g2KpUV?=
 =?us-ascii?Q?3zOGwLW2lzsx8fdvmmX63y97eP/mVCGbKUlk6s7yF6K1l2BAhn9J2dTg2VhW?=
 =?us-ascii?Q?Cncef+jEuQ2AY6kSPDgW7XfwIbX5E6CLbRuIZTxXERMZ5jz2tsQHQu8F37IZ?=
 =?us-ascii?Q?rRILyany+6GLCNzi7wgzZ3l4ykuQR83uhYQnRs1ei9zFQImCQGOP30YOY+ui?=
 =?us-ascii?Q?b/n0FqN0GTHNBNSY7EBv0XnnrSw96BJusgKxW1aorr8FH5K4HV21Tbbz8rZY?=
 =?us-ascii?Q?+/1l7nhDFxoMtx3yZNEAFgVU7vvDfZyzm7MMmMQnoLdpSyXGxFWBYRJWsop0?=
 =?us-ascii?Q?J1WxPMNGOFrMBgV9wGm1gMTmfmybI8VOr+lNgfiu69yiiFXqbfxtSXmP/PpI?=
 =?us-ascii?Q?7rYDHySiCHAP/Pc9qWo3u3Bh43BEhesu2WK1ziiaZZdy9dar6WAETu9KHdZi?=
 =?us-ascii?Q?fQqYLH+0vuXryQvA5ZFa+LZhe7gwNA6WmwDUVCyydAOuDDBAbXpQfnRLEWiz?=
 =?us-ascii?Q?nniaBQOypUmfvbJt2QoKE68hK+TdIjSUSNEPSyagFzY52XHknDsImY7Nk4jx?=
 =?us-ascii?Q?Pjc+qHcaqrFq3bsmHK0MGsHWeZcblfzqk6ouiv7oJaZFChq/47T4qDMARJmN?=
 =?us-ascii?Q?ZpKpmnu4ycgIVUx2/Aw+mcP2SF7iYWE9cpqVk+wFeFf/XoBArewIXYUMeWQE?=
 =?us-ascii?Q?l0RFCxNzXcVtQ/jsQNxJj9mIbxxMNzc1DQfDRldpW0prOAN1B+loyevBG+KK?=
 =?us-ascii?Q?zaHVzzIXO/9aghWc2s7Af1u2GtsWNYHQH9E+XJKbVlaENV21mgmlOky7EYSU?=
 =?us-ascii?Q?AyiofBfKyTeVkXxwedyTT5RrjT0VTj7wFHYwMEGGTu0G152GV4gajGgWMrOS?=
 =?us-ascii?Q?fW7o2Q4wkGrFxJhQTouR6VbtQj1kD5lJkWDOgZBfCM6kmRQyOg8+5XHGdLo+?=
 =?us-ascii?Q?6/BRPyyZjsvCfF4J6Sk5KLubl5X1QD5WZgfE1JckgeaQSbpC0atkLkbsrxKy?=
 =?us-ascii?Q?6YQpVTL3W27SsD8P2GEXcPjD4PlvQdCF62a+gCgx3M+FCHWCraJCkG2ybLlq?=
 =?us-ascii?Q?8iKlNtcrOj7gNiH9X1uQn3j8JBfZeslhbNP5jreTvM4JHu99bjfHwZ9lK5VX?=
 =?us-ascii?Q?CRO1VD6ZG72O1BxpP5uXyL0w5IqBq9jdCO2rFz8MDnPiEVs6XlOYzBXAhWN9?=
 =?us-ascii?Q?jRIWj+wjZar9CKk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:07:46.2711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efdc2a29-e944-4a7e-60dc-08dd450c27b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

From: Amit Cohen <amcohen@nvidia.com>

Currently, there is a check in core code to validate that the received
local port does not exceed number of ports in the switch. Next patch will
have to validate it also in PCI, before accessing the pci_ports array.
There is no reason to check it twice, so move this check to PCI code.

Note that 'mlxsw_pci->max_ports' and 'mlxsw_core->max_ports' store the same
value, which is read from firmware.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 3 +--
 drivers/net/ethernet/mellanox/mlxsw/pci.c  | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 628530e01b19..962283bbfe18 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2959,8 +2959,7 @@ void mlxsw_core_skb_receive(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
 	const struct mlxsw_rx_listener *rxl;
 	bool found = false;
 
-	if ((rx_info->trap_id >= MLXSW_TRAP_ID_MAX) ||
-	    (rx_info->local_port >= mlxsw_core->max_ports))
+	if (rx_info->trap_id >= MLXSW_TRAP_ID_MAX)
 		goto drop;
 
 	rcu_read_lock();
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index b560c21fd3ef..778493b21318 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -845,6 +845,9 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 		rx_info.local_port = mlxsw_pci_cqe_system_port_get(cqe);
 	}
 
+	if (rx_info.local_port >= mlxsw_pci->max_ports)
+		goto out;
+
 	err = mlxsw_pci_rx_pkt_info_init(q->pci, elem_info, byte_count,
 					 &rx_pkt_info);
 	if (err)
-- 
2.47.0


