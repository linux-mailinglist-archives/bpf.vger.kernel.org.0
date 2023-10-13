Return-Path: <bpf+bounces-12190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B97C900E
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B453B20B86
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A772B5F6;
	Fri, 13 Oct 2023 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YYO/3XOj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60D28E1F;
	Fri, 13 Oct 2023 22:07:46 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D67B7;
	Fri, 13 Oct 2023 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234864; x=1728770864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ImvM0k9dvXEH4c0l65Talt6Jwois7I6OLaujPp1yOdw=;
  b=YYO/3XOjvJA1nxbIDvoDcR2EmT/V4VHFHsrbepNKHb+xsWU2HHikACKs
   8FuhwdRlVd9AqcNSgCbc98+8jMyqmJz8ODbsuXKF2w/NzO5dWf2kt/M3o
   rEZIBbmSH2n1aAYyBCVVMR9Z/0kl6HZBgLHHZz06OjEbb0Iu2p/pmtZ1r
   A=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="245031530"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:07:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id E38F760B70;
	Fri, 13 Oct 2023 22:07:41 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:07:39 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:07:35 +0000
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
Subject: [PATCH v1 bpf-next 06/11] bpf: tcp: Add SYN Cookie validation SOCK_OPS hook.
Date: Fri, 13 Oct 2023 15:04:28 -0700
Message-ID: <20231013220433.70792-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new SOCK_OPS hook to validate arbitrary SYN Cookie.

When the kernel receives ACK for SYN Cookie, the hook is invoked with
bpf_sock_ops.op == BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB if the listener has
BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG set by bpf_sock_ops_cb_flags_set().

The BPF program can access the following information to validate ISN:

  bpf_sock_ops.sk      : 4-tuple
  bpf_sock_ops.skb     : TCP header
  bpf_sock_ops.args[0] : ISN

The program must decode MSS and set it to bpf_sock_ops.replylong[0].

By default, the kernel validates SYN Cookie before allocating reqsk, but
the hook is invoked after allocating reqsk to keep the user interface
consistent with BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h              | 12 ++++++
 include/uapi/linux/bpf.h       | 20 +++++++---
 net/ipv4/syncookies.c          | 73 +++++++++++++++++++++++++++-------
 net/ipv6/syncookies.c          | 44 +++++++++++++-------
 tools/include/uapi/linux/bpf.h | 20 +++++++---
 5 files changed, 130 insertions(+), 39 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 676618c89bb7..90d95acdc34a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2158,6 +2158,18 @@ static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
 	return ops->cookie_init_seq(skb, mss);
 }
+
+#ifdef CONFIG_CGROUP_BPF
+int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req,
+			   struct sk_buff *skb);
+#else
+static inline int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req,
+					 struct sk_buff *skb)
+{
+	return 0;
+}
+#endif
+
 #else
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
 					 const struct sock *sk, struct sk_buff *skb,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d3cc530613c0..e6f1507d7895 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6738,13 +6738,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
-	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK.
+	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK
+	 * and validates ACK for SYN Cookie.
 	 *
-	 * The bpf prog will be called to encode MSS into SYN Cookie with
-	 * sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
+	 * The bpf prog will be first called to encode MSS into SYN Cookie
+	 * with sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.  Then, the
+	 * bpf prog will be called to decode MSS from SYN Cookie with
+	 * sock_ops->op == BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
 	 *
-	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB for
-	 * input and output.
+	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
+	 * BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB for input and output.
 	 */
 	BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
@@ -6868,6 +6871,13 @@ enum {
 					 *
 					 * replylong[0]: ISN
 					 */
+	BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB,/* Validate SYN Cookie and set
+					 * MSS.
+					 *
+					 * args[0]: ISN
+					 *
+					 * replylong[0]: MSS
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 514f1a4abdee..b1dd415863ff 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -317,6 +317,37 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 }
 EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
 
+#if IS_ENABLED(CONFIG_CGROUP_BPF) && IS_ENABLED(CONFIG_SYN_COOKIES)
+int bpf_skops_cookie_check(struct sock *sk, struct request_sock *req, struct sk_buff *skb)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+
+	sock_ops.op = BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB;
+	sock_ops.sk = req_to_sk(req);
+	sock_ops.args[0] = tcp_rsk(req)->snt_isn;
+
+	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
+
+	if (BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk))
+		goto err;
+
+	if (!sock_ops.replylong[0])
+		goto err;
+
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESRECV);
+
+	return sock_ops.replylong[0];
+
+err:
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESFAILED);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bpf_skops_cookie_check);
+#endif
+
 /* On input, sk is a listener.
  * Output is listener if incoming packet would not create a child
  *           NULL if memory could not be allocated.
@@ -336,6 +367,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	int full_space, mss;
 	struct flowi4 fl4;
 	struct rtable *rt;
+	bool bpf_cookie;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
 
@@ -343,16 +375,19 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	    !th->ack || th->rst)
 		goto out;
 
-	if (tcp_synq_no_recent_overflow(sk))
-		goto out;
+	bpf_cookie = BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG);
+	if (!bpf_cookie) {
+		if (tcp_synq_no_recent_overflow(sk))
+			goto out;
 
-	mss = __cookie_v4_check(ip_hdr(skb), th, cookie);
-	if (mss == 0) {
-		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
-		goto out;
-	}
+		mss = __cookie_v4_check(ip_hdr(skb), th, cookie);
+		if (mss == 0) {
+			__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
+			goto out;
+		}
 
-	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
+	}
 
 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
@@ -365,7 +400,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
-	if (!cookie_timestamp_decode(net, &tcp_opt))
+	if (!bpf_cookie && !cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
 	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops,
@@ -375,21 +410,31 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
-	treq->rcv_isn		= ntohl(th->seq) - 1;
-	treq->snt_isn		= cookie;
-	treq->ts_off		= tsoff;
-	treq->txhash		= net_tx_rndhash();
-	req->mss		= mss;
 	ireq->ir_num		= ntohs(th->dest);
 	ireq->ir_rmt_port	= th->source;
+	treq->snt_isn		= cookie;
+
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
+
+	if (bpf_cookie) {
+		mss = bpf_skops_cookie_check(sk, req, skb);
+		if (!mss) {
+			reqsk_free(req);
+			goto out;
+		}
+	}
+
+	req->mss		= mss;
 	ireq->ir_mark		= inet_request_mark(sk, skb);
 	ireq->snd_wscale	= tcp_opt.snd_wscale;
 	ireq->sack_ok		= tcp_opt.sack_ok;
 	ireq->wscale_ok		= tcp_opt.wscale_ok;
 	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
+	treq->rcv_isn		= ntohl(th->seq) - 1;
+	treq->ts_off		= tsoff;
+	treq->txhash		= net_tx_rndhash();
 	treq->snt_synack	= 0;
 	treq->tfo_listener	= false;
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 60bdc4d9150b..3e920e7eb5d3 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -139,6 +139,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	struct dst_entry *dst;
 	struct sock *ret = sk;
 	int full_space, mss;
+	bool bpf_cookie;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
 
@@ -146,16 +147,19 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	    !th->ack || th->rst)
 		goto out;
 
-	if (tcp_synq_no_recent_overflow(sk))
-		goto out;
+	bpf_cookie = BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG);
+	if (!bpf_cookie) {
+		if (tcp_synq_no_recent_overflow(sk))
+			goto out;
 
-	mss = __cookie_v6_check(ipv6_hdr(skb), th, cookie);
-	if (mss == 0) {
-		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
-		goto out;
-	}
+		mss = __cookie_v6_check(ipv6_hdr(skb), th, cookie);
+		if (mss == 0) {
+			__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
+			goto out;
+		}
 
-	__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
+	}
 
 	/* check for timestamp cookie support */
 	memset(&tcp_opt, 0, sizeof(tcp_opt));
@@ -168,7 +172,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
-	if (!cookie_timestamp_decode(net, &tcp_opt))
+	if (!bpf_cookie && !cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
 	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops,
@@ -177,17 +181,25 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		goto out_drop;
 
 	ireq = inet_rsk(req);
+	ireq->ir_rmt_port = th->source;
+	ireq->ir_num = ntohs(th->dest);
+	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
+	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
+
 	treq = tcp_rsk(req);
-	treq->tfo_listener = false;
+	treq->snt_isn = cookie;
+
+	if (bpf_cookie) {
+		mss = bpf_skops_cookie_check(sk, req, skb);
+		if (!mss) {
+			reqsk_free(req);
+			goto out;
+		}
+	}
 
 	if (security_inet_conn_request(sk, skb, req))
 		goto out_free;
 
-	req->mss = mss;
-	ireq->ir_rmt_port = th->source;
-	ireq->ir_num = ntohs(th->dest);
-	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
-	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
 	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
@@ -203,6 +215,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 
 	ireq->ir_mark = inet_request_mark(sk, skb);
 
+	req->mss = mss;
 	req->num_retrans = 0;
 	ireq->snd_wscale	= tcp_opt.snd_wscale;
 	ireq->sack_ok		= tcp_opt.sack_ok;
@@ -210,6 +223,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->tstamp_ok		= tcp_opt.saw_tstamp;
 	req->ts_recent		= tcp_opt.saw_tstamp ? tcp_opt.rcv_tsval : 0;
 	treq->snt_synack	= 0;
+	treq->tfo_listener = false;
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = cookie;
 	treq->ts_off = tsoff;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d3cc530613c0..e6f1507d7895 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6738,13 +6738,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
-	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK.
+	/* Call bpf when the kernel generates SYN Cookie (ISN) for SYN+ACK
+	 * and validates ACK for SYN Cookie.
 	 *
-	 * The bpf prog will be called to encode MSS into SYN Cookie with
-	 * sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.
+	 * The bpf prog will be first called to encode MSS into SYN Cookie
+	 * with sock_ops->op == BPF_SOCK_OPS_GEN_SYNCOOKIE_CB.  Then, the
+	 * bpf prog will be called to decode MSS from SYN Cookie with
+	 * sock_ops->op == BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB.
 	 *
-	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB for
-	 * input and output.
+	 * Please refer to the comment in BPF_SOCK_OPS_GEN_SYNCOOKIE_CB and
+	 * BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB for input and output.
 	 */
 	BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
@@ -6868,6 +6871,13 @@ enum {
 					 *
 					 * replylong[0]: ISN
 					 */
+	BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB,/* Validate SYN Cookie and set
+					 * MSS.
+					 *
+					 * args[0]: ISN
+					 *
+					 * replylong[0]: MSS
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.30.2


