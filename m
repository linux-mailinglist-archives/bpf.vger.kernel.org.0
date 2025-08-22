Return-Path: <bpf+bounces-66322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F1B324FA
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0FAB06441
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668A2FF143;
	Fri, 22 Aug 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQBW6uhA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809F285CB6
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901140; cv=none; b=pIhq4YKwKoIQsaYIY3ZM4t91p/ONSw2Zf4J6fC9dXQvupU6ZZ8yS1rtXvLxcbrL5TJMXEqr61kJZ4xkk6KcD/Gr5rJBa09f8LvrbgXNQJkdn2c9miwenm1Rsbf5EJIuX2YGVCwESRmKwVZKu9TIujacx+zkgnTGpRVB8p8Mjm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901140; c=relaxed/simple;
	bh=/NWJL1wmsuEzZOaEZz7IyvMyuJ96SbtzpEqZoYd11ds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OyCJFc3d3LifEY0QDiUKGbnZ4ScRmIeLM9pOjNK9/O90qwTw0x+vLSIPWs4vh/dOtHspHoS3M5BfXF5xfy5zR+dV8euJ9xcrKcd3ViG2LO1fHhXxUT4BwZ0PgaDd6FUx2y6MK6AiPx6a/45tJK/v6GTJpQzgY0TWj9BflNV8G1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQBW6uhA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4750376ca8so1737974a12.2
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901138; x=1756505938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7M+CnGcTpCVxuVAkgAkBI8z3UPXo/wQzGJoW95ftmg=;
        b=eQBW6uhAWNO8+/KhZQI2nUBqhQreu7e8iAO1+Cy0Y+YvX2d3TfOX40Lb6okFRhqoZH
         aCx/Vk89dGDdVc5aRr3tlZHjltoT1+fuGT0Shx1UyA2qJkZjwuyZKINa/JvfMNiTvoZE
         gY3ck2EnI2gAX+DVBCKmj6yNgcf4Xf9nx89IBaTy+N4fk1K3+/sjvg4hi4towP7Lx7yM
         8ey2CoU9J/UGfyP3vtSVoB7IKOMl8sLnaB+Tq+cnEDOFNujcgHB2d/f3KZo3rr3o9x0C
         N0Y1Tp6dd6UvInt4W28SypzPTGHCFh+fZteWUSotMbegX/QADWlJ/xWgj/TDzXzswf97
         GQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901138; x=1756505938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7M+CnGcTpCVxuVAkgAkBI8z3UPXo/wQzGJoW95ftmg=;
        b=V5H4c2xTTg0tmEpVMt/rSfINtk7T6rIl1xGEtvGqi/CRrufO9AQOe53PIJ3oBAZFsa
         0UPfX/qHNFujs1dSPMeE+oGrB2KNGQH4CmJDCQDDu4vdMNV454mZ+k0+QblaK+Y7WFQX
         GXdLqCPsKTNiqK9HfMCin8ha/eisKJsyDf0Fe9XefxoMqh0Lrw5bdS5pa1FmaDxmHKJZ
         IWMyUnaL7dIQNvTjihYnHXnFvyE57KqeRU99D7icmSIgjIXe3t2nQP9ZKmWuXkPAPTam
         Y49RaCMOwUihd+LKDWERxc+Bb+l/dL012wcEv21olKPyq8Rw3V2OIKuc2TPg/DFef/WY
         QJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVoVUTfj7ZHl+CF3ChSVcEfn5TqZkVJYIguTCxNKvH/eGUvLihESuiCyS7ik2TArszdhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+paYdgtnVLfmlXpvsefwp3xyMw/m3Mc4scVXHM/KpTUjj0eUu
	3a0afzukZDHElHT+CsNtOYqdItKHvvVoFSBi4v16kQD7E922Oh0GThYzl6S5HWHaOEnY1uB94dt
	3hz6dow==
X-Google-Smtp-Source: AGHT+IGyDbStFF3KyCpNXq5NKyutS6eQntdmyicyHuuY0diu1TbRY/mtcjK6mBu+DEnj8IC3OSXBWy9kl7E=
X-Received: from pgam18.prod.google.com ([2002:a05:6a02:2b52:b0:b47:699d:842f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa4:b0:243:25b0:2321
 with SMTP id adf61e73a8af0-24340e443cdmr6942737637.52.1755901138612; Fri, 22
 Aug 2025 15:18:58 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:18:01 +0000
In-Reply-To: <20250822221846.744252-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-7-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 6/8] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
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

This can be flagged via bpf_setsockopt() during socket() or accept():

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

Note that we do not support other hooks because UDP charges memory
under sk->sk_receive_queue.lock instead of lock_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h             | 48 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  6 +++++
 net/core/filter.c              | 32 ++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  6 +++++
 4 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 63a6a48afb48..fb33a7af7c9a 100644
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
+#ifdef CONFIG_BPF_SYSCALL
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
+#ifdef CONFIG_BPF_SYSCALL
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
+static inline void mem_cgroup_sk_set_flag(struct sock *sk, unsigned short flags)
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
index 80df246d4741..9657496e0f3c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7183,6 +7183,7 @@ enum {
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
+	SK_BPF_MEMCG_FLAGS	= 1010, /* Get or Set flags saved in sk->sk_memcg */
 };
 
 enum {
@@ -7205,6 +7206,11 @@ enum {
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
index aa17c7ed5aed..d8a9f73095fb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5267,6 +5267,31 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool getopt)
 	return 0;
 }
 
+static int sk_bpf_set_get_memcg_flags(struct sock *sk, int *optval, bool getopt)
+{
+	if (!mem_cgroup_sk_enabled(sk))
+		return -EOPNOTSUPP;
+
+	if (getopt) {
+		*optval = mem_cgroup_sk_get_flags(sk);
+		return 0;
+	}
+
+	/* Don't allow once sk has been published to userspace.
+	 * INET_CREATE is called without lock_sock() but with sk_socket
+	 * INET_ACCEPT is called with lock_sock() but without sk_socket
+	 */
+	if (sock_owned_by_user_nocheck(sk) && sk->sk_socket)
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
@@ -5284,6 +5309,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
 	case SK_BPF_CB_FLAGS:
+	case SK_BPF_MEMCG_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5293,8 +5319,12 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 80df246d4741..9657496e0f3c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7183,6 +7183,7 @@ enum {
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
+	SK_BPF_MEMCG_FLAGS	= 1010, /* Get or Set flags saved in sk->sk_memcg */
 };
 
 enum {
@@ -7205,6 +7206,11 @@ enum {
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
2.51.0.rc2.233.g662b1ed5c5-goog


