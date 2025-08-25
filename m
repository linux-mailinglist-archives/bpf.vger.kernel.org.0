Return-Path: <bpf+bounces-66450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67DB34C30
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D57B5C79
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2FC299AAB;
	Mon, 25 Aug 2025 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHaTT4au"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42D28B7CC
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154525; cv=none; b=mwHppvo658IKYpFkCgTdQ2wVlPdsdOePfa0vOV/hApa95Np4JnQz+QJsrcLL5/y0S/3T3LCCUf6IbjL3nlq/EYdHZsgnmKbY5dnee9sZxu6CsKHt4i+cdoK4MxdR8kdka6jNGC9p+m1JqbGqz4oX06pBYnrVYi7CUjj3yDPpLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154525; c=relaxed/simple;
	bh=J3njKZlv/So4BVesWI9Zm874Ux0hO6FiKyP4hZpJSPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mnew5jjcpXnWzBsndHYKQpnqVLo76MmpyghPwIjKWmvc3mHm2/jVAs0OfTK7GxKuvAaCy27vZpYijV5IayB4hRcBY1p7vGGhymWgUA1X2+BPHRXgZY+3flyhnh0nhr1qHxp+KhCM8ZvE+8XMeX6b9HErelUAHXLFXxudUJOMlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHaTT4au; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2463648439eso50536545ad.1
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154524; x=1756759324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5AaaCWRjbVKrGh3SwvTm7gVupDxknnn0Hxflr0DZ2h4=;
        b=pHaTT4auGNucNYZg4l5kAYxtd67aYt5JMt3+UUffMIlMXdzkoRhHY1QhiB5UdBgPo+
         sEyZyaGoNFJ9R70v8cDLy4SCKf0Be7xRLNgh+zCofL2ClZyhR4ETKXQJGJvRzVzKivJw
         57ja57OdAdXK+/4Ts+2rlLgA8e3UeGilXc/a1j9FE71JvxEwlnjxj3dO15SloefU5IHF
         rX8L/NJ1NsEhd6wMkmJM8wn6RXkrRwMBUK9Zbmc5UXNBI2elTuSY99HY53JNOOBU7UeN
         6/OK3ecNEWYLCQTCe+RRsqhu/bzYcGwoJBtaR6IvENn77CeOKOvQn7oiPWD88K3P9F+0
         udjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154524; x=1756759324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AaaCWRjbVKrGh3SwvTm7gVupDxknnn0Hxflr0DZ2h4=;
        b=qR6pqXZ3z7KL1w9RBhA4djb/uAIKMA3ZoqTYSwo5quUlvqhGBLX+2+wbgcyiIRpJam
         5kRWUEBAG4JMoNaEiWkPJjeZK+V9XiZ6sP9n3DcpoTXA3582EzvvuuUE3IO5+NT/PsvJ
         oDqm1ZUe+GhJur+AUMsYDZiEZ/eLwmHS14XOrCD6dz1qCQthWaIBu4NCgTqBF0RBtITR
         +WtwEXolGM/LZDw7yzQUrw/Zt7Lc9o+rztZ9fuUeHtsQvF0ZU+xXnNf4hDKjztjd+dSO
         uineCll9xGhxIjOSkmOmvW8F3HIhVy1xvgTSdf1GhhuVwophf0SncQ6x//HB4dr6uuj/
         AJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCVrd3aI7AJYVAvnIpjsJ1ejUo7xCw9O4DH0M4YcA8zSREaph9EdDgxZUwmScEP8IO6qDg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Jk/fNekDQoG27kDI/1SHvvhcNLvfvBwIEYJmFVIF9MO8nWnn
	2wUT4aFQzXn121W/W4qmcj+idFmvhcLYvxP9gMoM/vuUZ78h5GuR0p2+K469dz3bmCZbvlNMlU9
	UiS4YXQ==
X-Google-Smtp-Source: AGHT+IGW6xrxq+kjqgyWIG0bFyarROscv+BxqMHvkCBiHMbNLz5LFNxrZBHx+/nInqlV6plTyCmb2B4rtyM=
X-Received: from pjx15.prod.google.com ([2002:a17:90b:568f:b0:327:41f6:db15])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0c:b0:240:a430:91d
 with SMTP id d9443c01a7336-2462edee7b2mr150730315ad.10.1756154523661; Mon, 25
 Aug 2025 13:42:03 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:25 +0000
In-Reply-To: <20250825204158.2414402-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-3-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
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

We will store a flag in sk->sk_memcg by bpf_setsockopt().

For a new child socket, memcg is not allocated until accept(),
and the child's sk_memcg is not always the parent's one.

For details, see commit e876ecc67db8 ("cgroup: memcg: net: do not
associate sock with unrelated cgroup") and commit d752a4986532
("net: memcg: late association of sock to memcg").

Let's add a new hook for BPF_PROG_TYPE_CGROUP_SOCK in
__inet_accept().

This hook does not fail by not supporting bpf_set_retval().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Define BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT() when CONFIG_CGROUP_BPF=n
---
 include/linux/bpf-cgroup-defs.h | 1 +
 include/linux/bpf-cgroup.h      | 5 +++++
 include/uapi/linux/bpf.h        | 1 +
 kernel/bpf/cgroup.c             | 2 ++
 kernel/bpf/syscall.c            | 3 +++
 net/ipv4/af_inet.c              | 2 ++
 tools/include/uapi/linux/bpf.h  | 1 +
 7 files changed, 15 insertions(+)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index c9e6b26abab6..c9053fdbda5e 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -47,6 +47,7 @@ enum cgroup_bpf_attach_type {
 	CGROUP_INET6_GETSOCKNAME,
 	CGROUP_UNIX_GETSOCKNAME,
 	CGROUP_INET_SOCK_RELEASE,
+	CGROUP_INET_SOCK_ACCEPT,
 	CGROUP_LSM_START,
 	CGROUP_LSM_END = CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
 	MAX_CGROUP_BPF_ATTACH_TYPE
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index aedf573bdb42..88b8ab8621e2 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -67,6 +67,7 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 	CGROUP_ATYPE(CGROUP_INET6_GETSOCKNAME);
 	CGROUP_ATYPE(CGROUP_UNIX_GETSOCKNAME);
 	CGROUP_ATYPE(CGROUP_INET_SOCK_RELEASE);
+	CGROUP_ATYPE(CGROUP_INET_SOCK_ACCEPT);
 	default:
 		return CGROUP_BPF_ATTACH_TYPE_INVALID;
 	}
@@ -225,6 +226,9 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk)				       \
 	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET_SOCK_CREATE)
 
+#define BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(sk)			       \
+	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET_SOCK_ACCEPT)
+
 #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk)			       \
 	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET_SOCK_RELEASE)
 
@@ -482,6 +486,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk,skb) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET_BIND_LOCK(sk, uaddr, uaddrlen, atype, flags) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_INET4_POST_BIND(sk) ({ 0; })
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..80df246d4741 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1133,6 +1133,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_CGROUP_INET_SOCK_ACCEPT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 180b630279b9..dee9ae0c2a9a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2724,6 +2724,7 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET_INGRESS:
 		case BPF_CGROUP_INET_EGRESS:
+		case BPF_CGROUP_INET_SOCK_ACCEPT:
 		case BPF_CGROUP_SOCK_OPS:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
@@ -2742,6 +2743,7 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET_INGRESS:
 		case BPF_CGROUP_INET_EGRESS:
+		case BPF_CGROUP_INET_SOCK_ACCEPT:
 		case BPF_CGROUP_SOCK_OPS:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..23a801da230c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2640,6 +2640,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_CGROUP_SOCK:
 		switch (expected_attach_type) {
 		case BPF_CGROUP_INET_SOCK_CREATE:
+		case BPF_CGROUP_INET_SOCK_ACCEPT:
 		case BPF_CGROUP_INET_SOCK_RELEASE:
 		case BPF_CGROUP_INET4_POST_BIND:
 		case BPF_CGROUP_INET6_POST_BIND:
@@ -4194,6 +4195,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_INET_EGRESS:
 		return BPF_PROG_TYPE_CGROUP_SKB;
 	case BPF_CGROUP_INET_SOCK_CREATE:
+	case BPF_CGROUP_INET_SOCK_ACCEPT:
 	case BPF_CGROUP_INET_SOCK_RELEASE:
 	case BPF_CGROUP_INET4_POST_BIND:
 	case BPF_CGROUP_INET6_POST_BIND:
@@ -4515,6 +4517,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_INET_INGRESS:
 	case BPF_CGROUP_INET_EGRESS:
 	case BPF_CGROUP_INET_SOCK_CREATE:
+	case BPF_CGROUP_INET_SOCK_ACCEPT:
 	case BPF_CGROUP_INET_SOCK_RELEASE:
 	case BPF_CGROUP_INET4_BIND:
 	case BPF_CGROUP_INET6_BIND:
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index ae83ecda3983..ab613abdfaa4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 		kmem_cache_charge(newsk, gfp);
 	}
 
+	BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
+
 	if (mem_cgroup_sk_enabled(newsk)) {
 		int amt;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..80df246d4741 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1133,6 +1133,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_CGROUP_INET_SOCK_ACCEPT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.51.0.261.g7ce5a0a67e-goog


