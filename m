Return-Path: <bpf+bounces-15428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F97F2042
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0621C20D80
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A439FD2;
	Mon, 20 Nov 2023 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jE8nlfzM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C36DA2;
	Mon, 20 Nov 2023 14:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700519209; x=1732055209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GE1NGt33UkveFcasoYOwExD3r8TqRfqQ+Y3LDNLMYy8=;
  b=jE8nlfzMf2yrRtFNC95l1Ab9TAC4iNUqnLZnn+r9mUtXfaUWzIzxYI1+
   6gbUjX5esd9l1eWkdZZY+7ln4sLwZD/9HLTxfC9OfuFkdWpRGxvekOKUt
   Ey9rXSVjTfm85261xazWxlQqm158CCo7/AIZANQj8Q5O3VaglrcfzGTNC
   I=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="617190399"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:26:40 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com (Postfix) with ESMTPS id 78C85A0992;
	Mon, 20 Nov 2023 22:26:35 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:53038]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.2:2525] with esmtp (Farcaster)
 id 5aac473f-44a5-4b29-bde7-a12a0067d238; Mon, 20 Nov 2023 22:26:34 +0000 (UTC)
X-Farcaster-Flow-ID: 5aac473f-44a5-4b29-bde7-a12a0067d238
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:26:34 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:26:30 +0000
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
Subject: [PATCH v2 bpf-next 06/11] tcp: Move TCP-AO bits from cookie_v[46]_check() to tcp_ao_syncookie().
Date: Mon, 20 Nov 2023 14:23:36 -0800
Message-ID: <20231120222341.54776-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120222341.54776-1-kuniyu@amazon.com>
References: <20231120222341.54776-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.26]
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We initialise treq->af_specific in cookie_tcp_reqsk_alloc() so that
we can look up a key later in tcp_create_openreq_child().

Initially, that change was added for MD5 by commit ba5a4fdd63ae ("tcp:
make sure treq->af_specific is initialized"), but it has not been used
since commit d0f2b7a9ca0a ("tcp: Disable header prediction for MD5
flow.").

Now, treq->af_specific is used only by TCP-AO, so, we can move that
initialisation into tcp_ao_syncookie().

In addition to that, l3index in cookie_v[46]_check() is only used for
tcp_ao_syncookie(), so let's move it as well.

While at it, we move down tcp_ao_syncookie() in cookie_v4_check() so
that it will be called after security_inet_conn_request() to make
functions order consistent with cookie_v6_check().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     |  1 -
 include/net/tcp_ao.h  |  6 ++----
 net/ipv4/syncookies.c | 16 ++++------------
 net/ipv4/tcp_ao.c     | 16 ++++++++++++++--
 net/ipv6/syncookies.c |  7 ++-----
 5 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index cc7143a781da..d4d0e9763175 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -494,7 +494,6 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
-					    const struct tcp_request_sock_ops *af_ops,
 					    struct sock *sk, struct sk_buff *skb);
 #ifdef CONFIG_SYN_COOKIES
 
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index b56be10838f0..4d900ef8dfc3 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -265,8 +265,7 @@ void tcp_ao_established(struct sock *sk);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
-		      struct tcp_request_sock *treq,
-		      unsigned short int family, int l3index);
+		      struct request_sock *req, unsigned short int family);
 #else /* CONFIG_TCP_AO */
 
 static inline int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
@@ -277,8 +276,7 @@ static inline int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 }
 
 static inline void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
-				    struct tcp_request_sock *treq,
-				    unsigned short int family, int l3index)
+				    struct request_sock *req, unsigned short int family)
 {
 }
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index de051eb08db8..1e3783c97e28 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -286,9 +286,7 @@ bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
 EXPORT_SYMBOL(cookie_ecn_ok);
 
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
-					    const struct tcp_request_sock_ops *af_ops,
-					    struct sock *sk,
-					    struct sk_buff *skb)
+					    struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_request_sock *treq;
 	struct request_sock *req;
@@ -303,9 +301,6 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 
 	treq = tcp_rsk(req);
 
-	/* treq->af_specific might be used to perform TCP_MD5 lookup */
-	treq->af_specific = af_ops;
-
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 	treq->req_usec_ts = false;
 
@@ -345,7 +340,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct rtable *rt;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
-	int l3index;
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -376,8 +370,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops,
-				     &tcp_request_sock_ipv4_ops, sk, skb);
+	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops, sk, skb);
 	if (!req)
 		goto out_drop;
 
@@ -406,9 +399,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
 
-	l3index = l3mdev_master_ifindex_by_index(net, ireq->ir_iif);
-	tcp_ao_syncookie(sk, skb, treq, AF_INET, l3index);
-
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
 	 */
@@ -417,6 +407,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (security_inet_conn_request(sk, skb, req))
 		goto out_free;
 
+	tcp_ao_syncookie(sk, skb, req, AF_INET);
+
 	req->num_retrans = 0;
 
 	/*
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 7696417d0640..c4cd1e09eb6b 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -844,18 +844,30 @@ static struct tcp_ao_key *tcp_ao_inbound_lookup(unsigned short int family,
 }
 
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
-		      struct tcp_request_sock *treq,
-		      unsigned short int family, int l3index)
+		      struct request_sock *req, unsigned short int family)
 {
+	struct tcp_request_sock *treq = tcp_rsk(req);
 	const struct tcphdr *th = tcp_hdr(skb);
 	const struct tcp_ao_hdr *aoh;
 	struct tcp_ao_key *key;
+	int l3index;
+
+	/* treq->af_specific is used to perform TCP_AO lookup
+	 * in tcp_create_openreq_child().
+	 */
+#if IS_ENABLED(CONFIG_IPV6)
+	if (family == AF_INET6)
+		treq->af_specific = &tcp_request_sock_ipv6_ops;
+	else
+#endif
+		treq->af_specific = &tcp_request_sock_ipv4_ops;
 
 	treq->maclen = 0;
 
 	if (tcp_parse_auth_options(th, NULL, &aoh) || !aoh)
 		return;
 
+	l3index = l3mdev_master_ifindex_by_index(sock_net(sk), inet_rsk(req)->ir_iif);
 	key = tcp_ao_inbound_lookup(family, sk, skb, -1, aoh->keyid, l3index);
 	if (!key)
 		/* Key not found, continue without TCP-AO */
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 18c2e3c1677b..12b1809245f9 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -142,7 +142,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	int full_space, mss;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
-	int l3index;
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -173,8 +172,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops,
-				     &tcp_request_sock_ipv6_ops, sk, skb);
+	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops, sk, skb);
 	if (!req)
 		goto out_drop;
 
@@ -218,8 +216,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->ts_off = tsoff;
 	treq->txhash = net_tx_rndhash();
 
-	l3index = l3mdev_master_ifindex_by_index(net, ireq->ir_iif);
-	tcp_ao_syncookie(sk, skb, treq, AF_INET6, l3index);
+	tcp_ao_syncookie(sk, skb, req, AF_INET6);
 
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok = 0;
-- 
2.30.2


