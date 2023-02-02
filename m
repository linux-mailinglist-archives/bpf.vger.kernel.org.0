Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B70688290
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 16:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjBBPdR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 10:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjBBPcN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 10:32:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECC4979F39;
        Thu,  2 Feb 2023 07:31:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D074C14;
        Thu,  2 Feb 2023 07:30:46 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13C203F64C;
        Thu,  2 Feb 2023 07:30:01 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:29:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Subject: Re: [PATCH 4/8] ftrace: Store direct called addresses in their ops
Message-ID: <Y9vW99htjOphDXqY@FVFF77S0Q05N.cambridge.arm.com>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230201163420.1579014-5-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201163420.1579014-5-revest@chromium.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 05:34:16PM +0100, Florent Revest wrote:
> All direct calls are now registered using the register_ftrace_direct API
> so each ops can jump to only one direct-called trampoline.
> 
> By storing the direct called trampoline address directly in the ops we
> can save one hashmap lookup in the direct call ops and implement arm64
> direct calls on top of call ops.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/ftrace.h | 3 +++
>  kernel/trace/ftrace.c  | 6 ++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index a7dbd307c3a4..84f717f8959e 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -321,6 +321,9 @@ struct ftrace_ops {
>  	unsigned long			trampoline_size;
>  	struct list_head		list;
>  	ftrace_ops_func_t		ops_func;
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	unsigned long			direct_call;
> +#endif
>  #endif
>  };
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index cb77a0a208c7..b0426de11c45 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2577,9 +2577,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
>  static void call_direct_funcs(unsigned long ip, unsigned long pip,
>  			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> -	unsigned long addr;
> +	unsigned long addr = ops->direct_call;
>  
> -	addr = ftrace_find_rec_direct(ip);
>  	if (!addr)
>  		return;
>  
> @@ -5375,6 +5374,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	ops->func = call_direct_funcs;
>  	ops->flags = MULTI_FLAGS;
>  	ops->trampoline = FTRACE_REGS_ADDR;
> +	ops->direct_call = addr;
>  
>  	err = register_ftrace_function_nolock(ops);
>  
> @@ -5445,6 +5445,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	/* Enable the tmp_ops to have the same functions as the direct ops */
>  	ftrace_ops_init(&tmp_ops);
>  	tmp_ops.func_hash = ops->func_hash;
> +	tmp_ops.direct_call = addr;
>  
>  	err = register_ftrace_function_nolock(&tmp_ops);
>  	if (err)
> @@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  			entry->direct = addr;
>  		}
>  	}
> +	ops->direct_call = addr;

AFAICT we don't synchronize threads when installing the tmp_ops, so IIUC on
arches with call_ops, there could be a a thread in the middle of ftrace_caller
which has loaded the ops pointer from the patch-site, but hasn't yet loaded the
ops::direct_func pointer, and could race with this assignment.

Given that, I think this needs to be:

	WRITE_ONCE(ops->direct_call, addr);

... in order to avoid the risk of the store being torn, and the ftrace_caller
trampoline loading a corrupted pointer.

Other than that, this looks good to me!

Thanks,
Mark.

>  
>  	mutex_unlock(&ftrace_lock);
>  
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 
