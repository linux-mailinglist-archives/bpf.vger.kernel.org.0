Return-Path: <bpf+bounces-53187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BA6A4E3CB
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A6F8A23CD
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1C2857F8;
	Tue,  4 Mar 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VyCDqo+7"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2062.outbound.protection.outlook.com [40.107.103.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4A284B43;
	Tue,  4 Mar 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101381; cv=fail; b=uZ4HOh3+x6p5fSHP5gsPzi498uTXtaWpxVvIHf9/amDbVy/H38nmuU3Jez6opn0BYyvAHB+0E6CPFOgSSFEA3HR6n1emm3GPLL9PiqUKZKkpyMw4yEaUveBGVPZDP2Gf4XB3qIgmv3dO4DBoe5BcmmuY8k26t9HuNLQi/1W7F6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101381; c=relaxed/simple;
	bh=+ARu58x8s13+TcFCn58qW5AlwIEfzHsxB3c3plCyDaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqnbW4WegwiDQ1HxGOkiUou56Xto2X3bP7IRUqzPcgYFrjjSAgW+SJLSGhAy/2woVIj+FNh5rUOub09mVxYhpnI2njdKX6BQBGz9VnG0EwAAolT3iAG1/dP2UYh/3jQqFLCuv+For1HMAJcYG9TWjybxngaidZk3QltRygHgwTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VyCDqo+7; arc=fail smtp.client-ip=40.107.103.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKrPt7L7yLn43uPaxqRiFcfDjyenCe/5dCniKfX3c1fW5x3z+qNjj2dO0jbBW627PylKbgeZpVaKxPG2w4xeQl+FV8w/lnsapCciw0eRxxd+6f2sw8sA253g+hmZ58GfEV41K0iRlgXLNFtP/xjfCPWVDkPKWAFBJ0etxBuKfxT3EZl7q/JLxR+2T3+0fAgIJQwiYDEgcsYfBuG/s/LATQMVrjP7Nk4F8SXah71VT1cYC5OkF/9RLadDN2i9bHp01cEmrDvhQIzVceXEMoPJ+1BCZzo1KMp3wuEMol6I+M4ypOQz1qhqbmNlqAK2dPpACkoy4kPE+WCOC/PUEhEKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P7pGyCPHjKrPFWpZP9X6L+e4wDkYsQD65Q6r5MyWLw=;
 b=qMw6TwxgpcdKZq+RGU/OZvTEOpkgZE0tdVNq/H10OaiwGMMhStGX6yOi+3tEBX/qfGDXeSGSbZS4d6iTbcoT6J9OZs1K2r5KW+R4POTDqhvlK7eesMMDCkCCWfZbVoiq4u/hV1LzUJlpr8l/CZ+nH7knFkr+ADRZuCMs393zyhDSCCiK2Ce4tdIIxdUstZaYeDmc8g5/7hok3jStw7P/ZU1cqIGO2PMBNW64tX4ptd9FTO1YA7ZC8ybufgQoPaQ6hwBBI0PLaQP3dRV1yM5d4/0u6twvc17n4DwY9x3MBlND1tOS53euJMrCJeGqsvnR5Wt9LC7GAiHbhLJZHQdCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P7pGyCPHjKrPFWpZP9X6L+e4wDkYsQD65Q6r5MyWLw=;
 b=VyCDqo+7qIXNmReb/crr1X/jLId3ODQ0+c6xtgYqMA72gfvSeBhiT7fJ0Je/n9f2yd7gCm9P2sc6Bsob2PplO7JPDmMNYA0W9eY3uTg744CF7Jhefo6D9hx8TOLE8xoFrmi2TAQBX0GRsGNw/xIsZXQ5n0WOQbATsvu9PuRhI27wc/tiZdAG6FKAfUxT62+lwoIOn5AngT5DEXcVVfRRR7DUFOfYsnufZswemykI2ESHoMRQxfonWX6toVOcWOtLBO3uVCWosmeKnXbsTik77kVWTbwDrCmfM4t0A5CKLQLY21B8DHt9zb829poCnpS8VBf7gQfRBvp4CWcG2pY4xA==
Received: from AM9P193CA0021.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::26)
 by AS8PR07MB9474.eurprd07.prod.outlook.com (2603:10a6:20b:633::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:16:14 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::7d) by AM9P193CA0021.outlook.office365.com
 (2603:10a6:20b:21e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 15:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Tue, 4 Mar 2025 15:16:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8CCFE24DA2;
	Tue,  4 Mar 2025 17:16:12 +0200 (EET)
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
Date: Tue,  4 Mar 2025 16:16:00 +0100
Message-Id: <20250304151607.77950-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|AS8PR07MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fa8b29-5c8e-42c4-3de6-08dd5b2f8100
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eDhFUUxvUk9NdUNkcVdvY1dESUdnTHY0ZGRUdmlDTVAyYml0bVUzR0R0emFQ?=
 =?utf-8?B?SWFNZWc2WndDbVhFNTYxajZPanN5eHZoR21QWXdVYUwzbVlZRUNTdUdOVmt0?=
 =?utf-8?B?UXBVdUFxUlBvZFBmZDFHakNGMmdlQmdtTWpaNHNibThpajZVaEljSzcrZzlC?=
 =?utf-8?B?Tm5qendTS1JxdUhiU2ZLZ0NtOUxZZmxpd3A1bndPNUxoaUt2eWpabXFoQ1ZU?=
 =?utf-8?B?amF4ZC95V3dTMjh1UDA2cnpPK0NndVNFK29OWlBMR2VYOHkzbXhKemdKMlhm?=
 =?utf-8?B?bWI0OWUvZGFxRGxwTHFYRWJ3cnoxclpQczg2bTlOeWN3UFVEZFlKZk5ETmd1?=
 =?utf-8?B?djk0SkxkVlQ5ZmF1RHhSdzdsWk5ULzN5MC94WElBM08vdURpWWZMQ2hmMXYv?=
 =?utf-8?B?L0NWRm5QN3BTWGNxZ014N1E1WDduT3psVG56OEsydXp5QjduUm82b0xVSVR3?=
 =?utf-8?B?ZXNERldpaWtkVDlXV0tBQ0JiQ0hJNVlqaTFBOUhlK0h2c3VlVG9JWHhzMkIw?=
 =?utf-8?B?RHY0RllMcFd0Ryt5czVQZS9mSVYycHRUTy9FZG90UDRtbDEyS01XWmllR1lP?=
 =?utf-8?B?d2dTSlRJenFjQ2tJTUp3K01kNlVMYVRsVldKc3ZGNnRqeHJoVnhlRGNXTUhs?=
 =?utf-8?B?SmQ4eUQvOFhSMUxNNy9Zd3FvZGZSMG1aVjRrckcwU2FQM3NVSjlkK2JRWTJw?=
 =?utf-8?B?L3pFdjAwSE5YamJnYytMZW10Y1RHczBuVlk5L3RudmN2ejhjTTJIUVQ2UFg2?=
 =?utf-8?B?bUgrTzI4QWFqLytJWTZ6YVRyalc5SkpzeThDZ29DckhZOEU0Q01uMlhWSTZN?=
 =?utf-8?B?RkNNaCtKcEY4dXpQYVJSdzRxQ3RzcHpwWWVOY2l2a0NhbkpJclZKTFI5TFpO?=
 =?utf-8?B?dGtzenQrSW5Hd1ZZa1BzTmN3cmVxb2NHNXZaV1NBL1JGTk91bTZBd3lQbWZy?=
 =?utf-8?B?eGl1VWgxVklIdHM4UU5kMDNlbGd4TkFwR2ZyRjd1ejRYMFl0OWpwRjRBRWwr?=
 =?utf-8?B?aENGNTJxYklySUx3cTlFT3ZNK0FDaEpGYy9FTXIxZld2bDlYaWk1L0R0RGJ0?=
 =?utf-8?B?aUd2NzAxMmVrRVlXTTQzNTZOQjhoQlgyKzM1djJ3REFSOWc2akpCdlVwcllS?=
 =?utf-8?B?UEZrV3pKSUFJTXY1d08wbVhoRVFUYWZwWmJHMmY0Mm1ldHJFZXRuZm5Xa2RM?=
 =?utf-8?B?Ti85eFYzVk4rSXU1MldoeHFwbGJ4R0Rwb2pIVWhMVHl5dVdHWlVER2QrL0FX?=
 =?utf-8?B?RHlNTmxJaitybGVEbHJaZ0JjSTdSc3hMVi9xc25CaldxWE8rTy92NFhqNWRw?=
 =?utf-8?B?Tkhib0N0MWw4Z2lzWm9DamRQRmZRTWx2K0IvOHR0QUpCU1YzendWU1NGaDBV?=
 =?utf-8?B?aktuVStoaXp3SnA5NVNIQ0ZRdTFNTVF1WUduemlqRUZoeWt4T1JmVk50eXFP?=
 =?utf-8?B?YllsNTN2MHZaM2s0ZEVOSzM0R1ROOXEwbUlpTzFLMXlIU3I2WmtsZnErRGFR?=
 =?utf-8?B?UkM5TGVSWDlFZC9XZEV5MHA4VGN0cW55UFFmZWtkeEI5ZGxySTAvLzFuMjBj?=
 =?utf-8?B?eE1KWGlRSk5pT29ZTlZLT3JYYmNzaytqV3J6NlhnLzZHUlFFWlVzZ2taV1Rs?=
 =?utf-8?B?OUJrVDRqdHJkZzlXM25TUnRpa0g1UEJOaGhSMXVyRVhCYmRHK0FMTVBhWXg1?=
 =?utf-8?B?VXdXSGZROGc2K2o0dlB5bEVQWnRmU2liL3N4TUZtSnkwSm1kN1FMZFhvTENW?=
 =?utf-8?B?RWJzZ2kvck5ubDZCQVExYnE0eUwzejBFNEhYcTJjMTJSblVaTzhwakpPbTV6?=
 =?utf-8?B?c2ZhODhVWjF0bGhZRFV2NjZwSmEwSml4Z1hVc1VldXdaZFVBLzJqSWJzbnRh?=
 =?utf-8?B?aTU4NC9TV1RDWEpEejR1a0JhdHJvd281Wi9qTFUxUmhoc0NiL0VPS1JUMFpU?=
 =?utf-8?B?aS9qcGhnRG9nTENvMVVGTVI0dFVrVHo5VGN5ZGRsM1AzSWprNWQ4WDBKVjhW?=
 =?utf-8?B?eTJXVzdROStxano1blQwSDlQYUVEV3hEQ1N2V296TjUwT1N3d1kzUXNQV256?=
 =?utf-8?Q?gPEc4m?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:14.1564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fa8b29-5c8e-42c4-3de6-08dd5b2f8100
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9474

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


