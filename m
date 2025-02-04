Return-Path: <bpf+bounces-50395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6449A26FCD
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4D57A1DCE
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B4620C012;
	Tue,  4 Feb 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQzp7MHW"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE116B3A1;
	Tue,  4 Feb 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667190; cv=fail; b=OdXlphzF6iBgcwc8+ecWbkZaI8KkgTeOk7p/4bQmtTEQf43NHuoSyk3wig/o27jwsl7z/iJ2a9TWN8ukYkQWVZ+t+d0v/ywfEFb1e2P/UmshRAm37ImnjbAZbtJM4SlNkaeMvyeByR4EK8vOwTvp2dV45J1PZmkwdY7Jdj+yuFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667190; c=relaxed/simple;
	bh=1yDGvHPywxLfu09/oD0z4qF1Pe3Kk+V6gpDU5BTIRgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keO66I1UPPdA8x/5wxtr9BsmVhg2jE6XPqiJVpLOeUxzgHOZ7PRa66tidYtS1FdSkMSpDcELm5IZEFeFNfY7+0rCsixWqyx4bHdZUkCUzpnpmHZ+W57vRhDExUE2qmnOA7gTkDVnfs0dqHwz4ZiAWY63wsi6CSrkvGYiUiEcjCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rQzp7MHW; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b33aJa76GX6Vtlr/1JdMJ5edIhYXyL5qkSxjNULbP7lxxvv95p/tWiDoXz/skR+ArEnhq4n26N93SBgByTK2QqEu7m9aDcrYihf2Mf/KSN6Puzw5nP9qWPa/LE7Mv3vYKfZt/NOj7b3SmOqpnHxr9vem94L5lZ/LIRnGA8LS/wck1UaU2RduLFoDkmx2eaotu73I1cQJDGVt894Zc/h6cD0J3XBXUNkgrUWTbfyZmwR6epvjfsl3pDNMLk0SU6BI+BQEwytJclIjWVliA2lS36TChgFdqhAu9OFBT+xPhNppwoyA3jxccwDgtsqzbMcfHGlnJxIbJzO00lmDmfQHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgadwxTQM6BI2Wo3mpfyLYZjx9HJxiD6+jiQbyzxINY=;
 b=XOM5aca/rCl8cijjMGNpdb2ktDd9md2L5gpCSgAYOvrCz4TlakIxuyJ90G9EEDsppPtIE5RmjxHs0QStjL8QmJnMIwJSJRvnDWkhwQg7+uBgqMSSPdn7Za7PGEJnVrHjbPzROnoMGmBdVKpz/TriwufhN/Hv7m4F/nws+ZFGwHMIe+ZoQR6PL0nHaVTsFZIxAiSk9xudq+sVdqHhQvMoHCQYdvgDX3epuafDNohZnGJ5re/zY6bftDzlQjIkSS2Gyb+bKu2EwuSPIXIXzGqfZnDeeq8BcTaMMIKp1R2C7DVHuUy+GRz2zwQuuvK1I5E9YZowmlL5JbE8QiazFw6Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgadwxTQM6BI2Wo3mpfyLYZjx9HJxiD6+jiQbyzxINY=;
 b=rQzp7MHWWRpvOkJmLmNrkfOegBOJt4yvr8d/SAVzHqB3IHuoBJBJAY1cNwXfH7tzEDArjEhpG1GFyNAPDdIeTuy3rKQkdq3p4DdtQEqHN0NcPPsmLyT1l5I4CxQwvKVkcsHCO51ayYiAGZsw8LiJAQWERvFS0UB+UzvQ20mX0zSZ3zW8gQ41CI0PHmMueq+QXWwcZN3g7/rqfWL0h4U2p3+xu6aPWFm41V40H2SFflka1WilarnQQ6qdXanRtgQa8SoeOzpY5Dk6ynqbnV6YY2fF4eHfgG0kO3mjoAH1CVHLCkoXSX4pscXdacKSVHpgR/AxQDObEdO1ebhSICoGcg==
Received: from CH2PR14CA0045.namprd14.prod.outlook.com (2603:10b6:610:56::25)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 11:06:23 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::2c) by CH2PR14CA0045.outlook.office365.com
 (2603:10b6:610:56::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Tue,
 4 Feb 2025 11:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:06:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:06:11 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:06:05 -0800
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
Subject: [PATCH net-next 01/12] mlxsw: core: Remove debug prints
Date: Tue, 4 Feb 2025 12:04:56 +0100
Message-ID: <8aa8bc610c5c5e58b4535235300e9afca312950d.1738665783.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b4cabf-776b-413b-9c6d-08dd450bf608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0vUcqejogkStCuulGzzwPqpV8a0eqmYC0fbngfu3YbrjRWryDLr9YD81E22g?=
 =?us-ascii?Q?UDScruhYqTw4AFbmfm32RsTn+BnlHYMdLcd2BGMcbC95J7PtJ+ugLpHbEQdc?=
 =?us-ascii?Q?/CnaqN0KyZOyh9+8VjehAEGY3Ron26ywNuglY1Am2iwsGfMcHLq+STZ2EK0n?=
 =?us-ascii?Q?ZZQG7f0jxKx0bbb0AfkO6pIt9LtejBdqUPanHdnfnururvJYRaIcBJRiH0/f?=
 =?us-ascii?Q?fsMC06NAuSGCav5Zw982oSmsJg1JGq+ESVqaiukI8jt9PxlQk+5KQZQHlA2i?=
 =?us-ascii?Q?QdXH6o/PqzAfFD/AcPJfNVPKoSqVWGk4L1RQxhz8FgyYkMGQibKKlRWceOmE?=
 =?us-ascii?Q?tZ3CaO4lyZro8GWphxlOSOTpgPQCrZQe3k2uhFyPt4Vlhu0jaIXA6zRYVODS?=
 =?us-ascii?Q?i4Ig+B7pTV1cdVdDRuXEcjAwBlPAIZeGP9a1WAyedIga3Z4QxyWdXOf5jwH0?=
 =?us-ascii?Q?pF0xv7ANjnctnT9YixE8ooP8yBcFPoQcrze5WT/gDEG27TjBjb/Tr3PAWjqC?=
 =?us-ascii?Q?kCLN0/M9qbBymWlMd1LPygVUFv2L4T+pEzSsb1oyqrRFhn0uzvhv+NFSGuxc?=
 =?us-ascii?Q?Ot3mn+WNdJoOCLIoCFEOjCWf3TXZJvNm4PYu4LQlRzAyKttvAj9oDeiLmVuN?=
 =?us-ascii?Q?TTS42eccQzvrRrlckHFeT/DFCbbJSobxpY1BOthn0hzhTF1mUDf/yETtYwqg?=
 =?us-ascii?Q?c1U934VDAxlHfh48LIdbbRjSBbpsTAflwrgN8tOaPbU0onpVYyDFby9Ypj6R?=
 =?us-ascii?Q?yjZIwKj1uFuID/dvJTJm44ArOldMgpfB8pyU3LxjllryQYAmDJEfKOcwpGdD?=
 =?us-ascii?Q?bf3u3KfpI9fBMPzWwqBvet6G3J64xKL/cQK/1/2uequApjIK4TAYjiwhlb/b?=
 =?us-ascii?Q?o008H6HyQnSk3ILoQgX/tt01l2kjdVpLj1SztqWWco0WkEV+htYGiaJX7i8U?=
 =?us-ascii?Q?m8S90f6vAXiMDtcp8hpAL2l7BXb1hD65CPSLbA18dxN0u7o3sBpgHISbnMwc?=
 =?us-ascii?Q?I1avaFYfwvs+8aDCy4Pm/kX2ZT7rEyiRLaJOh3TEuBz13OnQj1/IqRXT5I6N?=
 =?us-ascii?Q?pf3/FwHQdIpRyfDH8m7ZlkQXMNo/aKBfSrT9uitPcU31FHA/0xaFO8t6dTUu?=
 =?us-ascii?Q?jtMwD7i21cQz0pSiV5EgbSJwd6lqp/YZyccLSoNCNVp/u8VXCYjvGkMh0zY2?=
 =?us-ascii?Q?12dqWaOmVRTOo7JlZaKhOucBRCk9FLk9fYD5hqpKH24gz8o7s9Q4xV3Y26t5?=
 =?us-ascii?Q?05TqgA6vKYQVr9gqxMCmURvElPtmvb47yDM9s2Ya4HTzqZ021HrQCaYZOYzg?=
 =?us-ascii?Q?sCwOsi8gEJBA3xVSLVIDB4xWGxELsmck0euxJ76F6F7ywH6C5hQU4DqE5Zwd?=
 =?us-ascii?Q?sHyBgkxrj73JPjDzu9kfcKuaqrsC0EgBc25xqaDmqGFsGe3wiM8z7cZzHK4R?=
 =?us-ascii?Q?NOe56mQAE+A0i+BrjKjxJOL9CvDgo9vJsC5/h5h1ryD+TTCCV5fJ6lsEaxPA?=
 =?us-ascii?Q?WETk69kqHWvFuaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:06:22.9944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b4cabf-776b-413b-9c6d-08dd450bf608
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864

From: Amit Cohen <amcohen@nvidia.com>

dev_dbg_ratelimited() is used as part of mlxsw_core_skb_receive(), the
printed info can be achieved using simple tracing. Remove such calls to
clean up the code. A next patch will change 'rx_info' fields, without
these prints, some fields will become unnecessary and can be removed.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 2bb2b77351bd..8becb08984a6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2948,9 +2948,6 @@ void mlxsw_core_skb_receive(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
 	bool found = false;
 
 	if (rx_info->is_lag) {
-		dev_dbg_ratelimited(mlxsw_core->bus_info->dev, "%s: lag_id = %d, lag_port_index = 0x%x\n",
-				    __func__, rx_info->u.lag_id,
-				    rx_info->trap_id);
 		/* Upper layer does not care if the skb came from LAG or not,
 		 * so just get the local_port for the lag port and push it up.
 		 */
@@ -2961,9 +2958,6 @@ void mlxsw_core_skb_receive(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
 		local_port = rx_info->u.sys_port;
 	}
 
-	dev_dbg_ratelimited(mlxsw_core->bus_info->dev, "%s: local_port = %d, trap_id = 0x%x\n",
-			    __func__, local_port, rx_info->trap_id);
-
 	if ((rx_info->trap_id >= MLXSW_TRAP_ID_MAX) ||
 	    (local_port >= mlxsw_core->max_ports))
 		goto drop;
-- 
2.47.0


