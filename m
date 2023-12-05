Return-Path: <bpf+bounces-16684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A09804423
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122801C20C58
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B81184E;
	Tue,  5 Dec 2023 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="poaD6X/A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9B4102;
	Mon,  4 Dec 2023 17:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701740139; x=1733276139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oI6Tock4vyiMgrEo2VFazTzVSGzICIUnmtDP4s4yEow=;
  b=poaD6X/ApANhtsgXUBpWcpqxy0avvsV822OjOIxN6a4lJcmhOuR74Dyt
   VtziyHvGjRaWhQe8hwOwAebT04+oaFvZKER5DY5Uh8I5c54pNefvuG3LS
   LbLWgU3GtU8qwAtnh7DXQwGFzfBWkj6E6OJgw3GFqhFlQw+m29BYiYxf0
   E=;
X-IronPort-AV: E=Sophos;i="6.04,251,1695686400"; 
   d="scan'208";a="315701169"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:35:32 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 84F4240DB0;
	Tue,  5 Dec 2023 01:35:28 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:52199]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.176:2525] with esmtp (Farcaster)
 id aa1b22d1-6495-4ccf-a387-ba6f042a98ed; Tue, 5 Dec 2023 01:35:27 +0000 (UTC)
X-Farcaster-Flow-ID: aa1b22d1-6495-4ccf-a387-ba6f042a98ed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 5 Dec 2023 01:35:27 +0000
Received: from 88665a182662.ant.amazon.com (10.119.0.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 01:35:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v4 bpf-next 2/3] bpf: tcp: Support arbitrary SYN Cookie.
Date: Tue, 5 Dec 2023 10:34:19 +0900
Message-ID: <20231205013420.88067-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

This patch adds a new kfunc available at TC hook to support arbitrary
SYN Cookie.

The basic usage is as follows:

    struct tcp_cookie_attributes attr = {
        .tcp_opt = {
            .mss_clamp = mss,
            .wscale_ok = wscale_ok,
            .rcv_scale = recv_scale, /* Server's WScale < 15 */
            .snd_scale = send_scale, /* Client's WScale < 15 */
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
inet_reqsk(skb->sk)->rsk_listener in skb_steal_sock().  However,
we do not clear skb->sk and skb->destructor so that we can carry
the reqsk to cookie_v[46]_check().

The refcnt of reqsk will finally be set to 1 in tcp_get_cookie_sock()
after creating a full sk.

Note that we can use the unused bits in struct tcp_options_received
and extend struct tcp_cookie_attributes in the future when we add a
new attribute that is determined in 3WHS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/request_sock.h |  35 +++++++++++++
 include/net/sock.h         |  25 ---------
 include/net/tcp.h          |   6 +++
 net/core/filter.c          | 102 ++++++++++++++++++++++++++++++++++++-
 net/core/sock.c            |  14 ++++-
 5 files changed, 153 insertions(+), 29 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 144c39db9898..2efffe2c05d0 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -83,6 +83,41 @@ static inline struct sock *req_to_sk(struct request_sock *req)
 	return (struct sock *)req;
 }
 
+/**
+ * skb_steal_sock - steal a socket from an sk_buff
+ * @skb: sk_buff to steal the socket from
+ * @refcounted: is set to true if the socket is reference-counted
+ * @prefetched: is set to true if the socket was assigned from bpf
+ */
+static inline struct sock *
+skb_steal_sock(struct sk_buff *skb, bool *refcounted, bool *prefetched)
+{
+	struct sock *sk = skb->sk;
+
+	if (!skb->sk) {
+		*prefetched = false;
+		*refcounted = false;
+		return NULL;
+	}
+
+	*prefetched = skb_sk_is_prefetched(skb);
+	if (*prefetched) {
+#if IS_ENABLED(CONFIG_SYN_COOKIES)
+		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
+			*refcounted = false;
+			return inet_reqsk(sk)->rsk_listener;
+		}
+#endif
+		*refcounted = sk_is_refcounted(sk);
+	} else {
+		*refcounted = true;
+	}
+
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	return sk;
+}
+
 static inline struct request_sock *
 reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
 	    bool attach_listener)
diff --git a/include/net/sock.h b/include/net/sock.h
index 1d6931caf0c3..0ed77af38000 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2838,31 +2838,6 @@ sk_is_refcounted(struct sock *sk)
 	return !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE);
 }
 
-/**
- * skb_steal_sock - steal a socket from an sk_buff
- * @skb: sk_buff to steal the socket from
- * @refcounted: is set to true if the socket is reference-counted
- * @prefetched: is set to true if the socket was assigned from bpf
- */
-static inline struct sock *
-skb_steal_sock(struct sk_buff *skb, bool *refcounted, bool *prefetched)
-{
-	if (skb->sk) {
-		struct sock *sk = skb->sk;
-
-		*refcounted = true;
-		*prefetched = skb_sk_is_prefetched(skb);
-		if (*prefetched)
-			*refcounted = sk_is_refcounted(sk);
-		skb->destructor = NULL;
-		skb->sk = NULL;
-		return sk;
-	}
-	*prefetched = false;
-	*refcounted = false;
-	return NULL;
-}
-
 /* Checks if this SKB belongs to an HW offloaded socket
  * and whether any SW fallbacks are required based on dev.
  * Check decrypted mark in case skb_orphan() cleared socket.
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
index 0adaa4afa35f..a43f7627c5fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11816,6 +11816,94 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 
 	return 0;
 }
+
+__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
+					struct tcp_cookie_attributes *attr,
+					int attr__sz)
+{
+#if IS_ENABLED(CONFIG_SYN_COOKIES)
+	const struct request_sock_ops *ops;
+	struct inet_request_sock *ireq;
+	struct tcp_request_sock *treq;
+	struct request_sock *req;
+	__u16 min_mss;
+
+	if (attr__sz != sizeof(*attr) || attr->tcp_opt.unused)
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
+	    (attr->tcp_opt.snd_wscale > TCP_MAX_WSCALE ||
+	     attr->tcp_opt.rcv_wscale > TCP_MAX_WSCALE)) {
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
+	ireq->rcv_wscale = attr->tcp_opt.rcv_wscale;
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
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
@@ -11844,6 +11932,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
 
+BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11859,6 +11951,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
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
@@ -11874,8 +11971,9 @@ static int __init bpf_kfunc_init(void)
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


