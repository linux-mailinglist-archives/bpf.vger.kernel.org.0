Return-Path: <bpf+bounces-15574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E397F3658
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EDF1F231FC
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E21389;
	Tue, 21 Nov 2023 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TKk4tyR0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E812E;
	Tue, 21 Nov 2023 10:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700592262; x=1732128262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yYLlb5n0UieUbkQyodcteK0sltQb9GBOvK/pMQSwaB8=;
  b=TKk4tyR05OeS8aHle6G/NVoCtdQDj93AQ4F6tirQy53ADF01iuaelM2f
   mwZUe+MBa/g4NlGakPS8jLYDNdFUBE6k+vCCT3mAdQ3FRig2gWQLmdj9g
   vzfNYDqrDL9U1bzmzy1BQTQY4WJlI8AjnddWW0y1xl+aTkfbcz3qt+JZF
   8=;
X-IronPort-AV: E=Sophos;i="6.04,216,1695686400"; 
   d="scan'208";a="364193721"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:44:20 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id 5A55365B5B;
	Tue, 21 Nov 2023 18:44:15 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:39576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.176:2525] with esmtp (Farcaster)
 id 86ed2bc3-5411-4d9d-bbe8-b652de1e61ca; Tue, 21 Nov 2023 18:44:14 +0000 (UTC)
X-Farcaster-Flow-ID: 86ed2bc3-5411-4d9d-bbe8-b652de1e61ca
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:44:14 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 21 Nov 2023 18:44:10 +0000
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
Subject: [PATCH v3 bpf-next 03/11] tcp: Clean up goto labels in cookie_v[46]_check().
Date: Tue, 21 Nov 2023 10:42:37 -0800
Message-ID: <20231121184245.69569-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
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


