Return-Path: <bpf+bounces-38143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A543296085B
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABDA1C2242D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30291A00EE;
	Tue, 27 Aug 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="edQ2OFBb"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C91A00CE;
	Tue, 27 Aug 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757578; cv=fail; b=f+BW88dSCJcW2WssDJnBzIKExgx5hTNKsjZQW63pbYttbfkoi4wG/+L8iWCaNDPPyKf5yz/TzJaCkGeYvOuHRu+/M43wMVFg6/YJsRFFDvqTuFL991FSteQVpLrWdycMDGkcQb0ngDQX7NVu6n3Zj9YmVgd9tOa1Mj9pQUhANxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757578; c=relaxed/simple;
	bh=ZSO9BS7FQnyfh+P7GBIhB20jEHsBwFAt/IzNjE08fB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2XeN+jBHYJFgxFoeYr5eCQpMkow04lqQMkxwx7fHVCr0LQcS6pUqgQpHiTzfYI4FXGwx1EaKC6Ot9dniGy5U5roz7ht065NBWFIqBZ69q2a3sdHVF9sM97kzQ7TgQL93sfnfF0HNqxs4rLfvjKiAOx5ea+y0JKiOaaiW3vMXrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=edQ2OFBb; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbZJbMai9ebHlpibdi1n3b47mpvPCBWI/GMbh+g+ZXQpj1IFQiIuXE1I5KTgiiio440GRccyxMpyvVpMmrqg1PAIOxjh9WuQe8zETZ5QL4z4k0kniDPqwuBwfAhax71l5aYKEfRRVLWXpuRnX5eOfJbEH1CaUs8Ll6ImoPoLaKy4YJUZgPDXSs13IT9aIEAIP7VSr5A/Mdfj9yul645SJ0xQb2zgzfn36e8F6BiwCxyfROmsHss4sdeFVv4rUjoHuofu/LFd/P923MtIHG+XT2DPDUonUG37gtOvG2TU1iQE/ySvtL0DcF6I88z3KuG8Ngc+vSL/PLJTmh9693DzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTEdbrFhmQFupAiwpXEZ4pVUw4FSxjqhWoIykOtD+2Y=;
 b=tQ+PFOCrnJo72KzsApOApWSV+2KZL5mBmrbk8xlncHpjFct4U5Ij/t4A8cC/sqcGU2rymVUENaoP4KYKOV8AqfvDvkJaT9C0Siy8BOKAsFvs3xGbCLeDNZMX+M54prBRv2r8DreiNXDesK4weM824T1WvKsbhxF2MEoIqb59See02stMPErfKYEu/mWZNDhTLNOgG+d/459HWXY1oxELfqeW4++CNfsVbdxoXDcgKSC6vVrrYJe9ZKyyxsLE0kp5LZGQ8GF6uo4UJzDgE9b0N0bf3PKy1uFXNN4tGs099g91X+/6Vq3WoEufMHzoMZVWp1vPe5IBAjK6Zjxtw0Dzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTEdbrFhmQFupAiwpXEZ4pVUw4FSxjqhWoIykOtD+2Y=;
 b=edQ2OFBbL4QFDzAPjnjwbM0mI6r2Zx/7lBcAfZig4ikVqTQk3TBbAxsesYneE+wnvOYDDpuG2wk/Mg597j2sZasVm/5vHtidjEMAovfxqbVpSMQhPCnf299AKyRlA9b5wtY5B/P3CX+xYHFtqYgjWnLqeci5qkXeB7cVBUi0+ZHLXBGBNP+76ErXYzLg0mDTbRqyhql8v7uUt6IwYSRkBSURJ31OK2K/wfCeUwKCEDFgG+690k7LY/mm8A+BGReB+cGMQvTK9q2y24Syt7Ouf1O31c1T0sjTk6ZqVIyPSHuTe2NhWjmmRWdm6iHMZPKDZ5J22nFoI68i6zHlV8bw2g==
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 11:19:31 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::d4) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:10 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:06 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 03/12] ipv4: icmp: Unmask upper DSCP bits in icmp_route_lookup()
Date: Tue, 27 Aug 2024 14:18:04 +0300
Message-ID: <20240827111813.2115285-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827111813.2115285-1-idosch@nvidia.com>
References: <20240827111813.2115285-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1fe48a-f54a-43a4-f5be-08dcc68a1f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?umBkg8nC9ayoc1Oazs7N8sGwMta/LDikziavlEQ8wBy6i552DbTjDsUYB40e?=
 =?us-ascii?Q?DGPFI6/ZYHE5l+wVqr2Y19VWU4a4TK/d3TzLZ8sCqSWdo8a/yNwr/8WxTjC1?=
 =?us-ascii?Q?B3Z8hpZvexW2WiaN5k26ExFh7mEnCxH+SjJVYDWd+zCjqrtdhLN4dlIWuSJn?=
 =?us-ascii?Q?9uO/SmtV34IBOZGwThYc7V5FAxK7G0leTm9izHAxbr7+2/garQUG59RFmN0C?=
 =?us-ascii?Q?lS1/WZ4Al1vxnscRjL05z83VBDBhBif8U66yeV4//wAIQImcFXBYLFy+AjD0?=
 =?us-ascii?Q?YcxBaf3rOitl0PCrggcb2rGCa0BmbtV5xtrBtAWKU9WpO3rNI0rFbRSB/j/t?=
 =?us-ascii?Q?TPDWUPPjgj27IYjmuc2+YRb0GsWz4ua8aGLTzHuev+gBq0R0ENhxKWKyWTIK?=
 =?us-ascii?Q?zf6rm9XnUwOCmp9oUWzqCl8eeCc2YZ1kS7odSpy+mkq/5uCb+3JT//kmyMBb?=
 =?us-ascii?Q?LjJ0G1GMu724D5AMedOY8TJgID9Djj/DExSHbPs0TgZ4+rrho4n8se1k8p7i?=
 =?us-ascii?Q?o+ys4lvXwSmuP0YwSzxuSGKyMFzG2Nb4VS054rk2Sxl5030PS6ZTsFQWGPxh?=
 =?us-ascii?Q?XgglEJ+SlPZ9tfXt7yhhKjlN6pXhUGZF9fSFV+ryikhNHZQONM7ZfWlDJYz6?=
 =?us-ascii?Q?S4DTrExyrikH2fc5RXY85EyFRwJ5hjUUMPp26W15jFxGWwx6AfAv5QqPspYx?=
 =?us-ascii?Q?wNu7WCmya90zQo+kTRoVGW57LED1YfTPHyYv1YsvtWBgkZmvAWKhIF4sAqkG?=
 =?us-ascii?Q?0DJBPvQAzQ6QKNY+7v+72zfhgzDELByvzgdOjtOqLRAjHBj7bpGiByDQYE3C?=
 =?us-ascii?Q?l3GuivHyA+xqiB9jFrL9bgwdE+40OKGkaXS3KnHaBpFrHkwrFpqKT+5zzX/S?=
 =?us-ascii?Q?V3bH2ylj6At+luV/mwHJEUDDMS3Mo+BP9thDgtl03pC618BlVB27WgHcE1oL?=
 =?us-ascii?Q?bcDiSP8oClkn3LTR/yvKP7bR4ErLKgmhIP7ZWdFQqiqAJfLuMtvaSXf+Vlxs?=
 =?us-ascii?Q?uB3Fv01awMgxZmLA55+DytFsY4V2yy4WQJ1mruTRwCR28PcVsDImHHawEx6a?=
 =?us-ascii?Q?x9NaIPOMY8dSO8XtdckEv7etQw/ECmqYALw7X1XTekvYbSuejB0Af9tHl+op?=
 =?us-ascii?Q?AO9ujkXgKncbtn8vkpxW/7NQdP4bswMK5TvJjVf8vYVcMEGR+SUHmtyZXjOH?=
 =?us-ascii?Q?tIYoK7mSHO5RyRiL88Hf1dUkW7pKKHYA1VzXd+rZfzDtRuFggxXhupmN1Exf?=
 =?us-ascii?Q?RKaVFCcSsg1OAZjSY7DpAJYD9cAJUrauoWZunPs3g59nauxcDkswDnNffjIN?=
 =?us-ascii?Q?CU5gG5HVVo0lePfNMQuLw4DOrU2NQD9np9Y5e2zFdL4Iad/ols6Td80WNQlI?=
 =?us-ascii?Q?QKe/+9w2wZBcL5QxQgjhE26xYHPSL8xrK/rbMJ33splyttp0mSkygN4QGuTb?=
 =?us-ascii?Q?4LTzrcCAsMGCQ4b2WiRZAUXf8FSLhj2Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:31.0242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1fe48a-f54a-43a4-f5be-08dcc68a1f48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747

The function is called to resolve a route for an ICMP message that is
sent in response to a situation. Based on the type of the generated ICMP
message, the function is either passed the DS field of the packet that
generated the ICMP message or a DS field that is derived from it.

Unmask the upper DSCP bits before resolving and output route via
ip_route_output_key_hash() so that in the future the lookup could be
performed according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/icmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index b8f56d03fcbb..441057f2c903 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -93,6 +93,7 @@
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
 #include <net/addrconf.h>
+#include <net/inet_dscp.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/icmp.h>
 
@@ -496,7 +497,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	fl4->saddr = saddr;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_uid = sock_net_uid(net, NULL);
-	fl4->flowi4_tos = RT_TOS(tos);
+	fl4->flowi4_tos = tos & INET_DSCP_MASK;
 	fl4->flowi4_proto = IPPROTO_ICMP;
 	fl4->fl4_icmp_type = type;
 	fl4->fl4_icmp_code = code;
-- 
2.46.0


