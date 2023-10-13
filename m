Return-Path: <bpf+bounces-12193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298C7C9014
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7538D1C21290
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72F2B5FD;
	Fri, 13 Oct 2023 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hPgTExoZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3528E14;
	Fri, 13 Oct 2023 22:09:02 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07668B7;
	Fri, 13 Oct 2023 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234941; x=1728770941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUd0me7DPt4Hknray8dhvkAHrpDElyBmY35W+kyF1U4=;
  b=hPgTExoZ/C6ytNsDGQIYLHIN0CsoQPsE+qXg06u2KMzBbUC4vsKMHdSg
   XhwRAEYDnaS31cWRMMc4B0vTjZ/Zfgenkq496oXz8Ea+Yvn4cJGxEmZ8+
   1VbOcA5AQY3MAKdhGo09bYeAyiwYuQk/LrIEaQ033DSgVnWuntZ5/pinP
   k=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="361839329"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:08:58 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id 5103489C3E;
	Fri, 13 Oct 2023 22:08:57 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:08:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Fri, 13 Oct 2023 22:08:52 +0000
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
Subject: [PATCH v1 bpf-next 09/11] tcp: Split cookie_ecn_ok().
Date: Fri, 13 Oct 2023 15:04:31 -0700
Message-ID: <20231013220433.70792-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch is a prerequisite for the following change.

For non-BPF SYN Cookie, inet_rsk(req)->ecn_ok is initialised with
tcp_opt->rcv_tsecr & TS_OPT_ECN.  OTOH, we will initialise it
differently for BPF SYN Cookie.

Then, inet_rsk(req)->ecn_ok is updated with net->ipv4.sysctl_tcp_ecn
or dst_feature(dst, RTAX_FEATURE_ECN).

Now cookie_ecn_ok() is just oneliner, but TS_OPT_ECN is only available
in net/ipv4/syncookies.c.  Instead of exporting the function, we move
it and TS_OPT_XXX to tcp.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/tcp.h     | 31 +++++++++++++++++++++++++++++--
 net/ipv4/syncookies.c | 43 +++----------------------------------------
 net/ipv6/syncookies.c |  4 +++-
 3 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4fe19917db6c..143f47c28312 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -569,8 +569,35 @@ __u32 cookie_v4_init_sequence(const struct sk_buff *skb, __u16 *mss);
 u64 cookie_init_timestamp(struct request_sock *req, u64 now);
 bool cookie_timestamp_decode(const struct net *net,
 			     struct tcp_options_received *opt);
-bool cookie_ecn_ok(const struct tcp_options_received *opt,
-		   const struct net *net, const struct dst_entry *dst);
+
+/* TCP Timestamp: 6 lowest bits of timestamp sent in the cookie SYN-ACK
+ * stores TCP options:
+ *
+ * MSB                               LSB
+ * | 31 ...   6 |  5  |  4   | 3 2 1 0 |
+ * |  Timestamp | ECN | SACK | WScale  |
+ *
+ * When we receive a valid cookie-ACK, we look at the echoed tsval (if
+ * any) to figure out which TCP options we should use for the rebuilt
+ * connection.
+ *
+ * A WScale setting of '0xf' (which is an invalid scaling value)
+ * means that original syn did not include the TCP window scaling option.
+ */
+#define TS_OPT_WSCALE_MASK	0xf
+#define TS_OPT_SACK		BIT(4)
+#define TS_OPT_ECN		BIT(5)
+/* There is no TS_OPT_TIMESTAMP:
+ * if ACK contains timestamp option, we already know it was
+ * requested/supported by the syn/synack exchange.
+ */
+#define TSBITS	6
+#define TSMASK	(((__u32)1 << TSBITS) - 1)
+
+static inline bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt)
+{
+	return tcp_opt->rcv_tsecr & TS_OPT_ECN;
+}
 
 /* From net/ipv6/syncookies.c */
 int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th,
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index f78566991e08..ff979cc314da 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -19,30 +19,6 @@ static siphash_aligned_key_t syncookie_secret[2];
 #define COOKIEBITS 24	/* Upper bits store count */
 #define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
 
-/* TCP Timestamp: 6 lowest bits of timestamp sent in the cookie SYN-ACK
- * stores TCP options:
- *
- * MSB                               LSB
- * | 31 ...   6 |  5  |  4   | 3 2 1 0 |
- * |  Timestamp | ECN | SACK | WScale  |
- *
- * When we receive a valid cookie-ACK, we look at the echoed tsval (if
- * any) to figure out which TCP options we should use for the rebuilt
- * connection.
- *
- * A WScale setting of '0xf' (which is an invalid scaling value)
- * means that original syn did not include the TCP window scaling option.
- */
-#define TS_OPT_WSCALE_MASK	0xf
-#define TS_OPT_SACK		BIT(4)
-#define TS_OPT_ECN		BIT(5)
-/* There is no TS_OPT_TIMESTAMP:
- * if ACK contains timestamp option, we already know it was
- * requested/supported by the syn/synack exchange.
- */
-#define TSBITS	6
-#define TSMASK	(((__u32)1 << TSBITS) - 1)
-
 static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
 		       u32 count, int c)
 {
@@ -266,21 +242,6 @@ bool cookie_timestamp_decode(const struct net *net,
 }
 EXPORT_SYMBOL(cookie_timestamp_decode);
 
-bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
-		   const struct net *net, const struct dst_entry *dst)
-{
-	bool ecn_ok = tcp_opt->rcv_tsecr & TS_OPT_ECN;
-
-	if (!ecn_ok)
-		return false;
-
-	if (READ_ONCE(net->ipv4.sysctl_tcp_ecn))
-		return true;
-
-	return dst_feature(dst, RTAX_FEATURE_ECN);
-}
-EXPORT_SYMBOL(cookie_ecn_ok);
-
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    const struct tcp_request_sock_ops *af_ops,
 					    struct sock *sk,
@@ -438,6 +399,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			goto out;
 		}
 	} else {
+		ireq->ecn_ok = cookie_ecn_ok(&tcp_opt);
 		treq->ts_off = tsoff;
 	}
 
@@ -498,7 +460,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 				  dst_metric(&rt->dst, RTAX_INITRWND));
 
 	ireq->rcv_wscale  = rcv_wscale;
-	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, &rt->dst);
+	ireq->ecn_ok &= READ_ONCE(net->ipv4.sysctl_tcp_ecn) ||
+		dst_feature(&rt->dst, RTAX_FEATURE_ECN);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index b0a7ea75a504..f4c0cb463e02 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -198,6 +198,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 			goto out;
 		}
 	} else {
+		ireq->ecn_ok = cookie_ecn_ok(&tcp_opt);
 		treq->ts_off = tsoff;
 	}
 
@@ -272,7 +273,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 				  dst_metric(dst, RTAX_INITRWND));
 
 	ireq->rcv_wscale = rcv_wscale;
-	ireq->ecn_ok = cookie_ecn_ok(&tcp_opt, net, dst);
+	ireq->ecn_ok &= READ_ONCE(net->ipv4.sysctl_tcp_ecn) ||
+		dst_feature(dst, RTAX_FEATURE_ECN);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 out:
-- 
2.30.2


