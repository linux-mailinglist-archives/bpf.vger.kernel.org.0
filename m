Return-Path: <bpf+bounces-77244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373FCD2E3C
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 12:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 309283028FDB
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5729228850D;
	Sat, 20 Dec 2025 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNUw4PRD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD7302773
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766230552; cv=none; b=SvQMnUt46sh/3wQDDDO5XHJxnHWywpc6qnNfIrq97uaKpMLEPZnbY0jzJ/AKDHbywJzW6zLxc+tx2plRthCF/pxkF4gp3KkRvZcA72NGiB5XDivMqDuqsa7BEV22mrYUqqdQWQpll7HFTTdvyPzIq96KNAZDq+i6HF0BatccO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766230552; c=relaxed/simple;
	bh=TzPsFbXzEN8yJbx8ENdKQ00Lv+fJ8UDDohHsL3t0pNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ishC9fGDqi9+mXkBS4fn6Z0Cf2VF3Jfbi5q3vFPCvZZrwjFsWjqww/NfBxhKRDnNpnL4xpeVlCzg1dcj343MKYWGUydbWmDwZgPFam6lFMb+RSokFXa5M4YpDsF/HvAagDwI70ULASUk8Vz0kACQBLJEXhBJ3IvOEVE8czsqRes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNUw4PRD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso4064411b3a.2
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 03:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766230551; x=1766835351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0zqUWkRr1OhlERiva29GCpoJfzXQoSXsvZUKYgXshQ=;
        b=bNUw4PRDd+cCA/vyQB21p28eMoM8y4ZRnVmknWpV2YAc6pMDGKhWTBgpbnifcSwugc
         ZywTWlZh9pevCbDl6ihRDotev21OlkZtCLT4cirnHtQ7KOk7TDBwdZlZh334GA+9Fu0d
         EGkmgt3Mmen74nw0xGQ89fVpTIyw1RYzn39eFmLAEfywgdtiMyoAWuRNf1Pshsu7RoMy
         MhVyi+05UcJlL4G2Cl9SuGKbGbGWe+yNoUSLTey0pnFUA/Oeb2IS7dgYm7AJ6eXaV57s
         7aTF2iB3U85JRFO/ZQR+JO4EKBtuGI3U3iXamRbuUnRSH9Kw/xlfm6v36+q4b1BcNVYY
         Yrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766230551; x=1766835351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0zqUWkRr1OhlERiva29GCpoJfzXQoSXsvZUKYgXshQ=;
        b=ChlgmHeYlrQr/nyDHFTSrjE9qYyC675hNX8ih2ShrW6vGCUNl15ZVLgk1TJw8sqHXn
         BtiP8Uh5JL3LKj1fALR01y9Q/o+tuTcx3DRpGYr5E1iRsEQC14SrLeem4LiY/uqmMGoy
         xOiewjG7kSmgclexCGxoA3vy8FjrZq7CeWY47ZkkMCpUgGhDHbWjHtyUtX3j9TR6XP4Q
         UVRWqM50WwaGTgZ+39+9g9v2I0+5leLKzE8dZ0lO/P4HP8qjLSFBpO+Mmvd4Nk1k23uO
         0Vs9bc4Vr+h9XGdjuVUAlvZKXtxhLmU2pNM1WwlRhuy00Tv2ULvVuqr8k03D+cbgHFL5
         1uNg==
X-Gm-Message-State: AOJu0YzBSWKZ3H6hCXUeT5EEj61psn0NJf1+//Yl9REUuKzXaYcl3KLG
	r9XnvQod6cwgCByxwqYf0XSW/idKYZi4bzhX+xAp6N9CwFmYCjZo/tdd
X-Gm-Gg: AY/fxX7WJGx1M7r8qD71D+l+NKNW/Da4SPx7bWmfWndFxtRxDGfbuJEqyuyWkI23XvE
	76yoV7/F7XMQgET8h7aui/+xI7+kipeCK6MYvy+WwLWNWqeDVA55rg6dEWHtt3QcDvcTbTYSl2N
	CuXUixyFaL6tF5DPBj0+puX/0eIle2bXKyv02DcMLfqZTr6yDcBBq9zkcHa7/pIp0Dom5yMGt1S
	5nqZh4ASP2+rAXN8j4okxOx94xb1Vmuwem8PxqzIj0F6OUGrUngLZAP+8tjyzhbL+DtRBGK+9yI
	oMYGeO3EkGaDVXR1WItTldDDxLarUVffIe3pvE7Pk8VKaf3y0QFGjXyGNlrzta7+X4xqDHjiofu
	LyNLuEpLaP0c4eU7STXnDS1d2DmHZxB9Qh21Hu+JwQaSqDj2G2YceRGIvLqwdwTsW74xiGX2HhP
	0z18YkfAtn3Qw=
X-Google-Smtp-Source: AGHT+IGjXxkdEc26flzm1tjMlF1UGlJYpJbfDXErsjFRqInN2xVsk033RWoq042V5e9gt/g5HQEI6g==
X-Received: by 2002:a05:6a20:7f93:b0:366:14b0:1a31 with SMTP id adf61e73a8af0-376aaefd515mr5284172637.63.1766230550204;
        Sat, 20 Dec 2025 03:35:50 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d65653sm7799389a91.5.2025.12.20.03.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 03:35:49 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Sat, 20 Dec 2025 19:35:04 +0800
Subject: [RFC PATCH bpf 1/2] bpf: Fix memory access tags in helper
 prototypes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-helper_proto-v1-1-2206e0d9422d@gmail.com>
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
In-Reply-To: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
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
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Zesen Liu <ftyghome@gmail.com>, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4723; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=TzPsFbXzEN8yJbx8ENdKQ00Lv+fJ8UDDohHsL3t0pNQ=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ6ZbF0v7/Qwf330Cdnmb2e2jt0ScOaRnKWfMI7P12AJe7
 wZXsf6OUhYGMS4GWTFFlt4fhndXZpobb7NZcBBmDisTyBAGLk4BmIhbDsP/0vAbV95In89d8W2J
 wHG+n4W9rqGi3yaL3zxxaobcJSbpN4wMO3mD/DolW82Xrd0d9UDy/5ezqW8vb5U9eSH+9KXoabX
 WnAA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking"),
the verifier started relying on the access type tags in helper
function prototypes to perform memory access optimizations.

Currently, several helper functions utilizing ARG_PTR_TO_MEM lack the
corresponding MEM_RDONLY or MEM_WRITE tags. This omission causes the
verifier to incorrectly assume that the buffer contents are unchanged
across the helper call. Consequently, the verifier may optimize away
subsequent reads based on this wrong assumption, leading to correctness
issues.

Similar issues were recently addressed for specific helpers in commit
ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's output buffer")
and commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name args").

Fix these prototypes by adding the correct memory access tags.

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
 kernel/trace/bpf_trace.c | 6 +++---
 net/core/filter.c        | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

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


