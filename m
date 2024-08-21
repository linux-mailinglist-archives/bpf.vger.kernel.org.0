Return-Path: <bpf+bounces-37704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6E959C76
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063331F239D8
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1D199926;
	Wed, 21 Aug 2024 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ST6CnQy4"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6281917E3;
	Wed, 21 Aug 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244901; cv=fail; b=gZiJB8TN/vODMLsMboSPP2TVMYcW7uQmKEY4CAWOm/KGNgaKVOMx1JkZqa2/yGqIzDN4Ft2LWdsyL2TH+5XYcJ4vj1iKLwXbXkhcTH6lfaJml41thno0pHvvf8bV931NqO+leQcWMe8/A3LwCvdAVP067dsLQgZo7eZS8S2/pqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244901; c=relaxed/simple;
	bh=Ssgb6Gjv8Djkc940o+y++j8P4eTDOEMBFYMxsxaxxo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfYNddqF0g9rQj4UqwojVAo4MBEhIHBec5mxgfo23LNXEigv5ByGK39UNHYmnF/Si/Ice37L+m5+7qavhAH6WgcBEf2TkYd7dl5grhiQ6yGid0EXfITwTHNZSDfhCAgtEboz2mjb5H4ARZTbhMg1KvA3QhpEMpVKRY4QKtr9AQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ST6CnQy4; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtiDwjApGqOb9noUEiZcU3VGchn6orrkdR1jdhNrEC6yjDo4DyxHQTBumW4O47QW+m/Kb+pDqZVfsYiK9WiwbhO+NGJXTRA0PvKfw5MqCh2ggAk3ejg0VcJOmXsNyGVz9n6XyzwlvaqnUAAaE+L3/I++XOJCnSepuavH7FwXNOmYPfRYZGNtHU+Xa0fE0m2f6yo2Ck/fb3MGWwb8uEBrB5dJWMN6BUNziI1BRaNZgTiJoRPECdpNy4vWJOgfam5Vkt3XxnKD/MlgGPgTx1jgJzVT7uD1NJ3LaG5/aE2PwtQEeQTuDuSQP8Z/fzMjOdAYZP+AukA26PmQZbbHRRDhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oxap+lbKuGnFwiMyedrVUKBjetL57NAW/XhLbwv1o4=;
 b=FeLhb75PUbRBBARq69EqI8fIQ9gnDA4eZmPzKvrZERbgj327YtG+kMYEJndFPVvxZnjqDjIVu8y1i7Yiwir0Q2H9HiQrSas/t1pPqvM9FUZ2OzBrfiirnzNnBqHFI24V1B5KvLHo+36cUdFyDby+zdcR1nYw3ag3BxWOYCKU4PXcFghPJRyrBmkNBUGSJ8cl9NPfTWZEs0ePS2qATyG2pj3I2ia3dmaarNneWQtl/q54eaFljvI+GR9kygRT85ga4jST1H99QliTXqmKtcohztQXDR4j3j8G+3hCHfRIB0tVGSBuHwKyJYWMMoLejDd33po8Brk927Nv9lEbWtD29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oxap+lbKuGnFwiMyedrVUKBjetL57NAW/XhLbwv1o4=;
 b=ST6CnQy4k2NW9dZuFqGksHRguTEtm6UHt2TALkJ63lz/UGDW0M3TIBkT7uznu20Fj1afo08jb8+JVulcuIlBN3ZScX55xJwMUD4WsFhrpF5zMb9NhF7ZMmTIFtTv0X1l1gTsRtB53XohMO945jg3jokTP7+mgW0tvGEwb3ukjAJuD4XRMhNGMp+/uBGPydGOhrtBddeNFZ2P9yo87nMRiGo4ioS00TFeSiCfiMwbyUbOlTksDwa+sLItT6B5dJ71oTBpihJULCaez1BEi58MwcptB4e4FATOfJPSxWqNO7WnAOZ4u/6eQycuy+CDAe2wV/UEcvRxyhC4P028ZeBpFA==
Received: from DS7PR05CA0076.namprd05.prod.outlook.com (2603:10b6:8:57::13) by
 PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 12:54:55 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::48) by DS7PR05CA0076.outlook.office365.com
 (2603:10b6:8:57::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Wed, 21 Aug 2024 12:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:54:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:42 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:37 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 01/12] bpf: Unmask upper DSCP bits in bpf_fib_lookup() helper
Date: Wed, 21 Aug 2024 15:52:40 +0300
Message-ID: <20240821125251.1571445-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: efd79f00-2d11-4039-313d-08dcc1e074a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fh+ULgAkDsLgLFbnbLiSAfgA7WJQv9E4bFPrgwYigWYZuScyPYyNcbBsl8B4?=
 =?us-ascii?Q?L2gYjFToVlVuB5t/Rqk4z4S/9yKJfZUSBfJtbGkVrxNJ3fWWJlXpPabIOZ3O?=
 =?us-ascii?Q?h4dbX9Wj8TkYSdAAOWTdNZQTOk8Qev1D4zm9yMRU0qCfnl+IeSWlLP9yUx+s?=
 =?us-ascii?Q?OaQeDHu9BNAFBX03tLpptOj+WbvF2WGHHDEQmz9hrwpOS7MxJpMd7PF5D9qy?=
 =?us-ascii?Q?GB3gp75RIfVntLlc2DpbfdlDwB1h8k69x7psIMjqdluVll9DgwDaognSwR92?=
 =?us-ascii?Q?mS+oPpmEQglhSQNRLzFF6A6UXnQ7Z4ICoRmN9gVSTCxSp2HfAbsCT9sU/VQl?=
 =?us-ascii?Q?PqwygooqBGXd+1NiWPEp9Hqt+F5mS3CJ+3Rvf4ewLuUBspF1xWoKebB+M8Of?=
 =?us-ascii?Q?qUaHkG6hsTI/NWVEWGEMAKf0D5JvxhmREXnikY21GrjTDn9DWFenmhJUyv6m?=
 =?us-ascii?Q?gKfXus7l1IxYderu/QrC/gDy5b/2txT3gGvcNOdGTImKcVO6h/GxjJfsrLT+?=
 =?us-ascii?Q?cKH5Q42+DNimMLVs/JRbHkmhknnitat3K9PzxnpWozzofeR/0n2czN23j6mW?=
 =?us-ascii?Q?fGZX3N5wh4xuu4tH2SXhWpQi3TR3Sq12a5o8AozaZh1RuRwYegfb+R201sNp?=
 =?us-ascii?Q?bQ6Rxj1MX+4DCjFdytHRQv5SWDlrsskYwQS5ROMvhOhSbJ5tRM7GzxL4tS5x?=
 =?us-ascii?Q?qtuJGoWEltu6YF2N3pY494gHf2pozqbykkLa38pkdOsZmk87tcBSLTu9YqdJ?=
 =?us-ascii?Q?ka6rewDhSQ6YjtbKpaEyXT3luIOebfOz9PG1XDK9WPFCe0b1LgCx3pRwZLaQ?=
 =?us-ascii?Q?SuwmRYT1h0WaVAQ0NR/USpquWR/LxnB62X6JPU4d91x2ioer9Pgp3WgvJAEP?=
 =?us-ascii?Q?ZH3slcu1dE3XjIx3FyxEFig4F6NvxLEzZtyBgBNuyHs1Ki46qStKCY8kD0Q9?=
 =?us-ascii?Q?Yc1o2vRCEpsgXaBFcQpfZtudoZSKpXbnD4WfK6dSOVtQsHKFhy8pVc8dU5YS?=
 =?us-ascii?Q?giudxkIwvlu0+2xw+JOkvKmHPtiZzsxRJT+cbHCZZbn5aIxLDYq6yPm+TPN9?=
 =?us-ascii?Q?j9LcY6wtnVCUxTOCfISWvTjbChoW4adQX0H29pnQAc4ve9aGVvSjsfkZ0hvC?=
 =?us-ascii?Q?ugpbvYKx/1k9EXDVnWEqY3AbrFRKai207RG8zRwIIphK5mnMMxScHPb75A5O?=
 =?us-ascii?Q?9upWPC1U0rh2zg1+UO8quOE4gtLUIjbHXNA5wtogn1DfXH8GoSLeRL6hISqz?=
 =?us-ascii?Q?S8camucU3AZrmSuCcxS7Db1Y3xJKumq1eRP/n4pOUhbX1Ug0rnJmbMgKeX9z?=
 =?us-ascii?Q?U8X+leJVCcqQ7IgF71/4H6kxjDxSHDbBc5GhT/odgWdXVoxASvdh8xHacOqO?=
 =?us-ascii?Q?A27dqoqn9TdmoRUOirw9zFbTH3CeGUEM7j6f+5z79Jh2yTiDWYigXarUvNrO?=
 =?us-ascii?Q?eJ6ZHFmSdqOgXlJ3YkDwwqIHiTQUa2D9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:54:55.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd79f00-2d11-4039-313d-08dcc1e074a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330

The helper performs a FIB lookup according to the parameters in the
'params' argument, one of which is 'tos'. According to the test in
test_tc_neigh_fib.c, it seems that BPF programs are expected to
initialize the 'tos' field to the full 8 bit DS field from the IPv4
header.

Unmask the upper DSCP bits before invoking the IPv4 FIB lookup APIs so
that in the future the lookup could be performed according to the full
DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f3c72cf86099..89f56fac48fb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,7 @@
 #include <net/netkit.h>
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
+#include <net/inet_dscp.h>
 
 #include "dev.h"
 
@@ -5899,7 +5900,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl4.flowi4_iif = params->ifindex;
 		fl4.flowi4_oif = 0;
 	}
-	fl4.flowi4_tos = params->tos & IPTOS_RT_MASK;
+	fl4.flowi4_tos = params->tos & INET_DSCP_MASK;
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_flags = 0;
 
-- 
2.46.0


