Return-Path: <bpf+bounces-53419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971F6A50EC4
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F0D17049F
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D409D2066C5;
	Wed,  5 Mar 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RupOYdk6"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD71265618;
	Wed,  5 Mar 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214349; cv=fail; b=MIeu4ayV+QAyTHjCw3uW9zNAqaV4d1r2NMTnTuQ58RggLJiyNCszpdWn7DaRJs+FOTQGLNFF9jaWcFpq9i71tTUnyCBIofrETYFIyQBsG+wXlG7yEs0R8FnCvCu20WXjQS0PraI0iZvyT2n+4ADEV/igffmNLudAMfCnDZtFD8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214349; c=relaxed/simple;
	bh=DS5pMf6K6WVtAf8pglKCB69Nj81sKdozzBcJ3P/6BO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tn1ncce1qmpVTwiVvZ8RVeaUY1gJTlYbDURYdPW3GP/DvSpLLr4LFcCSBXFN+qnD6DXs2VXH+O63/Q3xpJ8dSm/DaKBeD5yK+aGO5DSWP+hQIXQqweHBfjT90y3VnZNbWqtZwYphfXvrFr3nNDjXLMeBSJwkhWVnuP8J5bylRSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RupOYdk6; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2QOCWvvh8rrGfJdV0GUZz77JJgbdwFOKjzWIijHc4/A+FzU9qJe4mUyHjOsfSIpLb5DVBw/qCvx2faH4ITeqqPaxxHcuGovmhIvQ/iJ5hoUiSfSOpRRQib3GvXe2tSC/FddUadGpIjZuDinSsMDzVlRnQfK+na95rXDQb7ur7cEllhKbRcmmjqT1XohVmTToscfNTQEuH3KqWw1S3eXHvFznZKH0/TNGSa5L3wD0jhanYPMyNRzs6b0ffOPJJf3dPjEvJT/1qcSJbqPVVojj83eLT0bHBWCVi0vQjVds2C/YFOQXq7zzwiyqAXda9fus39nuL405DD39tgc9TvThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sMm9nIWAi2trJYkDq8YaqvfSyZTb5Z8cbXveLTvg+E=;
 b=osnOKmduZp0V+xvldYfGnzcgJuCGGesL4j0F3FAITXNqdOykK9ExrxR2V4ju4ZNamBniAXTjfcgEkz8GXS0CIHcMFZ1c2XbhkqI05mvictaYLhCXhJjs/0G4RRiF2bmM4q+9tT17OL/Vuezltm4Otnyc2BZJId/afE05zJ27psfziMR8yFLRNt7HXXpOKBAZFkzzzUyORGoSzVZ9sK5pS7ES5OisLYcGPX4FnWFr9RRwgkOqB4yXtwrfHsMofZuhKYme3bCkicnpCZHfDUY97Zw9A12BnkAqpPTHq4b2Z/s1IJEzPAVhc+Tgk4Z5k0Ip75o2Y6T+wFWK6Nm9vluDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sMm9nIWAi2trJYkDq8YaqvfSyZTb5Z8cbXveLTvg+E=;
 b=RupOYdk6Tq+8PtFdhyAaVONl3orVX3A7Mw0soxigKFhD0uWcMNP0kdttb/SCdYBp0mxuP8u4VbefUbzTKZienIpiiViydl7OwCNsMBwERPCyihq+hsdWsKGx62yxyjx2PJeTJDxHorRHgEDkBeFXqkl16g8gu3P110oP6vEJlzERAuDgFCQDHyzuYmz4pQzMPSwQfJB0bNcZF4zl5zkrYEdqTJtgHkmB3dut1BsBGhkVTx95saD8VKAY/TvIyNbKPoO8A04mD9GOcT67iCu1Wc6GVrVpVH0ZL4yKaSteDwGZ0wqE/iWkdsSzy5iz314cGJNhKqWcegVfANgJ2W7KtA==
Received: from AS8PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:20b:311::6)
 by AS2PR07MB8977.eurprd07.prod.outlook.com (2603:10a6:20b:554::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 22:39:04 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::8f) by AS8PR05CA0001.outlook.office365.com
 (2603:10a6:20b:311::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 22:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 22:39:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 20812215CA;
	Thu,  6 Mar 2025 00:39:03 +0200 (EET)
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
Subject: [PATCH v7 net-next 07/12] tcp: helpers for ECN mode handling
Date: Wed,  5 Mar 2025 23:38:47 +0100
Message-Id: <20250305223852.85839-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|AS2PR07MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 746ca052-1374-4f4f-a0f7-08dd5c3688ae
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z2cwVHFYaEFpYitKbDN6OWhFRU9rN2NrVHBiZkpiSGM0c2YvT0dMWFp2cmZx?=
 =?utf-8?B?OEZ2U0ZvTHFiWi9ya01ZaUx0NmNmOWxCWDl5N0o2YTFiSUlGSUlHRmk2bkxG?=
 =?utf-8?B?RnQ4RUlWWkthdkNaOWxDbTE5SEtSckFRQVVXTGQwUGVOanZ6MkZsbnRhUXpR?=
 =?utf-8?B?dS92NnNUMjB6ZldGZWNhSktwS3Riay9LTkF3Z2pLVDZBM2k4dHByZEdneGpI?=
 =?utf-8?B?N3ptNy9QeCtZTU04dmt3ODdDdXdEM0N6NFFiL2k5eHNMWjA4eC9aUXpqOW96?=
 =?utf-8?B?Tjk5Rjd4azc2cGlQYldiUUZ6QSsyYnNpV0E5ZThNcHlHb1NIWFptcGNDL1M0?=
 =?utf-8?B?ZVRDOEYyS2p0a2IzUjRTL0dEamQ1elJsM0hEUEFZMEJQUnlsZGV4ZGxDcUI1?=
 =?utf-8?B?d0UyeGM1L050dU1BODF0VThudk9NWmtHYVpLRTVYMnNUc0RjS1BrdDd1OVRo?=
 =?utf-8?B?Qm1FRUNXMjJMVWhxSVA2QjZrT3hsYmVBeVRCbE1ETG0za2crSW9NWFR5RS9n?=
 =?utf-8?B?MEhVMGdrZU5EWkM5Z1Ayc2xWNlV4RHZNbTYxQ21tZDlDYVc3VWJzUGFOY1JC?=
 =?utf-8?B?UzlEampRUytodW5qc2c1bExaTEZUZ2VWeTV5NEhJZnBJTTdEdVpnc2h4ZkRo?=
 =?utf-8?B?RVMxM2JnNllJcUhUUXV6cEdkYjMxdUwxaFFpclVwY0E1YVpkQjBEc1F4ZUxU?=
 =?utf-8?B?TFUzcE5rK3JwMTBDR1F4TVNqUDdQd3dJQXNCSGlBaTltQWUwc1ppMTcxRG9X?=
 =?utf-8?B?NzB6QWtEa3NRMHE3TTYwQ0YwUmtBU0FKOUtXL0RsNVR0L2ZaNlpnM2Q1NGc2?=
 =?utf-8?B?a1V2ZE9DVDlFaVRkeHYrWXMydlJsSDBVVFFHeFdTdDFzVnZwTG44OG9Ra3Ni?=
 =?utf-8?B?VE5wSVJXSXFXNFROc0x4ajBRVXJvQml5NFhxZDM5WUhwYmNIa2hXR3UwbVll?=
 =?utf-8?B?L1VSL21SeHpVS2RFNGh3bHRpUWxCL2lmbWluTjVNQjRtcmxRMWlXbE9RNEph?=
 =?utf-8?B?bnZ4SHNzVmdrbEtmK1pSYy82MFphcFNrZk11TnNDL0FxV05wVkpFNS85bWNy?=
 =?utf-8?B?R3lBQ2lCcGVqbDFtS05yNkM4anNtcmx6empvelZ2ekhPSnV1ckY2L01kUTJY?=
 =?utf-8?B?RnFZak9SVk1Bc1h3K1hoV2EzWHdRZk95UVN3RWpHZEtaOUJGM1d0QnZ4Zmtt?=
 =?utf-8?B?OXFVS2hFelVRSXFoVGRjYTl6OWs0YmphRHR5ZmtweUFjZ3g5WGlBTTJJWUhh?=
 =?utf-8?B?bXljRUNFeHNkNWo0dUlWbjFjNlpTVzJ2bkw1SmJNeDNZdzNYc2ZJcGhJWjFs?=
 =?utf-8?B?cE9mMjUwVjRFNzdyUU1EZys4RHVHZVBLdXRnVlJ6ZVNveHlIa1FxQ09NclFX?=
 =?utf-8?B?M0FkZWhmZnVTSEhEenp6UGRDUVllWlpvVnl1cW51TXhJdGhxTmZLQ3p6Yks4?=
 =?utf-8?B?VFl4d0YxcDExQkxDUy9neThQVEtZcVllci9JeExzUkdBcUJWSU9TNjdrd2FV?=
 =?utf-8?B?OWdqbHFxdzN4MURJZ1RXSW1RK1ZTWnJsa3JZZG1kMmYzcEVFekJmZThjRFJ5?=
 =?utf-8?B?U1g1UEswaDQzQmxkZ0Vmc3lVZ2FiQzBCSkpRZnlrbjM4cUNnNzhDUm5UZitp?=
 =?utf-8?B?eTVlRjRzTzJ5bzVuemtQUTFuTTczcXRaVWJFVjR3aG5HNERWZ2crbGk2SS9J?=
 =?utf-8?B?aTVhOEx4R1p3U1QvUjRTQk1GVkxMaHVlM3k2U1J2UU5hT2trZUJCUE5RSU9y?=
 =?utf-8?B?S0lUWTdvTUk4ZW1taG14WU5HLzRFN2ZzQ3ZxN3lURGdBK1M0TThVVUc3Mzcr?=
 =?utf-8?B?VFFGRFZ3RGR6ZzNEdHJsd2t0U2ROMWNDYkpkSTF4YWJUSXZmemcxandQZjF4?=
 =?utf-8?B?NUlOUVJhN0lJZS82S201QVdkNFlSVjFvbk9TalBpWm9VMFUxK1dNRVZSNzQ3?=
 =?utf-8?B?WFZrdTlVQWFkZXc1WExzOHVpNmR6Z0EvaVZjQmthTDRrd09sYlQ2cTJiQUJ3?=
 =?utf-8?B?UVQ1VHo3N1ljK0xacmRTL1pSNERyUzBSaUx4S3VYRVg1QlY4eCtOYXlORm5i?=
 =?utf-8?Q?MZzcO7?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 22:39:04.6832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746ca052-1374-4f4f-a0f7-08dd5c3688ae
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB8977

From: Ilpo Järvinen <ij@kernel.org>

Create helpers for TCP ECN modes. No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h        | 44 ++++++++++++++++++++++++++++++++++++----
 net/ipv4/tcp.c           |  2 +-
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++++-------
 net/ipv4/tcp_minisocks.c |  4 +++-
 net/ipv4/tcp_output.c    |  6 +++---
 6 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 49b66b499429..7e553f27c0e9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -374,10 +374,46 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 	}
 }
 
-#define	TCP_ECN_OK		1
-#define	TCP_ECN_QUEUE_CWR	2
-#define	TCP_ECN_DEMAND_CWR	4
-#define	TCP_ECN_SEEN		8
+#define	TCP_ECN_MODE_RFC3168	BIT(0)
+#define	TCP_ECN_QUEUE_CWR	BIT(1)
+#define	TCP_ECN_DEMAND_CWR	BIT(2)
+#define	TCP_ECN_SEEN		BIT(3)
+#define	TCP_ECN_MODE_ACCECN	BIT(4)
+
+#define	TCP_ECN_DISABLED	0
+#define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
+#define	TCP_ECN_MODE_ANY	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
+
+static inline bool tcp_ecn_mode_any(const struct tcp_sock *tp)
+{
+	return tp->ecn_flags & TCP_ECN_MODE_ANY;
+}
+
+static inline bool tcp_ecn_mode_rfc3168(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_ANY) == TCP_ECN_MODE_RFC3168;
+}
+
+static inline bool tcp_ecn_mode_accecn(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_ANY) == TCP_ECN_MODE_ACCECN;
+}
+
+static inline bool tcp_ecn_disabled(const struct tcp_sock *tp)
+{
+	return !tcp_ecn_mode_any(tp);
+}
+
+static inline bool tcp_ecn_mode_pending(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_PENDING) == TCP_ECN_MODE_PENDING;
+}
+
+static inline void tcp_ecn_mode_set(struct tcp_sock *tp, u8 mode)
+{
+	tp->ecn_flags &= ~TCP_ECN_MODE_ANY;
+	tp->ecn_flags |= mode;
+}
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index eb5a60c7a9cc..aa2141aef15d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4138,7 +4138,7 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_rcv_wscale = tp->rx_opt.rcv_wscale;
 	}
 
-	if (tp->ecn_flags & TCP_ECN_OK)
+	if (tcp_ecn_mode_any(tp))
 		info->tcpi_options |= TCPI_OPT_ECN;
 	if (tp->ecn_flags & TCP_ECN_SEEN)
 		info->tcpi_options |= TCPI_OPT_ECN_SEEN;
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 8a45a4aea933..03abe0848420 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -90,7 +90,7 @@ __bpf_kfunc static void dctcp_init(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
-	if ((tp->ecn_flags & TCP_ECN_OK) ||
+	if (tcp_ecn_mode_any(tp) ||
 	    (sk->sk_state == TCP_LISTEN ||
 	     sk->sk_state == TCP_CLOSE)) {
 		struct dctcp *ca = inet_csk_ca(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 769048b559e5..5c270cf96678 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -342,7 +342,7 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 
 static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
-	if (tp->ecn_flags & TCP_ECN_OK)
+	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
 
@@ -369,7 +369,7 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (!(tcp_sk(sk)->ecn_flags & TCP_ECN_OK))
+	if (tcp_ecn_disabled(tp))
 		return;
 
 	switch (TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK) {
@@ -402,19 +402,19 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 
 static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || th->cwr))
-		tp->ecn_flags &= ~TCP_ECN_OK;
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
 static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || !th->cwr))
-		tp->ecn_flags &= ~TCP_ECN_OK;
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
 static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if (th->ece && !th->syn && (tp->ecn_flags & TCP_ECN_OK))
+	if (th->ece && !th->syn && tcp_ecn_mode_rfc3168(tp))
 		return true;
 	return false;
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 3cb8f281186b..0ae24add155b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -461,7 +461,9 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 static void tcp_ecn_openreq_child(struct tcp_sock *tp,
 				  const struct request_sock *req)
 {
-	tp->ecn_flags = inet_rsk(req)->ecn_ok ? TCP_ECN_OK : 0;
+	tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
+			     TCP_ECN_MODE_RFC3168 :
+			     TCP_ECN_DISABLED);
 }
 
 void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 98f2684e0006..0d275ee68a1a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -325,7 +325,7 @@ static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 	const struct tcp_sock *tp = tcp_sk(sk);
 
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
-	if (!(tp->ecn_flags & TCP_ECN_OK))
+	if (tcp_ecn_disabled(tp))
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
@@ -354,7 +354,7 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 			INET_ECN_xmit(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tp->ecn_flags = TCP_ECN_OK;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
@@ -382,7 +382,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tp->ecn_flags & TCP_ECN_OK) {
+	if (tcp_ecn_mode_rfc3168(tp)) {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-- 
2.34.1


