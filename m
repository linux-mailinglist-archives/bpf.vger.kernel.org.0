Return-Path: <bpf+bounces-66916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C98B3B026
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83DAE4E0F89
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BDB1FBE80;
	Fri, 29 Aug 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZStvGwD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB01EE7DD
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429238; cv=none; b=B6jydTLEiHNbYFm9bPtamYlYL3ELUaq60WmzxQ4aTvfnRvnxG0KfhACftkC9ZRrQQGc44bVARDwaH2RQX3FeqSTXykViNCxKSVbO4oqhFyPBgpuZbW81XKiFZfKImQ2hPqrZuOMODwf+6mKGoWtZfU9R2x/6W/s+BV5++lmzBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429238; c=relaxed/simple;
	bh=xj6Vqlg3PFj0yxql0CK/3/uTOG8Lc3MsKWtr6dh2c0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PBzHyq+HvrtzynBVfgu2MdOnLfwM4vYV2vSD+zbGMQRaUs7unNitUNEv05ZjicvAyC7TMRP8yVvRf1JykRttAz06BQf4wVGxwj0NuoeszaVFToiC0e0Kk17tXI3FCFKnTQKfIHVGSXE+KVdtc+ZKhnmytZJ0GR6POdRKsuXfs2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZStvGwD; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7722bdaf7acso219938b3a.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429235; x=1757034035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2GbkWdfDVBxAwzWB5hYXEoCpmEtienkBEFWO4jTnMg=;
        b=mZStvGwD5U5Ul5Ty9lWC9XSu6mvSwgNGtjG/E6RaK0jXe3fOckMwYaD5PjOvXxl5mP
         9E7eh/nZqmUnNbHtGsU+UQY5GClyjL1PAV55O2LEsJdXNoLZ8i2YWgPi1Rj0CvO89ESZ
         CzFseopdS88cZXt6UbIR5a7FwKiBoEG+M46VMNVRVPjjbiUefJUvC96UuRlGuAObGcc2
         5K0RQ+EgC9cbdoYa9xLG6LM0xevPBGqtnqNM9NKJ6NzNId+tYXFio9mz86912zRtukyf
         Yd+DX3H+CnGP5EteCSPBFlXscG+6bOAy+SsJDtZWLRYu4avjPp8x4ceqmd8CxXfOcBK/
         fxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429235; x=1757034035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2GbkWdfDVBxAwzWB5hYXEoCpmEtienkBEFWO4jTnMg=;
        b=rPej1slXVtvHa+sdOQMuBDQdEpET2iCULg/NRPFaOydhRJz6D5ncxAuqj2YZKGydgn
         6wYXINkNj/Q7uU2PuEe6qw2uARxvKR7GzFMXlaPvy56NayQLKXI6PROVmJrA1ISUYsZL
         pQrNASDcpn9est3MaFvj/sCs1eJ3OqrbIYrh57TbOv11AKzYcXOxRF487KcynnmSdwVD
         sBUChSdQAOKlM+Zf+zo05UapSNsCYSwoVHZ4D5o41Mjy79EYcchhH4cZvuhAO1tkOv40
         das5GuPprU9XHAc7GMzO/InyViwzZPJY7YU57zaqrqHEYHhI2J2lIyFkM8wG8A1DJJY2
         gL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVme7lMDxnkZvC836HmG3zO4ln7/rTqihz97QnyFi5bzcX/09ZpJWQlSpTjsDvrxCOyaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTC/L/0AQIO37eD6a+rhk4aRBPC+1E6X9db60zXMB6sxlkl/5
	/pBpq147c/mXM5FYK8kJUVyH7NIS/u1iZ6JUoE4v+YE8apufF7QXfWEuF2FNzGxTGyGz6K4k4GP
	M4UJWhw==
X-Google-Smtp-Source: AGHT+IF79sxrN/ri7Tb/nlThw9NgU5qUncg/hWaazuqagby3B/96dpboHxegqnVvx45skkDPFWt6v47IqiA=
X-Received: from pfbdc5.prod.google.com ([2002:a05:6a00:35c5:b0:772:2c52:356b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da0:b0:772:ce8:d894
 with SMTP id d2e1a72fcca58-7720ce8dc01mr9098319b3a.29.1756429235391; Thu, 28
 Aug 2025 18:00:35 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:00:06 +0000
In-Reply-To: <20250829010026.347440-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829010026.347440-4-kuniyu@google.com>
Subject: [PATCH v4 bpf-next/net 3/5] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
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

We will decouple sockets from the global protocol memory accounting
if sockets have SK_BPF_MEMCG_SOCK_ISOLATED.

This can be flagged (and cleared) at the BPF_CGROUP_INET_SOCK_CREATE
hook by bpf_setsockopt() and is inherited to child sockets.

  u32 flags = SK_BPF_MEMCG_SOCK_ISOLATED;

  bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
                 &flags, sizeof(flags));

bpf_setsockopt(SK_BPF_MEMCG_FLAGS) is only supported at
bpf_unlocked_sock_setsockopt() and not supported on other hooks
for some reasons:

  1. UDP charges memory under sk->sk_receive_queue.lock instead
     of lock_sock()

  2. For TCP child sockets, memory accounting is adjusted only in
     __inet_accept() which sk->sk_memcg allocation is deferred to

  3. Modifying the flag after skb is charged to sk requires such
     adjustment during bpf_setsockopt() and complicates the logic
     unnecessarily

We can support other hooks later if a real use case justifies that.

OTOH, bpf_getsockopt() is supported on other hooks, e.g. bpf_iter,
for the debugging purpose.

Given sk->sk_memcg can be accessed in the fast path, it would
be preferable to place the flag field in the same cache line as
sk->sk_memcg.

However, struct sock does not have such a 1-byte hole.

Let's store the flag in the lowest bit of sk->sk_memcg and add
a helper to check the bit.

In the next patch, if mem_cgroup_sk_isolated() returns true,
the socket will not be charged to sk->sk_prot->memory_allocated.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4:
  * Only allow inet_create() to set flags
  * Inherit flags from listener to child in sk_clone_lock()
  * Support clearing flags

v3:
  * Allow setting flags without sk->sk_memcg in sk_bpf_set_get_memcg_flags()
  * Preserve flags in __inet_accept()

v2:
  * s/mem_cgroup_sk_set_flag/mem_cgroup_sk_set_flags/ when CONFIG_MEMCG=n
  * Use CONFIG_CGROUP_BPF instead of CONFIG_BPF_SYSCALL for ifdef
---
 include/net/sock.h             | 50 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  6 ++++
 net/core/filter.c              | 43 ++++++++++++++++++++++++++++-
 net/core/sock.c                |  1 +
 net/ipv4/af_inet.c             |  4 +++
 tools/include/uapi/linux/bpf.h |  6 ++++
 6 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 63a6a48afb48..703cb9116c6e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2596,10 +2596,41 @@ static inline gfp_t gfp_memcg_charge(void)
 	return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
 }
 
+#define SK_BPF_MEMCG_FLAG_MASK	(SK_BPF_MEMCG_FLAG_MAX - 1)
+#define SK_BPF_MEMCG_PTR_MASK	~SK_BPF_MEMCG_FLAG_MASK
+
 #ifdef CONFIG_MEMCG
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
+#ifdef CONFIG_CGROUP_BPF
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	val &= SK_BPF_MEMCG_PTR_MASK;
+	return (struct mem_cgroup *)val;
+#else
 	return sk->sk_memcg;
+#endif
+}
+
+static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
+{
+#ifdef CONFIG_CGROUP_BPF
+	unsigned long val = (unsigned long)mem_cgroup_from_sk(sk);
+
+	val |= flags;
+	sk->sk_memcg = (struct mem_cgroup *)val;
+#endif
+}
+
+static inline unsigned short mem_cgroup_sk_get_flags(const struct sock *sk)
+{
+#ifdef CONFIG_CGROUP_BPF
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	return val & SK_BPF_MEMCG_FLAG_MASK;
+#else
+	return 0;
+#endif
 }
 
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
@@ -2607,6 +2638,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	return mem_cgroup_sk_get_flags(sk) & SK_BPF_MEMCG_SOCK_ISOLATED;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
@@ -2629,11 +2665,25 @@ static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 	return NULL;
 }
 
+static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
+{
+}
+
+static inline unsigned short mem_cgroup_sk_get_flags(const struct sock *sk)
+{
+	return 0;
+}
+
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return false;
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	return false;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..52b8c2278589 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7182,6 +7182,7 @@ enum {
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
+	SK_BPF_MEMCG_FLAGS	= 1010, /* Get or Set flags saved in sk->sk_memcg */
 };
 
 enum {
@@ -7204,6 +7205,11 @@ enum {
 						 */
 };
 
+enum {
+	SK_BPF_MEMCG_SOCK_ISOLATED	= (1UL << 0),
+	SK_BPF_MEMCG_FLAG_MAX		= (1UL << 1),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
diff --git a/net/core/filter.c b/net/core/filter.c
index b6d514039cf8..eb2f87a732ef 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5267,6 +5267,35 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
 	return 0;
 }
 
+static int sk_bpf_get_memcg_flags(struct sock *sk, char *optval)
+{
+	if (!sk_has_account(sk))
+		return -EOPNOTSUPP;
+
+	*(u32 *)optval = mem_cgroup_sk_get_flags(sk);
+
+	return 0;
+}
+
+static int sk_bpf_set_memcg_flags(struct sock *sk, char *optval, int optlen)
+{
+	u32 flags;
+
+	if (optlen != sizeof(u32))
+		return -EINVAL;
+
+	if (!sk_has_account(sk))
+		return -EOPNOTSUPP;
+
+	flags = *(u32 *)optval;
+	if (flags >= SK_BPF_MEMCG_FLAG_MAX)
+		return -EINVAL;
+
+	mem_cgroup_sk_set_flags(sk, flags);
+
+	return 0;
+}
+
 static int sol_socket_sockopt(struct sock *sk, int optname,
 			      char *optval, int *optlen,
 			      bool getopt)
@@ -5284,6 +5313,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
 	case SK_BPF_CB_FLAGS:
+	case SK_BPF_MEMCG_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5293,8 +5323,15 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		return -EINVAL;
 	}
 
-	if (optname == SK_BPF_CB_FLAGS)
+	switch (optname) {
+	case SK_BPF_CB_FLAGS:
 		return sk_bpf_set_get_cb_flags(sk, optval, getopt);
+	case SK_BPF_MEMCG_FLAGS:
+		if (!IS_ENABLED(CONFIG_MEMCG) || !getopt)
+			return -EOPNOTSUPP;
+
+		return sk_bpf_get_memcg_flags(sk, optval);
+	}
 
 	if (getopt) {
 		if (optname == SO_BINDTODEVICE)
@@ -5726,6 +5763,10 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (IS_ENABLED(CONFIG_MEMCG) &&
+	    level == SOL_SOCKET && optname == SK_BPF_MEMCG_FLAGS)
+		return sk_bpf_set_memcg_flags(sk, optval, optlen);
+
 	return __bpf_setsockopt(sk, level, optname, optval, optlen);
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 8002ac6293dc..ae30d7d54498 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2515,6 +2515,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 #ifdef CONFIG_MEMCG
 	/* sk->sk_memcg will be populated at accept() time */
 	newsk->sk_memcg = NULL;
+	mem_cgroup_sk_set_flags(newsk, mem_cgroup_sk_get_flags(sk));
 #endif
 
 	cgroup_sk_clone(&newsk->sk_cgrp_data);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d42757f74c6e..9b62f1ae13ba 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -758,12 +758,16 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
 	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+		unsigned short flags;
 
+		flags = mem_cgroup_sk_get_flags(newsk);
 		mem_cgroup_sk_alloc(newsk);
 
 		if (mem_cgroup_from_sk(newsk)) {
 			int amt;
 
+			mem_cgroup_sk_set_flags(newsk, flags);
+
 			/* The socket has not been accepted yet, no need
 			 * to look at newsk->sk_wmem_queued.
 			 */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..52b8c2278589 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7182,6 +7182,7 @@ enum {
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
+	SK_BPF_MEMCG_FLAGS	= 1010, /* Get or Set flags saved in sk->sk_memcg */
 };
 
 enum {
@@ -7204,6 +7205,11 @@ enum {
 						 */
 };
 
+enum {
+	SK_BPF_MEMCG_SOCK_ISOLATED	= (1UL << 0),
+	SK_BPF_MEMCG_FLAG_MAX		= (1UL << 1),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
-- 
2.51.0.318.gd7df087d1a-goog


