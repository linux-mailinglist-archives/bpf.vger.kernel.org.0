Return-Path: <bpf+bounces-37703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12AC959C73
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F591C21F86
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2621192D9A;
	Wed, 21 Aug 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cyX8JagZ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB66155307;
	Wed, 21 Aug 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244895; cv=fail; b=FxWKivK/W2Q3Ulz9qlhvaorx+s2+oQ5Hibx5ScsM0cJZTjrBk18xKlP6ssQKcncZFBf+6QjI+MR+ge5NZrkJPDibvZ08YXHw11uptaUNiIAcTcKmZqpNm3Ci45j4NtZLHQAg03ir9yOaqcNVAdOEJ5WZYeHU73qQ90MZxeXq/F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244895; c=relaxed/simple;
	bh=Vficdu+h/xmCWYEpzJHzTasLcgrdGTy9HdrKYaSKXzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nPKNn08Y3ApyoROInMIGedGTwXX5/6lh2+J26CW49LNZRhBgW+xbKHpAf3m0mL7GLZ7uUtmuKAJiPG0dfb0F+C+rjs/59ctojcmXhjjEhmehK4Wg2g3ZvPtWPcMy2m1KnKd1e5pb54CiDmDSr60HUc8Lv0/Y6ziwFSUG7M1Xn+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cyX8JagZ; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKNdULK5963hEGdANS04akmTprncKxQfVBqysFHaEKt9rzskZ5yZC/9hNJvvWZofyCw5AlDGKkyyMOKJ7IcUtgNl+1R7N+aSCbMBpIWOBW0Ay4m/3k/2KzF+s90voqpZXTGyq2pM1lhBvWmjGu2ai81937S3Nn9Kzykou6mtYK/cdhJeVSwylEL3P96kX7rWpt2CwPfBD6Hj/0vTfZBGWQf2b0U6bRUWnC4GIMwWIxghIoPWwTe1QN7zu8FOmZtrrsTNXtP3clHTmf6yVsVfGyfSnojxeLyQWvi+obm9qKo6X8dHuvkAY+LDjwOdBotjSo7tOyi4ORyMqdINC1Sl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE7/cOwSpEUTeoTUjz48Awg8gombbskwHT+xDbuj5wQ=;
 b=kdBAuECF5aCoP7kgrmuGUHh7kwk3ki4tar9w8L5yp961DHfIHgsEgkpAtQHfTkygbQsRtO8ewImO8PbMNt7/CG4Gm9zwnL1avOZ0KaHN1opiBMPJtggNNX/+LUQiaje4H48++FjkriEcjRyVBMl41ZxQ9A0gxq+BLgxLvHoe8036IBe7BfKLL6Ai5Gmhmddx+tbQZ3oFHvGfO9lR4v0OYvh5eF8L9HZSuH8rpq8C02EsiSG1Ud6Obkh4h/ByGscCVSD7m9iTtAF8N8vHF87V2I+ZoUK7C6k0xgrZLtzffupJC2DiMRX9OLgOmJ//3eSxK1SeNk7zEUocuWim08UOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE7/cOwSpEUTeoTUjz48Awg8gombbskwHT+xDbuj5wQ=;
 b=cyX8JagZE0Di6VNd2tIeNe+r7aTKyRIWl3VLEnc9x42Oi8PJ3iAGzXWcJCJJ2V1rRYN9Kyg/RTOq0vcb5XsJU2BuvmLRfVbpuA3G3LPd5fgtEhL8E15mT4ekG1UWx+Rnu7pEZ3/88zAjHkpMfrWu4B4/L+DkIY3iCgCgfUZL56dnGDc5qo0MZ+hCBPu8LSjD4sU0lQ+wt5Uaq37kh2AU70z0RTIDB07MANjSy3FU917A7CUFhSlQPtt2ef3vCIJeBUqK0rDlfkHklcMDeKvrWH/cyhnsz6/OytCpFdOJd/BTZ6rHv10Sv0WmH2XLuZfvLNaNTt+4nlZoCoknX8CGuA==
Received: from SA9PR13CA0021.namprd13.prod.outlook.com (2603:10b6:806:21::26)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 12:54:50 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::93) by SA9PR13CA0021.outlook.office365.com
 (2603:10b6:806:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Wed, 21 Aug 2024 12:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 12:54:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:37 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 05:54:32 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<fw@strlen.de>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <pablo@netfilter.org>,
	<kadlec@netfilter.org>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 00/12] Unmask upper DSCP bits - part 1
Date: Wed, 21 Aug 2024 15:52:39 +0300
Message-ID: <20240821125251.1571445-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d34cfa7-4d2c-45f5-d904-08dcc1e071c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HI1X2q1mN1z1A0h9i4OwgnmbqogSdvpD8+54WiJlutp6tlRgOeS8MY03Q1zP?=
 =?us-ascii?Q?J3VyAqE2G2roxX4no7o2p2eZMuv/gHyUSSPlhYEcq3wIUUOVNQjdB9xCylsb?=
 =?us-ascii?Q?WyhcQEG3P15JcvXYx5S31AAWUQq5ricGa+WLeLfqUaY25sQCzF0Y+hVpUqnS?=
 =?us-ascii?Q?EusJwXQMXYUJb58D5CeeY1CWkyz47KgBZTFORLANXpwaylieZDsRnwLuIXH6?=
 =?us-ascii?Q?quajIkQ3OigDSmli4YO1n2wyJ9thYn0KRXTfPxCzS33iYFRIhjPbCo0ndKtq?=
 =?us-ascii?Q?92NssIZcJV9pL2fznXQekt9WNVJR92Qv8UCLDhVdu0Nz26hWpvEW8wz0g+Jr?=
 =?us-ascii?Q?mrCWyMMhBK2ILedENjRivPSlOXEvIx1YrbAGym4aljHM1HTKrceKQeXQr7eQ?=
 =?us-ascii?Q?jZBL/PavCTNzqYvmNRRviC8ZjnLvWFzDU0eUY9IV/YsoUycKIXTZqkhIfM2L?=
 =?us-ascii?Q?bEOSEEqutZFTTMVfqwEFnkooGk1aOzNxExAh5Dm2mhDTHkV1kkTiUtN3paHj?=
 =?us-ascii?Q?4CnLtgx0D5TuqHuQ+h3Yfy7iQWPJqczDpz5sZ5JsOBI7b1j23LX6IWd0xbAb?=
 =?us-ascii?Q?KCkfDJqRhshxW1MX2bABxb8ScWSUOKtEBM2FCpD/IZlvjI6JvZnDasCJETYN?=
 =?us-ascii?Q?3+mQ5iynvTZWuAd+FZ+atkLf9UxQRiGHu+Bn4Cf4S6gOCwaIVBIfv9Vffzi5?=
 =?us-ascii?Q?nt6vXUEYDxdYuxjdYembNyq+Hb5XGDP8bgby803wwAdC3+mmofmsEjZw0uIj?=
 =?us-ascii?Q?ft1ebfNsnxgswYjb8n7mA1dsYknieoDiSwoZLzuBNsoK/bCjJrp9BFTAzYLG?=
 =?us-ascii?Q?QEgJfw5kt5sw37txCF8+6PbMPoSHNwwDIKxzyGHbyMEY453VkegnRsR69ehQ?=
 =?us-ascii?Q?bFZeZfJBlvL6HzVAu6ATQow7vy3Tn+p/X2j99LOx/NBuYuJBVpSBgx72/Yln?=
 =?us-ascii?Q?0BJkHTiv7TwXbTDfueJw4sK0jLvMLh/CFjMVb/ZQCYJxRlboHDH6IoPWqozf?=
 =?us-ascii?Q?h1GydamIdzb0ysv7AG4Nj+xXQ/n79YCjfh+tPTFrhfh3hyqn5TkN82xjS4zv?=
 =?us-ascii?Q?JLWna0elHI3VeXod/CUkJW8cIViz5X6eg8pOkvp0nWfRWllWaS7eKzieCjob?=
 =?us-ascii?Q?HZ8k1EAF70Clb9eFQvbYBzC5HknQ6QihA1SG1egK9GIki2KtFWUX3kPRwKlU?=
 =?us-ascii?Q?agbwdz2qsGhkcrF53Ua4IjVMR7oTUhxbxA7rcAf6RZ9z8E/+JoiplNJaj9mQ?=
 =?us-ascii?Q?vdQLxNlDMAR8JG8R9ehWjTBC+UFKTVP9bPnEpqPSw1m5JPd9rrdg2a3AwbB9?=
 =?us-ascii?Q?xjMCmP05V11g2OlXz3XW76MYWnVkmmnGeQNzCDVxQ6O39vOqzwEWNV+B60S7?=
 =?us-ascii?Q?SWyfZYkOW4HGv91e5hBcFHyYmtWEUgP9HKsrzgV2+f1R9CK/TGwyYKVHquHk?=
 =?us-ascii?Q?w+L0GLxtbMGm5ej+Z8CoIvWXoGCBGFFC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:54:50.4250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d34cfa7-4d2c-45f5-d904-08dcc1e071c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978

tl;dr - This patchset starts to unmask the upper DSCP bits in the IPv4
flow key in preparation for allowing IPv4 FIB rules to match on DSCP. No
functional changes are expected.

The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
lookup to match against the TOS selector in FIB rules and routes.

It is currently impossible for user space to configure FIB rules that
match on the DSCP value as the upper DSCP bits are either masked in the
various call sites that initialize the IPv4 flow key or along the path
to the FIB core.

In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
need to make sure the entire DSCP value is present in the IPv4 flow key.
This patchset starts to unmask the upper DSCP bits in the various places
that invoke the core FIB lookup functions directly (patches #1-#7) and
in the input route path (patches #8-#12). Future patchsets will do the
same in the output route path.

No functional changes are expected as commit 1fa3314c14c6 ("ipv4:
Centralize TOS matching") moved the masking of the upper DSCP bits to
the core where 'flowi4_tos' is matched against the TOS selector.

Ido Schimmel (12):
  bpf: Unmask upper DSCP bits in bpf_fib_lookup() helper
  ipv4: Unmask upper DSCP bits in NETLINK_FIB_LOOKUP family
  ipv4: Unmask upper DSCP bits when constructing the Record Route option
  netfilter: rpfilter: Unmask upper DSCP bits
  netfilter: nft_fib: Unmask upper DSCP bits
  ipv4: ipmr: Unmask upper DSCP bits in ipmr_rt_fib_lookup()
  ipv4: Unmask upper DSCP bits in fib_compute_spec_dst()
  ipv4: Unmask upper DSCP bits in input route lookup
  ipv4: Unmask upper DSCP bits in RTM_GETROUTE input route lookup
  ipv4: icmp: Pass full DS field to ip_route_input()
  ipv4: udp: Unmask upper DSCP bits during early demux
  ipv4: Unmask upper DSCP bits when using hints

 net/core/filter.c                 | 3 ++-
 net/ipv4/fib_frontend.c           | 4 ++--
 net/ipv4/icmp.c                   | 2 +-
 net/ipv4/ipmr.c                   | 3 ++-
 net/ipv4/netfilter/ipt_rpfilter.c | 3 ++-
 net/ipv4/netfilter/nft_fib_ipv4.c | 3 ++-
 net/ipv4/route.c                  | 8 ++++----
 net/ipv4/udp.c                    | 3 ++-
 8 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.46.0


