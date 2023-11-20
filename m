Return-Path: <bpf+bounces-15425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4177F203A
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B3EB219D6
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CCC39878;
	Mon, 20 Nov 2023 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FQk+i8Z3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD30ED8;
	Mon, 20 Nov 2023 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700519126; x=1732055126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yYLlb5n0UieUbkQyodcteK0sltQb9GBOvK/pMQSwaB8=;
  b=FQk+i8Z3ve9rgZJ0MTKIy8FKVPqj0J4sRmdgN08fH1tGfU5+c95DgsNL
   A0RgWmQ7KSqZaXZ+tbwEcf9XiHVJ7ft4LEU67vwGzjFU9hi8KneFJQHe4
   yUQNpL/2TJw6jaiRLZ7cd7/D+RtXqLDaEbYhHMJNojBaxK3AgBfTADe9B
   w=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="363932543"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:25:23 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 044BD49E78;
	Mon, 20 Nov 2023 22:25:17 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:60936]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.6:2525] with esmtp (Farcaster)
 id 52d17316-ef6d-4aaf-b85a-0492a131bd8b; Mon, 20 Nov 2023 22:25:17 +0000 (UTC)
X-Farcaster-Flow-ID: 52d17316-ef6d-4aaf-b85a-0492a131bd8b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:25:16 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 20 Nov 2023 22:25:12 +0000
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
Subject: [PATCH v2 bpf-next 03/11] tcp: Clean up goto labels in cookie_v[46]_check().
Date: Mon, 20 Nov 2023 14:23:33 -0800
Message-ID: <20231120222341.54776-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF, and then reqsk
will be preallocated before cookie_v[46]_check().

Depending on how validation fails, we send RST or just drop skb.

To make the error handling easier, let's clean up goto labels.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/syncookies.c | 22 +++++++++++-----------
 net/ipv6/syncookies.c |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index fb41bb18fe6b..8b7d7d7788af 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -376,11 +376,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	ret = NULL;
 	req = cookie_tcp_reqsk_alloc(&tcp_request_sock_ops,
 				     &tcp_request_sock_ipv4_ops, sk, skb);
 	if (!req)
-		goto out;
+		goto out_drop;
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
@@ -415,10 +414,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
 
-	if (security_inet_conn_request(sk, skb, req)) {
-		reqsk_free(req);
-		goto out;
-	}
+	if (security_inet_conn_request(sk, skb, req))
+		goto out_free;
 
 	req->num_retrans = 0;
 
@@ -435,10 +432,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
 	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt)) {
-		reqsk_free(req);
-		goto out;
-	}
+	if (IS_ERR(rt))
+		goto out_free;
 
 	/* Try to redo what tcp_v4_send_synack did. */
 	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
@@ -462,5 +457,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (ret)
 		inet_sk(ret)->cork.fl.u.ip4 = fl4;
-out:	return ret;
+out:
+	return ret;
+out_free:
+	reqsk_free(req);
+out_drop:
+	return NULL;
 }
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index ba394fa73f41..106376cbc9de 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -172,11 +172,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (!cookie_timestamp_decode(net, &tcp_opt))
 		goto out;
 
-	ret = NULL;
 	req = cookie_tcp_reqsk_alloc(&tcp6_request_sock_ops,
 				     &tcp_request_sock_ipv6_ops, sk, skb);
 	if (!req)
-		goto out;
+		goto out_drop;
 
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
@@ -269,5 +268,6 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	return ret;
 out_free:
 	reqsk_free(req);
+out_drop:
 	return NULL;
 }
-- 
2.30.2


