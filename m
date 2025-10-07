Return-Path: <bpf+bounces-70465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A008EBBFD68
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED9F18976DF
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2528F5;
	Tue,  7 Oct 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ec/R6HPk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C87260A
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795889; cv=none; b=eld7ZdOT+uWxZzHLKChJ5wM/oir9GhP9F/64DrhXI70XDTN1j4FnIpd9CgEeqIsK4SK0xBROYPqeV9U9peH/CM9tW+omG4nIadLJB6iRDZ54QemW+9FolWNpVo7lLCqSy+AunddDVHEhjr6xCa8zRIMC3vYbbxbhpwoHxKKW4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795889; c=relaxed/simple;
	bh=EpcumTPqfNHtxC9fxqegwsrgKSBxr5l+TEXm0sfw8d8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qtr+RbKsLhAhd0YFQpHIJzFv7ZCOIa1frPnPcuobnD/SdZQMvC0lUnDNB1GdsCDL5q7WFEkQdSJrGD6G3oie3kYzgFCzd/mKcOOUlL64thMswuxuxsqfGz9tyWk04DS5T8Ec4xHSfujN7PhWDhNytuU8jtgbSutB7mWz93l3Ltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ec/R6HPk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2698b5fbe5bso65546995ad.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795887; x=1760400687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKsDlqQUNGucXp83WfS+22+WClBxI3Ues+3qVbOfGzY=;
        b=ec/R6HPkXLchw338LPSKa3jmkuctAqeHp5HshdnXsYnQIbRELJyWMB5WgFVj3NPU60
         stvfTkSkIdhqskytv9dDJScPZf5YzzTcmW28ELhWRAuCS7Wu+tt4MCIfocWfc9yk5XPi
         mCpBnmQbPfhq7bO6R0LogBgVQXA9WDAE6gKkzHkgQUbixGrH5Yz9+kE6kz+8VrxEgUYf
         xFD+xo7ZPzmBzmPh84AgRnnRQOP6geFdXeV/6jlRcuE9bPIfspix9ErajnZJarbiLKDa
         hJ3gTLDczX8yaghd9xNKG0eS2neh+uOal2nX54Fl8fSlE7eafg7mQV9QqqFTFOHTuX8j
         mzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795887; x=1760400687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKsDlqQUNGucXp83WfS+22+WClBxI3Ues+3qVbOfGzY=;
        b=ODMwUwEeik/ZD6oG7uQoTlPAE19XOBX00j+0N9v/h4LLFt7/U3nZrAY2bHZR0KeP+7
         2dVjWvkEtXKj+jtMgaognCqkdXqtEQmIbMK/7AmLnnPqmdWkApmlDY5TSlBzzKGy4eM6
         32Wpk2FhdsCQSlmWbSWcq2FrJMQDLwDCLtCr7O9nOIMq0fNIxVjNPvBwhSap8g3Vnwy1
         l4lzpph30jfUrZBO5qasnAZRQwG17bleMDQlPPMtFSmZZuy3eDQpIqkP7kNv4wrYy+ud
         Eli9j8fpfcoUT+z7gy4eXI2rTqj9hkz0JRj+FW0RXSlmpzUFgSYEn8GZIq7YOcMJOdmi
         o+bA==
X-Forwarded-Encrypted: i=1; AJvYcCVCrvFoFJoF7zyZyO1ry/cV16lJWQE61JERALv2uS8+sCZGSkbp/GRZ/mevp2McxaXggpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKcov3gQjo0ohEiWuqFNSUPFgrgmvKxKygGudz11Vte1iPdoS
	Kwd/vW5nPEKAYnCcezZWEZtetgD17gCTXx23qcKcVl6hlisNl8u97U0yslW7hDa838b+dW8F45V
	CsK0SkQ==
X-Google-Smtp-Source: AGHT+IEyLqtAUCvMdzr313XFcu15NT/8XLo8eZD/FfTNrYXLg04f4hYNJtL1R1jJCkcKnOPTMWXox/AUHLw=
X-Received: from plpf11.prod.google.com ([2002:a17:903:3c4b:b0:269:740f:8ae8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68d:b0:248:79d4:93be
 with SMTP id d9443c01a7336-28e9a62fe10mr169426105ad.30.1759795887300; Mon, 06
 Oct 2025 17:11:27 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:07:27 +0000
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007001120.2661442-3-kuniyu@google.com>
Subject: [PATCH bpf-next/net 2/6] net: Allow opt-out from global protocol
 memory accounting.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some protocols (e.g., TCP, UDP) implement memory accounting for socket
buffers and charge memory to per-protocol global counters pointed to by
sk->sk_proto->memory_allocated.

Sometimes, system processes do not want that limitation.  For a similar
purpose, there is SO_RESERVE_MEM for sockets under memcg.

Also, by opting out of the per-protocol accounting, sockets under memcg
can avoid paying costs for two orthogonal memory accounting mechanisms.
A microbenchmark result is in the subsequent bpf patch.

Let's allow opt-out from the per-protocol memory accounting if
sk->sk_bypass_prot_mem is true.

sk->sk_bypass_prot_mem and sk->sk_prot are placed in the same cache
line, and sk_has_account() always fetches sk->sk_prot before accessing
sk->sk_bypass_prot_mem, so there is no extra cache miss for this patch.

The following patches will set sk->sk_bypass_prot_mem to true, and
then, the per-protocol memory accounting will be skipped.

Note that this does NOT disable memcg, but rather the per-protocol one.

Another option not to use the hole in struct sock_common is create
sk_prot variants like tcp_prot_bypass, but this would complicate
SOCKMAP logic, tcp_bpf_prots etc.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/proto_memory.h |  3 +++
 include/net/sock.h         |  3 +++
 include/net/tcp.h          |  3 +++
 net/core/sock.c            | 32 +++++++++++++++++++++++++-------
 net/ipv4/tcp.c             |  3 ++-
 net/ipv4/tcp_output.c      |  7 ++++++-
 net/mptcp/protocol.c       |  7 ++++---
 net/tls/tls_device.c       |  3 ++-
 8 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 8e91a8fa31b5..ad6d703ce6fe 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -35,6 +35,9 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	    mem_cgroup_sk_under_memory_pressure(sk))
 		return true;
 
+	if (sk->sk_bypass_prot_mem)
+		return false;
+
 	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c..5cf8de6b6bf2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -118,6 +118,7 @@ typedef __u64 __bitwise __addrpair;
  *	@skc_reuseport: %SO_REUSEPORT setting
  *	@skc_ipv6only: socket is IPV6 only
  *	@skc_net_refcnt: socket is using net ref counting
+ *	@skc_bypass_prot_mem:
  *	@skc_bound_dev_if: bound device index if != 0
  *	@skc_bind_node: bind hash linkage for various protocol lookup tables
  *	@skc_portaddr_node: second hash linkage for UDP/UDP-Lite protocol
@@ -174,6 +175,7 @@ struct sock_common {
 	unsigned char		skc_reuseport:1;
 	unsigned char		skc_ipv6only:1;
 	unsigned char		skc_net_refcnt:1;
+	unsigned char		skc_bypass_prot_mem:1;
 	int			skc_bound_dev_if;
 	union {
 		struct hlist_node	skc_bind_node;
@@ -380,6 +382,7 @@ struct sock {
 #define sk_reuseport		__sk_common.skc_reuseport
 #define sk_ipv6only		__sk_common.skc_ipv6only
 #define sk_net_refcnt		__sk_common.skc_net_refcnt
+#define sk_bypass_prot_mem		__sk_common.skc_bypass_prot_mem
 #define sk_bound_dev_if		__sk_common.skc_bound_dev_if
 #define sk_bind_node		__sk_common.skc_bind_node
 #define sk_prot			__sk_common.skc_prot
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5ca230ed526a..d52ed4fe2335 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -303,6 +303,9 @@ static inline bool tcp_under_memory_pressure(const struct sock *sk)
 	    mem_cgroup_sk_under_memory_pressure(sk))
 		return true;
 
+	if (sk->sk_bypass_prot_mem)
+		return false;
+
 	return READ_ONCE(tcp_memory_pressure);
 }
 /*
diff --git a/net/core/sock.c b/net/core/sock.c
index dc03d4b5909a..7de189ec2556 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1046,9 +1046,13 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	if (!charged)
 		return -ENOMEM;
 
+	if (sk->sk_bypass_prot_mem)
+		goto success;
+
 	/* pre-charge to forward_alloc */
 	sk_memory_allocated_add(sk, pages);
 	allocated = sk_memory_allocated(sk);
+
 	/* If the system goes into memory pressure with this
 	 * precharge, give up and return error.
 	 */
@@ -1057,6 +1061,8 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 		mem_cgroup_sk_uncharge(sk, pages);
 		return -ENOMEM;
 	}
+
+success:
 	sk_forward_alloc_add(sk, pages << PAGE_SHIFT);
 
 	WRITE_ONCE(sk->sk_reserved_mem,
@@ -3136,8 +3142,11 @@ bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
 		return true;
 
-	sk_enter_memory_pressure(sk);
+	if (!sk->sk_bypass_prot_mem)
+		sk_enter_memory_pressure(sk);
+
 	sk_stream_moderate_sndbuf(sk);
+
 	return false;
 }
 EXPORT_SYMBOL(sk_page_frag_refill);
@@ -3254,10 +3263,12 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	bool memcg_enabled = false, charged = false;
 	struct proto *prot = sk->sk_prot;
-	long allocated;
+	long allocated = 0;
 
-	sk_memory_allocated_add(sk, amt);
-	allocated = sk_memory_allocated(sk);
+	if (!sk->sk_bypass_prot_mem) {
+		sk_memory_allocated_add(sk, amt);
+		allocated = sk_memory_allocated(sk);
+	}
 
 	if (mem_cgroup_sk_enabled(sk)) {
 		memcg_enabled = true;
@@ -3266,6 +3277,9 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 			goto suppress_allocation;
 	}
 
+	if (!allocated)
+		return 1;
+
 	/* Under limit. */
 	if (allocated <= sk_prot_mem_limits(sk, 0)) {
 		sk_leave_memory_pressure(sk);
@@ -3344,7 +3358,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
-	sk_memory_allocated_sub(sk, amt);
+	if (allocated)
+		sk_memory_allocated_sub(sk, amt);
 
 	if (charged)
 		mem_cgroup_sk_uncharge(sk, amt);
@@ -3383,11 +3398,14 @@ EXPORT_SYMBOL(__sk_mem_schedule);
  */
 void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 {
-	sk_memory_allocated_sub(sk, amount);
-
 	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_sk_uncharge(sk, amount);
 
+	if (sk->sk_bypass_prot_mem)
+		return;
+
+	sk_memory_allocated_sub(sk, amount);
+
 	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7949d16506a4..feb0aea23a59 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -928,7 +928,8 @@ struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 		}
 		__kfree_skb(skb);
 	} else {
-		sk->sk_prot->enter_memory_pressure(sk);
+		if (!sk->sk_bypass_prot_mem)
+			tcp_enter_memory_pressure(sk);
 		sk_stream_moderate_sndbuf(sk);
 	}
 	return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb3576ac0ad7..0fb2a3bb62cd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3732,12 +3732,17 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	delta = size - sk->sk_forward_alloc;
 	if (delta <= 0)
 		return;
+
 	amt = sk_mem_pages(delta);
 	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
-	sk_memory_allocated_add(sk, amt);
 
 	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge() | __GFP_NOFAIL);
+
+	if (sk->sk_bypass_prot_mem)
+		return;
+
+	sk_memory_allocated_add(sk, amt);
 }
 
 /* Send a FIN. The caller locks the socket for us.
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0292162a14ee..94a5f6dcc577 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1065,11 +1065,12 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		if (first)
+		if (first && !ssk->sk_bypass_prot_mem) {
 			tcp_enter_memory_pressure(ssk);
-		sk_stream_moderate_sndbuf(ssk);
+			first = false;
+		}
 
-		first = false;
+		sk_stream_moderate_sndbuf(ssk);
 	}
 	__mptcp_sync_sndbuf(sk);
 }
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a64ae15b1a60..caa2b5d24622 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -373,7 +373,8 @@ static int tls_do_allocation(struct sock *sk,
 	if (!offload_ctx->open_record) {
 		if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
 						   sk->sk_allocation))) {
-			READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
+			if (!sk->sk_bypass_prot_mem)
+				READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
 			sk_stream_moderate_sndbuf(sk);
 			return -ENOMEM;
 		}
-- 
2.51.0.710.ga91ca5db03-goog


