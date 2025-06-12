Return-Path: <bpf+bounces-60475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B59DAD76F6
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4ED17633C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0329C34B;
	Thu, 12 Jun 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dK/kBWPu"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F6298CAC;
	Thu, 12 Jun 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743260; cv=fail; b=g6ySRNWebm4IzgaikrrUZ3KbHZZXyxb3VJz6ofy2b4E6hObo6KjyZEXQD2DTSF6vOevy7fxAfLwPSHFnL5xSlPizYsEylQgHuFbKPC6aa3oagC86e56BOLaOiWn0eb+Sw4ULsJojLLct2WMBrLrbPHL/d/l5mfPKCBIkXIcZPzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743260; c=relaxed/simple;
	bh=fK31n1luX/Iewtw0abWfPxFgIyeIwopcfCtGfBUj/zQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faGKdwSHkwDfmW+5n8BnNkSxs8zzc2n0lFNeaa9bgDN5vxNHfC5G7jbGM2OybeYuKRAvbxaqHqxtHnQRdgYS7rRHK4IzPRnINMo3hQ6MhTjscWsLCk1BzO7u9kDmInwfahtVdojst+LWJ0Mk4b+UBhRhoEHLireiKr2pa3cZiSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dK/kBWPu; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzOQMgVbwPJ54yRshBFtt6zcCYmfZw4V6WQo2U97e/2IBQ9Otg013Ba1C4jEtvbK1prWLni0xc96Ntym0F3jcsn9lxzyi5++NhzjpExEBJUmwNK+ofvW6Pt0LDfjVXngwTmCT391OzfQyDjK3+6XttGC9rPWVOz51ne4jAFUgo6hC5egj+j08CNwxdqHhEz032swjw5QZ30gUTsrt3sKtcvg28Pc1P7YP14f/6ui/MFl+YoImjgwlPG3E3Cqco4XyAb7tliPiTXW1aUExPkjs5gRko/yDqnUIc/NxSScQUG66+E4RgR+Kpq3b+nErNr66A9J9xuXmwBDy7nqYSDRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMQMUUJjzcZTA1EgiUykQv0oxokoAAmDHIl9dLUmMMQ=;
 b=NtElmojtBonNlw20iDOWz56OeEvM1ZciqKiAh+qsCf79sn0DERsp2w8NZSOkgkbxn9knoRPRc35XoGa+wKk7do+OcXYOs2uQ3hizRUmAMXTX/lNdd9XEOapapNGKEICh5qsTcY0XcV1FNmnISfXXo/RnxZGxP+/aw9fF9k0ejggoKntbe6p2u6DFyMWy5sdUuMCtCw4d59rop3NbWSql50/VJFdQAqdd8kVd4LqePtcodHtwB1MV+rqMnXe0Eq1n+/GnoFfTMw0V5YSddAo+TmwQ5Iz5jCVek1QB4IftRGyuGEFNWMHCb4RKsTAcHSRNwVBefXeJ3iOHVCxMUezGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMQMUUJjzcZTA1EgiUykQv0oxokoAAmDHIl9dLUmMMQ=;
 b=dK/kBWPuUe64I3Gy8htULobdskvS+OITIldwc1f/rserrSyPMcPh+9L4rsCg/kojDpknO9dsGFPMrJ70UvHzoJlYcDQzVe6aXylJR8kL7IJ5NKtVN3U9hAlaitEhSbzEHLhRXklaRirQ//EZjLxK/wkQaBVCorfn/2CwvQ1u9u3ds7QMHPBFHhp6XnkL432cN2ka4iW+HUoDsFAWkxYealpEpw2Z4NPWWMaxNeUJxf75QhAh03RMdrbZwJJKbqZc4tY50IJB284pYc1IBgLgz3p7tukQPICRtVKYF8QX0k2049b4PSgr+Sj0vUgZbOytWNp0b/BEyfoWBnTmuDnZyA==
Received: from SA1PR02CA0003.namprd02.prod.outlook.com (2603:10b6:806:2cf::9)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 15:47:35 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::1e) by SA1PR02CA0003.outlook.office365.com
 (2603:10b6:806:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 15:47:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 08:47:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 08:47:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 12
 Jun 2025 08:47:10 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v5 03/12] page_pool: Add page_pool_dev_alloc_netmems helper
Date: Thu, 12 Jun 2025 18:46:39 +0300
Message-ID: <20250612154648.1161201-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612154648.1161201-1-mbloch@nvidia.com>
References: <20250612154648.1161201-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 529bccb6-a885-4c26-dc19-08dda9c87396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6qxPQtbz3M+50xHaM8vk2l3zwfmC7akk3gxh0+du6bElWx+spHUqHIRYbGA9?=
 =?us-ascii?Q?Q6JjJK2O3lJQUwOMP/yYi9Ifrz8Wd7oaJ562k7af/iTP0c61A2mdtvKf/nVJ?=
 =?us-ascii?Q?s6x8a2dSmPCj6Ym8gVV8u8tJov9AZWODL/SgwihZRbF7ESbDvQnsoDlRwWMQ?=
 =?us-ascii?Q?6/l9CBUZQ/uenvyZ+cu+p/Cpq4cxwJ2cU2IVneemvh0HxYZQHSQ0RuEGeUGI?=
 =?us-ascii?Q?64OmUfXIfCjeoRPlj/5lqrRPHPcxLZtSrq0Ie9FU7KE77Uv6iNjKiXaUIfUb?=
 =?us-ascii?Q?3YEwIPbdBX8g9yGnXCLvApJmpP5+ju1ABAzK74p1rdXxuBWE1EGdrYJJlXXy?=
 =?us-ascii?Q?UY2ewv3M11ZxlOx2afSj/L1Z4M/BL3QMrYREEyViLAFB53hUn90w+acl8iDi?=
 =?us-ascii?Q?tuked+TUVeQbj3Yxf7EF1gjJUHO1m88/fvOxGJzX1dnopzPqJz2w8RMbNIGz?=
 =?us-ascii?Q?I1KTrjfAcrPrHyrgyDL7e/59er/ULXwT8J/pMlcOlsrQTZA7+jYQY7/qGsH3?=
 =?us-ascii?Q?7eFP1Q6bDijGNW97FjVmigmyjxIinuLUw0PDoYMH3T0k4mu6yzp6Cb8qVLOh?=
 =?us-ascii?Q?JY514U8fokcuURLm1g02qWV8WDrAJ8mxNn4A9k3b2Ug36Gimi7X3EOGT2BIA?=
 =?us-ascii?Q?QD1a8pPOAqKcctxalmTBxFTM8TLDW7DAzUbk0scSVP2fZJuqRHD0xafWGJt/?=
 =?us-ascii?Q?OY5r/VUuP8NPUKsxe6w8lZjHi4xc3Fbb6JYMUqJB31vHfR3Ljbe6+9/n14h+?=
 =?us-ascii?Q?YTbXM53I1K/HIuWp8B50VPTd4sAosn+eXEoPBaECnarh/50vT4hRh3/87dzG?=
 =?us-ascii?Q?UaK2x+IQXIQnV1OFVHVqFVvx3EIQWALIgK8HNg7/OCblt9njrTGh6841XoIn?=
 =?us-ascii?Q?hYpYgP/ZLJHE6sZQElOQZnIIKkBQP+owntZpVv0274M4XS7VngpTH2fzGCjC?=
 =?us-ascii?Q?A3FtEEJLW/CME0kKQi9udR/Zod+hxtdh+qwB+B4l5gzZcGPvODtunLh6VvEx?=
 =?us-ascii?Q?OW5bDRNnisifshT3ZiBHGdqbqmVisGZnU8rldrghuuLZcRvARA7o6nISytvS?=
 =?us-ascii?Q?Nxdt3tTiOL8vaI2x/Y4jw01XDJ/AjsxhSZ3Em6C8uKPaCyBKoTKHhGUReWYb?=
 =?us-ascii?Q?JL3ofOL3/+6QWIK+jpCHlD7s4AY79SYbraRJgKUFFPwP0vuDV/HrZphIW7pe?=
 =?us-ascii?Q?x7oMrPK4QRoPJXq40Sx3y1wzI9+9nHirL+JSCEc4pNn+9VYr4yiZAC0u5xGK?=
 =?us-ascii?Q?OWaCdoLHgqAJ+7tSb6URlFl5AnUrNjXjuyTvdfIOejNAmcNzKVG0Ev9fE/0O?=
 =?us-ascii?Q?OYH0R8NaU1FmMIiUWEpv7ra3hbjvcuuFvOs9vNPbCuO0BD4gTt4y1QkDxKuG?=
 =?us-ascii?Q?rVh0astpd8l5/bRCQLdNBcypRRGJL8NURR4pB1IqNV+8IKxIzpBbXNWKKed7?=
 =?us-ascii?Q?mMnQZp/vZ6glH84Jl5rgs82B4NyDsaCCjMDrNfnlnPYeRhuxLp1vH4m/sgxk?=
 =?us-ascii?Q?PA0wcdLlkyfO2EggsHvtY4qc1n5lkzqIX2Xg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:47:35.2820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 529bccb6-a885-4c26-dc19-08dda9c87396
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

From: Dragos Tatulea <dtatulea@nvidia.com>

This is the netmem counterpart of page_pool_dev_alloc_pages() which
uses the default GFP flags for RX.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/net/page_pool/helpers.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 93f2c31baf9b..773fc65780b5 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -153,6 +153,13 @@ static inline netmem_ref page_pool_dev_alloc_netmem(struct page_pool *pool,
 	return page_pool_alloc_netmem(pool, offset, size, gfp);
 }
 
+static inline netmem_ref page_pool_dev_alloc_netmems(struct page_pool *pool)
+{
+	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
+
+	return page_pool_alloc_netmems(pool, gfp);
+}
+
 static inline struct page *page_pool_alloc(struct page_pool *pool,
 					   unsigned int *offset,
 					   unsigned int *size, gfp_t gfp)
-- 
2.34.1


