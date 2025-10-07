Return-Path: <bpf+bounces-70468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F22BBFD7A
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33D9E4F2C56
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5201D5CD7;
	Tue,  7 Oct 2025 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdDpXVZr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC461A9F91
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795894; cv=none; b=e+d8nb4hAqnBubwh0w+Kh8/LJk8wDzwl4VcKqVip4X2Q1kJdFjl9sytDMmPZOdYx7qjkytSYi/T9F8zvWkGv5RVJpCbDor3PdCYmDA+QVliplMoimOEHZw7fuwy4MXKBarku0M/I1KedOSccDRfs73ItpAlHD333lyw8xapyZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795894; c=relaxed/simple;
	bh=AhdGypzzPdwRBmO9MGKG2+tt14BLJO93FlbV4GnCA1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZB1K9q+68IGnJ4pzwdUWsLDzmq/PQZVeIW2ZtDMMVUANzuF6kWCwSTRv2WftHtfJQHO6ZWLsOh45Fex1NObV1LQ8zsb0z3WmZb+3wbM3I3RlmF3Ih9k4eR6iIfM+FovhGoQcxE4gJeTFpF19p3BHkjZk5NBu+HnUeox4GhAgPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdDpXVZr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so552032a91.3
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795892; x=1760400692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqpDEmUrIZVmeTo0tmElhXQv+TjsQsN6uVhACALePHY=;
        b=JdDpXVZr4r4zIkoM125vdzJPgk9Fc35ONYk2cBUl4wMCr0tEmsTdbq2ImqTC8PKQjB
         EfY5XycNZ/YnvScsCEr/Nx6kAH3beOPX5Apmql2RfW5C0h93O8NJKWnZj/FKRbeCJWOE
         9U79MHPonLJC2uEiOPSygdrAysLqvojTAo/wt2ogCfUMYBsjkGWOLWmGMweHCC2OQnBy
         Vt0FXcKofRrzKpFQnady1ua0SyFQGiPIfbzJfhP0Muon7tmSFWFvVCKiAwdjg8D4x5MS
         S5lP0wcdeccv0L5W9y9km6dGQMyWRf/va9PHtd3MwT8DX4nZi9fSX0F2KquORG+lLP5D
         uFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795892; x=1760400692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqpDEmUrIZVmeTo0tmElhXQv+TjsQsN6uVhACALePHY=;
        b=Si9pRaYMMy4U4rC5k6ZhXKWQ7f71vyg8VRtkxrnsnBMwT6SujdhRMLtvUFM28RYl9+
         esN6oT9+fNRw55/46ryzBAnVy7isL67J5AbPxJ9cAdySdIBaEZAQkk40R6oQie3KWJ6I
         euTvwtDQ9k7Z+AbMFmfMWwX5IOVJ5f/H0VuAwP3jc447mROlOYdHVTPCIOPuCg1WhG6F
         Gvl8hunux3uc+LinoJCjeHsYEzLbdC1QZxNsHYwvh/5JZtXeicS18mM+Xss7xQnvsHEZ
         qEL4lDuuAIEXpdSRYAUU0quvKy8h2N+snyE391gZkEDhrIKdwlSWcZ919yjJDcKtjwMN
         lNtw==
X-Forwarded-Encrypted: i=1; AJvYcCUF0e/tJntxn9MRqT7L0DBAUm2vm4hIOm4lEBIqqCGUe+G7BpoJJRw0VR3Xd4N91NSVCcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0gH9DudSiJcpIt3VifKKB7HVX0sECKnclod4aFKzAO4ZEKYD
	UkBkwzwvQpR4CvclXm+g03NLB1Jqfj+PLrDsPz3agY7DKezHh0ey3xbyALrLShHwYigMiVUWlJJ
	mLQzv+g==
X-Google-Smtp-Source: AGHT+IHFz4tz5zxSY826R7ba5oTZypEah7BrZGxMQBBBiAgsgor58q59KtyVCSHpwI1sG/RLCnhuVA+gP1Y=
X-Received: from pjvh15.prod.google.com ([2002:a17:90a:db8f:b0:330:6eb8:6ae4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3806:b0:335:28ee:eeaf
 with SMTP id 98e67ed59e1d1-339c279e6bfmr18463503a91.29.1759795891734; Mon, 06
 Oct 2025 17:11:31 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:07:30 +0000
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007001120.2661442-6-kuniyu@google.com>
Subject: [PATCH bpf-next/net 5/6] bpf: Introduce SK_BPF_BYPASS_PROT_MEM.
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

If a socket has sk->sk_bypass_prot_mem flagged, the socket opts out
of the global protocol memory accounting.

This is easily controlled by net.core.bypass_prot_mem sysctl, but it
lacks flexibility.

Let's support flagging (and clearing) sk->sk_bypass_prot_mem via
bpf_setsockopt() at the BPF_CGROUP_INET_SOCK_CREATE hook.

  int val = 1;

  bpf_setsockopt(ctx, SOL_SOCKET, SK_BPF_BYPASS_PROT_MEM,
                 &val, sizeof(val));

As with net.core.bypass_prot_mem, this is inherited to child sockets,
and BPF always takes precedence over sysctl at socket(2) and accept(2).

SK_BPF_BYPASS_PROT_MEM is only supported at BPF_CGROUP_INET_SOCK_CREATE
and not supported on other hooks for some reasons:

  1. UDP charges memory under sk->sk_receive_queue.lock instead
     of lock_sock()

  2. Modifying the flag after skb is charged to sk requires such
     adjustment during bpf_setsockopt() and complicates the logic
     unnecessarily

We can support other hooks later if a real use case justifies that.

Most changes are inline and hard to trace, but a microbenchmark on
__sk_mem_raise_allocated() during neper/tcp_stream showed that more
samples completed faster with sk->sk_bypass_prot_mem == 1.  This will
be more visible under tcp_mem pressure (but it's not a fair comparison).

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
  # bpftool prog load sk_bypass_prot_mem.bpf.o /sys/fs/bpf/test type cgroup/sock_create
  # bpftool cgroup attach /sys/fs/cgroup/test cgroup_inet_sock_create pinned /sys/fs/bpf/test

  [128, 256)          6413 |                                                    |
  [256, 512)       1868425 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [512, 1K)        1101697 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                      |
  [1K, 2K)          117031 |@@@@                                                |
  [2K, 4K)           11773 |                                                    |

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/uapi/linux/bpf.h       |  2 ++
 net/core/filter.c              | 31 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6829936d33f5..6eb75ad900b1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7200,6 +7200,8 @@ enum {
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
+	SK_BPF_BYPASS_PROT_MEM	= 1010, /* Get or Set sk->sk_bypass_prot_mem */
+
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 83f40ac3392f..02a783cbd7af 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5731,9 +5731,37 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+static int sk_bpf_set_get_bypass_prot_mem(struct sock *sk,
+					  char *optval, int optlen,
+					  bool getopt)
+{
+	int val;
+
+	if (optlen != sizeof(int))
+		return -EINVAL;
+
+	if (!sk_has_account(sk))
+		return -EOPNOTSUPP;
+
+	if (getopt) {
+		*(int *)optval = sk->sk_bypass_prot_mem;
+		return 0;
+	}
+
+	val = *(int *)optval;
+	if (val < 0 || val > 1)
+		return -EINVAL;
+
+	sk->sk_bypass_prot_mem = val;
+	return 0;
+}
+
 BPF_CALL_5(bpf_sock_create_setsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (level == SOL_SOCKET && optname == SK_BPF_BYPASS_PROT_MEM)
+		return sk_bpf_set_get_bypass_prot_mem(sk, optval, optlen, false);
+
 	return __bpf_setsockopt(sk, level, optname, optval, optlen);
 }
 
@@ -5751,6 +5779,9 @@ static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
 BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (level == SOL_SOCKET && optname == SK_BPF_BYPASS_PROT_MEM)
+		return sk_bpf_set_get_bypass_prot_mem(sk, optval, optlen, true);
+
 	return __bpf_getsockopt(sk, level, optname, optval, optlen);
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6829936d33f5..9b17d937edf7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7200,6 +7200,7 @@ enum {
 	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
 	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
 	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
+	SK_BPF_BYPASS_PROT_MEM	= 1010, /* Get or Set sk->sk_bypass_prot_mem */
 };
 
 enum {
-- 
2.51.0.710.ga91ca5db03-goog


