Return-Path: <bpf+bounces-37835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC0895B0BA
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4F61F225D6
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD22170A13;
	Thu, 22 Aug 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwDPO/qx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8316F8E9
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316092; cv=none; b=V8SDNw5Wo9TBV71KyW+33GYts7BfQCfpI0Jk/tUrvpMYwhVLSD10cVf7xX7QSTNefNLpXn8lLdMwKKmvixH23sR2Ymv+hQlvMx+UQMqaVzuyYPrbx+dQawhb/XniludzoHXq5C2dcnvWXwmvkjtfxiZaK5udlfvJO+wEaw6eF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316092; c=relaxed/simple;
	bh=hnd3Do08Llt25bMUJHeSN3tOab2iTxSrJbIUXCWGwFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW3JC7TZDsb/KGjWswU+3IsyH5LLa7rYzlFtplnJzOxVKnKX3b4xr0HjqHufgmHUooolb0xvvwCJ08Mw85+bZpMz388p8w0jWD90f6d34tS4S/FXnoiRmFlLac6cfCHLUq9Q8dizJ5l+C7MwcNOpGaJYlUa7BvL+bpgoRtv4OtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwDPO/qx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71423704ef3so466063b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316090; x=1724920890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8mdBEinJF/YGnCUK6Zz6XgYn6ajCQ7Sr3+ce1p+VbY=;
        b=gwDPO/qx5jwxkJWbFnZ6try4PG/7iFg7SAbVnG9UkjgI8k0A4KgzfTfQ6IsKUKCoep
         Uu6TI9IhXuLsbZv7bYpMBL/SDx1r9YIeUdpEnHS2YPfGTd+rd9QmalCGuXVJfR8TXJa/
         fQSArUWgTgarZFeQBuPXl9kiF+IbBdW4+4h0Qx46PPuE+dSH5RrJ71BwU0a2v9jLjEvG
         y9C4De8SHkqaT+YRJUjHWSh1uMBjJa13QzBYOZO9huOdQS2koulLzvTOfpjKcF4DNIc4
         1ndah0Nnj7oKc2Ca1LAUPt1/d86niaLm9XTRVx+WJBuomknkMTJnQX+9sehav1YEihaT
         0Bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316090; x=1724920890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8mdBEinJF/YGnCUK6Zz6XgYn6ajCQ7Sr3+ce1p+VbY=;
        b=VrRmbvqKLAtPOiuhv8t1pFTZQ69bKG2SOEvoYRv2MYN2riasix0vZs7BSIsJHPj+l7
         BZ2Z71PvE2otWKfjjwQn9wS1/75uviCK4og3HrcM+bC3Qf80suDzetLjZhxKNr11JkwM
         PEZzajhVxgfD48Vyi5/+wyxgub0nyrLBI7d92f1sKndCsNYND1g5Qtr0dQLr2Xe1tBcF
         cyjJWs3GENNLXP+mudrAYWY4J0Px2Dj48/HlEhwlQXUyuX5HvtbcgXkeXr7iiFFAof4+
         TdFq+D/YXN05itl4U7TiqI0VRMrcDxUIX2P+U8t8do2AtDeHxeAWn0WA2v4N9QtI7C7Z
         s7Ww==
X-Gm-Message-State: AOJu0YyTC5jt0eNXaDB8aFJ2Vv82k6vsnYNuYTxjbh74qT5W+/qh2VqT
	l7e4ckzyq14R2PC/ud542GSLfDxTbjx9HfgmNgueXVN3s15W6WEtOboL2ffP
X-Google-Smtp-Source: AGHT+IGm39PM8GLIKEO/h/JnccOr+zK7FjhYVktjHCVJmgmyJSV+s+jvF7PTzErlmbGQm1jYej+v2g==
X-Received: by 2002:a05:6a21:478a:b0:1c4:ba7c:741c with SMTP id adf61e73a8af0-1caeb1d90e2mr1363921637.21.1724316090020;
        Thu, 22 Aug 2024 01:41:30 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434340449sm881692b3a.218.2024.08.22.01.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:41:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/6] selftests/bpf: rename nocsr -> bpf_fastcall in selftests
Date: Thu, 22 Aug 2024 01:41:08 -0700
Message-ID: <20240822084112.3257995-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822084112.3257995-1-eddyz87@gmail.com>
References: <20240822084112.3257995-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attribute used by LLVM implementation of the feature had been changed
from no_caller_saved_registers to bpf_fastcall (see [1]).
This commit replaces references to nocsr by references to bpf_fastcall
to keep LLVM and selftests parts in sync.

[1] https://github.com/llvm/llvm-project/pull/105417

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  4 +--
 ...rifier_nocsr.c => verifier_bpf_fastcall.c} | 26 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)
 rename tools/testing/selftests/bpf/progs/{verifier_nocsr.c => verifier_bpf_fastcall.c} (95%)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index cf3662dbd24f..80a90c627182 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -53,7 +53,7 @@
 #include "verifier_movsx.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
-#include "verifier_nocsr.skel.h"
+#include "verifier_bpf_fastcall.skel.h"
 #include "verifier_or_jmp32_k.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
@@ -177,7 +177,7 @@ void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
-void test_verifier_nocsr(void)                { RUN(verifier_nocsr); }
+void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_nocsr.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
similarity index 95%
rename from tools/testing/selftests/bpf/progs/verifier_nocsr.c
rename to tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 666c736d196f..e30ab9fe5096 100644
--- a/tools/testing/selftests/bpf/progs/verifier_nocsr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -39,7 +39,7 @@ __naked void simple(void)
 	: __clobber_all);
 }
 
-/* The logic for detecting and verifying nocsr pattern is the same for
+/* The logic for detecting and verifying bpf_fastcall pattern is the same for
  * any arch, however x86 differs from arm64 or riscv64 in a way
  * bpf_get_smp_processor_id is rewritten:
  * - on x86 it is done by verifier
@@ -52,7 +52,7 @@ __naked void simple(void)
  *
  * It is really desirable to check instruction indexes in the xlated
  * patterns, so add this canary test to check that function rewrite by
- * jit is correctly processed by nocsr logic, keep the rest of the
+ * jit is correctly processed by bpf_fastcall logic, keep the rest of the
  * tests as x86.
  */
 SEC("raw_tp")
@@ -463,7 +463,7 @@ __naked static void bad_write_in_subprog_aux(void)
 {
 	asm volatile (
 	"r0 = 1;"
-	"*(u64 *)(r1 - 0) = r0;"	/* invalidates nocsr contract for caller: */
+	"*(u64 *)(r1 - 0) = r0;"	/* invalidates bpf_fastcall contract for caller: */
 	"exit;"				/* caller stack at -8 used outside of the pattern */
 	::: __clobber_all);
 }
@@ -480,7 +480,7 @@ __naked void bad_helper_write(void)
 {
 	asm volatile (
 	"r1 = 1;"
-	/* nocsr pattern with stack offset -8 */
+	/* bpf_fastcall pattern with stack offset -8 */
 	"*(u64 *)(r10 - 8) = r1;"
 	"call %[bpf_get_smp_processor_id];"
 	"r1 = *(u64 *)(r10 - 8);"
@@ -488,7 +488,7 @@ __naked void bad_helper_write(void)
 	"r1 += -8;"
 	"r2 = 1;"
 	"r3 = 42;"
-	/* read dst is fp[-8], thus nocsr rewrite not applied */
+	/* read dst is fp[-8], thus bpf_fastcall rewrite not applied */
 	"call %[bpf_probe_read_kernel];"
 	"exit;"
 	:
@@ -598,7 +598,7 @@ __arch_x86_64
 __log_level(4) __msg("stack depth 8")
 __xlated("2: r0 = &(void __percpu *)(r0)")
 __success
-__naked void helper_call_does_not_prevent_nocsr(void)
+__naked void helper_call_does_not_prevent_bpf_fastcall(void)
 {
 	asm volatile (
 	"r1 = 1;"
@@ -689,7 +689,7 @@ __naked int bpf_loop_interaction1(void)
 {
 	asm volatile (
 	"r1 = 1;"
-	/* nocsr stack region at -16, but could be removed */
+	/* bpf_fastcall stack region at -16, but could be removed */
 	"*(u64 *)(r10 - 16) = r1;"
 	"call %[bpf_get_smp_processor_id];"
 	"r1 = *(u64 *)(r10 - 16);"
@@ -729,7 +729,7 @@ __naked int bpf_loop_interaction2(void)
 {
 	asm volatile (
 	"r1 = 42;"
-	/* nocsr stack region at -16, cannot be removed */
+	/* bpf_fastcall stack region at -16, cannot be removed */
 	"*(u64 *)(r10 - 16) = r1;"
 	"call %[bpf_get_smp_processor_id];"
 	"r1 = *(u64 *)(r10 - 16);"
@@ -759,8 +759,8 @@ __msg("stack depth 512+0")
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
 /* cumulative_stack_depth() stack usage is MAX_BPF_STACK,
- * called subprogram uses an additional slot for nocsr spill/fill,
- * since nocsr spill/fill could be removed the program still fits
+ * called subprogram uses an additional slot for bpf_fastcall spill/fill,
+ * since bpf_fastcall spill/fill could be removed the program still fits
  * in MAX_BPF_STACK and should be accepted.
  */
 __naked int cumulative_stack_depth(void)
@@ -798,7 +798,7 @@ __xlated("3: r0 = &(void __percpu *)(r0)")
 __xlated("4: r0 = *(u32 *)(r0 +0)")
 __xlated("5: exit")
 __success
-__naked int nocsr_max_stack_ok(void)
+__naked int bpf_fastcall_max_stack_ok(void)
 {
 	asm volatile(
 	"r1 = 42;"
@@ -820,7 +820,7 @@ __arch_x86_64
 __log_level(4)
 __msg("stack depth 520")
 __failure
-__naked int nocsr_max_stack_fail(void)
+__naked int bpf_fastcall_max_stack_fail(void)
 {
 	asm volatile(
 	"r1 = 42;"
@@ -828,7 +828,7 @@ __naked int nocsr_max_stack_fail(void)
 	"*(u64 *)(r10 - %[max_bpf_stack_8]) = r1;"
 	"call %[bpf_get_smp_processor_id];"
 	"r1 = *(u64 *)(r10 - %[max_bpf_stack_8]);"
-	/* call to prandom blocks nocsr rewrite */
+	/* call to prandom blocks bpf_fastcall rewrite */
 	"*(u64 *)(r10 - %[max_bpf_stack_8]) = r1;"
 	"call %[bpf_get_prandom_u32];"
 	"r1 = *(u64 *)(r10 - %[max_bpf_stack_8]);"
-- 
2.45.2


