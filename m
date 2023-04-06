Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3B6D93E3
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbjDFKXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjDFKXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 06:23:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 295848A48;
        Thu,  6 Apr 2023 03:22:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBCA516F8;
        Thu,  6 Apr 2023 03:23:01 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.171])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42B2E3F762;
        Thu,  6 Apr 2023 03:22:15 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:22:09 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v6 3/5] samples: ftrace: Save required argument registers
 in sample trampolines
Message-ID: <ZC6dUacJjFVDyDGz@FVFF77S0Q05N>
References: <20230405180250.2046566-1-revest@chromium.org>
 <20230405180250.2046566-4-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405180250.2046566-4-revest@chromium.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 05, 2023 at 08:02:48PM +0200, Florent Revest wrote:
> The ftrace-direct-too sample traces the handle_mm_fault function whose
> signature changed since the introduction of the sample. Since:
> commit bce617edecad ("mm: do page fault accounting in handle_mm_fault")
> handle_mm_fault now has 4 arguments. Therefore, the sample trampoline
> should save 4 argument registers.
> 
> s390 saves all argument registers already so it does not need a change
> but x86_64 needs an extra push and pop.
> 
> This also evolves the signature of the tracing function to make it
> mirror the signature of the traced function.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks for this!

Mark.

> ---
>  samples/ftrace/ftrace-direct-too.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index f28e7b99840f..71ed4ee8cb4a 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -5,14 +5,14 @@
>  #include <linux/ftrace.h>
>  #include <asm/asm-offsets.h>
>  
> -extern void my_direct_func(struct vm_area_struct *vma,
> -			   unsigned long address, unsigned int flags);
> +extern void my_direct_func(struct vm_area_struct *vma, unsigned long address,
> +			   unsigned int flags, struct pt_regs *regs);
>  
> -void my_direct_func(struct vm_area_struct *vma,
> -			unsigned long address, unsigned int flags)
> +void my_direct_func(struct vm_area_struct *vma, unsigned long address,
> +		    unsigned int flags, struct pt_regs *regs)
>  {
> -	trace_printk("handle mm fault vma=%p address=%lx flags=%x\n",
> -		     vma, address, flags);
> +	trace_printk("handle mm fault vma=%p address=%lx flags=%x regs=%p\n",
> +		     vma, address, flags, regs);
>  }
>  
>  extern void my_tramp(void *);
> @@ -34,7 +34,9 @@ asm (
>  "	pushq %rdi\n"
>  "	pushq %rsi\n"
>  "	pushq %rdx\n"
> +"	pushq %rcx\n"
>  "	call my_direct_func\n"
> +"	popq %rcx\n"
>  "	popq %rdx\n"
>  "	popq %rsi\n"
>  "	popq %rdi\n"
> -- 
> 2.40.0.577.gac1e443424-goog
> 
