Return-Path: <bpf+bounces-15426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415937F203E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DE6B21A10
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF439864;
	Mon, 20 Nov 2023 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VJ2T0ZLT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C3D8;
	Mon, 20 Nov 2023 14:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700519157; x=1732055157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jlKUJrk73Mv3zbApSPHD3+Zd4V9jyvSXYH68b7XnrhQ=;
  b=VJ2T0ZLTsBTcQnRsGHW6uOcnPV7j9w85wZ5+GgUwAvH6dktaZb1rI/5s
   vbw53E9/PquJdFbDwBtHqGtD5b+S0cTudaLB6zkcR6Q1q72wr6kJrVTa4
   MWxevpoDjqpUGkBHBc1tKk0H4IoN58BzYKiI/Pefp+6XD1qgOU0VCl/jQ
   A=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="45067081"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:25:52 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 183CB803D4;
	Mon, 20 Nov 2023 22:25:51 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:2843]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id 9ed75e44-0066-4fb0-b8c0-8adfe43469a5; Mon, 20 Nov 2023 22:25:50 +0000 (UTC)
X-Farcaster-Flow-ID: 9ed75e44-0066-4fb0-b8c0-8adfe43469a5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:25:42 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 20 Nov 2023 22:25:38 +0000
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
Subject: [PATCH v2 bpf-next 04/11] tcp: Don't pass cookie to __cookie_v[46]_check().
Date: Mon, 20 Nov 2023 14:23:34 -0800
Message-ID: <20231120222341.54776-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

tcp_hdr(skb) and SYN Cookie are passed to __cookie_v[46]_check(), but
none of the callers passes cookie other than ntohl(th->ack_seq) - 1.

Let's fetch it in __cookie_v[46]_check() instead of passing the cookie
over and over.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/netfilter_ipv6.h   |  8 ++++----
 include/net/tcp.h                |  6 ++----
 net/core/filter.c                | 15 ++++-----------
 net/ipv4/syncookies.c            | 15 ++++++++-------
 net/ipv6/syncookies.c            | 15 ++++++++-------
 net/netfilter/nf_synproxy_core.c |  4 ++--
 6 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/include/linux/netfilter_ipv6.h b/include/linux/netfilter_ipv6.h
index 7834c0be2831..61aa48f46dd7 100644
--- a/include/linux/netfilter_ipv6.h
+++ b/include/linux/netfilter_ipv6.h
@@ -51,7 +51,7 @@ struct nf_ipv6_ops {
 	u32 (*cookie_init_sequence)(const struct ipv6hdr *iph,
 				    const struct tcphdr *th, u16 *mssp);
 	int (*cookie_v6_check)(const struct ipv6hdr *iph,
-			       const struct tcphdr *th, __u32 cookie);
+			       const struct tcphdr *th);
 #endif
 	void (*route_input)(struct sk_buff *skb);
 	int (*fragment)(struct net *net, struct sock *sk, struct sk_buff *skb,
@@ -179,16 +179,16 @@ static inline u32 nf_ipv6_cookie_init_sequence(const struct ipv6hdr *iph,
 }
 
 static inline int nf_cookie_v6_check(const struct ipv6hdr *iph,
-				     const struct tcphdr *th, __u32 cookie)
+				     const struct tcphdr *th)
 {
 #if IS_ENABLED(CONFIG_SYN_COOKIES)
 #if IS_MODULE(CONFIG_IPV6)
 	const struct nf_ipv6_ops *v6_ops = nf_get_ipv6_ops();
 
 	if (v6_ops)
-		return v6_ops->cookie_v6_check(iph, th, cookie);
+		return v6_ops->cookie_v6_check(iph, th);
 #elif IS_BUILTIN(CONFIG_IPV6)
-	return __cookie_v6_check(iph, th, cookie);
+	return __cookie_v6_check(iph, th);
 #endif
 #endif
 	return 0;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index d2f0736b76b8..2b2c79c7bbcd 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -491,8 +491,7 @@ void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb);
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
 				 struct dst_entry *dst, u32 tsoff);
-int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th,
-		      u32 cookie);
+int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    const struct tcp_request_sock_ops *af_ops,
@@ -586,8 +585,7 @@ bool cookie_ecn_ok(const struct tcp_options_received *opt,
 		   const struct net *net, const struct dst_entry *dst);
 
 /* From net/ipv6/syncookies.c */
-int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th,
-		      u32 cookie);
+int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
 
 u32 __cookie_v6_init_sequence(const struct ipv6hdr *iph,
diff --git a/net/core/filter.c b/net/core/filter.c
index 383f96b0a1c7..d64baa7ac6cd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7229,7 +7229,6 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 	   struct tcphdr *, th, u32, th_len)
 {
 #ifdef CONFIG_SYN_COOKIES
-	u32 cookie;
 	int ret;
 
 	if (unlikely(!sk || th_len < sizeof(*th)))
@@ -7251,8 +7250,6 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 	if (tcp_synq_no_recent_overflow(sk))
 		return -ENOENT;
 
-	cookie = ntohl(th->ack_seq) - 1;
-
 	/* Both struct iphdr and struct ipv6hdr have the version field at the
 	 * same offset so we can cast to the shorter header (struct iphdr).
 	 */
@@ -7261,7 +7258,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 		if (sk->sk_family == AF_INET6 && ipv6_only_sock(sk))
 			return -EINVAL;
 
-		ret = __cookie_v4_check((struct iphdr *)iph, th, cookie);
+		ret = __cookie_v4_check((struct iphdr *)iph, th);
 		break;
 
 #if IS_BUILTIN(CONFIG_IPV6)
@@ -7272,7 +7269,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 		if (sk->sk_family != AF_INET6)
 			return -EINVAL;
 
-		ret = __cookie_v6_check((struct ipv6hdr *)iph, th, cookie);
+		ret = __cookie_v6_check((struct ipv6hdr *)iph, th);
 		break;
 #endif /* CONFIG_IPV6 */
 
@@ -7725,9 +7722,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv6_proto = {
 BPF_CALL_2(bpf_tcp_raw_check_syncookie_ipv4, struct iphdr *, iph,
 	   struct tcphdr *, th)
 {
-	u32 cookie = ntohl(th->ack_seq) - 1;
-
-	if (__cookie_v4_check(iph, th, cookie) > 0)
+	if (__cookie_v4_check(iph, th) > 0)
 		return 0;
 
 	return -EACCES;
@@ -7748,9 +7743,7 @@ BPF_CALL_2(bpf_tcp_raw_check_syncookie_ipv6, struct ipv6hdr *, iph,
 	   struct tcphdr *, th)
 {
 #if IS_BUILTIN(CONFIG_IPV6)
-	u32 cookie = ntohl(th->ack_seq) - 1;
-
-	if (__cookie_v6_check(iph, th, cookie) > 0)
+	if (__cookie_v6_check(iph, th) > 0)
 		return 0;
 
 	return -EACCES;
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 8b7d7d7788af..c08428d63d11 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -189,12 +189,14 @@ __u32 cookie_v4_init_sequence(const struct sk_buff *skb, __u16 *mssp)
  * Check if a ack sequence number is a valid syncookie.
  * Return the decoded mss if it is, or 0 if not.
  */
-int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th,
-		      u32 cookie)
+int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th)
 {
+	__u32 cookie = ntohl(th->ack_seq) - 1;
 	__u32 seq = ntohl(th->seq) - 1;
-	__u32 mssind = check_tcp_syn_cookie(cookie, iph->saddr, iph->daddr,
-					    th->source, th->dest, seq);
+	__u32 mssind;
+
+	mssind = check_tcp_syn_cookie(cookie, iph->saddr, iph->daddr,
+				      th->source, th->dest, seq);
 
 	return mssind < ARRAY_SIZE(msstab) ? msstab[mssind] : 0;
 }
@@ -332,7 +334,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 {
 	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
 	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
 	struct tcp_options_received tcp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
@@ -354,7 +355,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (tcp_synq_no_recent_overflow(sk))
 		goto out;
 
-	mss = __cookie_v4_check(ip_hdr(skb), th, cookie);
+	mss = __cookie_v4_check(ip_hdr(skb), th);
 	if (mss == 0) {
 		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
@@ -384,7 +385,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
 	treq->rcv_isn		= ntohl(th->seq) - 1;
-	treq->snt_isn		= cookie;
+	treq->snt_isn		= ntohl(th->ack_seq) - 1;
 	treq->ts_off		= 0;
 	treq->txhash		= net_tx_rndhash();
 	req->mss		= mss;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 106376cbc9de..4cd26c481168 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -114,12 +114,14 @@ __u32 cookie_v6_init_sequence(const struct sk_buff *skb, __u16 *mssp)
 	return __cookie_v6_init_sequence(iph, th, mssp);
 }
 
-int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th,
-		      __u32 cookie)
+int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th)
 {
+	__u32 cookie = ntohl(th->ack_seq) - 1;
 	__u32 seq = ntohl(th->seq) - 1;
-	__u32 mssind = check_tcp_syn_cookie(cookie, &iph->saddr, &iph->daddr,
-					    th->source, th->dest, seq);
+	__u32 mssind;
+
+	mssind = check_tcp_syn_cookie(cookie, &iph->saddr, &iph->daddr,
+				      th->source, th->dest, seq);
 
 	return mssind < ARRAY_SIZE(msstab) ? msstab[mssind] : 0;
 }
@@ -128,7 +130,6 @@ EXPORT_SYMBOL_GPL(__cookie_v6_check);
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct tcp_options_received tcp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -150,7 +151,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (tcp_synq_no_recent_overflow(sk))
 		goto out;
 
-	mss = __cookie_v6_check(ipv6_hdr(skb), th, cookie);
+	mss = __cookie_v6_check(ipv6_hdr(skb), th);
 	if (mss == 0) {
 		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
@@ -213,7 +214,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
 	treq->snt_synack	= 0;
 	treq->rcv_isn = ntohl(th->seq) - 1;
-	treq->snt_isn = cookie;
+	treq->snt_isn = ntohl(th->ack_seq) - 1;
 	treq->ts_off = 0;
 	treq->txhash = net_tx_rndhash();
 
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 467671f2d42f..fbbc4fd37349 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -617,7 +617,7 @@ synproxy_recv_client_ack(struct net *net,
 	struct synproxy_net *snet = synproxy_pernet(net);
 	int mss;
 
-	mss = __cookie_v4_check(ip_hdr(skb), th, ntohl(th->ack_seq) - 1);
+	mss = __cookie_v4_check(ip_hdr(skb), th);
 	if (mss == 0) {
 		this_cpu_inc(snet->stats->cookie_invalid);
 		return false;
@@ -1034,7 +1034,7 @@ synproxy_recv_client_ack_ipv6(struct net *net,
 	struct synproxy_net *snet = synproxy_pernet(net);
 	int mss;
 
-	mss = nf_cookie_v6_check(ipv6_hdr(skb), th, ntohl(th->ack_seq) - 1);
+	mss = nf_cookie_v6_check(ipv6_hdr(skb), th);
 	if (mss == 0) {
 		this_cpu_inc(snet->stats->cookie_invalid);
 		return false;
-- 
2.30.2


