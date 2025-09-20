Return-Path: <bpf+bounces-69022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809AAB8BAAA
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FD41654EE
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17271CD15;
	Sat, 20 Sep 2025 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hc8q9Xi1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EB3FE7
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326879; cv=none; b=SLbkdoECcEcofaFiI+/3gMD2Kqg1u1qoNY5QZWuTZKVsa6YGxIdEwDjnX4tQnDjPrbhqKBvs5S4ekeFk3NAQjqm4AmJj5oWpL/ZV7Vx52+cF8oSguLB5xFc4tTvPo3axn1nLXWZ+5F48fk3yFxvnJeN1jZt/ipvU5+HUk5G5Jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326879; c=relaxed/simple;
	bh=bgNNiIxrtBE4jUaOl87kHp4beo9ryWUNNsWYcbVB5YI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HJVByJzJI8qbjRGvDcVbhm04NlPjTM/P9k1M6vwkmlpH4+4YyGOPSt5HcZAsl3KdQO+5S1hPBVXtyzg9Ap06zLXgtEaW5EY9D8hHdZqHJcYp7R+fP5iB/QBzjtS3zUaBWYUaOfLOi5D9L1FHn74w1OH5ymUjhETM584bRmHKSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hc8q9Xi1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77e13772b37so1219808b3a.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 17:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758326877; x=1758931677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYiC1L/UFMbiPuw3cV7992tVLcm9d6P0yq8ElSa5Lkk=;
        b=hc8q9Xi1gMEKYOd8VTQkc0IMB1CbNBRBIChmnEso39O9C9W5Tw/ldTSJJscvPlafWs
         imQsnue4HWjeDPbRzh8+lCcNHXH9QZ05uLbIW3kb5pii6ZigdoDPwOKRJ64adyJi1M8e
         lLaC9MXzdupCKYqL3sZm4bBoBTyJMOPSaNB1EkSoCix47oN1LKBOvlLPQuZpqCYU0C4q
         BcCL+SIZTQ+Jv6Qiy01vYmKbMBtHxYCaomtmRWkd4CS4OoKvyRqtuk9q2ZB0Wu8gG5Ih
         GvckvJwSZDm+eYx70oxb4c4FuO5OCWE560xtHZuRAfzsnx8DmQz3Lr1/X0K7pJPtqd7R
         NkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758326877; x=1758931677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYiC1L/UFMbiPuw3cV7992tVLcm9d6P0yq8ElSa5Lkk=;
        b=Hj93UjX1HTvAGk9qLjKiF16GysfzRdIbKHGmuVeQGOqG3A/PkRIli3d6UbanqmTkXk
         eQ87HX2C2W/uaHPRQiy3wFCR8dHa4N0+cRL3ZUX3TlLudzkiS7TNx9kmt67/SCNHCau/
         E2TBk0ztRc31YlHrRFUJBeCBLIZOyVD3xhyLz2N9DB+V3DdMwpbqzvrfKthFuNITWN1U
         wZhCLtKYEFS8o8Sr/WHkCWump0UJ3khcB1C6QDuOPT/E/tazZvi9rDixiyubZcpOaYMe
         GjgOnxT5i/sfJXJYTmLUM8vSogSj+E7d3JB/EEevveOaKLWVbU3DxxernveuMjPgWmZi
         lk1w==
X-Forwarded-Encrypted: i=1; AJvYcCUWVR6F+ktGn7cUmB6BsG5fsJNFAafuBLMiWnHLRwnmAqxiGYxbo+3IgDiwTMStVV0c/dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudbOPpmUupxBisqDw1DwUPfFbk5wtLOornyQa+00dA+OOTRtI
	VhKwxYntCmmF6logPrSGHK8h7GhGJ6D2wqSqey2xu/Qp1EwCLoU1w4mBeFFy2e2bxvr3LezINY2
	+ZXFkqA==
X-Google-Smtp-Source: AGHT+IFSjMIoA5Lq7ieog8/LAKruL/s2RCjdOEzI3hmIp9QBWMOFhhh3HQXhO145LMCeyAbTC9R695Il1CE=
X-Received: from pfbfo4.prod.google.com ([2002:a05:6a00:6004:b0:77c:1814:c8d2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc8:b0:772:38d0:4fee
 with SMTP id d2e1a72fcca58-77e4d709aa3mr6231993b3a.12.1758326876942; Fri, 19
 Sep 2025 17:07:56 -0700 (PDT)
Date: Sat, 20 Sep 2025 00:07:15 +0000
In-Reply-To: <20250920000751.2091731-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250920000751.2091731-2-kuniyu@google.com>
Subject: [PATCH v10 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
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
2.51.0.470.ga7dc726c21-goog


