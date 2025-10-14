Return-Path: <bpf+bounces-70953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6257ABDBD7D
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249DC19A351D
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A6A2FA0F2;
	Tue, 14 Oct 2025 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0NO+1eX5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE22F83CC
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486177; cv=none; b=LZS13CbL/3RSLu2GKnwDQwMXnLlywicekmQJJGVc538fmNkI3Lw2ALFM0Z3yniJjXYMY1SdOpRPu2Y8zH3fWIBvysNIZqeLZBqhWC/419BjDrNggx2Eev0831rzgX+NounbGSKr9ehiwFULGpA6SxwV/DzKqj/VR/lEwfXUdyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486177; c=relaxed/simple;
	bh=0S3wfoKNn7fk8v5Za7A5EvdX8PUm5sLrlLZPgxrNM1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ixVzZgGE7oHNs5D7rNa5huPt/Xc33gGbit7HrHQcELWQCAQbIDgfbrTjmgbHYUKd7fLi5oUECaHrBdUv3INI7jSH2jUsru6qnMHhiLxQB3gMWQBTcdM5zWOMZDHYjB0Kc0ONC+p5CnnuXBgJ8GynK65hDQGJ5r12bBTTiBgyqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0NO+1eX5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78038ed99d9so13690725b3a.2
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760486175; x=1761090975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Edj0bcQ7ZzhnkuMguuVmM8jUUa3u7sVQ8bv/UVIhsFw=;
        b=0NO+1eX5nIv+ScDmTQEVpIuvzhPsjOdCGA8SlAjM9BNcf5mj2HJXcveULbUw7jw6CX
         inNZssM/Sg48tcJcvNnPTsN4RM7RvTeAF+nu1tzBG9uUjcprGRhQNvuaD66KNcqPcIYW
         w03qvbFbtmAS4EeVouASvJYozctQTjtkPKSrqES7K6cylfKpVCUTAK4V6Ilj4eLAPSv7
         CLvLxJYC7OWjs//JpG6hLRkEfgAb5bzFzwEkRaJMHJ83ifelg/QeQHFzxplAnMtObck4
         rAvUywgIKua9dzHNhMqX9FrZniKLSzCSkrEcu4+3axZXiho5WAoZc5mKr4VGge/yv2mq
         QgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486175; x=1761090975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Edj0bcQ7ZzhnkuMguuVmM8jUUa3u7sVQ8bv/UVIhsFw=;
        b=YUva4ALDoFwWZNhYbwVzA35uCS8Q0cIa9kdJKm/GuZkdtiI7U4uYgwpSw+GxXbg+OF
         9wVjgcj7cXHY28XSclnq/imNYCHIyA5ONIt5MDupTnF2J1b5tn2KMaMRHBxSMGxVVIOq
         d8tZqvXjZ/OAMKpJmDPNRzLtj1apf0Em9WQQyGD196aNjXP54vNRsuJ2tCwWVlPSrQ+/
         cf/XrOH733LpL+gleyDXmxGuPkxlG8E4nzvDtlZm67AF8reWQBb8lh/bgIFCPXymZ+GV
         wGt9+RtKYwafCUFqoQYmctDkpRaPAanQEFYnv+uNqJLn+x57oqf3fZVBH5LHsaMWV3Mn
         nSBA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2KHmK64rYK91BU8k0vinpMPRdOwqRcERoObSbABwmuUd3mx4Ar4Xga3doY+jx7BDAu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHAXPkqbJ2zHUAwWmhG0U5SJLOREJC+7d5dhIRQoIMICDu506
	wpFh7vA7VC9kfTCoQ6Aw2ngACJo0kIvaeEv1OocXyQL8oPAxygynMfhrQHTCsqmEB03Ub8kevGk
	Orzh43Q==
X-Google-Smtp-Source: AGHT+IHWYNMSvJxkQ0QVpqwAHLoCp+dG4J9m5Llra1vI6evRQKKy3q7KXjcmqtjMR4PzNaoiiDo9lIkG7QU=
X-Received: from pfbea2.prod.google.com ([2002:a05:6a00:4c02:b0:77c:6e29:42af])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:98c:b0:781:556:f41
 with SMTP id d2e1a72fcca58-79386e50a8cmr33147289b3a.19.1760486175244; Tue, 14
 Oct 2025 16:56:15 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:54:58 +0000
In-Reply-To: <20251014235604.3057003-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014235604.3057003-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014235604.3057003-6-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 5/6] bpf: Introduce SK_BPF_BYPASS_PROT_MEM.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/uapi/linux/bpf.h       |  2 ++
 net/core/filter.c              | 31 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6829936d33f58..6eb75ad900b13 100644
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
index ed3f0e5360595..ff3fb639bfec9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5733,9 +5733,37 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
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
 
@@ -5753,6 +5781,9 @@ static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
 BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
+	if (level == SOL_SOCKET && optname == SK_BPF_BYPASS_PROT_MEM)
+		return sk_bpf_set_get_bypass_prot_mem(sk, optval, optlen, true);
+
 	return __bpf_getsockopt(sk, level, optname, optval, optlen);
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6829936d33f58..9b17d937edf73 100644
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
2.51.0.788.g6d19910ace-goog


