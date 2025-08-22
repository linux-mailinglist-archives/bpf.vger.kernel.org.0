Return-Path: <bpf+bounces-66318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78680B324F3
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38611626D02
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7DF2E54D4;
	Fri, 22 Aug 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmXRnQzi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8682C158B
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901134; cv=none; b=HSl0PvRiy9aeopMDOjomfbTH5dxdTLOqEStbBRob45bLVD8v1q8FWgbbbagiv2s7DjutGz9M0qtIniSvyJ6DzxY38q1C73QkVo2ZT5Fe+UY6VO71MTwNR4ZCnZNiRbWVir3bzdwKbz5F4beeaY9ozeGekIdbuGRIe7I7YBJsYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901134; c=relaxed/simple;
	bh=Uy5BWlJYeqJ7BtJ/K1jsWTao9hB06q5ehbmU3TPa3ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j4eyWtdA1zk/DqJQf2BalUgw72hCRbZC7tAgUwTyAWfqy8E2nppR+6THZVXzisilAbXKfcjJaO3qXOdribrioPliwpNBX+wNaicc5ovwGQ54Oa5cq4DEbrwGJlU9/8YZkys0r1molM1nQ+OfXC07EQBMfg6HzOGk9lbJK7RvxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmXRnQzi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324f2f16924so2191090a91.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901133; x=1756505933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=povoySMDMH4jgrz3Br8X8ooOXJKrPnkecGKw2kqO4xs=;
        b=TmXRnQzi7uA79V9DWM1zJbem4iD3s2wF3uQRQuTnNuizv0cM4rVCs5QZr+Abu8uImA
         lCeAdYaKrcg5ZX9Vr1mjdwYLF0R7zYMblN/OsAN9xTbSDE8QUFAog/ujJbVicv97uwYR
         hzO3FcYNPPzeqBC0GjVxImgdcY9fSnK+rHwClA6gLJHZ4TspHIAPiSNyBgH6kcwQ4oHy
         x8xE8E4dTl5ajXFiuYnJcsZ40pU05Tw2GX9Wf8Ugf8wUytjRXALmtYI0tQL/uK1BZg2R
         TxEpeVKD/itCkyVskfA9DBLIijwF+0+DDzwxAbTCM4U5SGmKoVpBpgrceH0HwfXP7JXV
         tWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901133; x=1756505933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=povoySMDMH4jgrz3Br8X8ooOXJKrPnkecGKw2kqO4xs=;
        b=dj57vyrrCRbdALFf8wBnl9Vv9CYUl91PH3tidG//bECREUTAphdNy0F7NinBy4cda3
         s9FpJqrKPxOxlRPm6nPqMqsmL5hycBHv3rO7CkljeqeJT9SOFzRTszN3YNPt/nbzpkqm
         Rwcot1TYttjrhTT/TbGAVo1UTSNCOO0D4E3diBaemfjo2+cHOpgMHwtI0I46YRdBWJ1U
         RVhOC3yBjnBZD65/Qm5VdxUppQzZFs//IW99RbkYUY6FTSnQQWshf0K0XfKOPWRZ30LB
         w8HpgLBfNz9oD2uM4DbqtRn6nYaPvxSNX5pvvu/tVnoxcQobJc7j9R53CEAf/u5/h0Ey
         La4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0BxRkeJEv/jOyj/qvFbesHFqpYxmJw/4d4iq/D5TBdCUeCpZMShCBf6mxlIotw7TNxiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxnRKRb3iHGnSIbS+FjM+C6iZK9u30vSSRG8M5XijLFOgcC/K
	giNtEbCE6Ndo9SPzrF0/6kegD5HYJhFaAfqkHOSugxryvG9Z2cjj6jQHiUP0i21xCdTxFSDxgM4
	nfp9vzA==
X-Google-Smtp-Source: AGHT+IFrehCbMo9OiA7VNG7OIJjpck6BwlW5cw2/haOPtjx2K8umYHB+q0m+3Pqyyu4KjlZzgFkbRlisJvw=
X-Received: from pjbee5.prod.google.com ([2002:a17:90a:fc45:b0:324:e6a7:84ce])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dd1:b0:312:1c83:58e9
 with SMTP id 98e67ed59e1d1-32515ee155cmr5681496a91.5.1755901132682; Fri, 22
 Aug 2025 15:18:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:17:57 +0000
In-Reply-To: <20250822221846.744252-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-3-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
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

We will store a flag in sk->sk_memcg by bpf_setsockopt().

For a new child socket, memcg is not allocated until accept().

Let's add a new hook for BPF_PROG_TYPE_CGROUP_SOCK in
__inet_accept().

This hook does not fail by not supporting bpf_set_retval().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/bpf-cgroup-defs.h | 1 +
 include/linux/bpf-cgroup.h      | 4 ++++
 include/uapi/linux/bpf.h        | 1 +
 kernel/bpf/cgroup.c             | 2 ++
 kernel/bpf/syscall.c            | 3 +++
 net/ipv4/af_inet.c              | 2 ++
 tools/include/uapi/linux/bpf.h  | 1 +
 7 files changed, 14 insertions(+)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index c9e6b26abab6..c9053fdbda5e 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -47,6 +47,7 @@ enum cgroup_bpf_attach_type {
 	CGROUP_INET6_GETSOCKNAME,
 	CGROUP_UNIX_GETSOCKNAME,
 	CGROUP_INET_SOCK_RELEASE,
+	CGROUP_INET_SOCK_ACCEPT,
 	CGROUP_LSM_START,
 	CGROUP_LSM_END = CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
 	MAX_CGROUP_BPF_ATTACH_TYPE
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index aedf573bdb42..4b0e835bbab7 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -67,6 +67,7 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 	CGROUP_ATYPE(CGROUP_INET6_GETSOCKNAME);
 	CGROUP_ATYPE(CGROUP_UNIX_GETSOCKNAME);
 	CGROUP_ATYPE(CGROUP_INET_SOCK_RELEASE);
+	CGROUP_ATYPE(CGROUP_INET_SOCK_ACCEPT);
 	default:
 		return CGROUP_BPF_ATTACH_TYPE_INVALID;
 	}
@@ -225,6 +226,9 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_SOCK(sk)				       \
 	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET_SOCK_CREATE)
 
+#define BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(sk)			       \
+	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET_SOCK_ACCEPT)
+
 #define BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk)			       \
 	BPF_CGROUP_RUN_SK_PROG(sk, CGROUP_INET_SOCK_RELEASE)
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..80df246d4741 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1133,6 +1133,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_CGROUP_INET_SOCK_ACCEPT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 180b630279b9..dee9ae0c2a9a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2724,6 +2724,7 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET_INGRESS:
 		case BPF_CGROUP_INET_EGRESS:
+		case BPF_CGROUP_INET_SOCK_ACCEPT:
 		case BPF_CGROUP_SOCK_OPS:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
@@ -2742,6 +2743,7 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		switch (prog->expected_attach_type) {
 		case BPF_CGROUP_INET_INGRESS:
 		case BPF_CGROUP_INET_EGRESS:
+		case BPF_CGROUP_INET_SOCK_ACCEPT:
 		case BPF_CGROUP_SOCK_OPS:
 		case BPF_CGROUP_UDP4_RECVMSG:
 		case BPF_CGROUP_UDP6_RECVMSG:
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..23a801da230c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2640,6 +2640,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_CGROUP_SOCK:
 		switch (expected_attach_type) {
 		case BPF_CGROUP_INET_SOCK_CREATE:
+		case BPF_CGROUP_INET_SOCK_ACCEPT:
 		case BPF_CGROUP_INET_SOCK_RELEASE:
 		case BPF_CGROUP_INET4_POST_BIND:
 		case BPF_CGROUP_INET6_POST_BIND:
@@ -4194,6 +4195,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_INET_EGRESS:
 		return BPF_PROG_TYPE_CGROUP_SKB;
 	case BPF_CGROUP_INET_SOCK_CREATE:
+	case BPF_CGROUP_INET_SOCK_ACCEPT:
 	case BPF_CGROUP_INET_SOCK_RELEASE:
 	case BPF_CGROUP_INET4_POST_BIND:
 	case BPF_CGROUP_INET6_POST_BIND:
@@ -4515,6 +4517,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_INET_INGRESS:
 	case BPF_CGROUP_INET_EGRESS:
 	case BPF_CGROUP_INET_SOCK_CREATE:
+	case BPF_CGROUP_INET_SOCK_ACCEPT:
 	case BPF_CGROUP_INET_SOCK_RELEASE:
 	case BPF_CGROUP_INET4_BIND:
 	case BPF_CGROUP_INET6_BIND:
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index ae83ecda3983..ab613abdfaa4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 		kmem_cache_charge(newsk, gfp);
 	}
 
+	BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
+
 	if (mem_cgroup_sk_enabled(newsk)) {
 		int amt;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..80df246d4741 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1133,6 +1133,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_CGROUP_INET_SOCK_ACCEPT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


