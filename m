Return-Path: <bpf+bounces-68053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156AAB520DE
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742ED483E16
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B0B2D593C;
	Wed, 10 Sep 2025 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdns1+Vf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03792D7DF2
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532070; cv=none; b=HrXy5yJVpXM32cRVHqsiAlrq839mrsZ0pZOcN+uYbEtZXbFQVDthsxuN/YS4uNKQeVL+RmxmLazlNxyUEAhgcdSWp7ytT7YuEfhQbB/eh+ElT5Mb0F7E1FOkMDhLoMpMU34cqc35t+pkD2BJxAyRv3z/PK3L0+RjeRu3T3EEKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532070; c=relaxed/simple;
	bh=rGkoFu9nkoi5/nIXhQG8fsZVP8xpKsdD3ZK3Uhe0wtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LjMP4uFqpisrvZFSRKJFdYG+gN1mabs3yIwhFEaRS82iJsSNT8f9vOXLix9wXOPGX24e83n2KoT+ze7anV/aOr65Im+qsBijfHPGRUjhJ82Y6BC+xzG6mjge7zOi1mUWux3wJwz5HCyx/HhqIFy1BiV128kp/EAzUQ0qEay261s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdns1+Vf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32bbe7c5b87so5539744a91.3
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757532068; x=1758136868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hadbIntpGNCK8KIrsiK3iLz7/wZPA5xxeDjpdPKa29s=;
        b=qdns1+VfYdw8PcH88jRbi8+uytV9Qb3Rnb/kR0IwCDcleHMs32e0v3twJC+SfhXBkD
         CI4OiODYXvRhTvDpJaik9KnPyy9OoCiQHzq5izWdYX1YXKCJwlmkLloelIibi05vddIr
         QnWsbIaG6bw38FwCN9bZTPiP4M7oLAnYQ5NZ64psaQ+THVu5tzRz65zdGlPEr2RIM/Cu
         pK2SCZhdVdFXjqCXyLWAJpd5QBeBRP1NxBGFWK4qQ64xkk2DJeCEoBAWFgwDJfGjvwJK
         o0uPPL/E72XMwaLWTPOd/lGfrmVvyPGBAObQqek3Md6128akzQehPKvVgMjqZNwck9AG
         rQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532068; x=1758136868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hadbIntpGNCK8KIrsiK3iLz7/wZPA5xxeDjpdPKa29s=;
        b=ct2GQTOeXS4ZPFaZ3RoPhJmnEOdQfWGQmwLEfJsp7MMyB9Od4/yt7j0kEBsABodEKS
         k1NGGIttK4Hid1Vp9+LKJ84ZQMgQR8oZ2JD7FaCXYMh8pkc308N0YgxMTHORUCVOlnTg
         X//I/d3u4ou+YVRIMiwaFP94cW1JgPc2b/wuX2p/IhhzMpG4e56MyWQo7vKxczeOmuDE
         WagqtXJdymn/ObquZpkLLLDGUfArn5K0HzDwr+XnSTd9aIDZPg3PUYVAHSHCFu702ksq
         ThGrkJIJ87uh+HJL31tYV4KAcWD61V7OVlGVt9J0sgVkxly54LgVucOpjURL4iowiHjP
         /7sg==
X-Forwarded-Encrypted: i=1; AJvYcCX9XggTOKGl+7Ee8jTNbOv8WdUxFbyloxS03iFsLafMWXcp30DiFpiBhTwg3FCXwFaR3nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jFI9v1QNDbVJEFMHVicl5ZGrmdJqhIHb+pxS804/SxYAnoOv
	gdd6dQAkXkTsztlaJYqhkMkn9k2Gs9KOUwGlFQvzMjM+fCgKBHC7FMWT5WHwGH9nEqdv3OpBK6W
	XWdNKdA==
X-Google-Smtp-Source: AGHT+IGbANkEku5ty+X9AZ87gGL4+UNPqYynbA9OgB9jQfV4sifD2iaaynGTbEbqa9ppCZoR0agb34J3B/I=
X-Received: from pjqq13.prod.google.com ([2002:a17:90b:584d:b0:32d:a0b1:2b03])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5105:b0:327:dc81:b399
 with SMTP id 98e67ed59e1d1-32d43f03dc3mr20918419a91.9.1757532067943; Wed, 10
 Sep 2025 12:21:07 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:19:31 +0000
In-Reply-To: <20250910192057.1045711-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910192057.1045711-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910192057.1045711-5-kuniyu@google.com>
Subject: [PATCH v8 bpf-next/net 4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

We will support flagging SK_MEMCG_EXCLUSIVE via bpf_setsockopt() at
the BPF_CGROUP_INET_SOCK_CREATE hook.

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
v5: Rename new variants to bpf_sock_create_{get,set}sockopt().
v4:
  * Use __bpf_setsockopt() instead of _bpf_setsockopt()
  * Add getsockopt() for a cgroup with multiple bpf progs running
v3: Remove bpf_func_proto for accept()
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..31b259f02ee9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5723,6 +5723,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_sock_create_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
+	.func		= bpf_sock_create_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_getsockopt_proto = {
+	.func		= bpf_sock_create_getsockopt,
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
+			return &bpf_sock_create_setsockopt_proto;
+		default:
+			return NULL;
+		}
+	case BPF_FUNC_getsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_getsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.384.g4c02a37b29-goog


