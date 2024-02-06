Return-Path: <bpf+bounces-21374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8384BFC4
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03B91F21B4C
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163421CD31;
	Tue,  6 Feb 2024 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAYU5QCR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8E1BDED
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257123; cv=none; b=t9uTi68vdqlm3sc6Al3DetB1IZH14kj70US8U61oL30Zlmap6QVDlnBtvXryFrMTH8hROJgxNAxWOtiLF8hK+H3nlm8lmC5iX3ZM1MrcyNSqZ+4bsB73vVzDcIE2hHXEOEikHUeFPTwUNDl0TDK3TkB+R6vPDfF3Syk8SXX0je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257123; c=relaxed/simple;
	bh=eueHQE607LnJ9GtCHljb8AaXRLkGlzLEzibT//2GRiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOgqKOqAq9be1w/ni0lPl+5DLctw4HGx9EHaLzghM1cnq6ruKO5kFyoF/bV0X052Nszb2z5cbYmsxpq0Sd1hWKpNdXfOsrdZ6uTWgawA1n5ozG2s9RSEN9kYVO+RzO6qyC3lPebEJH5zecnmIv5kjkk/8Vd28cGePv6fKKY7Jvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAYU5QCR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e02597a0afso12137b3a.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257121; x=1707861921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waJIZfpNliIHPa/9880riUne4F1M98q2cd6wla9GZjk=;
        b=cAYU5QCR847DECzpKXaWauFdML4N3o8+vpgtWRMWYKi+LIZaRCj4dZzq4YgGzxe0hi
         qO122rK5pmuktZ0XEwabECQ+K4GRArocMzp9QA6eNEDu6cfznqpyk7NpiKJprs8Naj46
         LCtWXpkrLZRKckl/3vRI62M+Xvy5llP0YNjK8kqGbiiqPmbA2esAMei/q+mhdwylYGcg
         xlfm64D1Ip+2qtkOENZRSHk4wL8nROXDyVj83cHwvQCJM5UW1ZsElpamZTGSmfnol43V
         zwoEfUV+TunxCgw46GHV2duuqC83wfnNkx2ofRaEKGVMenP8TyjcScD4UEh0bmUn8GXK
         wCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257121; x=1707861921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waJIZfpNliIHPa/9880riUne4F1M98q2cd6wla9GZjk=;
        b=DPwtsRwkVddHhxmdFXvULYpw+JiJjRmHBaGhpt5zequrgKu+Srdu49ls7sx+RCHbR8
         XAZMp0MkImrmUSnYzL5UpX1vu3YVGwQH4NTuzluYXVkq90UsN/qArPejLQETBQ/hak0f
         JBJofJbMWkJbFbBoSHyHv6mRZAbq8iir82+L0Gbfs8dABTg86mJQGaryqnjOF9rKX7CM
         XIH5ve4QYAVk+g6Va48sjbfFQVq1XFcmwThOJ1Bmto1rT/AjkDQLxIVGROJ6HRB5YDWh
         KSRec7Ed3XRywJdLazCM6H300E7ZO/QERlCwORc63+sYnQdniDIPQ1qw0ZCq7ZkFfcRm
         l7eA==
X-Gm-Message-State: AOJu0Yyra3MhBnL7JZeXSFyP8/Vhr1OxQXKxoIELc7zYKeB/31w3KFb8
	ERMYAxePRDreKB4TARecD0aA2ZvYLlwcWQT/nULzpUMvlFoJmDghlA8vvsqK
X-Google-Smtp-Source: AGHT+IGEm41W1mIMfg18EMXRi5EZlNoYfBurQNFDegQZNFeL2j9w6VizaJwjHHTqyxrGN0HSh8f/bg==
X-Received: by 2002:a05:6a20:8154:b0:19e:a23f:fa73 with SMTP id u20-20020a056a20815400b0019ea23ffa73mr606797pza.5.1707257121125;
        Tue, 06 Feb 2024 14:05:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXxN8orindXUKGG1h/zyY3mQyICEUtCIntzBop61kdfolwDs7jXajQYTwYORXc3hFm7NsG4OasP13LHB6c852skW89A5Q3SEJ9IeXDoIlf8HFxDkSEQwtp0/hR6/4zyqyoEUUOyZl7qxTHsrtAYLfY96aJG11wKBcbQfUK+jAghxuHvzl5GfAONh4LbS5QeBT2B9USv2mg4iHKbjiyPWsCkS1ydEmzx+CC1iJngFwB5VSmgSP3SEUQKbB3N9kyl4hqzgAWt3xXJbEfM3pfWaP0AZ0sXpYwjQtuN
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id x17-20020a056a00271100b006e0542f9689sm2474751pfv.103.2024.02.06.14.05.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 09/16] bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
Date: Tue,  6 Feb 2024 14:04:34 -0800
Message-Id: <20240206220441.38311-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

In global bpf functions recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.

Note, when the verifier sees:

__weak void foo(struct bar *p)

it recognizes 'p' as PTR_TO_MEM and 'struct bar' has to be a struct with scalars.
Hence the only way to use arena pointers in global functions is to tag them with "arg:arena".

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/btf.c      | 19 +++++++++++++++----
 kernel/bpf/verifier.c | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 82f7727e434a..401c0031090d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -715,6 +715,7 @@ enum bpf_arg_type {
 	 * on eBPF program stack
 	 */
 	ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value) */
+	ARG_PTR_TO_ARENA,
 
 	ARG_CONST_SIZE,		/* number of bytes accessed from memory */
 	ARG_CONST_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7725cb6e564..6d2effb65943 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7053,10 +7053,11 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
 }
 
 enum btf_arg_tag {
-	ARG_TAG_CTX = 0x1,
-	ARG_TAG_NONNULL = 0x2,
-	ARG_TAG_TRUSTED = 0x4,
-	ARG_TAG_NULLABLE = 0x8,
+	ARG_TAG_CTX	 = BIT_ULL(0),
+	ARG_TAG_NONNULL  = BIT_ULL(1),
+	ARG_TAG_TRUSTED  = BIT_ULL(2),
+	ARG_TAG_NULLABLE = BIT_ULL(3),
+	ARG_TAG_ARENA	 = BIT_ULL(4),
 };
 
 /* Process BTF of a function to produce high-level expectation of function
@@ -7168,6 +7169,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				tags |= ARG_TAG_NONNULL;
 			} else if (strcmp(tag, "nullable") == 0) {
 				tags |= ARG_TAG_NULLABLE;
+			} else if (strcmp(tag, "arena") == 0) {
+				tags |= ARG_TAG_ARENA;
 			} else {
 				bpf_log(log, "arg#%d has unsupported set of tags\n", i);
 				return -EOPNOTSUPP;
@@ -7222,6 +7225,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			sub->args[i].btf_id = kern_type_id;
 			continue;
 		}
+		if (tags & ARG_TAG_ARENA) {
+			if (tags & ~ARG_TAG_ARENA) {
+				bpf_log(log, "arg#%d arena cannot be combined with any other tags\n", i);
+				return -EINVAL;
+			}
+			sub->args[i].arg_type = ARG_PTR_TO_ARENA;
+			continue;
+		}
 		if (is_global) { /* generic user data pointer */
 			u32 mem_size;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6bd5a0f30f72..07b8eec2f006 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9348,6 +9348,18 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
 				return -EINVAL;
 			}
+		} else if (base_type(arg->arg_type) == ARG_PTR_TO_ARENA) {
+			/*
+			 * Can pass any value and the kernel won't crash, but
+			 * only PTR_TO_ARENA or SCALAR make sense. Everything
+			 * else is a bug in the bpf program. Point it out to
+			 * the user at the verification time instead of
+			 * run-time debug nightmare.
+			 */
+			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
+				bpf_log(log, "R%d is not a pointer to arena or scalar.\n", regno);
+				return -EINVAL;
+			}
 		} else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
 			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
 			if (ret)
@@ -20321,6 +20333,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				reg->btf = bpf_get_btf_vmlinux(); /* can't fail at this point */
 				reg->btf_id = arg->btf_id;
 				reg->id = ++env->id_gen;
+			} else if (base_type(arg->arg_type) == ARG_PTR_TO_ARENA) {
+				/* caller can pass either PTR_TO_ARENA or SCALAR */
+				mark_reg_unknown(env, regs, i);
 			} else {
 				WARN_ONCE(1, "BUG: unhandled arg#%d type %d\n",
 					  i - BPF_REG_1, arg->arg_type);
-- 
2.34.1


