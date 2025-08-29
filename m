Return-Path: <bpf+bounces-66914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F069B3B023
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630AA567BCA
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F41E1DF0;
	Fri, 29 Aug 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npi8h0Kk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E51A9F85
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429235; cv=none; b=XCCI5C8CImc9Rn68txatPU1UPj1UumjYATpoOuWZMz0SAvVpYxis15xz4cbr7tsawiwgDOvym8qgpu42oPD/2NaJlLH1KjX0TS2hCk5AhZaRwhNisBjrXiKsxdPeg18E/9TK1HMLm36rzAzEUB9cRWg8K3SZJjbnU4Ydb26+E9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429235; c=relaxed/simple;
	bh=mZlGwGG08pkFIw0b37XMjqhuG4FyorfBoqmECqvfBcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sMUv/7WJL465taYdweJAzXybuaE2FMjY2sRhojKa4IfOxgxr0aeBqTa6Fn8dt5OjrSL8DVeITZR/P7VnwOpTSMCu8xjF/coSfJzMfyNQ6uBisXp2/Ln7EitndQxpFDmOLJANWjhD+ChBGqKRE11hKvtWQe2HTz3aYGqg7oyhZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npi8h0Kk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77057266cd8so1373896b3a.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429232; x=1757034032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AidYNR+IVrdDAFmuGwOIdpzQ7vtS0Z9HM1KjWrrlL1k=;
        b=npi8h0KkOI+6m1MD7CqM44RwkXLH3KG4jqx4lGmcq00qNcRd83ZLuhzL+V0d6m+rCx
         GzkOaORShQUa11/M4M7k8OxtkUMDqn3Iyrbzhdn4SzGGHr1bqWgOyCJJD/mLKG+ljGrE
         Zd2MrSm87bpMMZfJ9d7wTmocQBmLLve1XJkxXtOxsb3K3ihydjAyK62m1G/ZRhNUjafQ
         NvDEZ36ts9PU7vanYTuCAZLOp6fOTsgNaIVvJGllu0qnLPJnJAnNZiwYUrdE758eun6T
         ggZ9LrCUcTLjhiZbTZ8MEYwuCL+37kYcwVjjLmjtFQ7X/z8XvqAVZ86FVMp87Cjg8UL7
         t+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429232; x=1757034032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AidYNR+IVrdDAFmuGwOIdpzQ7vtS0Z9HM1KjWrrlL1k=;
        b=tQT5u9p41SSBr/ZW/EqC9nSktS224QfyZnsaZEcRve7q16GheleaFdE0WmWm51xKZv
         aIzMPQgrki0VZqSUeDmSEFvV8WL9j3ZRirRFWCVbOtuaD2D24u/EEThYKpPkMCiCAyVa
         BKEFCYbxc/SvBlQ/hVblxAeAlJr+ZAwgPfa/Q6zCvEVGleWOSAl9+lXtJCQ+dtbTEx8o
         UnQ2th31nhsjJeEfmee5Pq1EI+DP6h2iwnTyGp2i5EWThmJShY0+tYWBhdH4no/LZujv
         SVI2okkolv/0uEHhrYAocT22QcOktRKIL/xJHl2AbbCjY9MvsJoGfnme7LHw1mq/AJSC
         7CWw==
X-Forwarded-Encrypted: i=1; AJvYcCV8XHExVMdMYxmSTC5CCVOwR2AAO2pz11aCNkQHViOmZn8Of+hawfgyr9+rX33CMblUPEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9jXWSicf9PVNWu62ibldF1n4Y0eKdbFMYEhVtpMNns7mogDj
	fObIZBITA5e8fkcvNn4mz3V3sE0s/dTNFaY1JHmdRo1lrB/pQ4MIFOzl8w1uztcpOdnEGVZVxx5
	A1Dn3dA==
X-Google-Smtp-Source: AGHT+IHhIxX8Gv9Tw0BMtZ722rdhJbCRqrGg6yv12Wu53Mkw9SU4FF6RdvKWZzo231tzxjI5cigq1r4PW4s=
X-Received: from pfug1.prod.google.com ([2002:a05:6a00:781:b0:771:f8d3:3787])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b52:b0:772:114c:bcbb
 with SMTP id d2e1a72fcca58-772114cc0d7mr9124284b3a.4.1756429231922; Thu, 28
 Aug 2025 18:00:31 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:00:04 +0000
In-Reply-To: <20250829010026.347440-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829010026.347440-2-kuniyu@google.com>
Subject: [PATCH v4 bpf-next/net 1/5] tcp: Save lock_sock() for memcg in inet_csk_accept().
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
2.51.0.318.gd7df087d1a-goog


