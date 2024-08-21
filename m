Return-Path: <bpf+bounces-37708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40930959C82
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76631F23859
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86B199935;
	Wed, 21 Aug 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UrqK9lOh"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835818FDC2;
	Wed, 21 Aug 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244927; cv=fail; b=C59tRV15Q4aSKtbGtNYRlm5snomdTuBtjkLA+E0yzMdLFSHRDhkgTUpHtIX9AYnK14zdR+aM0YMxSxoeJq+fNERSj+pQ8/EwJKG1/RHX8ekF/QKxgGcYXU5nEbds8Ocyfv9u3MUqkM0qjJPbhxCIfJw2mh9ENHFI8t7l/PoJemc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244927; c=relaxed/simple;
	bh=tFfe1m1phJMQAeHy0OTTn0InTibgNkWbO5yfLrZJ4VA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4vz5Tkw0YcH0a9cJk/AgVzqW4DDcbm4mVT0daEhe6gawamn2hBTlUXwN7pK1YeoQ949AtWGRlXCjitF4UBqpIf65EY6ju7gfAWvZDn8WLRgn34EyKJANzpH7yVV9babTqSmW76S/gXJZLwS8SfGLgnA3BXehXxwkkB/EHW+U78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UrqK9lOh; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI2IrvoyR0tUNq4C+mhN1pdhjKnqwjw/SAxMh3JQIMrqqfM4smmf2R2YtEpwqhTaJ/1+EleXs08/fFMCcoGQTY0dDMQiSnLVViAGcNEkcsw62PociPR+UaDelgletgP67sWFgBhspb3MauI8VNU4dbRdlWZCIHP/gYBAedqVgM2/lw8HNtAhOkE5FRHvGnV1yQIzC/rPrcsCn/H1pQO1xSSi3wioJ7QGVnjeq/Em11F5Qpv7nemMsmim3uKvQoIAZRIqbxeXPvK7haEfYeh8X3HV0x68+AFCHoA70Eufa+vamspeiGQP7oLKFFb1XncHc8qmGkQXZg5A+zzAeLwrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttnnAoH0ChuxN0hsf2yxSrdVVDBZKnO8NUsYq+YYLsw=;
 b=PZh/M3JeacQRXPxZWiW0v75rVKwoXZfKcAHlMvfgwWBMTr7BjsvdXXVyFsrpYzkF5uNZCAwkjKuwgrMX3kCch8iLZ/OuUJW9tUD1/TxPz9n1NLPFF8s0bsui98QEslNJ8ABda0v3W9udZ6LcmPO1ADVeQ4L2A/q+eQ0mGccRZC/fC4kYHLzue/8lLJzqLdblnQ5Zr2A7Lg0UGyCT5DkYhi8Isj+WEE0y0KFpDNhQIEEHqek8Zi+LbmsvVTaOMcmyhpJsFM9v5vjyVQTYnLo3DYU4VsibqZXFTSYgPHdN81mTI1FF7ilUqfLZf6f73UiA0hFOCMIgKe38DbYGv8bxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttnnAoH0ChuxN0hsf2yxSrdVVDBZKnO8NUsYq+YYLsw=;
 b=UrqK9lOh7EMTOmQ3n/OKEIdng1KwBY+RyJybiCOYH+z6JKRN47h1kPdGBE6OEDxX9x5et9kmYs9h8bwGSPuyeO4+2VC6Jm5FkoorrXycqzygS4Yf+aRYuDeh3H6c1pMjb0fYTbUTKObRxPbFqEl0kSVqL48vwJqh4Nyb6hhdqFp8wqVyXVAlkYQciljoBeQeH7xVxIZomlR74oJmyOmn43rsYQUV92pauXC/U59QgN7AfophzIbr+WvM46RhQ0L4R5hnEkJIpuB2N9s9XBxNPaJVb4TxkdtI8hf7RN2ZkXU2VNq77sBvSBBJpfpy+B+gDiiuRjLxeJ+jDrx6nz1/hg==
Received: from SA9PR13CA0010.namprd13.prod.outlook.com (2603:10b6:806:21::15)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 12:55:22 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::77) by SA9PR13CA0010.outlook.office365.com
 (2603:10b6:806:21::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:03 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:58 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 05/12] netfilter: nft_fib: Unmask upper DSCP bits
Date: Wed, 21 Aug 2024 15:52:44 +0300
Message-ID: <20240821125251.1571445-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821125251.1571445-1-idosch@nvidia.com>
References: <20240821125251.1571445-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ffe3cb-6fdc-4fac-b5c1-08dcc1e084c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlUySpFFQbaP+GEt0rEy3a8/9biH2w/aM8XYppiAPClqt2Z6GxidZW+3N7RZ?=
 =?us-ascii?Q?yBU2wH/jAItGoHzJ3AbhdFQPF39CvBN8Pi7SP/u1sRYDNp2zpdCAO37cIaW8?=
 =?us-ascii?Q?RSBh3PFXeWcMEgCmoQHKIxWuGssRKia9ix1Obl7oPxvHYcNijyz29diwlnY2?=
 =?us-ascii?Q?ft8uqCQ+2pll5WNJN2jjYhWoqebny9Ztll80qxZ8EK9uuPkdlX1083afx84O?=
 =?us-ascii?Q?M65RAVFwMFG/eLxWdvEoYDB86vYAso/zay30owfxCDT9mAocq7ta7tDDhynD?=
 =?us-ascii?Q?y5lBRWOwr2fdFKhf9uQkH1T+QbSAaKPUfeEucuBD8xPToAqvxGOOgbfsZmuy?=
 =?us-ascii?Q?Ow1Nuv/TC78XVlfZEGEi2R63+YAs6TVUgu1ASbwNSc7fL2eyo2lO7Aucs29L?=
 =?us-ascii?Q?Glz60A9bwFGM1YWIOtmnQ0XUoNzOPN2n1Wan9InftAIdpZ9v9vbllNdv5Jis?=
 =?us-ascii?Q?cNNLKn7X95zq3o0iGweC7edE9M6wAPcXKhrWYjhPfJ251U+F+tO7WEi8uHo5?=
 =?us-ascii?Q?wrV8DuygRNYyy4s7gre+N7fljZwPkoQd06jHmK3/B1ZEegMsg42elPrlsTSD?=
 =?us-ascii?Q?UHDj0KyCI+JS9WBnKRlGZpzm1lyT1hGKXNs3aGizSsVoQ8kAJghDvIbWgT5A?=
 =?us-ascii?Q?Qh5Ljag0VEWVTCJkp/z/O87AGnd7tYttvMgc/YJ0yBE16bl15zRCul7wS6AR?=
 =?us-ascii?Q?ORo4ZAwwPXszyq8YH+0UE3Vc9XQoWKwcFOLSilu5OWGjgdEv05VIgWdcgj0V?=
 =?us-ascii?Q?QfKcAOUn4ANgvL2VRMJv8mgKCWT1X/14anB1qVGtwGG5WHO2I61TZQXnsuVE?=
 =?us-ascii?Q?0PvoOQkdbRyHs3Mvzij8ICe0qIZJObPqQek+WS+55S5WvEQnlArXIDc0n4/0?=
 =?us-ascii?Q?EFEmGyNxaFruIh0vTav8Gzdv6xiRULRpTI/cnoEJT5qdMuc2nU6I4MHrOHSb?=
 =?us-ascii?Q?yZSd37keNrdVXhS9nAKxJHfL7sEXtNc6hY/s7FwL//51lneguni6NPtoceDV?=
 =?us-ascii?Q?IXLeJza7ZbFDNd7GuD7NvsVNH2cFHrGo0wVzC7+8jqL6KrOwXgVXHjgWGCkq?=
 =?us-ascii?Q?H/753SEeKYxhflKVvS8MrRb4OrvrCO6rWEpXLkD5mjghQ4n1PpVNZNStbtDH?=
 =?us-ascii?Q?nWwk9ZDusJQXylSrpjKaTvxPx+Q1iMqZSnA/ArmuFzYyattqPxRrLv5xkdu6?=
 =?us-ascii?Q?kV47mbbJP3v2Lf3KBHs3eWe82N1KDLsH8/tzLXWJN1O8MKrhmuZ4HknkhvG/?=
 =?us-ascii?Q?nU9TGWclTM4TiwK275ShYpAUQmUvA7VlBE4f0tGmH1Xl6QyY25KIBcdefWku?=
 =?us-ascii?Q?8TIw6zrpdacieoqIIEDeYrWbmLg7rew12icDEYnx/pD8QukYEp8/366E4Pa2?=
 =?us-ascii?Q?ygVg6PpsM2skYqfsC9qpTsHxQ7EsP2CuzHYdc4fwus/MzJgkwnhO+DReR/Mt?=
 =?us-ascii?Q?5Edg29SbWgmFAFKA+T2Dbx3/o9+V6QFx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:22.2393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ffe3cb-6fdc-4fac-b5c1-08dcc1e084c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

In a similar fashion to the iptables rpfilter match, unmask the upper
DSCP bits of the DS field of the currently tested packet so that in the
future the FIB lookup could be performed according to the full DSCP
value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/netfilter/nft_fib_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index df94bc28c3d7..00da1332bbf1 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -10,6 +10,7 @@
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nft_fib.h>
 
+#include <net/inet_dscp.h>
 #include <net/ip_fib.h>
 #include <net/route.h>
 
@@ -108,7 +109,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	if (priv->flags & NFTA_FIB_F_MARK)
 		fl4.flowi4_mark = pkt->skb->mark;
 
-	fl4.flowi4_tos = iph->tos & IPTOS_RT_MASK;
+	fl4.flowi4_tos = iph->tos & INET_DSCP_MASK;
 
 	if (priv->flags & NFTA_FIB_F_DADDR) {
 		fl4.daddr = iph->daddr;
-- 
2.46.0


