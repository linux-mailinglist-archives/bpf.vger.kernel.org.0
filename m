Return-Path: <bpf+bounces-38370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4758963C0D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96771C21AA3
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D516C696;
	Thu, 29 Aug 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QiC/KjjH"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADF12F399;
	Thu, 29 Aug 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914628; cv=fail; b=H6PcQX4weUzunVfHr4iSQTNTbF8llMlMUEpgCaH2LiyOxS5E2ZelfuWDs5Tnbt1e6Ue0bf7v3l62x5/+WDxGy9cd6HYDamoFzjZXbGXay6uxmvtbmFdVXs7aVSdYeFhe4SnROkqJ8I5W+b/iJjodhSdXb1oTWnF+6vi3YuU/HHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914628; c=relaxed/simple;
	bh=GEBK9holuzCsTWf0N2O6nr1GAFiofdfb4fV9ID3fVrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYhHZtxFzZ5Mq+PmLsT8fBvFUUZhcU45BDxNH0ymhU9pBYj20dNMW9Mzz1q26SyVdi6QUBoBC9ilQ9713KBa9quBtF4Jz7cR3zZ8OeaGB3V6NRIuGJ+hl3radsnSZMZIw7yvmrZoUz2zOQ28Oa21FTxE90fBpaKue0UwQJu28HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QiC/KjjH; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c64OxT4T2MPO6ChZxWgBZHvEhqqS1aevAKUyW2rtuVeyj85bAx+HoLPq1HJujAFwOFI6x9SAUrcaSdA2fhasn/iGjBerbPshX3wTHwiFeeN/Rnxy8ljdZOG4E/7qO2ihO0UN6/Q4O6URqoOunF+aZ3sSBWktIjdJaC0l+y++k91gv7FH4Pgaw0XVFj+jH48CSyOIt2V3Sj+KfPt/nHYe6CLJBcvtLMdh3PSauEZ9E20b1ff2amDYlMNmZOH6Mz4IxgN5alxo+4mWKkgJv9rsMVYchIt/0eNv8SXdLB8sOWtPSJZs9Ubx+utwWAj4TrxeIbzuv4KjuF4Lowu2c+B5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqRopwUqYrBusmryt7d299ZIRLr6IU10zDFiq3ZMk0w=;
 b=QbDce3nkz9ZTFluAjfgwIH2YwS4X6j6pq2J0X+pm69xkmjyl5cOu3gf1607cKCvKcmY29ti94cSr4F+wbTuBkdR5ScmDq09cHtYUnzBAT5DRS2Q9VaMhFxxZ/XLyxJsvuEeZyUN0MPKsWLME9AvCzUZhJMF3fCTOH+5H2G4CWWzXoDrbiOT+2SyxmVaGBWdIk7Wbmk2hjOVsFnC7fHubFlO+C6JE7MjYBe5keg8c3v+0VKjBhGqQu9HTkCDW3P5iZGDOEUZAkTI2hYny090LZAggHNL+eP2hX2SdjGu9QY64+sWCHu90RZHEK9O/qtxDmSb98WrDtXIHm8t+WfqZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqRopwUqYrBusmryt7d299ZIRLr6IU10zDFiq3ZMk0w=;
 b=QiC/KjjHlPlYvybwfP2N3ZcX1qBN20gWtrOH6V6W3y1dNk7ummhRqO67djr8Ie/VI3RWuCNzCyOrxg88COq+Yj6TtFa2sJeGpxJgri3hrCNsW3TgKqIMmor9CX4sO3XtpsIri1BEZ1EG1Uak76wG3gUOTyoB+IxFKtH1M2HeA7ARgQZwO+WxMVe0/iu2atTud3IPZ0kmtw+vvBo/hRu6Vp09MvKKrFtIy9DHxeue9rlsreiq+4gaeXzwlcd+8aNgaEZAup7+agAoQtnvkkFpJLqU6+uNA2fo24P/GCtdmVOgxJXVkN03z5/O9H35gajS0GIpje8HZaaHmAdzeuA4xw==
Received: from MW4PR04CA0203.namprd04.prod.outlook.com (2603:10b6:303:86::28)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 06:57:04 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::f0) by MW4PR04CA0203.outlook.office365.com
 (2603:10b6:303:86::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 06:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 06:57:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:52 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 23:56:47 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 04/12] ipv4: Unmask upper DSCP bits in ip_sock_rt_tos()
Date: Thu, 29 Aug 2024 09:54:51 +0300
Message-ID: <20240829065459.2273106-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f708602-645a-440d-18c2-08dcc7f7ca5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iopZjPMZW5OjX5KF5OBNT2NIfVf8eAP46ld5pUeZk46VT4O5FjJy8/1sBO3?=
 =?us-ascii?Q?mEbjqqMEbCJ16zZtmO6KW6FNSepB8/nrBR29FbOKpd5PEsaDXyoH4ex0oEd9?=
 =?us-ascii?Q?rRFq/9u1aqOFx9eW1aEWxIzcPswN6GeQpnPYIsLG7Z+iS5gT6EC7ytCK4mDa?=
 =?us-ascii?Q?BWFp/SZCyR1su9aMi7xCoZuD+oMNlpUY2yYV3zRzD9xPb5yW470f6nzan/l6?=
 =?us-ascii?Q?luULNIk+gd6EUXp1iprQEa/+k3ZFnkZln9BxN3yfS2VAYLALmey9P6HrkD34?=
 =?us-ascii?Q?lrPlVgWaSrvSzJsAn4Ic0mSxS0MQH+d/6DPATHoYBGgDHDywZLMv0nL8Ymzj?=
 =?us-ascii?Q?hEdDrmTsQE77tCjQNCGiwIaTHIJBzKcL3fKUJLkBS20PV2FcSQeHkv2Io00G?=
 =?us-ascii?Q?Z79g87Le4NG+0ST3jAKmx0pPUQUF+Ixbk7NDpaCtdw0ZRYTM0TQ4ImCIs0BO?=
 =?us-ascii?Q?XMk+fgn5AK0uQgq0iP4s6YwktBmQ3+3C1kO+rVgA+e60NdvmvDQWch9hqRSH?=
 =?us-ascii?Q?nso5jbcJ0qu3EuD4qbhDkc5bcJu4sWLHmz81LU7T8BQwuN8qWhjtTGFwg9YD?=
 =?us-ascii?Q?7Y/YxiNvQGrE6VOPVKufP7pmE2oYqogirWfo3fmYGi7vM8/eef/CKC2O8VWl?=
 =?us-ascii?Q?rpS/N6gm1yNdpbQuK8oMh8Mn0OLmgwBsF1J0UMFNtt2+lfZthqmQEXdEx7lc?=
 =?us-ascii?Q?5xlbopkLB/0zQqVoX04AaEdT21VIDmT6YyFVhdTHqnB6l2UDMXIFMrppLOZ1?=
 =?us-ascii?Q?4/CbDrZGzBiWqjI0mKbV/GZWweG867t+cMVDg+W1uJYQ6Ffo4P+W4xSjBYo0?=
 =?us-ascii?Q?tX0QZuW2lEPpchQ5ziAVZ2nQK4+1LWlJSgFxlfona9duoOrd3MYfOWBxU8K6?=
 =?us-ascii?Q?qtQBfGDwWkKlIow8HZEJ41nd8KqWtQTXpmX4YFDsaXi4n8FrJPa64bVg4GhH?=
 =?us-ascii?Q?G4p/pP3GndDNldbQDHFXStKWmwy20VCag+50GF6DmdwRXHah/m2yAFU0TrpL?=
 =?us-ascii?Q?4glSf28TVf9Hq4LdRjGmusOJcs68rMF/f+jSQ+f1haK5fl9XqQ2YLsTkw7bR?=
 =?us-ascii?Q?Eu6TAOc47mo7t83dQDQjkm7K+PL0Ja+nD5C4nFml7WMwrpQN1BmfnBWROdI2?=
 =?us-ascii?Q?c+j9VdE5fksruYJdgOdVwRA0yuOdGhMC54O9Fz9sAIH83T6YNxZF6hLz40Lw?=
 =?us-ascii?Q?CC78aXE62+0UFxhcxOzEvryUBuvWZTI1YaPtuTyMQe3GJwwVnfaZhdUpmNGt?=
 =?us-ascii?Q?Qjvp3YIqVJxaYIWqx8KbxGC5Eyn3BLW5mR57LrLcWE2CG6YBJ3nuv1uhkwQK?=
 =?us-ascii?Q?vRUby9sVxpYocr/qjarX2cGpYcACq7kK3Ft18KoTNPDGaiMZ/B8v29JggY8j?=
 =?us-ascii?Q?T7GuW9xTp3dKSg4IY+GjKFCB5Jzsfxz++Bfk+Kh+YF5gkijFy+CP5iM+ScLE?=
 =?us-ascii?Q?edpF5LmJ08Un3kTBT6gxsM8OyBznxLw2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:57:04.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f708602-645a-440d-18c2-08dcc7f7ca5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

The function is used to read the DS field that was stored in IPv4
sockets via the IP_TOS socket option so that it could be used to
initialize the flowi4_tos field before resolving an output route.

Unmask the upper DSCP bits so that in the future the output route lookup
could be performed according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
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


