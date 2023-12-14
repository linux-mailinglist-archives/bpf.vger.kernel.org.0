Return-Path: <bpf+bounces-17846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8867813566
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD9F282BDB
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F55E0A5;
	Thu, 14 Dec 2023 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WQp31+zc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C310F;
	Thu, 14 Dec 2023 07:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702569345; x=1734105345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G27pj8LYHdnN7TKoSD97L7HFiQjzVPM+Haa/cXT3hMM=;
  b=WQp31+zcTQBPnGbwhTm7DDBe0BClTjwIGmKAQFdnOD2KqbbSzHVf7fe4
   xiDdxmNX6Lj3rkth7xdN6CLresoM6FoAoozam9khDQHz9RWYB07D46QO4
   CTuyl6L+0FmEvWl4S8RwfRTFvqTX7FiLQ6yCccir8qj+neJ6dtZ4gBDft
   g=;
X-IronPort-AV: E=Sophos;i="6.04,275,1695686400"; 
   d="scan'208";a="382978500"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:55:37 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id 2E51B6107D;
	Thu, 14 Dec 2023 15:55:36 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:16776]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.95:2525] with esmtp (Farcaster)
 id 671ac1a8-3a9f-452c-80a5-26d411d1740f; Thu, 14 Dec 2023 15:55:35 +0000 (UTC)
X-Farcaster-Flow-ID: 671ac1a8-3a9f-452c-80a5-26d411d1740f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:55:35 +0000
Received: from 88665a182662.ant.amazon.com (10.143.92.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:55:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v6 bpf-next 2/6] tcp: Move skb_steal_sock() to request_sock.h
Date: Fri, 15 Dec 2023 00:54:20 +0900
Message-ID: <20231214155424.67136-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214155424.67136-1-kuniyu@amazon.com>
References: <20231214155424.67136-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF.

If BPF prog validates ACK and kfunc allocates a reqsk, it will
be carried to TCP stack as skb->sk with req->syncookie 1.

In skb_steal_sock(), we need to check inet_reqsk(sk)->syncookie
to see if the reqsk is created by kfunc.  However, inet_reqsk()
is not available in sock.h.

Let's move skb_steal_sock() to request_sock.h.

While at it, we refactor skb_steal_sock() so it returns early if
skb->sk is NULL to minimise the following patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/request_sock.h | 28 ++++++++++++++++++++++++++++
 include/net/sock.h         | 25 -------------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 144c39db9898..26c630c40abb 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -83,6 +83,34 @@ static inline struct sock *req_to_sk(struct request_sock *req)
 	return (struct sock *)req;
 }
 
+/**
+ * skb_steal_sock - steal a socket from an sk_buff
+ * @skb: sk_buff to steal the socket from
+ * @refcounted: is set to true if the socket is reference-counted
+ * @prefetched: is set to true if the socket was assigned from bpf
+ */
+static inline struct sock *skb_steal_sock(struct sk_buff *skb,
+					  bool *refcounted, bool *prefetched)
+{
+	struct sock *sk = skb->sk;
+
+	if (!sk) {
+		*prefetched = false;
+		*refcounted = false;
+		return NULL;
+	}
+
+	*prefetched = skb_sk_is_prefetched(skb);
+	if (*prefetched)
+		*refcounted = sk_is_refcounted(sk);
+	else
+		*refcounted = true;
+
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	return sk;
+}
+
 static inline struct request_sock *
 reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
 	    bool attach_listener)
diff --git a/include/net/sock.h b/include/net/sock.h
index 1d6931caf0c3..0ed77af38000 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2838,31 +2838,6 @@ sk_is_refcounted(struct sock *sk)
 	return !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE);
 }
 
-/**
- * skb_steal_sock - steal a socket from an sk_buff
- * @skb: sk_buff to steal the socket from
- * @refcounted: is set to true if the socket is reference-counted
- * @prefetched: is set to true if the socket was assigned from bpf
- */
-static inline struct sock *
-skb_steal_sock(struct sk_buff *skb, bool *refcounted, bool *prefetched)
-{
-	if (skb->sk) {
-		struct sock *sk = skb->sk;
-
-		*refcounted = true;
-		*prefetched = skb_sk_is_prefetched(skb);
-		if (*prefetched)
-			*refcounted = sk_is_refcounted(sk);
-		skb->destructor = NULL;
-		skb->sk = NULL;
-		return sk;
-	}
-	*prefetched = false;
-	*refcounted = false;
-	return NULL;
-}
-
 /* Checks if this SKB belongs to an HW offloaded socket
  * and whether any SW fallbacks are required based on dev.
  * Check decrypted mark in case skb_orphan() cleared socket.
-- 
2.30.2


