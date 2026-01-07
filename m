Return-Path: <bpf+bounces-78077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E43CFD9A1
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 13:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B065305968F
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3A311C15;
	Wed,  7 Jan 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1D1drad"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B682FB08C
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788257; cv=none; b=IGZXcftw6O7As5UaAgABNNWHw/3k4WLEguYGVH1Al3hE2Akk149VLaxafx5k17ksk6DvGdNkpSXXl8iWTlnLQ50GOYcUAh/VqQVYaUnGGphPVA6WL4iSJoHY8utzYuUL6mZ249aIvBGpl9XH0At1hXIOHtp+L7vbOkk3pzq0gpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788257; c=relaxed/simple;
	bh=6oDFp6ikqBgS4NvjQlEcN+NYxI3tGIrBI1QcoO9lYMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfacTA5PG6yVRB8ZFs04/7JurBgMFjlCxey8YD54Tacq24TkgUSmjXtiR2y16ylx7oIbMkXAS5LoJ9SxkkwjQkynURUTD9FLQq9EQ1U+6wDklVcmI/B0tCjM5S0A3m5YIlFo8XB5iTrfD4Qt/dHJ+554TpSdbnN+jYsq7EUainA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1D1drad; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a07fac8aa1so18200855ad.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 04:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788255; x=1768393055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxLt1bPb5cLdWg0B5PWvieuskeOyEx2nDLq7pSp3TII=;
        b=F1D1dradbj3ijKYXCc6nX4i7QBHuII6mfCaxrNGvFVG3hZTsXhPpowDuE2H18qr+GT
         zw4sy0HfcfF6Yll/MKLOIgTs3lu0pQHfEU1N8wxBu+zq+PxFMm73nXzE4kKFvPGppfy9
         +UF/WoSCai3UrUFBUwF54zCZKYrOxw5+9EeyMpOGmBnp4GQwtqKhLrMLK3bOM7s/VJQc
         D/x8qhfVzfls/Ph/ZU0fTlh4+RPS4bdWKYYqLYHo8/cZKlgVSgoX0kXldAm5v1z7TXwq
         GnCZsNRsOQ3G9aTVyoUBuMYpHpBkfhJk9F7lWEVKEkQdPx0fFzpYkm0zFtl2Dk+qamOr
         S85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788255; x=1768393055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZxLt1bPb5cLdWg0B5PWvieuskeOyEx2nDLq7pSp3TII=;
        b=xUBgE6q5XC9VTafiBgYhFkyfltBheD4GCDBBj88g2x7soC/bfk1NjlpES7F2J+EEVR
         wSgAn9jXdNW156YHoqMGrjqVhNOVMpV+b6aiy+QYjq+2YFWRR+W+o1Wtb6I2uHRVyOvW
         yemAg5m2jfhBNPGt21f+n9nbr9J5R6Cl008TO6wImRKE8FJQ7kehHFRcXI0WufOftGH6
         UIbPqwdHpKRlVdm/M02MJ3KbL8sG9RCEaAem/FYdCJqSuXdWQYnnI9GIy+VV+4BV7V6h
         22wqi/jsQu3etHq4coT1PY9gaRUBeJV9OnG1tatN1c1t4uzuFfPxAJBx8X1zCWBmQ1cM
         61Sg==
X-Gm-Message-State: AOJu0YyG2LbuYevc0G/bn5dUiVfPH1eqxP8E2YlZObMT97QKagxLtTPP
	VconWn4VJdGqTcbuLjxVbU3/xj37BMvWZTVS17+1GHUssOveouVRkfR5
X-Gm-Gg: AY/fxX4nqj7iHDhc5LmanCe4mZQGFjnfwnOBsQEy5Mw1vHp1vZgJjPHCrb76bQ6ecZD
	xebZ4BvbeWXrfdutZWUGV7AZHiBztuO7poWjSTwc9Xa6vMBh0mZXBICZI2sQceBMJaxGMm5yp8n
	lczD0d0xTnZohdRpl5MpYfRKleyf8GxGYlRd7jgnDvWWuXlo/ZhaErP++/18e6oWX+f5LOFHm/D
	ucSJ0OnBlYrCN0u9oNnOC9MVeagwBZy1NVsbgNFsOmEco7TmdM4U15OndCiBMBpuFlenygS7H06
	/C+oFoQzxSMkvdmehpcQ1DlfsAknlT19XCJN2rU28vAVhpfve/WKSyJ+0GGMeWRBYMyuKR1jT95
	BR+Fi6u43CIG6fm+s61fiZ7x73oBkxcNA07B/g0icK3ALM4Y8GL6RAith+GfOzVYCAK0CTx3XRl
	BU0ad6zOqJ8u8=
X-Google-Smtp-Source: AGHT+IGiF9G+rvaOpCVWYv2ETMytrEzZAPWdZDAV0zOLsUPSBbRbuVJIdeQIAaow6iROGJG4ccGwaQ==
X-Received: by 2002:a17:902:e944:b0:2a0:bd93:4dbf with SMTP id d9443c01a7336-2a3ee4453d6mr27686195ad.13.1767788254971;
        Wed, 07 Jan 2026 04:17:34 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7856sm51003525ad.68.2026.01.07.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:17:34 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Wed, 07 Jan 2026 20:16:47 +0800
Subject: [PATCH bpf 1/2] bpf: Fix memory access flags in helper prototypes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-helper_proto-v1-1-21fa523fccfd@gmail.com>
References: <20260107-helper_proto-v1-0-21fa523fccfd@gmail.com>
In-Reply-To: <20260107-helper_proto-v1-0-21fa523fccfd@gmail.com>
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
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2ac3zke7gDNeXd3zfyqc//gN/vvbjrX/K9+XK91/uTGg
 pMbls5t6ihlYRDjYpAVU2Tp/WF4d2WmufE2mwUHYeawMoEMYeDiFICJNHYzMszrvh0k7hCxlEnj
 4bxretGCW9NunCwX1nXXe200teH4vZuMDEfmHl3kzLmMIfLS5Ylxl3uL5qx74v6jz7r135VEn+O
 LrTgA
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


