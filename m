Return-Path: <bpf+bounces-66915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5132B3B025
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E16E7A613E
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 00:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980821F09B6;
	Fri, 29 Aug 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaO7uEEv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F478F34
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429236; cv=none; b=jWG5L6fIBkMmYL7EK+KqyO1S7rKtrI52X3WPNE5OOGQYHBmCQN28VAqa5jpVkx0Nzg8LrsZcWHcHIwmm/hXxkbmeqC5QXWubWyMJauEJKjyhJphkngorohFmbRv6PlnsgFXnpLSfMx6tZ0+Tkz7lg2XJIaHyp8N/mcI175wG3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429236; c=relaxed/simple;
	bh=Is8kbxRW8jhZhX+6XLLs47qB3YfRF2r1dknjq2Pezc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XgLhrLggcIGCk/sdjWE9IEFAmKobUOhASwgdOR66Ufs4pkbv6vzsAgup6RXZF5C3/gw31ZYf5spKcK8/I3S1eAXx2zy4jByXm60mrpcli6fWsOJ38Cg6pDQgWlph9aUFmPhK9jew69HWEdW+vlbJe13hNKYkBzgpnRPZ6XhbEGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uaO7uEEv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso1415069b3a.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429234; x=1757034034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAF3FQNLKAl9oDz0E05A/xKhwXgqQ4gwB23R4aRTiHk=;
        b=uaO7uEEvy1Iahds43oa/CHxAuyizreI+KqqCbI5NDAD+Sk+hJJMmn6U1hRjMfLK4oB
         x4u+iGrytnmur1UVJtreCpL1xSK+svKhGmm4CKe7SZSB8gWsfpFB4xR9+HDYGZxZdK0j
         zKNN4M8E/oST1W4/x1xa/NcfoVr61MR4EiVTSPo3fV0O+muEYyFQeGp0bnKGEpZZhmun
         RgNjANEOfFXeDmQDFUUnSY7pM//7Yt9cut4ymP7QExJE0VyWUObTUavo4ZIcy252gllB
         QUlLwjME8YB+rerD9meIEL+meaiXgOGj6Xjt/lHBvcjAmOrRAM5zSjICNUOw2sQJYD8L
         K41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429234; x=1757034034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAF3FQNLKAl9oDz0E05A/xKhwXgqQ4gwB23R4aRTiHk=;
        b=jugc90wBY6SSBcfn+NrAfV7R5GUJwN+xsuxMLzxsjSTT4sr4se19O5Ytrzl1sItHRz
         D4fA3YE/orCDTPT/w08sML4toptU2BL6Du4My3u7n/N2r4i22ZJN5YZPCqthf4w9BMRJ
         OlMYZOsICZNH0M0vGna006T/TCD4yihEbmdL/KvoZANcZyzTOpGtfal2YfU57dT6aKGm
         69kUMp0ttQro565hIGlibQiUMewg3dOltjIw6tgFkm8B5HQnhQR07MNBVjhEHhdM/st2
         kNbuq/ynbs6HcUxlIH0RbTKW0GL4pClbV+wLrlkkt+Zw5WK8UoAnx7ZidBhNbiJd7ycq
         o9xg==
X-Forwarded-Encrypted: i=1; AJvYcCXIxy5vUi65crA/UNljP+dgLyzfPuxLrRNYMqee4N8NLdWg7gwuVAeKYO9Zu+iCNiPucj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5v3oCw5fa3um8jfkm/ZMHbCcDxYhRFeGv2Cc/49pozfzVZHd
	Pf6PFO7tiJuSpfn+qlo3hcvvYQKqAmwDrV7Obyc3sQQaa8YWvOxNkzdh/A/G/PVeIwnui0yyNyV
	TXaLr9w==
X-Google-Smtp-Source: AGHT+IHFp4wOwQl8ZGrkq9TjXMLxJ7v7p+L5PsbNdfCeg7YTZKt9akhASRe8npJw+ekfKStndxntsZEeUWE=
X-Received: from pfoo18.prod.google.com ([2002:a05:6a00:1a12:b0:771:e7c9:bf42])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1953:b0:771:e4b0:4641
 with SMTP id d2e1a72fcca58-771e4b04bbdmr21349037b3a.1.1756429233575; Thu, 28
 Aug 2025 18:00:33 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:00:05 +0000
In-Reply-To: <20250829010026.347440-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829010026.347440-3-kuniyu@google.com>
Subject: [PATCH v4 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

We will store a flag in sk->sk_memcg by bpf_setsockopt() at the
BPF_CGROUP_INET_SOCK_CREATE hook.

BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
that passes a pointer to struct sock to the bpf prog as void *ctx.

But there are no bpf_func_proto for bpf_setsockopt() that receives
the ctx as a pointer to struct sock.

Also, bpf_getsockopt() will be necessary for a cgroup with multiple
bpf progs running.

Let's add new bpf_setsockopt() and bpf_getsockopt() variants for
BPF_CGROUP_INET_SOCK_CREATE.

Note that inet_create() is not under lock_sock() and has the same
semantics with bpf_lsm_unlocked_sockopt_hooks.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4:
  * Use __bpf_setsockopt() instead of _bpf_setsockopt()
  * Add getsockopt() for a cgroup with multiple bpf progs running
v3: Remove bpf_func_proto for accept()
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..b6d514039cf8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5723,6 +5723,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto = {
+	.func		= bpf_unlocked_sock_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_unlocked_sock_getsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_unlocked_sock_getsockopt_proto = {
+	.func		= bpf_unlocked_sock_getsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
@@ -8051,6 +8085,20 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_setsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_unlocked_sock_setsockopt_proto;
+		default:
+			return NULL;
+		}
+	case BPF_FUNC_getsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_unlocked_sock_getsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.318.gd7df087d1a-goog


