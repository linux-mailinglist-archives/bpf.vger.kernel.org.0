Return-Path: <bpf+bounces-15432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C167F204D
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746E81C21872
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E033A27B;
	Mon, 20 Nov 2023 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MGQvU0+8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804FDAA;
	Mon, 20 Nov 2023 14:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700519301; x=1732055301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Osg4PHAQtLbisrixvy+MHg4/u6PoowyVDp20WB03Bsc=;
  b=MGQvU0+80LXVdbWRM295RwFOyy8cNWmln2xof8aXATpcyYGmIJqD6BOA
   quR267wzkKRYgFamuNIpF1Mw3WJS6n8+OBhKxvtOBvwhq4pSl2FfjM8sj
   gXPR02bfl0Pjh01ghS8ArZo0HDNDmP43TkcVMLZlDt4jqbCJAxNoQM4dc
   g=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="45067859"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:28:19 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id BDDA334005D;
	Mon, 20 Nov 2023 22:28:18 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:20196]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.8:2525] with esmtp (Farcaster)
 id dbcdfb03-48c9-4df6-b3d0-6c0a0c58df03; Mon, 20 Nov 2023 22:28:18 +0000 (UTC)
X-Farcaster-Flow-ID: dbcdfb03-48c9-4df6-b3d0-6c0a0c58df03
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:28:17 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 20 Nov 2023 22:28:13 +0000
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
Subject: [PATCH v2 bpf-next 10/11] bpf: tcp: Support arbitrary SYN Cookie.
Date: Mon, 20 Nov 2023 14:23:40 -0800
Message-ID: <20231120222341.54776-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This patch adds a new kfunc available at TC hook to support arbitrary
SYN Cookie.

The basic usage is as follows:

    struct tcp_cookie_attributes attr = {
        .tcp_opt = {
            .mss_clamp = mss,
            .wscale_ok = wscale_ok,
            .snd_scale = send_scale, /* < 15 */
            .tstamp_ok = tstamp_ok,
            .sack_ok = sack_ok,
        },
        .ecn_ok = ecn_ok,
        .usec_ts_ok = usec_ts_ok,
    };

    skc = bpf_skc_lookup_tcp(...);
    sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
    bpf_sk_assign_tcp_reqsk(skb, sk, attr, sizeof(attr));
    bpf_sk_release(skc);

bpf_sk_assign_tcp_reqsk() takes skb, a listener sk, and struct
tcp_cookie_attributes and allocates reqsk and configures it.  Then,
bpf_sk_assign_tcp_reqsk() links reqsk with skb and the listener.

The notable thing here is that we do not hold refcnt for both reqsk
and listener.  To differentiate that, we mark reqsk->syncookie, which
is only used in TX for now.  So, if reqsk->syncookie is 1 in RX, it
means that the reqsk is allocated by kfunc.

When skb is freed, sock_pfree() checks if reqsk->syncookie is 1,
and in that case, we set NULL to reqsk->rsk_listener before calling
reqsk_free() as reqsk does not hold a refcnt of the listener.

When the TCP stack looks up a socket from the skb, we return
inet_reqsk(skb->sk)->rsk_listener in inet6?_steal_sock().  However,
we do not clear skb->sk and skb->destructor so that we can carry
the reqsk to cookie_v[46]_check().

The refcnt of reqsk will finally be set to 1 in tcp_get_cookie_sock()
after creating a full sk.

Note that we can extend struct tcp_cookie_attributes in the future
when we add a new attribute that is determined in 3WHS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet6_hashtables.h | 14 ++++-
 include/net/inet_hashtables.h  | 14 ++++-
 include/net/tcp.h              |  6 +++
 net/core/filter.c              | 96 +++++++++++++++++++++++++++++++++-
 net/core/sock.c                | 14 ++++-
 5 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 533a7337865a..b6c0ed5a1e3c 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -116,9 +116,21 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched || !sk_fullsock(sk))
+	if (!prefetched)
 		return sk;
 
+	if (sk->sk_state == TCP_NEW_SYN_RECV) {
+		if (inet_reqsk(sk)->syncookie) {
+			*refcounted = false;
+			skb->sk = sk;
+			skb->destructor = sock_pfree;
+			return inet_reqsk(sk)->rsk_listener;
+		}
+		return sk;
+	} else if (sk->sk_state == TCP_TIME_WAIT) {
+		return sk;
+	}
+
 	if (sk->sk_protocol == IPPROTO_TCP) {
 		if (sk->sk_state != TCP_LISTEN)
 			return sk;
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 3ecfeadbfa06..0f4091112967 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -462,9 +462,21 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched || !sk_fullsock(sk))
+	if (!prefetched)
 		return sk;
 
+	if (sk->sk_state == TCP_NEW_SYN_RECV) {
+		if (inet_reqsk(sk)->syncookie) {
+			*refcounted = false;
+			skb->sk = sk;
+			skb->destructor = sock_pfree;
+			return inet_reqsk(sk)->rsk_listener;
+		}
+		return sk;
+	} else if (sk->sk_state == TCP_TIME_WAIT) {
+		return sk;
+	}
+
 	if (sk->sk_protocol == IPPROTO_TCP) {
 		if (sk->sk_state != TCP_LISTEN)
 			return sk;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 842791997f30..373afcfaefa6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -591,6 +591,12 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 }
 
 #if IS_ENABLED(CONFIG_BPF)
+struct tcp_cookie_attributes {
+	struct tcp_options_received tcp_opt;
+	bool ecn_ok;
+	bool usec_ts_ok;
+} __packed;
+
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
 	return skb->sk;
diff --git a/net/core/filter.c b/net/core/filter.c
index d64baa7ac6cd..58b567aaf577 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11807,6 +11807,88 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 
 	return 0;
 }
+
+__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
+					struct tcp_cookie_attributes *attr,
+					int attr__sz)
+{
+	const struct request_sock_ops *ops;
+	struct inet_request_sock *ireq;
+	struct tcp_request_sock *treq;
+	struct request_sock *req;
+	__u16 min_mss;
+
+	if (attr__sz != sizeof(*attr))
+		return -EINVAL;
+
+	if (!sk)
+		return -EINVAL;
+
+	if (!skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (dev_net(skb->dev) != sock_net(sk))
+		return -ENETUNREACH;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		ops = &tcp_request_sock_ops;
+		min_mss = 536;
+		break;
+#if IS_BUILTIN(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		ops = &tcp6_request_sock_ops;
+		min_mss = IPV6_MIN_MTU - 60;
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
+
+	if (attr->tcp_opt.mss_clamp < min_mss) {
+		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
+		return -EINVAL;
+	}
+
+	if (attr->tcp_opt.wscale_ok &&
+	    attr->tcp_opt.snd_wscale > TCP_MAX_WSCALE) {
+		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
+		return -EINVAL;
+	}
+
+	if (sk_is_mptcp(sk))
+		req = mptcp_subflow_reqsk_alloc(ops, sk, false);
+	else
+		req = inet_reqsk_alloc(ops, sk, false);
+
+	if (!req)
+		return -ENOMEM;
+
+	ireq = inet_rsk(req);
+	treq = tcp_rsk(req);
+
+	req->syncookie = 1;
+	req->rsk_listener = sk;
+	req->mss = attr->tcp_opt.mss_clamp;
+
+	ireq->snd_wscale = attr->tcp_opt.snd_wscale;
+	ireq->wscale_ok = attr->tcp_opt.wscale_ok;
+	ireq->tstamp_ok	= attr->tcp_opt.tstamp_ok;
+	ireq->sack_ok = attr->tcp_opt.sack_ok;
+	ireq->ecn_ok = attr->ecn_ok;
+
+	treq->req_usec_ts = attr->usec_ts_ok;
+
+	skb_orphan(skb);
+	skb->sk = req_to_sk(req);
+	skb->destructor = sock_pfree;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
@@ -11835,6 +11917,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
 
+BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11850,6 +11936,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
 	.set = &bpf_kfunc_check_set_sock_addr,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_tcp_reqsk,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -11865,8 +11956,9 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						&bpf_kfunc_set_sock_addr);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
+					       &bpf_kfunc_set_sock_addr);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
 }
 late_initcall(bpf_kfunc_init);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index fef349dd72fa..998950e97dfe 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2579,8 +2579,18 @@ EXPORT_SYMBOL(sock_efree);
 #ifdef CONFIG_INET
 void sock_pfree(struct sk_buff *skb)
 {
-	if (sk_is_refcounted(skb->sk))
-		sock_gen_put(skb->sk);
+	struct sock *sk = skb->sk;
+
+	if (!sk_is_refcounted(sk))
+		return;
+
+	if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
+		inet_reqsk(sk)->rsk_listener = NULL;
+		reqsk_free(inet_reqsk(sk));
+		return;
+	}
+
+	sock_gen_put(sk);
 }
 EXPORT_SYMBOL(sock_pfree);
 #endif /* CONFIG_INET */
-- 
2.30.2


