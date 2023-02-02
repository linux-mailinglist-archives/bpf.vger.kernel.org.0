Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C236880ED
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 16:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjBBPCX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 10:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjBBPCT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 10:02:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DAFA8B327;
        Thu,  2 Feb 2023 07:02:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B532FC14;
        Thu,  2 Feb 2023 07:02:46 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DBCC3F64C;
        Thu,  2 Feb 2023 07:02:02 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:01:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Subject: Re: [PATCH 1/8] ftrace: Replace uses of _ftrace_direct APIs with
 _ftrace_direct_multi
Message-ID: <Y9vPAdFBJF/gKXaO@FVFF77S0Q05N.cambridge.arm.com>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230201163420.1579014-2-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201163420.1579014-2-revest@chromium.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 05:34:13PM +0100, Florent Revest wrote:
> The _multi API requires that users keep their own ops and can enforce
> that an op is only associated to one direct call.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/trace/trace_selftest.c         |  9 ++++++---
>  samples/ftrace/ftrace-direct-modify.c | 11 +++++++----
>  samples/ftrace/ftrace-direct-too.c    | 12 +++++++-----
>  samples/ftrace/ftrace-direct.c        | 12 +++++++-----

Looking at samples/ftrace/, as of this patch we have a few samples that are
almost identical, modulo the function being traced, and some different register
shuffling for arguments:

* ftrace-direct.c and ftrace-direct-multi.c
* ftrace-direct-modify.c and ftrace-direct-modify

... perhaps it would be better to just delete the !multi versions ?

Regardless, the changes below look functionally correct to me. I gave it a spin
on x86_64, both with the FTRACE_STARTUP_TEST, and loading the modules
dynamically, and those were all happy:

| # mount -t tracefs none /sys/kernel/tracing/
| # for KO in *.ko; do
| > echo $KO;
| > insmod $KO;
| > cat /sys/kernel/tracing/enabled_functions 
| > rmmod $KO;
| > done
| ftrace-direct-modify.ko
| [   91.890089] 
| [   91.890600] **********************************************************
| [   91.892277] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
| [   91.893912] **                                                      **
| [   91.895569] ** trace_printk() being used. Allocating extra memory.  **
| [   91.897215] **                                                      **
| [   91.898861] ** This means that this is a DEBUG kernel and it is     **
| [   91.900517] ** unsafe for production use.                           **
| [   91.902138] **                                                      **
| [   91.903755] ** If you see this message and you are not debugging    **
| [   91.905378] ** the kernel, report this immediately to your vendor!  **
| [   91.907010] **                                                      **
| [   91.908625] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
| [   91.910221] **********************************************************
| schedule (1) R   D      tramp: ftrace_regs_caller+0x0/0x66 (call_direct_funcs+0x0/0x20)
|         direct-->my_tramp1+0x0/0x1d [ftrace_direct_modify]
| ftrace-direct-multi-modify.ko
| wake_up_process (1) R   D       tramp: ftrace_regs_caller+0x0/0x66 (call_direct_funcs+0x0/0x20)
|         direct-->my_tramp1+0x0/0x23 [ftrace_direct_multi_modify]
| schedule (1) R   D      tramp: ftrace_regs_caller+0x0/0x66 (call_direct_funcs+0x0/0x20)
|         direct-->my_tramp1+0x0/0x23 [ftrace_direct_multi_modify]
| ftrace-direct-multi.ko
| wake_up_process (1) R   D       tramp: ftrace_regs_caller+0x0/0x66 (call_direct_funcs+0x0/0x20)
|         direct-->my_tramp+0x0/0x30 [ftrace_direct_multi]
| schedule (1) R   D      tramp: ftrace_regs_caller+0x0/0x66 (call_direct_funcs+0x0/0x20)
|         direct-->my_tramp+0x0/0x30 [ftrace_direct_multi]
| ftrace-direct-too.ko
| handle_mm_fault (1) R   D       tramp: ftrace_regs_caller+0x0/0x66 (call_direct_funcs+0x0/0x20)
|         direct-->my_tramp+0x0/0x30 [ftrace_direct_too]
| ftrace-direct.ko
| wake_up_process (1) R   D       tramp: ftrace_regs_caller+0x0/0x66 (call_direct_funcs+0x0/0x20)
|         direct-->my_tramp+0x0/0x20 [ftrace_direct]

So FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  4 files changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index ff0536cea968..9b7f10cbc51d 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -806,6 +806,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  	int ret;
>  	unsigned long count;
>  	char *func_name __maybe_unused;
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	struct ftrace_ops direct = {};
> +#endif
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  	if (ftrace_filter_param) {
> @@ -870,8 +873,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  	 * Register direct function together with graph tracer
>  	 * and make sure we get graph trace.
>  	 */
> -	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
> -				     (unsigned long) trace_direct_tramp);
> +	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
> +	ret = register_ftrace_direct_multi(&direct, (unsigned long)trace_direct_tramp);
>  	if (ret)
>  		goto out;
>  
> @@ -891,7 +894,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  
>  	unregister_ftrace_graph(&fgraph_ops);
>  
> -	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
> +	ret = unregister_ftrace_direct_multi(&direct,
>  				       (unsigned long) trace_direct_tramp);
>  	if (ret)
>  		goto out;
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index de5a0f67f320..e1e6c286970c 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -96,6 +96,8 @@ asm (
>  
>  #endif /* CONFIG_S390 */
>  
> +static struct ftrace_ops direct;
> +
>  static unsigned long my_tramp = (unsigned long)my_tramp1;
>  static unsigned long tramps[2] = {
>  	(unsigned long)my_tramp1,
> @@ -114,7 +116,7 @@ static int simple_thread(void *arg)
>  		if (ret)
>  			continue;
>  		t ^= 1;
> -		ret = modify_ftrace_direct(my_ip, my_tramp, tramps[t]);
> +		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
>  		if (!ret)
>  			my_tramp = tramps[t];
>  		WARN_ON_ONCE(ret);
> @@ -129,7 +131,8 @@ static int __init ftrace_direct_init(void)
>  {
>  	int ret;
>  
> -	ret = register_ftrace_direct(my_ip, my_tramp);
> +	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
> +	ret = register_ftrace_direct_multi(&direct, my_tramp);
>  	if (!ret)
>  		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
>  	return ret;
> @@ -138,12 +141,12 @@ static int __init ftrace_direct_init(void)
>  static void __exit ftrace_direct_exit(void)
>  {
>  	kthread_stop(simple_tsk);
> -	unregister_ftrace_direct(my_ip, my_tramp);
> +	unregister_ftrace_direct_multi(&direct, my_tramp);
>  }
>  
>  module_init(ftrace_direct_init);
>  module_exit(ftrace_direct_exit);
>  
>  MODULE_AUTHOR("Steven Rostedt");
> -MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
> +MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
>  MODULE_LICENSE("GPL");
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index e13fb59a2b47..0e907092e2c0 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -70,21 +70,23 @@ asm (
>  
>  #endif /* CONFIG_S390 */
>  
> +static struct ftrace_ops direct;
> +
>  static int __init ftrace_direct_init(void)
>  {
> -	return register_ftrace_direct((unsigned long)handle_mm_fault,
> -				     (unsigned long)my_tramp);
> +	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
> +
> +	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
>  }
>  
>  static void __exit ftrace_direct_exit(void)
>  {
> -	unregister_ftrace_direct((unsigned long)handle_mm_fault,
> -				 (unsigned long)my_tramp);
> +	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
>  }
>  
>  module_init(ftrace_direct_init);
>  module_exit(ftrace_direct_exit);
>  
>  MODULE_AUTHOR("Steven Rostedt");
> -MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
> +MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct_multi()");
>  MODULE_LICENSE("GPL");
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> index 1f769d0db20f..e446c38f6b58 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -63,21 +63,23 @@ asm (
>  
>  #endif /* CONFIG_S390 */
>  
> +static struct ftrace_ops direct;
> +
>  static int __init ftrace_direct_init(void)
>  {
> -	return register_ftrace_direct((unsigned long)wake_up_process,
> -				     (unsigned long)my_tramp);
> +	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
> +
> +	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
>  }
>  
>  static void __exit ftrace_direct_exit(void)
>  {
> -	unregister_ftrace_direct((unsigned long)wake_up_process,
> -				 (unsigned long)my_tramp);
> +	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
>  }
>  
>  module_init(ftrace_direct_init);
>  module_exit(ftrace_direct_exit);
>  
>  MODULE_AUTHOR("Steven Rostedt");
> -MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
> +MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
>  MODULE_LICENSE("GPL");
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 
