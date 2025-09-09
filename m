Return-Path: <bpf+bounces-67939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC7FB5075D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867647B5532
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836D836206C;
	Tue,  9 Sep 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boEzsVxT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86E35CECF
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450802; cv=none; b=LloKkSz6OnRqHH5qARZevGdrLUuCeZjibEcPdei261xn2HZBOY9k4eL5mzehZjvssa6IesbkK/YBX8JUDo7p/wxP9tTo3AGWPmM0CQWseBCHpOsUL7+BXoZPv68B3rafXBgiXzhGWH5++ugODGRJMiq7Ced42lrdPBXdgaI1n5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450802; c=relaxed/simple;
	bh=CLITwuzgTCobvfT4Cy7qoPmNTRtPW70MX/oVblpLXPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XL4iTCVLXKwzqifYA16osZrr9xfXGYGbBhqNM6gQbE72mgPM5p2hR/jFqDu0eY+2VSR46o8TIBwyVx5b7SbAcexYzMtqedrh3QXGvYrHVNqUtARqForoRsIv2psA/04NGn2SobUZvL6HtaHoj5102/4Bp5F864ozDqdPpdQfWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boEzsVxT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4f86568434so4975621a12.2
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757450799; x=1758055599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tk0Z6VoWVLyw2cW8ACyafnjyZH1DhAGy7rjwLShHFc=;
        b=boEzsVxT+33yx98WwBjIkjYhf5r+bxFnH9ZGGMcUXT08Mn6zFSSddHyP7OzddZiuK3
         zNZdIilU7yRC435M+WDGEWAreAwqctitDJkZVNg8EIX7mieedk8yatZQ8v9uiZPQaLZM
         qgwNGJmzV2YHgsfUCxLNvwP2B+WgyE8jAblTLxsK0XhBKCXuwui176Dcgz70w9W9DSBP
         6R2g3MsrNCgJQYy04FiVDJpT74ZF1gfkG2khk391DmGEiSHpN41MGxMahkmPF1tar8s1
         ExsUyaNYa+JwNUs8XtnfvhSv+bxN+06uiMk4jQ2WiDtQOEnxdkT63h8/G9z9bDV0Nv4r
         2eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450799; x=1758055599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tk0Z6VoWVLyw2cW8ACyafnjyZH1DhAGy7rjwLShHFc=;
        b=YDJfZs/OUq6U2NfmIrk+3sp+MrvHUSxiG/pb6J88ZqPlGtFRpAK4Bv+5Kw+vxUBb3a
         IPhr617pq6T2/oZ7N1bghlrZxycXSrDBN3CN0lXy7U63qqRoJdioIfaog4fdfOUz3aLs
         aby0vlnJcJHA708NQTug9tvWBKb4xgaQRQZaJIB1nDXpDmRTLVq4AM0LL/UFq+KOOz5o
         k8R3tIu7yMXqj98kTAAtp0zCja4Vuz2rBzy9wwHVkkJCU4/ssmTypFZuWXm/QtByQTG4
         Kq3L73GZjfaMfiUCXFYp5WZD3JpI+Sze2Nkoixh/C9i5kMB97YMhzJQlBqgwLUN5orfj
         sp+w==
X-Forwarded-Encrypted: i=1; AJvYcCV/akcSJg49PJVB8vtTVwOX4yMKuwjBPCXXS9J2GJ7nYfrubfROPhji/xVmA/kd5m0NiNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy86YIQb8ibpO2J29tUQ041KVybY8sJ7rZXnoH3j3LdjPqY5AgQ
	N7BrUQgIRkBAfz8FXLlVEoVX7atxvx8kEk/e7Is/A6n3cK9gDQ4xiASBVq5GIPgfMBD7ZItcgF2
	N5/JEgw==
X-Google-Smtp-Source: AGHT+IE/k2GTScTkHiRT87eVAiNUFvBiCNCEmQJq3hp6ICEgpHYc+cygbpRrpbBVoF4AVNOLAIP7eu96Rjo=
X-Received: from plbcp6.prod.google.com ([2002:a17:902:e786:b0:24c:8f0c:bd97])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f791:b0:248:811e:f86c
 with SMTP id d9443c01a7336-25172291b93mr160820325ad.34.1757450799282; Tue, 09
 Sep 2025 13:46:39 -0700 (PDT)
Date: Tue,  9 Sep 2025 20:45:32 +0000
In-Reply-To: <20250909204632.3994767-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909204632.3994767-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909204632.3994767-3-kuniyu@google.com>
Subject: [PATCH v7 bpf-next/net 2/6] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
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

Some protocols (e.g., TCP, UDP) implement memory accounting for socket
buffers and charge memory to per-protocol global counters pointed to by
sk->sk_proto->memory_allocated.

If a socket has sk->sk_memcg, this memory is also charged to memcg as
"sock" in memory.stat.

We do not need to pay costs for two orthogonal memory accounting
mechanisms.  A microbenchmark result is in the subsequent bpf patch.

Let's decouple sockets under memcg from the global per-protocol memory
accounting if mem_cgroup_sk_exclusive() returns true.

Note that this does NOT disable memcg, but rather the per-protocol one.

mem_cgroup_sk_exclusive() starts to return true in the following patches,
and then, the per-protocol memory accounting will be skipped.

In __inet_accept(), we need to reclaim counts that are already charged
for child sockets because we do not allocate sk->sk_memcg until accept().

trace_sock_exceed_buf_limit() will always show 0 as accounted for the
memcg-exclusive sockets, but this can be obtained in memory.stat.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
---
v7: Reorder before sysctl & bpf patches
v6: Update commit message
---
 include/net/proto_memory.h      | 15 ++++++--
 include/net/sock.h              | 10 ++++++
 include/net/tcp.h               | 10 ++++--
 net/core/sock.c                 | 64 ++++++++++++++++++++++-----------
 net/ipv4/af_inet.c              | 12 ++++++-
 net/ipv4/inet_connection_sock.c |  1 +
 net/ipv4/tcp.c                  |  3 +-
 net/ipv4/tcp_output.c           | 10 ++++--
 net/mptcp/protocol.c            |  3 +-
 net/tls/tls_device.c            |  4 ++-
 10 files changed, 100 insertions(+), 32 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 72d4ec413ab5..4383cb4cb2d2 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -31,13 +31,22 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	if (!sk->sk_prot->memory_pressure)
 		return false;
 
-	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_sk_under_memory_pressure(sk))
-		return true;
+	if (mem_cgroup_sk_enabled(sk)) {
+		if (mem_cgroup_sk_under_memory_pressure(sk))
+			return true;
+
+		if (mem_cgroup_sk_exclusive(sk))
+			return false;
+	}
 
 	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
+static inline bool sk_should_enter_memory_pressure(struct sock *sk)
+{
+	return !mem_cgroup_sk_enabled(sk) || !mem_cgroup_sk_exclusive(sk);
+}
+
 static inline long
 proto_memory_allocated(const struct proto *prot)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index 63a6a48afb48..66501ab670eb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2607,6 +2607,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
 
+static inline bool mem_cgroup_sk_exclusive(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
@@ -2634,6 +2639,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return false;
 }
 
+static inline bool mem_cgroup_sk_exclusive(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	return false;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2936b8175950..225f6bac06c3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -275,9 +275,13 @@ extern unsigned long tcp_memory_pressure;
 /* optimized version of sk_under_memory_pressure() for TCP sockets */
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
-	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_sk_under_memory_pressure(sk))
-		return true;
+	if (mem_cgroup_sk_enabled(sk)) {
+		if (mem_cgroup_sk_under_memory_pressure(sk))
+			return true;
+
+		if (mem_cgroup_sk_exclusive(sk))
+			return false;
+	}
 
 	return READ_ONCE(tcp_memory_pressure);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 8002ac6293dc..814966309b0e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1046,17 +1046,21 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	if (!charged)
 		return -ENOMEM;
 
-	/* pre-charge to forward_alloc */
-	sk_memory_allocated_add(sk, pages);
-	allocated = sk_memory_allocated(sk);
-	/* If the system goes into memory pressure with this
-	 * precharge, give up and return error.
-	 */
-	if (allocated > sk_prot_mem_limits(sk, 1)) {
-		sk_memory_allocated_sub(sk, pages);
-		mem_cgroup_sk_uncharge(sk, pages);
-		return -ENOMEM;
+	if (!mem_cgroup_sk_exclusive(sk)) {
+		/* pre-charge to forward_alloc */
+		sk_memory_allocated_add(sk, pages);
+		allocated = sk_memory_allocated(sk);
+
+		/* If the system goes into memory pressure with this
+		 * precharge, give up and return error.
+		 */
+		if (allocated > sk_prot_mem_limits(sk, 1)) {
+			sk_memory_allocated_sub(sk, pages);
+			mem_cgroup_sk_uncharge(sk, pages);
+			return -ENOMEM;
+		}
 	}
+
 	sk_forward_alloc_add(sk, pages << PAGE_SHIFT);
 
 	WRITE_ONCE(sk->sk_reserved_mem,
@@ -3153,8 +3157,11 @@ bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
 		return true;
 
-	sk_enter_memory_pressure(sk);
+	if (sk_should_enter_memory_pressure(sk))
+		sk_enter_memory_pressure(sk);
+
 	sk_stream_moderate_sndbuf(sk);
+
 	return false;
 }
 EXPORT_SYMBOL(sk_page_frag_refill);
@@ -3267,18 +3274,30 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	bool memcg_enabled = false, charged = false;
 	struct proto *prot = sk->sk_prot;
-	long allocated;
-
-	sk_memory_allocated_add(sk, amt);
-	allocated = sk_memory_allocated(sk);
+	long allocated = 0;
 
 	if (mem_cgroup_sk_enabled(sk)) {
+		bool exclusive = mem_cgroup_sk_exclusive(sk);
+
 		memcg_enabled = true;
 		charged = mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge());
-		if (!charged)
+
+		if (exclusive && charged)
+			return 1;
+
+		if (!charged) {
+			if (!exclusive) {
+				sk_memory_allocated_add(sk, amt);
+				allocated = sk_memory_allocated(sk);
+			}
+
 			goto suppress_allocation;
+		}
 	}
 
+	sk_memory_allocated_add(sk, amt);
+	allocated = sk_memory_allocated(sk);
+
 	/* Under limit. */
 	if (allocated <= sk_prot_mem_limits(sk, 0)) {
 		sk_leave_memory_pressure(sk);
@@ -3357,7 +3376,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
-	sk_memory_allocated_sub(sk, amt);
+	if (allocated)
+		sk_memory_allocated_sub(sk, amt);
 
 	if (charged)
 		mem_cgroup_sk_uncharge(sk, amt);
@@ -3396,11 +3416,15 @@ EXPORT_SYMBOL(__sk_mem_schedule);
  */
 void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 {
-	sk_memory_allocated_sub(sk, amount);
-
-	if (mem_cgroup_sk_enabled(sk))
+	if (mem_cgroup_sk_enabled(sk)) {
 		mem_cgroup_sk_uncharge(sk, amount);
 
+		if (mem_cgroup_sk_exclusive(sk))
+			return;
+	}
+
+	sk_memory_allocated_sub(sk, amount);
+
 	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index d42757f74c6e..52d060bc9009 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -95,6 +95,7 @@
 #include <net/checksum.h>
 #include <net/ip.h>
 #include <net/protocol.h>
+#include <net/proto_memory.h>
 #include <net/arp.h>
 #include <net/route.h>
 #include <net/ip_fib.h>
@@ -769,8 +770,17 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 			 */
 			amt = sk_mem_pages(newsk->sk_forward_alloc +
 					   atomic_read(&newsk->sk_rmem_alloc));
-			if (amt)
+			if (amt) {
+				/* This amt is already charged globally to
+				 * sk_prot->memory_allocated due to lack of
+				 * sk_memcg until accept(), thus we need to
+				 * reclaim it here if newsk is isolated.
+				 */
+				if (mem_cgroup_sk_exclusive(newsk))
+					sk_memory_allocated_sub(newsk, amt);
+
 				mem_cgroup_sk_charge(newsk, amt, gfp);
+			}
 		}
 
 		kmem_cache_charge(newsk, gfp);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index ed10b959a906..f8dd53d40dcf 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
+#include <net/proto_memory.h>
 
 #if IS_ENABLED(CONFIG_IPV6)
 /* match_sk*_wildcard == true:  IPV6_ADDR_ANY equals to any IPv6 addresses
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71a956fbfc55..dcbd49e2f8af 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -908,7 +908,8 @@ struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 		}
 		__kfree_skb(skb);
 	} else {
-		sk->sk_prot->enter_memory_pressure(sk);
+		if (sk_should_enter_memory_pressure(sk))
+			tcp_enter_memory_pressure(sk);
 		sk_stream_moderate_sndbuf(sk);
 	}
 	return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index dfbac0876d96..4b6a7250a9c2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3574,12 +3574,18 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	delta = size - sk->sk_forward_alloc;
 	if (delta <= 0)
 		return;
+
 	amt = sk_mem_pages(delta);
 	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
-	sk_memory_allocated_add(sk, amt);
 
-	if (mem_cgroup_sk_enabled(sk))
+	if (mem_cgroup_sk_enabled(sk)) {
 		mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge() | __GFP_NOFAIL);
+
+		if (mem_cgroup_sk_exclusive(sk))
+			return;
+	}
+
+	sk_memory_allocated_add(sk, amt);
 }
 
 /* Send a FIN. The caller locks the socket for us.
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a287b75c1b3..f7487e22a3f8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -16,6 +16,7 @@
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
+#include <net/proto_memory.h>
 #include <net/tcp_states.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/transp_v6.h>
@@ -1016,7 +1017,7 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		if (first)
+		if (first && sk_should_enter_memory_pressure(ssk))
 			tcp_enter_memory_pressure(ssk);
 		sk_stream_moderate_sndbuf(ssk);
 
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..6696ef837116 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -35,6 +35,7 @@
 #include <linux/netdevice.h>
 #include <net/dst.h>
 #include <net/inet_connection_sock.h>
+#include <net/proto_memory.h>
 #include <net/tcp.h>
 #include <net/tls.h>
 #include <linux/skbuff_ref.h>
@@ -371,7 +372,8 @@ static int tls_do_allocation(struct sock *sk,
 	if (!offload_ctx->open_record) {
 		if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
 						   sk->sk_allocation))) {
-			READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
+			if (sk_should_enter_memory_pressure(sk))
+				READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
 			sk_stream_moderate_sndbuf(sk);
 			return -ENOMEM;
 		}
-- 
2.51.0.384.g4c02a37b29-goog


