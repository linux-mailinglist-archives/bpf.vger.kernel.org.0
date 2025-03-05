Return-Path: <bpf+bounces-53414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5370DA50EB7
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D7C188A7C4
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E66266B75;
	Wed,  5 Mar 2025 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dxbDY76P"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFB20469E;
	Wed,  5 Mar 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214344; cv=fail; b=j+pDetzAdsnpip5M1hiG5aK39TwjM7duhBFnpTlVCCir8BPfX/2w4IOZBmMe2oHD0kywz6kTXNF2Sp/LwxAMK/RXYTF228PB6Y4ov+ax+jTfgZzzB9CiFt4/AE8IYmH5tSMS20rZqxIG/At6jFFR5PvQwOi7ICLY1fYmqaF4/G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214344; c=relaxed/simple;
	bh=+ARu58x8s13+TcFCn58qW5AlwIEfzHsxB3c3plCyDaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeVRGoh5GX8wJ6dM5cTXtfDkIA06WciwUUrsr6Kig5lwZl2xTjpezJ/6wlAOEeRWBqIkGsg4YGZY9EfKPBzGbspqYZ3zV1Pbykj/0xgqG4oJ70wt0BuytbUibG7s/fNAmeZL/2rAWRQrnRWN9IhIRG/w2Qj8BE9SD4DHH4vB9j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dxbDY76P; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvboP1rrKf0pc9JHZcwg0Pm8tLbSZeeB5tS8RLd8E79hTQpUvm+Y/xtFefE7CyPWmOhs4y2jGqJKJ/TiQq+dX5qmcl1+EJSUkd8ZxSdt46xP6spoaGHJ+H6+KS58Rqp8V+G+RMPJTbEHIlZ26O3lE31ffyqAHRrjiVM0kCMn7p+HrxuqgA2wlokPOBbb79By6mT9s3hE25SKu+/b9oHKHiwuYfiviZGk71nqnb15BXj2EoRUQVYE6Uk3LU+Oo7BcVVXFgg2SXVZ8M3t3yMRMyPvVbBmYIErN1FGsZ/gNlyVJt3bF9d5/EBUi+awU62xpzByKQFTjZNcXVPHQbIlozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P7pGyCPHjKrPFWpZP9X6L+e4wDkYsQD65Q6r5MyWLw=;
 b=Zl3fVy5aW/uKIdUB0gMo32daxg4jQUxWl5fZoGdZlHhTH9JmhjleBvEl6KYu36vp899joGtF90hQuB+1CvSHeezLV7HoLR2uulvBQsaal2X/58KVIuT3vM2kd6xytQmpMYLysXL0qMtyKapvZ0LYd19nhQamayK/xwgunmViClALy0dtOG/wgBs9BHayA5f/ZHn9aKq0fYYo/SWunGZzoj8l6/qgeGgdA0d9na9HSZWqqmZhXbAN7j5VFcmmTXHyTb7Sw6/Y1NxE/YaGSTCTcSxSB4a6i2Syjk1IfhZD8zvQlJRdOzkpf72NEnAiQsU6auY2C2cFG9IeXobHozEqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P7pGyCPHjKrPFWpZP9X6L+e4wDkYsQD65Q6r5MyWLw=;
 b=dxbDY76Pikd5cKgyCntcs7Ry/bKQmbjHo5M8wKCPeEeT+sqenoc/LClGhhnIp1/dHaZIotv7zphBMZWbfHRKwxX6aZjv7JiX6g1sPtxwU0nz4AERMj20KLUYMi/cXyliO2A0t15qUiWuAoP1zKfxj9MUF67vhd3Kn7nSu7P2iDjxPvE+hQNusU/0LJsB6yXmGDqsx9mv3TzyjIjS/Wzz8R6CewqM23/nOOR8XtHhoVN3YYEZn4z8v6gglKVD5WPtN+4dpL3FrwUm+mcdjZmzAXmaHrX5aEM1IqLaRS+zgi4NFBlfWv7C/8cQT+lxkBmC/12WyIBvuzLRT4hIP7ecyA==
Received: from DB3PR08CA0019.eurprd08.prod.outlook.com (2603:10a6:8::32) by
 DB9PR07MB8749.eurprd07.prod.outlook.com (2603:10a6:10:30d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.18; Wed, 5 Mar 2025 22:38:58 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::33) by DB3PR08CA0019.outlook.office365.com
 (2603:10a6:8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 22:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:38:58 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 707FC206F9;
	Thu,  6 Mar 2025 00:38:56 +0200 (EET)
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
Subject: [PATCH v7 net-next 02/12] tcp: create FLAG_TS_PROGRESS
Date: Wed,  5 Mar 2025 23:38:42 +0100
Message-Id: <20250305223852.85839-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|DB9PR07MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e54c7f-689f-4f1a-cfe3-08dd5c3684d6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aTNkNTNpWGpWd09vWGwrdE10L3NrSjhaVGpPZDc5QWtSN3ZhNWVwQU8zR01i?=
 =?utf-8?B?RUlkMHNKQms2NmlaeVNmbXdzeGgrbVBEclltRENQeXp1N1Z5RVVIUnA0UXNZ?=
 =?utf-8?B?WjRLVUhmQjdtdTZyUm9qTHgwc0dwSkd3Wmtnb1BPMlpnQ3lwSmRtenBONXlC?=
 =?utf-8?B?VDVnVzNCYU02U2hxSkFqNWFYdDNPQVMyZ0NLNTJRcDFLalVhNnhyVWxJbEdq?=
 =?utf-8?B?aXhTYzVWUi9Yd1RBT1J4UUFRbVJzSi9aalIrbEpEbDNGQytVNXhyQjMzWVdR?=
 =?utf-8?B?RzQ2SUd4NjVPNnVpU3llWFUvTnBZUmNDeHdETThWQUtFL0FzSlE3Q1dTZnA2?=
 =?utf-8?B?b2FsdUZGZE9HRXQ5Y3YyVmIxYUxSWnZBMloyd3BrcWVYWk95MHJYY3lGKzZw?=
 =?utf-8?B?dDB5OXZud3poRWhJeHNXcmlkSEp6QmcyRjhUdGF4WFJZUlhnVmg1VFVicndN?=
 =?utf-8?B?czl5b0VyM2VRdDM3MC92N0R3SjYzaE5qY1p2VStZQWFTaDBKSFRUM2QvU1Zw?=
 =?utf-8?B?a2pNaHBuL1k2NTNXdXRpOU5yZGZuWGozNXYrT2dtcWNYZzhLb2VWWUdicGVn?=
 =?utf-8?B?WlgxS0M1Z0g2VjJZYlRsUzRrc1N6dzY4ZERXZWdHSFE1KytqVUFwOGpzdTdz?=
 =?utf-8?B?TFRPRVdpWFc2NEgzQ3A4TENhT3pHYng1aGIzNEhGRHMwQldMbXNGbmg5ek1q?=
 =?utf-8?B?cVozM0ljd2xMUXdQUk8raUFNTTJaVUdBbnBocy9YNUtIL1VRTFFJUW5qU0lk?=
 =?utf-8?B?bFlqVlFPMDV3a2JXR2dVNzRrak16UjZ1NmtFY0FaYTZweWlVNSswK04wTmxW?=
 =?utf-8?B?cHUzSXk5WjdlZkxSNWtwd08rSWNMUWNwcjJZS0Noc0g2RzR1WE8wZmxxVXNC?=
 =?utf-8?B?NzN4M1NURE00OHBjRmtqYVVKTjd0WERrYlg1Ulp6ZXhTbnhNN2pNcmxweW1Y?=
 =?utf-8?B?SXhleEU1M01tQURqdzRWSGt4SVJ2eGM1VElWSWVydVZmclNFeXo5aEs0bEVR?=
 =?utf-8?B?U2luUUtlby9hTDNwKzhnRlF0SU5qOTUrSG15RkQvQ1F3b09YL3lhSmIzNE90?=
 =?utf-8?B?VVFkc3QxR3V0T3I3S1oraGRiblVKMHlOMkFiREZDYkpIOWh5eXQ5NkFBSDEz?=
 =?utf-8?B?eE4yeDFMZW5Dejlmdm10aVFMdlhHcCtmRDRWZllrMXl2S25TRW9xUkxOK0ps?=
 =?utf-8?B?OW9TV3ZRdEorK0FXYjdEMlNka3luLzdTRnBzd1RqYmNYbmRGMkJOT1lOeUw4?=
 =?utf-8?B?M2FVQllqd2oyeVpEY2NuQStsODdPdkJISkw1QkFJMmhwWVc3SHhVNUtrb0d4?=
 =?utf-8?B?UlUyWFhOY21YYTYwajRNMU9VRG1Ic3ZxL0o1eW9VbjVYYzRNZzEvUHBaWURL?=
 =?utf-8?B?UFU3SXVGTG9EQmkrbTVFZ2EyWkphcHorSDlGTEpjUTlWZzIrYkZQckVIRXdD?=
 =?utf-8?B?d0R4L09iZVZwdERuajJBYVJqTkRBb0pGRTZEZkJDVmhYbjlLTzdkK2c1cFpK?=
 =?utf-8?B?dmNvMDNZb0s3eUM2R1RJK2oyZis1bU5UZU9obnVXeW1hY1JpTGRyUTNoMm1H?=
 =?utf-8?B?OXVOME8wYU1XQm1tekdrZEtENWF3b2tRRXpSa3J6N3AyN0xGWEZNbFExRHB3?=
 =?utf-8?B?WU9OVS9hTzh1MmRhamtyQncrS2tlT2hNZzlBWFExeVhnOXBnbWxXaTFaL21i?=
 =?utf-8?B?dnFEMWNkM2VGSEVDQXpGaVpUM2dtWVB5NEdMeGFwRkNtSmNxMXRpRWNOVmRm?=
 =?utf-8?B?eHVoZ0dMK0tLWG0yRlhuR09Ob0VBZzFxeDhhSGpjMlVaSWRoVWM0UzQ2OHpr?=
 =?utf-8?B?ZWt4K3VMQkVoN3JKb1RWa2xvVVFDbkZ6dC9QclM1a2ZkWE54ZGhBeHV6YXFR?=
 =?utf-8?B?WXNRWE9PN05lejQyRWRMN1VCQWpIUlpWZkZOME9CYVAzMUVhbEVvSFdZVXky?=
 =?utf-8?B?ZDBCSWs0YUFvc1FjWXVPQzNYcE5ySmtIMkwvQUgvS090MzJIa2ZMY3hQMjM0?=
 =?utf-8?B?RzBrbndlUVo4L1VJWElyOUtKd0ZOY2E2QzVqMkJPKzFXUWY1WVJIZ0xPV1ZM?=
 =?utf-8?Q?QSWsfn?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:38:58.2044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e54c7f-689f-4f1a-cfe3-08dd5c3684d6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8749

From: Ilpo Järvinen <ij@kernel.org>

Whenever timestamp advances, it declares progress which
can be used by the other parts of the stack to decide that
the ACK is the most recent one seen so far.

AccECN will use this flag when deciding whether to use the
ACK to update AccECN state or not.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6a8eca916580..771e075d457d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -102,6 +102,7 @@ int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
 #define FLAG_NO_CHALLENGE_ACK	0x8000 /* do not call tcp_send_challenge_ack()	*/
 #define FLAG_ACK_MAYBE_DELAYED	0x10000 /* Likely a delayed ACK */
 #define FLAG_DSACK_TLP		0x20000 /* DSACK for tail loss probe */
+#define FLAG_TS_PROGRESS	0x40000 /* Positive timestamp delta */
 
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
 #define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
@@ -3821,8 +3822,16 @@ static void tcp_store_ts_recent(struct tcp_sock *tp)
 	tp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 }
 
-static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
+static int __tcp_replace_ts_recent(struct tcp_sock *tp, s32 tstamp_delta)
 {
+	tcp_store_ts_recent(tp);
+	return tstamp_delta > 0 ? FLAG_TS_PROGRESS : 0;
+}
+
+static int tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
+{
+	s32 delta;
+
 	if (tp->rx_opt.saw_tstamp && !after(seq, tp->rcv_wup)) {
 		/* PAWS bug workaround wrt. ACK frames, the PAWS discard
 		 * extra check below makes sure this can only happen
@@ -3831,9 +3840,13 @@ static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
 		 * Not only, also it occurs for expired timestamps.
 		 */
 
-		if (tcp_paws_check(&tp->rx_opt, 0))
-			tcp_store_ts_recent(tp);
+		if (tcp_paws_check(&tp->rx_opt, 0)) {
+			delta = tp->rx_opt.rcv_tsval - tp->rx_opt.ts_recent;
+			return __tcp_replace_ts_recent(tp, delta);
+		}
 	}
+
+	return 0;
 }
 
 /* This routine deals with acks during a TLP episode and ends an episode by
@@ -3990,7 +4003,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * is in window.
 	 */
 	if (flag & FLAG_UPDATE_TS_RECENT)
-		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
+		flag |= tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
 
 	if ((flag & (FLAG_SLOWPATH | FLAG_SND_UNA_ADVANCED)) ==
 	    FLAG_SND_UNA_ADVANCED) {
@@ -6165,6 +6178,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	    TCP_SKB_CB(skb)->seq == tp->rcv_nxt &&
 	    !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
 		int tcp_header_len = tp->tcp_header_len;
+		s32 delta = 0;
+		int flag = 0;
 
 		/* Timestamp header prediction: tcp_header_len
 		 * is automatically equal to th->doff*4 due to pred_flags
@@ -6177,8 +6192,10 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			if (!tcp_parse_aligned_timestamp(tp, th))
 				goto slow_path;
 
+			delta = tp->rx_opt.rcv_tsval -
+				tp->rx_opt.ts_recent;
 			/* If PAWS failed, check it more carefully in slow path */
-			if ((s32)(tp->rx_opt.rcv_tsval - tp->rx_opt.ts_recent) < 0)
+			if (delta < 0)
 				goto slow_path;
 
 			/* DO NOT update ts_recent here, if checksum fails
@@ -6198,12 +6215,13 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 				if (tcp_header_len ==
 				    (sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED) &&
 				    tp->rcv_nxt == tp->rcv_wup)
-					tcp_store_ts_recent(tp);
+					flag |= __tcp_replace_ts_recent(tp,
+									delta);
 
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
-				tcp_ack(sk, skb, 0);
+				tcp_ack(sk, skb, flag);
 				__kfree_skb(skb);
 				tcp_data_snd_check(sk);
 				/* When receiving pure ack in fast path, update
@@ -6234,7 +6252,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			if (tcp_header_len ==
 			    (sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED) &&
 			    tp->rcv_nxt == tp->rcv_wup)
-				tcp_store_ts_recent(tp);
+				flag |= __tcp_replace_ts_recent(tp,
+								delta);
 
 			tcp_rcv_rtt_measure_ts(sk, skb);
 
@@ -6249,7 +6268,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 
 			if (TCP_SKB_CB(skb)->ack_seq != tp->snd_una) {
 				/* Well, only one small jumplet in fast path... */
-				tcp_ack(sk, skb, FLAG_DATA);
+				tcp_ack(sk, skb, flag | FLAG_DATA);
 				tcp_data_snd_check(sk);
 				if (!inet_csk_ack_scheduled(sk))
 					goto no_ack;
-- 
2.34.1


