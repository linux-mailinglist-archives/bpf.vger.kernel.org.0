Return-Path: <bpf+bounces-38379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB303963C1F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F10C2868DA
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7B16EBF4;
	Thu, 29 Aug 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SePJsqOL"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245F15E5C0;
	Thu, 29 Aug 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914687; cv=fail; b=jVYf4HbarkpITkSbUwP7aoxDIz+InpTTSpZyCApk/tv4XwM99B+GyqCX65aZh1ROq6iD0dWJxgSrZPBnsHPXOVPWyacSNcEOTnBEELBQ5MaPlTUdJF4kDmfZaihFwQMAYMrJFjnPs0iH+5juI/A7+Ds6ma61iPtdghYvAKzpiDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914687; c=relaxed/simple;
	bh=5KTqU4JntSTsJdIhbrp6bHPxu/XXGn+lkQXKhaVfxFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiLCdhkCYCTUzu/Bs6+wZ5tGHVbNoq8NMO4YDQFDi+p/BU3NcJ0HMnFvJqu4j8hiIl71xx1XvdLpnH0UIA2zgfDc0ydnAMZhYk5iXLwUGeErN/39KwBLbbOpXaFL1AmUyXxh5qNeoWvNdHK589ksqq/sofgHV2Hjnr0p5mzdWe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SePJsqOL; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouiTY5KumSy4NLIKk9v+DfuYGjncKdjhy8i/KjtGeDlswi+Dpl9lkbM9SUgFxMwwrfseFD9JmwGt/U7TvzgfmxWDlGo9+lECcun+I857KQZzHAhsnv9exb0TVQwQ9BZiDLs73vFqA9skHLCFkGI9JiDEKJGRo8G6ew00owiaoOl5jBnCOVSo/02O+xCuOV16W3KUwNjvFbM5JNO60lLmk3ou6u6FbwJMPyZL+0IaZHB/r7SLJygtd2x/0umcs7wrGxczHPJzCGzSNNUR31bs5XTnS9yRz16SeFunca1qX7UfNCMghSP/1hL6rfTizvgCNqFFnFIqV2CqtbFu/olHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alonQpJ9HT9EaR2IMd1Oh85w1Z/2Rn+SvwQrGdHkO64=;
 b=h22rRvYcEF7xOiCBRWgrgsCI8y4ID5esxYFmRhV5p0pdcxWRlH6sW4Ll8zbI7pGsGqOhbBQxjON/64jOLxzwBVzm806anuCjCCRZlwjVVyaFXfIrYxTEGOuL0P/vNGQJsWu5FcpeARyomkHSC2JEO97UsyV4kGkmigqIQFgqKjFC7YSFSVFIPkD9byZNx5NTdMcScmJ1xsvAo3xm/WXvlfdQB7BlzENdxvqD3jE+vI4UnnkyKqGTgwvMUp5Z1QSlcyL3U1Fl37u0yQfZdhPdSwyBgQD07jp4Va/dKrRRqI6Zllmwr8CRmaOZksU8x2E19OhPbPxZYBJ0uoW48MMagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alonQpJ9HT9EaR2IMd1Oh85w1Z/2Rn+SvwQrGdHkO64=;
 b=SePJsqOL/RFYka8xhQ3BFmYzI/dpsRUsonRJPguEluTzgmLFitFXFUcwZQWu6UFBvvt1DSzdXFWVdZbQ/2cJLOT8q4nnvWMk6ZcMhVG5MM64ZYe75ab0KlbKmFtFGcSW9ioydS1+dsXApY0brR3pRQ+pk9wYFx7pWcCxJA48uONdrVNA0MtPfmoTeENvn2HdgVwRjNxRtlBnTydSs5vntOpOAvnQcuPay8rUhiE7zwFzC4A0Fq4wnFsaLpQnT4vajMn6dUHKxkkAgc6U5QeJDc1cmY6T6tvCuR7CZUo3A0GY2JBngZV+PxKznbzB8MxTBupFCQWHQcLKur5/Fs825g==
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 06:58:03 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::9) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 06:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:58:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:43 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:57:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 12/12] bpf: Unmask upper DSCP bits in __bpf_redirect_neigh_v4()
Date: Thu, 29 Aug 2024 09:54:59 +0300
Message-ID: <20240829065459.2273106-13-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: d9de2095-f7ab-4af1-c2c9-08dcc7f7ed33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GNN6PQoxM76ekgYE01pZGVDotUKuNZI3i8nOzlYw8L/Zcw9Zo9ayUHuG3mTh?=
 =?us-ascii?Q?qWjJnf9ALZStNnGTejHdkzgwtlWNVO+5G4HbStvfWfO1oeiTaSsSiqQs5H0C?=
 =?us-ascii?Q?dwUKCgdOT+rzSPf5tI9K9wXZadO3TysKQnh/nousOpgpMpGBsNcQwV1Al29h?=
 =?us-ascii?Q?OldRyoCjFjv45uVUVud2NltLh1gITSvdHByAyAlHUtx3LkOLVHQ77BZU0aks?=
 =?us-ascii?Q?MB38UiWvLw3254c2VX+HYDWwqbtUwpvLZecYpOra/QEP7/6EaaQ7c7rSffeG?=
 =?us-ascii?Q?DMo/ocmBEj5RKyNM4zoj62DlKHvno/UGptSiQOdnEFj4jBzVeUOONpECi00h?=
 =?us-ascii?Q?qFh69/MQbHIu5sMIcYG23nIP2uczR0tY/IRTiEOmWv0K4WpND6Ynk2g8u5Qp?=
 =?us-ascii?Q?uzeAx1t6kVCbgVnHieetjONek81w0/MPBIWWNFKHv8csgs3UrOHM5gK3GKMI?=
 =?us-ascii?Q?H0dgVngVJEgr7oohtliPkeHoQ91cSdf2CgaZMjB317i9+J94c7Fnh9uUWP2o?=
 =?us-ascii?Q?6z2YRlGMZjigO/Rw1IPMB0mZ7Ph1NWoMDACvbDtyKcbhlJhOgUiIAqzcxTWm?=
 =?us-ascii?Q?S7+4Eu07uN7b/B7wFgw9UX9Wca1qrmbDKBgKNNsn7nmrxwl6UlM/X6belvwF?=
 =?us-ascii?Q?JSuQ5m8eHVML1IEfXABXLPpEBvLVinfk+QPqCWA1SLY5SBFW+U8jk5dS6Xqz?=
 =?us-ascii?Q?oRCZkSazI20HtOIn3qIf5Iaqh++wsZ6jlboj4sLPUt9BT7CBAzkHm+1kB2GZ?=
 =?us-ascii?Q?aZAjdCn9cGv0kCh7Wncc+crdBaQ9QuqyWe0K37MkUBQ11NG7DKmZkiVZIIVU?=
 =?us-ascii?Q?J595Sout2YolcOINWzolRYdO4fmYD4M9lJmznZ7cWnYJgrtfW8d3W/uhRnAg?=
 =?us-ascii?Q?B+86EHiW/3cqKomoHjw7GzMLa3CvvKihx1YQwuXnB5SrwElprUKBflmQeDZK?=
 =?us-ascii?Q?KM7Xw12X8vgEkiapn7+L4rC35TFnQviIs8LZxK4bo9oew82SCjS48xGgNz4q?=
 =?us-ascii?Q?+Q5xmGBLxeTJnfi5jI6cMU629mxopIFG1XautM3mZBCqcFrPbzox3si+ObuB?=
 =?us-ascii?Q?+BoVnv8rLujc20MxYm83rhRuKErTlypvKJfyEXeVM1JVPcBbW83BOucqiR+U?=
 =?us-ascii?Q?wLEYO3W3UZuE2+YcDK9G4mxHdSTYNgMFudizloQW+kH5cpfl/lsL6a9mgvSj?=
 =?us-ascii?Q?seDCfgr8ru3lBFTH15VaT58hI5C/WWQSaSAbLaTGhGFNt42GAqCNa6a5uZjJ?=
 =?us-ascii?Q?7I0Uf8Yyv9tFcjkHI1Vi+/vottg7nxHr8Bii1r0WNsvfx4Bif9BfC9m8qYXy?=
 =?us-ascii?Q?0/FiZrBIodRVm2lk0rYNlhKIKX5+6vG+MC/8VmBxZWXBWRr10fyypx34AbRL?=
 =?us-ascii?Q?wETcy5cjJU4wHwa+xky8SHlJyl5qfTOmR8fjkia6vFnBJAhWqaNQfV8nKc3D?=
 =?us-ascii?Q?h7xHZcS7VK7AbqsaB0XwIH7fU7yMGC01?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:58:02.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9de2095-f7ab-4af1-c2c9-08dcc7f7ed33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

Unmask the upper DSCP bits when calling ip_route_output_flow() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f09d875cc053..8569cd2482ee 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2372,7 +2372,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 		struct flowi4 fl4 = {
 			.flowi4_flags = FLOWI_FLAG_ANYSRC,
 			.flowi4_mark  = skb->mark,
-			.flowi4_tos   = RT_TOS(ip4h->tos),
+			.flowi4_tos   = ip4h->tos & INET_DSCP_MASK,
 			.flowi4_oif   = dev->ifindex,
 			.flowi4_proto = ip4h->protocol,
 			.daddr	      = ip4h->daddr,
-- 
2.46.0


