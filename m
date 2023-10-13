Return-Path: <bpf+bounces-12192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15597C9012
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16351C21203
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD932B5F6;
	Fri, 13 Oct 2023 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rQS+p4aV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6E21A0A;
	Fri, 13 Oct 2023 22:08:41 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE4EBE;
	Fri, 13 Oct 2023 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234920; x=1728770920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vBCcXjcjRadFapyzF1H2DHpW0+quqNcW998BSAv+3kM=;
  b=rQS+p4aVMx9kDu7hwTOe09Jxmet14ubHB2I0XRoZD58pCpJ4XHYqlXzB
   4TpnkSp3HZEy0Gnuv1HqgJrwNEm/WhjH4gibJXhN2rLA9RsOvjJXQ7MeS
   NlyJ9KY/JcSdmMpLFM0nUGw/veerj0mYhLYgk8ZTHu6l3CXqcIIxq0FHM
   A=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="677654404"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:08:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 5E7FA804AF;
	Fri, 13 Oct 2023 22:08:31 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:08:30 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:08:26 +0000
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
Subject: [PATCH v1 bpf-next 08/11] bpf: tcp: Make TS available for SYN Cookie storage.
Date: Fri, 13 Oct 2023 15:04:30 -0700
Message-ID: <20231013220433.70792-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013220433.70792-1-kuniyu@amazon.com>
References: <20231013220433.70792-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.60]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF_SOCK_OPS_GEN_SYNCOOKIE_CB can now encode more information into
TS value via bpf_sock_ops.replylong[1], which will be looped back to
bpf_sock_ops.args[1] of BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB to validate.

After invoking BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook, we set 1 to
inet_rsk(req)->bpf_cookie and saves bpf_sock_ops.replylong[1] in
inet_rsk(req)->bpf_cookie_tsval.  Later in cookie_init_timestamp(),
we use bpf_cookie_tsval as TS value if bpf_cookie is 1.

Also, we set 0 to tcp_rsk(req)->ts_off so that the generated TS value is
sent as is.  This is to remove host-specific bits from SYN Cookie for
scalability.  However, ts_off is implemented to randomise TS value for
each peer for security reasons.  Thus, the TS value must look like a
random number.  For example, init TS with a random number first and use
a few bits to encode client information.

Before invoking BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB hook, we need not adjust
tcp_opt.rcv_tsecr as ts_off was 0 when sending the timestamp.  Also, we
need to initialise tcp_rsk(req)->ts_off with tcp_opt->rcv_tsecr -
tcp_ns_to_ts(tcp_clock_ns()) so that the timestamp after 3WHS will be the
initial TS + delta.

  SYN+ACK    : Initial TS

  After 3WHS : tcp_ns_to_ts(tcp_clock_ns()) + tp->tsoffset
               = tcp_ns_to_ts(tcp_clock_ns())   <-- In tcp_established_options()
                 + tcp_opt->rcv_tsecr
                 - tcp_ns_to_ts(tcp_clock_ns()) <-- When validating ACK
               = Initial TS + delta

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet_sock.h        |  4 ++-
 include/net/tcp.h              |  5 ++--
 include/uapi/linux/bpf.h       | 12 ++++++---
 net/ipv4/syncookies.c          | 45 ++++++++++++++++++++++------------
 net/ipv4/tcp_input.c           |  4 +++
 net/ipv6/syncookies.c          | 23 +++++++++--------
 tools/include/uapi/linux/bpf.h | 12 ++++++---
 7 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 98e11958cdff..19b3ddcda0f8 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -87,8 +87,10 @@ struct inet_request_sock {
 				ecn_ok	   : 1,
 				acked	   : 1,
 				no_srccheck: 1,
-				smc_ok	   : 1;
+				smc_ok	   : 1,
+				bpf_cookie : 1;
 	u32                     ir_mark;
+	u32			bpf_cookie_tsval;
 	union {
 		struct ip_options_rcu __rcu	*ireq_opt;
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 90d95acdc34a..4fe19917db6c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2161,10 +2161,11 @@ static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
 
 #ifdef CONFIG_CGROUP_BPF
 int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req,
-			   struct sk_buff *skb);
+			   struct sk_buff *skb, struct tcp_options_received *tcp_opt);
 #else
 static inline int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req,
-					 struct sk_buff *skb)
+					 struct sk_buff *skb,
+					 struct tcp_options_received *tcp_opt)
 {
 	return 0;
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e6f1507d7895..24f673d88c0d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6865,16 +6865,22 @@ enum {
 					 * earlier bpf-progs.
 					 */
 	BPF_SOCK_OPS_GEN_SYNCOOKIE_CB,	/* Generate SYN Cookie (ISN of
-					 * SYN+ACK).
+					 * SYN+ACK) and value of Timestamps
+					 * option.
 					 *
 					 * args[0]: MSS
 					 *
 					 * replylong[0]: ISN
+					 * replylong[1]: TS
+					 *
+					 * TS value must look like random
+					 * for security reasons.
 					 */
-	BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB,/* Validate SYN Cookie and set
-					 * MSS.
+	BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB,/* Validate SYN Cookie and TS and
+					 * set MSS.
 					 *
 					 * args[0]: ISN
+					 * args[1]: TS
 					 *
 					 * replylong[0]: MSS
 					 */
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index b1dd415863ff..f78566991e08 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -62,11 +62,12 @@ static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
  */
 u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 {
-	struct inet_request_sock *ireq;
-	u32 ts, ts_now = tcp_ns_to_ts(now);
-	u32 options = 0;
+	struct inet_request_sock *ireq = inet_rsk(req);
+	u32 ts, ts_now;
+	u32 options;
 
-	ireq = inet_rsk(req);
+	if (ireq->bpf_cookie)
+		return ireq->bpf_cookie_tsval * (NSEC_PER_SEC / TCP_TS_HZ);
 
 	options = ireq->wscale_ok ? ireq->snd_wscale : TS_OPT_WSCALE_MASK;
 	if (ireq->sack_ok)
@@ -74,6 +75,7 @@ u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 	if (ireq->ecn_ok)
 		options |= TS_OPT_ECN;
 
+	ts_now = tcp_ns_to_ts(now);
 	ts = ts_now & ~TSMASK;
 	ts |= options;
 	if (ts > ts_now) {
@@ -318,15 +320,25 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
 
 #if IS_ENABLED(CONFIG_CGROUP_BPF) && IS_ENABLED(CONFIG_SYN_COOKIES)
-int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_buff *skb)
+int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_buff *skb,
+			   struct tcp_options_received *tcp_opt)
 {
 	struct bpf_sock_ops_kern sock_ops;
+	struct net *net = sock_net(sk);
+
+	if (tcp_opt->saw_tstamp) {
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
+			goto err;
+
+		tcp_rsk(req)->ts_off = tcp_opt->rcv_tsecr - tcp_ns_to_ts(tcp_clock_ns());
+	}
 
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
 
 	sock_ops.op = BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB;
 	sock_ops.sk = req_to_sk(req);
 	sock_ops.args[0] = tcp_rsk(req)->snt_isn;
+	sock_ops.args[1] = tcp_opt->rcv_tsecr;
 
 	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
@@ -393,15 +405,17 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
 	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
 
-	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
-		tsoff = secure_tcp_ts_off(net,
-					  ip_hdr(skb)->daddr,
-					  ip_hdr(skb)->saddr);
-		tcp_opt.rcv_tsecr -= tsoff;
-	}
+	if (!bpf_cookie) {
+		if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
+			tsoff = secure_tcp_ts_off(net,
+						  ip_hdr(skb)->daddr,
+						  ip_hdr(skb)->saddr);
+			tcp_opt.rcv_tsecr -= tsoff;
+		}
 
-	if (!bpf_cookie && !cookie_timestamp_decode(net, &tcp_opt))
-		goto out;
+		if (!cookie_timestamp_decode(net, &tcp_opt))
+			goto out;
+	}
 
 	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops,
 				     &tcp_request_sock_ipv4_ops, sk, skb);
@@ -418,11 +432,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
 
 	if (bpf_cookie) {
-		mss = bpf_skops_cookie_check(sk, req, skb);
+		mss = bpf_skops_cookie_check(sk, req, skb, &tcp_opt);
 		if (!mss) {
 			reqsk_free(req);
 			goto out;
 		}
+	} else {
+		treq->ts_off = tsoff;
 	}
 
 	req->mss		= mss;
@@ -433,7 +449,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
 	treq->rcv_isn		= ntohl(th->seq) - 1;
-	treq->ts_off		= tsoff;
 	treq->txhash		= net_tx_rndhash();
 	treq->snt_synack	= 0;
 	treq->tfo_listener	= false;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c86a737e4fe6..feb44bff29ef 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6987,6 +6987,10 @@ static int bpf_skops_cookie_init_sequence(struct sock *sk, struct request_sock *
 
 	*isn = sock_ops.replylong[0];
 
+	inet_rsk(req)->bpf_cookie = 1;
+	inet_rsk(req)->bpf_cookie_tsval = sock_ops.replylong[1];
+	tcp_rsk(req)->ts_off = 0;
+
 	return 0;
 }
 #else
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 3e920e7eb5d3..b0a7ea75a504 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -165,15 +165,17 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
 	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
 
-	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
-		tsoff = secure_tcpv6_ts_off(net,
-					    ipv6_hdr(skb)->daddr.s6_addr32,
-					    ipv6_hdr(skb)->saddr.s6_addr32);
-		tcp_opt.rcv_tsecr -= tsoff;
-	}
+	if (!bpf_cookie) {
+		if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
+			tsoff = secure_tcpv6_ts_off(net,
+						    ipv6_hdr(skb)->daddr.s6_addr32,
+						    ipv6_hdr(skb)->saddr.s6_addr32);
+			tcp_opt.rcv_tsecr -= tsoff;
+		}
 
-	if (!bpf_cookie && !cookie_timestamp_decode(net, &tcp_opt))
-		goto out;
+		if (!cookie_timestamp_decode(net, &tcp_opt))
+			goto out;
+	}
 
 	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops,
 				     &tcp_request_sock_ipv6_ops, sk, skb);
@@ -190,11 +192,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->snt_isn = cookie;
 
 	if (bpf_cookie) {
-		mss = bpf_skops_cookie_check(sk, req, skb);
+		mss = bpf_skops_cookie_check(sk, req, skb, &tcp_opt);
 		if (!mss) {
 			reqsk_free(req);
 			goto out;
 		}
+	} else {
+		treq->ts_off = tsoff;
 	}
 
 	if (security_inet_conn_request(sk, skb, req))
@@ -226,7 +230,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->tfo_listener = false;
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = cookie;
-	treq->ts_off = tsoff;
 	treq->txhash = net_tx_rndhash();
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok = 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e6f1507d7895..24f673d88c0d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6865,16 +6865,22 @@ enum {
 					 * earlier bpf-progs.
 					 */
 	BPF_SOCK_OPS_GEN_SYNCOOKIE_CB,	/* Generate SYN Cookie (ISN of
-					 * SYN+ACK).
+					 * SYN+ACK) and value of Timestamps
+					 * option.
 					 *
 					 * args[0]: MSS
 					 *
 					 * replylong[0]: ISN
+					 * replylong[1]: TS
+					 *
+					 * TS value must look like random
+					 * for security reasons.
 					 */
-	BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB,/* Validate SYN Cookie and set
-					 * MSS.
+	BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB,/* Validate SYN Cookie and TS and
+					 * set MSS.
 					 *
 					 * args[0]: ISN
+					 * args[1]: TS
 					 *
 					 * replylong[0]: MSS
 					 */
-- 
2.30.2


