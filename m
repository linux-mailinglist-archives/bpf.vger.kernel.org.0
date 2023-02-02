Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8728688322
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 16:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjBBPyq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 10:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjBBPyo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 110D0677A2;
        Thu,  2 Feb 2023 07:54:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3FAFC14;
        Thu,  2 Feb 2023 07:55:19 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD3763F64C;
        Thu,  2 Feb 2023 07:54:35 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:54:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Subject: Re: [PATCH 5/8] ftrace: Make DIRECT_CALLS work WITH_ARGS and
 !WITH_REGS
Message-ID: <Y9vcua0+JzjmTICO@FVFF77S0Q05N.cambridge.arm.com>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230201163420.1579014-6-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201163420.1579014-6-revest@chromium.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 05:34:17PM +0100, Florent Revest wrote:
> Direct called trampolines can be called in two ways:
> - either from the ftrace callsite. In this case, they do not access any
>   struct ftrace_regs nor pt_regs
> - Or, if a ftrace ops is also attached, from the end of a ftrace
>   trampoline. In this case, the call_direct_funcs ops is in charge of
>   setting the direct call trampoline's address in a struct ftrace_regs
> 
> Since "ftrace: pass fregs to arch_ftrace_set_direct_caller()", the later
> case no longer requires a full pt_regs.

Minor nit, but could we please have the commit ID, e.g.

| Since commit:
| 
|   9705bc70960459ae ("ftrace: pass fregs to arch_ftrace_set_direct_caller()")
| 
| The latter case no longer requires a full pt_regs.

> It only needs a struct
> ftrace_regs so DIRECT_CALLS can work with both WITH_ARGS or WITH_REGS.
> With architectures like arm64 already abandoning WITH_REGS in favor of
> WITH_ARGS, it's important to have DIRECT_CALLS work WITH_ARGS only.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/trace/Kconfig  | 2 +-
>  kernel/trace/ftrace.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 5df427a2321d..4496a7c69810 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -257,7 +257,7 @@ config DYNAMIC_FTRACE_WITH_REGS
>  
>  config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	def_bool y
> -	depends on DYNAMIC_FTRACE_WITH_REGS
> +	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
>  	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  
>  config DYNAMIC_FTRACE_WITH_CALL_OPS
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b0426de11c45..73b6f6489ba1 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5282,7 +5282,7 @@ static LIST_HEAD(ftrace_direct_funcs);
>  
>  static int register_ftrace_function_nolock(struct ftrace_ops *ops);
>  
> -#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
> +#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT)

Unfortunately, I think this is broken for architectures where:

* DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
* DYNAMIC_FTRACE_WITH_REGS=y
* DYNAMIC_FTRACE_WITH_ARGS=n

... since those might pass a NULL ftrace_regs around, and so when using the
list ops arch_ftrace_set_direct_caller() might blow up accessing an element of
ftrace_regs.

It looks like 32-bit x86 is the only case with that combination, and its
ftrace_caller implementation passes a NULL regs, so I reckon that'll blow up.
However, it looks like there aren't any FTRACE_DIRECT samples wired up for
32-bit x86, so I'm not aware of a test case we can use.

We could make the FTRACE_OPS_FL_SAVE_REGS flag conditional, or we could
implement DYNAMIC_FTRACE_WITH_ARGS for 32-bit x86 and have
DYNAMIC_FTRACE_WITH_DIRECT_CALLS depend solely on that.

Thanks,
Mark.
