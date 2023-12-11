Return-Path: <bpf+bounces-17377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1280C20F
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 08:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F301D1F21072
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACB2208AF;
	Mon, 11 Dec 2023 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="prOU6ah4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF5CDB;
	Sun, 10 Dec 2023 23:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702280283; x=1733816283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G27pj8LYHdnN7TKoSD97L7HFiQjzVPM+Haa/cXT3hMM=;
  b=prOU6ah4Sqh3jmlMGUXNo8NGeQWo1I6Vdl5R4SM+Y32S9leTyD2C4xcZ
   5C57PbWiRouRi4VvAiwCrgPPwjd/2dfm+fNiQF2sJtwr5HcniR7adCDYr
   GTPqyigSNqpskhczSDDK7Dih8tphCn8PT98zmnYh2wKzUwYnQm0VmeyYN
   I=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="624434067"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 07:38:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id 3ADB140D40;
	Mon, 11 Dec 2023 07:38:00 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:60319]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.169:2525] with esmtp (Farcaster)
 id 2e4ae004-9cf3-424b-9709-d828856ce276; Mon, 11 Dec 2023 07:37:59 +0000 (UTC)
X-Farcaster-Flow-ID: 2e4ae004-9cf3-424b-9709-d828856ce276
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 07:37:59 +0000
Received: from 88665a182662.ant.amazon.com (10.119.13.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 07:37:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v5 bpf-next 2/6] tcp: Move skb_steal_sock() to request_sock.h
Date: Mon, 11 Dec 2023 16:36:46 +0900
Message-ID: <20231211073650.90819-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211073650.90819-1-kuniyu@amazon.com>
References: <20231211073650.90819-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
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


