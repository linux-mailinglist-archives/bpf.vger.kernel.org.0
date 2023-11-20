Return-Path: <bpf+bounces-15431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276007F204B
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C486282814
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC473A279;
	Mon, 20 Nov 2023 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RCIairo9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ACD97;
	Mon, 20 Nov 2023 14:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700519281; x=1732055281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+JRCveewSWjc65hVKXp90gQjdRBf1pSvCvgd9Qx0MPw=;
  b=RCIairo9KEeVn5JxJ+o8yY42n4mA7SxnTnh1pmqBSKU3ouDgDnoDqHaD
   awcHQx6A8va5I44GsP78LKWi/jsD9p9839wKonTNPbgXCkZTVmDYDGxk8
   vFqrqVtRt/bIX3g6C0yiEBDhnj3poZ8mMZy0eVobkV78sDukzqTZH9DzN
   k=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="45067761"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:27:58 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-d23e07e8.us-east-1.amazon.com (Postfix) with ESMTPS id B002A80E60;
	Mon, 20 Nov 2023 22:27:52 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:8002]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.167:2525] with esmtp (Farcaster)
 id d572354e-59d5-4a3d-9e5c-984c7801c1f3; Mon, 20 Nov 2023 22:27:52 +0000 (UTC)
X-Farcaster-Flow-ID: d572354e-59d5-4a3d-9e5c-984c7801c1f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:27:52 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:27:48 +0000
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
Subject: [PATCH v2 bpf-next 09/11] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
Date: Mon, 20 Nov 2023 14:23:39 -0800
Message-ID: <20231120222341.54776-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
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
 net/ipv4/syncookies.c | 59 ++++++++++++++++++++++++++++++++++++++++++-
 net/ipv6/syncookies.c |  6 ++++-
 3 files changed, 84 insertions(+), 2 deletions(-)

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
index beea4d05fafc..b120eb4be8eb 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -305,6 +305,59 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
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
@@ -405,7 +458,11 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
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
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index c8d2ca27220c..45f113994c4b 100644
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
-- 
2.30.2


