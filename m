Return-Path: <bpf+bounces-38145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542DF96085F
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CF2842DC
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B9E19FA77;
	Tue, 27 Aug 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMRs+Pzq"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF9198A34;
	Tue, 27 Aug 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757589; cv=fail; b=MATu5g3drH/+UnVNO6LppMPBLmVWvYabNZkd6GU3hZHocjUKC5AUZQJtNBEkpK5GQ2+ktRe3jzc7ItBwKG4Bo7PNPFIUO8hcsjgWcRe23fUZWNSzes3PzRHZF2QUZx+pCgnr9qT3hgzVObeTfJsHe3l8s653UefyxSVJda75IoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757589; c=relaxed/simple;
	bh=0Qv4ybhnSSpkcm8GFi8YArgQ7bADsaUMTi6ZIJeC/Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQu//5gGsNnBrYPNLvpb8dbjglaXJklDbjYsiRSA60qFpllWNqUzXhtNVe0HS6Gz9U4UvWkuNRl7Dmt5gYjijWiiuh/EXizPlrEFHK6L0ETGOJQARuWnikSv7kmeWd3+xlZ4dHOPM1Z8gX+ynQH2rHUDEHVXP05ijnYntp/0fKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DMRs+Pzq; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIbYdaz6vAqZza0Ufbu1hmPb7TkaZ6KmBP21odzoFuvic52XLw3kn3Y9t7tVy/w4iD9bE1GMFv198nYUV2IIJXGT3KtseKkpeoaQcuOeIGtVX0fQLu1j+m2eQhfROYG5Ak2qvuLkD428gCyndmbmZkhlP6tXR8bBEPl2k/wVOnz4W16s2pn3orHXCx+8gyl9+qUOqjHvNl4LNhxvn13bkbniQ0igOWjwD4xyHwZXsgTGv6yJgYdAe+jRnjvg/98JTTrD0sHATYB7bOMgVFdlDUGdv9goXZbEaWYNoax9XLz+KC7MeFch9ZhB8u1OZbHpCiy6qfDSsKOTH6W1HZjmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRRxiVw4vsC8dDiNvPJTwDAHtY4y8XoqWYHNCYyC2Bg=;
 b=AJ2RpvI3XTzTZMsIST5ZVnvb3q3nHa6FXjJTXOZ0diS5RlrOmaTHGuK9k49z3fubMCspczJ8yMVyMcFItI95zlQmZiqxOjz20e4GkhkYQZXa6s36GMQXjJHOK9jWYmKl++ABBGNK9kVSYWNio0rRJpTLNLXFBC01r5XZDN6G0HL1RjnoQTLUuZRuBcPh6eM+5VbCTQQ0hQgRY1hHQSrIeSHCyCXZFBe9vfO0OSROVxR3y5ityZZgm9bdKxnsN8ZLRD5rMoDE61eyQkRuApxlQt4IEKuZk+m8cZ6emSqUn5PmGDBmEruFeoMyaq4OVNI9AVSwnXUjmtEtmmRGanlr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRRxiVw4vsC8dDiNvPJTwDAHtY4y8XoqWYHNCYyC2Bg=;
 b=DMRs+PzqvUxc0zFVDcocrEh5N0XDZ4WXzKYgWFBqaUooiDZHc8Stn55sB1zWZrhPFNv7HaSUBUVsqDK7NwgUjnRC5rqMMQSb/lTpQyj2lrBjLgkG4sgrAIk1eK/+iG8hwFTEgkbmV6q+WPquqiHJDqhY5ul2Rgv3r9Qst0YXKDxflhpNscjG0Y3gmjCz7Xaad/ar9Lf5d55kcBZ1CWa6H9RCyhQLy1j5APMQ5cb5ab1k9sJgvD/HCnKG2dUxQEJbK0do1UqgpYKeycD+hcYKVcqDaZCWWq3eo5Uq/cvvGWwi8RD1nX6flFXJymcI8QTEezD2hZGcmx0sX9hVlMjEdw==
Received: from MN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:52d::22)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:19:44 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::fc) by MN0PR04CA0008.outlook.office365.com
 (2603:10b6:208:52d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:27 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:23 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 07/12] xfrm: Unmask upper DSCP bits in xfrm_get_tos()
Date: Tue, 27 Aug 2024 14:18:08 +0300
Message-ID: <20240827111813.2115285-8-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: a81658f0-36a1-4701-268a-08dcc68a2718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wse0irJXBD1NMnjy4tP4dnY83U7+s4y4SPxXvjwGbwT+nFs6CEHeHn0yxflG?=
 =?us-ascii?Q?irULCfkDlx5EDuxl3wbGDlrzw1iqx7WeoW82Xmz5/j5HFOvdmj1BZJmfh3Zs?=
 =?us-ascii?Q?3UDQdwatXQUPNrZ6q+Wgad9NJd19NZeMWKalLkVWxwcay+L5gHUUzIl0LQ+R?=
 =?us-ascii?Q?n0YmCRDwl82d33UMPwprl4fVbVx7NenGrrHtlte+xHz+dDJp0gGno+Sp/0nN?=
 =?us-ascii?Q?M4T4CwOmv8jrrqqM2RMWYqXtl0Vh2pxEC05bLTuBBQM6+WlqGpx1LfjbSJfH?=
 =?us-ascii?Q?OM54zgUbwMNMHfrCBtFictD2+04VGesKzJavVaUS6Cw+N9gqT6fkj0t5a0CH?=
 =?us-ascii?Q?9WddlKQ5l64AbCkV5i5rLKDUJ3aAMIkKiJkGNcxkA1YSn7Ohg9y+r3GcYkcc?=
 =?us-ascii?Q?7zOA52SX6zh9Q/lyfiYIlcZ7gFVwiIV3UekHC6CmMtoHvqM2irXobqWGg+nr?=
 =?us-ascii?Q?uryDbUjtF2eMdGwhP/AOHc1DwFq7tMAlLpaOhatM4KwvdmgbGD7/HcyLvQcv?=
 =?us-ascii?Q?TsA0yxvYQH/Bq9DhCF+0uRfXDHPm+EWzjsE6u/C9mrPWyubsTD2pm5hrAwgd?=
 =?us-ascii?Q?rHKpR+627IvknyBw8b3LprEViQH0oHC7FXIiJJ843YBU86aAjWu60Y3DDatC?=
 =?us-ascii?Q?68tuE5YXQjzqQA3oUrLEbrejHOQiPXZF8sqk70/3LbKOrGG0yXvHHeWBvH7i?=
 =?us-ascii?Q?t36phf/abkMsDLeuIstt7hHWMyjhq/FirKK9+ebOA8FTmNijMcWc2hJeAamD?=
 =?us-ascii?Q?G+HQN+yB0aYrTWewOJ/NVGbEwF8lHBaOX2LSGHU+uBwAf+eYkw+wZVjt8hZA?=
 =?us-ascii?Q?SWomUGKE0ODGFvFl2J8kqPWPcU9KVX5o6Uva4nBY9I61wf8iLIaHeBa0/1sh?=
 =?us-ascii?Q?AVOFFmcKeJ3VcyWmArd2XwpV/hY40EDV3OVWHj/ETBkYhsEa1mZdmY5sZBmu?=
 =?us-ascii?Q?jOpA4V8YF7Frxoyl/qBew3HYtu8h+Xg55hW/FJ/71B70LBbHpBxyLzcevERG?=
 =?us-ascii?Q?1RCTEoUQGImO+YCIHY6EvbLU0LmPlyR5KzTCTyRcSSiFtkv/LZlQddQ7xv1u?=
 =?us-ascii?Q?8cN6S+0cEQfor+7/4AH4cbw5rGjsWAe2gn3usRX1P+004UhjKGumTQipl7a+?=
 =?us-ascii?Q?PZfRbk6nL94A9lSYS8DMRYNw0NYyTxh63Pw9pctMiUHz3SU6tY8uBs+bEEQM?=
 =?us-ascii?Q?3IIUXjoeHmbmnVPh0AYJlGCxMkNGdHy05SmeKEBEAYT0734beX07lAJmbxRr?=
 =?us-ascii?Q?pfWyAyMbLHpuLj1P6uJW8BnzX5IqlLwUwKhO5iXeCuZMAcNAjatdsgGQ+Ff+?=
 =?us-ascii?Q?QknvJ8ii2nBhNNTFV8RzIofmcU0f5iloYKGQYHQ1Bam6sjjZWVR+wdVP7MjG?=
 =?us-ascii?Q?GB2jZRjYSxJdqEW6QOlLd8211Bx/xNyihHArYX/C49eJ9sEV91WDModozl3N?=
 =?us-ascii?Q?FiUODswAiPn4OgudLqRdvB2HIJyFlcQR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:44.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81658f0-36a1-4701-268a-08dcc68a2718
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

The function returns a value that is used to initialize 'flowi4_tos'
before being passed to the FIB lookup API in the following call chain:

xfrm_bundle_create()
	tos = xfrm_get_tos(fl, family)
	xfrm_dst_lookup(..., tos, ...)
		__xfrm_dst_lookup(..., tos, ...)
			xfrm4_dst_lookup(..., tos, ...)
				__xfrm4_dst_lookup(..., tos, ...)
					fl4->flowi4_tos = tos
					__ip_route_output_key(net, fl4)

Unmask the upper DSCP bits so that in the future the output route lookup
could be performed according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/xfrm/xfrm_policy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c56c61b0c12e..b22767c0c078 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -45,6 +45,7 @@
 #ifdef CONFIG_XFRM_ESPINTCP
 #include <net/espintcp.h>
 #endif
+#include <net/inet_dscp.h>
 
 #include "xfrm_hash.h"
 
@@ -2561,7 +2562,7 @@ xfrm_tmpl_resolve(struct xfrm_policy **pols, int npols, const struct flowi *fl,
 static int xfrm_get_tos(const struct flowi *fl, int family)
 {
 	if (family == AF_INET)
-		return IPTOS_RT_MASK & fl->u.ip4.flowi4_tos;
+		return fl->u.ip4.flowi4_tos & INET_DSCP_MASK;
 
 	return 0;
 }
-- 
2.46.0


