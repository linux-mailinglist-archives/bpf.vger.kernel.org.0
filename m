Return-Path: <bpf+bounces-67810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EEEB49D06
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E397D170064
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D13054E4;
	Mon,  8 Sep 2025 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1ovmplw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D502F7449
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371084; cv=none; b=Qra5Rb/IvSYYfLWH43UBpWsf0Mvk8BOdwrRPGx1//B8QbOwflV0pGeW2ORHQ/fDke9oixXmyjk7YZAh1yTLC08DXttq7aaPgU/8AumGlIWxaB9gmxkEHv42X5PkzwVyrjBOgMNUU9PZjs5a6vELHHPmHt9SOQ1tgl12/Dcvm6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371084; c=relaxed/simple;
	bh=MvbBR5pzBYpYf2+kymmP2KpJY0bjrbJky7R+wQxUwVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUMhsuwy2aGwZ3wjq2QgeFX32tRKSkXcHABXN14atQr9xx5Tg5WCrek7yo9Z8kadh0A4Q6eCg5Uh9JhSBxFsRrZaHERPs7121CsxD1/j/l2n6yOF//PAG9u1yY4XcU0efIKx2/Qmy6IW/9kPSkDanwJC1GVoQFnr6ErOcPn3fC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1ovmplw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-258b7567e8cso4320585ad.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371081; x=1757975881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqaqUP3nMZFvLQVOkcG9ZCuRnTN5jT7aHz8tfDT/rSc=;
        b=u1ovmplwkTx1SD+7tTiFFh+Aw6UCXGKP5JLK2S7pg7v+yXt3zZvbqTC8eSIGUbFlJa
         ML7n9+IvO+fp8YkOmmL7sl7X3c0U/RIpMLzlwocAJScnAxmDit8Mftr+fkWr5fk4FJ+Q
         C8ALdcKvJvcAPBQma72gQoR3CTBclpEZ6S91B3NoN9/tCXlpUy7iif/AdsKnvObY8jIJ
         3KmWfmBoxzvVRAzNjfo1Ja1ddSaZFloEdnqZDArp1ML+57AAtmf13BLBN//ahXZwco+0
         K86cItJlyUteBuNDGG62tfldroRV2F49e4QDHk8Y57+INITC2N1xLqHnyYrZx7bW3PqC
         +2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371081; x=1757975881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqaqUP3nMZFvLQVOkcG9ZCuRnTN5jT7aHz8tfDT/rSc=;
        b=OE4RmoVxN+4bk/LJCVCucIyr3ryFn8efLRiAUCMs/q8xy7LROfTj+Crf8dNSPrqONT
         BvHwtROIe3XUMmY6kzhNUohZvINOwEjPqfNvd6DNU8BExzg5Fyf0AQHKq/kOgNNwaCXf
         3qnCEii2prBH/3dPwzYNfyUY/ARfG0VaoD+BexZ9pTk/HjZsZR2KrSpBhf7CZuTMku9o
         7Vd3Og0d6EiDPqd+n8H7r8WQENsAGlanElEVe6cXoPAWVv8ZV7M2towP2fAuel0mZJNz
         cDSeDGSyQokJyCta3mPmJ/smOeRp5Yqw9aGgejC90bE6V8WK29LK1yTf17taD5Hws5WE
         y/+w==
X-Forwarded-Encrypted: i=1; AJvYcCUGAdKqf9zUKxdXlozouhgNK78FAkShjMX7jpaLBpYBqlEmmtCLpjGbToJPVGuejaxqF2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YySG7K+l9bABpiqfbjM0HKOJwhjAcEK/qfnNiRpSxb4uFoGUZ5x
	ETHV396YZ5xMy/ZBYSSpemdaz/4PRLPNWSJQUJbEFRgYGjr+xQBErV70zUENBqwkRBvdjsWfQzt
	hsRiOXg==
X-Google-Smtp-Source: AGHT+IHpVDzNVmMdyMPKVfdWDijuadwNont6W84jL0EA+QCqJoSp/70UinFq5d7Aayh+hWY9HRhOLejeiNI=
X-Received: from plbmq16.prod.google.com ([2002:a17:902:fd50:b0:248:93f4:fe04])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc45:b0:248:fc2d:3a25
 with SMTP id d9443c01a7336-25170c416d0mr118705645ad.38.1757371081523; Mon, 08
 Sep 2025 15:38:01 -0700 (PDT)
Date: Mon,  8 Sep 2025 22:34:38 +0000
In-Reply-To: <20250908223750.3375376-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908223750.3375376-5-kuniyu@google.com>
Subject: [PATCH v6 bpf-next/net 4/5] net-memcg: Allow decoupling memcg from
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

When running under a non-root cgroup, this memory is also charged to the
memcg as "sock" in memory.stat.

We do not need to pay costs for two orthogonal memory accounting
mechanisms.

Let's decouple sockets in memcg from the global per-protocol memory
accounting if sockets have SK_BPF_MEMCG_SOCK_ISOLATED in sk->sk_memcg.

Note that this does NOT disable memcg, but rather the per-protocol one.

If mem_cgroup_sk_isolated(sk) returns true, the per-protocol memory
accounting is skipped.

  # cat /sys/fs/cgroup/test/memory.stat | grep sock
  sock 2757468160 <--------------------------------- charged to memcg
  # cat /proc/net/sockstat | grep TCP
  TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 0 <-- not charged to tcp_mem

In __inet_accept(), we need to reclaim counts that are already charged
for child sockets because we do not allocate sk->sk_memcg until accept().

trace_sock_exceed_buf_limit() will always show 0 as accounted for the
isolated sockets, but this can be obtained via memory.stat.

Most changes are inline and hard to trace, but a microbenchmark on
__sk_mem_raise_allocated() during neper/tcp_stream showed that more
samples completed faster with bpf.  This will be more visible under
tcp_mem pressure.

  # bpftrace -e 'kprobe:__sk_mem_raise_allocated { @start[tid] = nsecs; }
    kretprobe:__sk_mem_raise_allocated /@start[tid]/
    { @end[tid] = nsecs - @start[tid]; @times = hist(@end[tid]); delete(@start[tid]); }'
  # tcp_stream -6 -F 1000 -N -T 256

Without bpf prog:

  [128, 256)          3846 |                                                    |
  [256, 512)       1505326 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [512, 1K)        1371006 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     |
  [1K, 2K)          198207 |@@@@@@                                              |
  [2K, 4K)           31199 |@                                                   |

With bpf prog in the next patch:
  (must be attached before tcp_stream)
  # bpftool prog load sk_memcg.bpf.o /sys/fs/bpf/sk_memcg type cgroup/sock_create
  # bpftool cgroup attach /sys/fs/cgroup/test cgroup_inet_sock_create pinned /sys/fs/bpf/sk_memcg

  [128, 256)          6413 |                                                    |
  [256, 512)       1868425 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [512, 1K)        1101697 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                      |
  [1K, 2K)          117031 |@@@@                                                |
  [2K, 4K)           11773 |                                                    |

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
---
v6: Update commit message
---
 include/net/proto_memory.h      | 15 ++++++--
 include/net/tcp.h               | 10 ++++--
 net/core/sock.c                 | 64 ++++++++++++++++++++++-----------
 net/ipv4/af_inet.c              | 12 ++++++-
 net/ipv4/inet_connection_sock.c |  1 +
 net/ipv4/tcp.c                  |  3 +-
 net/ipv4/tcp_output.c           | 10 ++++--
 net/mptcp/protocol.c            |  3 +-
 net/tls/tls_device.c            |  4 ++-
 9 files changed, 90 insertions(+), 32 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 72d4ec413ab5..8f20210136ab 100644
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
+		if (mem_cgroup_sk_isolated(sk))
+			return false;
+	}
 
 	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
+static inline bool sk_should_enter_memory_pressure(struct sock *sk)
+{
+	return !mem_cgroup_sk_enabled(sk) || !mem_cgroup_sk_isolated(sk);
+}
+
 static inline long
 proto_memory_allocated(const struct proto *prot)
 {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2936b8175950..0191a4585bba 100644
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
+		if (mem_cgroup_sk_isolated(sk))
+			return false;
+	}
 
 	return READ_ONCE(tcp_memory_pressure);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index ae30d7d54498..bda1655fa9bf 100644
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
+	if (!mem_cgroup_sk_isolated(sk)) {
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
@@ -3154,8 +3158,11 @@ bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
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
@@ -3268,18 +3275,30 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	bool memcg_enabled = false, charged = false;
 	struct proto *prot = sk->sk_prot;
-	long allocated;
-
-	sk_memory_allocated_add(sk, amt);
-	allocated = sk_memory_allocated(sk);
+	long allocated = 0;
 
 	if (mem_cgroup_sk_enabled(sk)) {
+		bool isolated = mem_cgroup_sk_isolated(sk);
+
 		memcg_enabled = true;
 		charged = mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge());
-		if (!charged)
+
+		if (isolated && charged)
+			return 1;
+
+		if (!charged) {
+			if (!isolated) {
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
@@ -3358,7 +3377,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
-	sk_memory_allocated_sub(sk, amt);
+	if (allocated)
+		sk_memory_allocated_sub(sk, amt);
 
 	if (charged)
 		mem_cgroup_sk_uncharge(sk, amt);
@@ -3397,11 +3417,15 @@ EXPORT_SYMBOL(__sk_mem_schedule);
  */
 void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 {
-	sk_memory_allocated_sub(sk, amount);
-
-	if (mem_cgroup_sk_enabled(sk))
+	if (mem_cgroup_sk_enabled(sk)) {
 		mem_cgroup_sk_uncharge(sk, amount);
 
+		if (mem_cgroup_sk_isolated(sk))
+			return;
+	}
+
+	sk_memory_allocated_sub(sk, amount);
+
 	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 9b62f1ae13ba..adbc8bcb760b 100644
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
@@ -773,8 +774,17 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
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
+				if (mem_cgroup_sk_isolated(newsk))
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
index dfbac0876d96..f7aa86661219 100644
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
+		if (mem_cgroup_sk_isolated(sk))
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


