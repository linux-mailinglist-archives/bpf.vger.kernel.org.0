Return-Path: <bpf+bounces-12186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2ED7C9006
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525F3B20B9B
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F78D2AB3B;
	Fri, 13 Oct 2023 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WHSobaYl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAB2376A;
	Fri, 13 Oct 2023 22:06:12 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B2CBE;
	Fri, 13 Oct 2023 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234771; x=1728770771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AMKe1qX0yrACVdD6iB2yMhGGPwLt3Fp7fyyVuRjkb+o=;
  b=WHSobaYljmbcwwIXHscOewWfivPOfmdEDbOO+Rnl/FfJeHmLMC/TeoZC
   UMeSgWn+xEYV7N9qzJPWF91MI0SI24gywjyPMETN3Rk1rcvmWC07BEmqa
   2xuY3YWvU5Ae3+HVtEmd3St2hqzagvcCLgeFtENuTCmj5AhMD616iz+uZ
   c=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="245031288"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:06:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id A61EDA0AE1;
	Fri, 13 Oct 2023 22:06:05 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:05:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Fri, 13 Oct 2023 22:05:52 +0000
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
Subject: [PATCH v1 bpf-next 02/11] tcp: Cache sock_net(sk) in cookie_v[46]_check().
Date: Fri, 13 Oct 2023 15:04:24 -0700
Message-ID: <20231013220433.70792-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sock_net(sk) is used repeatedly in cookie_v[46]_check().
Let's cache it in a variable.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/syncookies.c | 19 ++++++++++---------
 net/ipv6/syncookies.c | 17 +++++++++--------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 174eaddc28b5..64280cf42667 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -330,6 +330,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct tcp_options_received tcp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
+	struct net *net = sock_net(sk);
 	struct tcp_request_sock *treq;
 	struct request_sock *req;
 	struct sock *ret = sk;
@@ -339,7 +340,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
 
-	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies) ||
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
 		goto out;
 
@@ -348,24 +349,24 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	mss = __cookie_v4_check(ip_hdr(skb), th, cookie);
 	if (mss == 0) {
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
 	}
 
-	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
+	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
 
 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
+	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
-		tsoff = secure_tcp_ts_off(sock_net(sk),
+		tsoff = secure_tcp_ts_off(net,
 					  ip_hdr(skb)->daddr,
 					  ip_hdr(skb)->saddr);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
-	if (!cookie_timestamp_decode(sock_net(sk), &tcp_opt))
+	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
 	ret = NULL;
@@ -402,7 +403,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	/* We throwed the options of the initial SYN away, so we hope
 	 * the ACK carries the same options again (see RFC1122 4.2.3.8)
 	 */
-	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(sock_net(sk), skb));
+	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
 	if (security_inet_conn_request(sk, skb, req)) {
 		reqsk_free(req);
@@ -423,7 +424,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   opt->srr ? opt->faddr : ireq->ir_rmt_addr,
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
-	rt = ip_route_output_key(sock_net(sk), &fl4);
+	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
 		reqsk_free(req);
 		goto out;
@@ -443,7 +444,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 				  dst_metric(&rt->dst, RTAX_INITRWND));
 
 	ireq->rcv_wscale  = rcv_wscale;
-	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, sock_net(sk), &rt->dst);
+	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, &rt->dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst, tsoff);
 	/* ip_queue_xmit() depends on our flow being setup
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 894d5ae312d1..cbee2df8a006 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -133,6 +133,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	struct tcp_options_received tcp_opt;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
+	struct net *net = sock_net(sk);
 	struct tcp_request_sock *treq;
 	struct request_sock *req;
 	struct dst_entry *dst;
@@ -141,7 +142,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
 
-	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies) ||
+	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
 		goto out;
 
@@ -150,24 +151,24 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 
 	mss = __cookie_v6_check(ipv6_hdr(skb), th, cookie);
 	if (mss == 0) {
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
 		goto out;
 	}
 
-	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
+	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
 
 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
-	tcp_parse_options(sock_net(sk), skb, &tcp_opt, 0, NULL);
+	tcp_parse_options(net, skb, &tcp_opt, 0, NULL);
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
-		tsoff = secure_tcpv6_ts_off(sock_net(sk),
+		tsoff = secure_tcpv6_ts_off(net,
 					    ipv6_hdr(skb)->daddr.s6_addr32,
 					    ipv6_hdr(skb)->saddr.s6_addr32);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
-	if (!cookie_timestamp_decode(sock_net(sk), &tcp_opt))
+	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
 	ret = NULL;
@@ -237,7 +238,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_uid = sk->sk_uid;
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
-		dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, final_p);
+		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
 		if (IS_ERR(dst))
 			goto out_free;
 	}
@@ -255,7 +256,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 				  dst_metric(dst, RTAX_INITRWND));
 
 	ireq->rcv_wscale = rcv_wscale;
-	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, sock_net(sk), dst);
+	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst, tsoff);
 out:
-- 
2.30.2


