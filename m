Return-Path: <bpf+bounces-53192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8AA4E354
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD93619C4F01
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7F290BA2;
	Tue,  4 Mar 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="HKBFgTLK"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B928FFD7;
	Tue,  4 Mar 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101387; cv=fail; b=J33ZouWsOns3jQwxLReFzEO1mvBHcXUWF+OblDs7boQb4nCiG9Kzo+Q6gl4m1i/3xTcZTH6/WkSA/VC85WAFTeVUXl5QxNv/D8VcT9dS/OfP7zW/uaLgO6UI/+HJDf15vlk7pZZtyVVgNgtVRjofTqBvBCWB/YdWqqgi+zKutZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101387; c=relaxed/simple;
	bh=DS5pMf6K6WVtAf8pglKCB69Nj81sKdozzBcJ3P/6BO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9/bjoTe3g9+kZbUhi5P7nu5UE07SWhxOxFHECHTYYF4xZ6kn/F/7qSfhKlldcqTIsLZLFvN+Fg/DEMNQfM+ji+XhglyR8VzlPlungKQ3P21HD3GhWgoZyq1CxX2Ciirb1wc4Pv4K3fxYvTlFxkgWh5z9xRcK81IFFYunjSl/V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=HKBFgTLK; arc=fail smtp.client-ip=40.107.249.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyIv9t/AMS9MQCt+s8xaevPlzORGRQ95JCMpG+XEt5Fn2Ml7kG0M9lWGByfUotmRFVqNBHd+A2vWFiiE23gwWePMGsQFD5APy1k4uwKyCkhZdaYy9S9J4sVuZJyu2QUwqsqHWT8N/H/zK4T6vwCSaviVDRk5tbKAyXDHrdQoghwNxfSQQ4ODo93w4IJhVMi1u0s/MFkYAUL9jKJKPtvsnBjYbAZPQujNAlHSpzs5DE4nVnwRHdR8c/nabeEecuQQD1k7wzEc0vzx14Z3fBXKkHgYhcSImw+ScrnXLla++3cnzvtK5R8JLcN3oqqWnDbNwEmcumgPCY2d0odEP9diIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sMm9nIWAi2trJYkDq8YaqvfSyZTb5Z8cbXveLTvg+E=;
 b=hcP3Z65cvUEb5sIVKs7a1f3e0utEGfvwuoNGF4qhvQEs6VXdGpgSLse1ymx0B/32g9roerSWOsMMSDvpa/4zBaNVYxe5mC8AocZh+FfwN1Qql/C80mzZJ1j06z9QrxiUNdSeOb5+6cHFyjvn0v6ALefgUWZlWyb9zOygnx/jbhyBKztCDILqvgGs0nkOL0xadZ2iYStBAApZE29zDcLZxx/UILUfJ4iyp98Wo6ZS6DFteGwxPViP25VjsH3qiO94kvVrLvhq5qgUU+t6ncN9YDZv6mDk+tsUcCX1crQy27uGki85tIXidSAByU+GG5mcJDRsJrcN3PcUtqsi4K0Dcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sMm9nIWAi2trJYkDq8YaqvfSyZTb5Z8cbXveLTvg+E=;
 b=HKBFgTLKyuH0/LhbFb/KXXkYkxVJQI0C2S3ZeHBGLvA9IR1YF+P9j3Jhrpo0wXd/9m8+IScN/R8j3zHtKtCSFuwLyTvSiqgb+CaTPYI2kHk9Vs+aAJy6/h7fvQHX7zkwXFIS4XLctbtpQ9AWK0A6TldPBwhlazGeBghQE+tZ9Jfk7BHdXex5uQTwiAq9/faejUg9mx0pXXx6bT3nc/NPAYQ+vd/mw9VvBXSoGibpc5Ge5P2iW8XGGt/ryKhpz8z44CMe94oebJneL2hP0cVjvluYxwyVbU/YaAYCqM1Ts1nPLq865+HcomOxjJi22+Coy0NO8hC9DNolY6D9ikie0A==
Received: from DB8P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::27)
 by PA4PR07MB7519.eurprd07.prod.outlook.com (2603:10a6:102:ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:16:21 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::ff) by DB8P191CA0017.outlook.office365.com
 (2603:10a6:10:130::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 15:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 15:16:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3FFA724FBD;
	Tue,  4 Mar 2025 17:16:19 +0200 (EET)
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
Date: Tue,  4 Mar 2025 16:16:05 +0100
Message-Id: <20250304151607.77950-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|PA4PR07MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cadedda-4788-484c-a158-08dd5b2f8519
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WkhsWjJYRWMxRklKQnkzRElqV3I1QlJ6cmhxTHlIWVFRVndTNHZOUWpHTGVY?=
 =?utf-8?B?aVpzU0hxYTVWd01Bak4wbWtqbW9ETExrdG9SUlN5L0t4bjg3azArVGE2Uncx?=
 =?utf-8?B?RmRvdnJlSUV4UGZyV2ViSG81bTE5L0lTTnlxSVU2bnNNUU84SFpKVklTb25M?=
 =?utf-8?B?SURvVWpueTFBNTkvblp0KzVremFQYjhQc0NvVzdMcVhzbkJpWTFrcGwwN2tE?=
 =?utf-8?B?ZTFjU3RCUUsrT3c0TFBJOFA5azMzMnZNWGVLS2oxcmlFNzlHTEYvN1ZuSDZU?=
 =?utf-8?B?dGQzb0N0YzdJZjlhZHZ4cDQrTlNsaU92ZSsvbmQ0a2VLMzQyVWh0aFdxRGk4?=
 =?utf-8?B?RnM4bUNoc2VKaGViazMzRXdRRUtkWXllbUhjQ0JIWFoyNzgwL251RDErRGZt?=
 =?utf-8?B?b21uV3o0OS8wTXdTZ3FlUm5VKzFteS9mY2NpV3FXeDhtTElNR2RNQzkvUklu?=
 =?utf-8?B?VU9xNWJoazJzRkI3MDE1dUpZQ3R0Q3MremYrY3htMnFlUVNKTUR1QitkVzh3?=
 =?utf-8?B?eXJUMWhaN2lKTjBJVW5xbXQ4Wm8xK2FnRy8vNW9GZGdEaGNlZFhYczZ6OE9R?=
 =?utf-8?B?ekRZQlB4VEhZMHVMYXdsYXBvRkdMUG1SNmVlbXdTWVpJcEU0WUJyVXAzdHRM?=
 =?utf-8?B?NmVlbjVkbXFEd0ZEdDRYOEZTQkVKakdWMm4xTlF6djNxOEdJb2EvZmp0d2Yx?=
 =?utf-8?B?ZkdSbzV5Vm1ZVE4xOVhVS3NPNkhDL2NVTkZ0SStZM1Z4VUFza1F5UXJrZEZN?=
 =?utf-8?B?RXM3Vkp0M2syTGNuUmlDZDVlaWtkR0ZwcDBUZ2pEalRMS1Fxa0YvTkc2MStB?=
 =?utf-8?B?WUVtR1FOZ3RjbjdCQmVwS3g4MmpQZDE5TEFCNHVJL20wZVZ1U0t5UnREc2dH?=
 =?utf-8?B?SWJhaUQ5QWNtWjc5MGhUWndIOU8rUytQa0JiWEwwRlNHeThtR1UxR2pscm9G?=
 =?utf-8?B?bzd1dzlsVElFMUtoamZyaWVUL1U5djlwdmtCNU1VWjhIQk90bGR4ckRLSlF2?=
 =?utf-8?B?RFVsZ3R0NlJ4V21ZUjBxZCtRQzltUzlDdWtESUV0K2liWVB6RE9nMmVhZE5v?=
 =?utf-8?B?Q2Yvb1J4TVJiWGN4T2dBU0VWUmY5NUYxNGtQRFg0bTNuUWlZL3pkeEZWOHB2?=
 =?utf-8?B?ZGFneTR2SUc0WkFOUGpSRGtLN1RIeEQ0dHdJVnM5d0tOMGx2VTRDOEZzSmI3?=
 =?utf-8?B?Q2JzMEFZZzludG9SZE15dko0bWUxQnl3Q2RpaStyNGVZV3F5bE12Y1JjekxO?=
 =?utf-8?B?UWZNSVNmTm1XcG04UCtqaTdkZkk4dkdxQXFhTll3YVZZV1laUWROejAvYi9B?=
 =?utf-8?B?T3MycS9ySDFuTkZScVhDaEZZQVJ3Z3RoNTUwSVV6bDB1M0V5YkZROTZXVnkv?=
 =?utf-8?B?Z2hYSXo5M0dxajg2UXk4cVY3cERSaXlRYkdhS24ydjM1TUk1UmRpK3hqUExZ?=
 =?utf-8?B?cDJlZmE1dnkxWVA3ZmpNcWZhL015SEFJQXRZc3BVTzRCSFhiaUNRdzBvZlhY?=
 =?utf-8?B?b1RoL3J0Z0xiTVErZHBpbm5xVzU5aW9KNDA0L0ErTm94ejFSbzJ6TjZWdjFK?=
 =?utf-8?B?a1RNUnhSajlaSWM2T2w1Y1RRU0U4MEo2SjQ4b0tMc0RvMjJMMFcwckZZYXJi?=
 =?utf-8?B?NVJlV0pDSDBOd1VlS0RGaVAwL3dmdU1iemtlTmVOaDVMN0ROYm9rV2tsZWR2?=
 =?utf-8?B?YmR6UGhBc0F4RCtyZDNPTk81NzVlMldDVVlxQkNBZFdpUHVwN3psUnFQTTBI?=
 =?utf-8?B?cGtINmE0SUp4Nm4wQ1h2VC81dC9KcEdNOG93ZGhwN0Z4UkoyeTU4amF2bVV0?=
 =?utf-8?B?TU9WZDl5MU9xTUErWHpucXB1NXltbThsTWU3R25rd29XN2wwcTdDOURBKzJO?=
 =?utf-8?B?bW41Nk00STVxQVVDSUFUYkFBN2t5UFNFdGZhbm91STNRZWZITEhlOHFISWJl?=
 =?utf-8?B?V05PQWRFN2xFSDZqZUtISm8wQk55TVhrRTJsKzN4azZuQjVMaDJhTnArNEJS?=
 =?utf-8?B?MWFGT0JzS1VRRVpDVE1QTVVlajl6UE16SnE1emcyaFRGZG96MEdqL2p0OUZO?=
 =?utf-8?Q?LDCiMV?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:21.0026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cadedda-4788-484c-a158-08dd5b2f8519
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7519

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


