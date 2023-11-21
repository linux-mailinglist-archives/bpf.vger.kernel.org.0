Return-Path: <bpf+bounces-15579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D47F366E
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7136EB21BE8
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8D524C3;
	Tue, 21 Nov 2023 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I2Ko2Ojy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB73D1;
	Tue, 21 Nov 2023 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700592389; x=1732128389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/IDCn4vk4hlNpIMmgf+NBEzfSAq/I2fBO/TCBRwaARI=;
  b=I2Ko2Ojy2pnDl8Nbg2GcpiALSWX+tg8xvnR4+fkQ9H7k28MgAhIq1nlu
   uLA6enM2YQBWmS9nj4a4stYhtPE8HdLEgN5xgoXnh2RQRtrR1Ax9v0ow0
   U6LHJuYw22Z7ek5l7g8EC+y+y9Av0l/sXyZtNrBO/KbjBxdrcecXOqt3d
   g=;
X-IronPort-AV: E=Sophos;i="6.04,216,1695686400"; 
   d="scan'208";a="685614594"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:46:23 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com (Postfix) with ESMTPS id 411BEA0A87;
	Tue, 21 Nov 2023 18:46:21 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:52287]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.37:2525] with esmtp (Farcaster)
 id 250b4bf4-ade9-4f19-bc96-fe0025400452; Tue, 21 Nov 2023 18:46:20 +0000 (UTC)
X-Farcaster-Flow-ID: 250b4bf4-ade9-4f19-bc96-fe0025400452
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:46:20 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Tue, 21 Nov 2023 18:46:16 +0000
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
Subject: [PATCH v3 bpf-next 08/11] tcp: Factorise non-BPF SYN Cookie handling.
Date: Tue, 21 Nov 2023 10:42:42 -0800
Message-ID: <20231121184245.69569-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF, and then kfunc at
TC will preallocate reqsk and initialise some fields that should
not be overwritten later by cookie_v[46]_check().

To simplify the flow in cookie_v[46]_check(), we move such fields'
initialisation to cookie_tcp_reqsk_alloc() and factorise non-BPF
SYN Cookie handling into cookie_tcp_check(), where we validate the
cookie and allocate reqsk, as done by kfunc later.

Note that we set ireq->ecn_ok in two steps, the latter of which will
be shared by the BPF case.  As cookie_ecn_ok() is one-liner, now
it's inlined.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     |  13 ++++--
 net/ipv4/syncookies.c | 106 +++++++++++++++++++++++-------------------
 net/ipv6/syncookies.c |  61 ++++++++++++------------
 3 files changed, 99 insertions(+), 81 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d4d0e9763175..973555cb1d3f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -494,7 +494,10 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
-					    struct sock *sk, struct sk_buff *skb);
+					    struct sock *sk, struct sk_buff *skb,
+					    struct tcp_options_received *tcp_opt,
+					    int mss, u32 tsoff);
+
 #ifdef CONFIG_SYN_COOKIES
 
 /* Syncookies use a monotonic timer which increments every 60 seconds.
@@ -580,8 +583,12 @@ __u32 cookie_v4_init_sequence(const struct sk_buff *skb, __u16 *mss);
 u64 cookie_init_timestamp(struct request_sock *req, u64 now);
 bool cookie_timestamp_decode(const struct net *net,
 			     struct tcp_options_received *opt);
-bool cookie_ecn_ok(const struct tcp_options_received *opt,
-		   const struct net *net, const struct dst_entry *dst);
+
+static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *dst)
+{
+	return READ_ONCE(net->ipv4.sysctl_tcp_ecn) ||
+		dst_feature(dst, RTAX_FEATURE_ECN);
+}
 
 /* From net/ipv6/syncookies.c */
 int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 9bca1c026525..beea4d05fafc 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -270,21 +270,6 @@ bool cookie_timestamp_decode(const struct net *net,
 }
 EXPORT_SYMBOL(cookie_timestamp_decode);
 
-bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
-		   const struct net *net, const struct dst_entry *dst)
-{
-	bool ecn_ok = tcp_opt->rcv_tsecr & TS_OPT_ECN;
-
-	if (!ecn_ok)
-		return false;
-
-	if (READ_ONCE(net->ipv4.sysctl_tcp_ecn))
-		return true;
-
-	return dst_feature(dst, RTAX_FEATURE_ECN);
-}
-EXPORT_SYMBOL(cookie_ecn_ok);
-
 static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req)
 {
@@ -321,8 +306,12 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 }
 
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
-					    struct sock *sk, struct sk_buff *skb)
+					    struct sock *sk, struct sk_buff *skb,
+					    struct tcp_options_received *tcp_opt,
+					    int mss, u32 tsoff)
 {
+	struct inet_request_sock *ireq;
+	struct tcp_request_sock *treq;
 	struct request_sock *req;
 
 	if (sk_is_mptcp(sk))
@@ -338,40 +327,36 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 		return NULL;
 	}
 
+	ireq = inet_rsk(req);
+	treq = tcp_rsk(req);
+
+	req->mss = mss;
+	req->ts_recent = tcp_opt->saw_tstamp ? tcp_opt->rcv_tsval : 0;
+
+	ireq->snd_wscale = tcp_opt->snd_wscale;
+	ireq->tstamp_ok = tcp_opt->saw_tstamp;
+	ireq->sack_ok = tcp_opt->sack_ok;
+	ireq->wscale_ok = tcp_opt->wscale_ok;
+	ireq->ecn_ok = tcp_opt->rcv_tsecr & TS_OPT_ECN;
+
+	treq->ts_off = tsoff;
+
 	return req;
 }
 EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
 
-/* On input, sk is a listener.
- * Output is listener if incoming packet would not create a child
- *           NULL if memory could not be allocated.
- */
-struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
+static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
+					     struct sk_buff *skb)
 {
-	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
-	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_options_received tcp_opt;
-	struct tcp_sock *tp = tcp_sk(sk);
-	struct inet_request_sock *ireq;
-	struct net *net = sock_net(sk);
-	struct tcp_request_sock *treq;
-	struct request_sock *req;
-	struct sock *ret = sk;
-	int full_space, mss;
-	struct flowi4 fl4;
-	struct rtable *rt;
-	__u8 rcv_wscale;
 	u32 tsoff = 0;
-
-	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
-	    !th->ack || th->rst)
-		goto out;
+	int mss;
 
 	if (tcp_synq_no_recent_overflow(sk))
 		goto out;
 
-	mss = __cookie_v4_check(ip_hdr(skb), th);
-	if (mss == 0) {
+	mss = __cookie_v4_check(ip_hdr(skb), tcp_hdr(skb));
+	if (!mss) {
 		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
 	}
@@ -392,21 +377,44 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops, sk, skb);
+	return cookie_tcp_reqsk_alloc(&tcp_request_sock_ops, sk, skb,
+				      &tcp_opt, mss, tsoff);
+out:
+	return ERR_PTR(-EINVAL);
+}
+
+/* On input, sk is a listener.
+ * Output is listener if incoming packet would not create a child
+ *           NULL if memory could not be allocated.
+ */
+struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
+{
+	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
+	const struct tcphdr *th = tcp_hdr(skb);
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct inet_request_sock *ireq;
+	struct net *net = sock_net(sk);
+	struct request_sock *req;
+	struct sock *ret = sk;
+	struct flowi4 fl4;
+	struct rtable *rt;
+	__u8 rcv_wscale;
+	int full_space;
+
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
+	    !th->ack || th->rst)
+		goto out;
+
+	req = cookie_tcp_check(net, sk, skb);
+	if (IS_ERR(req))
+		goto out;
 	if (!req)
 		goto out_drop;
 
 	ireq = inet_rsk(req);
-	treq = tcp_rsk(req);
-	treq->ts_off		= tsoff;
-	req->mss		= mss;
+
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
-	ireq->snd_wscale	= tcp_opt.snd_wscale;
-	ireq->sack_ok		= tcp_opt.sack_ok;
-	ireq->wscale_ok		= tcp_opt.wscale_ok;
-	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
-	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
 
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
@@ -448,7 +456,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 				  dst_metric(&rt->dst, RTAX_INITRWND));
 
 	ireq->rcv_wscale  = rcv_wscale;
-	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, &rt->dst);
+	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index e0a9220d1536..c8d2ca27220c 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -127,31 +127,18 @@ int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th)
 }
 EXPORT_SYMBOL_GPL(__cookie_v6_check);
 
-struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
+static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
+					     struct sk_buff *skb)
 {
-	const struct tcphdr *th = tcp_hdr(skb);
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct tcp_options_received tcp_opt;
-	struct tcp_sock *tp = tcp_sk(sk);
-	struct inet_request_sock *ireq;
-	struct net *net = sock_net(sk);
-	struct tcp_request_sock *treq;
-	struct request_sock *req;
-	struct dst_entry *dst;
-	struct sock *ret = sk;
-	int full_space, mss;
-	__u8 rcv_wscale;
 	u32 tsoff = 0;
-
-	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
-	    !th->ack || th->rst)
-		goto out;
+	int mss;
 
 	if (tcp_synq_no_recent_overflow(sk))
 		goto out;
 
-	mss = __cookie_v6_check(ipv6_hdr(skb), th);
-	if (mss == 0) {
+	mss = __cookie_v6_check(ipv6_hdr(skb), tcp_hdr(skb));
+	if (!mss) {
 		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
 	}
@@ -172,14 +159,37 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops, sk, skb);
+	return cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops, sk, skb,
+				      &tcp_opt, mss, tsoff);
+out:
+	return ERR_PTR(-EINVAL);
+}
+
+struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct inet_request_sock *ireq;
+	struct net *net = sock_net(sk);
+	struct request_sock *req;
+	struct dst_entry *dst;
+	struct sock *ret = sk;
+	__u8 rcv_wscale;
+	int full_space;
+
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
+	    !th->ack || th->rst)
+		goto out;
+
+	req = cookie_tcp_check(net, sk, skb);
+	if (IS_ERR(req))
+		goto out;
 	if (!req)
 		goto out_drop;
 
 	ireq = inet_rsk(req);
-	treq = tcp_rsk(req);
 
-	req->mss = mss;
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 
@@ -198,13 +208,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	    ipv6_addr_type(&ireq->ir_v6_rmt_addr) & IPV6_ADDR_LINKLOCAL)
 		ireq->ir_iif = tcp_v6_iif(skb);
 
-	ireq->snd_wscale	= tcp_opt.snd_wscale;
-	ireq->sack_ok		= tcp_opt.sack_ok;
-	ireq->wscale_ok		= tcp_opt.wscale_ok;
-	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
-	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
-	treq->ts_off = tsoff;
-
 	tcp_ao_syncookie(sk, skb, req, AF_INET6);
 
 	/*
@@ -245,7 +248,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 				  dst_metric(dst, RTAX_INITRWND));
 
 	ireq->rcv_wscale = rcv_wscale;
-	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, dst);
+	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 out:
-- 
2.30.2


