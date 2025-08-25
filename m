Return-Path: <bpf+bounces-66454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CEAB34C3E
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96BA7AF03D
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0992FF649;
	Mon, 25 Aug 2025 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOaNXZ71"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F632FA0E2
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154532; cv=none; b=fC/pJGRHE5sj0dTmXerOuh+3HmMSCfiA+Yy5+PWnINsbP0tyWksnxoBu0g6SRiISfv2JpnqtAih9G/17f1QI1qw38jzQabF91M/EMW2LxREwvVnlLpJgb7qNs8MwbkQUGNYQDZXOzOEBTH2eJN/D5fIz06AxrvkPGFogyvfXCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154532; c=relaxed/simple;
	bh=8J91X27kwkG3J1o/KwmX8tCJqR6ZHQPHGOmeCjEAYnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nhltIYDmygJDhoAKRyLStyxChCif9cyiWnD0n1sAW9BOuU/jzXjdLYYZETnvTm4HyeEzUPPygRscF6r9TyVQWhyouZkj++xErualB48xCEY4J8xfZqIkyKxIHc26imM1b0ZgRxBW/8tz5ab8UGT54bs2rFgboySK166O7cv+CLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WOaNXZ71; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47174bdce2so3810214a12.2
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154530; x=1756759330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZbqORmGAVXvrcsrYy+vWRcR/4pp02lgb0ulvhwqppc=;
        b=WOaNXZ71yCOQaWTuBJXfQe37/mGMn1HLtA2y6kh2iB5zH4SWJZWe+Wx3DrEnS++Jdn
         mv4xdMUvBg1Ke7C+ZZs0kTS5NMcjbPMqQn3WLT+p/heuC1+xVhovFGB6NC8slh+H+ct6
         ymlroG4JULbH0mS+0CSYzSDWaHDCemYDOID9gFHSz4t4OIpq3qA9sN9t2Ky5+JWAj8h/
         bNdNIuMv1H6plgPo296sNf/8tp5F6THpUJUXIT1nHbqGIEHih8AdfXSakvZf69g1hkD0
         NeucFhxdRgkdaMS2f72uZgKtiVXFAa61TWGW8xJPycnugzc+dBsj+cnJ0+kMko5u4f2y
         WBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154530; x=1756759330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZbqORmGAVXvrcsrYy+vWRcR/4pp02lgb0ulvhwqppc=;
        b=frUFhPfxjVhgNmepXlmHQYpuxrAGf8QktN5n9BjMxVYb8m9BWS9fPopEf8P7vQWrUH
         B6KMhLqevVsjHGI/2n2bHuYu0tjdE+psCMRweXi2SbKJI5qGydqv6VsSeGrXPjNOr0Xs
         dh8M4NBUfPTlRXnBOcLehv31s7BpVZgAUsxXjPbf4CbSI5jCeXjwbVCMxnLJUiKDOUdU
         9Hn3weeVgsMPBHzk9YWj7Ub28kMw6jqKtC1M50ybHhyCfWTyhyK5mAzBC3uQft8UOOUh
         fbTOG/pqBV1lQl3Z610IP758R8rBEpBawL3vUAOjKKrThipDqISm1muMO1F73qtCXtvM
         Q0zA==
X-Forwarded-Encrypted: i=1; AJvYcCWErECcIwhWt7CIqHe1QdbzzsHOhT0HAk9SPPRjsZlRDKdMpffaYE8MsMZD1l5r/lRurh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTUbTWzfbY4olC4y9duMaDkoSIXBUnJ5zD8s/HyiJCtkPXTNC
	uR65VRtrvpvWUICktpRZ9DCN5hhxZJH1rwkWkFPC9u+gUEvrdM1Z/AOqao1rUSGNLqb/xi8+gIw
	TQSCS/w==
X-Google-Smtp-Source: AGHT+IEbQhuHGnZeecHiqABL2up3AfDnhKI2khVJ9XYYnLg+6J7dFB95hkuLG+azsczwAJBNl+L7oBx1xyg=
X-Received: from pjd5.prod.google.com ([2002:a17:90b:54c5:b0:2fb:fa85:1678])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c6:b0:246:a90e:9179
 with SMTP id d9443c01a7336-246a90eaf13mr88700315ad.28.1756154529862; Mon, 25
 Aug 2025 13:42:09 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:29 +0000
In-Reply-To: <20250825204158.2414402-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-7-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 6/8] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
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
v2:
  * s/mem_cgroup_sk_set_flag/mem_cgroup_sk_set_flags/ when CONFIG_MEMCG=n
  * Use CONFIG_CGROUP_BPF instead of CONFIG_BPF_SYSCALL for ifdef
---
 include/net/sock.h             | 48 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  6 +++++
 net/core/filter.c              | 32 ++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  6 +++++
 4 files changed, 91 insertions(+), 1 deletion(-)

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
index 1fa40b4d3d85..a78356682442 100644
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
+	 * INET_SOCK_CREATE is called without lock_sock() but with sk_socket
+	 * INET_SOCK_ACCEPT is called with lock_sock() but without sk_socket
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
2.51.0.261.g7ce5a0a67e-goog


