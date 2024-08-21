Return-Path: <bpf+bounces-37714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A583A959C9B
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6315E282BBB
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149831A4AC1;
	Wed, 21 Aug 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fktt/6jL"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F851A4AB0;
	Wed, 21 Aug 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244951; cv=fail; b=Tk4mBni0V7qRm1Yuzjhjj+F7DXfO77wnUEZa1FskLmNAfrxbz5viUlcNEL+VHEYshfVxBzc57Tae1zt8+Zgow6AB8CYfmgKAcLN0H3JFxpzdi1Ij+qtpJp31U+NzrI4CYoxFqZOD4bpN0b+AsDBA8L+tphN1GrI+qsLt+roMoBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244951; c=relaxed/simple;
	bh=KHf5+23Q1o8Z/tz2yhacSTmTS8F8a0rISZKnuL1Vc40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFJrCu/hz6awkQoIDmhlQXE+XR5noSyGlnBlqSywryxx3zsPrmgdFKg1ohJyT8noS6mz3z8ZWA5+eomWXergMyJgsdXrMg26bBCdJo0Y4DS8YqRw49rCHDlzzQzZXYIrKD/xXO+1NPoE5Pw8JRWc2UrxR5+9eyBcjodtnNpuVEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fktt/6jL; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxvXC2ryVEyVp+21GIp7sjhfj8Qd2DKusg1CLFuoexnXKwMXImn8w8quR0lPobQ2vily1iDTl2WyYkFmKJf5HS+CWBXQlFyGfHSryAoyicq821kD7EpHaG7v/Ur1yxhJApsjeEjUvAXDHPKtumJwg7eTZtWdeNoEMFFFc9nwfsJRUpMKfN+Bz87BHy27qO4arjHWfrb4fYZ3M3ur0PsAXHjcOogU253Tv38kzM9IvyU7f722z9kGGYXGp8QGTIpgX9FloyDGjjaXsMyfYQF9HJeEhQ/Pq/pupdWCoan8gwgrDvSssO5zdhGMPafnc42H0gZ+vIuujB3htmkaMzFWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvuohySGIZubXFsfVqYf1uOTo09t04eVhgB778+MlIs=;
 b=lK7E5hl/4g5SAxr2p0TZEgFxJwng2jGZKCRNIZzhtTjQBL/DV67f1NWbgj7YuRBej9Qj+Io3CQHuiegOTvXcNkJNwGdxMxz35ePo3g122kSPxtpNk6xcvyW2xa8pbGA6qQmXIpoLUUN/dKhapgfQWxyQuA+4j7nDTik0oiW13MBCsIRKEmiPlaZNKfRrnQEug5KsoVYgZnoFW6/+TXlrpLoM2upfOZ2/jA10N9eXesWVQ8BAYu31rhjNY4YKnKKhBn3xZDAbzReEK+bWXgGAk0DMyy0j4R1AByTyukLeKCAtMxuaTHjgOYRozpR7/XN1uQD2NNcmRBZa4RJYuhGp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvuohySGIZubXFsfVqYf1uOTo09t04eVhgB778+MlIs=;
 b=fktt/6jLlHzdZUv73vrBqYSnZwip0wB8cCRAafZ0YgPfqhIdWz7UQsUD1JXMj++woRmnn+Of9n+SE5inHpeqzRCDq4YetpwZr3Y47ERy3tggn8IJhpv5oURKT6n5inZ8HcEYtU43EviqtDSEu17UgWTpDKhti35Yl9ZC/pIpb0Ngqw4IK4gjOBvZcEKkQxUafTpZUfMdZ/amnoXu3AFdoCfgkOkOvrOY9+vsRBcd5mP8wqPbHo8T903ZdAH5Yhq5qsMmFL0f3i6JiwH/X3ebmoiZGCIhlAguxGfn20OauA11B47m3P8swUNaVhg5JQOdN3xMCQGE5bmmx88S1jlRHw==
Received: from DS7PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:3b5::9) by
 DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.29; Wed, 21 Aug 2024 12:55:46 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::47) by DS7PR03CA0034.outlook.office365.com
 (2603:10b6:5:3b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:35 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:30 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 11/12] ipv4: udp: Unmask upper DSCP bits during early demux
Date: Wed, 21 Aug 2024 15:52:50 +0300
Message-ID: <20240821125251.1571445-12-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0f758a-303e-441c-4c39-08dcc1e0931c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mad7PWFvBNpueg6vRmZZMMq51i08orbuSDro5HXH2Ng/coE72IOZ26zD1mUT?=
 =?us-ascii?Q?DtDEom/XguoYWgM9Y/rweTBGomuI8ul//mtHWMcIPoOildfgjZ450Ca9RtTD?=
 =?us-ascii?Q?ddT0q56wqgLrt36Ju4FtLzwgakOS9zC6KzV0wMu78lZE3qrFbtrG9AzuAhoJ?=
 =?us-ascii?Q?iZsET1RI8You3NbJQQY7f6kiTowDu7IyBYmQnilCXTqyikpmalhB5lQ+QehV?=
 =?us-ascii?Q?LFoRUtAk73aYYcCn28pOjMz1YyqNn9g8yYVx/jAXUL4BnDPOrdcNC3FqmOfe?=
 =?us-ascii?Q?uJhtOgnR7T7cAkG5MBevP9qvblZW/eijlzqHPrG2Uz6B/HEAscPgBgAfXm7m?=
 =?us-ascii?Q?534o9jH3cgfG1w1ioGX7S97pwKdwxjVtlrHnQU4opmwWvnD4MmnSE31Z+C0J?=
 =?us-ascii?Q?qWpHgoTmxqp9Cn3uV8d4zRg58fewh3QfagaQJ36NYWDvf1YXHf3G6F+a4Oc5?=
 =?us-ascii?Q?q+yCa4l6HbDisRfPaoMCl+FHZ2BX8U524tKCMX3YaaG+YqG9q6fET4HLxGln?=
 =?us-ascii?Q?U1S/9RCc9arpq74RAn940ArdeI8eB8K3cRhV4owc8dDSM1atYT1wbhIYLGOH?=
 =?us-ascii?Q?j17+WUibonjNSs4JAZegdMWyHWKOs2swk93MGuljilw6NeuPr05HAmSP8AR6?=
 =?us-ascii?Q?j3IeVIQks+U5f7uS7ZzgiLGRANf8NtNZGXOH8rv2DnCYSWWZEGMMSiTOxRo8?=
 =?us-ascii?Q?mR/td9EfyejzGk03f6ZzIe9OwviseadS7aX8naHgjs3oTIXszJsYPBOzG0E3?=
 =?us-ascii?Q?gvrKYG8k2xsEQyoDHi1kQLsmWcdtMmMhglaG8eVC3gAco2nx32NZL1FxKFTM?=
 =?us-ascii?Q?nsKqt3RnyxD1yZCGEQA6KgpWehYxdo8HjAJ2UuD8InZHLdUex+JJAieih1hl?=
 =?us-ascii?Q?CD4TUc/XRSQ76pc1vMAr+XRAywrJe1Iu+rIXeG2vZsaxRZSfznBI3hqzNHv3?=
 =?us-ascii?Q?P/enARzf3dH3/ylxzgEKaB7Op+3zoPQuKtiW+XRUGbVTgu+iv6mEAoIHXA7l?=
 =?us-ascii?Q?xSiv+cdrscCNmLe8meJFbNipdXmCj+wbOFyacHdnAsfWkZcZbwohsixIbw+q?=
 =?us-ascii?Q?vxUEzvpJb70PHZE0up1h1H9V+0rksJQrH2LZ5Hz958J2vOnEFXyTeU1mVI/G?=
 =?us-ascii?Q?8Q50AVFf7cvbmm13Rxa4LAFzW7jW0tThlu4nAtB4u4gnZdLOR1QiBk16nN7z?=
 =?us-ascii?Q?QmmKPPxw5/DT7VdwwqdrWvp+J6QEnmE0m5lYsrzIcZUz/h34+WL9Hg6pw5cq?=
 =?us-ascii?Q?i5ISalZoLJdFNNJ6VbB+kttafMkMzQy6icyud54j37N35zgQ0BBN3cxgLcg7?=
 =?us-ascii?Q?13JJvI5Krib0gIQlIXhcVZdaTl3tYFbSpucb3N8qGYNDzplMbGpqdYqPuFJr?=
 =?us-ascii?Q?X0N8c8RSWsV/5Bu50D9OP4CQYA3zmcqeHKTx4bn0S493+QK5XsBtD8Q7nDjK?=
 =?us-ascii?Q?W5y/tUCAJjw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:46.3145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0f758a-303e-441c-4c39-08dcc1e0931c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862

Unmask the upper DSCP bits when performing source validation for
multicast packets during early demux. In the future, this will allow us
to perform the FIB lookup which is performed as part of source
validation according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/udp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ddb86baaea6c..8accbf4cb295 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -115,6 +115,7 @@
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
 #include <net/gro.h>
+#include <net/inet_dscp.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6_stubs.h>
 #endif
@@ -2618,7 +2619,7 @@ int udp_v4_early_demux(struct sk_buff *skb)
 		if (!inet_sk(sk)->inet_daddr && in_dev)
 			return ip_mc_validate_source(skb, iph->daddr,
 						     iph->saddr,
-						     iph->tos & IPTOS_RT_MASK,
+						     iph->tos & INET_DSCP_MASK,
 						     skb->dev, in_dev, &itag);
 	}
 	return 0;
-- 
2.46.0


