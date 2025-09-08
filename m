Return-Path: <bpf+bounces-67808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51ACB49D02
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568D63B46BF
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B62F0C45;
	Mon,  8 Sep 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huS+c0no"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B22ED87C
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371080; cv=none; b=EpbZPlp7hGIM26FOdodsXltnFr6ClNBkYtpb0jlFtuzNM9Eov4peJrYghGwO5EYzFN8IhmYnQEcxrhe/WVNwEY84Y3aewiXY+H4pY4vsF0F1WsC41Fg0RvHLY4Yu0LksZNaBTcmvo8Lb7x8jArczG8b68Cmr+owhUhDcW7bG/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371080; c=relaxed/simple;
	bh=Zg2dYvCnPFVXnXB5nEBHXo464Q/xjFkceUox2T1mmwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SxaQd2h2WQkIjwApa03bDDQTp1bZVtqsiShrt45syNDhSW/GiO9Fh4arU5daoObPvFX/aYPRFp8N5YvJATtIGLox1hn1DTQhYvIw2kHN3Zkil9wDbOt6IFy+nyrnVfUJoS/PeqSYmheUq2g8KsQc4DKBTCkTeslIZ8itkVuTbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huS+c0no; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7724877cd7cso5613348b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371078; x=1757975878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwMayW5JGRRu1NxycFG0BO8xTeOuWUAjlnQY+YD/1oo=;
        b=huS+c0nozIuTg83psnYvC7aijbNiTnZooEfuHipayZYVTfVJN3VkKNG1V4f+mGAif7
         A/VN0q6k9guAv6KOUR2LX7qkXWdvLw9Te0y8DSh8Enw80mMJJg6L1HPFSe8BnPkbpXCf
         fI8RsFi85hYBrsRtQ4XRhbCMm0P5GvRhNrZzs/4SrIKrCNaBqRWgt/oBMtBXNgNsOwBC
         jgU7jMWu1TNQufq/90DG/jEEOKxXvppoKod0mBSwkk/rTedf8wkxCfYS3BYA8kaeb7p6
         EYGoanZOXGfEyh85VrUJF3HN9un5YvHTzxvm7Gzyv6UTyFHqx91I+wXyIen95BHu5gMC
         KYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371078; x=1757975878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwMayW5JGRRu1NxycFG0BO8xTeOuWUAjlnQY+YD/1oo=;
        b=M0Q4GH9XfRy01Ca/oHNbdjW7mW05XfT2xiifhFxhSiNamoa2CWg3eBxd9tLA80e0D2
         c7gHsx8XGBl0cI8GmOklbblrFn7jGA9Da5m3Uv45IOwXMGaKJ1n9jhDxHUFIF5CbCvDc
         BW2ou0X5Jpco+z1bnxVz/D/l0a39Zwst/y5vHhwbb+G2UjmgEuXkQ6Q/f/UJqeCQ3MjA
         j8iTNCRdSz39uxKf3ixTys1aZmzH0aivpeAjlnlV9r1nqCy0++FkYaKfBanW1O/D411F
         TN6qcU6+1bzRp5nBmgSY/G0zwJCd4AP5/xf48FhP0xxip2xvVO5LCks0pXZX6FasUPUN
         9hMw==
X-Forwarded-Encrypted: i=1; AJvYcCW7e30kp1UAqdG7dKNnPnwltjFomEOX1hwAiyaFiVJ8v5N1J9S1V8qhMb2FbqK1MXtULig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfIOzxonx5JW9O0u4QBQ39y88L5+jHmdTtRXWH9SDfiIDD9AW
	phqy3YCLb5+in13OsnVHLOcKsV1qRBFtLrHd4y44bWbxbX2TIuihDHPDlM4rqIZMTbF+Phvff+r
	05XR79A==
X-Google-Smtp-Source: AGHT+IGnIBxrx5Bh8I/A3wZNpztShzbnsVgQsQomp7OHc3xII3jvnrW+HDLcs5ORbhGcG+ksttwa+mKd0+E=
X-Received: from pfbbt14.prod.google.com ([2002:a05:6a00:438e:b0:772:3e0e:87db])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:181d:b0:772:5352:eb4a
 with SMTP id d2e1a72fcca58-7742ddf2069mr11382205b3a.21.1757371078299; Mon, 08
 Sep 2025 15:37:58 -0700 (PDT)
Date: Mon,  8 Sep 2025 22:34:36 +0000
In-Reply-To: <20250908223750.3375376-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908223750.3375376-3-kuniyu@google.com>
Subject: [PATCH v6 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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


