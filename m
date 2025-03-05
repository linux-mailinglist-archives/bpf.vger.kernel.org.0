Return-Path: <bpf+bounces-53423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CCBA50ED6
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66051892220
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F126989C;
	Wed,  5 Mar 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FPxkws5H"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C3268C49;
	Wed,  5 Mar 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214353; cv=fail; b=AII0D49OqAIVvVWbk3dN61lFxEh9u3Ac12LYej7wTezs8JRh/MYyG3rgIlrLlY87ywsTnI4DTxZzLHpXAQV8h5UUKGsUaZKebwErjG1+fRsBQ5KShLZ9Gk8l98IHlnmZGq8qryBM2m2n2e86tUQF0WUrLyXvlhcxZZeu7MpW1KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214353; c=relaxed/simple;
	bh=3RdkqonsChfPG7hBRM7hh41Onpxs6JOlUNvjb73ogq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFlJGm/ppKLatUoxlySEIx6LSfEPN3GsWgz2F3k9ahXxgzBl9em1B3QljFBWnxcPnWKkKn5IQmENafULfq5wi/rzwjsEXRx5xIV/lsVD5856fpWIAgDQbQeYI+qoZFkLY7+pu+jizjqKKNd1YILRzXYs6K+Tn1o0/48qvQp4xlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FPxkws5H; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czDIgFkKrxPLZwstSc4comjRks1bx+ezfDt/liAca0bO1K367Emvq2Mov8bl1aB13e+WyWMSVz0Pq6kSe8nr5x1D1PCjt5zEwoSGN8E3xdX69+qeyiEsc/qrMmlL7XQP5fwKIbfmCs866Bp6V62gGGRarJ85ib7+enrq2+qYXzais/1TwcAiNjYUGyCkjxWz5uTF3DAEQpJcPMdNCCx/basfy+qih9LZITP0FbOwIUcoEZn1L7bbdMXxGFOV6LdLFpEpi4ied56q7qm0VuBrpcfkv6McbD/1yp7U1AcOoOMq8kfekXdPL/BfsQV0ABRgl9n/MJPAfPyvkDpQ6L4ajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKrlzno0YCh/lOjvTyktTr1XKxpY+DGvH39/XNQmcYc=;
 b=d0kl87YitQptQ8ojfaVT72jRH++Xv6FHEca4QYjEMAJGUSE9b5NogwmMPIPBZIA7anFNpMOAuvE7QWQwkpvgZ/eZKW2PchcJKDztRLT76zAwxYHee9ltwwjolfG5uG25CVCyxA93J9KWID4l5MwmHDn1Oeg/wEzSbxQ1gnI6ixYEXqLCzj+IJXAPcDPfbEGNkfUOBIMfKotAaahjOrxlAhouOkWdEwd14i2xsy3d0HcNIcD/lj42DiH+WBiBcCVJ/d0mQIqrkzrCAKa2GhxmJ43tiX6le24V5cRNHr1xt7YPPXyuGK5lK56EC4CLJlwN/Lcdi2d8n1yPqX5/cRjODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKrlzno0YCh/lOjvTyktTr1XKxpY+DGvH39/XNQmcYc=;
 b=FPxkws5H6yUnrSXLy/L34ZCeYx5z38pMS6tOjV0vLMeB8P6TjkDN+X1joiJeOXwotcAKMh1Y8ELZDwyf46HAgi5O2YOgA+CbHm2D8fdtbp/+9I+MLYXApGgJJ97UdNjGXz7q2lwH7N/DBRZDaYZoAp+8u4KNnZk32HYmp9JQe6Jyqe5XRprwciXXQ8TPQiHi3B975Ed8Gqj3gn6RD0w07G2KqZz4FBW0t7dFjo/Bg4XMLVRohHmo4WvpCxgK+LTHmCf1RV7sTyWh/Hb0MLCaWCgUtvZm8LeXHyJ0o/ZL3azM/twkdXwZ/ggE9gGog0czsvkOWH+DVR0omhZI5Fftfg==
Received: from DU2PR04CA0274.eurprd04.prod.outlook.com (2603:10a6:10:28c::9)
 by DBBPR07MB7354.eurprd07.prod.outlook.com (2603:10a6:10:1e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:39:07 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::f9) by DU2PR04CA0274.outlook.office365.com
 (2603:10a6:10:28c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 22:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:39:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id BDF4B251D8;
	Thu,  6 Mar 2025 00:39:05 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dsahern@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	dsahern@kernel.org,
	pabeni@redhat.com,
	joel.granados@kernel.org,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	kory.maincent@bootlin.com,
	bpf@vger.kernel.org,
	kuniyu@amazon.com,
	andrew@lunn.ch,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@CableLabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 09/12] gro: prevent ACE field corruption & better AccECN handling
Date: Wed,  5 Mar 2025 23:38:49 +0100
Message-Id: <20250305223852.85839-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|DBBPR07MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: c8409674-5992-40b5-5014-08dd5c368a4e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UzVOZUZsYThvRlpKQU5KNTNoUWwrQlB5ZmJQK0tCNWgyMmIySG1IRlFkYjNW?=
 =?utf-8?B?cE5xb1dnTkNzMG54c04yUEhwY2JmOHlHTWlqckpLN1VpTWdFWWdvYSsrNHlM?=
 =?utf-8?B?UnV5QXVieFpDUG00WU82aGMzcFM3M0ZYdmhYVXloOGtjRFJBV1NYVHFIUlJu?=
 =?utf-8?B?Q1NjQlRYMTlnejZTdjJNdjd0U0ZCWVJOSnN3M0R6dG85amk2TWhZVkE4VUZx?=
 =?utf-8?B?QVJ0Yi9wQ1N5ZEJST3ZiOXNORksvM21CUk1oQUwwZG9OOTRZaG5aQjZ0VWpq?=
 =?utf-8?B?bmdoTkZ3TmlMZzN5Y2taQW9kVitLVEI4a0JIOXZSQzg2cFlWeUhOcjFuK3pL?=
 =?utf-8?B?OWlWZVlIMnV3bTBsazFVUk5ZdmRSMmFPRngzdE9WWU5Ba1Zmcmo3Rk8yTlNP?=
 =?utf-8?B?SW5FUmF5RzNDVUZ1RUwzcWtYZXpIQmtjdFB4SVRyQ3QvRjBMR01mSW5UNmRq?=
 =?utf-8?B?L0VwekF5V0N2dXJ6YTJOQi96NUg5Y3FxL3Jwc0dFMjhnZ29USGh4cG5JdlNX?=
 =?utf-8?B?MG0xSUlaNS9hMG5xTjZkNjQ5a1pqUThoV2pMcFhtUWMxOWVKVjlWYXB3eHZp?=
 =?utf-8?B?MzRSZXZ5R1ZvMVNxZGp6UUNzNE9TZ3B3cFM0STFzS3c2b2ptdm85TUlUeDhS?=
 =?utf-8?B?TmFReFIydmtqcUx1TXo0aWtVSEEwYlMyWGV4aFM4emhxR1UyVE9MTmp1OUNW?=
 =?utf-8?B?TFZscVNPa3FBMjcwdUFCQmpPZm82dCtPM2NmZlRXM3lGSTY0RFMxVkp3T2ht?=
 =?utf-8?B?akphelpWMHlHVkVIWWNObEhhQjNXbVdFbmVETHdEYWNOMk5OeE92Vk50TWQz?=
 =?utf-8?B?K1paNEFPazZ4TGQxeVgzNFA0MjJwS3NFQWF1a0x1Uk96cDdibDhyaWxtSHJi?=
 =?utf-8?B?RGU4K3BsZlFZZ2EzWTlwMEI4Yndyd0E0aWhvMERtTU90YUJpdWZpemc3QkZ2?=
 =?utf-8?B?OFVJV1htSnQ2eXk1bHJYeWJwYU9zNDJ4N0pwNEYwUnlLSXpnOVJkR09uM2Z1?=
 =?utf-8?B?SlN0bUdCc3R2QmNCNHVXbFhwR3NjQUlKMmZGMTZLM3liTGNYdkEwQmR1Vmlr?=
 =?utf-8?B?ODFBcW1UaUxRYlVzcGhBT2RWSDRUbW9RVDIyV2kzRGI3SDdjL085Z2QrZ1Ix?=
 =?utf-8?B?NkJPSHB5MklKalF4TlhSV3Vycm80ZC9IVitXWFg4S0JLVUV3dkhhdkI4dms5?=
 =?utf-8?B?WnhlakFxaXhPWGRab0Y1T0VhRnk1SzZ5WXlmL2ljTGcyeGtUei95d2I5bk9v?=
 =?utf-8?B?bWpGSW9xc0pxWUJQK3YzTldYMW1RMFFoZHdCSzVQUzlDaUFNVnVNQ1d5aUhs?=
 =?utf-8?B?RUtvdDZVdnBCY3Z2ODlqUnB6NnpTc3MvVTRpUHFNQThHRnJGbkUvcDFtQ1M2?=
 =?utf-8?B?MUZZM3FjL25KTStMMWE4dWFzUjEzRVhhbk9WOGdPN1NXclRSS2RtbnJwVzFP?=
 =?utf-8?B?NTg3cUJ3azlmQ21MVmMyMkxTckRhSmt3TWp3V2Vldi9JTUNNR0d6UEFDcWlj?=
 =?utf-8?B?YkFPMHhwSXRjZUo5enBNRUVSdy9UR2dmOElzUmFuclp2S1hWL3M0NU9JOU5S?=
 =?utf-8?B?dWlBSGZDSjNjZHZwSjlPSC9PeU1uZU5tSmdRMGhXaWZCb08xdER6amRwL0ZS?=
 =?utf-8?B?K0hwZXorLy9zS04wcnBGNEdhbnB0UHdPMWxVMWNEZVJDWkVOd1puSjV1alhl?=
 =?utf-8?B?L0htdWVzU2VmVmRZRmNwQzJ3WTdFMXdldjQxR05mc1VmSlhzUjZIVXNpNVky?=
 =?utf-8?B?NXdqaWwxVk1JNFJ2djMzLzBGYjlITUxCSkxsL2s4RWpvL2RZbG9DWGhPNXhK?=
 =?utf-8?B?YnBIamZRWS9tMVJSWkh2ZklkYkF4b0kwRzdNTXRvK3M3WW9JT2lUZ1VXMDJv?=
 =?utf-8?B?ODlUWUhYM1QyS2YzZkRqZ1BqOUpudis3aDVwR1pvT2RrQkNEMFhRQ1B5WHc3?=
 =?utf-8?B?dS9UeENDM1luTk9KMTdJOUtlUFNhRlljYzA2STcxT1ZKa1NaQXpHNFB1STFR?=
 =?utf-8?B?Zm9NaHlzVzY4eTBEcEtVUkJjVWhZZ3JiSkFCc08vRmY1dzF1SHlZKzNoSlAw?=
 =?utf-8?Q?DCJPvW?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:07.3605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8409674-5992-40b5-5014-08dd5c368a4e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7354

From: Ilpo Järvinen <ij@kernel.org>

There are important differences in how the CWR field behaves
in RFC3168 and AccECN. With AccECN, CWR flag is part of the
ACE counter and its changes are important so adjust the flags
changed mask accordingly.

Also, if CWR is there, set the Accurate ECN GSO flag to avoid
corrupting CWR flag somewhere.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index a4cea85288ff..ef12aee5deb4 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -329,7 +329,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	th2 = tcp_hdr(p);
 	flush = (__force int)(flags & TCP_FLAG_CWR);
 	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
-		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
+		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
 		flush |= *(u32 *)((u8 *)th + i) ^
@@ -405,7 +405,7 @@ void tcp_gro_complete(struct sk_buff *skb)
 	shinfo->gso_segs = NAPI_GRO_CB(skb)->count;
 
 	if (th->cwr)
-		shinfo->gso_type |= SKB_GSO_TCP_ECN;
+		shinfo->gso_type |= SKB_GSO_TCP_ACCECN;
 }
 EXPORT_SYMBOL(tcp_gro_complete);
 
-- 
2.34.1


