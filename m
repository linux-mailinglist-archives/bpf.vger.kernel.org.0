Return-Path: <bpf+bounces-38144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8F96085D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA951C223FF
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CEF1A01B6;
	Tue, 27 Aug 2024 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uVI3nfPO"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB971A00DF;
	Tue, 27 Aug 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757579; cv=fail; b=GryVWGTSbaetPlWpaD6Omh0364Wtrt5t2b3q4WhboDLA3u3WWVrGKXsb2H9TieZGKAeCGxG8flZDCbSpQ8mOF0sNt9AjqX85hKZ3eFtoYRhW+lcmbfhmEhg+eOXqt9rtVEa5z+JE85NX2lKIpmLB9l266FgnjervsiyLXH/Nsf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757579; c=relaxed/simple;
	bh=JeinloMhWkQtbeRhNY9HjXMsQgFY/vP+p0TGY2wfRb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCq9GO2SPSr/eIWiyNe+bzi0uWduKF/D6I0DeGLTo6hTze9GEvGrjrVD2RJlizjKdcLASHQvdxdzGCeeE4a/cTOL+h89e6yMS/JmPHrslU0SvJZUiI8PQF+xHirvGHk3McXHjd7fjeF09h0VGtssN18hOh4/qcu/w4PUiU6o2AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uVI3nfPO; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQLtGLXeVqQhyzNgd9wf3+szT1ZQPSRhjMlbYAD4Lx6/pNnSXWUK08DlrPlmHYaiv8161JLMyFk9Sz8kS+rbHYOaJzVvS6ak/uwDpR+99Ca5UQmtM22nkf2maO0VWkCsDkWA+EKvwFW7qFXochLJCq6vd8v6QOs7vNEz1YjLrFxou9FAtEeyFxtNhx8ARt2lWYTTEsjZrXSGayrFKdX2W8rulUQHxk7lEDUleFl/ZJdkLjUoMtrDP6PAj5OP0NMVJw0byZQU7GKg9bC3SUmlefHxNR9+rgaMSQWI+cOSAXsB7YlISLqI4kes5nlJ/IrGMmUI4Zw/X0yC3noGmGEqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkf/EFPMphsv2xPDyBVxwEAK9tZ116IyCBc+YIcXSwQ=;
 b=x09QgbUWEgi/HQUE0+tT/9qA9l2iQrvdOMEsUB9RKcXMI81jZLeRPlO+ceKvGaoeCOWkfFD1bXl1yWnj+vFmg4sPdEoEDeGTLV0H7uKQ5M4mJA8OANq4hjSADweFW241DQ1g3fqXYU/0wQsXxaI84mTq1k9+cHlYQpqGfUPpWL9VxjQC+QEsVp8jVr1TJ4OI0ufgts+QoaQYRl5zaPHcdqTcZ0XBXSsVromPmqCDQ2kcgAvzpD0DvpDZNVdm9z9OGUC6x02DhsSwp5y+NeML8Td3yewwWLlsWjR08x2qEnrvia8OHsx3GXDpWgsZlzNYJD0HSx5Z/ltyrLBAZGtOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkf/EFPMphsv2xPDyBVxwEAK9tZ116IyCBc+YIcXSwQ=;
 b=uVI3nfPONR+71v1OJktYcqF83rvD61KYwSbeTRV70DsMD4nI5YDgjv4+pmZ1JHSnMcneY+pZMeCLgzHO9xJEootBanNmokTUMks69v4wTU7RTDiknUklAYCfWKs7QlEFzUl6R3KRVg0TBukM0hgPUxiLQLxIxyeZmfL0irL9V0W+5C3dhsPWJJXXOcB2L2aaITyLfse+IPtXF8VyL0RPtTIZOyBBKvO8VL+Y2GOYwTz3sPC+cITcRJ6jtryd0nS6uzDkMA/jFmMqw6TRFpniie6PmNz7sI/M6jHZKFDFdtSsVoa7fyCF6mbMpWZVyfPZuSuLRyXov7j4bpnkX+8Bxw==
Received: from BL0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:207:3c::49)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:19:35 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::cb) by BL0PR02CA0036.outlook.office365.com
 (2603:10b6:207:3c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:19 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:15 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 05/12] ipv4: Unmask upper DSCP bits in get_rttos()
Date: Tue, 27 Aug 2024 14:18:06 +0300
Message-ID: <20240827111813.2115285-6-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ad1c0b-d902-4898-e724-08dcc68a2177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4nT0KYwRAoYijPYmdXKGSDcklHaNnZBZ2hE6onCKp5gLtDjsAmHn4OQt7pq?=
 =?us-ascii?Q?qdaHYDPyb1UQ0DK3fwnUaKe/QvOQKaF+dAjUeMmiPbMZrtBDVHEAD3RiQeCV?=
 =?us-ascii?Q?tMvObu/23iYo/9VOn1OQfhVWCLCSsVozRxIbSbwPy7m59RfMEH/lmvoW+Fak?=
 =?us-ascii?Q?ffHCV7YlfVz5HxCIHSx7ZOQmdvVasHLEYZxucnfTKvaHu/zxa7N3KOLDaGlG?=
 =?us-ascii?Q?5ok/FUWZ9WShO0kRcTlaTjvOknovHf0Gxk4SFCkzvW0KbXBdwiBBbwEXtaLH?=
 =?us-ascii?Q?QGb/VovukrblLd42kqA7h3R8ZyZZj+p+8rWpdc/BlQ3FXOcl+9ALqbMkWER3?=
 =?us-ascii?Q?Lh5O0fLTqwrWRfjrp3NAxe6xoYaW12TmP8YKRz6dcysLMmSU4vTPAyLlcq5+?=
 =?us-ascii?Q?/vxgenNS+Pc8BluwJ6PXBbnrqnljq5nuUJPn5RJ5j7Mi1XRxUDkM6CwMO4/e?=
 =?us-ascii?Q?aJVGLKqrAlpp96iD/gg0CuK8BZmYqN+O0EQh+ysNNOXfcWjgMU6QOdm1u6cl?=
 =?us-ascii?Q?T6fo9QdbIP9WJJw5Mp0uztDNDEV+GWH3qnTYA7tcg5GKcXUQc0qu2JwbtDeN?=
 =?us-ascii?Q?0/W+Px4WkuqZQwVuL/kSZxDn8H2IIilf9hnaX0wJBw3/7VnJJqy9aG4lUCdq?=
 =?us-ascii?Q?6LN8ikn4a17SoTuAnHPgyICLsb6oT35/A56pZaWu26VjLxd5oGbJvi/n6g+A?=
 =?us-ascii?Q?vjzds1vJgbC/G7sbs3/VAuIyLA57sf+mhx9+sj+57xFtwTlQgANbfm4/fpvJ?=
 =?us-ascii?Q?GrqlA7o+aHpxDfKkrVYXf4IVBVX6vGyooLdIju6lUGlV1/AHMSn5fAT2fYkd?=
 =?us-ascii?Q?i6YUs82bQLp98fDrr0HpRqjz6ZArzhDTXeExescAi/mt4mhNje4rxYtDrmCz?=
 =?us-ascii?Q?Wny78DVoS0KleKj7CoLW0wv692aUQGFnAepxttzL6k1VtZEOvoUfWZCvUe9h?=
 =?us-ascii?Q?TaNZ4nhvT1f+rBH2gOzKLgymU9tSB7uFzR7+ijUnsIZ9Z0mQnEA4LmVkUvwy?=
 =?us-ascii?Q?0E9a+yZ1XJiyV4FN/l7xA6qw2cSmCxU7pc5OzsybEI3KQvlae9KOrUkw2dUp?=
 =?us-ascii?Q?v3ksxZsHPhdm4Pfwk6qH4sgr4bqG6weg/iUS7A6qavlKpYnfxi41nY3l/yRQ?=
 =?us-ascii?Q?nD5IfdHQttqhWTf5s2pejjFMGNFfHezwtfQhEkKwhya3E6EvXlSBQnt8TsEG?=
 =?us-ascii?Q?/V45efsOEmClAPf/OSBspLrwnpj245zW3UgGc+hb+j7WENK79Jc8I7pwLYdI?=
 =?us-ascii?Q?kYie3JNadnrZ/AB+x0UbHQMd/A4oUxxpsPsxXpVXSEY9ykBCLoJhGH9x9quX?=
 =?us-ascii?Q?uguMkmO29LeD4UobY956X62uGJu876wL3PD/w+qHk0CUf4e/ZTJKAjRNPcKy?=
 =?us-ascii?Q?2sK50Q+3gRWmFNAmO8q16oFHy2ZYLTxHQA6Xh7BxpkYdKZMhQEZe32yTG1JC?=
 =?us-ascii?Q?ceirkQhqrKr/M/IZKMGjggoMYADfmqWd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:34.7029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ad1c0b-d902-4898-e724-08dcc68a2177
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

The function is used by a few socket types to retrieve the TOS value
with which to perform the FIB lookup for packets sent through the socket
(flowi4_tos). If a DS field was passed using the IP_TOS control message,
then it is used. Otherwise the one specified via the IP_TOS socket
option.

Unmask the upper DSCP bits so that in the future the lookup could be
performed according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index c5606cadb1a5..2b43f04c7d03 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -33,6 +33,7 @@
 #include <net/flow_dissector.h>
 #include <net/netns/hash.h>
 #include <net/lwtunnel.h>
+#include <net/inet_dscp.h>
 
 #define IPV4_MAX_PMTU		65535U		/* RFC 2675, Section 5.1 */
 #define IPV4_MIN_MTU		68			/* RFC 791 */
@@ -258,7 +259,9 @@ static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
 
 static inline __u8 get_rttos(struct ipcm_cookie* ipc, struct inet_sock *inet)
 {
-	return (ipc->tos != -1) ? RT_TOS(ipc->tos) : RT_TOS(READ_ONCE(inet->tos));
+	u8 dsfield = ipc->tos != -1 ? ipc->tos : READ_ONCE(inet->tos);
+
+	return dsfield & INET_DSCP_MASK;
 }
 
 /* datagram.c */
-- 
2.46.0


