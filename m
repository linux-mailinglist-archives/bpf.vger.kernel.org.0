Return-Path: <bpf+bounces-19556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2914782E205
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 21:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EFE1C2217E
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D5B1AAD9;
	Mon, 15 Jan 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="phxBCEhp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201C1AAA9;
	Mon, 15 Jan 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705352206; x=1736888206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZfQPB6JMckLxLId+ZlBGaccpBS3SlDGkkZoJg1lNpM=;
  b=phxBCEhpmbxAMPJsri/ZKWwWU+6PZJBEOn8Ptfyy539jM+utwi6RysJh
   on24F3EdNgGXrnwganJNDi8gT2+Ihaj7+LO8cGOs7ymOech1zx2Wu5ZIk
   ls2g/Ruzpur7vM8lTup5698kP5celDzEUc0+U2TNbohXKMk8t3tQLOttu
   8=;
X-IronPort-AV: E=Sophos;i="6.04,197,1695686400"; 
   d="scan'208";a="374582046"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 20:56:45 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id DD69A80799;
	Mon, 15 Jan 2024 20:56:43 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:59892]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.54:2525] with esmtp (Farcaster)
 id cad763b3-c3fe-44fb-875c-9fe590b2c891; Mon, 15 Jan 2024 20:56:43 +0000 (UTC)
X-Farcaster-Flow-ID: cad763b3-c3fe-44fb-875c-9fe590b2c891
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:56:40 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 15 Jan 2024 20:56:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v8 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
Date: Mon, 15 Jan 2024 12:55:11 -0800
Message-ID: <20240115205514.68364-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
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


