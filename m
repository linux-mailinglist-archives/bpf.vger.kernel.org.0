Return-Path: <bpf+bounces-17847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B581356B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921472823A8
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088F65E0AB;
	Thu, 14 Dec 2023 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GcURaM1m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78079112;
	Thu, 14 Dec 2023 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702569366; x=1734105366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZfQPB6JMckLxLId+ZlBGaccpBS3SlDGkkZoJg1lNpM=;
  b=GcURaM1mnSHmcOZfmv92l5acpGxn9HojlYZyFFZZJCjoPk8w66xxec3/
   GuOWMvxZWDhWWdwpQFY68LFamsc+wJptWFrNVa4a59og73E5HcUEfE8Hx
   uPFEJxlfvFVw2Hl90hRnh3IDhb8o5vGQzpJSHdbSrAkrVsgAiZxmRpJAK
   c=;
X-IronPort-AV: E=Sophos;i="6.04,275,1695686400"; 
   d="scan'208";a="382978700"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:56:05 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id 2939380789;
	Thu, 14 Dec 2023 15:56:04 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:25385]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.118:2525] with esmtp (Farcaster)
 id 1ab6d7b5-fbdf-4ed1-9203-30db343f1585; Thu, 14 Dec 2023 15:56:03 +0000 (UTC)
X-Farcaster-Flow-ID: 1ab6d7b5-fbdf-4ed1-9203-30db343f1585
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:56:02 +0000
Received: from 88665a182662.ant.amazon.com (10.143.92.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Thu, 14 Dec 2023 15:55:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v6 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
Date: Fri, 15 Dec 2023 00:54:21 +0900
Message-ID: <20231214155424.67136-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
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
listener.

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


