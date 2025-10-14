Return-Path: <bpf+bounces-70949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4CDBDBD64
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 486A3352891
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DBF2ED86F;
	Tue, 14 Oct 2025 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soFqo+Ci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355B29E0E5
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486171; cv=none; b=q3OKWscfHukm29326iu7Ro4ZLNAj5Utv5s/2HtMFzjTWerVkNq4AeOjjSFCHmvJeLwamNQuGUgd8nV9dCyNLZqMnz+5K+Bxpvkxc8fzK3vYPwFBGlC4UaqtEue4SWUw8/oofM1nVSFr+zFe4rGlTkXUrqgb30d8sHnl59ycco70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486171; c=relaxed/simple;
	bh=MRGpKykJxOpTlzndR3QGSRcL1wBXhTwFuH2YVz+eOBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPmPAH6uabhi3H64nZlBCY6H+rXUUWwuAzjIGQPrN54P5kRQsQhTbAOOpA6UYi/HnthoG0unM0vAb6pGEr+nlEfUOtc6Q+Sx1GHabd3P/7uBv6xhfROQ7x9jzrQM+MGOOv8YgMZr0hgeNuXziIkzTJglH6p7UibFSNqpZYDkj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soFqo+Ci; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7811e063dceso8926214b3a.2
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760486169; x=1761090969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob2YpgXK89qud9yI7+fPx6sALJDXvpuhZCZOK6qu6oo=;
        b=soFqo+CiS5CCw0j6odBqe+pmQeAtc+sZ+JcsoiNg0GbQ9ngUe4FhkxS6aTzsgNKXEX
         TrNBag+ReOlwcio71ZqirByby2Psx53br6+1FbUhzh12S+OHcFVsmg1azlb9XWy4Vifn
         +48oqaO7tiqdG7uydFsDLa0F9Zh2AtjoSOdSX5JuljMn4Nd5Zvj4blWQRcxNB10axxc0
         ZUP17/FsHzwJ6d3N0saID4WmQ0FuwGRXS+ILHrrRt9hTEg0Z8NpBSh4v8WPavoSLJRxq
         XCuz0Uc0j9QiBXSAPI7bj+hagjlvTA4ev5FOgr6yNgQUdSTpXIgj6pGqfVGmANEbxEcy
         w0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486169; x=1761090969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob2YpgXK89qud9yI7+fPx6sALJDXvpuhZCZOK6qu6oo=;
        b=ZUFyvHT8fDKbOkPueJ+fufjuIlZIwQgc3BNlyXMKyuBucdC+Uto0Xx1/3khRTwGuPi
         vWobXTMFIQVK1UdiMNmqbkxDwKoEQoyuIO+4FvvE/R+DJcJtDgdHZVSGTwWcmiqrHm1l
         oKLCswU7MGgek5BTLSiVz1bp2ayDjRXxqBxBB9mgF8Z8CsQ2F4YOY9TTpUwFOwV7VH3s
         zpbuRcSh1/PgLUg/BqTP9JyU5lLyGgNF2jEcNTORWZrZCo1M0xSYRjnH8o7PPJK5+i07
         1iFGkG2xt6tSwLacMivFB2a6BzJPDCMlZQnXmxkQ/WVjDH1Z7Vv6HFlgxZNNmOkb0dGv
         ACyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7M0vubeVTHgga8RbD5of7BYaujSdeOLaHkr6/AyANCkOwtPqxTEp2p6u0JtdqyYxW9CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIL0iwF6PllE/Xoc7M8anY8husHAVa/B2U36lIKlaB/X+tPnj
	2rT4Pvdkn+LO8qT5slVtaJ6nQdh1fNFO+60BRSVfFIQxGudZ2eRyOAcBUaj2g/HWN0/49MU8dJR
	kvuACbA==
X-Google-Smtp-Source: AGHT+IFhFt4sdvKgBJbACG84ZSkCiCL+FOvevB4G641zJgNbUcJh1yaPlhDNOS8U9sgQYl0Fjqj1lWzP/HY=
X-Received: from pfbfc13.prod.google.com ([2002:a05:6a00:2e0d:b0:77f:61e8:fabd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b8b:b0:79a:fd01:dfa9
 with SMTP id d2e1a72fcca58-79afd01f231mr13158691b3a.6.1760486168845; Tue, 14
 Oct 2025 16:56:08 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:54:54 +0000
In-Reply-To: <20251014235604.3057003-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014235604.3057003-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014235604.3057003-2-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/af_inet.c              | 22 ++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c | 25 -------------------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3109c5ec38f39..e8771faa5bbfd 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -755,6 +755,28 @@ EXPORT_SYMBOL(inet_stream_connect);
 
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
index cdd1e12aac8c0..3b83b66b2284c 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -712,31 +712,6 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
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
2.51.0.788.g6d19910ace-goog


