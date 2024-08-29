Return-Path: <bpf+bounces-38377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B9963C1B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024611C2412D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E2417556C;
	Thu, 29 Aug 2024 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EB352dhW"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07E1F61C;
	Thu, 29 Aug 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914670; cv=fail; b=eBuScAUUrzbQEV4YA0dMOd3O05i/eyXjLpBZIArMoeWuAfAozYks11qVkwpbcP5TfpJTv4Jhdic9thGJwLEsQlIMANjqXhEbQvr1XmXC+61Q1diwEnEqE84Dc9kbXxVNFB5dALwUuH/x4XqWox3IrjGcMv+XIvUsUL0lu2L3XF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914670; c=relaxed/simple;
	bh=Q6DCgyGPCyWM1e3MmZ7KUEf9BpiFeX1aXiwlVB0sCeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owtU/cSSedHUgYMSF39/gJtVHR6z/pIssOjSwFph03FJhN7DunxUp16a5QvgNYkDWqblaNh2VNLsliF33VY3zJU8EzRizh6fx5+u3C3+In3fpOEYBgxONao3Xr/RKCFuOIiYr/fbx20x8ruB945CcK0ZJ1aYooGP09/q8vTfBL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EB352dhW; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEZEaGN555XJawR6Bt1h4FMkEwChk6PaPbZlcTnZiUCcingy/1VT53SGSiPS3+3YCZ41oYDhPJjZvnqHsmmZTShLnmH05X0Ip47SIsm3H9GHfRUZJF/xxC9qx6GzFFn6T1xpGjLbnuM9/5RysH7dEDFEUmdwYXBkJw2i/4dypHB8IeC8JdYHOVhWVadhM6rkn5Ll66WEov9BIPFlnXv5V1JsIIRGLIfjZtj1eXVUnEsYebxzmKqAfglRLg0Rp51XD2BpyBC5VAM2GSk8GlLdzt8neMgmdKPZ8lH04TPXG0j1Uotowbps5WLg87y//Sof0m0chA819Em9Z106oUBLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX13TuVBXOIT7A7klMaUzHbARyxNZTQ2EerN7KekEZY=;
 b=Ue9Z6v62YG1Qsy+EIKMCoQxzWKb4JA7O5HZ0xKRb3Hgnmf2oRQQhGpUGDrzSC7bstQqBnmYDJFV6dA+/DvDqTMSkDh4/vaF8FDR2WBdnDI8FX3l/UTtEPhv6y0ZH5SgO4jIs9IaTpsbC554pJ6BlPcot4aU+GH6YbTjRZ6qDie2RA7x2dHcM6GMiubNoB0P8CSnpxQyMSp0F70P+HRHu+s2eGzzpCDzLQi1BJ7frXlNQyJag1LkS8yT0TqvZ87t/dNe511+sBvwGh0KgVZ8c8QAJz4DEvx4LUTTtYeuzgblw28Cx0VnCfB6/PXOeUJIHcCMU/Zs4g7Tr/X+lWyGIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX13TuVBXOIT7A7klMaUzHbARyxNZTQ2EerN7KekEZY=;
 b=EB352dhWWgTnm/7eObVYAAKbMR5EM6GNC868hmzt/8BI5DlLZlNXPqssGJsAa0sdi1UVl808Za2AQgQbkJskgMhp6eAGZJtupDt10a654PFcChEIIMHtAgsk32ZISvw7XOSh0z3NFlGIpvs+0mkpzC0IHgZV+hLimdDC/Gey/dtJihH4scMWq56Qe3jhU9JTg7ki3ZfrM/IRtzNnvbNL4lIIx1Z3nZfWRCjqyLrkJq7087y8EcyZqQ7DbJYmQWB9WuFmJWWQIjTvRibv59ZF1MudJs9lzdP0CSV2wVmblvxvCEJxggGuw1oMVFnfoewI2fHc4OzCj/11NUdXmoTOyg==
Received: from CH0PR03CA0348.namprd03.prod.outlook.com (2603:10b6:610:11a::23)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 06:57:46 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::54) by CH0PR03CA0348.outlook.office365.com
 (2603:10b6:610:11a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:28 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:22 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 10/12] ipvlan: Unmask upper DSCP bits in ipvlan_process_v4_outbound()
Date: Thu, 29 Aug 2024 09:54:57 +0300
Message-ID: <20240829065459.2273106-11-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829065459.2273106-1-idosch@nvidia.com>
References: <20240829065459.2273106-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: beb1afb7-efab-4a05-6689-08dcc7f7e2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MyV/UACuPV60uH1SBNZYVHI6WOmHro59oWePkBzx3DJVDo9L4nQE1kd55Ww4?=
 =?us-ascii?Q?L//xXt6DWRQi3iFviDB/ndUfr9s3YHh3OBGYtzm07WCWDiD62r7DE7gpC1+B?=
 =?us-ascii?Q?eEQVgfeSxsPCsbs5YRGCE/WQIKoCXuiSgDGU5G5otmNEIU7PV/Fsj9WVbWLS?=
 =?us-ascii?Q?WAzgVYA+Ex+yiAjOw5v4PN3UMGnuMng5Rw1NtSa7+HdkycUklYaVSNud7J/Z?=
 =?us-ascii?Q?7tPNTF7GYER2yJJwuzbCGlewemaHK3zavjVr+MKRNjc8ybSzGMfmQz5Nxbff?=
 =?us-ascii?Q?H+2/BPQYaUQNB5lLzyfDmyccaEzEHREt8db35R8dJW/JMCsLIAcq90aIUgWw?=
 =?us-ascii?Q?hO58qX1BXZSi3z2klTst4+aO9lH4RlXYlS/eXqjjCKo5SfqZRP8X95xZJ18H?=
 =?us-ascii?Q?q/xEPKaUSoAojySg0s9UcB1QGOLIHwR648GMo/Fj3/DFXztI5DyhIvcsOktT?=
 =?us-ascii?Q?sIhDNOS/WaBfOBYRihDx5Vs4oQL6URF5RHXMuIn1L90nwfnttOUhZDQ3RWY2?=
 =?us-ascii?Q?6DATxoyaMhx+tSIZd/elupQi/NH5BX9dMtAhj/knjqRSshJcb+gQVY9cqjrg?=
 =?us-ascii?Q?va4epOrbKuJHsj9+WqVC3ICJfruNrrxUjsiXHoOX096+g/U2nqFrggWGt2GF?=
 =?us-ascii?Q?e8xYJtPeZLfN6Xtldh6czpfngEYxzjoWsRt11TBqRKz1YXdxL3AGH5g+WdjI?=
 =?us-ascii?Q?75AcLJXjZhv8FtMcB+TW51UJKjpxbQ0sOS+FYpdUNPqpvRNNgOnms3Xd/Fq0?=
 =?us-ascii?Q?BgjtyuCCgIrfFfJxIshCy1k/iYmcEH9w3XXA25/nN5gbMiOFNUiCDzWaoqoV?=
 =?us-ascii?Q?MZNROLiDCPnIe6gZ6U6EWNZIqDu5dz9uM05pKNDhpGvWMW9aU3Oy6xlB9iZq?=
 =?us-ascii?Q?Vzn0conY7zliFwRmLIqmxrv2zZkGXZvtmh1FQjSvRxtYnUVKHn+J2VfINxER?=
 =?us-ascii?Q?7lEmCNO8Hu/83wboimFbW9+zWY/ZmbcKbh4xoI891QF1VjX6y5BeVb3i/C8p?=
 =?us-ascii?Q?hW+f+YAEVwfK++GR2KhH8xIENngVzIqqjKixJrdWKFPcYrKTjQmwP3WTqxmQ?=
 =?us-ascii?Q?lTpaa8yKhJ8SWbTsYqHEmbCqeyTftaXKha98pQOBQMaO4TxG3lrrpMU8JwZ5?=
 =?us-ascii?Q?IwLjTkg+qCifmKG7x+dyhhstBKp5qYVpQtJELuHEMCIR0z0XMfd829sXdPU9?=
 =?us-ascii?Q?uUNBbFNNrhOSZ5omsZESF7z44D53HWVo0KS0Dc5eWpYch0i5Y4ezfUH61Clm?=
 =?us-ascii?Q?i8xOyDpZ5bMxdO0whQTyFRIHtnUuE7/N13viTutYKOOv0kRNl1lvqNLGcsYY?=
 =?us-ascii?Q?UWqproogqusyCtmHPLmlc1xnAQ3JIz+06L4ciTF3X3hW6l962siwWeKofddP?=
 =?us-ascii?Q?EtMG3woAN6ua+Nlb/e/ubWvVbNeGDso9AFxYjmCf4UOKJEs0zSdf7IgeJZIh?=
 =?us-ascii?Q?+ncHPCW18VZKAGzEEF/4PqPSnZtFeHnd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:45.4181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb1afb7-efab-4a05-6689-08dcc7f7e2d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

Unmask the upper DSCP bits when calling ip_route_output_flow() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index fef4eff7753a..b1afcb8740de 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2014 Mahesh Bandewar <maheshb@google.com>
  */
 
+#include <net/inet_dscp.h>
+
 #include "ipvlan.h"
 
 static u32 ipvlan_jhash_secret __read_mostly;
@@ -420,7 +422,7 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 	int err, ret = NET_XMIT_DROP;
 	struct flowi4 fl4 = {
 		.flowi4_oif = dev->ifindex,
-		.flowi4_tos = RT_TOS(ip4h->tos),
+		.flowi4_tos = ip4h->tos & INET_DSCP_MASK,
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
 		.flowi4_mark = skb->mark,
 		.daddr = ip4h->daddr,
-- 
2.46.0


