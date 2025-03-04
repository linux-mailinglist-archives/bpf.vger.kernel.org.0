Return-Path: <bpf+bounces-53193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96EA4E378
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5769B1886D4B
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909AB290BDA;
	Tue,  4 Mar 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pSILdxQK"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F99290BAB;
	Tue,  4 Mar 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101390; cv=fail; b=jsznK4BG8GXuhHx5vk1dCLy/ya18P7n4z6BoXMikKHwtvuOVZJg1IVx2t/Ex5PCnTDZ77xspQ7HOnzrn4LRZ+N7ToU5nYQSxxuJdzhbRQ793dX1kEHYfp9drF8JnNJIXS1Fv5XVIJ3Ttx8MZqIVZ9D4/N1eJURMlwLDQpOn264w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101390; c=relaxed/simple;
	bh=3RdkqonsChfPG7hBRM7hh41Onpxs6JOlUNvjb73ogq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FShlyv3Gj7NnEblc1gXnmYuOsYdlcA7NJM1pcgWfgEyYh6x1z4QSjdB2XXmWMGahBOS6P0zm8yCyqZIk+xOUvs5Gb436y53j+EBioA3uQ5gGHP6rbbj9B7grZdz8ccgbXECsACZXA18zCop5aJJSuQmqmUg9LCLFXfCMBu+wRn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pSILdxQK; arc=fail smtp.client-ip=40.107.241.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCBkfnoFdUno92ZoO/2pr9WSviUc56XigZ1jR5ka2lA5WLaA+L1d5Ls57gkDsDJFI4sIXmZqvQyowoDUXfbQfo5p3R2/r/lewKQdZ4dbwyDERF55pQMhcGeU/mA09sqk5KUUz3raumNFjlLzWp7REaeoytjM+7j0L1/iC9H33QYR2xdOubMnTnaKqgk5ZTSHo+Cq8wcrf8pbb57cpb6lNvrP9R2Dz/d93ZAhSXT9WmpzpOpYSH9geMqVbVgo7n234ST1nuijYYDcf8sTBeyR46cqD867enYXT2pMbepewYYtgIDEK/l5x5oqkDfkrGd72TqxLigGybpgByXo2aUtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKrlzno0YCh/lOjvTyktTr1XKxpY+DGvH39/XNQmcYc=;
 b=ROz9JaYFkGRTzaE1TzeKU8oIWdNNJHdQUS+cw9eEHG/FXnMD+I9Rlshd7LCqtH0Rzuk+afX4GgQWNtnC5+hTeHeDOT7SoCZoF7PY1zDt0fZUWvMisCJjC5jWcMRcF5Lsib5VCqa2ouFH4hrPl0qsiBVHD7rr7/wShoBsVGVl8gXSaZK2PniW+NV91TTPw8JT79IKExG3NUNCKfRd/mMxD58EOIR1KnmlsmHNGXQRxWpbtNF5YVMTwVoPqJkZuieltn3zzc4RcYbQlJmP45hWSPRpTFi5cgTiJYOqW3RNJz6JAom42zp/nnpr3u0EmiEwxTOh2OQFqULVEUsUsA4ONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKrlzno0YCh/lOjvTyktTr1XKxpY+DGvH39/XNQmcYc=;
 b=pSILdxQK8S7/xZrWOu0BU+wQ/3+KoTSOnnOFhSJUQgNi20gpXUoP8+55BNBTPvZ65ryBZ9MzEJ+tTbgOQxnuNR/EsmqYENNEwn80KYi52vWdfqnj6j8kJ9VqzYdaYNaMzSDcxK9t3TZJuPuo1fR5gGpoKnW/5mgJ+Is8FEvKUV25kRimQdIDk5413Uk8o2R8yIf2dpLIK2j/BHrfxITo1FY/vP75797y1amZ5r4VydLjkMszt6kcBwzdt+MqjlHVVmkLqGFS5gIwEr0DbwtY6voc0YT4Z4IqrQ7vCeCDg/DzTM50OI9qSxwhQNS4hx3CFLHy6VZeCgj8XageMcWz5A==
Received: from AS4P195CA0038.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::21)
 by VI1PR07MB6510.eurprd07.prod.outlook.com (2603:10a6:800:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Tue, 4 Mar
 2025 15:16:24 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::2) by AS4P195CA0038.outlook.office365.com
 (2603:10a6:20b:65a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 15:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 15:16:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id E29FF24FD2;
	Tue,  4 Mar 2025 17:16:21 +0200 (EET)
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
Date: Tue,  4 Mar 2025 16:16:07 +0100
Message-Id: <20250304151607.77950-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304151607.77950-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250304151607.77950-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|VI1PR07MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: b08c362e-7611-42e0-a09d-08dd5b2f8691
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?alFJV1JESk51NCtjYUhUQWorcDY1N0JOUVk1cXVkWWdXekMvUkEvOC9GQ3J2?=
 =?utf-8?B?bzdmVDVndnhCOHhmcnZrQ2NkRW94NERKZWg1clE2TFJpVm05L0RzZmM1RlEz?=
 =?utf-8?B?SVhvVE5oOFNnc3hTRjNkcklEVmQzZXNOcllYWW5aeWxpTFNrTXE5aGRXNjly?=
 =?utf-8?B?RmlOeVZPYVpxVGFHYy9LV0NNN3ZCRldmekgyWng2OG1ueUIvVzJhWTlHNFQy?=
 =?utf-8?B?b3l1cWZTQWQ2MjZpVmVYd3FRaUN2dC9hRTh5eVQyMWFYMnV2VWtJVkpSNmdN?=
 =?utf-8?B?QnNqQWVMUmFhNU1hcGlBR0toVDhlZ2lVOFpHd2kvSzE0WU1TWjk2d0pTcjBY?=
 =?utf-8?B?dE55bWRhUW5YRUhkVkI2NVNRZzFpczYzc09zeEQ3QVNrMWFRb2FoeGRhYXJC?=
 =?utf-8?B?TCtydC9jQkVzYktUT3IzUDA3UFZTTWFXZGpYQTlqQjNqeDFhVWs1NzdNRE12?=
 =?utf-8?B?bmdUWW5WbFlldmFRTk80cTlsN1VvakNzMWNFMG1pdnJpTTk2RlhrR1RBZGRF?=
 =?utf-8?B?d0IwT0c2amREOU45YUR0dFQrQzBaWlovekVRWHFlV3ByL0xodUVaKzVQUDVV?=
 =?utf-8?B?QnZFY3hMbWFaeGJyV3hyZFRlb3BObEdWY1doZ2N4Wk9aQ2lKSnlYQlZ4QkZj?=
 =?utf-8?B?c1ZtWXVQUnlNcnFDQ0w3ODZjb2ZzZWRhdytjL1RWdDhtbSswQzN5YkRmMjAv?=
 =?utf-8?B?VCtZa21nMnovK2xrU3JIQzQ1NmRlVzMxcTFtbXZTQzZ4Sjl2QkkyZERSd1ZO?=
 =?utf-8?B?bmMvNnp3QmZNZGI3dE5CMUtFSjV1Ty9wUWQ4UGZoaWJ6UmZ0aGQvbWRyd0Fo?=
 =?utf-8?B?b3NmYlIxLzJFRnFyZVlBcUhBeExUMGhqcDNhcThGdTJXRW4xNHZpRm9lYVVm?=
 =?utf-8?B?UjcyTmZ5amFkaDJVcUJraEJzNDUxekN1T2hnWEdVR0NQR25BSGVUdlpNS3VW?=
 =?utf-8?B?WWlqQnE1MDNncFJzYTZzdXFkdzl2REdxWjdvTlVZMk15WFVHa1dkMjJUMkxp?=
 =?utf-8?B?cmZ2L25mT3VYM2dDSGZwTVllM20waWNjbDZkN2tVWEVDUGV2cXFjUzJpbzV2?=
 =?utf-8?B?OUd2WE5JMnpWc1Zra1FxalRTSFZEQ01FVEN4YUZXeHNSaXlBTnovTndQM0dw?=
 =?utf-8?B?MVFaVytKSmVBR3ZMLy9DeXVkQytBWldLNDEvY2JRcjFXK0tRbERGak16Nlpj?=
 =?utf-8?B?UWJrUnNOcithcEhYK0E4NE9scW9EbnU2VTZwRWRXV3pYQkkwK0pCVWNNY3Rl?=
 =?utf-8?B?dVRFKzhjLzIrOGduK2Jqd3lkQ2NNWlZVVzd0RFplQkdrY2RyZFliWU0rWFUy?=
 =?utf-8?B?b3VlWXVBRCswR1FZNWs3UXZVMG02WVZNV3RKRHdOdkdESmk0L1FJaWFhSUkz?=
 =?utf-8?B?SHdEdktENU52S0dNMFYvc0k3dURmSmlEcmNMTS9MaWsrQUdTZUVkSVF3Z0Q2?=
 =?utf-8?B?bzE0VU5kM3Y0b0wvb1NtbUt5UGtCT1I2T0tzMHJaV0NjenhwVmRvbTg1TFNo?=
 =?utf-8?B?VEh4K0ZRcEtDdElYVloyQTM3cXRVdTVHN2JCZDJzdVFxbG9Lck0xaWVoSDdM?=
 =?utf-8?B?UXJiNStyZFFPUkYyLzh0TXRFcnV2R0drelVNMFM2SnBMNHFxVlV3YnZkYnlW?=
 =?utf-8?B?ZFY3ZTFwOWt0aW1kVlFLQ2l1SmVJeWp1VDlwTnpueTJpMFhHYXZDQ2lQMkVt?=
 =?utf-8?B?bXNGSWFhTGl1TGVXL2dRUXZla0xvWmNPY0pMOEFXK0lOWnMycU5sbGV6UE81?=
 =?utf-8?B?L3JjYzdldU02alk0UllONVNtaFBVYTV6M0dFYk51MnRXZHdQNHlEeHVZNSt6?=
 =?utf-8?B?VjJkMXFEcFM0Y0ZVc2lLUkF6dWpIL2NHOTllZ0xBTkRmdjBQV215cjBUSEVT?=
 =?utf-8?B?SzJjdzJKcFpMcWVQT2QrUTNyUzlBNTkxTmcrRXlXNk43QlljNDFXbi9HOU5j?=
 =?utf-8?B?ZVpBMmhBbzNvbU4vY2JlcWVsSUpiYzB6YlFpS0JvMnlocHRicUdxY3hMZlll?=
 =?utf-8?B?NWVXc0ppdDU4ck1qZDFMeWdrTDZ2RW44Y3duaytFbS90bXgyb0pyZ2JNWkhB?=
 =?utf-8?Q?LjEt0x?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:23.4978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08c362e-7611-42e0-a09d-08dd5b2f8691
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6510

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


