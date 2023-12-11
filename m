Return-Path: <bpf+bounces-17378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB7680C212
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 08:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798FF280D59
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 07:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3F208A2;
	Mon, 11 Dec 2023 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LbSmwS+I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A737D9;
	Sun, 10 Dec 2023 23:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702280312; x=1733816312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eDG7lZDdNHh0EcDGdXiU32gJ7fG+PdDfE2jYmtKCwR4=;
  b=LbSmwS+IfPlneDmIk0Px/QAJ2Fthpxvt52XWyMqtIWidoKaWP4zQK1Nu
   ZEB8oKuFgnLBZAtOM14WDwPjPW5Q/T7hPuZwwwta1neWJm2p9nbnu7tWp
   aPTFPoHBHNECkwdJMsxvjORhED/eQtUSqQANrM3k4YfctHEQGBJWvuJOr
   k=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="599818199"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 07:38:29 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 1A9648066A;
	Mon, 11 Dec 2023 07:38:27 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:17502]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.170:2525] with esmtp (Farcaster)
 id 558f2cb6-acb3-4eee-8a35-2fcb69b954ce; Mon, 11 Dec 2023 07:38:26 +0000 (UTC)
X-Farcaster-Flow-ID: 558f2cb6-acb3-4eee-8a35-2fcb69b954ce
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 07:38:26 +0000
Received: from 88665a182662.ant.amazon.com (10.119.13.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 11 Dec 2023 07:38:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v5 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
Date: Mon, 11 Dec 2023 16:36:47 +0900
Message-ID: <20231211073650.90819-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

We will support arbitrary SYN Cookie with BPF.

If BPF prog validates ACK and kfunc allocates a reqsk, it will
be carried to TCP stack as skb->sk with req->syncookie 1.  Also,
the reqsk has its listener as req->rsk_listener with no refcnt
taken.

When the TCP stack looks up a socket from the skb, we steal
inet_reqsk(skb->sk)->rsk_listener in skb_steal_sock() so that
the skb will be processed in cookie_v[46]_check() with the
listener or another one in the same reuseport group.

Note that we do not clear skb->sk and skb->destructor so that we
can carry the reqsk to cookie_v[46]_check().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/request_sock.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 26c630c40abb..8839133d6f6b 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -101,10 +101,21 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
 	}
 
 	*prefetched = skb_sk_is_prefetched(skb);
-	if (*prefetched)
+	if (*prefetched) {
+#if IS_ENABLED(CONFIG_SYN_COOKIES)
+		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
+			struct request_sock *req = inet_reqsk(sk);
+
+			*refcounted = false;
+			sk = req->rsk_listener;
+			req->rsk_listener = NULL;
+			return sk;
+		}
+#endif
 		*refcounted = sk_is_refcounted(sk);
-	else
+	} else {
 		*refcounted = true;
+	}
 
 	skb->destructor = NULL;
 	skb->sk = NULL;
-- 
2.30.2


