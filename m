Return-Path: <bpf+bounces-67331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6AB42966
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCD8687357
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111413680AC;
	Wed,  3 Sep 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COc8r5SU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF22D9789
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926166; cv=none; b=bj5x+qmdrh4O4k4lua7rdBHRXEzVKEvSz47HKuEsowJotOD7v6TLOhWRMqn8XBlVKcmb3X75Ac2xMEb2x/gzy42f9k66h2Mlqd531fpWeKcfhjXHHmOVvEGMTmG0gbCxzhH/UcWKYNjZfMqsqyPWE4ew11ltlztvyyiTyVC0Cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926166; c=relaxed/simple;
	bh=msexKRoOWWu708vhFOv15aCp2yq6WClH6MFmNCnrAB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rgm6B+ps/aNX5jcZQ4ireRnAOOvsrUX9Z3WD5cJZCwdkCIgkqPsCbubIACCcxJiK6BJe53xPn22qvDsHwVoFin2AmohhD7PoOhvASZ3JQkiOvgn1reMMHLlc2CFEciJa+KrQBLPpsf2DaRQn+Cf7QX/GD6lhtDp168t8eD6FfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COc8r5SU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24b2b347073so3130845ad.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756926164; x=1757530964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHPGfsvlVgGO5d2N3Xpt2aHuFaG1f8adEH+NiEv9Hao=;
        b=COc8r5SUWOr2hICVqVf4wvk51ttgpVt9tvWng5QhpePcO3j0rDfAhVROMWh6/3eatT
         wgqx4q4+4//Spbeo/2nyhjjw8Ui6dmmC3upc0QZ9cA7dRf/c5CnJYwy7orETF7KBUjqd
         l2fkiQr6qlA0tLZ/+QqbPfPYix4OhzyRn3sgVd4WFg9solJNggaPSpYU8FwdilUs+y4V
         AQwDicrPjCfP1iNVHsPJy6r8fGtl928HzT2LQYBRe5sVYhfOTjAb8I6mdZgp5u5simP/
         cQfS8Pn191h1QLcdFEjDkycgwYbKly1cB6vA3NFOI6SWXioQeOn/mZOuRqBJx4dvAmZk
         LLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926164; x=1757530964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHPGfsvlVgGO5d2N3Xpt2aHuFaG1f8adEH+NiEv9Hao=;
        b=Wvh8LA4qbI/oHbo8a8MrYG3hFCwQRc+CxDskroxIDY4ARvvvTvktsYjEWdU2M2pS0E
         KT7s8gOO9BU2fr7OwNFuJwVEXneZqBBoKyrasmyrHFA4XHKpoQLvs98wNtWDhjZymMX7
         kBDiXjT9rOUZsPB2uw/QKTTcods72kgyeFeG4ZrOBZvW+KLD/VJldWHr1Uqgp16Es7Cp
         qKyHH6jjTShP9ispnZaBP9EEO+/5tSBjQS2xL6IQ5D2bF8gVTvRomkQAlEi2wSMx/7er
         TReMgixdXY3Ap0YtILYGCZ4O/l25VN3IsDUCKO8BCkNCFdQYOD5ni/zaDywO0zcTbs8c
         IvXg==
X-Forwarded-Encrypted: i=1; AJvYcCV8jYTX8xdfFXncMwctzCAU7ANd9XtQv21mvUpGt4C/e+KnRjvDOLPJDoauSKVCyRLok6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXYd3jF1KM1pYZtQcf8zd2u5oQzD5g5sOxqyDsmxJmhgL0aUw
	AJAsIutwtTpsZNZtjqUL34Cpig+R4YBafAx7+9bONtkCI/2ru6KLmSNCPH+gltiGvHScI0ezH1G
	8gJzT5A==
X-Google-Smtp-Source: AGHT+IFISbwiCDDNVkXjyASXAuvIp7wDi1cJn/o15BknQV0z4/pa2CGp5M1tmE3lZpHJhlz1Dip9HCEkve4=
X-Received: from pjbsg10.prod.google.com ([2002:a17:90b:520a:b0:329:e390:e996])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d503:b0:24c:ba8a:6f23
 with SMTP id d9443c01a7336-24cba8a7245mr7401065ad.35.1756926164419; Wed, 03
 Sep 2025 12:02:44 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:02:01 +0000
In-Reply-To: <20250903190238.2511885-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903190238.2511885-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903190238.2511885-3-kuniyu@google.com>
Subject: [PATCH v5 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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
2.51.0.338.gd7d06c2dae-goog


