Return-Path: <bpf+bounces-66584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D11A7B3725F
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 20:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6F894E201A
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCD3728AB;
	Tue, 26 Aug 2025 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHbTApz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF17C372895
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233612; cv=none; b=URnSOLopxq4owq2mX22AhOUIvrSVmnyrqNj9zxUp0VnEr5M1igx/O0I6kz0LAFMm4r77TvKV0MttmKS7bpPwno0BuyiOWMGYWUTQsVpYf24u5u8wvePCw1NaxjW/pUosSHMEaEX0fW/Bt8NrOcgb6OjqSGaU1FZcYq4EYiWFcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233612; c=relaxed/simple;
	bh=4vgLUFd9RZeB6/jBKnlLgA0SC0nLasSC8wAFedlWobg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XBg8ZcJPjPdhTBZCmeCdFJGl0qvfGHBJYqRTzwJOcduNdxnyZsUl73BNj/1ku4Kr46m1mFKkLrZIb1dZIN/QF3lTMb02qcBLQXn1xTcFGP493E8V7fRLU7l37WaXA8dBhuTWoqGuLq38EtvFNDYnRv6Tqx1+wRNj9X3Wcg3pHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHbTApz5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246fbc9a3ecso20141385ad.3
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756233610; x=1756838410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLPQQCHOMUrRCy7URA/m/9B1gloRdIuH7D/8J0zmwRU=;
        b=iHbTApz5KLdQztzOHg+n11PDyzddSwX6E6lD+9F2u1/cSJS40ZfiUnctgaNEq163re
         pQRs6OZSakOGnrySWe/bzgEGeXhTX37GRDJmAiZNYLwOZT1MD3mH0lN/aCG2UCt0yIy9
         xuRt852uZQFUKj+elWkCioqy7oz6FV4fxTIg8OkVTcSakUSd1idN9EyOHiIH7psccWOI
         D/d9fsyNSoid1kkADsxUOBRiRUMGgYCyKjYRVKDueW9C89akshuRJ0nwXKpY8WaVXm7D
         0dUc2Tzz2pCpFBWS6KaZfpDKTNvB4WXUTAZ5IRzLVneeVd2Iep9Ny8GZ7EsCRGU6SqSI
         OCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233610; x=1756838410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLPQQCHOMUrRCy7URA/m/9B1gloRdIuH7D/8J0zmwRU=;
        b=j0gycrfigejwTVZ38fm4CF5+3lqzdD+5FovUL1FN7mB+huVi9q0aslc5eXA/JXErdA
         xFOap46IGE540A9mdmYe0FEBCjdDF2Ql7jK6E5RSDltFGRMLB9Hs0oPni/IzLW7wWf5P
         LgX11o7VtXNJA5n4G4VxFxJhfXvTK4Q4Yslcc02KX8jN2eK21rCzOvO7LU4O+bQDDHjj
         VHT1Sv9rANF5q0I28wbOCXXYKD55MQoiaIxzwGbaDAOeMyJjlEmFYn9Pl6Ig+iLU3W7A
         44uGAu7XIk/7BwHaJf4uEzzJLlZ335w4kkJe2CKhVVvLcntr+qVzeJHERG4XP4yXz4mm
         ur6g==
X-Forwarded-Encrypted: i=1; AJvYcCXNO/c8tyabmGizZFvZiWkWtz8veBKqEmdCkRbvkqbJ76nTmBPX9UENw+f0hyjQjTsS4Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcby2EqM2RTIzmd7h6tGolF9yMvI0NWROT4jaQkGNtnBEAxTJu
	I/+aFRX1IRF1urB1hSaAOTiqShenyGsVpMoLqvGjEp606rnSrTFyHDTQ/DAPGUo9U8uikcYtvx5
	QPVh4Rg==
X-Google-Smtp-Source: AGHT+IGJznsVaigKS39xUOObMztlHsUarIUo4h1T9n7ROBTqMa4UBufM7WXzpE9v3K2KyItRif1fr025+V8=
X-Received: from pjbsi9.prod.google.com ([2002:a17:90b:5289:b0:312:14e5:174b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b48:b0:246:6113:f1a8
 with SMTP id d9443c01a7336-2466113f4e7mr176972405ad.40.1756233609902; Tue, 26
 Aug 2025 11:40:09 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:38:09 +0000
In-Reply-To: <20250826183940.3310118-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826183940.3310118-4-kuniyu@google.com>
Subject: [PATCH v3 bpf-next/net 3/5] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
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

This can be flagged, during socket() or before sk->sk_memcg is set
in accept(), via bpf_setsockopt():

  flags = SK_BPF_MEMCG_SOCK_ISOLATED;
  bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
                 &flags, sizeof(flags));

Given sk->sk_memcg can be accessed in the fast path, it would
be preferable to place the flag field in the same cache line as
sk->sk_memcg.

However, struct sock does not have such a 1-byte hole.

Let's store the flag in the lowest bit of sk->sk_memcg and add
a helper to check the bit.

In the next patch, if mem_cgroup_sk_isolated() returns true,
the socket will not be charged to sk->sk_prot->memory_allocated.

The main targets are BPF_CGROUP_INET_SOCK_CREATE and
BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB as demonstrated in the selftest.

Note that we do not support modifying the flag once sk->sk_memcg is set
especially because UDP charges memory under sk->sk_receive_queue.lock
instead of lock_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3:
  * Allow setting flags without sk->sk_memcg in sk_bpf_set_get_memcg_flags()
  * Inherit flags in __inet_accept()

v2:
  * s/mem_cgroup_sk_set_flag/mem_cgroup_sk_set_flags/ when CONFIG_MEMCG=n
  * Use CONFIG_CGROUP_BPF instead of CONFIG_BPF_SYSCALL for ifdef
---
 include/net/sock.h             | 48 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  6 +++++
 net/core/filter.c              | 28 +++++++++++++++++++-
 net/ipv4/af_inet.c             |  4 +++
 tools/include/uapi/linux/bpf.h |  6 +++++
 5 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 63a6a48afb48..d41a2f8f8b30 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2596,10 +2596,39 @@ static inline gfp_t gfp_memcg_charge(void)
 	return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
 }
 
+#define SK_BPF_MEMCG_FLAG_MASK	(SK_BPF_MEMCG_FLAG_MAX - 1)
+#define SK_BPF_MEMCG_PTR_MASK	~SK_BPF_MEMCG_FLAG_MASK
+
 #ifdef CONFIG_MEMCG
+static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
+{
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	val |= flags;
+	sk->sk_memcg = (struct mem_cgroup *)val;
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
+}
+
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
 }
 
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
@@ -2607,6 +2636,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
@@ -2624,6 +2658,15 @@ static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 	return false;
 }
 #else
+static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
+{
+}
+
+static inline unsigned short mem_cgroup_sk_get_flags(const struct sock *sk)
+{
+	return 0;
+}
+
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
 	return NULL;
@@ -2634,6 +2677,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
index 443d12b7d3b2..943ae6d7d637 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5267,6 +5267,27 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
 	return 0;
 }
 
+static int sk_bpf_set_get_memcg_flags(struct sock *sk, int *optval, bool getopt)
+{
+	if (!sk_has_account(sk))
+		return -EOPNOTSUPP;
+
+	if (getopt) {
+		*optval = mem_cgroup_sk_get_flags(sk);
+		return 0;
+	}
+
+	if (sock_owned_by_user_nocheck(sk) && mem_cgroup_from_sk(sk))
+		return -EBUSY;
+
+	if (*optval <= 0 || *optval >= SK_BPF_MEMCG_FLAG_MAX)
+		return -EINVAL;
+
+	mem_cgroup_sk_set_flags(sk, *optval);
+
+	return 0;
+}
+
 static int sol_socket_sockopt(struct sock *sk, int optname,
 			      char *optval, int *optlen,
 			      bool getopt)
@@ -5284,6 +5305,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
 	case SK_BPF_CB_FLAGS:
+	case SK_BPF_MEMCG_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5293,8 +5315,12 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		return -EINVAL;
 	}
 
-	if (optname == SK_BPF_CB_FLAGS)
+	switch (optname) {
+	case SK_BPF_CB_FLAGS:
 		return sk_bpf_set_get_cb_flags(sk, optval, getopt);
+	case SK_BPF_MEMCG_FLAGS:
+		return sk_bpf_set_get_memcg_flags(sk, (int *)optval, getopt);
+	}
 
 	if (getopt) {
 		if (optname == SO_BINDTODEVICE)
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


