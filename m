Return-Path: <bpf+bounces-78080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38C6CFDA9D
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 13:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83E630B1E1E
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD3314D0C;
	Wed,  7 Jan 2026 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHy6lYO6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636D314B66
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788550; cv=none; b=c8Dosppd77kFjo3WUS5pykK9zpv159kaVgWsTRI1sz9VYU1pxiv3ROJdvFRJAAU9HFFeHD8YC5I/JBFx0gvbt8Gz6qnk3TLY7oc1RsfqY4nyX+gbR9yWuKMMzpMjLW7FYxhLfwDgi3js+8xBJdZ7bKVDgmnpJZ7N97rCkaA9P60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788550; c=relaxed/simple;
	bh=6oDFp6ikqBgS4NvjQlEcN+NYxI3tGIrBI1QcoO9lYMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJfIwqvDVv/7Wky2edz+6KgTZrePugz1R8fY+feqUJNO0FqzS6FiDBWuMsZ2OSILIaIofZ1ltrJ0UhiI9oH23YbBnFLZezeBM6L8t9AOMKeMIEhUK3ZFXDnpqKGHwOkXs2Hblxh2+IFnllrjD+VTJ33Q+bgtf+dol8/0+YNHipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHy6lYO6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so1755335a91.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 04:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788549; x=1768393349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxLt1bPb5cLdWg0B5PWvieuskeOyEx2nDLq7pSp3TII=;
        b=fHy6lYO6jp3lRLyMYZe3IygWIqqN7HP2cXK33FZo2crbhXlFtHJRk4jECq3kmTY7Jg
         z6EFkPFOCMC9YGdp+9txFypWOgbu7Ka98dxPJoypWsEiiJ3ZoxY3lxzZQ4FLPNdKD3J6
         YE9atPKkJN+s+Hiu4+nxo8PtSh3ZlAn21OnVrvbGqUffnxC8ZhNh7tB4wW2n9RFGE6Ir
         4YWp+1yrvHyvT3wvUjSaAz5AlnCzpdDaFpHJPRqiRhjFHmE6mBt2rEuQX2LVJ+exrlnX
         Vb4XUuuIP5D6YLY1HmNenG+mF7KQ0RW/otIr1SzC3qycaDPPKbPklOp2Y0qh+D8v/aYH
         tg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788549; x=1768393349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZxLt1bPb5cLdWg0B5PWvieuskeOyEx2nDLq7pSp3TII=;
        b=VViG2ogwh9xIMwvxvORXW/ZVPt7HBlqYDYx8+6h0YFjJpQI+q2RDNkZyn97hGkIEil
         menDBerJkSU4QMqXJracj5vQdsPSZtQ7nx9IC/tGZV0rxCimDLLHgRqys0PZRYMMKWeT
         2ZkKQn7ojqAo1Q83kH2fWopB5Gva6JaXJJXKoKn28N4Xtk2Je+lQ9SVjPkP7srAlUfSG
         QTFcRoeXWT6jkc4ooGaVOtW5PqsQwo9xJO7alu9U35btgAOYpN+tzd66aflCCBNvdCg4
         eRiGSNYTo0YqkjM8KizQPdWkdMUBg8U5+t5Rvq7RAegMQi32d3e6xWWDagSR3CcliA3e
         I/CQ==
X-Gm-Message-State: AOJu0YxP8ThvCkA6T4S+bxzxoZhV56aDPaj7MINJTUS8+jnpXoLhY0/6
	4OQuapNCX4m2UoHczX3TlSN7pfYrbwKFYO+CVA5EHgH6EVjAL7pSV+NV
X-Gm-Gg: AY/fxX7GsLLRr6iqZqUguagPNayZ/7mVDstQLO25AXI13JtxqNU9QEQ1s7+oUU26T/7
	bri6PV6rWalN9IjN2iYffH8UXFSwRcgb0XXgkAMst327QBev2rHk6vMS7jM0ZoWe/svhJzoGSZU
	L80pEstVeSAdwzX0sr8aswehr6OZPyCIRb6rA7Lyc6WN0Is7iLsOnVZIx5MJwX5ncNbwRQ8CiK5
	hA8MHoeM1mUVrQOQ5aJjQr4ziEqC5ooXUu7LrgHgEhiACRuxc5GvFxtHI1+XwHYbA/fjWUWGTpX
	xx3u/vRUTYhtI/1Jgvb3WrBNsfT5Er+Rr0x5bpEgyqgjuYw/swG8LC1UwMrvcWJJhQGDKp0PvHI
	/ervh6rsNk3cYgxQdkx1GX71QXx594sLyyXLBo+jYUGS7RfOZP1I+3zZgNZR3VfFLZC3g3bO4tB
	xiCib0nXuJQ+64c5KM+5xAAQ==
X-Google-Smtp-Source: AGHT+IGMhHuRS5o+GTE6fiL+UGv/YA7yMKM0gxu6LQ29zfgnf2FGe0JFwDg0odk/A2Q3yA/ZyxafNA==
X-Received: by 2002:a17:90b:4ad1:b0:34c:7d65:e4a with SMTP id 98e67ed59e1d1-34f68c62b7fmr2222804a91.31.1767788548263;
        Wed, 07 Jan 2026 04:22:28 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b1526sm5025946a91.14.2026.01.07.04.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:27 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Wed, 07 Jan 2026 20:21:38 +0800
Subject: [PATCH bpf 1/2] bpf: Fix memory access flags in helper prototypes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-helper_proto-v1-1-e387e08271cc@gmail.com>
References: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
In-Reply-To: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5550; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=6oDFp6ikqBgS4NvjQlEcN+NYxI3tGIrBI1QcoO9lYMw=;
 b=kA0DAAoWjB93TexNMocByyZiAGleT/Sj3Tw1qRS4iEQ5ZKqX/Zr0iIRtDyzucPnnik5D1j16s
 Ih1BAAWCgAdFiEEjfgx3alpNzO2PKDBjB93TexNMocFAmleT/QACgkQjB93TexNMocb3AEA8+Sn
 cCnGk681RIuEzT5Q4i2a/JxVXbY5lQnUlvxzD74BAMI+ocInMSeAHlMOLy27XdeCylBYw9c9DjP
 yt7LIErQP
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking"),
the verifier started relying on the access type flags in helper
function prototypes to perform memory access optimizations.

Currently, several helper functions utilizing ARG_PTR_TO_MEM lack the
corresponding MEM_RDONLY or MEM_WRITE flags. This omission causes the
verifier to incorrectly assume that the buffer contents are unchanged
across the helper call. Consequently, the verifier may optimize away
subsequent reads based on this wrong assumption, leading to correctness
issues.

For bpf_get_stack_proto_raw_tp, the original MEM_RDONLY was incorrect
since the helper writes to the buffer. Change it to ARG_PTR_TO_UNINIT_MEM
which correctly indicates write access to potentially uninitialized memory.

Similar issues were recently addressed for specific helpers in commit
ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's output buffer")
and commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name args").

Fix these prototypes by adding the correct memory access flags.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Shuran Liu <electronlsr@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
 kernel/bpf/helpers.c     | 2 +-
 kernel/bpf/syscall.c     | 2 +-
 kernel/trace/bpf_trace.c | 6 +++---
 net/core/filter.c        | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c..f66284f8ec2c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1077,7 +1077,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.func		= bpf_snprintf,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_CONST_STR,
 	.arg4_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4ff82144f885..ee116a3b7baf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6407,7 +6407,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.func		= bpf_kallsyms_lookup_name,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fe28d86f7c35..59c2394981c7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1022,7 +1022,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.func		= bpf_snprintf_btf,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE,
@@ -1526,7 +1526,7 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.gpl_only       = true,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
 	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 };
@@ -1661,7 +1661,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index 616e0520a0bb..6e07bb994aa7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6399,7 +6399,7 @@ static const struct bpf_func_proto bpf_xdp_fib_lookup_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -6454,7 +6454,7 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -8010,7 +8010,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv4_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
 	.arg1_size	= sizeof(struct iphdr),
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -8042,7 +8042,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv6_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
 	.arg1_size	= sizeof(struct ipv6hdr),
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 

-- 
2.43.0


