Return-Path: <bpf+bounces-19558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07AD82E20A
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 21:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BACB2211E
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E411AADD;
	Mon, 15 Jan 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UTMiMtm3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735301AAA9;
	Mon, 15 Jan 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705352255; x=1736888255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVxPvrEtm6Dvgj0AimBVUPk8kjRrNtEmfhUs50GoGdc=;
  b=UTMiMtm3ZMsRxE9xcPjKhh3UnWWVTSoF5NdetUQGam7/G7nB0OW2Twf8
   VqW6o+LeYFRMeuGmVCottEQkeMBD0uC+DEzjuImM0+Qb1oeY9fKLPT2fw
   K6wFAHF9oSFc8tFquA+lZoI32MBsWdJt9B6cc42Crvs+dneyvxnggKNzm
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,197,1695686400"; 
   d="scan'208";a="382361583"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 20:57:32 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 2DB5E40D41;
	Mon, 15 Jan 2024 20:57:30 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:22838]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.157:2525] with esmtp (Farcaster)
 id 97340147-d539-469f-ba62-cf4baaa41203; Mon, 15 Jan 2024 20:57:29 +0000 (UTC)
X-Farcaster-Flow-ID: 97340147-d539-469f-ba62-cf4baaa41203
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:57:29 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:57:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v8 bpf-next 5/6] bpf: tcp: Support arbitrary SYN Cookie.
Date: Mon, 15 Jan 2024 12:55:13 -0800
Message-ID: <20240115205514.68364-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240115205514.68364-1-kuniyu@amazon.com>
References: <20240115205514.68364-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

This patch adds a new kfunc available at TC hook to support arbitrary
SYN Cookie.

The basic usage is as follows:

    struct bpf_tcp_req_attrs attrs = {
        .mss = mss,
        .wscale_ok = wscale_ok,
        .rcv_wscale = rcv_wscale, /* Server's WScale < 15 */
        .snd_wscale = snd_wscale, /* Client's WScale < 15 */
        .tstamp_ok = tstamp_ok,
        .rcv_tsval = tsval,
        .rcv_tsecr = tsecr, /* Server's Initial TSval */
        .usec_ts_ok = usec_ts_ok,
        .sack_ok = sack_ok,
        .ecn_ok = ecn_ok,
    }

    skc = bpf_skc_lookup_tcp(...);
    sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
    bpf_sk_assign_tcp_reqsk(skb, sk, attrs, sizeof(attrs));
    bpf_sk_release(skc);

bpf_sk_assign_tcp_reqsk() takes skb, a listener sk, and struct
bpf_tcp_req_attrs and allocates reqsk and configures it.  Then,
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

Note that we can extend struct bpf_tcp_req_attrs in the future when
we add a new attribute that is determined in 3WHS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h |  14 ++++++
 net/core/filter.c | 114 +++++++++++++++++++++++++++++++++++++++++++++-
 net/core/sock.c   |  14 +++++-
 3 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dfe99a084a71..451dc1373970 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -600,6 +600,20 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 }
 
 #if IS_ENABLED(CONFIG_BPF)
+struct bpf_tcp_req_attrs {
+	u32 rcv_tsval;
+	u32 rcv_tsecr;
+	u16 mss;
+	u8 rcv_wscale;
+	u8 snd_wscale;
+	u8 ecn_ok;
+	u8 wscale_ok;
+	u8 sack_ok;
+	u8 tstamp_ok;
+	u8 usec_ts_ok;
+	u8 reserved[3];
+};
+
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
 	return skb->sk;
diff --git a/net/core/filter.c b/net/core/filter.c
index 8c9f67c81e22..647d04171b7e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11837,6 +11837,106 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 
 	return 0;
 }
+
+__bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct sk_buff *skb, struct sock *sk,
+					struct bpf_tcp_req_attrs *attrs, int attrs__sz)
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
+	if (attrs__sz != sizeof(*attrs) ||
+	    attrs->reserved[0] || attrs->reserved[1] || attrs->reserved[2])
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
+	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_LISTEN ||
+	    sk_is_mptcp(sk))
+		return -EINVAL;
+
+	if (attrs->mss < min_mss)
+		return -EINVAL;
+
+	if (attrs->wscale_ok) {
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_window_scaling))
+			return -EINVAL;
+
+		if (attrs->snd_wscale > TCP_MAX_WSCALE ||
+		    attrs->rcv_wscale > TCP_MAX_WSCALE)
+			return -EINVAL;
+	}
+
+	if (attrs->sack_ok && !READ_ONCE(net->ipv4.sysctl_tcp_sack))
+		return -EINVAL;
+
+	if (attrs->tstamp_ok) {
+		if (!READ_ONCE(net->ipv4.sysctl_tcp_timestamps))
+			return -EINVAL;
+
+		tsoff = attrs->rcv_tsecr - tcp_ns_to_ts(attrs->usec_ts_ok, tcp_clock_ns());
+	}
+
+	req = inet_reqsk_alloc(ops, sk, false);
+	if (!req)
+		return -ENOMEM;
+
+	ireq = inet_rsk(req);
+	treq = tcp_rsk(req);
+
+	req->rsk_listener = sk;
+	req->syncookie = 1;
+	req->mss = attrs->mss;
+	req->ts_recent = attrs->rcv_tsval;
+
+	ireq->snd_wscale = attrs->snd_wscale;
+	ireq->rcv_wscale = attrs->rcv_wscale;
+	ireq->tstamp_ok	= !!attrs->tstamp_ok;
+	ireq->sack_ok = !!attrs->sack_ok;
+	ireq->wscale_ok = !!attrs->wscale_ok;
+	ireq->ecn_ok = !!attrs->ecn_ok;
+
+	treq->req_usec_ts = !!attrs->usec_ts_ok;
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
@@ -11865,6 +11965,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
 
+BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11880,6 +11984,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
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
@@ -11895,8 +12004,9 @@ static int __init bpf_kfunc_init(void)
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
index 158dbdebce6a..147fb2656e6b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2582,8 +2582,18 @@ EXPORT_SYMBOL(sock_efree);
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


