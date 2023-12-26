Return-Path: <bpf+bounces-18681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E6281E928
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC91F21CC9
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D096186A;
	Tue, 26 Dec 2023 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEwh3AKA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F8185E
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbb4806f67so902514b6e.3
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 11:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703617921; x=1704222721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XP2WrM7TZCbV5LRPVNBtVfGBE5koX1gCMYwvkMyB7g=;
        b=UEwh3AKAGyKZrV5hd6u2thJ6jXBIqCVDfVzRkVqX+fD1WecFQu/aQcNr9uGmTu7e9c
         toShDD1Ww2zpWoosn1nqZ82G4S60WlvVzP8T+rjCKsDVtNcJSfyXVBnKFfyZ3ddqguc9
         QxtMrNGJLzIBnTLbBGUZPstQcAqkXw0Du+FoQP+gUXUJtjMoAVm20e0bh7n5/hgtMXOy
         U1dj5PYjwD1cScKHmqH/8LIUY2NEZw7b7DyJmNkuWRD/8U5YP0y3JILylSv+SO02Fgrd
         TTyXK2jV0NmW6F66hLTRZSmHMbXDjZMm1La2Kp22itJuV7luZXXk33710LOrZcMPCBqm
         C5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617921; x=1704222721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XP2WrM7TZCbV5LRPVNBtVfGBE5koX1gCMYwvkMyB7g=;
        b=bGw12WHJrI73ZNjgLa6uqgAyChbZMJYPtpzGYhTYc8aOilWkAi+AKQWrmLDF2Vp12v
         8Z+Lj1o8s7YekK4zJ8vItQrhwx9Lt5BxVXv49Sc51MTNWkU9f5aLIJNVJ2g2MfaBqS/J
         VOK/akvet2RMq2eW2+R9yr6OsevqshF0K8bOwYxw2b9ZfNTp2Zt3hLo/z5FILwOGW3ig
         5H2c4sqVLPj9auLXzFsNc1SEywQusYvdxtD/AbjIUI8MFQ9up+FI6E/GwIHHOWoLzLFE
         tlJTZKM3ib+t1gx6ddljZuYxpAshYUedVr1hecM/O3Od76wb+SeIe413g2F2vSSmq8XB
         ib4g==
X-Gm-Message-State: AOJu0YyRw/dYpoD5E89gXcpzcoFMVQbWaL/qb+gjiBVh1oJ12Y+F19Zg
	o5EVPze0c2FFgPUTlBtjdIun27a2NwU=
X-Google-Smtp-Source: AGHT+IE9+NwpEqmCO/XkS9MCNBFgQUQhNQfOEHvwYUw51fTQnml5oQOsR1IyDvpifjmoiIKSt08sVg==
X-Received: by 2002:a05:6808:1512:b0:3bb:8144:120d with SMTP id u18-20020a056808151200b003bb8144120dmr9796367oiw.23.1703617920631;
        Tue, 26 Dec 2023 11:12:00 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:bc9b])
        by smtp.gmail.com with ESMTPSA id v22-20020a056a00149600b006d9b65d1a8esm4362860pfu.28.2023.12.26.11.11.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Dec 2023 11:12:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 2/6] bpf: Introduce "volatile compare" macros
Date: Tue, 26 Dec 2023 11:11:44 -0800
Message-Id: <20231226191148.48536-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
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
Introduce bpf_cmp_likely/unlikely(var1, conditional_op, var2) macros that can be used as:

-               if (seen >= 1000)
+               if (bpf_cmp_unlikely(seen, >=, 1000))

The macros take advantage of BPF assembly that is C like.

The macros check the sign of variable 'seen' and emits either
signed or unsigned compare.

For example:
int a;
bpf_cmp_unlikely(a, >, 0) will be translated to 'if rX s> 0 goto' in BPF assembly.

unsigned int a;
bpf_cmp_unlikely(a, >, 0) will be translated to 'if rX > 0 goto' in BPF assembly.

C type conversions coupled with comparison operator are tricky.
  int i = -1;
  unsigned int j = 1;
  if (i < j) // this is false.

  long i = -1;
  unsigned int j = 1;
  if (i < j) // this is true.

Make sure BPF program is compiled with -Wsign-compare then the macros will catch
the mistake.

The macros check LHS (left hand side) only to figure out the sign of compare.

'if 0 < rX goto' is not allowed in the assembly, so the users
have to use a variable on LHS anyway.

The patch updates few tests to demonstrate the use of the macros.

The macro allows to use BPF_JSET in C code, since LLVM doesn't generate it at
present. For example:

if (i & j) compiles into r0 &= r1; if r0 == 0 goto

while

if (bpf_cmp_unlikely(i, &, j)) compiles into if r0 & r1 goto

Note that the macros has to be careful with RHS assembly predicate.
Since:
u64 __rhs = 1ull << 42;
asm goto("if r0 < %[rhs] goto +1" :: [rhs] "ri" (__rhs));
LLVM will silently truncate 64-bit constant into s32 imm.

Note that [lhs] "r"((short)LHS) the type cast is a workaround for LLVM issue.
When LHS is exactly 32-bit LLVM emits redundant <<=32, >>=32 to zero upper 32-bits.
When LHS is 64 or 16 or 8-bit variable there are no shifts.
When LHS is 32-bit the (u64) cast doesn't help. Hence use (short) cast.
It does _not_ truncate the variable before it's assigned to a register.

Traditional likely()/unlikely() macros that use __builtin_expect(!!(x), 1 or 0)
have no effect on these macros, hence macros implement the logic manually.
bpf_cmp_unlikely() macro preserves compare operator as-is while
bpf_cmp_likely() macro flips the compare.

Consider two cases:
A.
  for() {
    if (foo >= 10) {
      bar += foo;
    }
    other code;
  }

B.
  for() {
    if (foo >= 10)
       break;
    other code;
  }

It's ok to use either bpf_cmp_likely or bpf_cmp_unlikely macros in both cases,
but consider that 'break' is effectively 'goto out_of_the_loop'.
Hence it's better to use bpf_cmp_unlikely in the B case.
While 'bar += foo' is better to keep as 'fallthrough' == likely code path in the A case.

When it's written as:
A.
  for() {
    if (bpf_cmp_likely(foo, >=, 10)) {
      bar += foo;
    }
    other code;
  }

B.
  for() {
    if (bpf_cmp_unlikely(foo, >=, 10))
       break;
    other code;
  }

The assembly will look like:
A.
  for() {
    if r1 < 10 goto L1;
      bar += foo;
  L1:
    other code;
  }

B.
  for() {
    if r1 >= 10 goto L2;
    other code;
  }
  L2:

The bpf_cmp_likely vs bpf_cmp_unlikely changes basic block layout, hence it will
greatly influence the verification process. The number of processed instructions
will be different, since the verifier walks the fallthrough first.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 69 +++++++++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 20 +++---
 .../selftests/bpf/progs/iters_task_vma.c      |  3 +-
 3 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 1386baf9ae4a..789abf316ad4 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -254,6 +254,75 @@ extern void bpf_throw(u64 cookie) __ksym;
 		}									\
 	 })
 
+#define __cmp_cannot_be_signed(x) \
+	__builtin_strcmp(#x, "==") == 0 || __builtin_strcmp(#x, "!=") == 0 || \
+	__builtin_strcmp(#x, "&") == 0
+
+#define __is_signed_type(type) (((type)(-1)) < (type)1)
+
+#define __bpf_cmp(LHS, OP, SIGN, PRED, RHS, DEFAULT) \
+	({ \
+		__label__ l_true; \
+		bool ret = DEFAULT; \
+		asm volatile goto("if %[lhs] " SIGN #OP " %[rhs] goto %l[l_true]" \
+				  :: [lhs] "r"((short)LHS), [rhs] PRED (RHS) :: l_true); \
+		ret = !DEFAULT; \
+l_true:\
+		ret;\
+       })
+
+/* C type conversions coupled with comparison operator are tricky.
+ * Make sure BPF program is compiled with -Wsign-compre then
+ * __lhs OP __rhs below will catch the mistake.
+ * Be aware that we check only __lhs to figure out the sign of compare.
+ */
+#define _bpf_cmp(LHS, OP, RHS, NOFLIP) \
+	({ \
+		typeof(LHS) __lhs = (LHS); \
+		typeof(RHS) __rhs = (RHS); \
+		bool ret; \
+		_Static_assert(sizeof(&(LHS)), "1st argument must be an lvalue expression"); \
+		(void)(__lhs OP __rhs); \
+		if (__cmp_cannot_be_signed(OP) || !__is_signed_type(typeof(__lhs))) {\
+			if (sizeof(__rhs) == 8) \
+				ret = __bpf_cmp(__lhs, OP, "", "r", __rhs, NOFLIP); \
+			else \
+				ret = __bpf_cmp(__lhs, OP, "", "i", __rhs, NOFLIP); \
+		} else { \
+			if (sizeof(__rhs) == 8) \
+				ret = __bpf_cmp(__lhs, OP, "s", "r", __rhs, NOFLIP); \
+			else \
+				ret = __bpf_cmp(__lhs, OP, "s", "i", __rhs, NOFLIP); \
+		} \
+		ret; \
+       })
+
+#ifndef bpf_cmp_unlikely
+#define bpf_cmp_unlikely(LHS, OP, RHS) _bpf_cmp(LHS, OP, RHS, true)
+#endif
+
+#ifndef bpf_cmp_likely
+#define bpf_cmp_likely(LHS, OP, RHS) \
+	({ \
+		bool ret; \
+		if (__builtin_strcmp(#OP, "==") == 0) \
+			ret = _bpf_cmp(LHS, !=, RHS, false); \
+		else if (__builtin_strcmp(#OP, "!=") == 0) \
+			ret = _bpf_cmp(LHS, ==, RHS, false); \
+		else if (__builtin_strcmp(#OP, "<=") == 0) \
+			ret = _bpf_cmp(LHS, >, RHS, false); \
+		else if (__builtin_strcmp(#OP, "<") == 0) \
+			ret = _bpf_cmp(LHS, >=, RHS, false); \
+		else if (__builtin_strcmp(#OP, ">") == 0) \
+			ret = _bpf_cmp(LHS, <=, RHS, false); \
+		else if (__builtin_strcmp(#OP, ">=") == 0) \
+			ret = _bpf_cmp(LHS, <, RHS, false); \
+		else \
+			(void) "bug"; \
+		ret; \
+       })
+#endif
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
index 2811ee842b01..f09cd14d8e04 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -210,7 +210,7 @@ __noinline int assert_zero_gfunc(u64 c)
 {
 	volatile u64 cookie = c;
 
-	bpf_assert_eq(cookie, 0);
+	bpf_assert(bpf_cmp_unlikely(cookie, ==, 0));
 	return 0;
 }
 
@@ -218,7 +218,7 @@ __noinline int assert_neg_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_lt(cookie, 0);
+	bpf_assert(bpf_cmp_unlikely(cookie, <, 0));
 	return 0;
 }
 
@@ -226,7 +226,7 @@ __noinline int assert_pos_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_gt(cookie, 0);
+	bpf_assert(bpf_cmp_unlikely(cookie, >, 0));
 	return 0;
 }
 
@@ -234,7 +234,7 @@ __noinline int assert_negeq_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_le(cookie, -1);
+	bpf_assert(bpf_cmp_unlikely(cookie, <=, -1));
 	return 0;
 }
 
@@ -242,7 +242,7 @@ __noinline int assert_poseq_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_ge(cookie, 1);
+	bpf_assert(bpf_cmp_unlikely(cookie, >=, 1));
 	return 0;
 }
 
@@ -258,7 +258,7 @@ __noinline int assert_zero_gfunc_with(u64 c)
 {
 	volatile u64 cookie = c;
 
-	bpf_assert_eq_with(cookie, 0, cookie + 100);
+	bpf_assert_with(bpf_cmp_unlikely(cookie, ==, 0), cookie + 100);
 	return 0;
 }
 
@@ -266,7 +266,7 @@ __noinline int assert_neg_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_lt_with(cookie, 0, cookie + 100);
+	bpf_assert_with(bpf_cmp_unlikely(cookie, <, 0), cookie + 100);
 	return 0;
 }
 
@@ -274,7 +274,7 @@ __noinline int assert_pos_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_gt_with(cookie, 0, cookie + 100);
+	bpf_assert_with(bpf_cmp_unlikely(cookie, >, 0), cookie + 100);
 	return 0;
 }
 
@@ -282,7 +282,7 @@ __noinline int assert_negeq_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_le_with(cookie, -1, cookie + 100);
+	bpf_assert_with(bpf_cmp_unlikely(cookie, <=, -1), cookie + 100);
 	return 0;
 }
 
@@ -290,7 +290,7 @@ __noinline int assert_poseq_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_ge_with(cookie, 1, cookie + 100);
+	bpf_assert_with(bpf_cmp_unlikely(cookie, >=, 1), cookie + 100);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/testing/selftests/bpf/progs/iters_task_vma.c
index e085a51d153e..dc0c3691dcc2 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
@@ -28,9 +28,8 @@ int iter_task_vma_for_each(const void *ctx)
 		return 0;
 
 	bpf_for_each(task_vma, vma, task, 0) {
-		if (seen >= 1000)
+		if (bpf_cmp_unlikely(seen, >=, 1000))
 			break;
-		barrier_var(seen);
 
 		vm_ranges[seen].vm_start = vma->vm_start;
 		vm_ranges[seen].vm_end = vma->vm_end;
-- 
2.34.1


