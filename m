Return-Path: <bpf+bounces-18473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819E781AC35
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 02:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6626287BE9
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53121843;
	Thu, 21 Dec 2023 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UNDcqPG9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4A2567;
	Thu, 21 Dec 2023 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703122241; x=1734658241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Klb4cCMldIPKj180sj2tMdm4GY8NaECcM5R2AQ5KTfs=;
  b=UNDcqPG9VdUCMIfpV2Adbqa5rU+Gdpn9RTB/fDrWUNbyKaWaZC20/iPN
   JgsknNezIDzwcLtnMvgdPGOOAZqQSNaeiA3TG5csJcmEeEsozFDhAoHSr
   iZks72dXsY6mIcXwfLocYotKZZt1qNO8FoUPdiqdr8QAFvAbgfnnN7a3f
   c=;
X-IronPort-AV: E=Sophos;i="6.04,292,1695686400"; 
   d="scan'208";a="260916356"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:30:40 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 5E7F949148;
	Thu, 21 Dec 2023 01:30:37 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:44543]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.150:2525] with esmtp (Farcaster)
 id 001ab379-44b2-4692-a68a-36410aaac63e; Thu, 21 Dec 2023 01:30:36 +0000 (UTC)
X-Farcaster-Flow-ID: 001ab379-44b2-4692-a68a-36410aaac63e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 01:30:35 +0000
Received: from 88665a182662.ant.amazon.com (10.119.15.211) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 01:30:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v7 bpf-next 5/6] bpf: tcp: Support arbitrary SYN Cookie.
Date: Thu, 21 Dec 2023 10:28:05 +0900
Message-ID: <20231221012806.37137-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221012806.37137-1-kuniyu@amazon.com>
References: <20231221012806.37137-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
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
 include/net/tcp.h |  13 ++++++
 net/core/filter.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
 net/core/sock.c   |  14 +++++-
 3 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a63916f41f77..20619df8819e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -600,6 +600,19 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
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
+};
+
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
 	return skb->sk;
diff --git a/net/core/filter.c b/net/core/filter.c
index 24061f29c9dd..961c2d30bd72 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11837,6 +11837,105 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 
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
+	if (attrs__sz != sizeof(*attrs))
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
@@ -11865,6 +11964,10 @@ BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
 
+BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11880,6 +11983,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
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
@@ -11895,8 +12003,9 @@ static int __init bpf_kfunc_init(void)
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
index 446e945f736b..1116338f8ff4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2575,8 +2575,18 @@ EXPORT_SYMBOL(sock_efree);
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


