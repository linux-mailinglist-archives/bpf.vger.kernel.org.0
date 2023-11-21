Return-Path: <bpf+bounces-15572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F177F3650
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A591C20D68
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533EF2209C;
	Tue, 21 Nov 2023 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kh03OHwo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7333CB;
	Tue, 21 Nov 2023 10:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700592210; x=1732128210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0Dzozr/kVc8IJh5icMBhMQjmf7I4hZmQKcdHxwevzc=;
  b=Kh03OHwoPvZmtM5PoODnEyN8RNspVPsOZmzeDYxUKi2lUjFsNbEjxOLI
   wOPTCZWGVvgOPNOsN+ThJGiRZjJqPpZgo1J5Wkm1kbfaDxVTTSut/JUJU
   wTOFvVt6MwwEVQU7gylf0XnMmfJLKa80kps3wgsscBBwk/ejvpjJ7HM60
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,216,1695686400"; 
   d="scan'208";a="617450909"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:43:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 8504B80795;
	Tue, 21 Nov 2023 18:43:24 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:35888]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.2:2525] with esmtp (Farcaster)
 id 5cd57399-a886-42c3-892b-5aceb633d488; Tue, 21 Nov 2023 18:43:24 +0000 (UTC)
X-Farcaster-Flow-ID: 5cd57399-a886-42c3-892b-5aceb633d488
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:43:23 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:43:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v3 bpf-next 01/11] tcp: Clean up reverse xmas tree in cookie_v[46]_check().
Date: Tue, 21 Nov 2023 10:42:35 -0800
Message-ID: <20231121184245.69569-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231121184245.69569-1-kuniyu@amazon.com>
References: <20231121184245.69569-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.30]
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will grow and cut the xmas tree in cookie_v[46]_check().
This patch cleans it up to make later patches tidy.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/syncookies.c | 10 +++++-----
 net/ipv6/syncookies.c | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index d37282c06e3d..a0118ea76734 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -331,18 +331,18 @@ EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 {
 	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
+	const struct tcphdr *th = tcp_hdr(skb);
+	__u32 cookie = ntohl(th->ack_seq) - 1;
 	struct tcp_options_received tcp_opt;
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
-	struct tcp_sock *tp = tcp_sk(sk);
-	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
-	struct sock *ret = sk;
 	struct request_sock *req;
+	struct sock *ret = sk;
 	int full_space, mss;
+	struct flowi4 fl4;
 	struct rtable *rt;
 	__u8 rcv_wscale;
-	struct flowi4 fl4;
 	u32 tsoff = 0;
 	int l3index;
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 12eedc6ca2cc..aa5fb5486cde 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -127,17 +127,17 @@ EXPORT_SYMBOL_GPL(__cookie_v6_check);
 
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 {
+	const struct tcphdr *th = tcp_hdr(skb);
+	__u32 cookie = ntohl(th->ack_seq) - 1;
+	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct tcp_options_received tcp_opt;
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
-	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct tcp_sock *tp = tcp_sk(sk);
-	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
-	struct sock *ret = sk;
 	struct request_sock *req;
-	int full_space, mss;
 	struct dst_entry *dst;
+	struct sock *ret = sk;
+	int full_space, mss;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
 	int l3index;
-- 
2.30.2


