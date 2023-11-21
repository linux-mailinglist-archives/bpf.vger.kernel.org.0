Return-Path: <bpf+bounces-15576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7937F365E
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E06B21066
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC148783;
	Tue, 21 Nov 2023 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TVbbC44G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FBCD1;
	Tue, 21 Nov 2023 10:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700592313; x=1732128313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTXVYsjHlXxS4ygF6uxrwNsUA9p+2KM2DEkM38vXuYc=;
  b=TVbbC44Glr+zNFXJR2kONHBUWfqMDPnDG7buqUk+P13y+FMvg6sVhEQS
   0LxwSpbLlFokjDjRhEpVLgjYf9MiFdt+NvdpRGviBSy19OqmES7pvhHur
   S9Fa7thC+DeQaTQVhwr12/V/hNFeGOzG4mNeRaMvIKwDxvRXH6xpPUgR/
   A=;
X-IronPort-AV: E=Sophos;i="6.04,216,1695686400"; 
   d="scan'208";a="377947874"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:45:07 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 6422660A30;
	Tue, 21 Nov 2023 18:45:05 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:22380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.37:2525] with esmtp (Farcaster)
 id 91831ecf-01a7-4b79-a7d5-8f140c86a7da; Tue, 21 Nov 2023 18:45:05 +0000 (UTC)
X-Farcaster-Flow-ID: 91831ecf-01a7-4b79-a7d5-8f140c86a7da
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:45:04 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:45:00 +0000
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
Subject: [PATCH v3 bpf-next 05/11] tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
Date: Tue, 21 Nov 2023 10:42:39 -0800
Message-ID: <20231121184245.69569-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

When we create a full socket from SYN Cookie, we initialise
tcp_sk(sk)->tsoffset redundantly in tcp_get_cookie_sock() as
the field is inherited from tcp_rsk(req)->ts_off.

  cookie_v[46]_check
  |- treq->ts_off = 0
  `- tcp_get_cookie_sock
     |- tcp_v[46]_syn_recv_sock
     |  `- tcp_create_openreq_child
     |	   `- newtp->tsoffset = treq->ts_off
     `- tcp_sk(child)->tsoffset = tsoff

Let's initialise tcp_rsk(req)->ts_off with the correct offset
and remove the second initialisation of tcp_sk(sk)->tsoffset.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/syncookies.c | 7 +++----
 net/ipv6/syncookies.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2b2c79c7bbcd..cc7143a781da 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -490,7 +490,7 @@ void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb);
 /* From syncookies.c */
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
-				 struct dst_entry *dst, u32 tsoff);
+				 struct dst_entry *dst);
 int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index c08428d63d11..de051eb08db8 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -204,7 +204,7 @@ EXPORT_SYMBOL_GPL(__cookie_v4_check);
 
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
-				 struct dst_entry *dst, u32 tsoff)
+				 struct dst_entry *dst)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct sock *child;
@@ -214,7 +214,6 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 						 NULL, &own_req);
 	if (child) {
 		refcount_set(&req->rsk_refcnt, 1);
-		tcp_sk(child)->tsoffset = tsoff;
 		sock_rps_save_rxhash(child, skb);
 
 		if (rsk_drop_req(req)) {
@@ -386,7 +385,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	treq = tcp_rsk(req);
 	treq->rcv_isn		= ntohl(th->seq) - 1;
 	treq->snt_isn		= ntohl(th->ack_seq) - 1;
-	treq->ts_off		= 0;
+	treq->ts_off		= tsoff;
 	treq->txhash		= net_tx_rndhash();
 	req->mss		= mss;
 	ireq->ir_num		= ntohs(th->dest);
@@ -452,7 +451,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	ireq->rcv_wscale  = rcv_wscale;
 	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, &rt->dst);
 
-	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst, tsoff);
+	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4cd26c481168..18c2e3c1677b 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -215,7 +215,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->snt_synack	= 0;
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
-	treq->ts_off = 0;
+	treq->ts_off = tsoff;
 	treq->txhash = net_tx_rndhash();
 
 	l3index = l3mdev_master_ifindex_by_index(net, ireq->ir_iif);
@@ -264,7 +264,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, dst);
 
-	ret = tcp_get_cookie_sock(sk, skb, req, dst, tsoff);
+	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 out:
 	return ret;
 out_free:
-- 
2.30.2


