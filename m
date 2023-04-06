Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA836D946D
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjDFKuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 06:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjDFKuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 06:50:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B126E4C05;
        Thu,  6 Apr 2023 03:50:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A43CA16F8;
        Thu,  6 Apr 2023 03:51:01 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.171])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0BC3F73F;
        Thu,  6 Apr 2023 03:50:14 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:50:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v6 4/5] arm64: ftrace: Add direct call trampoline samples
 support
Message-ID: <ZC6j5GCvWuSG9vYe@FVFF77S0Q05N>
References: <20230405180250.2046566-1-revest@chromium.org>
 <20230405180250.2046566-5-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405180250.2046566-5-revest@chromium.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 05, 2023 at 08:02:49PM +0200, Florent Revest wrote:
> The ftrace samples need per-architecture trampoline implementations
> to save and restore argument registers around the calls to
> my_direct_func* and to restore polluted registers (eg: x30).
> 
> These samples also include <asm/asm-offsets.h> which, on arm64, is not
> necessary and redefines previously defined macros (resulting in
> warnings) so these includes are guarded by !CONFIG_ARM64.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>

These all look good to me. I gave each module a spin in an 8-vCPU VM on an M1
Macbook Pro with a bunch of other work going on, and all of those worked as
expected with sensible output in /sys/kernel/tracing/trace, and no noticeable
failures elsewhere. So:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/Kconfig                          |  2 ++
>  samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi.c        | 24 +++++++++++++
>  samples/ftrace/ftrace-direct-too.c          | 26 ++++++++++++++
>  samples/ftrace/ftrace-direct.c              | 24 +++++++++++++
>  6 files changed, 150 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f3503d0cc1b8..c2bf28099abd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -194,6 +194,8 @@ config ARM64
>  		    !CC_OPTIMIZE_FOR_SIZE)
>  	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
>  		if DYNAMIC_FTRACE_WITH_ARGS
> +	select HAVE_SAMPLE_FTRACE_DIRECT
> +	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_FAST_GUP
>  	select HAVE_FTRACE_MCOUNT_RECORD
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index 25fba66f61c0..98d1b7385f08 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -2,7 +2,9 @@
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/ftrace.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>  
>  extern void my_direct_func1(void);
>  extern void my_direct_func2(void);
> @@ -96,6 +98,38 @@ asm (
>  
>  #endif /* CONFIG_S390 */
>  
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"	.pushsection    .text, \"ax\", @progbits\n"
> +"	.type		my_tramp1, @function\n"
> +"	.globl		my_tramp1\n"
> +"   my_tramp1:"
> +"	bti	c\n"
> +"	sub	sp, sp, #16\n"
> +"	stp	x9, x30, [sp]\n"
> +"	bl	my_direct_func1\n"
> +"	ldp	x30, x9, [sp]\n"
> +"	add	sp, sp, #16\n"
> +"	ret	x9\n"
> +"	.size		my_tramp1, .-my_tramp1\n"
> +
> +"	.type		my_tramp2, @function\n"
> +"	.globl		my_tramp2\n"
> +"   my_tramp2:"
> +"	bti	c\n"
> +"	sub	sp, sp, #16\n"
> +"	stp	x9, x30, [sp]\n"
> +"	bl	my_direct_func2\n"
> +"	ldp	x30, x9, [sp]\n"
> +"	add	sp, sp, #16\n"
> +"	ret	x9\n"
> +"	.size		my_tramp2, .-my_tramp2\n"
> +"	.popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
> +
>  static struct ftrace_ops direct;
>  
>  static unsigned long my_tramp = (unsigned long)my_tramp1;
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> index f72623899602..26956c8fc513 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -2,7 +2,9 @@
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/ftrace.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>  
>  extern void my_direct_func1(unsigned long ip);
>  extern void my_direct_func2(unsigned long ip);
> @@ -103,6 +105,44 @@ asm (
>  
>  #endif /* CONFIG_S390 */
>  
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"	.pushsection    .text, \"ax\", @progbits\n"
> +"	.type		my_tramp1, @function\n"
> +"	.globl		my_tramp1\n"
> +"   my_tramp1:"
> +"	bti	c\n"
> +"	sub	sp, sp, #32\n"
> +"	stp	x9, x30, [sp]\n"
> +"	str	x0, [sp, #16]\n"
> +"	mov	x0, x30\n"
> +"	bl	my_direct_func1\n"
> +"	ldp	x30, x9, [sp]\n"
> +"	ldr	x0, [sp, #16]\n"
> +"	add	sp, sp, #32\n"
> +"	ret	x9\n"
> +"	.size		my_tramp1, .-my_tramp1\n"
> +
> +"	.type		my_tramp2, @function\n"
> +"	.globl		my_tramp2\n"
> +"   my_tramp2:"
> +"	bti	c\n"
> +"	sub	sp, sp, #32\n"
> +"	stp	x9, x30, [sp]\n"
> +"	str	x0, [sp, #16]\n"
> +"	mov	x0, x30\n"
> +"	bl	my_direct_func2\n"
> +"	ldp	x30, x9, [sp]\n"
> +"	ldr	x0, [sp, #16]\n"
> +"	add	sp, sp, #32\n"
> +"	ret	x9\n"
> +"	.size		my_tramp2, .-my_tramp2\n"
> +"	.popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
> +
>  static unsigned long my_tramp = (unsigned long)my_tramp1;
>  static unsigned long tramps[2] = {
>  	(unsigned long)my_tramp1,
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> index 1547c2c6be02..b2ac90e0c02e 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -4,7 +4,9 @@
>  #include <linux/mm.h> /* for handle_mm_fault() */
>  #include <linux/ftrace.h>
>  #include <linux/sched/stat.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>  
>  extern void my_direct_func(unsigned long ip);
>  
> @@ -66,6 +68,28 @@ asm (
>  
>  #endif /* CONFIG_S390 */
>  
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"	.pushsection	.text, \"ax\", @progbits\n"
> +"	.type		my_tramp, @function\n"
> +"	.globl		my_tramp\n"
> +"   my_tramp:"
> +"	bti	c\n"
> +"	sub	sp, sp, #32\n"
> +"	stp	x9, x30, [sp]\n"
> +"	str	x0, [sp, #16]\n"
> +"	mov	x0, x30\n"
> +"	bl	my_direct_func\n"
> +"	ldp	x30, x9, [sp]\n"
> +"	ldr	x0, [sp, #16]\n"
> +"	add	sp, sp, #32\n"
> +"	ret	x9\n"
> +"	.size		my_tramp, .-my_tramp\n"
> +"	.popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
>  static struct ftrace_ops direct;
>  
>  static int __init ftrace_direct_multi_init(void)
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index 71ed4ee8cb4a..38f6f677f913 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -3,7 +3,9 @@
>  
>  #include <linux/mm.h> /* for handle_mm_fault() */
>  #include <linux/ftrace.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>  
>  extern void my_direct_func(struct vm_area_struct *vma, unsigned long address,
>  			   unsigned int flags, struct pt_regs *regs);
> @@ -72,6 +74,30 @@ asm (
>  
>  #endif /* CONFIG_S390 */
>  
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"	.pushsection	.text, \"ax\", @progbits\n"
> +"	.type		my_tramp, @function\n"
> +"	.globl		my_tramp\n"
> +"   my_tramp:"
> +"	bti	c\n"
> +"	sub	sp, sp, #48\n"
> +"	stp	x9, x30, [sp]\n"
> +"	stp	x0, x1, [sp, #16]\n"
> +"	stp	x2, x3, [sp, #32]\n"
> +"	bl	my_direct_func\n"
> +"	ldp	x30, x9, [sp]\n"
> +"	ldp	x0, x1, [sp, #16]\n"
> +"	ldp	x2, x3, [sp, #32]\n"
> +"	add	sp, sp, #48\n"
> +"	ret	x9\n"
> +"	.size		my_tramp, .-my_tramp\n"
> +"	.popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
> +
>  static struct ftrace_ops direct;
>  
>  static int __init ftrace_direct_init(void)
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> index d81a9473b585..e5312f9c15d3 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -3,7 +3,9 @@
>  
>  #include <linux/sched.h> /* for wake_up_process() */
>  #include <linux/ftrace.h>
> +#ifndef CONFIG_ARM64
>  #include <asm/asm-offsets.h>
> +#endif
>  
>  extern void my_direct_func(struct task_struct *p);
>  
> @@ -63,6 +65,28 @@ asm (
>  
>  #endif /* CONFIG_S390 */
>  
> +#ifdef CONFIG_ARM64
> +
> +asm (
> +"	.pushsection	.text, \"ax\", @progbits\n"
> +"	.type		my_tramp, @function\n"
> +"	.globl		my_tramp\n"
> +"   my_tramp:"
> +"	bti	c\n"
> +"	sub	sp, sp, #32\n"
> +"	stp	x9, x30, [sp]\n"
> +"	str	x0, [sp, #16]\n"
> +"	bl	my_direct_func\n"
> +"	ldp	x30, x9, [sp]\n"
> +"	ldr	x0, [sp, #16]\n"
> +"	add	sp, sp, #32\n"
> +"	ret	x9\n"
> +"	.size		my_tramp, .-my_tramp\n"
> +"	.popsection\n"
> +);
> +
> +#endif /* CONFIG_ARM64 */
> +
>  static struct ftrace_ops direct;
>  
>  static int __init ftrace_direct_init(void)
> -- 
> 2.40.0.577.gac1e443424-goog
> 
