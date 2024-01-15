Return-Path: <bpf+bounces-19555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F582E203
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 21:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E910B22010
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238CF1AAD4;
	Mon, 15 Jan 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pykT+ink"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910718EB0;
	Mon, 15 Jan 2024 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705352188; x=1736888188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cLyaf2vFShETqwii2kP9N4veJlAO4VEEdhGxRDGF4GA=;
  b=pykT+inkHokr9thhfPwev7vzXyXm4w234MAZH5f3bWED0qqgQM5SZC+N
   Zyj04yEsN2OQOSC3PrcSO6nMYRjbI67AnEePtgoGE6MGwidvBKetOWQa/
   y/J7d8evVmZvlIGzLKxpqhulwACSrBve68a3zIBQsWY7ujtPndRsy94lr
   A=;
X-IronPort-AV: E=Sophos;i="6.04,197,1695686400"; 
   d="scan'208";a="389969069"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 20:56:20 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id B981549FCA;
	Mon, 15 Jan 2024 20:56:17 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:44926]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.212:2525] with esmtp (Farcaster)
 id 3a8d2eb8-d8a4-400d-9e33-75bc6dbee68d; Mon, 15 Jan 2024 20:56:16 +0000 (UTC)
X-Farcaster-Flow-ID: 3a8d2eb8-d8a4-400d-9e33-75bc6dbee68d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:56:16 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:56:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v8 bpf-next 2/6] tcp: Move skb_steal_sock() to request_sock.h
Date: Mon, 15 Jan 2024 12:55:10 -0800
Message-ID: <20240115205514.68364-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240115205514.68364-1-kuniyu@amazon.com>
References: <20240115205514.68364-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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
index a7f815c7cfdf..32a399fdcbb5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2814,31 +2814,6 @@ sk_is_refcounted(struct sock *sk)
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


