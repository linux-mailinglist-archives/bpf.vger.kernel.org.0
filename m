Return-Path: <bpf+bounces-38369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BE963C0B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358A52835E6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F112E1D9;
	Thu, 29 Aug 2024 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dbpil+pp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CDE12F399;
	Thu, 29 Aug 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914622; cv=fail; b=mLKs8mvj2MgJgGb1xg4BRv210kOShWJ9vsTlcZEUgGWSf66MAsuCymqWv33f5kUJoe5jjQpZT3R5PrRSWG/RJ/w3Nkf9/tWR52sLYtpsFodTRrrHK2HYTbwL+JCSW3LX073WzrhLaT5w3dgsewxMAOdDuzGAK6Cfa7jqTIiPyWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914622; c=relaxed/simple;
	bh=9rZ7KD5CNyNlM9PFJUhPFCt98Tnb6n7HD7QrRcXTIMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/wWpmJTFBvzQwz/KPSpEZte4yitfk3mCoNgktj9Qku8hfStSQsuKIadNzHgNzLCxzhF2XQ06LkrHfrBztiomaP3ik9C4v2DtdUN/5Rwu9xhTDPYlvK/mY+eT810jqegmKM03IIJ5dZ6BsvfoyMc4w6MQ2CccALEng2mFYgCmF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dbpil+pp; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3rHr2wRuLye2YXK7uIj+vT30/V7xbBToJI0FJVtT5hHalSM5UhAqbhSH9744l/u6qXppjv5QaVgtWplnlejquYsrDvTer5LK7PZFwt0HPYUyo9K+EsYlgjSVHvNPP7QamjFuVFy+CwjU4UGlfvd3hcgBW5DR6h3dw5x1kuJEcIfjH974B2eiHx0SFCmWRvwMa5wtGeFEu8ZOFWRs8m100PhsLuPjnfooKMvfXJRKX5abVjp2MxfT023QHk3bQnE5sJeqpH9lMe75mtIsTf5FWgbFuC5YVuaeuWFsETQd46NKP9kfYvVoYtz04Xc54IW4f5UqRLaFMgdqHs50Se9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O66q/qUN37ASSq7775bE0lMg0AWD9iz0lzm8yaNXkQ=;
 b=d3pa3ZC5Pycw3psoUMsZRocVXPgt76YOdSykIWWrDq8SryJEVqzfvFtCuL8PbwoEqFuVxiR5/YnkZ7BRCLFLD0aLrAFBQvZv0dzWnUCeLyCkAiRJKK+yVOdqONjVwpG5i0IJ99+hxkhOeIhADm1sOdgefzYhKxh5kri1TJBawSQpfMMqa0xkH6mcY/xdAxbKMcUutzus6FFlG8iai0aPZY4c4tX3Urseh+ipfkcmzZ4h/DMQ6OUqRGD1psWhgbFba31LmLuGeERyvL900Vtg72xVL+Cc4GDbNUMuPj0GoijzCvFM1jqn7jM4k75NyeRSu2z+EzrcqsN8lpv0/UN7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O66q/qUN37ASSq7775bE0lMg0AWD9iz0lzm8yaNXkQ=;
 b=Dbpil+ppnBaSZLOjp9h+jRe2zUqRDUH6UR59FyseUP8yZNd4KSvI/phst0CDIH4bZIYgV49p8LXPXEmuP0Qrh9/iO+wjoJRc2B+EGilS7m0HSXtSwA39OhqzpRds1pZmwKfoa55Ca7g+abjROkLjTiNiTMwEHgqR+ifkUqj967Lri/f+GWQiciBjLb8/9iUvejtkAtyXxKYi9xaI7Q0idThUnpeQ24GCMmICMznH/ZEf3BeUHCBCjHIjSHgyqMh7ZiGD7d/4OO8hOU99P8UA6p0/IQf2BfSbenbVXz/hsBzpn78MdkWjGUOZZ8mqCPQpbr6F4ChLlM+osUbkJj4ZsA==
Received: from BN8PR16CA0029.namprd16.prod.outlook.com (2603:10b6:408:4c::42)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 06:56:57 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:4c:cafe::6f) by BN8PR16CA0029.outlook.office365.com
 (2603:10b6:408:4c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Thu, 29 Aug 2024 06:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:56:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:42 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 02/12] ipv4: Unmask upper DSCP bits in ip_route_output_key_hash()
Date: Thu, 29 Aug 2024 09:54:49 +0300
Message-ID: <20240829065459.2273106-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 850b127e-826c-44d1-d200-08dcc7f7c5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hDwF+uOwwdXUk4BoIGyW+VIK4SW7Hdmc0j/Y/MIUwH/qWA2R0EMJkTN6gBgC?=
 =?us-ascii?Q?Jgk39gvaTFsTvKeFkaHz6YW8F9C9L6AbnFvvxQpb+4dGOvdA1quyvhdMb8d/?=
 =?us-ascii?Q?sE3aK8MgDByEjyaPR/UhEcwbIt+RWJitn0w9drumIsYF34qWK+EKF3VzvjWt?=
 =?us-ascii?Q?oQxUXhDVcpidbUTB/UHK8z46dcthRJbI1J2jA5urHmQvNeEh/CVTUKplQE9Q?=
 =?us-ascii?Q?uMNRIGj/U23RQUwDAdspoeL8IEUOe127BY1TMovh8kgtxH5ECxeHdOmghUzp?=
 =?us-ascii?Q?DrSsJrAz/ZAg9zdqIlvmpdyPeArAV2POxzyOvymdUuuYS9d+CvBJwHMvpmww?=
 =?us-ascii?Q?KRd/LjwY6t8nBJJBPiTbj+40DAf+H+6Q5VDdt0Kuk1A1QAog0/bz79jefBtH?=
 =?us-ascii?Q?yIU6SYOOCilZFffCRMGqAZyIqsPTSOkf7mGR9mitT6UYzoe4cdujhWrZtNct?=
 =?us-ascii?Q?ainFeQ/QWh1rOsLvRejRPs3ixj20ZZpe2cg8TDY9U4G4+QVC/OUjhEbveLxe?=
 =?us-ascii?Q?+xoDn/LPKfF7RT1nhEdDJY2/cAP/BVd6oo38ZllIAjWF9N5q2TqVx+3re602?=
 =?us-ascii?Q?NX/J453NSPCrBOcYpyrRciDSFh7Bv654pWFoNhnuV9BwTXTPKElQ3stZK8Wr?=
 =?us-ascii?Q?T0+ayLymv1Th4D1Mb5ObrfVy6t3/+b/nG55GFYA1NGiazvGo2xg6FsFbcOLB?=
 =?us-ascii?Q?xuh0AIkntYWhI5t4pG8bvMHzfUOxbdg0tNi1kEQK8zRKfsiryjDuG33UTb9D?=
 =?us-ascii?Q?LVezeVRFfHQqzDEoXTbv+yXYHDXKBjj01MjolL64/Zp6XB0of361Et8dRkng?=
 =?us-ascii?Q?ZTnYmI0EE1lP8KC2oJkliRIgdlbWaWtIeGeMUIh23j/O91q55PaJArHvGCbe?=
 =?us-ascii?Q?dQuT9v+9eGNgIKwYWilmmYOU6ilDW4JEQn9oDJwXyet4Wx4NmDv7nYHa3fS0?=
 =?us-ascii?Q?5klhbBj4OxPnXSgAC6aiJ76n38EacsJmj/9yv7kVmzVl3/stP+LWzz7/6Z6s?=
 =?us-ascii?Q?+j8a9hAgw/KrCs/C9PxNhCNiWp8PfMXKm31x1WWMPVZn+cEzcKxSddoxPfZQ?=
 =?us-ascii?Q?oY+SHUbS25s5hipSCvg3qSbK38HWh3t9NbmwqPuBDOJHAzilEYhqZqFpL2Wt?=
 =?us-ascii?Q?Rwo8yHl62A46jQInck/+Zp5g9c1uDYcWaJaiZzyIPuJGZ9+TB5sG8Ex5hKDb?=
 =?us-ascii?Q?w7k+Yd+yk8LzOzGntQJmAqvTgoFMwUbv5ZTa3c9gR3EJz2hdaQAB8C/fW102?=
 =?us-ascii?Q?NSwzamjhY6mS3ZBTKJden7HASYtyYbUni2lKOC/po3ifaiZL9crqxAWsUAZj?=
 =?us-ascii?Q?XcwvN687eYEyU+cDxm1xh5oGBm1Mub6gkAMzqT3NOVlYZ872G2hHcsUx2A1U?=
 =?us-ascii?Q?NY1fewLm7r45ppEcVhdbXBe9Tt1xzqZahePNEfeJ6DBaHa9Wyiv/iMo5i08t?=
 =?us-ascii?Q?Ov910zUFCFNtOPBXnneC0IPV7cJd5hSa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:56:56.6883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850b127e-826c-44d1-d200-08dcc7f7c5c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314

Unmask the upper DSCP bits so that in the future output routes could be
looked up according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e4b45aa18470..5a77dc6d9c72 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2618,7 +2618,7 @@ struct rtable *ip_route_output_key_hash(struct net *net, struct flowi4 *fl4,
 	struct rtable *rth;
 
 	fl4->flowi4_iif = LOOPBACK_IFINDEX;
-	fl4->flowi4_tos &= IPTOS_RT_MASK;
+	fl4->flowi4_tos &= INET_DSCP_MASK;
 
 	rcu_read_lock();
 	rth = ip_route_output_key_hash_rcu(net, fl4, &res, skb);
-- 
2.46.0


