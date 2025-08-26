Return-Path: <bpf+bounces-66582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0445EB3725E
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C6D8E3E48
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F037288F;
	Tue, 26 Aug 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGbjylei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62F3705BB
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233609; cv=none; b=mA1FVqG4zoTTI9qGERyMtfxSLSoMk+yDG3yCiOp5msPbzHizl8xcSH9Qb32kQyjqU2hxdzuFaTuGchcBHbHuBOS9zpHvA3rYaSfwTFjIo9phteB8fBZqB1JKjEhtTvXzck1SM0OCWc/mLNoh9FoEuKnM4qPryWCp3GF5IXSPkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233609; c=relaxed/simple;
	bh=7jpNdR78fDnRfgHkwUZcxkxmx9b0dmnDfv+BRs5yxQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WOstbTDRBXdbloEsAdeeXnIaImITUCUhBlsDXM5qmCEJYfqvTZ7Yu66m+At9Qc1SgMVvXL/e7+TK5bHatC2N7zPdq7ucwr0vw1T2Doo5wyJWAUZZqKYsLyLsSoDhieeDNwYiz+NVojRYOS2EKCF+1/WeGb0dBGgyWhR3rE2Ji4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGbjylei; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2468b307df7so35347755ad.3
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756233607; x=1756838407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=APBrO0PLDtNB0jweLrBqa+2oCwrCUsaFkmmSIlZAUxQ=;
        b=BGbjyleiTJpi0Wcg1WY1wP3aqHhiA5O6IAUdgk45xI9M55t5e2riE7v0w/gLQALdGm
         2UQP7Ifke17S5CbFAJtv4FSKWctvF6fowPopCS0RmjSfwdOPnDwW6LzwDhi8lEIFLnbf
         7BlXtTJCPjMtIu/4HefsK/qH3NgLzw0p9Zbe4jRhWCZT1DPhRUGitVio7vDgfOqtSqHR
         GfIWBHZh7kRqM6ypcS/FZAhnqtAm8WmlWGnM2HMxLYgG2N9MQjc33c88kboHaQfNfE+c
         ijxwVqCCwJYc25Mo9MiAnvSINLWljFaBslJXMscVjp5F5YiWfOOBjlHd9bnzwcwJ8ju7
         F0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233607; x=1756838407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APBrO0PLDtNB0jweLrBqa+2oCwrCUsaFkmmSIlZAUxQ=;
        b=TXSm5cNY7eepJJTx/0plFTrMGFB0+d8UVlFJ/f1k7GmR+C5CDp1FMW9t/U5gfWV46J
         4ZFUW9NEDYMZ6H8a/b2I18nC6TXp7+xGXymhsJQEA2rdXHdZNyFsiSt+pvzyYDAl3iUN
         vulWLO7MIV2cmAXOhs7qdk7ihVcTMwoTjKU9GOAzDPTPLwIdFEiIN8TonXISedgxgzI8
         9HPrN3JWvTUgP2OMHufHRDJQltQrw1Kb6ktyETgy03Z9dUsnydijX8RQUgg0D0hpE/y/
         uDiWSEzH+MOnVTtM0Gnon896A7yobQxYnwpiyvrOwLDDDji3MVnNpOCa6ZmSby7LoDP0
         P0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCX/kRjOXwvWWjpFcVAIirvqVPLqSiB7vtIAAvVSQnQImy5gnvZkWOU0wqotetcZQ1650p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4II41cdeR4jiPLI5DrFy28LVv4+ONM3OARgEUj+WO40adOXj1
	+n7f+DUT9/JUunfSx8tnNLnsfml/PJHpoxWPpfSgYtmrEiXad2oiYxbk65Na74vI50wOa2OhNB+
	dOwWFiA==
X-Google-Smtp-Source: AGHT+IE5/6txGf/8y9lNlS/eNCD5Wo6Y/AnWz2uFypEEHNPuasbllnC7+jE0N7IrNrXyBM08ZV6l7ytMHMo=
X-Received: from pjvf15.prod.google.com ([2002:a17:90a:da8f:b0:324:e309:fc3d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac7:b0:246:c826:bd16
 with SMTP id d9443c01a7336-246c826c033mr105766615ad.23.1756233606853; Tue, 26
 Aug 2025 11:40:06 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:38:07 +0000
In-Reply-To: <20250826183940.3310118-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826183940.3310118-2-kuniyu@google.com>
Subject: [PATCH v3 bpf-next/net 1/5] tcp: Save lock_sock() for memcg in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If memcg is enabled, accept() acquires lock_sock() twice for each new
TCP/MPTCP socket in inet_csk_accept() and __inet_accept().

Let's move memcg operations from inet_csk_accept() to __inet_accept().

Note that SCTP somehow allocates a new socket by sk_alloc() in
sk->sk_prot->accept() and clones fields manually, instead of using
sk_clone_lock().

mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
so I added the protocol check in __inet_accept(), but this can be
removed once SCTP uses sk_clone_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Don't split if blocks
---
 net/ipv4/af_inet.c              | 23 +++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..d42757f74c6e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -753,6 +753,29 @@ EXPORT_SYMBOL(inet_stream_connect);
 
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
+	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
+	if (mem_cgroup_sockets_enabled &&
+	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
+	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
+		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+
+		mem_cgroup_sk_alloc(newsk);
+
+		if (mem_cgroup_from_sk(newsk)) {
+			int amt;
+
+			/* The socket has not been accepted yet, no need
+			 * to look at newsk->sk_wmem_queued.
+			 */
+			amt = sk_mem_pages(newsk->sk_forward_alloc +
+					   atomic_read(&newsk->sk_rmem_alloc));
+			if (amt)
+				mem_cgroup_sk_charge(newsk, amt, gfp);
+		}
+
+		kmem_cache_charge(newsk, gfp);
+	}
+
 	sock_rps_record_flow(newsk);
 	WARN_ON(!((1 << newsk->sk_state) &
 		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0ef1eacd539d..ed10b959a906 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -708,31 +708,6 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 	release_sock(sk);
 
-	if (mem_cgroup_sockets_enabled) {
-		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
-		int amt = 0;
-
-		/* atomically get the memory usage, set and charge the
-		 * newsk->sk_memcg.
-		 */
-		lock_sock(newsk);
-
-		mem_cgroup_sk_alloc(newsk);
-		if (mem_cgroup_from_sk(newsk)) {
-			/* The socket has not been accepted yet, no need
-			 * to look at newsk->sk_wmem_queued.
-			 */
-			amt = sk_mem_pages(newsk->sk_forward_alloc +
-					   atomic_read(&newsk->sk_rmem_alloc));
-		}
-
-		if (amt)
-			mem_cgroup_sk_charge(newsk, amt, gfp);
-		kmem_cache_charge(newsk, gfp);
-
-		release_sock(newsk);
-	}
-
 	if (req)
 		reqsk_put(req);
 
-- 
2.51.0.318.gd7df087d1a-goog


