Return-Path: <bpf+bounces-15429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2F07F2045
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7870B21A0E
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533C3A262;
	Mon, 20 Nov 2023 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iN55E0Gk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675F2C7;
	Mon, 20 Nov 2023 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700519230; x=1732055230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ogdre1bYMCb9SWGOxo4KI11NZiojqrX7LIjIUbvo+0A=;
  b=iN55E0Gk7YjFTbiS9wPIpprHjET+sigtRu4Wlt7LpwiS7uMWk9FvStq4
   aCY1P/p6f7lYdA0SUo9mxkNQ2MF/txYjCTPgTa3UIQJOdj7e///hly+RI
   pXYsGhhQfS1uKhTiOpSbEmgDlEJ5fBFiE65A6mPtJzGgJJk6JvoZ7wCOK
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="377651486"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:27:02 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 6A22C8A35F;
	Mon, 20 Nov 2023 22:27:01 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:40606]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.242:2525] with esmtp (Farcaster)
 id 02cb6594-e05f-4124-9a9e-3500c23824c0; Mon, 20 Nov 2023 22:27:01 +0000 (UTC)
X-Farcaster-Flow-ID: 02cb6594-e05f-4124-9a9e-3500c23824c0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:27:00 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:26:56 +0000
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
Subject: [PATCH v2 bpf-next 07/11] tcp: Factorise cookie req initialisation.
Date: Mon, 20 Nov 2023 14:23:37 -0800
Message-ID: <20231120222341.54776-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF, and then some reqsk fields
are initialised in kfunc, and others are done in cookie_v[46]_check().

This patch factorises the common part as cookie_tcp_reqsk_init() and
calls it in cookie_tcp_reqsk_alloc() to minimise the discrepancy between
cookie_v[46]_check().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/syncookies.c | 69 ++++++++++++++++++++++++-------------------
 net/ipv6/syncookies.c | 14 ---------
 2 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 1e3783c97e28..9bca1c026525 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -285,10 +285,44 @@ bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
 }
 EXPORT_SYMBOL(cookie_ecn_ok);
 
+static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
+				 struct request_sock *req)
+{
+	struct inet_request_sock *ireq = inet_rsk(req);
+	struct tcp_request_sock *treq = tcp_rsk(req);
+	const struct tcphdr *th = tcp_hdr(skb);
+
+	req->num_retrans = 0;
+
+	ireq->ir_num = ntohs(th->dest);
+	ireq->ir_rmt_port = th->source;
+	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
+	ireq->ir_mark = inet_request_mark(sk, skb);
+
+	if (IS_ENABLED(CONFIG_SMC))
+		ireq->smc_ok = 0;
+
+	treq->snt_synack = 0;
+	treq->tfo_listener = false;
+	treq->txhash = net_tx_rndhash();
+	treq->rcv_isn = ntohl(th->seq) - 1;
+	treq->snt_isn = ntohl(th->ack_seq) - 1;
+	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
+	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
+	treq->req_usec_ts = false;
+
+#if IS_ENABLED(CONFIG_MPTCP)
+	treq->is_mptcp = sk_is_mptcp(sk);
+	if (treq->is_mptcp)
+		return mptcp_subflow_init_cookie_req(req, sk, skb);
+#endif
+
+	return 0;
+}
+
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct sock *sk, struct sk_buff *skb)
 {
-	struct tcp_request_sock *treq;
 	struct request_sock *req;
 
 	if (sk_is_mptcp(sk))
@@ -299,22 +333,10 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 	if (!req)
 		return NULL;
 
-	treq = tcp_rsk(req);
-
-	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
-	treq->req_usec_ts = false;
-
-#if IS_ENABLED(CONFIG_MPTCP)
-	treq->is_mptcp = sk_is_mptcp(sk);
-	if (treq->is_mptcp) {
-		int err = mptcp_subflow_init_cookie_req(req, sk, skb);
-
-		if (err) {
-			reqsk_free(req);
-			return NULL;
-		}
+	if (cookie_tcp_reqsk_init(sk, skb, req)) {
+		reqsk_free(req);
+		return NULL;
 	}
-#endif
 
 	return req;
 }
@@ -376,28 +398,15 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
-	treq->rcv_isn		= ntohl(th->seq) - 1;
-	treq->snt_isn		= ntohl(th->ack_seq) - 1;
 	treq->ts_off		= tsoff;
-	treq->txhash		= net_tx_rndhash();
 	req->mss		= mss;
-	ireq->ir_num		= ntohs(th->dest);
-	ireq->ir_rmt_port	= th->source;
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
-	ireq->ir_mark		= inet_request_mark(sk, skb);
 	ireq->snd_wscale	= tcp_opt.snd_wscale;
 	ireq->sack_ok		= tcp_opt.sack_ok;
 	ireq->wscale_ok		= tcp_opt.wscale_ok;
 	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
-	treq->snt_synack	= 0;
-	treq->tfo_listener	= false;
-
-	if (IS_ENABLED(CONFIG_SMC))
-		ireq->smc_ok = 0;
-
-	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
 
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
@@ -409,8 +418,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET);
 
-	req->num_retrans = 0;
-
 	/*
 	 * We need to lookup the route here to get at the correct
 	 * window size. We should better make sure that the window size
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 12b1809245f9..e0a9220d1536 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -178,11 +178,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
-	treq->tfo_listener = false;
 
 	req->mss = mss;
-	ireq->ir_rmt_port = th->source;
-	ireq->ir_num = ntohs(th->dest);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 
@@ -196,31 +193,20 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		ireq->pktopts = skb;
 	}
 
-	ireq->ir_iif = inet_request_bound_dev_if(sk, skb);
 	/* So that link locals have meaning */
 	if (!sk->sk_bound_dev_if &&
 	    ipv6_addr_type(&ireq->ir_v6_rmt_addr) & IPV6_ADDR_LINKLOCAL)
 		ireq->ir_iif = tcp_v6_iif(skb);
 
-	ireq->ir_mark = inet_request_mark(sk, skb);
-
-	req->num_retrans = 0;
 	ireq->snd_wscale	= tcp_opt.snd_wscale;
 	ireq->sack_ok		= tcp_opt.sack_ok;
 	ireq->wscale_ok		= tcp_opt.wscale_ok;
 	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
-	treq->snt_synack	= 0;
-	treq->rcv_isn = ntohl(th->seq) - 1;
-	treq->snt_isn = ntohl(th->ack_seq) - 1;
 	treq->ts_off = tsoff;
-	treq->txhash = net_tx_rndhash();
 
 	tcp_ao_syncookie(sk, skb, req, AF_INET6);
 
-	if (IS_ENABLED(CONFIG_SMC))
-		ireq->smc_ok = 0;
-
 	/*
 	 * We need to lookup the dst_entry to get the correct window size.
 	 * This is taken from tcp_v6_syn_recv_sock.  Somebody please enlighten
-- 
2.30.2


