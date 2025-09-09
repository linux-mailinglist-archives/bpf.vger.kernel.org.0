Return-Path: <bpf+bounces-67938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E10DB5075F
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD7544C4D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7022D24B3;
	Tue,  9 Sep 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blJ2OhOK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88E4502F
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450800; cv=none; b=Hj05tk2SYIRAbSAWani7aptc1hFByili9renQsGe+t6WKICTFwPx661lrUOgSqy3wQNFxCF0i+FVDcXMsgVO/Sh7P9CeWdNOxuIl99p1oNaSOGTRHkmBtWgZsSs6Oee5bUMluV4VDFIUQkqTpIRjG1IpBZStqBHQwMcm9OWtrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450800; c=relaxed/simple;
	bh=v3w2SS7Kkrv52T8FXm7oOh2uz/3H5kSOug5YVI7wCT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mgMnnV8bbSDTSZOtQJKroSqpmbrY8O78zMBz54/AfyBobU2uKlB+g3812vM/SjO4sdCn3tJJhPyg1kGzqALMXkmpnps8w/FLm1QUyEErPzqHL5eC3uP2xoSMkEijz1aT7LmMFlCNERBBHa1fS55OCL6BnugEuMlY6b6fiiLlP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blJ2OhOK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77250c660d3so5726485b3a.0
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757450798; x=1758055598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=blJ2OhOKZAyvvKoozaTBpz0xv0v2BiFuSSkKZZYRVLP56X9hYc0ZaK+yR/JupHAo2c
         ffz2+SWA8j3sfWiEWiW7cKkiYzkS2rvjV7758TnbIZ4Faj3K9GqgpKDyP4jM/Ht45j/a
         L8DHQItX1BhUHqfzMahQywNd/BPDMvShaIBw9I4e8iZQnjLuStBuOnNBrTdKbuPSFpMa
         x5n1MkUGaXVpb+EyJmb13acb6CJ5UM+frVb46awJbMFdcQI8YO4SUgmR530tY51z9o9X
         RYjS9nVHHDC8UwSS4V0fP1RMBUm9A6/cHM44keWCsARwR78Am/CWYer0UjxciNc4WxC+
         vFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450798; x=1758055598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BeVPATa3pZCn8jXo+/vosY7DTRyTcrn7DL+ZXvQULA=;
        b=kD17XRaAU/t+AJzYVvJp3SnuLYfcwGKldQLRvtar5N5jq0VRZxAQQYXTq89Y4pb02t
         PHrHIVSYz57Kvdc3GENDWGQ+sV8FADpnFUT8c/NdiEKpzfXKYcvAgZodSxb/KjFUhKdg
         uuPQellKs1KWxQA/7xZ9Mjt6DXmSWu9AMW7W3SNCTfcAbRTnprxzoVwOodlJ9iM5Ywga
         rb2RAW2GgpgPiDDDjAdCM+KbT4F9yDAwC7c3O/xp42u7J0n2L0jUQpP3Yzb88YgCss18
         eE1DA8gwnYslUDXlkc7dPk51U/4bgoGx/Ezx+zr91Ss0SlF4RjoLDqSh1oHfQmEEgnxl
         9p3A==
X-Forwarded-Encrypted: i=1; AJvYcCVIPamO3yWu1Rgg3bqvW4p2P6+D6/z2fqpHIvZ3AeFnIeCeVCfnx7JEEj17TDpsYktxp+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqKV3QO/6hw5jEdw6GmdF9/Onmc9sA+9rjnjlfvgM48PK9uC5
	9m5DwVu4y8DQLpdkb63DmlogibxJ1gFXOgK/CG8gxJTeqiouYTXXyJSyCKIs9PT2MobzWClrStN
	lMN12tg==
X-Google-Smtp-Source: AGHT+IF/YIcLf2+3AzZZZdpFcU8J1LDxv3YGeOA4xweV2ZaPU+2Gx0EG3ASHt15Ha5z8ID2ydEeU9jp9PGQ=
X-Received: from pgcv18.prod.google.com ([2002:a05:6a02:5312:b0:b4a:fba1:5765])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a4:b0:24b:954e:387a
 with SMTP id adf61e73a8af0-2533f7c90d2mr17446390637.16.1757450797854; Tue, 09
 Sep 2025 13:46:37 -0700 (PDT)
Date: Tue,  9 Sep 2025 20:45:31 +0000
In-Reply-To: <20250909204632.3994767-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909204632.3994767-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909204632.3994767-2-kuniyu@google.com>
Subject: [PATCH v7 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
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


