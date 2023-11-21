Return-Path: <bpf+bounces-15580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9897F3674
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AFDB21280
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862A56741;
	Tue, 21 Nov 2023 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DZZ01vE6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3238BD1;
	Tue, 21 Nov 2023 10:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700592422; x=1732128422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+JRCveewSWjc65hVKXp90gQjdRBf1pSvCvgd9Qx0MPw=;
  b=DZZ01vE6bJbajWVhLUcmAg4N1mu3TmjRjRZV6YaKJ5Uym5iuuwpKfAXi
   j6c6c+3IURm42iPXI+cWZvcdXyAyIDNA65xEKpWyymDZEtu6LROYKFkat
   iRqi/mIm6rMCcvMj80xm0g40xR3kwb6WiH1KkaT3ziR0mnRymtLWDI9wt
   4=;
X-IronPort-AV: E=Sophos;i="6.04,216,1695686400"; 
   d="scan'208";a="620915491"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:47:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 5BC081619A7;
	Tue, 21 Nov 2023 18:46:55 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:7936]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.133:2525] with esmtp (Farcaster)
 id 509360e6-8beb-4fb3-95e1-6c85a4b78fc9; Tue, 21 Nov 2023 18:46:54 +0000 (UTC)
X-Farcaster-Flow-ID: 509360e6-8beb-4fb3-95e1-6c85a4b78fc9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:46:47 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:46:42 +0000
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
Subject: [PATCH v3 bpf-next 09/11] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
Date: Tue, 21 Nov 2023 10:42:43 -0800
Message-ID: <20231121184245.69569-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
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


