Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6768DFEC
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjBGSX1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 13:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjBGSWs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 13:22:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1A3EC6B
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 10:22:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso13848672wms.0
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBlMmyhPG63Pvz4tbDgUIXvpdQEk55YVINwq7a2FyW4=;
        b=Yr4NbQJKN4Nx+k35zGr92vmBv6LJNG2wHEb4dlxgN+QFxIabAKjvMCLZ1uUais0bMK
         dNVFdpzXH0yGuFiwLbM9xlOUeyZnsG0dD60aAO0ZO4TzJAFcJly8OvXRPxUFAVrYWFz1
         qzFFueM9+ceHN89VHoLUxs0qQSpATd9h8a2Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBlMmyhPG63Pvz4tbDgUIXvpdQEk55YVINwq7a2FyW4=;
        b=b1pro7gd8S+OVs6Rf4FY0ooW+WIHyxGElIUf7Zdef2T3cK7MGc+0X8nJP2eM98vvUQ
         iy7FHnFCVD5TQ2OHjPABwAxLseJAdjbArF+uTCUoG/jQyKqpSE+2LcrFqZkxPLcz4c2t
         G5lumd1CBMp4NLcHbHZ3Mu4bRQPx4tDGSm6nNqdIh7bYEF5jjbc8USFf1T/jNPaOMdg+
         25XxcUZgNis04siQHm//VKq79zJxWg9WtigvjiFtrKHurM+Hfl4UQLnw5HSYvj+HccHq
         O0fU5qSE/lrZtTwkVnz8iA4/AdCQvIxbtr5n7VoCOskBG2/tXjyWyCR4nZGaHwbiQ551
         AXkA==
X-Gm-Message-State: AO0yUKWpwU0g7vzKNLFvBb93XF7MIoUdh/OiEHXypM61quYgOJOQ/H0/
        uB0IyqKyGrvQ4BCEi8Fg/TGddw==
X-Google-Smtp-Source: AK7set9Gf/TXJwIQxles6vw8IIkk1NLDMuEyWjEgs1Kk2ZhMGTWDfO+Axy3lfWS9rFYTFHPw929Lrw==
X-Received: by 2002:a05:600c:1716:b0:3dd:1ac2:989 with SMTP id c22-20020a05600c171600b003dd1ac20989mr2392196wmn.39.1675794134367;
        Tue, 07 Feb 2023 10:22:14 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5307:c0c0:ff97:80de])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003daf672a616sm15578369wmq.22.2023.02.07.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:22:13 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 09/10] arm64: ftrace: Add direct call trampoline samples support
Date:   Tue,  7 Feb 2023 19:21:34 +0100
Message-Id: <20230207182135.2671106-10-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207182135.2671106-1-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The ftrace samples need per-architecture trampoline implementations
to save and restore argument registers around the calls to
my_direct_func* and to restore polluted registers (eg: x30).

These samples also include <asm/nospec-branch.h> which does not exist on
arm64 and <asm/asm-offsets.h> which, on arm64, is not necessary and
redefines previously defined macros (resulting in warnings) so these
includes are guarded by !CONFIG_ARM64.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 arch/arm64/Kconfig                          |  2 ++
 samples/ftrace/ftrace-direct-modify.c       | 32 ++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 36 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 22 +++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 25 ++++++++++++++
 samples/ftrace/ftrace-direct.c              | 23 +++++++++++++
 6 files changed, 140 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7deafd653c42..5480ef8eaa2a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -194,6 +194,8 @@ config ARM64
 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 150c06b489ee..0178554c55f2 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,8 +2,10 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
 #include <asm/nospec-branch.h>
+#endif
 
 extern void my_direct_func1(void);
 extern void my_direct_func2(void);
@@ -96,6 +98,36 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	sub	sp, sp, #16\n"
+"	stp	x9, x30, [sp]\n"
+"	bl	my_direct_func1\n"
+"	ldp	x30, x9, [sp]\n"
+"	add	sp, sp, #16\n"
+"	ret	x9\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	sub	sp, sp, #16\n"
+"	stp	x9, x30, [sp]\n"
+"	bl	my_direct_func2\n"
+"	ldp	x30, x9, [sp]\n"
+"	add	sp, sp, #16\n"
+"	ret	x9\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 static struct ftrace_ops direct;
 
 static unsigned long my_tramp = (unsigned long)my_tramp1;
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 407c56325e65..ae1f97271d1a 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -2,8 +2,10 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
 #include <asm/nospec-branch.h>
+#endif
 
 extern void my_direct_func1(unsigned long ip);
 extern void my_direct_func2(unsigned long ip);
@@ -103,6 +105,40 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	sub	sp, sp, #32\n"
+"	stp	x9, x30, [sp]\n"
+"	str	x0, [sp, #16]\n"
+"	bl	my_direct_func1\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldr	x0, [sp, #16]\n"
+"	add	sp, sp, #32\n"
+"	ret	x9\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	sub	sp, sp, #32\n"
+"	stp	x9, x30, [sp]\n"
+"	str	x0, [sp, #16]\n"
+"	bl	my_direct_func2\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldr	x0, [sp, #16]\n"
+"	add	sp, sp, #32\n"
+"	ret	x9\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 46cf1873fda7..52bf238fcd7e 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -4,8 +4,10 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
 #include <asm/nospec-branch.h>
+#endif
 
 extern void my_direct_func(unsigned long ip);
 
@@ -66,6 +68,26 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	sub	sp, sp, #32\n"
+"	stp	x9, x30, [sp]\n"
+"	str	x0, [sp, #16]\n"
+"	bl	my_direct_func\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldr	x0, [sp, #16]\n"
+"	add	sp, sp, #32\n"
+"	ret	x9\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_multi_init(void)
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 7ee5dd3cc61d..f46ee08caa2b 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,8 +3,10 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
 #include <asm/nospec-branch.h>
+#endif
 
 extern void my_direct_func(struct vm_area_struct *vma,
 			   unsigned long address, unsigned int flags);
@@ -70,6 +72,29 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	sub	sp, sp, #48\n"
+"	stp	x9, x30, [sp]\n"
+"	stp	x0, x1, [sp, #16]\n"
+"	str	x2, [sp, #32]\n"
+"	bl	my_direct_func\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldp	x0, x1, [sp, #16]\n"
+"	ldr	x2, [sp, #32]\n"
+"	add	sp, sp, #48\n"
+"	ret	x9\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_init(void)
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 5ffce87fa83e..e37e8d9e855c 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,8 +3,10 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
 #include <asm/nospec-branch.h>
+#endif
 
 extern void my_direct_func(struct task_struct *p);
 
@@ -63,6 +65,27 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	sub	sp, sp, #32\n"
+"	stp	x9, x30, [sp]\n"
+"	str	x0, [sp, #16]\n"
+"	bl	my_direct_func\n"
+"	ldp	x30, x9, [sp]\n"
+"	ldr	x0, [sp, #16]\n"
+"	add	sp, sp, #32\n"
+"	ret	x9\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_ARM64 */
+
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_init(void)
-- 
2.39.1.519.gcb327c4b5f-goog

