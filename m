Return-Path: <bpf+bounces-21594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282DD84EF8E
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923051F28392
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5E53A9;
	Fri,  9 Feb 2024 04:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ire1UH1c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194535667
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451617; cv=none; b=kA3sI8oucVbLK0RRnLSCUKMrzfGEauRLjtejtbQcQrIEAgLxPAesa2o6eq92QhFPuiksQzld5zpfLr37LXHbiIyLA8IyCVj92Cg5tZqM3CY5W3mYC6xTxWfeugxIHqDT/oUcLqZe4H/RWHUM6elcq0sAROPSXIoaxBTRs0gg96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451617; c=relaxed/simple;
	bh=Bg5aGjdIz8HulVZArC9AzXZ4d0bb4JFzjyEXMh1sB5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sikYJ6f1NcLChCg81FkUMpqISBag+6eZe8uEfTZvxBsCQcS0sVayAJKsUfdGPXihQpnenmfDixPLlnfBop57vxcvLz9wisyBQFng0BGHDCQCBGR9rVgZ3w28lQh6nTTLu2B7yGBYEr4NRoSRL6FU277yrK9n8rZMfsMGS9293rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ire1UH1c; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7354ba334so4476085ad.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451615; x=1708056415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ9Snvkhjzxk5f60xE38IZQNIMkdSN5DBO4L+T7puE0=;
        b=Ire1UH1ciFgYSUnaAX3+hxFI1ATA37DVRT8gPeUm10r7cFwA6qcDKQvktBvSksinCP
         ryDM1vcsaWc2u5X66oLEGLVtVpuoeGEo6uca1LWWy1HnTSGvqxpLn0LTlxw+KZowbmH6
         hO/4g6YMngxp4H/PaxE6qO00ArQQGr5vRWUnA8cFl837/5XImqAtXDCLC1IM+gkBxuyA
         xn2cHg0Paz/09+sRb69b6MAMMvxDjWWZXm/Bv1u3zcLBtErfkiR/RQQgXMHBqLd6GrKI
         iPM3vTd2rJlg8Xe1pQO68mmtqwObtugsp7HiXUXWWvEhaun7l+2Vu9UlRDNDdmpnUOWO
         4g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451615; x=1708056415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ9Snvkhjzxk5f60xE38IZQNIMkdSN5DBO4L+T7puE0=;
        b=cGcx5Ib9Gr/33ADYCfYtu5cUgKrsbj6lzCRZsLVjM8VKl2ckb+nsTnf9bjLl2ob2IU
         0F/O/TaQOYPfiL6snXHnTlwzJfDwvbCCVN8SKOugrO/bqXSp1bF6GzssM7MlLsp23Jul
         OjYJG/YueHKRUW3ZIVoBwOyVGvLtP1es+OALVDSzTNPnsMafDWmYlU+t1lJztDIZ24os
         EPlFj9pqSM4KUlP/q33PrvtGeipdboBJTwYZoh/zMY4axGwRS+eeyO76cwel/1Q87Hh8
         161F/0yHOZwJgy/5Pa1xrGgJMLjhI7yeCOMcCCe0fhlsiYBGF36LXZKEwcayjLixjsdu
         fA3w==
X-Gm-Message-State: AOJu0Yykly7J8kH38L1oonhnnsMRGzY28qgbMP1p/WEV20n+EXrJFFXb
	OHNa0V6IwCwP+Oux6UzJFQpg3zCBDjzNunHQHKHIon6JaB+8SMvvGpCPpNnT
X-Google-Smtp-Source: AGHT+IGdKvGloD2x7T0TvljdUW1/xtPfwtVY4eu3Wz+SojJrERvkkNs762n7o/a8ViAyTbYVnq16Ig==
X-Received: by 2002:a17:902:c403:b0:1d9:bbc2:87e7 with SMTP id k3-20020a170902c40300b001d9bbc287e7mr500885plk.36.1707451615176;
        Thu, 08 Feb 2024 20:06:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/x2cbpnz0BUBrwD3oynKGkbQWd49A9Q51EP6K/5fCnnF23ZUpv0qRDmHTlrR6yA0AtXPMi3FuK5K+KFjNWQZB5mJntsOxS8Pm1u0s8ziWoeQw2r37+Me/HIxl3XgxR4kF3y3DhvCArqcZd+TXsi4bpWVUbTSne3QN9pquK2NsflaDJazTaGUXoTDw5FqEjjU2zuYKegJHRBDw6WC7STY0O4c1TLAlrG4mfSz/8Qw8kYBzblb0HSXdBLKCCxn0P8d6aqm9/j/gIVQKJRkMiVlEC3V3y4n8PzaD9mBz4h5KNSVPY3TwerwIV4dK9wOn2J489jvaUMgPG6ksWBRa0Vjh8eFWxGtM4aKjqcZVj6h9pFRxYkRbAg==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id kw13-20020a170902f90d00b001d752c4f180sm560989plb.94.2024.02.08.20.06.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 10/20] bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
Date: Thu,  8 Feb 2024 20:05:58 -0800
Message-Id: <20240209040608.98927-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
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
index 70d5351427e6..46a92e41b9d5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -718,6 +718,7 @@ enum bpf_arg_type {
 	 * on eBPF program stack
 	 */
 	ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value) */
+	ARG_PTR_TO_ARENA,
 
 	ARG_CONST_SIZE,		/* number of bytes accessed from memory */
 	ARG_CONST_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8e06d29961f1..857059c8d56c 100644
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
index 5eeb9bf7e324..fa49602194d5 100644
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
@@ -20329,6 +20341,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
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


