Return-Path: <bpf+bounces-67809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE9B49D05
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09C21BC067D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F5E2EBDE3;
	Mon,  8 Sep 2025 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="II9xAT3L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EC42EB879
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371082; cv=none; b=YThHkWxO/q3+QDJdPEhDKa5FRmmJPFGrzA2OO/ygfVsJFr/xvLbedZM9h14dxt8YZJjeaHBKgIi4G0N9tPF6P9xYWLd09jxmz847BrCwhndry2FgZ7zoIPwz5tFMESZN/Ry7AsiFZ32RUo0NTZ1ZonmF3DixZ1dmr12G9BeInEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371082; c=relaxed/simple;
	bh=OQHEjiQbN68of5bcZU2JNmMCMrUIRC0lhUxGLj7BfQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ixWKW2xxS1U6wlcvQ4X5ngLizfKy/6O8834RjQF9BgnKQUgyYmuMNh7Z7dPAigCn+PNNIEv1j58ftNMStjJkeoXx6HBiUhrl2Bd/2dlo0VDDlSSza1TMW1wGTgqmOnr1BXmL/e8MgnxO6/wr3LxuNsTB9sgQzSFNiJEJHljPl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=II9xAT3L; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7742e89771eso2371037b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371080; x=1757975880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCZ4dVF6GmuXaxfvYs+08+FdSBhOb+rzmBGzwSpmAt4=;
        b=II9xAT3LfQATsjzKoqc/eX7pLgX/hEHPRbouV7+IY2BsXRO5hA17mgEGBjFIcaT8xy
         6VVIpUN8+hpGc0dfwGeiJDnPSHpe4PwEY+Jt2Z5vJKw4S/IDsvtm3Hn9JepLLNyVuBbQ
         274c8Fw6BwIFDYVEKA9yTWQ/7mEJzcc1O/MKFJhiVcXYZoAckHOLPOKOgg26XluZb4/N
         Smfv/thj17JzWwS3uBI+ypVCJ871jEYq7iPyl313vFPTpcnTgsxjNF969eE/0ZvfAO+L
         WZ+a99Zl6rqDjHhsj/ovLbns4kG8d48RQlEo1rC/6oa/rSXmrrGB+/sJNMVXLYT/n4Co
         AvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371080; x=1757975880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCZ4dVF6GmuXaxfvYs+08+FdSBhOb+rzmBGzwSpmAt4=;
        b=QAJ5x68QmSUTvqCcG2OzfaCMAYEM198OxLMqkXIW4FxN5fTJgf5xVwJdyuvOYMdVjb
         gdt7lXaoj/yFBOVcC5kYDx1HucTmGhrEac5bLIV7o2QayA51PQN5iOtQQ2lttDji0DJF
         LwgF45VkvTzYKKB8LY4k+fYYJNBEp6JC9SdX9qLhqxXWEfbY6B/iNATpeN33DnrQiB/h
         59DOSJY+j2Aaz7dHoPKSoJky1WV/MoYbEHWSLfzlJSJ4kwZCT6sVQrW+G3yudbFy1+UZ
         okBsOSJ/3a9pOf2JyjSq1rqrRZSuHNVolxC0P3b9XRNv4TYlyLrR4qze8IIUGJ0jBNyN
         6PWw==
X-Forwarded-Encrypted: i=1; AJvYcCWwLs4/TOBKLu8o5Bdj14mY29BVE6198TEfpG7n06SUVpb7c10r9tyhdAvqqtDrM0hMH/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUl3Km86y+4sR0rRPGWAd9h7K8TrmwlhKucrMYs7N3zr4r/0zX
	GdJd/Hnd8ZP/wfACyX+mX9K8rV3CFkfg32Q63DKx5OcG0cmOx8ax2GFYFhja9Kl/lTQvQCqJERX
	mEnnnew==
X-Google-Smtp-Source: AGHT+IFGpM5T4UptOIvM5H7xRo/fwFVQVoQocC2uALvZYPLv5ajsWTAHOf14CqlOkbBF0GHfoxxeC9a4Oqk=
X-Received: from pfbhr3-n2.prod.google.com ([2002:a05:6a00:6b83:20b0:770:5229:752e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:234a:b0:772:2988:31d8
 with SMTP id d2e1a72fcca58-7742e382d23mr10889038b3a.2.1757371079986; Mon, 08
 Sep 2025 15:37:59 -0700 (PDT)
Date: Mon,  8 Sep 2025 22:34:37 +0000
In-Reply-To: <20250908223750.3375376-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908223750.3375376-4-kuniyu@google.com>
Subject: [PATCH v6 bpf-next/net 3/5] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
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

SK_BPF_MEMCG_FLAGS is only supported at BPF_CGROUP_INET_SOCK_CREATE
and not supported on other hooks for some reasons:

  1. UDP charges memory under sk->sk_receive_queue.lock instead
     of lock_sock()

  2. For TCP child sockets, memory accounting is adjusted only in
     __inet_accept() which sk->sk_memcg allocation is deferred to

  3. Modifying the flag after skb is charged to sk requires such
     adjustment during bpf_setsockopt() and complicates the logic
     unnecessarily

We can support other hooks later if a real use case justifies that.

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
v5:
  * Limit getsockopt() to BPF_CGROUP_INET_SOCK_CREATE

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
 net/core/filter.c              | 34 +++++++++++++++++++++++
 net/core/sock.c                |  1 +
 net/ipv4/af_inet.c             |  4 +++
 tools/include/uapi/linux/bpf.h |  6 ++++
 6 files changed, 101 insertions(+)

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
index 31b259f02ee9..df2496120076 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5723,9 +5723,39 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+static int sk_bpf_set_get_memcg_flags(struct sock *sk,
+				      char *optval, int optlen,
+				      bool getopt)
+{
+	u32 flags;
+
+	if (optlen != sizeof(u32))
+		return -EINVAL;
+
+	if (!sk_has_account(sk))
+		return -EOPNOTSUPP;
+
+	if (getopt) {
+		*(u32 *)optval = mem_cgroup_sk_get_flags(sk);
+		return 0;
+	}
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
 BPF_CALL_5(bpf_sock_create_setsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (IS_ENABLED(CONFIG_MEMCG) &&
+	    level == SOL_SOCKET && optname == SK_BPF_MEMCG_FLAGS)
+		return sk_bpf_set_get_memcg_flags(sk, optval, optlen, false);
+
 	return __bpf_setsockopt(sk, level, optname, optval, optlen);
 }
 
@@ -5743,6 +5773,10 @@ static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
 BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (IS_ENABLED(CONFIG_MEMCG) &&
+	    level == SOL_SOCKET && optname == SK_BPF_MEMCG_FLAGS)
+		return sk_bpf_set_get_memcg_flags(sk, optval, optlen, true);
+
 	return __bpf_getsockopt(sk, level, optname, optval, optlen);
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
2.51.0.384.g4c02a37b29-goog


