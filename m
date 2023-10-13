Return-Path: <bpf+bounces-12188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F4E7C900A
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91401C20A6C
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93A82B5D5;
	Fri, 13 Oct 2023 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aylXIMzL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852028E1F;
	Fri, 13 Oct 2023 22:07:05 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37628BE;
	Fri, 13 Oct 2023 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234823; x=1728770823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PiFJgedULXgoxnb8BlFAD5PdGwQN+lzRHSU/6rKUfS8=;
  b=aylXIMzLQ3xF2vi/xlIPIxWfp5JTOdeqINNmz4MKvTTC7A7V7wx+9rpm
   it+KYQWiAKzHtod39Ba8a6U0TCFa65O5CiViFahxl326QSaJ+SXdSvMSZ
   CiMWdy7DDsfcGALAF6V4tpwlumeY6SpUucyHQZdqrJwBqhaFsp15WfVg5
   M=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="35692211"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:07:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 4F26840D6F;
	Fri, 13 Oct 2023 22:06:56 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:06:48 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:06:43 +0000
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
Subject: [PATCH v1 bpf-next 04/11] tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
Date: Fri, 13 Oct 2023 15:04:26 -0700
Message-ID: <20231013220433.70792-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013220433.70792-1-kuniyu@amazon.com>
References: <20231013220433.70792-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.60]
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we create a full socket from SYN Cookie, we initialise
tcp_sk(sk)->tsoffset redundantly in tcp_get_cookie_sock() as
the field is inherited from tcp_rsk(req)->ts_off.

  cookie_v[46]_check
  | - treq->ts_off = 0 <------------------------- (0)
  ` - tcp_get_cookie_sock
      |- tcp_v[46]_syn_recv_sock
      |  `- tcp_create_openreq_child
      |	    `- newtp->tsoffset = treq->ts_off <-- (1)
      `- tcp_sk(child)->tsoffset = tsoff <------- (2)

Let's initialise tcp_rsk(req)->ts_off with the correct offset
and remove the second initialisation of tcp_sk(sk)->tsoffset.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/syncookies.c | 7 +++----
 net/ipv6/syncookies.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 91688d0dadcd..676618c89bb7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -477,7 +477,7 @@ void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb);
 /* From syncookies.c */
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
-				 struct dst_entry *dst, u32 tsoff);
+				 struct dst_entry *dst);
 int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th,
 		      u32 cookie);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index b0cf6f4d66d8..514f1a4abdee 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -198,7 +198,7 @@ EXPORT_SYMBOL_GPL(__cookie_v4_check);
 
 struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req,
-				 struct dst_entry *dst, u32 tsoff)
+				 struct dst_entry *dst)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct sock *child;
@@ -208,7 +208,6 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 						 NULL, &own_req);
 	if (child) {
 		refcount_set(&req->rsk_refcnt, 1);
-		tcp_sk(child)->tsoffset = tsoff;
 		sock_rps_save_rxhash(child, skb);
 
 		if (rsk_drop_req(req)) {
@@ -378,7 +377,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	treq = tcp_rsk(req);
 	treq->rcv_isn		= ntohl(th->seq) - 1;
 	treq->snt_isn		= cookie;
-	treq->ts_off		= 0;
+	treq->ts_off		= tsoff;
 	treq->txhash		= net_tx_rndhash();
 	req->mss		= mss;
 	ireq->ir_num		= ntohs(th->dest);
@@ -441,7 +440,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	ireq->rcv_wscale  = rcv_wscale;
 	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, &rt->dst);
 
-	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst, tsoff);
+	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
 	 * Normal sockets get it right from inet_csk_route_child_sock()
 	 */
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index b8ef6efbb60e..60bdc4d9150b 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -212,7 +212,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->snt_synack	= 0;
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = cookie;
-	treq->ts_off = 0;
+	treq->ts_off = tsoff;
 	treq->txhash = net_tx_rndhash();
 	if (IS_ENABLED(CONFIG_SMC))
 		ireq->smc_ok = 0;
@@ -257,7 +257,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, dst);
 
-	ret = tcp_get_cookie_sock(sk, skb, req, dst, tsoff);
+	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 out:
 	return ret;
 out_free:
-- 
2.30.2


