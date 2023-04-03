Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04F6D4EE7
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjDCR0q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 13:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjDCR0o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 13:26:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F72FF9;
        Mon,  3 Apr 2023 10:26:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767524B3;
        Mon,  3 Apr 2023 10:27:22 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDE2A3F6C4;
        Mon,  3 Apr 2023 10:26:35 -0700 (PDT)
Date:   Mon, 3 Apr 2023 18:26:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v5 3/4] arm64: ftrace: Add direct call trampoline samples
 support
Message-ID: <ZCsMQ/6MI49st2oW@FVFF77S0Q05N.cambridge.arm.com>
References: <20230403113552.2857693-1-revest@chromium.org>
 <20230403113552.2857693-4-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403113552.2857693-4-revest@chromium.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 03, 2023 at 01:35:51PM +0200, Florent Revest wrote:
> The ftrace samples need per-architecture trampoline implementations
> to save and restore argument registers around the calls to
> my_direct_func* and to restore polluted registers (eg: x30).
> 
> These samples also include <asm/asm-offsets.h> which, on arm64, is not
> necessary and redefines previously defined macros (resulting in
> warnings) so these includes are guarded by !CONFIG_ARM64.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>

Overall this looks pretty good!

I spotted a few bugs below while testing, and I've suggested some fixups below.

w.r.t. the asm-offsets include guards. I took a look at fixing arm64's
asm-offsets.c to not be problematic, but it requires some invasive refactoring,
so I'd like to clean that up as a separate series. I don't think that should
block this series, and I think that the include guards are fine for now.

> ---
>  arch/arm64/Kconfig                          |  2 ++
>  samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c | 38 +++++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi.c        | 23 +++++++++++++
>  samples/ftrace/ftrace-direct-too.c          | 26 ++++++++++++++
>  samples/ftrace/ftrace-direct.c              | 24 +++++++++++++
>  6 files changed, 147 insertions(+)
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

These looks functionally correct, given they'll only be attached to schedule()
and the direct funcs take no arguments, so there's no arguments to save/restore
and nothing to shuffle.

As an aside, I believe we'll need to rework the sequences when we add support
for RELIABLE_STACKTRACE so that the unwinder can reliably acquire the address
of the instrumented function and its caller, but I think for now it's
preferable to keep this simple and I'm happy to make that a problem for future
me.

> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> index f72623899602..e39108eb085d 100644
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
> @@ -103,6 +105,42 @@ asm (
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

For both of these trampolines we need to pass the trampoline's return address
(i.e. where we'll return to in the instrumented function) as the 'ip' argument
to my_direct_func{1,2}().

In both cases, just before the 'bl my_direct_func{1,2}' we'll need to add:

	mov	x0, x30

[...]

> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> index 1547c2c6be02..5a395d2d2e07 100644
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
> @@ -66,6 +68,27 @@ asm (
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
>  static struct ftrace_ops direct;

As with ftrace-direct-multi-modify.c, we need to pass the return address of the
trampoline as the 'ip' argument to my_direct_func1(), so just before the 'bl
my_direct_func' we'll need to add:

	mov	x0, x30

[...]

> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index f28e7b99840f..6e93c45fea86 100644
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
>  extern void my_direct_func(struct vm_area_struct *vma,
>  			   unsigned long address, unsigned int flags);

This gets attached to handle_mm_fault(), whose prototype is currently:

vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
                           unsigned int flags, struct pt_regs *regs)

i.e. it has 4 arguments, in x0 to x3.

> @@ -70,6 +72,30 @@ asm (
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
> +"	str	x2, [sp, #32]\n"
> +"	bl	my_direct_func\n"
> +"	ldp	x30, x9, [sp]\n"
> +"	ldp	x0, x1, [sp, #16]\n"
> +"	ldr	x2, [sp, #32]\n"

So here we need to save+restore x3 also.

We already have the space reserved, so that should just be a matter of using
stp/ldp for x2 and x3.

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

This looks fine. Since my_direct_func() is attached to wake_up_process() and
expects its single argument, saving/restoring x0 is sufficient and we don't
need any additional register shuffling.

Thanks,
Mark.
