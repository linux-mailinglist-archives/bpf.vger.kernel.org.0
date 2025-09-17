Return-Path: <bpf+bounces-68695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C7B818E3
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9024A0B2F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B520314D2D;
	Wed, 17 Sep 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6DV96nK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E4301033
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136465; cv=none; b=rLuyp3oFV3zvcdDhsxCe3O5FZnVVH7/widkDhlivJy0D27ab1whwtoYzE90HdaPbqsOgvGguAuRSFrfu/kH3CBE2oohrpnSBPq4edErtu+tUSzJ5e5F8P/o0kvxKJ6Gw9BBY8jKFpe3ZjCbKBKYEuzPbGrWqMozZ3f62cjWHTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136465; c=relaxed/simple;
	bh=jy5hkABfa0a79OkbGKXh8DmjmvtFULWB7mym1UPV1PY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d7eFP7YeFOAXS0jn65G1aJXWYx84LRJE1Ur9aBklCKGoJl3/kWGh8bo60Nu9SeWnQW83KGIP13r2sNk1OBefLZyM1ks7MNP81wyut0iAjlOvlSo8hQlr5nQAjFpPCvDQmRPxYhsV/ZFToPR6b5nIymd+CZsJ9ayKgAgz0imqcHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6DV96nK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2681642efd9so1108765ad.2
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758136463; x=1758741263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4lKbxvBM5o9mhOSF8xElOWjIUUO+TcNpNDportvZ/M=;
        b=Q6DV96nKfeo6TPSZ1xblNiYn3HsifchphBhyKJ+vm9veT6D3kWV4h2Fvl9zC4icvZC
         73zX2eopl0HLTedso8tCT8cBYjHE7zYV3LGfRTgW4J4yvvTAOIzbrF0xaTsd1uY8uZas
         oUulEJ2kzs8oyVbdh09sZtCkyPpGaAlcuTuFdia0YN0TDUfMLI5u00BQWB9u7resjn4w
         K9wQEyVvzgL+e6aSLDcQyD4TqowpWb97ODgzAioDXlvYkpX2STO4sh3JacYFeLJ+FlPJ
         BJdxu+eIKpjmN6/rwTZgwRW5FnUXVJ7bPPr+vuI/GRpRHMCccaytsE+4kzBxUsL0iQRa
         uD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136463; x=1758741263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4lKbxvBM5o9mhOSF8xElOWjIUUO+TcNpNDportvZ/M=;
        b=KD8JKHiVOIXamNidYS/htYtLzpVhBAlojJLQNJGf+YQ40F/X8KYvBglOxoLKoz6cs5
         SWOl05mHjCGzUOIkxJGf47qPujbYvG3aUA6p1FmDFB5+it0DFFgJMG3zpIyHJm3y7hbw
         EZ5AuR7fJ+n/bdM/PZkg6uncCSJxnwhWZOYjkpGB3rFsMx6IJuhQZZA9dPOUwnMTGaxq
         xKWyigQ/5LXKhyyQ20QWH30OmM73jagil+2kWD0dyb1G27/TNUodbFp29JkuXx9Jcxvf
         5D/Gx3ogj4hRCFzto8PbZupJcEor/NSXtODQfVgoHnO6O/MhF+BaY7Ex4fNU+DR0M/Hq
         q9CA==
X-Forwarded-Encrypted: i=1; AJvYcCX8/i8MxnhFRoNw7l1Id8rOdXCwCXfJ9CI/DxMfXTCNlu+busm+1A56E/mmSQ1vl3KprDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78OgZEfoEuebB+QcoQXJOJGy9HI13wK1W8Ot7JZ30tsnycoJJ
	wgksFnb3DlLclrcTxZErCgm/u2dHgSCPYvXp6thPPqx3BNgZ2O8M+9fcDEqyisJEAv0P+1ytEcg
	33kj9lg==
X-Google-Smtp-Source: AGHT+IEtwUIiVp8J/y/WKt+HlFcs4qZhaQs4szWKlIOaS0moT3nkU7ND0w6SqZgiH7uM0eBIaEYWIZngsfE=
X-Received: from pjff12.prod.google.com ([2002:a17:90b:562c:b0:32e:ddac:6ea5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cc:b0:24f:8286:9e5d
 with SMTP id d9443c01a7336-2681218d69cmr42855505ad.26.1758136463533; Wed, 17
 Sep 2025 12:14:23 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:13:57 +0000
In-Reply-To: <20250917191417.1056739-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917191417.1056739-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917191417.1056739-2-kuniyu@google.com>
Subject: [PATCH v9 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
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
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
v9: Drop sk_is_mptcp() check as sk_is_tcp() is true for MPTCP subflow
v3: Don't split if blocks
---
 net/ipv4/af_inet.c              | 22 ++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..c99724b3db04 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -753,6 +753,28 @@ EXPORT_SYMBOL(inet_stream_connect);
 
 void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
 {
+	/* TODO: use sk_clone_lock() in SCTP and remove protocol checks */
+	if (mem_cgroup_sockets_enabled &&
+	    (!IS_ENABLED(CONFIG_IP_SCTP) || sk_is_tcp(newsk))) {
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
2.51.0.384.g4c02a37b29-goog


