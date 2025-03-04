Return-Path: <bpf+bounces-53207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB46A4E876
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD9F3AE331
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394562BE7D1;
	Tue,  4 Mar 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Ul/C/SSt"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EF29CB4F;
	Tue,  4 Mar 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105847; cv=fail; b=eqiWamYmn3/Ao3FxQwnu2tauMVNozgwMqevqhQGyG22OHOb4qcp3xf4NyH6zU2NlnZYjdJHfKDsMZEsfFWOVRsLkjcmO2ENq1f8zVZYDGyXuPNLPVVAkybwmwKk2+FsQeN7QyOg/b1f9nE0mCMIHWOa2PPtcn8sok7fMsM1XM+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105847; c=relaxed/simple;
	bh=YCA5S/+m0auxbfcaXBPT8sCED3C7jO+RvSZW50TCA0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AKUbqsR3riQQQc3CohgbVfViX7KtlkPEUBuQ+vCjJ00AxSgQD7GBgktYMnUe6O6kRo0UAOJzuuRJbCzf2T7VclpKAVZ5YOl0Ui4qD9QbuHPDUAQl9ZQhKgJoiJw8TYEn+o6yHgSZnND2rG25oUhQg6h0JogAadmBYAn7Sfa4+BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Ul/C/SSt; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjaTx8aZpEq1rmuTFo/YZ8LMmSX1Zp5HsYtnmd3nbzOO3/gR+DnHg84l1XsfgxUTrWQ4c0YFg7JC64rWM9BqUJGmQM+wy7RRopS4M4Gu+DmKP8fWhTCPqhkhTl0HDshbfsS3keHVw99Eh42jOmGROzMQcRSmjxQmNymTGLy/eJj42anDXc7jbKUu9J0DHoWL1Vla4YeUixZK0Smsc/3OnZcqv5d+e/VDN9Aboy61Ur/pL0+d0pdzcbHL6t4k3lPexnm8aLcEpwkb8KX2911n1J3Lc+nvj44jy7x59jKEklDLoWLGMZdxsAM3celO6+YWR7wG4KopZZioc7YhOymCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytA/PdolvmtxyX3VKJFZRkoKIZjgm8rKjzdxQWuHeE0=;
 b=rVL+jPjCgNcYF9vQcQYA05TJbLkCtFT0dV8lUxi5i3Wp5oyo1nm6bgcaG5kvsGt3Na5WYptkgY/MoRPQDYvxfGQXaYkbAXUgtPBTeR+wPzqc8S1YwgI+CrZ/jEd15J6Aa0VkAVYFvQ3d1NQDMHCOIoe9ffwsGs7fJTXI1S2aFxduG/WY4hfiLf5rd+H3bB5IB06Crn+KNdL9DC9XWXyXLmvBxnMd0AkQj2RQKu1eNmhF8Ob1Y1RPT+UKYSTjhMdaWXNNcY5Y+xVC6pxIj87/T9gUB2Bgi9ZJudytjaLJZw03ZAg6fkQCpOCHTGoyh0Rd/nQE8wC5RfMk/O1yBj8dtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytA/PdolvmtxyX3VKJFZRkoKIZjgm8rKjzdxQWuHeE0=;
 b=Ul/C/SStdfaTdxLneEAE7AuNm9djL2VtvmvL/g8Wps85yJ6lu+2B+aIqoIKmjmoOl+hswr5TPj0S1n8QAs3S3HoQb4XaXye+/o+tbDlm5igL9J7kya926G9SxVl1Uf/sFaCE3vyGu524RZVXF5aNJ2yvS5iZmejSaidpfYpuiIintmo4TrWW1kuoQUnGlwTPA5XKLQtpeiKczvlplWvUiAT7IGMfuazfEOGC1/P0RtNKeOTheP1Ic7J54aiNNFesKzOHS1WLynp1pbSqbWmXwXFvOF+9mOIpo1hYWlz+aCXcSUVEv0WuZM4bd8QGsCQYntfnbZnF1Ob3gRmam64LQA==
Received: from DU2PR04CA0235.eurprd04.prod.outlook.com (2603:10a6:10:2b1::30)
 by DBBPR07MB7596.eurprd07.prod.outlook.com (2603:10a6:10:1e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:30:42 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::6b) by DU2PR04CA0235.outlook.office365.com
 (2603:10a6:10:2b1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.27 via Frontend Transport; Tue,
 4 Mar 2025 16:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 16:30:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id E092424465;
	Tue,  4 Mar 2025 18:30:40 +0200 (EET)
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
Date: Tue,  4 Mar 2025 17:30:37 +0100
Message-Id: <20250304163039.78758-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|DBBPR07MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: c72796da-e304-4105-7c0b-08dd5b39e874
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bXFRVXJYb1pKV0R1bjdySmczM3RYYWN6OXhGSU5ac1E2c0FQNmwrNFZsbHZ3?=
 =?utf-8?B?bW0veGZMVnRtR1NZVnlta3FESmUxcE9zNUkrZ2lFM0JRR2JKK3hteHMvYnFX?=
 =?utf-8?B?a1YySmlUM3pjWEF0Nmt3U25YSitlNVJpa1V1RWlrRURjNThQbzF1eUJXRlNI?=
 =?utf-8?B?ZSs2Wm9EZkFQdTBzNUE5UGFOUmF2N1lPTGpibVBuK0JxWCtuOWpodzROaFZu?=
 =?utf-8?B?N3diMG5rTzA3ek11cDdFN0tOVlJ5YWpQOE53eis1Umh5OG5IdXF1WnplOHRV?=
 =?utf-8?B?VmFGdVBGYzQvaVJCQjIvaE1EZ3pwYVFDRnBSZVdxMS96L3dhNUFBalJFTVJK?=
 =?utf-8?B?bm1uZTBLbGNnaXZoN0xYckl4YXozelRBT1lYZ2R0RlFUVVlLOTNyVTV6eGxv?=
 =?utf-8?B?K21VVFVhN29MYUhXU04wamMxY1lzdFJEOUw2ZkRBdytsOUtBUmZ3bVRKK3Vu?=
 =?utf-8?B?ZFZ5QzdHbVdhYThlL3p6Z21zVG15VC9IcitlZThMVTFScTg2S0RpR1pxeGxw?=
 =?utf-8?B?U252TUd2V1RKcGY3dkhvUnZ5elNiTStPWHIxWnhSaEhlS0JQaGNyOFZROGkx?=
 =?utf-8?B?aVdEOTh3di9wcW1MenBLWXY3dkpsNWxzYXlkT1N1VXZNc2JSUytkNlA1ZjNY?=
 =?utf-8?B?TWRkYW50UGFWZitvK09iZURJdnp5c2ZjQnJ0ekRoTmRqdXNyQ1gvUEw3Rkp6?=
 =?utf-8?B?QUt3R1dUSjd5WDRMVnJuOE1mOWxVRkM0TW1TYkVBUGJyZm55UElzb0RIWE0v?=
 =?utf-8?B?WkkxemUzbjJxejRRZXVldEU3ay81WjVsK2ZQZHZPd1NPQi9YQTkyOUNyeUJ6?=
 =?utf-8?B?MU54RFhjV2lDK3lsZ2FmUTdJNnc3MjJDeVMwZzU0a2tjREhYeFVoZFZTMXlN?=
 =?utf-8?B?aVFISUswT0xFdFdXZ1Iza08vSm4ra3dqbUt6MzFZK3VpZ1dLN3MzMGNCTHgv?=
 =?utf-8?B?Vi8xSzkxNUFuTGY3bjlqOWVYRlN5QlgrSVdTcUpHcStZY0pnZVZLcFU5QjNR?=
 =?utf-8?B?dE5wUVBNd0huZlBpdEJLelNuVmJzNngwRTNtbDZISDY1QmhrSUVlNWNWek5W?=
 =?utf-8?B?TXIyNkc4UzdweUF6QkdRclBLZDhRMkg3aTBVVWpMR2wrQkhRN3BZNHpVWWZq?=
 =?utf-8?B?MGpVSXFZL21ZODF0b1FLbFRvN2lXRWgxY3dic3lUNzU0eDViNmlPbkJmcVVL?=
 =?utf-8?B?MlJLbkhWVUpkemdmeStybGt3THJTcVlNMURMdUc0WmxLL1o5WnVnWU0yb0FX?=
 =?utf-8?B?YzRxQUJWUjhwL0gxSVRVOHFidVY0VjIvd295RUU5QmpRVkplRkFVcVhkaW16?=
 =?utf-8?B?cnpsSVA1a3d0M2JOaXpNWkdhTmJzcE9oOWd0TFo1dTJRdHh0clhXZ2swbE5O?=
 =?utf-8?B?L0FjMEQ3UjU2WStFRzJMbTJhWkxraC9hL1Y0cm8zdnpjRSszNEVrOEhaQ2NG?=
 =?utf-8?B?aWNBdW5laXh1eXFwa0xQN204QXppREhJQmxaMWJFWkhGcW5BZytER01UQXBy?=
 =?utf-8?B?KysyM2tTcU9vMTZ4OHZZaUY2VXFrMDVkUmNFc1QwVG9vR2ErT20rdDMzMjVt?=
 =?utf-8?B?c3c2UnpZS042U20xVGNWaXBkY3dQV05XQ3U4TGJ1MmJ2SHg1cExXRElZWkJv?=
 =?utf-8?B?S04wY0QwOEtPTStROUM3Ukp2Y0ZYMkNUNk5IMVh3ckVqNVhUNk5OWmNLcFdw?=
 =?utf-8?B?WktPZ0tmSzlHeERzYVJudE1rS0lUdHdFT3RLM0JXNkxiek1zdHdSZEFqdzFR?=
 =?utf-8?B?QzA0QUF6dHk4WGtDejF3eUFtQlh6RUhyYWxzclpzMW9OY2dvYmw2S2hMZHYy?=
 =?utf-8?B?djEzVU9ZaUsyTy9yL25seEdIU1diQ2ZZVmdNOVdHd212RWE0aG45OVhrbndC?=
 =?utf-8?B?UW54QkxjVkxsMXpVc1NGcWRqWVY5OVBmMDl0c3NCcENjUXEwNEpSWFRlM1RJ?=
 =?utf-8?B?dnpnZkRBQ1RFMjluL29Bc0RnK3pmQlJMRHFIM3M3M09pSG1CYmN0Vm0wWDJT?=
 =?utf-8?B?TnVWK2xodEsrdXZFbDRUUjFYL2ZVTXFQY2lRK29uL2NQdC9ueGZTRVR0T0Rk?=
 =?utf-8?Q?04Bo8C?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:30:42.5971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72796da-e304-4105-7c0b-08dd5b39e874
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7596

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


