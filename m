Return-Path: <bpf+bounces-67942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FD3B5076B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0740E3A2CFC
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A32362069;
	Tue,  9 Sep 2025 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQFo7LK7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2E78F54
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450806; cv=none; b=JK/wDhAtdmws6W7Q5w8g2G2xo+2h8FLXi7kETs2l6EEbqH2PUgAet/+ESY2WaahTCODfVX4cadx9SRlAVAaCC3oSABZLRXTql8V/spi3FMbaNuWBlttPSieToTdxaTdCsXC28vUY6pTR01HobZ0eAHIZ2PFly9H6hhjqNpvY8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450806; c=relaxed/simple;
	bh=7/s6ouyGU0JSfjn6KS9fHgWBJBrlBIyY6wwMrCQedKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oiHX+CdwhQG918ydJOzNQyFlhewGrf5ul0U9F2VytHv0aqWkUkaIrDVlqMFiDSrGjnVVyJlksyk+sbvfMnnnOAkQxXDqKI+mcC1RF731bK9f4wb2a/3Yy1jC5evw94LSniRYG1CW7ezT2YHGezuTBv0oBjrX1cHm7nLwQg+uVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQFo7LK7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77288e1ce43so6217939b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757450804; x=1758055604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3RUHR2FnHytqfPVXUxRf4ez8/UFPuKOQqDPzVjNBPgg=;
        b=gQFo7LK7gDdVzOJB5gGnAhGJ+SJl5sY3yXJUYYkWMR4+3KeR1S3lOD12W/TEAiVvA7
         p3XPnUqXaaheJsQtmn6qBEesN1NUgPCKqpmbNSfkmgsvGM4lCCxXMi74NKx3rX976qT1
         Pwhp4lEva7mcmowsZtoo6Xe7ZsULtamwBS1PsDCtyEdlXmf/hweQ7xzz2obet/k851iS
         b7CPif9NgvrHoTMWYFprf0AYJFvezhXj5aFfQORxXHu+L3KvYV5JgwUIfBqMSVMmfOpZ
         5ybCCNxR5i2XIvIh3E3RxMnqPNbiJacaHQx61jcN2EI8QBpG6LHnKQ+fj7RsUHkFrTX9
         LnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450804; x=1758055604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RUHR2FnHytqfPVXUxRf4ez8/UFPuKOQqDPzVjNBPgg=;
        b=OvuBOXIGj/FF8OcNpYrgtcnyCWCYny1z+AxvrNoKBNqhv/row+Q7HxyCkJ95dirWiU
         OFdaN1qoThsVyPgdSzQq8+n1Ekh85Int9UKQSsETZ6VhMvCRcfYF4tT+5r+Kub0miuiU
         i8nX4MUg6C6x72nh6OAD9SYaslO9C1DGLAPQmJbrqRmD7R/jJHDi1ym+WRglYZ9Mu5tO
         PJ67sFGgYR1uyejt6+pp7PirzsWnqxkcL9Bd8QwnUUD18TnTL/RW4Sno4l/yQDpaNRxU
         Imbj/HiJmvZhrk0VxyZlkL7orU0QJo8B0kNXcry4xW117748oA2Pv9yuFYJ+0CrjKAUU
         xXGA==
X-Forwarded-Encrypted: i=1; AJvYcCWLTEDFVoapsywHaeRvXVR4Lb9V7UTcFjxnvXeymnvbxp79SGThBXt2ubExg2prChVUdXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTy3f0x5KT9U2iLIaQPloqhyTXag1GlaU0F1Vv0dJwyfE4G4UQ
	htuKX+nuJcEhtMSc8s4eCljYFh3o/qSxLIiS9Bu1kBzOnVKG2C5jVB8uPDF2zU8oNqvLflgtb+s
	AF8J88A==
X-Google-Smtp-Source: AGHT+IFnBy2c09I3ExoXvLRTzV6n4q4VET3O7ebD01nmp9l3YdY8+D5jryYx1X33ZE2zKKoNGYXMBo6cr2E=
X-Received: from pfch21.prod.google.com ([2002:a05:6a00:1715:b0:76e:396a:e2dd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d83:b0:771:ec42:1c1e
 with SMTP id d2e1a72fcca58-7742ddeddb5mr14184310b3a.16.1757450804184; Tue, 09
 Sep 2025 13:46:44 -0700 (PDT)
Date: Tue,  9 Sep 2025 20:45:35 +0000
In-Reply-To: <20250909204632.3994767-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909204632.3994767-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909204632.3994767-6-kuniyu@google.com>
Subject: [PATCH v7 bpf-next/net 5/6] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_EXCLUSIVE.
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

If a socket has sk->sk_memcg with SK_MEMCG_EXCLUSIVE, it is decoupled
from the global protocol memory accounting.

This is controlled by net.core.memcg_exclusive sysctl, but it lacks
flexibility.

Let's support flagging (and clearing) SK_MEMCG_EXCLUSIVE via
bpf_setsockopt() at the BPF_CGROUP_INET_SOCK_CREATE hook.

  u32 flags = SK_BPF_MEMCG_EXCLUSIVE;

  bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_MEMCG_FLAGS,
                 &flags, sizeof(flags));

As with net.core.memcg_exclusive, this is inherited to child sockets,
and BPF always takes precedence over sysctl at socket(2) and accept(2).

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

Most changes are inline and hard to trace, but a microbenchmark on
__sk_mem_raise_allocated() during neper/tcp_stream showed that more
samples completed faster with SK_MEMCG_EXCLUSIVE.  This will be more
visible under tcp_mem pressure.

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
---
v7:
  * Update commit message.

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
 include/uapi/linux/bpf.h       |  6 ++++++
 mm/memcontrol.c                |  3 +++
 net/core/filter.c              | 34 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  6 ++++++
 4 files changed, 49 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..35e3ce40ac90 100644
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
+	SK_BPF_MEMCG_EXCLUSIVE	= (1UL << 0),
+	SK_BPF_MEMCG_FLAG_MAX	= (1UL << 1),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f7b97e02e429..0d017c8b8a00 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4997,6 +4997,9 @@ EXPORT_SYMBOL(memcg_sockets_enabled_key);
 
 static void mem_cgroup_sk_set(struct sock *sk, struct mem_cgroup *memcg)
 {
+	BUILD_BUG_ON((unsigned short)SK_MEMCG_EXCLUSIVE != SK_BPF_MEMCG_EXCLUSIVE);
+	BUILD_BUG_ON((unsigned short)SK_MEMCG_FLAG_MAX != SK_BPF_MEMCG_FLAG_MAX);
+
 	sk->sk_memcg = memcg;
 
 	if (READ_ONCE(sock_net(sk)->core.sysctl_memcg_exclusive))
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
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..35e3ce40ac90 100644
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
+	SK_BPF_MEMCG_EXCLUSIVE	= (1UL << 0),
+	SK_BPF_MEMCG_FLAG_MAX	= (1UL << 1),
+};
+
 struct bpf_perf_event_value {
 	__u64 counter;
 	__u64 enabled;
-- 
2.51.0.384.g4c02a37b29-goog


