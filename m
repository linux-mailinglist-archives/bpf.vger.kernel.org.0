Return-Path: <bpf+bounces-37710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0DB959C88
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C542829EA
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E9519ABA1;
	Wed, 21 Aug 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="di0avLCH"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A518FDC2;
	Wed, 21 Aug 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244937; cv=fail; b=GyVa3TWXxmjpURX+84vswLQekzFzLiydoQr6Jm6ALUmUmEGDmOgQ4TVQv6Sn0JGK5NRmxvsmrfahHD/Wq7Yc2J5dS+pt25or6Cm7ocK5hLWRbhIU+9zCNSwZZESiIEybRHk7kw4gG5p+uKWi/t5W6NHjBpwvaDgjfMy0Te7DHiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244937; c=relaxed/simple;
	bh=T6O7aCm90pi1FYbLLV2LBzq7iQVesA+s7k8pabiPcig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFTAX3tFA2WI3VD8PPfLh1AYe+H6t9Xgj+DRa1vM35tMNdz9DID4kZfYsoOCOS3LMUpnwHUyDzNJb/1LxeaD13B9MVGTDOds5XYgrCntt88LzYdhCpemKGPCOJh+6VjSIhqAwYTPRdlsJ1hvi8BgF6T2tuoPBuX3nl03ShktpJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=di0avLCH; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT3PT/lWCA/4z50oE2cWueXUHDpitC04jf40NhLvqTHR7kF8vUjGH7B66VenFvt4Inl6GrNRMMxwUhL1brrSvSpE+fP4KNSIxUQ5QqXczQ/AjVqP9X+LjXicT1ffdKZvZk2ht7qPaZu32MLAYjUg7Eo9dfk3Suorg5Lmq3YODv7BPMAVbTO/FJB0TS5XkP4Z2Vdm0QWe7zzbAB2TswVY57LT/ZYF4ivYL55bTLkLEllNKStZ+hagR8m3vRuxmE8fFHDA1tAeABakQqw/99clyDdisUPZ5l90YWbVpkOuvNUWJqbplYYSlMaReOFyuVXogVsX5YEjU3B1VVzISmN+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUc8X2ob/ON1IukCpo5IGLuSCvTVSrkK8Kcg9APnjOc=;
 b=GMeSkoNM6r/FAHr7PGmHWO0oLwc3TmmwZhpMrkMYuoCkkzK3ZOYBNk8apD+4vsY59IZ84584EtDponlQ3gecJg5QkochB/qVaQDXDR80OUpTGk/GGbaQU2Roxfzn7+phka190vqMbJdKgvKihkZMl/LF6hdKgnAmA2aCtT2RqDazz900KcRh0eFgalsy2clW5ezgcQ1S0ZpFAzT3dJYgOOuzTWJlTy3pligfUcl3RAJ4q3Fqt1/GGTf8A2mrbVQcWQsW0QhO5o7nrUO6HGJ4RVbtnq+NmLf7d1YeI02aJT8Fk7xYIbfbtZp4yRZTBc6IaSJD815Nhrye/BcNZ8bEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUc8X2ob/ON1IukCpo5IGLuSCvTVSrkK8Kcg9APnjOc=;
 b=di0avLCHehcujV1hfqB5bGAavFwUio8TuO/zm26aUMV319G7pOI7HAm+YxOxWHq+YLq8FLw1WqwWhXkjxiuAUWjAgT5o4z8PgH9409YXVQEc515oJ8fRRwdyhg9KF2N7r+arSLr8AGlV+F12OB6HRWx2/6LWEJwJGfP/4VHtOulG2uuOsmb9W/npVgFoQ3HcLmEjp+8pDq3CPwBl0CxUQ0kxGFDWYUg4HReByrVwq72Po6ox2bjUqyZGeiPeICNVZtDmNNgHG6aMr+ZshsvOgsmdg+naF+z/0pZZyDHufYSFiMf9Lboz1PS0pgubG6cEhwxBZ6+YuTuJi248J82m7w==
Received: from DS7PR05CA0080.namprd05.prod.outlook.com (2603:10b6:8:57::18) by
 SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 12:55:33 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::d3) by DS7PR05CA0080.outlook.office365.com
 (2603:10b6:8:57::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:19 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:14 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 08/12] ipv4: Unmask upper DSCP bits in input route lookup
Date: Wed, 21 Aug 2024 15:52:47 +0300
Message-ID: <20240821125251.1571445-9-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc4d80c-54f1-46d7-1117-08dcc1e08b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0UYe0/GIK5JlsrfpUQRmAHDMKRVeCnGXDzqxE58QRlE7qrlQJbQd5Mis7fw3?=
 =?us-ascii?Q?Bn9pc9B3R7jpJCYydEruG9fJA365AR6Nn6YgiNnwdZzzNUa0zHfCiq3S8eAQ?=
 =?us-ascii?Q?NQuL1ftsTg3Kl3woPDg2ofhMlHS6/RwIrEG8Khaem+Mp/hx20puCoKvBjcoZ?=
 =?us-ascii?Q?yYtB6zKxPI3ctkByQWAMhioi6Jd7azo/agEGYa4n35LWwlVBOLcBkEP8Grmo?=
 =?us-ascii?Q?AGxTWGDAickX10Bwz64f/tOetE416htMCh5ZA9nDxUlZ1WMBYN5Ro4G2pzAB?=
 =?us-ascii?Q?tKr8tYIJHv6XIcl25col71pT7RvNamA+BXV7cIYAKBB/diamNIVUeUK3mJJE?=
 =?us-ascii?Q?Kv+cPllPkCcGU9Zf3qoxvE7mXfMKm+wHR2yIfxD8A3UqhU9zLneDX01uCTzB?=
 =?us-ascii?Q?Ox1LziYLQ95v66/HpTnwfjAzAAweZcDXHIVtFBua6qrdmUyoXoXs2ceFC0lp?=
 =?us-ascii?Q?+jbgcDAu7Jm1m7SpplwWtXocDJQRz3coOs/p5rHbIRykSO12F9NiZ03Qi4q/?=
 =?us-ascii?Q?j3GHGjykmgkE9OMcaiwmoirKgv8O+M+hddDrZRfFf9WTP5MHFkN0PBXheSR/?=
 =?us-ascii?Q?1UQD6Gyp3n5VG9HBPaKuwDeh8qup8mQxTMeDJPJUk6JlKb1oCRnuqm1gWi5B?=
 =?us-ascii?Q?eud5rwqkuBsMCbGLsTk6SseJR4ulxCFuSA8vz49fyeCxNjRAKsGxwdgd8Qtk?=
 =?us-ascii?Q?okjB6uTK1FwamcYeXQ0oC68zue8UxaUIMBZGWe6e6Ap7RGGMwORt745Z9pO4?=
 =?us-ascii?Q?iPO9xyQS/SQr398/Ph3sFZDbvHiK7oXGlqx3kCdihJsKyFSoc8cOI2aWZm9w?=
 =?us-ascii?Q?/k/M/GDAQSHFx3XrNDKV6k4OJYgjE+wXjuB7Z56jAI6wc/1Df9sGkuTubYwV?=
 =?us-ascii?Q?pwmiePxuN7QmNAUojdxK7GZRE0trJkUpsCY2C11usXBhV1laouzm5WrB1GC9?=
 =?us-ascii?Q?7sNQGmbOpPZx4h+TQ6P9KqoPpmGdLofKFwZhLwdfmWrwZevf+/v1APGMgsTA?=
 =?us-ascii?Q?ATmHXxApsZG59zNVBNxKba9GpWrrUQ9qBYLxGIRA645D865mQWKZtOi78+Lm?=
 =?us-ascii?Q?Kedwssau/5ppvGiR/lhqZvAnsfJH9a26conaoB409E9yNkOHKtTYQD13ADE9?=
 =?us-ascii?Q?3Cv9PK5TTPKjJi2mpWa8rKA8pnaV52f4VM2Hy3MZYOWAr7vqrflwz2cEmB1y?=
 =?us-ascii?Q?8w6XVeg0nu7NmTY9h40PIgMBUYjojujN1n+cQLyqC5v5FbGDTDc7g9h8cL7a?=
 =?us-ascii?Q?bXzwVM0HkShgsrm2Ux7mhRsuVHd8u48I4rQPuhnWIj8S+okD2Pjlmy907F1l?=
 =?us-ascii?Q?4RgWzunQcP6AJHJM2iyKm/ljhmBDxZpWZDOkAn1QwFx/a/Vl7WEsh6pbAz3U?=
 =?us-ascii?Q?ZDEeHGCVz/3a7xY4UI5oEF35OgnzmcINWR0O7cATpQd2pw1CYMWN7JmFqhwJ?=
 =?us-ascii?Q?GTzLZo/bWq3f3ZATXG5BTVgf/rAwAC0s?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:32.9961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc4d80c-54f1-46d7-1117-08dcc1e08b2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810

Unmask the upper DSCP bits in input route lookup so that in the future
the lookup could be performed according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 9b6528b7b562..73bb61162445 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2470,7 +2470,7 @@ int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	struct fib_result res;
 	int err;
 
-	tos &= IPTOS_RT_MASK;
+	tos &= INET_DSCP_MASK;
 	rcu_read_lock();
 	err = ip_route_input_rcu(skb, daddr, saddr, tos, dev, &res);
 	rcu_read_unlock();
-- 
2.46.0


