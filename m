Return-Path: <bpf+bounces-38374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0257E963C15
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAC1286498
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FDE15C13B;
	Thu, 29 Aug 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMSaPYTJ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25F1662F4;
	Thu, 29 Aug 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914647; cv=fail; b=dci4+VYcFWgl2NP6vtMJKr4GRJVT/qINb3LURmMXlIvVIQhJnAoF/w2ORL/RgS4c1UIzR01GfIBhk9IaYDz0Z2t33Ombor0riHeF9XU7axcRj/HYNS5vspBHxX1lGr0wg16g71e8NPlzVI3sST63uDYY6dKkiV/2Mlu09gqTz7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914647; c=relaxed/simple;
	bh=W+jYR9PLFuP7/FIyD5Z+wK+J5lHS5/HhqiWzb0Hp4f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csINezDrwQq/xXPU7hPk6ogd0kr3aYWhAfOUwmtPubdaH8DSJTrTwCAOn4wL9rsgjMh9t1WnRlU+e7+YXu3rvii988+m4XRIa3dh0C2I+uQ5o8c6rPTZeR7tEPZ3oI2EXlCRIINKvJScwTb7MGAu5k4CEFcXIJ+LUfZkmqmEyyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMSaPYTJ; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMsGXQNtRnLAqJkRW1YVH41MK8OgIqTra+klbiWoH5TV5LQPZeVosQ1eX5B/xTSio6ti7lWA72kK+AoKyZf/9tCmzWFxU+RRJdigABZRNTAhBXxM+/Wm1TlUhYz/IVdQyqNK6Qjpz+K8v7iFKCGOw556kxdPWmwbRp3TdeYFaAZx+fl9XmpVlSu5BrzitPm+G67QYrukJLR4LzYmaf5D/UdzGNOAheiaHcn70V58ZH7lk9s91V7XltfInbKcOSs8RHdeRGQWzfTBtCpLMhFnhUWA+6/JYxXYjvXliO3Qc8yNbTVfZoecZ8bSMovDXdFziSKnB+dxJQ94ki8c3eYMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdFPITCNeYRxCGb9fUyANh54EvQdQHAryXOsUqnJL+I=;
 b=rs9znMqesJKdB8rWSOBEV/RbatIHw1RkH96dvO82GIz2tktu56dJPCnSdce8vvfX4Y75QpReHUcogC8WoXoWUmp6XVX6XjJqLbZmDwiMT9REJ8YfYMkGLf9kQu8LLBwhuMuojD1OTdH62+2zZA2fluP9kaF1LyphG6D+QBQ8Ljjmw8uD1v9lnAVMUhkFkEC7pSJ+PV9W74s4fNiYOStb+aFARciopKM+PY2NRics4TcFo/7ulJ7cA/K4tvfw1fOik1tTLw+4U2rgbvvpOuUaeEsMBTqr6wsDsR+LDsn3CZkPvclRjdIT6S4tsbMeHqo8J+Hyw1oTTmhTpjRaWf0UhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdFPITCNeYRxCGb9fUyANh54EvQdQHAryXOsUqnJL+I=;
 b=MMSaPYTJYGDMG0yMw/loXBNvhUjt+6Rva4MGuDtp7l3AnOzPH2VUdA6LxxpU7obGg0hxXiktnDghdfaHBp96oBYXYTogVVTT58tIsdyNaFNBK5u6HIGPuIItngJ+Ax/i8CFTRVpx0CC3ziVc0YVqR2iKhpsL+0KZ0rECu5nQh0wD0cSzUznlroySDjrXAt1DFafaxhMdow5Z8cM02p46vY2yVi1yMeYeoFedmzDC6ggBBs0Td2KS4cilWKDSM6lLAOXlDt0QzaRu1DBwe58wfmHsf9uv6o0ig/i6obyfBaAaoyeBdCPvwbsBZVHG+nIi/tPkG/YwsVKpy12zO4e0Eg==
Received: from MW4PR03CA0320.namprd03.prod.outlook.com (2603:10b6:303:dd::25)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 06:57:21 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::7) by MW4PR03CA0320.outlook.office365.com
 (2603:10b6:303:dd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:10 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:05 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 07/12] xfrm: Unmask upper DSCP bits in xfrm_get_tos()
Date: Thu, 29 Aug 2024 09:54:54 +0300
Message-ID: <20240829065459.2273106-8-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 575634b1-67c5-43e0-015a-08dcc7f7d457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?klkGLo892iWd/01H1L9laFrzWZ0u2+rF7szZ+DG2mF24zbs9e4EStBLCNvc8?=
 =?us-ascii?Q?9AfPHIl915JkrN/LKtd6YSAXRWzH5r9A4fF0n4oJglHabwqj1nhhgkHFI97h?=
 =?us-ascii?Q?OibPQ4bcbhhlh45AWHBUj+kuOt2BPXBrXN1GyfbdKi/iyXlEpCm+nORWjzo7?=
 =?us-ascii?Q?eePTVUPPf8wIJQvazQwKdo85Enizdkhg9uSFnQDKiz+HNTOWmoiaasPW90xR?=
 =?us-ascii?Q?xYIZx94PdgyZ9t00LEFw11yOSShFRqGXrbONZnv2OEcDWYbJbEkcAV0YwLtX?=
 =?us-ascii?Q?Drp7buszvdaVev5p7Ft1p57n59bqPtxc8jIyDWHkOH9uIQR2I4uPKj6Poc6c?=
 =?us-ascii?Q?QqlaXHH/CSadwHo4Zwrlf14N0bb58IDEQhnTUCdK0OdKu0ADg9dYzqY0yQMz?=
 =?us-ascii?Q?ant1b1Q7odbDlBww/Kqt6fokRk2hXgR44pbNLbdf/58M7XZx/tVVc/0/nxn2?=
 =?us-ascii?Q?qQVJ0j5Sg8TYoA1/i+N/88nvi3qTkqSl5iT+rqhbY16NgsegUdBSIfg+nctN?=
 =?us-ascii?Q?Unor6nCLcpYM3OXkadrgGScjgMLBrUaQHFbsuS9HLyxIKmH2EUVOx0AnQS/b?=
 =?us-ascii?Q?h08zXy3tITSPcAsOxe/AUR+7PK98e4sOsRtU63stQTvZRsEXzRRB4qZ8C8wc?=
 =?us-ascii?Q?tX80I2x8rv4EbqVGNfSk2WViqCwKyfFPRcVpgTMNAeGcyUXi1Anu3vrZiDEp?=
 =?us-ascii?Q?IcQPsXbsoPYykeg3SQ8VAmB1N5hLcSCVQ26SARGMRoTB6AkaxbCRjzrvq9rR?=
 =?us-ascii?Q?mBa+4W8nVj49dL8jUQgBsiaDDsxu1sx7geiw3aSen1wlWPhu9K8V1u/EoRbk?=
 =?us-ascii?Q?f9XWZyKGa29DnO2I66LcumatkNuLJVQv395jdEKvW9oCXQ97dmKhHcSmfYhR?=
 =?us-ascii?Q?PXuKsfv51bX80SRn0SU3ojkXcwHyn7Ig2DqS7vYTxawIbLIEriM51Y0nijC0?=
 =?us-ascii?Q?wswTDWda3CsCxjeYcXX4F6W5yu16EpDYukfE3b1vBwyGTIpfaGQ4xtQud7Go?=
 =?us-ascii?Q?KUp4IL2AFHjQiovV8oTcwZZjuNSstcPDLXdmPTNOhBD2eLWU0X79VP5VjlGs?=
 =?us-ascii?Q?NIAJJcljQ2EKmAjYTcmJDyJGfV6ctJ2O50sBtI7rn8yVgqDz/Mc54etfX92O?=
 =?us-ascii?Q?M9uMcVWyb09QVuM/OLUUwge8b9AOEMBCsLmxt1LMZNr7XZq8iKU0nL8YqNXp?=
 =?us-ascii?Q?gzGsNvlxOeKYFpilQOAqiji9vMC7XByCktMGVAkNO26KFsM7SCw2JKwtqH1a?=
 =?us-ascii?Q?aLv8/FqJ9oBXWJF+wJ3dJpfVGXbFWIH21FP1Llu38AZnLyb3x8Rims1orJXY?=
 =?us-ascii?Q?QPRay5U+QRhebpmwGM25/nTi3O1tcUJCyHw0Yxvf56L0lvx3H3CxY6qci8Jw?=
 =?us-ascii?Q?wXNx0Aga/FwpuhCV6InhpOa2K8SH+mhFI3Oiyb57cAGsdVFYbjVwks0oT7pz?=
 =?us-ascii?Q?fNfFC0k8Emdjv86BvtnkrtxGRcAoSKs3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:21.2151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575634b1-67c5-43e0-015a-08dcc7f7d457
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308

The function returns a value that is used to initialize 'flowi4_tos'
before being passed to the FIB lookup API in the following call chain:

xfrm_bundle_create()
	tos = xfrm_get_tos(fl, family)
	xfrm_dst_lookup(..., tos, ...)
		__xfrm_dst_lookup(..., tos, ...)
			xfrm4_dst_lookup(..., tos, ...)
				__xfrm4_dst_lookup(..., tos, ...)
					fl4->flowi4_tos = tos
					__ip_route_output_key(net, fl4)

Unmask the upper DSCP bits so that in the future the output route lookup
could be performed according to the full DSCP value.

Remove IPTOS_RT_MASK since it is no longer used.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/route.h    | 2 --
 net/xfrm/xfrm_policy.c | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index b896f086ec8e..1789f1e6640b 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -266,8 +266,6 @@ static inline void ip_rt_put(struct rtable *rt)
 	dst_release(&rt->dst);
 }
 
-#define IPTOS_RT_MASK	(IPTOS_TOS_MASK & ~3)
-
 extern const __u8 ip_tos2prio[16];
 
 static inline char rt_tos2priority(u8 tos)
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c56c61b0c12e..b22767c0c078 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -45,6 +45,7 @@
 #ifdef CONFIG_XFRM_ESPINTCP
 #include <net/espintcp.h>
 #endif
+#include <net/inet_dscp.h>
 
 #include "xfrm_hash.h"
 
@@ -2561,7 +2562,7 @@ xfrm_tmpl_resolve(struct xfrm_policy **pols, int npols, const struct flowi *fl,
 static int xfrm_get_tos(const struct flowi *fl, int family)
 {
 	if (family == AF_INET)
-		return IPTOS_RT_MASK & fl->u.ip4.flowi4_tos;
+		return fl->u.ip4.flowi4_tos & INET_DSCP_MASK;
 
 	return 0;
 }
-- 
2.46.0


