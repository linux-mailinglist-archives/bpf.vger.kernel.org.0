Return-Path: <bpf+bounces-17379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6480C215
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 08:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41E71C2098D
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F9208A5;
	Mon, 11 Dec 2023 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L9mrvyxg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D0D9;
	Sun, 10 Dec 2023 23:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702280342; x=1733816342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVAtZ8f9XuE7weAoLBCpAE4HOiZIPOSWZfLNFQERqUQ=;
  b=L9mrvyxgOzorzPeJd7Htok3ZHgdkNpsHGaTrgEUVfMksIf+pij+uaoz0
   8BAHVA7L6k9hZRzblwKH7UWnA6anb/LALcfGAabYxTsBqKSPGWrVrNN78
   hr4DwE+SNoqS/z8dIVE+JyDFBW2dZ6PVuHNVk1lB9jPnLC1AhEeBVQXn4
   M=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="382029912"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 07:38:56 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 842C3A08F3;
	Mon, 11 Dec 2023 07:38:55 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:6963]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.12:2525] with esmtp (Farcaster)
 id b9d1f19b-0efc-4f3b-a6fe-00eac03ad2b8; Mon, 11 Dec 2023 07:38:55 +0000 (UTC)
X-Farcaster-Flow-ID: b9d1f19b-0efc-4f3b-a6fe-00eac03ad2b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 07:38:52 +0000
Received: from 88665a182662.ant.amazon.com (10.119.13.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 07:38:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v5 bpf-next 4/6] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
Date: Mon, 11 Dec 2023 16:36:48 +0900
Message-ID: <20231211073650.90819-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211073650.90819-1-kuniyu@amazon.com>
References: <20231211073650.90819-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF in the following
patch.

If BPF prog validates ACK and kfunc allocates a reqsk, it will
be carried to cookie_[46]_check() as skb->sk.  If skb->sk is not
NULL, we call cookie_bpf_check().

Then, we clear skb->sk and skb->destructor, which are needed not
to hold refcnt for reqsk and the listener.

After that, we finish initialisation for the remaining fields with
cookie_tcp_reqsk_init().

Note that the server side WScale is set only for non-BPF SYN Cookie.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     | 20 ++++++++++++++++++++
 net/ipv4/syncookies.c | 31 +++++++++++++++++++++++++++----
 net/ipv6/syncookies.c | 13 +++++++++----
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c77354d1b86d..b5d7149eb0f8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -599,6 +599,26 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 		dst_feature(dst, RTAX_FEATURE_ECN);
 }
 
+#if IS_ENABLED(CONFIG_BPF)
+static inline bool cookie_bpf_ok(struct sk_buff *skb)
+{
+	return skb->sk;
+}
+
+struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb);
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
index 981944c22820..be88bf586ff9 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -295,6 +295,24 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_BPF)
+struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
+{
+	struct request_sock *req = inet_reqsk(skb->sk);
+
+	skb->sk = NULL;
+	skb->destructor = NULL;
+
+	if (cookie_tcp_reqsk_init(sk, skb, req)) {
+		reqsk_free(req);
+		req = NULL;
+	}
+
+	return req;
+}
+EXPORT_SYMBOL_GPL(cookie_bpf_check);
+#endif
+
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct sock *sk, struct sk_buff *skb,
 					    struct tcp_options_received *tcp_opt,
@@ -395,9 +413,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	    !th->ack || th->rst)
 		goto out;
 
-	req = cookie_tcp_check(net, sk, skb);
-	if (IS_ERR(req))
-		goto out;
+	if (cookie_bpf_ok(skb)) {
+		req = cookie_bpf_check(sk, skb);
+	} else {
+		req = cookie_tcp_check(net, sk, skb);
+		if (IS_ERR(req))
+			goto out;
+	}
 	if (!req)
 		goto out_drop;
 
@@ -445,7 +467,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 				  ireq->wscale_ok, &rcv_wscale,
 				  dst_metric(&rt->dst, RTAX_INITRWND));
 
-	ireq->rcv_wscale  = rcv_wscale;
+	if (!req->syncookie)
+		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index c8d2ca27220c..6b9c69278819 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -182,9 +182,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	    !th->ack || th->rst)
 		goto out;
 
-	req = cookie_tcp_check(net, sk, skb);
-	if (IS_ERR(req))
-		goto out;
+	if (cookie_bpf_ok(skb)) {
+		req = cookie_bpf_check(sk, skb);
+	} else {
+		req = cookie_tcp_check(net, sk, skb);
+		if (IS_ERR(req))
+			goto out;
+	}
 	if (!req)
 		goto out_drop;
 
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


