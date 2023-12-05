Return-Path: <bpf+bounces-16683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB41804420
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510B728142E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4517F5;
	Tue,  5 Dec 2023 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I0rKt0re"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F2F183;
	Mon,  4 Dec 2023 17:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701740106; x=1733276106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrkcrpaiMOUqKchDz5yNJtZXvNjLqZv9JlwR66inbk0=;
  b=I0rKt0reUBDi1I/qNpHuXfqgG3hPCTmBGaSqwBKHhbOgpbM2qEtJP7tW
   eb9y83fDQrr6Tcj1UNYC4fE0DpRuf66JdhRPp2SCIZyha7QIUf5AXyE96
   yOlgGm+BvFZL7CXdusQYSgzGyV28BleDxeR07n7IouzsWYYwnGWZd3/Yf
   k=;
X-IronPort-AV: E=Sophos;i="6.04,251,1695686400"; 
   d="scan'208";a="257398471"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:35:03 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id DBFAE4960B;
	Tue,  5 Dec 2023 01:35:01 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:64013]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id 2b399aaf-17d9-4712-abfe-97dd43843131; Tue, 5 Dec 2023 01:35:01 +0000 (UTC)
X-Farcaster-Flow-ID: 2b399aaf-17d9-4712-abfe-97dd43843131
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 5 Dec 2023 01:35:00 +0000
Received: from 88665a182662.ant.amazon.com (10.119.0.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 5 Dec 2023 01:34:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v4 bpf-next 1/3] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
Date: Tue, 5 Dec 2023 10:34:18 +0900
Message-ID: <20231205013420.88067-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231205013420.88067-1-kuniyu@amazon.com>
References: <20231205013420.88067-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF in the following
patch.

If BPF prog validates ACK and kfunc allocates reqsk, it will
be carried to cookie_[46]_check() as skb->sk.  Then, we call
cookie_bpf_check() to validate the configuration passed to kfunc.

First, we clear skb->sk, skb->destructor, and req->rsk_listener,
which are needed not to hold refcnt for reqsk and the listener.
See the following patch for details.

Then, we parse TCP options to check if tstamp_ok is discrepant.
If it is invalid, we increment LINUX_MIB_SYNCOOKIESFAILED and send
RST.  If tstamp_ok is valid, we increment LINUX_MIB_SYNCOOKIESRECV.

After that, we check sack_ok and wscale_ok with corresponding
sysctl knobs.  If the test fails, we send RST but do not increment
LINUX_MIB_SYNCOOKIESFAILED.  This behaviour is the same with the
non-BPF cookie handling in cookie_tcp_check().

Finally, we finish initialisation for the remaining fields with
cookie_tcp_reqsk_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     | 21 +++++++++++++++
 net/ipv4/syncookies.c | 62 +++++++++++++++++++++++++++++++++++++++++--
 net/ipv6/syncookies.c |  9 +++++--
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 973555cb1d3f..842791997f30 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -590,6 +590,27 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 		dst_feature(dst, RTAX_FEATURE_ECN);
 }
 
+#if IS_ENABLED(CONFIG_BPF)
+static inline bool cookie_bpf_ok(struct sk_buff *skb)
+{
+	return skb->sk;
+}
+
+struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
+				      struct sk_buff *skb);
+#else
+static inline bool cookie_bpf_ok(struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
+						    struct sk_buff *skb)
+{
+	return NULL;
+}
+#endif
+
 /* From net/ipv6/syncookies.c */
 int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 61f1c96cfe63..0f9c3aed2014 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -304,6 +304,59 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_BPF)
+struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
+				      struct sk_buff *skb)
+{
+	struct request_sock *req = inet_reqsk(skb->sk);
+	struct inet_request_sock *ireq = inet_rsk(req);
+	struct tcp_request_sock *treq = tcp_rsk(req);
+	struct tcp_options_received tcp_opt;
+	int ret;
+
+	skb->sk = NULL;
+	skb->destructor = NULL;
+	req->rsk_listener = NULL;
+
+	memset(&tcp_opt, 0, sizeof(tcp_opt));
+	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
+
+	if (ireq->tstamp_ok ^ tcp_opt.saw_tstamp) {
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
+		goto reset;
+	}
+
+	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
+
+	if (ireq->tstamp_ok) {
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
+			goto reset;
+
+		req->ts_recent = tcp_opt.rcv_tsval;
+		treq->ts_off = tcp_opt.rcv_tsecr - tcp_ns_to_ts(false, tcp_clock_ns());
+	}
+
+	if (ireq->sack_ok && !READ_ONCE(net->ipv4.sysctl_tcp_sack))
+		goto reset;
+
+	if (ireq->wscale_ok && !READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
+		goto reset;
+
+	ret = cookie_tcp_reqsk_init(sk, skb, req);
+	if (ret) {
+		reqsk_free(req);
+		req = NULL;
+	}
+
+	return req;
+
+reset:
+	reqsk_free(req);
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(cookie_bpf_check);
+#endif
+
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct sock *sk, struct sk_buff *skb,
 					    struct tcp_options_received *tcp_opt,
@@ -404,7 +457,11 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	    !th->ack || th->rst)
 		goto out;
 
-	req = cookie_tcp_check(net, sk, skb);
+	if (cookie_bpf_ok(skb))
+		req = cookie_bpf_check(net, sk, skb);
+	else
+		req = cookie_tcp_check(net, sk, skb);
+
 	if (IS_ERR(req))
 		goto out;
 	if (!req)
@@ -454,7 +511,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 				  ireq->wscale_ok, &rcv_wscale,
 				  dst_metric(&rt->dst, RTAX_INITRWND));
 
-	ireq->rcv_wscale  = rcv_wscale;
+	if (!req->syncookie)
+		ireq->rcv_wscale  = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index c8d2ca27220c..24224138ba1a 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -182,7 +182,11 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	    !th->ack || th->rst)
 		goto out;
 
-	req = cookie_tcp_check(net, sk, skb);
+	if (cookie_bpf_ok(skb))
+		req = cookie_bpf_check(net, sk, skb);
+	else
+		req = cookie_tcp_check(net, sk, skb);
+
 	if (IS_ERR(req))
 		goto out;
 	if (!req)
@@ -247,7 +251,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 				  ireq->wscale_ok, &rcv_wscale,
 				  dst_metric(dst, RTAX_INITRWND));
 
-	ireq->rcv_wscale = rcv_wscale;
+	if (!req->syncookie)
+		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
-- 
2.30.2


