Return-Path: <bpf+bounces-19554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC8D82E201
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 21:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1066282786
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5D1AAD4;
	Mon, 15 Jan 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="idckLaz/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0A199D9;
	Mon, 15 Jan 2024 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705352156; x=1736888156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/qeeJ+nITIu9hGaXfOfTxIri+4ngUdv4zcBq9AUD1U=;
  b=idckLaz/ZaeLXa/ycTIMRBzH/bkpdoZbEkVcV1sK4PcNnDnX9RxoDid9
   pSlmZZkB6OrSODFiKkr0mQ5efljXDpkDF/RXNehpQj9GSiyb8C2aYZ/3G
   13rvAVnzCje6hUC+fGQgfN6arvQr2du+ZNuvr90/U+GDXsiiQasL10FFD
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,197,1695686400"; 
   d="scan'208";a="627772203"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 20:55:54 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id 84A9C80525;
	Mon, 15 Jan 2024 20:55:52 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:57878]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.54:2525] with esmtp (Farcaster)
 id 71b7d2f6-1fdf-46ee-9e47-363a1f4d1868; Mon, 15 Jan 2024 20:55:51 +0000 (UTC)
X-Farcaster-Flow-ID: 71b7d2f6-1fdf-46ee-9e47-363a1f4d1868
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:55:51 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:55:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v8 bpf-next 1/6] tcp: Move tcp_ns_to_ts() to tcp.h
Date: Mon, 15 Jan 2024 12:55:09 -0800
Message-ID: <20240115205514.68364-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240115205514.68364-1-kuniyu@amazon.com>
References: <20240115205514.68364-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 9 +++++++++
 net/ipv4/syncookies.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dd78a1181031..114000e71a46 100644
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


