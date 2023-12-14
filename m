Return-Path: <bpf+bounces-17845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001F381355C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94C10B20C57
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B915E0A5;
	Thu, 14 Dec 2023 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u1Oo3omk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC2E8;
	Thu, 14 Dec 2023 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702569314; x=1734105314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7wmKmdaMBtvgkg9INuHzDnHxJd3l7VIHvc9Dvx5C90A=;
  b=u1Oo3omks9yvY/pHbBNjCIPES2o0PbGSqzd2rHZRK8PnkWttRgJHR8Dh
   dpqNMvNrtXIpM2SAXwS2foIlLYUBXC9xUjmA7k/rcT3D4uKuOXIWWykE1
   AxWLgy5oAzWKh+jMqYnw8JllIE2HwkxKlorwli19TqWzFwN4BgLtCP1sV
   I=;
X-IronPort-AV: E=Sophos;i="6.04,275,1695686400"; 
   d="scan'208";a="259756580"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:55:11 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id A336780C81;
	Thu, 14 Dec 2023 15:55:09 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:60938]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.147:2525] with esmtp (Farcaster)
 id 2bf03bff-de0f-4dee-8452-8917a9a43b03; Thu, 14 Dec 2023 15:55:08 +0000 (UTC)
X-Farcaster-Flow-ID: 2bf03bff-de0f-4dee-8452-8917a9a43b03
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:55:08 +0000
Received: from 88665a182662.ant.amazon.com (10.143.92.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:55:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v6 bpf-next 1/6] tcp: Move tcp_ns_to_ts() to tcp.h
Date: Fri, 15 Dec 2023 00:54:19 +0900
Message-ID: <20231214155424.67136-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214155424.67136-1-kuniyu@amazon.com>
References: <20231214155424.67136-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF.

When BPF prog validates ACK and kfunc allocates a reqsk, we need
to call tcp_ns_to_ts() to calculate an offset of TSval for later
use:

  time
  t0 : Send SYN+ACK
       -> tsval = Initial TSval (Random Number)

  t1 : Recv ACK of 3WHS
       -> tsoff = TSecr - tcp_ns_to_ts(usec_ts_ok, tcp_clock_ns())
                = Initial TSval - t1

  t2 : Send ACK
       -> tsval = t2 + tsoff
                = Initial TSval + (t2 - t1)
                = Initial TSval + Time Delta (x)

  (x) Note that the time delta does not include the initial RTT
      from t0 to t1.

Let's move tcp_ns_to_ts() to tcp.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     | 9 +++++++++
 net/ipv4/syncookies.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 973555cb1d3f..c77354d1b86d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -577,6 +577,15 @@ static inline u32 tcp_cookie_time(void)
 	return val;
 }
 
+/* Convert one nsec 64bit timestamp to ts (ms or usec resolution) */
+static inline u64 tcp_ns_to_ts(bool usec_ts, u64 val)
+{
+	if (usec_ts)
+		return div_u64(val, NSEC_PER_USEC);
+
+	return div_u64(val, NSEC_PER_MSEC);
+}
+
 u32 __cookie_v4_init_sequence(const struct iphdr *iph, const struct tcphdr *th,
 			      u16 *mssp);
 __u32 cookie_v4_init_sequence(const struct sk_buff *skb, __u16 *mss);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 61f1c96cfe63..981944c22820 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -51,15 +51,6 @@ static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
 			    count, &syncookie_secret[c]);
 }
 
-/* Convert one nsec 64bit timestamp to ts (ms or usec resolution) */
-static u64 tcp_ns_to_ts(bool usec_ts, u64 val)
-{
-	if (usec_ts)
-		return div_u64(val, NSEC_PER_USEC);
-
-	return div_u64(val, NSEC_PER_MSEC);
-}
-
 /*
  * when syncookies are in effect and tcp timestamps are enabled we encode
  * tcp options in the lower bits of the timestamp value that will be
-- 
2.30.2


