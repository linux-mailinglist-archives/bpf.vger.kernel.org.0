Return-Path: <bpf+bounces-53420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B9A50EC8
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EFC1704F7
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577026868B;
	Wed,  5 Mar 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tO0jjRwM"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A932676DB;
	Wed,  5 Mar 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214350; cv=fail; b=QlKMBacmnzKqDJeaKCIQ41P7rIhj6kdGaMEvGZ0FygnVvDnhPE6ONptkgmokvhi/6RYCtHFsxZCU4JGixfhtLCS8hhzeJ8qcOSFtUjVCch0po7eaQCgZsHehUbL+RxSAW1QCr7mS+NRvGrT4nxZxZ5nOx+BEmv+75PVJp+A+7L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214350; c=relaxed/simple;
	bh=HxJALqWnEF8Whxp0ZdFTJB3/DnjfC9ktgSbH3RujgEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gK8TlQ58syZTAhVXSM8w9CpPQeRejgMha+IFaWX216Dt8zgKxhE3CTU0VxsBau2yX+5nCmeMD7jgX/8n2/puUMQeEk5ikpI5Aiur+Hcr86mLsyo/qEQWRFERnVAYEbHYmi2Z4D30X0rWjFW4JIS05fSOMfXKBwpvwMX5dHH/j1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tO0jjRwM; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba7JLjqAOGM+h9El2B2oKM6dsEKML54c/dKxFHKGFzB3zO98lqx0pNmxivcmO4FuQmEf6G3N7ualSUuuqxk62ByUNLbsqR9fInlJqjOu/52ZqDdqF969PaIVsA52DFTbDMxKf1y/an/iieuNA7EXbWwkPJ6004hkFfjAsHb56VzeghDBjU0Z//7FkcpmzQ7JkM6SSEYWuVrCoftcy+MB/BQCPT1aKttM9gNRVphqlSLlAkVKd5Bz3WBragq7BIS0AbeNXlB9GWN2Cb7OBfIYFS7yWbD2LgdDBqtfCDxTKmVxUJ9m1LJJuLigasK8hPLrM6nlAfehBzCAlTcLiEzYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTSh1SaQdAu7He1aPYFxG7DTSFXD9HAX4cddFz0FSPk=;
 b=EpghBvVppc7AkQwmXtdjHvFkmzh1hw93e5UybA0KGMaVKx9AcpJUvRUY+ewokw6WODoEkUKAVoFD1vkGKG9Z/AIGtqCkIdi/vK7V9IufFrWu/+8tNck7pftiCdbLD2wU6jTyxOcJIIBauZIyiiTbliKixve9MQsnqgAtX1NAc46qUmbCt1snUqNt31dQW9jTsTU116XgVEKyihu60hfUbeYaEaDPuNSbSXai3tFeYS/m6a5vfch9KgBcyJqEyvob+A4t8K8/xam/UBbxNEYj5ry5TUUEZJRa2ok9zbZE9n1HX5uy/Ey4kc0d8uOoFDN++dpxwedPb2qGWxfuKNY5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.20) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTSh1SaQdAu7He1aPYFxG7DTSFXD9HAX4cddFz0FSPk=;
 b=tO0jjRwMq7K0BvjTnV/X48lz6YuBtSY/D2MKpe8itxO+V3pJ7MnAIUiF+MibUVTDXZ/b1athOcLgJ4KK1tnA+zew6nbED6fUZ8KCvRYxPdzHsN5Rku3t4ek2ujU/dMv1klSjxfN+CxkeHH2sP91qODL3mDfanhwWB9w2yM4ZReytepz5wDNXnD4pP1G4exfwtaEIWwLKUC5Ats6u5a8IVGbfnFB4SzbLDfoTigewNxkViNoZnuesVBe5QAP5zUoPPWEQCWCyQuUvXHlaR9VnH23DV1XRnZJAr2dP93PSUD0quCRQgfLzVQftDT2p6Da+IEEM4l5+yjdt9ly72OuuGg==
Received: from DU2PR04CA0241.eurprd04.prod.outlook.com (2603:10a6:10:28e::6)
 by PR3PR07MB8161.eurprd07.prod.outlook.com (2603:10a6:102:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 22:39:04 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::48) by DU2PR04CA0241.outlook.office365.com
 (2603:10a6:10:28e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 22:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.20) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:39:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 6D7CB251E3;
	Thu,  6 Mar 2025 00:39:00 +0200 (EET)
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
Subject: [PATCH v7 net-next 05/12] tcp: reorganize SYN ECN code
Date: Wed,  5 Mar 2025 23:38:45 +0100
Message-Id: <20250305223852.85839-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922F:EE_|PR3PR07MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbc1cfa-8c14-4e8e-2e2e-08dd5c36872f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?N1NVeGxkbFEyT0Z2R2k1RjRGQStVdHFUY1RsY0RhRFFtaU9Odmx2Zm95QjdO?=
 =?utf-8?B?c3N1c0t6MTR6Y3lpMTNHdXJvYWFWZTF5clo3OTAvMUlGdzFHVFFOYldBY1ND?=
 =?utf-8?B?UkQyb2s4aXhCd281TWZLcjFFMjh5TlY3ZCtVMWw4a1FhWWhBU3ZNdkpLNWV1?=
 =?utf-8?B?S3BubXVpalM4RzNHZGZwdFJjeGNYS094QnUvTHByeVZic01NbE1XaWZnL3dt?=
 =?utf-8?B?dGFWbnBCTCsxbUhMUWlLSlZoNkpkNER3RXdWN09GZG4yMU9oSnlQcHlWQk1n?=
 =?utf-8?B?TUYyUS95SHBvUVN6bnhpRVVVVkV1UFI4bHNCdktBNlR4Z0ZVcE9wQ0pqNHZz?=
 =?utf-8?B?WG9mNGVkU05HZUpuT09jVldqaWRSYTdQdWU4YUtLZWNjZlplZU9wMlZJY3FX?=
 =?utf-8?B?MzF2bGwrRU5oM1lEUWRGVU5tV0QzazhRdlR5TEd6L0hlVTcxOHJkWmg3SG1i?=
 =?utf-8?B?b1I1ZFZyMkFVN3VEMTZqYjJSOXhOeGcyemhUelVROHdjR2Zjc25VNjRGRVd4?=
 =?utf-8?B?Z29qOThJL1RJalk5bDcrWFIwWDlndXJXekdBQjNmTFFpVWN0d2lqV1U5alZ4?=
 =?utf-8?B?OFZydjBpSVc0YWxFeGRsY0RWR2J1RFJCLzZtS3QvTEQ0TEtpR2RmMWRIR3lR?=
 =?utf-8?B?V2ZNbUM1TVVBVGdoMEdTb3Q0Y1JGSSswL0dFWStlQ2RNZHd2QndIWjVoSnVP?=
 =?utf-8?B?MXRxL0VvdkZXMnBSSlc1WW1HVk9DZzdIeFRuUHM3KytsbXR2Y0VnL3BGNlUx?=
 =?utf-8?B?STgxMEZOQ3hvTDFuS1YzM1EwcFBpd1ZMRGl3WE1QaFE1UlJ6SVoxajFsemdU?=
 =?utf-8?B?ZitWZUljaVNXZ2pZQlJaRk04RDAzcm9UWUlIa0FQbk5neHFWK2c2eStLS0g3?=
 =?utf-8?B?ZkdQcEgxbThpZmcwbDJ6dW9QL0htTlBQREV5VExIUVZxenpNamdTYndnam0z?=
 =?utf-8?B?WGxXSVpKTlpUNmxLWFRNSkthdDd5emdXMndZRWNOSUNHVVZWSlZhV2hEOHQ1?=
 =?utf-8?B?Nnd1K28yOFY3VUxXZGdQL3dScjNZZTFJN3FzbkdSZUVjbTc0Rzc3VGNXZzkw?=
 =?utf-8?B?bVVaQzlra3A5b3FTUWNPRVVpQ0ErVjFrejkxUS9zazdrdFREbTBMQVJqMDJ6?=
 =?utf-8?B?Qit2RjA4NTJXcFFwSmVySWRhMnIybGw0QWt6SFZIMG5Pa1Q1bC9IalJhOUFH?=
 =?utf-8?B?MHdmbmlMYzBPY2pEZThmL0RlTFhkQmdXdmFtelRNUmFCU0F5QmZ0dC9TQm5v?=
 =?utf-8?B?SW5QeXZncU43TFBhZU1VSWYrUk1LRDdwaVhNQWYwY0x4UUJmL0JrcGZZUDg3?=
 =?utf-8?B?cmxZWHB4WEs4MlFzWlVrRjdraEV1S2NYZkpObWMrTXhuNE43aXYzMUtwZThx?=
 =?utf-8?B?KzhMcG0zWXptZ05NQ2JmSDdlM0I1bkJ0bmg1bS9xOW9GWnhmOEtjMmFFMld5?=
 =?utf-8?B?UVE3ejMzZUhQcGR2Rk1OQndYVXFzUXBhWC9EQW9jdGlHN0RkaGY4b3JqWGEx?=
 =?utf-8?B?djhqcDc5c3hKdTkzWWkrRlFjZW1xM2FoV05oZFRvRTQxSXVCVUd6WDZrelZG?=
 =?utf-8?B?WW5ERUhlWWo1UzJyT0l3YWhlRVROTklKeWYvaGl4MGlVTG8rZjlVWWY4M3NI?=
 =?utf-8?B?Sk9kMUs0MVE3R2ErMnluK2U2WkpGOE5xMjAxU0Y2Rk5hUEJidDVSOExtbHdm?=
 =?utf-8?B?U0U0UEd6QjYzOVoyTEpqa1NjdmFocGxxWVVFM01pT1U4U2hNUWJ5NUI5UEtp?=
 =?utf-8?B?VWRqQS9KS05WRmhUVE5wbllBWGxRMGxCNjN1dWZZSk44Mm1YQjA1YmJlT0Vy?=
 =?utf-8?B?TUdaQnJBWWNaOTJ3MVFxL0dEMlNOa1kzZnVEM2RLZEpodFVJN3BaM29HcnJH?=
 =?utf-8?B?MUdLbWtIanZoMTJMbWR5U3J0blNKVHdTWnF4UjZxVE16WFBXTDJZK242SlVu?=
 =?utf-8?B?d3UramJuVlhqTUt1ajJtVGtvb0FEUEc5RWpjelFjYm5PVGNSRU1aMDdCdkEy?=
 =?utf-8?B?WTBuekdqaGx6VE8vdUtPSE1TalhndW1VVnBMRVZCQ3FaektNUWdEKzB6TWZP?=
 =?utf-8?Q?Oa1ROX?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:02.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbc1cfa-8c14-4e8e-2e2e-08dd5c36872f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8161

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index efd3cb5e1ded..98f2684e0006 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,10 +350,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tp->ecn_flags = TCP_ECN_OK;
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tp->ecn_flags = TCP_ECN_OK;
 	}
 }
 
-- 
2.34.1


