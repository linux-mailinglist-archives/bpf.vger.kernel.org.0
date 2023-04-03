Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64096D4397
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 13:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjDCLgV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjDCLgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 07:36:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B411E8A
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 04:36:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so17879282wms.2
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680521762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqkYcLKOg4k24u7taA4ybtC6/VdL9Lx3veM4EqCfkEc=;
        b=KOe24HbbEOmLwhwfaHokbQTaD8n2ehhSaHyTE+CKY+SK0ovO3S1c2OPwopQN+nVwVV
         LO3FuHyPojbILBaPrO+w4rjiUC7uCwVTWkhG9KWGCHqCxZlQjq8G4rAaM9iiKPThJH2/
         LShE8g1csoNQMVG7//KQV68lY1+hqHNED+NR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqkYcLKOg4k24u7taA4ybtC6/VdL9Lx3veM4EqCfkEc=;
        b=IrBxHuFTQ7MXWLu0mKWmgTccK2vWKCJivl/lj/uFpicrZusQFyaohuJsRYFVL/+mh2
         jyegeoXLD3hShbPYdx5TqH/D5qiXvwDvCq5Lpvz+KGfz87m3ql+rO2DZzq7PnFdGs9Qg
         FhCNVGLPMUt7XkRE6cIUGz2H9PXt2Mzdut0JhW9sfFF4+0teyjOsR7YQNXtSY9CWQfID
         igKBSIW0N5aOZiYXIWQU11Q2u0N/Voj5bfJfotOttdP8KkRzETf2grsc+bDb++LcPBGA
         vWiKvb6r10SlJ+szG3+SAkDJh/DNUtYitdqJ749Jb/CkJrAB19bq2ZPjan0ciMrBW6Pw
         M7cw==
X-Gm-Message-State: AO0yUKW/KPhs+afaRFQaVvzECEJHGRPFBsT3tvrr+hcE0xfBZ/Dgjynf
        fHCH56Y8Tney1FGf+hXGbnpeQg==
X-Google-Smtp-Source: AK7set9SvK3cpuSZaNLawGVS1oDxyt+xXWc4bFWeP95BuDxYog5VP02Y24KxDJ7u4WNtYsxrBgMkXQ==
X-Received: by 2002:a7b:cc98:0:b0:3eb:3945:d405 with SMTP id p24-20020a7bcc98000000b003eb3945d405mr26200954wma.38.1680521762532;
        Mon, 03 Apr 2023 04:36:02 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:b5a2:4ffd:8524:ac1])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b003eb2e33f327sm29841410wmo.2.2023.04.03.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:36:02 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v5 3/4] arm64: ftrace: Add direct call trampoline samples support
Date:   Mon,  3 Apr 2023 13:35:51 +0200
Message-Id: <20230403113552.2857693-4-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
In-Reply-To: <20230403113552.2857693-1-revest@chromium.org>
References: <20230403113552.2857693-1-revest@chromium.org>
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
 samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 38 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 23 +++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 26 ++++++++++++++
 samples/ftrace/ftrace-direct.c              | 24 +++++++++++++
 6 files changed, 147 insertions(+)

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
index 25fba66f61c0..98d1b7385f08 100644
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
@@ -96,6 +98,38 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	bti	c\n"
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
+"	bti	c\n"
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
index f72623899602..e39108eb085d 100644
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
@@ -103,6 +105,42 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	bti	c\n"
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
+"	bti	c\n"
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
index 1547c2c6be02..5a395d2d2e07 100644
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
 
@@ -66,6 +68,27 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	bti	c\n"
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
index f28e7b99840f..6e93c45fea86 100644
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
@@ -70,6 +72,30 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	bti	c\n"
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
index d81a9473b585..e5312f9c15d3 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,7 +3,9 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#ifndef CONFIG_ARM64
 #include <asm/asm-offsets.h>
+#endif
 
 extern void my_direct_func(struct task_struct *p);
 
@@ -63,6 +65,28 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+#ifdef CONFIG_ARM64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	bti	c\n"
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

