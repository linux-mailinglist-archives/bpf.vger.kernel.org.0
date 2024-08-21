Return-Path: <bpf+bounces-37709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7719959C85
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F9DB28247
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6170199FC8;
	Wed, 21 Aug 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftt7kB8w"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4618FDC2;
	Wed, 21 Aug 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244934; cv=fail; b=mdYGwEF169ZrxknBk22+QhAf48DzwkQjevBn9/gycMHibbuz+kcGr0MCZEHEoqEtv+eP9BJGj1bjPdWTyZsqXt4LiASUvc+w35kEFO/DRHkTHe5fJShb6ZQEiuxXPrb8hc7jizHmZ665LJpOLzFlcYGRtbbYN3IaNHqSwA2Xgr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244934; c=relaxed/simple;
	bh=JEMMVTYPjFnOW5Az7+cz6O+69+Yiw2A4p5vqSogPncA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhR900Qo1zofhU7z/HzBCcugDjile2zLbR8NdiaeZBrHs5t4lbTIvWQUbAIo6ZJOW3ratSHx6YKgm87VOONAGfF2pobpluUMY6MveLpMeRGYXn4CJSqH8dc/x0bnjAdYOIJHPDpzBnyegPCW8TfsdVNKTQOyZJFZnIiKUCNhQZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ftt7kB8w; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3EYO4LwTsSQl4olXYQhhdLrMbOWdAO3Qb6tqTWti8HBtoLJev915bXoxotzdPRMi9CBBRUJCU1syeiPfZIp/dCOE71weL+cOoLzznDW6c+3CMYwvKvSE91sq5wVV8X70Vhzpz23A8ODkdKM0Kce6l0NHtCiIk8LUI0dVhcw3Fl8GIBP0MNvtDkEXX6xu/0lqfakktNfMnIbWDS/Y5An9hGP00UZZeQ1qSzbtXXBG4qKTGqBTzyNXR1jb2YdyuEzG42tuFSAmpwIu8HTsfc3LXbBEVFG1NAmkIgda07F4GkMLBIfXDGTl7RTNdi+LaT+FAF0+f9rg76skyhA5LwYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8Nz1X78BcCveBblWtaHUQQtoEzRq5zSavMsXEEVARs=;
 b=VVvOzZT13U3/bB6Noh6Nqj4R8k7GZqB4MHiiz45T+hxiFFsVx3IQBSCIx1Jg0n1yTZE+TFGTZIFuiqJsDhvnQcLMGiUSAFkF0+yJQguoNbJ6aa7P2HFYNU75VzyV3T/Q4t4JX+FyuX53xLgKKP/1IsnFzjNPNQMhj0JhjUxbRfwee5H2TQdN56rJTHosjNktuMP+vR/BMBRQvB9ahHksiX5PKeQyyAWYtXNn9VKFaDruzHSNgQRKe4kBwfbYmKIHqLbzydPFa2PUskqU7uG3htTs8qJ5uXiwV6zLC+4tIn7yUXob7XkOAwEy0qMgNEv1HZL08/d4X4WK//9sQsErSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8Nz1X78BcCveBblWtaHUQQtoEzRq5zSavMsXEEVARs=;
 b=ftt7kB8w9Aq3Ucp7lxbLnHLM9/NyfZ5rZWc0fIMqPGAcNGm4QKf0tPNbnKuU+d4hH8T6JTfaTPhrp9MuuBIz8US3N/xrqL+d1bo+OE021pA+wB/L8jmXvMReX2S7v0GFJAD40NLVcntZTWpze6raGNLRNjgFssMc/BUyE8U9aksvPl8WktyicLYdtBA3RdvrR4zjlD8FEEfl7yoemCWrZXqN8RP4hH6YGqwA20lpYjwOIGW/XjwjcGvOVfVSPzK/vtN0POPicqJsIohqzt//XzRLAjNXXlc/2XojnkbkDudJ+P4xAcB49DoPVvkbpjD6L/TTjpkXeWFmnKT851VOYw==
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.29; Wed, 21 Aug 2024 12:55:27 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::93) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 12:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:55:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:14 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:55:09 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 07/12] ipv4: Unmask upper DSCP bits in fib_compute_spec_dst()
Date: Wed, 21 Aug 2024 15:52:46 +0300
Message-ID: <20240821125251.1571445-8-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: befa76cc-c610-4e47-e082-08dcc1e087c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMLyiV7EtutNotwwJi58JzlbTCewgiCGJo+VmubAwAnjoQ/UFJexlPfSvF3v?=
 =?us-ascii?Q?syeyAscDBOu48MHBQEDMzvYBSr84FzMBSXevBaLY7+UyLD+wQovrO8bL5E6m?=
 =?us-ascii?Q?mhHfD/0EIXTE/vNJPXGwxaGIgFEwfJHdt9pt12cEJU0G15yGz7uBWj2gyio+?=
 =?us-ascii?Q?5DYVfTPG5A0zoBHHN40omzE4YNv+XMO+YN/9kPwGZQqmkSH82NdVyOPIYoKA?=
 =?us-ascii?Q?Zg2l60/Lb6jpK/KUTzesC7SDiPrqrka9LKIef3Tob+nE8+z9ZXeFBKKc3e++?=
 =?us-ascii?Q?kjsBmePvkmmxe5GumcCMhPJV9pLlyboyik5EYWAjrGUkzzNSdtr9KOZIw8fJ?=
 =?us-ascii?Q?FRDizfvZER2YHKigL2hW/iHVDc4rC4AjsBskUgATD2l0fnQjSa/XEpr5/mgj?=
 =?us-ascii?Q?MjW7LYaz3nXCPNsVF0LQcFp4Apy+TL1V3auBdKhUVu2bO4dk0Vcyxes3KEK/?=
 =?us-ascii?Q?0Z7ObNCxYtyFMVZ7reYWqipUymTlrJHa7Mj70h2B4wd0J3YgqkowTZfQuovQ?=
 =?us-ascii?Q?Y7cY8oJcVcMnGsGwyRv1hWC46PjiS5j4ZgA9e6nLFKcSdZyIqsQg+RjKOnvd?=
 =?us-ascii?Q?1EAOvdbQZ0UvzCI6suDuAOKkKAA6qJSqCGH5MGtFVqVut6udalY3XasU2Om1?=
 =?us-ascii?Q?mGhFVJNyasNFyNwx6EkBdy9h+e7+THVriWR3JS1pk6S21sTtPfNZ2Tj2jltB?=
 =?us-ascii?Q?otapAquQRmy8sOsHK2hAvJZIRYHkOolzbujhdbs/ZO3aq4syWkjOmzFp1zFt?=
 =?us-ascii?Q?0hiuZz4ewjOYlRfid+HmSD4f4JP3v/OUEF3VkIho25DMKdvhX9AtaZ7e2d6/?=
 =?us-ascii?Q?Pn9fx2lxrOYJdFNCGbaqRGhRsOt7K006gqHNumC/GqovKN/2p3tfDB1BLxlJ?=
 =?us-ascii?Q?HbF4lA5caDrUY7yZ59emRnJye1MAVYV+6B7w8v+kNXO3fs3xHIKslh+Xd28J?=
 =?us-ascii?Q?NZnrQS7eBzEqylGJuzLE6RTypCWlnd/kVXAklfzIenzWUm+WgXjMWxO0KwB1?=
 =?us-ascii?Q?d7BWTjzWY3fM0cudoTomDzvPUVdp/uSwWe5JOwVh69i49koU7plGjtCBRZld?=
 =?us-ascii?Q?5LKLilEClokDFREhDcTuLt4faQC/8C+IKbRfmD5zVLGj9N5dEgmc0kkxTNOx?=
 =?us-ascii?Q?a5vNtSzA4TPtljGfhl/iykk+C4EZFKOXEKCvQMz4DVevMRRnBJzaAtcFLHdW?=
 =?us-ascii?Q?grAxyXQU4rMXBfLe+4wzxIZxwwBJlNlS0LHCe9rPUNozN/a6iTTznhWkBop/?=
 =?us-ascii?Q?djFURDkDpItVZyCz66nwwcLFF5qmPDXuwd+RaJcA0yUPd/dHZ7M/+mKRkMLc?=
 =?us-ascii?Q?QcvN4AyzNOGyq/bjshofUxNC6gJLqJRDgV66DuM8qwPAn6fxWZT0XGL4np66?=
 =?us-ascii?Q?4KXFqypjy/aSOyo9d3q14yYMMAIgl5doQXGGr3E1nm9tzxX2qYpvZ/uoF6jq?=
 =?us-ascii?Q?5ZS4o38KtEXhtdAt+mdJB8YZJ1kEibpp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:55:27.3179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: befa76cc-c610-4e47-e082-08dcc1e087c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862

As explained in commit 35ebf65e851c ("ipv4: Create and use
fib_compute_spec_dst() helper."), the function is used - for example -
to determine the source address for an ICMP reply. If we are responding
to a multicast or broadcast packet, the source address is set to the
source address that we would use if we were to send a packet to the
unicast source of the original packet. This address is determined by
performing a FIB lookup and using the preferred source address of the
resulting route.

Unmask the upper DSCP bits of the DS field of the packet that triggered
the reply so that in the future the FIB lookup could be performed
according to the full DSCP value.

No functional changes intended since the upper DSCP bits are masked when
comparing against the TOS selectors in FIB rules and routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/fib_frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8b740f575da1..793e6781399a 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -293,7 +293,7 @@ __be32 fib_compute_spec_dst(struct sk_buff *skb)
 			.flowi4_iif = LOOPBACK_IFINDEX,
 			.flowi4_l3mdev = l3mdev_master_ifindex_rcu(dev),
 			.daddr = ip_hdr(skb)->saddr,
-			.flowi4_tos = ip_hdr(skb)->tos & IPTOS_RT_MASK,
+			.flowi4_tos = ip_hdr(skb)->tos & INET_DSCP_MASK,
 			.flowi4_scope = scope,
 			.flowi4_mark = vmark ? skb->mark : 0,
 		};
-- 
2.46.0


