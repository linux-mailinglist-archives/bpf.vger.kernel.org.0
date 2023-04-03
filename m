Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2D6D4358
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjDCLVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjDCLVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 07:21:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE39B1165A
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 04:21:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r29so28914939wra.13
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680520886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq5x86tVtWv9CUhJrZoYIW4Kchuy5NaR+pC4E8FDtAo=;
        b=dKIh+gFbz3U1lN2WVs7SpMMcM4hKKGWQIiHX5vyplIj6iEX3sD/3dlBnaeT3tN/f1M
         BOQGBSIQrpAp1eRpdzKomeZ2rN4trB87k68rKOJGJboYXk1r2zevH9tw0O9GMCrpoqOs
         JpHjB2hT8+r8OG/DEjND6Ataf4Rltn5BWXcWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680520886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq5x86tVtWv9CUhJrZoYIW4Kchuy5NaR+pC4E8FDtAo=;
        b=1MmY1k8AJ4T4rvbKs7y/2ahDiQf/Lp9gR4sBi1gMCpWPVjhHwC2WdNmVFWMbl2v1O2
         80Fs5N8Yh+u87zGnv+WWUZomDybZT/wuIY2N7ZLQpwVCvqtCY3X94NTYPSgCSjibgV31
         xb9eK0JKSnTeVa/FnORiODInKXd5Xr9lblZ/zyuBajlqL9NpPEo792csH+fXt2Aux7/Z
         /G9iHD+RMuXOZr9Cu4nnz2OEfGRVu4yP5KN2tSOWkQwYL0dgA8jO1pI6zEEJVZoqUEPV
         oR34w/mxC6Dabe4aaVZBGEY+vmooPulYe27mjMpherqd1gdrQpg+T5dEZfYioSw3GUp7
         22gQ==
X-Gm-Message-State: AAQBX9dMmzE7lhhApsmEqKcMDCx7ZaaAv7yOjxaiN8b5J/VvfDudR4QA
        SicSydowfCEdjhhTWNthtlMAGg==
X-Google-Smtp-Source: AKy350bqXIWWAZ7kAZuV8YL1a1EGm9Vm2reN1PAKAhf6LZsCQUy5JwJbkErX9cYXTp6Da/MEnbhaYg==
X-Received: by 2002:a5d:4fd0:0:b0:2cc:459b:8bc8 with SMTP id h16-20020a5d4fd0000000b002cc459b8bc8mr25844059wrw.6.1680520885849;
        Mon, 03 Apr 2023 04:21:25 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:b5a2:4ffd:8524:ac1])
        by smtp.gmail.com with ESMTPSA id u13-20020adfeb4d000000b002daeb108304sm9510031wrn.33.2023.04.03.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:21:25 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v4 3/4] arm64: ftrace: Add direct call trampoline samples support
Date:   Mon,  3 Apr 2023 13:20:58 +0200
Message-Id: <20230403112059.2749695-4-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
In-Reply-To: <20230403112059.2749695-1-revest@chromium.org>
References: <20230403112059.2749695-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The ftrace samples need per-architecture trampoline implementations
to save and restore argument registers around the calls to
my_direct_func* and to restore polluted registers (eg: x30).

These samples also include <asm/asm-offsets.h> which, on arm64, is not
necessary and redefines previously defined macros (resulting in
warnings) so these includes are guarded by !CONFIG_ARM64.

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
index f3503d0cc1b8..c2bf28099abd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -194,6 +194,8 @@ config ARM64
 		    !CC_OPTIMIZE_FOR_SIZE)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 25fba66f61c0..32ed0e1f8699 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,7 +2,9 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
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
index f72623899602..0ba40891d43e 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -2,7 +2,9 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
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
index 1547c2c6be02..0b072e763c97 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -4,7 +4,9 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
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
index f28e7b99840f..5606b7ad1950 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,7 +3,9 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
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
index d81a9473b585..7e20529ef132 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,7 +3,9 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
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
2.40.0.423.gd6c402a77b-goog

