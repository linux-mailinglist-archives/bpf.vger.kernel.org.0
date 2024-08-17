Return-Path: <bpf+bounces-37404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A919A9554B2
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 03:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37061C214A1
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 01:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E88D79DE;
	Sat, 17 Aug 2024 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJYOJlAK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32E524C
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723859519; cv=none; b=pI+Q9ml2G2zQe1Tp5IfxQPkaZd16UR/yNxeRnL++vo5rpHM86DQ/mklyGflb6oMWSpNt2BRWlTzU9lRFtSjc/5LTMa1S88LJgFgX79rBSh9rTS85Pbpp/4nX62YqRswQC+IiWuS2uPKpeK7SxIPc0ALaygdSHa2AThkMeZQIfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723859519; c=relaxed/simple;
	bh=15c5tJW0vKA28ak9MDWPEmXEIXi9JdqAudWhKjA2Dto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zbng1Kg5VHi7Pb7eDdeOTlR2UxFi3jAYXmITwu4BrwmJk42k80iweBmlSNUBedmRG9MAIQWpnGwCBkK5F3jZTDk6YPm4JJrMXIQ/gcopRlgtHPTQOOm+7aFMTMVa7w4KqX9IeC4WMR16J/i4RiPKCqVhuLQSzVzpiT+TD0IqP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJYOJlAK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d316f0060so2550531b3a.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723859516; x=1724464316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IODrgDAejDtFPL/LVv/d5eyGJxF4MuTnupDjFeVMCPA=;
        b=gJYOJlAKhaxLFtwoER1mKhJ9yM0YExrJn/Bu5/n6USSxz2ws6km6rDJFb7tdmP4Cnh
         i/YAHdlwKxniLPIh5d30hsDpvafReToqh9oqUX6Vsl9N+Bbqccxru7ujoJd2eBJxZaSM
         IfptfVqBv3JCpJifnys5cos/Vn+KkG9liZVHsXq1mbAGzy8DKIsijywf1oOZDNqfrIW1
         OGY22BWfu/VRc9eVZvpoepIdkOdqQCAVHEURbIFooIPZTaCqfnSER+Fkcxiq9/ByrcWW
         pSdp8yCZkBy0RYacM2C9nVHHkTlTqs52zyHDzYtH/8w/eRpfOLP5ZuD9AOxO/MyY2xZd
         ZDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723859516; x=1724464316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IODrgDAejDtFPL/LVv/d5eyGJxF4MuTnupDjFeVMCPA=;
        b=XtvB9OOrIlmEAKa+ZdMWWyraxM4qN3HVpg8Hr4Tw5C1UFTof3M9iCDupdGyJi/NP6U
         LAbBaTSqYNg65BjWxHe0WKDIE87qLUIRZVW7AVRRWYia+Td1xrmDgYYRHMxJF8AkfWy0
         XGt5+q9OWmeK7IVVbNYB/N1gbXDzpXn7zXRwqyvS7LDo/WYx8DkntoSgpDiihzhtpq5Y
         3q2RKjlJ6r5CAx+fimfxk8Fep0ug9PwZg+zE2FQI1ts6BRuq0m4GjqGixEHEsJ9msE5y
         7Z/iGwT1D9pWvCyW2bJNfsclEU9aK0gBMSzwKawxtaORJJinZbO8dZhOmIubIFj0hcn+
         +xOw==
X-Gm-Message-State: AOJu0YzglkDnnrAPPYuM2/u8QMtNwipUDHfE6+HX5AMR78L9pn1/NGck
	Zklw0kH0So/y/9BlBlFCiE6sEBiLKUrvO9jU0z4KkILWDO+w0bxuq8lUzuTA37o=
X-Google-Smtp-Source: AGHT+IEjPC5ypXDK3XXhyI71pRYzeWH2NYIPkqQI3Y2FCkfiWnJU6/90rZ4yxBM3qYYiXQhXYv19VQ==
X-Received: by 2002:a05:6a00:9157:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-71277039617mr12368488b3a.12.1723859516012;
        Fri, 16 Aug 2024 18:51:56 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356ad2sm3598887a12.69.2024.08.16.18.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 18:51:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: rename nocsr -> bpf_fastcall in selftests
Date: Fri, 16 Aug 2024 18:51:37 -0700
Message-ID: <20240817015140.1039351-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240817015140.1039351-1-eddyz87@gmail.com>
References: <20240817015140.1039351-1-eddyz87@gmail.com>
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

[1] https://github.com/llvm/llvm-project/pull/101228

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  4 +--
 ...rifier_nocsr.c => verifier_bpf_fastcall.c} | 26 +++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)
 rename tools/testing/selftests/bpf/progs/{verifier_nocsr.c => verifier_bpf_fastcall.c} (95%)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f8f546eba488..c3b5a4164b92 100644
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
@@ -176,7 +176,7 @@ void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
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
index a7fe277e5167..f75cd5e3fffe 100644
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
@@ -430,7 +430,7 @@ __naked static void bad_write_in_subprog_aux(void)
 {
 	asm volatile (
 	"r0 = 1;"
-	"*(u64 *)(r1 - 0) = r0;"	/* invalidates nocsr contract for caller: */
+	"*(u64 *)(r1 - 0) = r0;"	/* invalidates bpf_fastcall contract for caller: */
 	"exit;"				/* caller stack at -8 used outside of the pattern */
 	::: __clobber_all);
 }
@@ -445,7 +445,7 @@ __naked void bad_helper_write(void)
 {
 	asm volatile (
 	"r1 = 1;"
-	/* nocsr pattern with stack offset -8 */
+	/* bpf_fastcall pattern with stack offset -8 */
 	"*(u64 *)(r10 - 8) = r1;"
 	"call %[bpf_get_smp_processor_id];"
 	"r1 = *(u64 *)(r10 - 8);"
@@ -453,7 +453,7 @@ __naked void bad_helper_write(void)
 	"r1 += -8;"
 	"r2 = 1;"
 	"r3 = 42;"
-	/* read dst is fp[-8], thus nocsr rewrite not applied */
+	/* read dst is fp[-8], thus bpf_fastcall rewrite not applied */
 	"call %[bpf_probe_read_kernel];"
 	"exit;"
 	:
@@ -553,7 +553,7 @@ __arch_x86_64
 __log_level(4) __msg("stack depth 8")
 __xlated("2: r0 = &(void __percpu *)(r0)")
 __success
-__naked void helper_call_does_not_prevent_nocsr(void)
+__naked void helper_call_does_not_prevent_bpf_fastcall(void)
 {
 	asm volatile (
 	"r1 = 1;"
@@ -640,7 +640,7 @@ __naked int bpf_loop_interaction1(void)
 {
 	asm volatile (
 	"r1 = 1;"
-	/* nocsr stack region at -16, but could be removed */
+	/* bpf_fastcall stack region at -16, but could be removed */
 	"*(u64 *)(r10 - 16) = r1;"
 	"call %[bpf_get_smp_processor_id];"
 	"r1 = *(u64 *)(r10 - 16);"
@@ -680,7 +680,7 @@ __naked int bpf_loop_interaction2(void)
 {
 	asm volatile (
 	"r1 = 42;"
-	/* nocsr stack region at -16, cannot be removed */
+	/* bpf_fastcall stack region at -16, cannot be removed */
 	"*(u64 *)(r10 - 16) = r1;"
 	"call %[bpf_get_smp_processor_id];"
 	"r1 = *(u64 *)(r10 - 16);"
@@ -710,8 +710,8 @@ __msg("stack depth 512+0")
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
@@ -749,7 +749,7 @@ __xlated("3: r0 = &(void __percpu *)(r0)")
 __xlated("4: r0 = *(u32 *)(r0 +0)")
 __xlated("5: exit")
 __success
-__naked int nocsr_max_stack_ok(void)
+__naked int bpf_fastcall_max_stack_ok(void)
 {
 	asm volatile(
 	"r1 = 42;"
@@ -771,7 +771,7 @@ __arch_x86_64
 __log_level(4)
 __msg("stack depth 520")
 __failure
-__naked int nocsr_max_stack_fail(void)
+__naked int bpf_fastcall_max_stack_fail(void)
 {
 	asm volatile(
 	"r1 = 42;"
@@ -779,7 +779,7 @@ __naked int nocsr_max_stack_fail(void)
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


