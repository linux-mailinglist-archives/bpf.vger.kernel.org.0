Return-Path: <bpf+bounces-38150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF77296086A
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D3A1F23777
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E721A0733;
	Tue, 27 Aug 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8QGrAtp"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B619FA9F;
	Tue, 27 Aug 2024 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757604; cv=fail; b=IzOyjKR+kam5ka3T4n43YDJ4PcWgOMoK3Nj+70HdbhooYJNyq0q5VacrFQJHi0Nk45DScKbZHpyrDQn6sKW9YDqSDC5DVn1UU17ma17qvlFcHBGDBAMCzKeNmDtuvXU8Ym66FATSWnWxEIGSUpROizAwZBsJnbGlhluRUrs08qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757604; c=relaxed/simple;
	bh=6j92+AG2SkjSPGg8M+Wnnc0INH7Yp/nhRz+wbVynJhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIWqq8rTEbWGWqNelawPpMSLe2wmhsSaIBH24bgb2yskKpeEWeaOzepJpxtNnH1xHpPTREW7kOc/fj/VY2Pp9/mwYKpzX+jgpt1SpEMp71iNQeoQg3YDLYy7+jnE01mdnwcWEXcvoPdit3XWGo9q6Jo8iI9lmNIcWlaOTnBUdIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8QGrAtp; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keOFG/JwOr5tVJxVrG9OnQPuM5X8UzY4d5DwK78MT5Eb+bxe2w4HAe4NrpA0c7cjJ7o/KOyC92nu58in3G5e2HB9XGG1IRNAm5PHmhgVb8Mdrdj21Lv0uNBlcLh3po5Q16sbYrI47VfV0wRpkDiDcjh8NrK86TyKSGCRFunQMSxNcvAjTl8TauffbjhUQCerALugR9YYKaT8gv19eNGMec6dzh+I8GZyJSJH9FYCAjzFRndOTwCW+poGCSQ3BmsOL4LZQyjudoviAB2Xr7ShP45v8nOxJvaDN2YBhBL0bVLNUPax+knvS+ALJScxizj2f2AGSP2vPlkhRpMqxLKBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Zqrm9McsYc5XcS3ktiPj2ux3HVyL8Nl+oqyniWCFQo=;
 b=d5xoUccsm95ipqtEmLdPmFqibhBarD7YszTYXU6l8hHjz5wrou9SvRARuYXXPMfWn1CEhlgtwONReXw6KTdyUO12IpnQywBJGU5cIiUcmIaCaz81WZ4wQKIKms/2oSaB7t7rMB5FwQZPgwm+LQRYumNZROnSCXl+FSTSlRh8hYZbFfqX7UTlwmP0NIe7DxvnypsNgKU4sMZYG7W71UmhuFztabGVNf+ltvOq03txJdN0xwKX1OA3cf6NutcfQr83664wzLejqYij+HYGoqzbPq5Qn7Lt5Imva7zeO10dTKyfAggKoEXcMg/8pbuf2nSeGfmLETHEXoqXRnB5rfY/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zqrm9McsYc5XcS3ktiPj2ux3HVyL8Nl+oqyniWCFQo=;
 b=H8QGrAtpzbKnl0UvZ3ZuJsTG9i1FefabZSZQBuZZsvbf1X3sRdGwaC9OdGokKjR+ImbdFALXtyIRK7vWZ3LCULdjIwnVPTNNuGBgWpuXTasXXJYNYbKLozchcphdaetGIU/fygFzaQczyIha0DRGxjhT6i8Eeb2Bz9W+L+FN5DTQs0ELmA6w7pC+cU2d+HZoYhUFCUmw9yHeXyciQRwg7Nx/j/1MPRSgEiMMUg+09/WesaQOmMuXwSiICj89NIhSM97XZJabzHgMbZoRiFhPfGZePjsRtkNTTYZdJBzf/HYx26i9CvShZlx/frg7Kx+iiXTV9U9SOUMC54vDtXcNIQ==
Received: from BL0PR0102CA0064.prod.exchangelabs.com (2603:10b6:208:25::41) by
 LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 11:19:58 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::14) by BL0PR0102CA0064.outlook.office365.com
 (2603:10b6:208:25::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 11:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 11:19:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:43 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 04:19:39 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, <dsahern@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<john.fastabend@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <bpf@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 11/12] vrf: Unmask upper DSCP bits in vrf_process_v4_outbound()
Date: Tue, 27 Aug 2024 14:18:12 +0300
Message-ID: <20240827111813.2115285-12-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: e204d7b3-b036-455d-37c1-08dcc68a2f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zEY3fSNCdarWtGynJhC9ulPYEykr/yyTMKKJvnk3t3RILQ7w6wJotyndpVA2?=
 =?us-ascii?Q?I9TcwXSVsvDD9kX+AFp8j2ctwKFHRpouuWglRyhQlfF7zXrMykmpmWnNYcor?=
 =?us-ascii?Q?eQmqv5h7nJflWC/7bp5SqU/+Wrw6P8aSoCc/Y1kDvdM0J3ZpPSL6LY0u8xqS?=
 =?us-ascii?Q?PnvyP98ibkhdRX3rK76lrcIAFQj033WIGsc76MaNBC6LilBaUFhhAeDCCqDz?=
 =?us-ascii?Q?ZXl8vuoNelzF9/sH25DlrSo+iObZdxQaKuN9U+qkkQBHu7zC8JGboHhCYUOd?=
 =?us-ascii?Q?v8zCMo3AGFq9uKmLqMQLa33p7LDFc37cQAHb49RsO0KOb+Ry4d/fqe5jowiX?=
 =?us-ascii?Q?ux0vpiZQHU/Znt0nauDtbTWapqFnAcak8J8qDNTIxR7V6GQqhzNWqta0d04g?=
 =?us-ascii?Q?A6jBXiYCj/e2xE0JxwcdxL2V4FUSRBq8PPR20T0Wuiblj5RbaCBK2LPkP8EV?=
 =?us-ascii?Q?Ja4rUHocNmxKFIN3TbXEVHNj8EFfBY50qji1DpuCxJ9g+oCMrvwp8fF0Wd9e?=
 =?us-ascii?Q?WMo1Z9dc19Oh17Ji+9R3gTbT3tyA9EXDjataAtiP+MIjpzFZ8dwCdjAGWCCG?=
 =?us-ascii?Q?d4dM+Owr/R1Sh2y+SWJrft4TjIDBO/wl7m38FQOC7pNPEQnr2blggtcisqqz?=
 =?us-ascii?Q?F/b96I66YxSUD1/npDn1ecCVPX+CCRBNaT4p/+tk0m42l9OAHJ4TV5Nm1r6I?=
 =?us-ascii?Q?5T6/CAooGWblDMDVKSsw5iorA2+6hsF0oaa3YssJ0accgtObRhrSduJcGCRZ?=
 =?us-ascii?Q?C/U2xwYwGaC7XwqOw+j3cATW+goGrspeAPSGMnl+wcgqmhp7r/Ip8SImDSRt?=
 =?us-ascii?Q?deGhVmg45PCKU8K6VZQ8n9xW5Mh/+1ECSu5ossZP6z/UVPyhMuaKGvDD3nbc?=
 =?us-ascii?Q?wgkYxJlFn571dWkBPkX1pRe7re9Et1Pylfa5LqKGdPCUQgZ1HReg3MSS8LN6?=
 =?us-ascii?Q?b5yitu41UZ/uvyWgzUU0y3L9opvWh3w7TdkDcryOJ2DTR4WAVnRdQKTB6z5b?=
 =?us-ascii?Q?zgp5RsYMiimHVS5qWFrIBx+VLaoTR3ivlDCzqoDb9EbYBwrA5Yjok9xHawKM?=
 =?us-ascii?Q?ufr8ixYBmuw4V+T2yqLyRUuiCx+Q8WmV9STrQc6X/2HTa8/DlyfJSk/zZW6u?=
 =?us-ascii?Q?dBg98qspdAmMnB0yc2uVnqplGEESso6bx7vYC2KwHwYgx0yzI00WtABTol3f?=
 =?us-ascii?Q?PByhLzgBTLYFtg5iIQZWsZF2d+/5NYBixqP2yb8oXC+BLLwWDQOH2opgub+W?=
 =?us-ascii?Q?C/0UBZrrCx6nQgC0O0h0AUy1j9LLYLBHqtab+3J+1XXInUWQMX6DYTAeJNC2?=
 =?us-ascii?Q?nkPS6HGSi4kSuz627tHQIKkskugDqVgmwMhkKG00tPFuQ4eEzNSeab2v41vy?=
 =?us-ascii?Q?+JhxCBdtg5qf6rl5pnq2JWd/f+mPL5sIlx1Uqqs/qV749d+BVzexAbk4nsSV?=
 =?us-ascii?Q?W7QITimblyIeTPyjx1Q/WEVwsnIzDlF6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:19:57.8779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e204d7b3-b036-455d-37c1-08dcc68a2f3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

Unmask the upper DSCP bits when calling ip_route_output_flow() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 040f0bb36c0e..a900908eb24a 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -37,6 +37,7 @@
 #include <net/sch_generic.h>
 #include <net/netns/generic.h>
 #include <net/netfilter/nf_conntrack.h>
+#include <net/inet_dscp.h>
 
 #define DRV_NAME	"vrf"
 #define DRV_VERSION	"1.1"
@@ -520,7 +521,7 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
 	/* needed to match OIF rule */
 	fl4.flowi4_l3mdev = vrf_dev->ifindex;
 	fl4.flowi4_iif = LOOPBACK_IFINDEX;
-	fl4.flowi4_tos = RT_TOS(ip4h->tos);
+	fl4.flowi4_tos = ip4h->tos & INET_DSCP_MASK;
 	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 	fl4.flowi4_proto = ip4h->protocol;
 	fl4.daddr = ip4h->daddr;
-- 
2.46.0


