Return-Path: <bpf+bounces-12185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C67C9004
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2D0B20B91
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42752943C;
	Fri, 13 Oct 2023 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hQ0ZxKJs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE732376A;
	Fri, 13 Oct 2023 22:05:42 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DFBE;
	Fri, 13 Oct 2023 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697234742; x=1728770742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=akkCOV4E+AxdN/Jk4vmKptN8nw12t+3ZNRvL4pniTfU=;
  b=hQ0ZxKJsFiJi2E0pK8yarcMnWyEO2Zw4xNSCGrjhyo0LmNxss5aq2gCn
   /6RvhSo9/kbCKJnpOGLfGiFdMQebTTJHGma8O0ear90LqQywGcX14/pRg
   dw9NT6x+Y9nYZXyEp58QcE24SygHJphoNVHnokj9nj8VeGfNdx0A2/Zb7
   s=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="245031212"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:05:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 2EE3560D44;
	Fri, 13 Oct 2023 22:05:33 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:05:30 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:05:26 +0000
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
Subject: [PATCH v1 bpf-next 01/11] tcp: Clean up reverse xmas tree in cookie_v[46]_check().
Date: Fri, 13 Oct 2023 15:04:23 -0700
Message-ID: <20231013220433.70792-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We will grow and cut the xmas tree a bit, so let's clean it up
to make later patches easy to review.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/syncookies.c | 10 +++++-----
 net/ipv6/syncookies.c | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index dc478a0574cb..174eaddc28b5 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -325,18 +325,18 @@ EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
 struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 {
 	struct ip_options *opt = &TCP_SKB_CB(skb)->header.h4.opt;
+	const struct tcphdr *th = tcp_hdr(skb);
+	__u32 cookie = ntohl(th->ack_seq) - 1;
 	struct tcp_options_received tcp_opt;
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
-	struct tcp_sock *tp = tcp_sk(sk);
-	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
-	struct sock *ret = sk;
 	struct request_sock *req;
+	struct sock *ret = sk;
 	int full_space, mss;
+	struct flowi4 fl4;
 	struct rtable *rt;
 	__u8 rcv_wscale;
-	struct flowi4 fl4;
 	u32 tsoff = 0;
 
 	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies) ||
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 5014aa663452..894d5ae312d1 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -127,17 +127,17 @@ EXPORT_SYMBOL_GPL(__cookie_v6_check);
 
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 {
+	const struct tcphdr *th = tcp_hdr(skb);
+	__u32 cookie = ntohl(th->ack_seq) - 1;
+	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct tcp_options_received tcp_opt;
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct tcp_request_sock *treq;
-	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct tcp_sock *tp = tcp_sk(sk);
-	const struct tcphdr *th = tcp_hdr(skb);
-	__u32 cookie = ntohl(th->ack_seq) - 1;
-	struct sock *ret = sk;
 	struct request_sock *req;
-	int full_space, mss;
 	struct dst_entry *dst;
+	struct sock *ret = sk;
+	int full_space, mss;
 	__u8 rcv_wscale;
 	u32 tsoff = 0;
 
-- 
2.30.2


