Return-Path: <bpf+bounces-38142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C926960859
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8783284110
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00BA19FA96;
	Tue, 27 Aug 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Osg//OjX"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2519F48D;
	Tue, 27 Aug 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757575; cv=fail; b=te6Ls/dFEqE8j1bq+JDNiRjejm2cm2M9FP0hPthY+9IBH0Y05LRxcMuXyBngVus/30Cge6iweUkZMZn4waym8InkVbflE4ZvwD3AJKuN1ZFh+RIX52FNgsQczZem4nHlEEDzuhxJV6AZavpl8GBE/i4EYjklcmF8I+WUiNoIxxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757575; c=relaxed/simple;
	bh=rAM0eyus0dvwp6x665Vb6VoqcQIdMW3QiQpG/CBlBtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nh/uIxIGvPdxmeGWOHZlexswWrH9j+h0qnwYKk7OQIAk7kBlqqHbr+hR1LsSk/mIpK44u57W6q4l02VXFNcR9a1iNG3PcndnoeX3qa4sa+drCsuhe2k1MS5N+cf7lj38hZ+IV+tht/PAh1gKJxVCB/v7AD37UMU2fQ1SyVq1xF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Osg//OjX; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZWugld8zh9LRg0LUEhvUqCRUCFka7h+t3HrmQM50MDq+I+zlFxsiJvhKqXAwHwZVWtT8L2SRzKcdFsXfm/BDDYYOtrRGAtSugVtQyxNbauAl4y2LcJewz6iyNu8Ih0CGrcPag92RdCsmPtTl4dlAbehu6Kt1v8MUNbjlWWscwZq+zXO5J3VNhP2LhlwMlwIsOUAxGmiyyiSdz44jgc2VrqRKWpBDtdKQqhcjyS+b8beqx4qRAnvoODcA9c8u2CmGMXbyoWsSo2cFtSTyOHyJLlAQ/Du6h2Y0Cif2KPyByagqeLagKP2+1DDKRD5e8vNk5haLZkSI3Krr6/7wRqqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/WC/bc3OK2FxtvbRRrudoNM002joPtYD7dTEG6vObw=;
 b=MsxXO8gpiH/g9ibI0zj0Yz2My84qwDGydDH4/yXiIj47Bs4WpOiCfuEraQyn2crzAGnAaS+oZzIKUwCdHVzZ8x9LFR8u8oIiM3+B2jWob8YqxHCql8gV/++xa7pZgPP5ULw2L351b8E2fkkI71i+yc5uMStyPOrPd3JAwqCehpVQIzdfdSkc82H+eh581NyKR726RksQmHoyWGdAmO7Q29U9ymdJ4/7JJL8jp1uCMcVEj2MUShB2IzFwlSyVfrmuPK/8CtaEBHk45Ep7wXDfKRGlBdU39B8nAuYyhu/MMnMlCimRs6z7mSlaJQ8cWeCI/ytxk4ev6y1bEdhU6eliQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/WC/bc3OK2FxtvbRRrudoNM002joPtYD7dTEG6vObw=;
 b=Osg//OjXmXgPzxyLp9lB4Lj52H95dStfBtpcSsO6Yq/FFzuiC2h9rK9y4GT8Ho7aTUuar9AgRhg/StNApMvJ+ZPqPII5mXDRzhYue4gPOZAkXzOsm4Vugq+i/TENXtlG/hYJnTnJX9Ad3z6E6FSu7ZKSoCKoN21KjXun95x0HCOdtquafpAauDF1caJfHyYpKGqSvNx8Wt5bU5Un/DExbzmwwgreetfBGg6zQnXOeGDX1TYtL8qTbk70WFDEWhDfHj9YfwuoklFb+ekdr7zboE734wgy+QUkN7+bnffybj0PqVnXrB0fUQlJsWKwxkGI2KTAjxvEpv1xQ7GJmHF5Vw==
Received: from BLAPR03CA0121.namprd03.prod.outlook.com (2603:10b6:208:32e::6)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 11:19:30 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::79) by BLAPR03CA0121.outlook.office365.com
 (2603:10b6:208:32e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:15 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:11 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 04/12] ipv4: Unmask upper DSCP bits in ip_sock_rt_tos()
Date: Tue, 27 Aug 2024 14:18:05 +0300
Message-ID: <20240827111813.2115285-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e88e3e-82cb-47ea-88b7-08dcc68a1ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fadfb5DqWpwUTJBaU0AjLR+bYk+urX9Ejn5BFw038IgFjZgtueeN4UY1HD/4?=
 =?us-ascii?Q?bHpeZsJh+zneefdDPcASIjHjD8oGdOHm4fJAyJa8QZYTp/WR4fNNUNkV+7YC?=
 =?us-ascii?Q?etbFJd0XLtnPMckzbe/rRrYXLXXdGxiHMzkHuCCOCwCMPTNxC9p+zjhF4L8g?=
 =?us-ascii?Q?CxY52BdEcme8UTAKFuBgoWkePNLBuaveAV2omsh46Z+En4ej0g9dPHBfvC8z?=
 =?us-ascii?Q?cRZU5Pet5OkgdGCQflOakuPyDXrV2mHHgEFyMcfl+EGtmClIAzbQ0YOH9+/h?=
 =?us-ascii?Q?WNKbwlbSxSnYYmjM5bhAqkPg9PVW5+t86av7aeHJwmS0MbOyScSWoSm53AmS?=
 =?us-ascii?Q?2tGKgdAorqjnQenDlC8DgvSD/EDWGDMH2Ma0N0d+P2z9stydNZT0ZwNEpLVR?=
 =?us-ascii?Q?gpu/XDRpNdj5kdsLPwEwOSAuyZU8L4UhulDpbzYEPSalUnAWwmcqPJbjJM2P?=
 =?us-ascii?Q?mQgWMC5a19CM038Miyh06u0OaKGvZvulbm+P8a+6izuoF9fIJLMb8m6Y6R7K?=
 =?us-ascii?Q?JCLq2phGog68YCp7YgCp2pKz4hO0yGRKb0ix2CQXdRv0uLwZ1ZTeL9SjgNr7?=
 =?us-ascii?Q?G4ztoNhVTwwqIX9v9MSh0W2aEWN1jA465BY68xF31FmahLY9hdRPskkwgPgg?=
 =?us-ascii?Q?q5nzybDisnNAfvLRMj4p8C0uhtpLsP7SDVfYSn49Hyw3NEzN3vezQ0zJMoBc?=
 =?us-ascii?Q?QnKdQG3Pe/DwlW9TZc+6+GuYnVXpBDfJALOcz/+q2+cm7o5TP/tU4VQ0zR+l?=
 =?us-ascii?Q?zTt4jVqDyFmPDS0y9oqiVvRumqewSf4lFGxBQEQQFNspn5ofGuWaafuNRotp?=
 =?us-ascii?Q?iB0TInzQHhfWlMBanQC9OJ8SM1K2dQEbtJfFeC9jtCy8gIoVp6i71ZpQOXGE?=
 =?us-ascii?Q?V0z201hRVe6nmkCfKF27g60bQx6QrZeLeXdDRrjobMp7hhF8xIv6SjB0r9RS?=
 =?us-ascii?Q?Ho6xVoEsBNxca1K90pHisw0yPfLyLqsazLL/jLNoTMQVT10yn3e9d6yiSb7b?=
 =?us-ascii?Q?9BtTpNV83YzfPCiJ/cQawvCZ4Dz2VjQZwa5uyM2af59xq6Gm0MKk+lU3S8Yz?=
 =?us-ascii?Q?FuI1y4rTll2pcF8DXnkYXKLfIZ/PC/6g5nAbdBmbQ1XnIXE0GeOpIV2cN7Cy?=
 =?us-ascii?Q?X9rS4m16m90lEMi3b14LfY3jXqdfoeEu9scvNGtGpG2vKg4iRoHmUrN6nkPu?=
 =?us-ascii?Q?EnNi3goe7p5F2/2rjyW7xJ3oG0BISZZT98LX0xg8RRMk5Cr97qplpe1/aYdZ?=
 =?us-ascii?Q?lwB7Nv4dTPwAM9pFedQmfX1PRcRpTf2TobdnEDV5KeThP111cXQ7oIrRgKXM?=
 =?us-ascii?Q?uIEY7hgTghW22C8PRvcib7yh4XDBURW2mnVeqkhSjr2DG3Sf94mKhmXUlEAB?=
 =?us-ascii?Q?yEWQmV8JnmGQgWPqgM6YUq7rj/Nl7LAxIACC0xmIN4NncflVu6cIg6qMCgBK?=
 =?us-ascii?Q?t9FIEeNM5QIuQJtwY//TEyBBISYgEO00?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:30.3620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e88e3e-82cb-47ea-88b7-08dcc68a1ee1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

The function is used to read the DS field that was stored in IPv4
sockets via the IP_TOS socket option so that it could be used to
initialize the flowi4_tos field before resolving an output route.

Unmask the upper DSCP bits so that in the future the output route lookup
could be performed according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/route.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/route.h b/include/net/route.h
index 93833cfe9c96..b896f086ec8e 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -27,6 +27,7 @@
 #include <net/ip_fib.h>
 #include <net/arp.h>
 #include <net/ndisc.h>
+#include <net/inet_dscp.h>
 #include <linux/in_route.h>
 #include <linux/rtnetlink.h>
 #include <linux/rcupdate.h>
@@ -45,7 +46,7 @@ static inline __u8 ip_sock_rt_scope(const struct sock *sk)
 
 static inline __u8 ip_sock_rt_tos(const struct sock *sk)
 {
-	return RT_TOS(READ_ONCE(inet_sk(sk)->tos));
+	return READ_ONCE(inet_sk(sk)->tos) & INET_DSCP_MASK;
 }
 
 struct ip_tunnel_info;
-- 
2.46.0


