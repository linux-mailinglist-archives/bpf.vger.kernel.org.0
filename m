Return-Path: <bpf+bounces-18477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BA081AD96
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8466D1F24159
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18ED5239;
	Thu, 21 Dec 2023 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om6v06pV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF75249
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3ed1ca402so3170165ad.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703129945; x=1703734745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/kbRrld7FHDe+QEHKZXNmyEZAUBUZD3xfDckJcZ7nk=;
        b=Om6v06pV/7jDm46hyQ5t63KlfN0IzVRhmNuHDD3smSLF/haBpYAVWfHBzUMwhAXs9H
         A/yFxKPZbSsW8iotSIXCAdOLhoMNEu1e/BA5dP444qXTF6wv+g+bjyKCOi0u2yEwvUUX
         jP2BVoLHn5ue/XjC4G3B0YZWrIJJ1aC+khj4w3zfZxOa+X0afxuFgdTNnscoG3BaT5Ni
         nbkPnwGLLcGoiCIL7munCbVOz8BxoAe2+WKqgVB2Eja2HKw71kSSNh1GtN1Y7HMI90w0
         kPGNUL15cYrr5O9dBPRNulk2j/LvKg9bHH23tvQHFie/1JB1oD4oZNYtR3aulGy4qaJF
         H1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129945; x=1703734745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/kbRrld7FHDe+QEHKZXNmyEZAUBUZD3xfDckJcZ7nk=;
        b=F0nTxmOnRZKExjsMkTT2VClRVXIvox50NEReo61iviQxCxLXMmghMxkpo3vPKuq4Em
         L+C2pUlmxSDUS6JAppxdvoZzOGdmy8mW8kmiIuaTrcrKofmcuav1a18yF2jlk4zTkx4X
         Uea5P7NEGM5VW3kZthDBp7762eDl1vAb6kP7droYaLP0LETMycAGoo8/MyTRfxiInKEI
         QAwO6R+8hQStEwNvjBjorjYu+c0GLMxKeBs5FQjciE4P7/GHpPSwaQh0p5sj7yYZMDKD
         J/PmpRdgOdTwPThb6kX7ykZ0Qg4wcexT/ulyOvfJzm9ap09EgWqYYlFdjriav+SfoMfK
         04QA==
X-Gm-Message-State: AOJu0YxZEniJ4boRv6edaOzghX06qQMq9IOGChr9ghhnbeoOm3z3Uc8a
	ZuL3PKFw4OkuEJ3kxv+hQiA=
X-Google-Smtp-Source: AGHT+IGjp1B+tRKiM1kiB9qnl9FoFrnsm9tFFxtixKuM3lSXin6OgBgsNYEgaRAGXPZyA3SN/iiVkg==
X-Received: by 2002:a17:902:ce91:b0:1d4:97a:7f5a with SMTP id f17-20020a170902ce9100b001d4097a7f5amr53531plg.95.1703129945326;
        Wed, 20 Dec 2023 19:39:05 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:ec38])
        by smtp.gmail.com with ESMTPSA id pi15-20020a17090b1e4f00b0028be1aec1b6sm585088pjb.52.2023.12.20.19.39.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 19:39:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net
Cc: andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
Date: Wed, 20 Dec 2023 19:38:51 -0800
Message-Id: <20231221033854.38397-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Compilers optimize conditional operators at will, but often bpf programmers
want to force compilers to keep the same operator in asm as it's written in C.
Introduce bpf_cmp(var1, conditional_op, var2) macro that can be used as:

-               if (seen >= 1000)
+               if (bpf_cmp(seen, >=, 1000))

The macro takes advantage of BPF assembly that is C like.

The macro checks the sign of variable 'seen' and emits either
signed or unsigned compare.

For example:
int a;
bpf_cmp(a, >, 0) will be translated to 'if rX s> 0 goto' in BPF assembly.

unsigned int a;
bpf_cmp(a, >, 0) will be translated to 'if rX > 0 goto' in BPF assembly.

C type conversions coupled with comparison operator are tricky.
  int i = -1;
  unsigned int j = 1;
  if (i < j) // this is false.

  long i = -1;
  unsigned int j = 1;
  if (i < j) // this is true.

Make sure BPF program is compiled with -Wsign-compare then the macro will catch
the mistake.

The macro checks LHS (left hand side) only to figure out the sign of compare.

'if 0 < rX goto' is not allowed in the assembly, so the users
have to use a variable on LHS anyway.

The patch updates few tests to demonstrate the use of the macro.

The macro allows to use BPF_JSET in C code, since LLVM doesn't generate it at
present. For example:

if (i & j) compiles into r0 &= r1; if r0 == 0 goto

while

if (bpf_cmp(i, &, j)) compiles into if r0 & r1 goto

Note that the macro has to be careful with RHS assembly predicate.
Since:
u64 __rhs = 1ull << 42;
asm goto("if r0 < %[rhs] goto +1" :: [rhs] "ri" (__rhs));
LLVM will silently truncate 64-bit constant into s32 imm.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 44 +++++++++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 20 ++++-----
 .../selftests/bpf/progs/iters_task_vma.c      |  3 +-
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 1386baf9ae4a..b78a9449793d 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -254,6 +254,50 @@ extern void bpf_throw(u64 cookie) __ksym;
 		}									\
 	 })
 
+#define __cmp_cannot_be_signed(x) \
+	__builtin_strcmp(#x, "==") == 0 || __builtin_strcmp(#x, "!=") == 0 || \
+	__builtin_strcmp(#x, "&") == 0
+
+#define __is_signed_type(type) (((type)(-1)) < (type)1)
+
+#define __bpf_cmp(LHS, OP, SIGN, PRED, RHS) \
+	({ \
+		__label__ l_true; \
+		bool ret = true; \
+		asm volatile goto("if %[lhs] " SIGN #OP " %[rhs] goto %l[l_true]" \
+				  :: [lhs] "r"(LHS), [rhs] PRED (RHS) :: l_true); \
+		ret = false; \
+l_true:\
+		ret;\
+       })
+
+/* C type conversions coupled with comparison operator are tricky.
+ * Make sure BPF program is compiled with -Wsign-compre then
+ * __lhs OP __rhs below will catch the mistake.
+ * Be aware that we check only __lhs to figure out the sign of compare.
+ */
+#ifndef bpf_cmp
+#define bpf_cmp(LHS, OP, RHS) \
+	({ \
+		typeof(LHS) __lhs = (LHS); \
+		typeof(RHS) __rhs = (RHS); \
+		bool ret; \
+		(void)(__lhs OP __rhs); \
+		if (__cmp_cannot_be_signed(OP) || !__is_signed_type(typeof(__lhs))) {\
+			if (sizeof(__rhs) == 8) \
+				ret = __bpf_cmp(__lhs, OP, "", "r", __rhs); \
+			else \
+				ret = __bpf_cmp(__lhs, OP, "", "i", __rhs); \
+		} else { \
+			if (sizeof(__rhs) == 8) \
+				ret = __bpf_cmp(__lhs, OP, "s", "r", __rhs); \
+			else \
+				ret = __bpf_cmp(__lhs, OP, "s", "i", __rhs); \
+		} \
+		ret; \
+       })
+#endif
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
index 2811ee842b01..7acb859f57c7 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -210,7 +210,7 @@ __noinline int assert_zero_gfunc(u64 c)
 {
 	volatile u64 cookie = c;
 
-	bpf_assert_eq(cookie, 0);
+	bpf_assert(bpf_cmp(cookie, ==, 0));
 	return 0;
 }
 
@@ -218,7 +218,7 @@ __noinline int assert_neg_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_lt(cookie, 0);
+	bpf_assert(bpf_cmp(cookie, <, 0));
 	return 0;
 }
 
@@ -226,7 +226,7 @@ __noinline int assert_pos_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_gt(cookie, 0);
+	bpf_assert(bpf_cmp(cookie, >, 0));
 	return 0;
 }
 
@@ -234,7 +234,7 @@ __noinline int assert_negeq_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_le(cookie, -1);
+	bpf_assert(bpf_cmp(cookie, <=, -1));
 	return 0;
 }
 
@@ -242,7 +242,7 @@ __noinline int assert_poseq_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_ge(cookie, 1);
+	bpf_assert(bpf_cmp(cookie, >=, 1));
 	return 0;
 }
 
@@ -258,7 +258,7 @@ __noinline int assert_zero_gfunc_with(u64 c)
 {
 	volatile u64 cookie = c;
 
-	bpf_assert_eq_with(cookie, 0, cookie + 100);
+	bpf_assert_with(bpf_cmp(cookie, ==, 0), cookie + 100);
 	return 0;
 }
 
@@ -266,7 +266,7 @@ __noinline int assert_neg_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_lt_with(cookie, 0, cookie + 100);
+	bpf_assert_with(bpf_cmp(cookie, <, 0), cookie + 100);
 	return 0;
 }
 
@@ -274,7 +274,7 @@ __noinline int assert_pos_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_gt_with(cookie, 0, cookie + 100);
+	bpf_assert_with(bpf_cmp(cookie, >, 0), cookie + 100);
 	return 0;
 }
 
@@ -282,7 +282,7 @@ __noinline int assert_negeq_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_le_with(cookie, -1, cookie + 100);
+	bpf_assert_with(bpf_cmp(cookie, <=, -1), cookie + 100);
 	return 0;
 }
 
@@ -290,7 +290,7 @@ __noinline int assert_poseq_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_ge_with(cookie, 1, cookie + 100);
+	bpf_assert_with(bpf_cmp(cookie, >=, 1), cookie + 100);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/testing/selftests/bpf/progs/iters_task_vma.c
index e085a51d153e..7af9d6bca03b 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
@@ -28,9 +28,8 @@ int iter_task_vma_for_each(const void *ctx)
 		return 0;
 
 	bpf_for_each(task_vma, vma, task, 0) {
-		if (seen >= 1000)
+		if (bpf_cmp(seen, >=, 1000))
 			break;
-		barrier_var(seen);
 
 		vm_ranges[seen].vm_start = vma->vm_start;
 		vm_ranges[seen].vm_end = vma->vm_end;
-- 
2.34.1


