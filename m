Return-Path: <bpf+bounces-17380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855780C21C
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 08:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BEE1F2107E
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 07:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE8208A7;
	Mon, 11 Dec 2023 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rR1y77k3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A00D9;
	Sun, 10 Dec 2023 23:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702280365; x=1733816365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QiXFV6MJSnrvanoHJVQCvimF5oLov/smCpvjFxOL/xg=;
  b=rR1y77k3assCznR98yQO/DPocMGn2V/1jLFwL8ME4DSePuSetjF4GuX4
   c31gj/VAlLwOxNnKXfUX/uAD1wqy94DNy/aMZLwA87HPzH0J9qT6LePgG
   C6aAGEQnUSdTJc8hgTMi4oYoQyu6HVUM43tIVWx+5UXq50Ym2ViZTyzKi
   c=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="49707994"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 07:39:23 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id 3DB4BE0D1C;
	Mon, 11 Dec 2023 07:39:20 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:65083]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.7:2525] with esmtp (Farcaster)
 id 2fd4baeb-02a1-4863-b932-0327789a2f77; Mon, 11 Dec 2023 07:39:20 +0000 (UTC)
X-Farcaster-Flow-ID: 2fd4baeb-02a1-4863-b932-0327789a2f77
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 07:39:19 +0000
Received: from 88665a182662.ant.amazon.com (10.119.13.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 11 Dec 2023 07:39:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v5 bpf-next 5/6] bpf: tcp: Support arbitrary SYN Cookie.
Date: Mon, 11 Dec 2023 16:36:49 +0900
Message-ID: <20231211073650.90819-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
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
            .rcv_tsval = tsval,
            .rcv_tsecr = tsecr,
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

When the TCP stack looks up a socket from the skb, we steal the
listener from the reqsk in skb_steal_sock() and create a full sk
in cookie_v[46]_check().

The refcnt of reqsk will finally be set to 1 in tcp_get_cookie_sock()
after creating a full sk.

Note that we can use the unused bits in struct tcp_options_received
and extend struct tcp_cookie_attributes in the future when we add a
new attribute that is determined in 3WHS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h |   6 +++
 net/core/filter.c | 118 +++++++++++++++++++++++++++++++++++++++++++++-
 net/core/sock.c   |  14 +++++-
 3 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b5d7149eb0f8..6e3ee9036ecb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -600,6 +600,12 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
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
index adcfc2c25754..713feacb3ad3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11816,6 +11816,110 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 
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
+	struct net *net;
+	__u16 min_mss;
+	u32 tsoff = 0;
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
+	net = dev_net(skb->dev);
+	if (net != sock_net(sk))
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
+	if (attr->tcp_opt.mss_clamp < min_mss)
+		return -EINVAL;
+
+	if (attr->tcp_opt.wscale_ok) {
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
+			return -EINVAL;
+
+		if (attr->tcp_opt.snd_wscale > TCP_MAX_WSCALE ||
+		    attr->tcp_opt.rcv_wscale > TCP_MAX_WSCALE)
+			return -EINVAL;
+	}
+
+	if (attr->tcp_opt.sack_ok && !READ_ONCE(net->ipv4.sysctl_tcp_sack))
+		return -EINVAL;
+
+	if (attr->tcp_opt.tstamp_ok) {
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
+			return -EINVAL;
+
+		tsoff = attr->tcp_opt.rcv_tsecr -
+			tcp_ns_to_ts(attr->usec_ts_ok, tcp_clock_ns());
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
+	req->rsk_listener = sk;
+	req->syncookie = 1;
+	req->mss = attr->tcp_opt.mss_clamp;
+	req->ts_recent = attr->tcp_opt.rcv_tsval;
+
+	ireq->snd_wscale = attr->tcp_opt.snd_wscale;
+	ireq->rcv_wscale = attr->tcp_opt.rcv_wscale;
+	ireq->tstamp_ok	= attr->tcp_opt.tstamp_ok;
+	ireq->sack_ok = attr->tcp_opt.sack_ok;
+	ireq->wscale_ok = attr->tcp_opt.wscale_ok;
+	ireq->ecn_ok = attr->ecn_ok;
+
+	treq->req_usec_ts = attr->usec_ts_ok;
+	treq->ts_off = tsoff;
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
@@ -11844,6 +11948,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
 
+BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11859,6 +11967,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
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
@@ -11874,8 +11987,9 @@ static int __init bpf_kfunc_init(void)
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


