Return-Path: <bpf+bounces-67807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726BB49D00
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6284A3C5431
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816642EDD65;
	Mon,  8 Sep 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLWQZYpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9542E8B6B
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371079; cv=none; b=lCq6WgGkdcdwdB2OHyoROsbPFrPhKqZHmpnxXC/YEM80eZrZYF8/MfzdxZB2SK9DHwFeu+liyKHoXfYXQEjcgW8ram40Bsb5dk4yoC6BjPeAleUzwaiFys/epC/+8Bs5CSmMlybDsU/gQB89CQdYsCyA2SXzAUvBhuCFV13xrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371079; c=relaxed/simple;
	bh=v3w2SS7Kkrv52T8FXm7oOh2uz/3H5kSOug5YVI7wCT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mEMU1WeBt/Bx8gDSAw+KB7cFxo4jQqcRXd0Mrilcb6gqgVjoCnGmA5ofR8mgMLLOhAyOq6tS+OjaQJ0f/SyA2SatijCrD7/t1qBcKWoxMWN4/zcj47bS5V3pqochFVCbee/mgZEKaZb8Y1Uj8FN8U7G7GevnRa7rx/9lv8fx34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLWQZYpq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7724877cd7cso5613316b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371077; x=1757975877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=bLWQZYpqO3WjZ/O5dYk1NJynrQHlTCocXujWA2P6rt8D6sToRK+kT1494htEccQwY/
         wloIuRoltbgp4tkyRdVTMOLc2uJKG5a89GPuHywtLbAo1Z8W3HFOO283ZX1ni0i4+951
         w69pAlcCHC1USZOigUwN1bLKVvnGWWblLZstCEtqvRp0uiUJ+vQQ8Lp7wk7ZPlbCQYP4
         AUe8u5pPT/2A2AkNuljpMq8vTxxeMkLpXLWiqGR8lsRn+YQN6AV172/c0KuLFx7yFIX9
         rdRiX+G+U68uCB42JoNmk+c4u+oa7LfjIpQwqW9QVUXdtdRS+JYnyoCB3HySoZWvYp2I
         DnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371077; x=1757975877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=RKAJKjcXTnJCm4EqThJQbGfPyf3M+9ryqQuscm2fCoOYRKiou8Egmg/G0BeDMcFA+x
         sJcyFf5tfjk7iCZFRCD6BcoG5psVify6GfGd5FFCesGUubV4OCJNQZe47CTfrdKzrwwy
         C4XKCIrZg5Hf9SgCkKnavaJ1cHNyOWYtjgCKByibjbHw8PSJUJeOmer7JDxM/1aI0vrE
         dD/DIVKRcpBoqsKhwydMEI7wqO9o7LAiRXT5lXUirgtfSQZDgmibgXY3F8BSaf5yAx7T
         vaHg9tD7NKBSllJC3G5ysDbzmNwCuemiRcG0hXfD3xL5oDVwMWaqqiANiUvirb2GCSzV
         Ahtw==
X-Forwarded-Encrypted: i=1; AJvYcCVeGEghhSXoRsPGR8Fp5ROeO+JMcauXV5aQatWwFP60AI0IVMGKy9WPhOP1xkEwo6CXzME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyELhyFqXmg6Cid5tSj0K0QANw4wDzNIPK32sLlwTnAoemALy
	IMgfgrYHgFAwCUFtKbXjcq44VlmReHzhvGA+D2qcvEg8XILFxbgi3Ka4AIA+rO4eRvsg1wUaMW5
	Rrruk2Q==
X-Google-Smtp-Source: AGHT+IHaowIy+RBqf2r6sKAdT4EUV1YuMSMRybxibOlbKHg2UIZYpufGKjXJLgvkucA7h8BVkmDjiIod7k8=
X-Received: from pfqn18.prod.google.com ([2002:aa7:9852:0:b0:774:260c:5b7c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a27:b0:774:1fd4:1007
 with SMTP id d2e1a72fcca58-7742de3fec4mr10979554b3a.23.1757371076669; Mon, 08
 Sep 2025 15:37:56 -0700 (PDT)
Date: Mon,  8 Sep 2025 22:34:35 +0000
In-Reply-To: <20250908223750.3375376-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908223750.3375376-2-kuniyu@google.com>
Subject: [PATCH v6 bpf-next/net 1/5] tcp: Save lock_sock() for memcg in inet_csk_accept().
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
2.51.0.384.g4c02a37b29-goog


