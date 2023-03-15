Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BEA6BC190
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 00:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjCOXhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 19:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjCOXgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 19:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1B6F61F;
        Wed, 15 Mar 2023 16:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1166E61E91;
        Wed, 15 Mar 2023 23:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B08C433D2;
        Wed, 15 Mar 2023 23:33:56 +0000 (UTC)
Date:   Wed, 15 Mar 2023 19:33:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Subject: Re: [PATCH v2 01/10] ftrace: Replace uses of _ftrace_direct APIs
 with _ftrace_direct_multi
Message-ID: <20230315193355.30c48764@gandalf.local.home>
In-Reply-To: <20230207182135.2671106-2-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
        <20230207182135.2671106-2-revest@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  7 Feb 2023 19:21:26 +0100
Florent Revest <revest@chromium.org> wrote:

> The _multi API requires that users keep their own ops but can enforce
> that an op is only associated to one direct call.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  kernel/trace/trace_selftest.c         | 11 +++++++----
>  samples/ftrace/ftrace-direct-modify.c | 12 ++++++++----
>  samples/ftrace/ftrace-direct-too.c    | 12 +++++++-----
>  samples/ftrace/ftrace-direct.c        | 12 +++++++-----
>  4 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index ff0536cea968..57221f69a33b 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -806,6 +806,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  	int ret;
>  	unsigned long count;
>  	char *func_name __maybe_unused;
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	struct ftrace_ops direct = {};

Make this static to the file and move it above to where there's already an
#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block.

Less #ifdef is better, and also, I don't like having as an example an
ftrace_ops structure allocated on the stack. It can become increasingly
larger as time goes by. I don't want to encourage placing it on stacks.

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

I had to rebase this code on top of the latest tree because of updates.
Which is good, because this patch requires those same. When using
ftrace_set_filter_ip() one needs to call

   ftrace_free_filter(&direct);

Because the ftrace_set_filter_ip() allocates hashs on the ftrace_ops and
those need to be freed.


>  
> @@ -891,8 +894,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  
>  	unregister_ftrace_graph(&fgraph_ops);
>  
> -	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
> -				       (unsigned long) trace_direct_tramp);
> +	ret = unregister_ftrace_direct_multi(&direct,
> +					     (unsigned long) trace_direct_tramp);
>  	if (ret)
>  		goto out;
>  
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index de5a0f67f320..ecd76f75cb80 100644
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
> @@ -129,7 +131,9 @@ static int __init ftrace_direct_init(void)
>  {
>  	int ret;
>  
> -	ret = register_ftrace_direct(my_ip, my_tramp);
> +	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
> +	ret = register_ftrace_direct_multi(&direct, my_tramp);
> +
>  	if (!ret)
>  		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
>  	return ret;
> @@ -138,12 +142,12 @@ static int __init ftrace_direct_init(void)
>  static void __exit ftrace_direct_exit(void)
>  {
>  	kthread_stop(simple_tsk);
> -	unregister_ftrace_direct(my_ip, my_tramp);
> +	unregister_ftrace_direct_multi(&direct, my_tramp);

Same here.

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

And here.

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

And here.

Maybe we could add a parameter to unregister_ftrace_direct_multi():

  bool free_filters

when set, it will call the ftrace_free_filter(), as it looks like there's a
common code path here:

	ftrace_set_filter_ip();
	register_ftrace_direct_multi();
	[..]
	unregister_ftrace_direct_multi();
	ftrace_free_filter();

Add the option will save people from having to do that last step, and also
remind people that the filters need to be freed.

-- Steve

>  }
>  
>  module_init(ftrace_direct_init);
>  module_exit(ftrace_direct_exit);
>  
>  MODULE_AUTHOR("Steven Rostedt");
> -MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
> +MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
>  MODULE_LICENSE("GPL");

