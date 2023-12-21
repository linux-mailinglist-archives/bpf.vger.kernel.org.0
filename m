Return-Path: <bpf+bounces-18471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD9681AC31
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 02:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9D81C239F5
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 01:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92A17E9;
	Thu, 21 Dec 2023 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NZW2WnjF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07232567;
	Thu, 21 Dec 2023 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703122192; x=1734658192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZfQPB6JMckLxLId+ZlBGaccpBS3SlDGkkZoJg1lNpM=;
  b=NZW2WnjFiR76ffAeMRUIjkQ9dJPKmWbFAwPKpGeaAQBuH0zKRz6NnK1H
   O3jZw8X6KOjQSxc3r1gT1Eh/RLHNJpf1eOyaED68r0hNyM/D5oRnOBsNH
   ICp25XX15N7L6NNkXhZwqnzN8wfm9eUjDA8pouV4bFW49DWpR/0n64rqf
   s=;
X-IronPort-AV: E=Sophos;i="6.04,292,1695686400"; 
   d="scan'208";a="692885158"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:29:46 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id E2E39C1C69;
	Thu, 21 Dec 2023 01:29:44 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:28472]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.144:2525] with esmtp (Farcaster)
 id 2668e679-f948-4a73-986f-e996851b565f; Thu, 21 Dec 2023 01:29:44 +0000 (UTC)
X-Farcaster-Flow-ID: 2668e679-f948-4a73-986f-e996851b565f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 01:29:41 +0000
Received: from 88665a182662.ant.amazon.com (10.119.15.211) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 01:29:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v7 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
Date: Thu, 21 Dec 2023 10:28:03 +0900
Message-ID: <20231221012806.37137-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221012806.37137-1-kuniyu@amazon.com>
References: <20231221012806.37137-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
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


