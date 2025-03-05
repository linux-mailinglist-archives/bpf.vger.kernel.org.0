Return-Path: <bpf+bounces-53422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45358A50ECD
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CDB1705B4
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED026983F;
	Wed,  5 Mar 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aPOnApGi"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207ED2676DB;
	Wed,  5 Mar 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214353; cv=fail; b=lyssJGxtNljFo98UStC/35w0OmvnvBdn/8HpaeGs5fbnsN2KtPKEXaAcclwkkD2sOo6xBrEu+pWWysIlUrcENDH9xf7wOuBuz/BCi3F2f568KITv6xAbgnAkgq59FQOg1y1TgvMMKt6/Ewwy5NXAozGDva3PB0db9phPhAx3HnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214353; c=relaxed/simple;
	bh=YCA5S/+m0auxbfcaXBPT8sCED3C7jO+RvSZW50TCA0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGOCAmwxsVarlIWOqa3/GasbZD58alwMyQRJExffnoO6lE5NsfKvMMPgtB9SEmXMnj3XbTmF3+XBwXt7W8Pj93NDkifj+F7BUfm0MG/Yt6oSB32MPk1voNK9XGs2vrkbYCBHzbzWvcRIt8CjBKqWosxDCbMM6eAtmT+f4RcxMQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aPOnApGi; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IewCSr6tNbWrQT615kHJ8mRzttcy1UAuhwFQ9LPGCyH/K+q1qVsKmH/sHOUtXY8Ovnvle/+f7CcuwQrodsLGgJK7xV9fpwOF46+nzmTkGveKXoiBEnYpdgvXCVwWQW+pUq+qksJ3UTzp73yaZW7wZBJ4RNWJA3RFS2H/M8ASFsYg/ngmbT55Q/n46Rn+pb+bQhqUYS4XrCIH/+qPZLGH47/xjGSwQuctsqy4BV4lIYo/4oyb0RvUKys74FNQ1i0mqzRF8jflycarO380tn7qJT3N0BiD42nbMVUi3WhEO6PhIWe/w9N32vXkiWoz3bX7PydWlXrmXxMnk64D/Dww0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytA/PdolvmtxyX3VKJFZRkoKIZjgm8rKjzdxQWuHeE0=;
 b=UTJkpSM/iDHXCzdW9brBR6FMO9DICb9PDh3Ac/1rTu6j+Qjm9v+oeM/eqQBoLYMJpuz4FQkAGwyEW3b4PZWFvkBOHt/c7kNshDfiO4I6Jai5tPBaybLJZ7iOnoHp1Ukpr44yq2W44dHzAxXPTKrS5Cqqvo3oVks/+j/zQYwxJfAFaIt+HsDu+2huPtMew5xX4Yq2POgZT7bHjy8kc7+RJDiHVE/Ce2ZZ5ofE7SvFniWgi+uDpmP2MzwjyCUbaNAAUm2k8F9e0nomeykHd3aplYBWva6gedupy2o6HTABZWRmPG7QXTGcuUapJcP0oXqbj/3ttFNER3uoI/Zm0eu/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytA/PdolvmtxyX3VKJFZRkoKIZjgm8rKjzdxQWuHeE0=;
 b=aPOnApGiM8thfgIh8AFHSRS2PzpIp8nyE8wX+IJP9Vs2UBEZhPbzkWA2HgEu9GIQlOuLVwD+OChnyPvB2jpPusFVpU81pmtDlVdx2XX6crqfvzzi3N56Dt4qKYwkAo/W1eWyXDMLdM2Fysvu5LeFee2mn7+ZnCXB+46sPp6mQIZyioy907Jv7NwlyUhpMi0FH3hIVDzsrIKalMOqVLvQ+baLLaZq4zl0/6ySU4IAg+TbnR2vzDanzzEfzOcMaEUN0YshS/JzdwoawDGEIMwXN5xAv2xGW+cPWgepzLKcIe93MNAZJnqMwpy4vbI4BiHzBM2v9a7cCVEmLs2dqTyEYg==
Received: from AS9PR05CA0318.eurprd05.prod.outlook.com (2603:10a6:20b:491::25)
 by AM8PR07MB7649.eurprd07.prod.outlook.com (2603:10a6:20b:244::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 22:39:08 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:491:cafe::48) by AS9PR05CA0318.outlook.office365.com
 (2603:10a6:20b:491::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 22:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:39:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 0EC75251D4;
	Thu,  6 Mar 2025 00:39:07 +0200 (EET)
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
Subject: [PATCH v7 net-next 10/12] tcp: AccECN support to tcp_add_backlog
Date: Wed,  5 Mar 2025 23:38:50 +0100
Message-Id: <20250305223852.85839-11-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AM8PR07MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 9588c3d2-ee94-4931-f622-08dd5c368b1a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QXZmNG1aQS93NEo4bVZCUWhZQkZBUnFBaXZNZ01rU0lhRUQ1bDdWejBVSVNP?=
 =?utf-8?B?MFhVdExFS0dJVTBLaVpkU0xqUmxwb0ZPUmVFWi9MNmFYYjhMMStGZklhekF4?=
 =?utf-8?B?SHpqZDdWZEtKNlNVRGRLRWxjTXRMTS8wZXNLanJZMnp5SnMwdVpqSVRwWXJS?=
 =?utf-8?B?N25NdEhtNzQ5TTdHTXU0VVBYQWZBU2poSFROQmVaNDZRY0JBK2JOTGs1RUJ5?=
 =?utf-8?B?U0RxTW1IREtYVENla2pqNDJVQk13eXZ4T1YyNEdSRmJLbitDc0lIRy8xNm9O?=
 =?utf-8?B?cmE1UWxLbmJXRFp0QVNqMFdNenJ4ZHdIbWZvaERPRG12b2dQNmwzU0tSQnIv?=
 =?utf-8?B?YTFGbDlSMlJCdCsvRUZNbEluUHg3QWZPbEZUM3VXRkZqYURjSEkvMGJFZTEv?=
 =?utf-8?B?TTZ3MFlDUFNPT1Y4WUxpVHNCQ3pmYlVQZE9xNlB3LzNiaE9KRS9teVZJdFNB?=
 =?utf-8?B?QW54YzNCUklvaGYwYWl1ZjBIN2NmbTBrV3hsckRXUGU5SWo2RWFUSk0rR3Fn?=
 =?utf-8?B?TDBHVk5Vd3VoZjNCek9jWVdiYzdDaklsYVdlbTk4ZnF5VzlXZVY1YnVrVCty?=
 =?utf-8?B?RUVHWDVjU2dSQkpmSGJ6b1Q3OXBOa25HWjJjQ3QrY2dvTFBFRkdIVlJlR1Vj?=
 =?utf-8?B?V1g2VE5icU4rMDkxUk5oSHB3RlpXcXlHelVvOS9EcFlrdVJSWFI3UElLK3or?=
 =?utf-8?B?d0pYcmE1ZkV5dmVWTEJndWNTRmFNYnNHdHpjSU5acElBWGFxQnkrK29IN2VW?=
 =?utf-8?B?OEdjZUVzTHZIYnpodm1XTG91UmQweXJNQjFzNFdzcEtCeE4xUE9Nd0oxci9k?=
 =?utf-8?B?di9aQlYzNGRTS1NKcVF3UEprdms3RzFBcDZuOUFvZkZBcS8ya2tZeHozazQ4?=
 =?utf-8?B?WGh6ajlmTXZwT0tlNno5UThqeTl0YktMWlRNOElvL3hUZStmZnJsRVlnMnc1?=
 =?utf-8?B?aU1aWDNkMkYreU5wWE02citPR1lMTUdPZ0RNb0lFUEV4SDYwcmo0RzloaVY4?=
 =?utf-8?B?ZEdsNmsrOVRjTWFTekRmd0ZkNUtrWUtZQkl2L3E3d3gvSFZyODVSVXQ5QUYr?=
 =?utf-8?B?MUEzbDc0cjluVXhvMkREelo5SHlMN0MwdS9xY1BUSnlqKzQvTitXRW9BbUQr?=
 =?utf-8?B?aytEWFZ2dUVtUGpsaWVBZUZxNWJPT3gyUFkwcm13dTdJMjA4VTdRdXFaRXE2?=
 =?utf-8?B?emJ4MkNpZkpxMzlFSkpjWGN5eTZWQ3N2OUZZWHNRRTlXSzQrUjdqU2pWS2w5?=
 =?utf-8?B?RmhYUmxKR2tRQzhIK2d5d2d6aG9WMVhZR1JVOTBhZmljUE50QTIvTVZRTjVp?=
 =?utf-8?B?UmxGS1BXcW5OcXRValI5U1p4NWlRNCtEVDJwQ2M0SkVNSEc4VjJpUDhzUWxm?=
 =?utf-8?B?QVNQSFBqK3NienNtZ1VTd0lhL0xmMlJtWE1LN25yODVSZDJEZjU3cEFaeWN0?=
 =?utf-8?B?aFJRYTV0RWdacHhTYkNvVSt2U3hCS2pMRzFIU25KaHI1dGoxQTJmQzdpOFFw?=
 =?utf-8?B?UzdrOUZqalY5QktaenQwem1Ubi9aL1hvalUzYjB2YmhuZmd1NHhrQm9EQkdi?=
 =?utf-8?B?c3pKUW5oQ0xJL1FaMG01Vk8zdWZ6aHFmbEUwRUpZZkN6aUFZcS81ZzJjOUM2?=
 =?utf-8?B?WlpwZlBaeVRIeC9HMzNhdExvbFdMSUFZaDFhS0xYVGtVTWpMTm1uVGhzMWtR?=
 =?utf-8?B?MmlyVjVGc2hnNEQxY3U0THpyVEJ3MDVNcDRkSWdkK1pmakJFNGtVNnBLQ0RX?=
 =?utf-8?B?VjhSVUxKMDhjZTJiRkx6MzFGUnhNNGpCTkdJZWhTWlBiSVZoaStEYVQ3ckRr?=
 =?utf-8?B?VVFTbkJDbHFtYW02dWNLS1I4QXNxd0l2TXpLOHhlcmhnaGVsNGVuL1p3MHVr?=
 =?utf-8?B?aVVqVnhoL29OVjU5YjVLVjl6UU1OTWZwTEFHOHJUZ3RWVTY4QVZycC80ZzJs?=
 =?utf-8?B?b0pYNFBjVlhWeW54dVljT25SdnhsbnN4azFLbFNmUEU2UERDOVRqSEJuUlVi?=
 =?utf-8?B?N0ludyttVHI1bkpMSGZNZUN4cVdScW1LZTdnTVN5QlhEOGpraTZ2UXZkdEUx?=
 =?utf-8?Q?Hfvm22?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:08.7486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9588c3d2-ee94-4931-f622-08dd5c368b1a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7649

From: Ilpo Järvinen <ij@kernel.org>

AE flag needs to be preserved for AccECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fab684221bf7..87f270ebc635 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2051,7 +2051,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    !((TCP_SKB_CB(tail)->tcp_flags &
 	      TCP_SKB_CB(skb)->tcp_flags) & TCPHDR_ACK) ||
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
-	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
+	      TCP_SKB_CB(skb)->tcp_flags) &
+	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
-- 
2.34.1


