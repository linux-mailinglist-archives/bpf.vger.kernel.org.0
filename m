Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74368818B
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjBBPSr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 10:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjBBPSn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 10:18:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 992CD5956F;
        Thu,  2 Feb 2023 07:18:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F30DC14;
        Thu,  2 Feb 2023 07:18:05 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CFD83F64C;
        Thu,  2 Feb 2023 07:17:21 -0800 (PST)
Date:   Thu, 2 Feb 2023 15:17:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Subject: Re: [PATCH 3/8] ftrace: Rename _ftrace_direct_multi APIs to
 _ftrace_direct APIs
Message-ID: <Y9vT/l9wH9pqf9nR@FVFF77S0Q05N.cambridge.arm.com>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230201163420.1579014-4-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201163420.1579014-4-revest@chromium.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 05:34:15PM +0100, Florent Revest wrote:
> Now that the original _ftrace_direct APIs are gone, the "_multi"
> suffixes only add confusion.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/ftrace.h                      | 16 +++++------
>  kernel/bpf/trampoline.c                     | 14 ++++-----
>  kernel/trace/ftrace.c                       | 32 ++++++++++-----------
>  kernel/trace/trace_selftest.c               |  7 +++--
>  samples/Kconfig                             |  2 +-
>  samples/ftrace/ftrace-direct-modify.c       |  8 +++---
>  samples/ftrace/ftrace-direct-multi-modify.c |  8 +++---
>  samples/ftrace/ftrace-direct-multi.c        |  6 ++--
>  samples/ftrace/ftrace-direct-too.c          |  6 ++--
>  samples/ftrace/ftrace-direct.c              |  6 ++--
>  10 files changed, 53 insertions(+), 52 deletions(-)

This looks like a sensible cleanup to me.

As with the last two patches, on x86_64 the kernel builds cleanly, the
FTRACE_STARTUP_TEST is happy, and loading each of the ftrace_direct*.ko samples
works fine. So:

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 2d7c85e47c2d..a7dbd307c3a4 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -398,10 +398,10 @@ struct ftrace_func_entry {
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  extern int ftrace_direct_func_count;
>  unsigned long ftrace_find_rec_direct(unsigned long ip);
> -int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> -int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> -int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> -int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr);
> +int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
> +int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
> +int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
> +int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
>  
>  #else
>  struct ftrace_ops;
> @@ -410,19 +410,19 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
>  {
>  	return 0;
>  }
> -static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +static inline int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	return -ENODEV;
>  }
> -static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +static inline int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	return -ENODEV;
>  }
> -static inline int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +static inline int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	return -ENODEV;
>  }
> -static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr)
> +static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	return -ENODEV;
>  }
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d0ed7d6f5eec..150b53316df2 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -39,14 +39,14 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd
>  	int ret = 0;
>  
>  	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
> -		/* This is called inside register_ftrace_direct_multi(), so
> +		/* This is called inside register_ftrace_direct(), so
>  		 * tr->mutex is already locked.
>  		 */
>  		lockdep_assert_held_once(&tr->mutex);
>  
>  		/* Instead of updating the trampoline here, we propagate
> -		 * -EAGAIN to register_ftrace_direct_multi(). Then we can
> -		 * retry register_ftrace_direct_multi() after updating the
> +		 * -EAGAIN to register_ftrace_direct(). Then we can
> +		 * retry register_ftrace_direct() after updating the
>  		 * trampoline.
>  		 */
>  		if ((tr->flags & BPF_TRAMP_F_CALL_ORIG) &&
> @@ -198,7 +198,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
>  	int ret;
>  
>  	if (tr->func.ftrace_managed)
> -		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr);
> +		ret = unregister_ftrace_direct(tr->fops, (long)old_addr);
>  	else
>  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
>  
> @@ -215,9 +215,9 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
>  
>  	if (tr->func.ftrace_managed) {
>  		if (lock_direct_mutex)
> -			ret = modify_ftrace_direct_multi(tr->fops, (long)new_addr);
> +			ret = modify_ftrace_direct(tr->fops, (long)new_addr);
>  		else
> -			ret = modify_ftrace_direct_multi_nolock(tr->fops, (long)new_addr);
> +			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
>  	} else {
>  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
>  	}
> @@ -243,7 +243,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  
>  	if (tr->func.ftrace_managed) {
>  		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
> -		ret = register_ftrace_direct_multi(tr->fops, (long)new_addr);
> +		ret = register_ftrace_direct(tr->fops, (long)new_addr);
>  	} else {
>  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
>  	}
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 5efe201428fa..cb77a0a208c7 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5312,7 +5312,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
>  }
>  
>  /**
> - * register_ftrace_direct_multi - Call a custom trampoline directly
> + * register_ftrace_direct - Call a custom trampoline directly
>   * for multiple functions registered in @ops
>   * @ops: The address of the struct ftrace_ops object
>   * @addr: The address of the trampoline to call at @ops functions
> @@ -5333,7 +5333,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
>   *  -ENODEV  - @ip does not point to a ftrace nop location (or not supported)
>   *  -ENOMEM  - There was an allocation failure.
>   */
> -int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	struct ftrace_hash *hash, *free_hash = NULL;
>  	struct ftrace_func_entry *entry, *new;
> @@ -5391,11 +5391,11 @@ int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  	}
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
> +EXPORT_SYMBOL_GPL(register_ftrace_direct);
>  
>  /**
> - * unregister_ftrace_direct_multi - Remove calls to custom trampoline
> - * previously registered by register_ftrace_direct_multi for @ops object.
> + * unregister_ftrace_direct - Remove calls to custom trampoline
> + * previously registered by register_ftrace_direct for @ops object.
>   * @ops: The address of the struct ftrace_ops object
>   *
>   * This is used to remove a direct calls to @addr from the nop locations
> @@ -5406,7 +5406,7 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
>   *  0 on success
>   *  -EINVAL - The @ops object was not properly registered.
>   */
> -int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	struct ftrace_hash *hash = ops->func_hash->filter_hash;
>  	int err;
> @@ -5426,10 +5426,10 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  	ops->trampoline = 0;
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
> +EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
>  
>  static int
> -__modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +__modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	struct ftrace_hash *hash;
>  	struct ftrace_func_entry *entry, *iter;
> @@ -5476,7 +5476,7 @@ __modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  }
>  
>  /**
> - * modify_ftrace_direct_multi_nolock - Modify an existing direct 'multi' call
> + * modify_ftrace_direct_nolock - Modify an existing direct 'multi' call
>   * to call something else
>   * @ops: The address of the struct ftrace_ops object
>   * @addr: The address of the new trampoline to call at @ops functions
> @@ -5493,19 +5493,19 @@ __modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>   * Returns: zero on success. Non zero on error, which includes:
>   *  -EINVAL - The @ops object was not properly registered.
>   */
> -int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr)
> +int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	if (check_direct_multi(ops))
>  		return -EINVAL;
>  	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
>  		return -EINVAL;
>  
> -	return __modify_ftrace_direct_multi(ops, addr);
> +	return __modify_ftrace_direct(ops, addr);
>  }
> -EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi_nolock);
> +EXPORT_SYMBOL_GPL(modify_ftrace_direct_nolock);
>  
>  /**
> - * modify_ftrace_direct_multi - Modify an existing direct 'multi' call
> + * modify_ftrace_direct - Modify an existing direct 'multi' call
>   * to call something else
>   * @ops: The address of the struct ftrace_ops object
>   * @addr: The address of the new trampoline to call at @ops functions
> @@ -5519,7 +5519,7 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi_nolock);
>   * Returns: zero on success. Non zero on error, which includes:
>   *  -EINVAL - The @ops object was not properly registered.
>   */
> -int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  {
>  	int err;
>  
> @@ -5529,11 +5529,11 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  		return -EINVAL;
>  
>  	mutex_lock(&direct_mutex);
> -	err = __modify_ftrace_direct_multi(ops, addr);
> +	err = __modify_ftrace_direct(ops, addr);
>  	mutex_unlock(&direct_mutex);
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
> +EXPORT_SYMBOL_GPL(modify_ftrace_direct);
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  /**
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index 9b7f10cbc51d..06218fc9374b 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -874,7 +874,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  	 * and make sure we get graph trace.
>  	 */
>  	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
> -	ret = register_ftrace_direct_multi(&direct, (unsigned long)trace_direct_tramp);
> +	ret = register_ftrace_direct(&direct,
> +				     (unsigned long)trace_direct_tramp);
>  	if (ret)
>  		goto out;
>  
> @@ -894,8 +895,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  
>  	unregister_ftrace_graph(&fgraph_ops);
>  
> -	ret = unregister_ftrace_direct_multi(&direct,
> -				       (unsigned long) trace_direct_tramp);
> +	ret = unregister_ftrace_direct(&direct,
> +				       (unsigned long)trace_direct_tramp);
>  	if (ret)
>  		goto out;
>  
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 0d81c00289ee..e85998ca354d 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -38,7 +38,7 @@ config SAMPLE_FTRACE_DIRECT
>  	  that hooks to wake_up_process and prints the parameters.
>  
>  config SAMPLE_FTRACE_DIRECT_MULTI
> -	tristate "Build register_ftrace_direct_multi() example"
> +	tristate "Build register_ftrace_direct() on multiple ips example"
>  	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
>  	depends on HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>  	help
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index e1e6c286970c..0f1b8859e1e1 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -116,7 +116,7 @@ static int simple_thread(void *arg)
>  		if (ret)
>  			continue;
>  		t ^= 1;
> -		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
> +		ret = modify_ftrace_direct(&direct, tramps[t]);
>  		if (!ret)
>  			my_tramp = tramps[t];
>  		WARN_ON_ONCE(ret);
> @@ -132,7 +132,7 @@ static int __init ftrace_direct_init(void)
>  	int ret;
>  
>  	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
> -	ret = register_ftrace_direct_multi(&direct, my_tramp);
> +	ret = register_ftrace_direct(&direct, my_tramp);
>  	if (!ret)
>  		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
>  	return ret;
> @@ -141,12 +141,12 @@ static int __init ftrace_direct_init(void)
>  static void __exit ftrace_direct_exit(void)
>  {
>  	kthread_stop(simple_tsk);
> -	unregister_ftrace_direct_multi(&direct, my_tramp);
> +	unregister_ftrace_direct(&direct, my_tramp);
>  }
>  
>  module_init(ftrace_direct_init);
>  module_exit(ftrace_direct_exit);
>  
>  MODULE_AUTHOR("Steven Rostedt");
> -MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
> +MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
>  MODULE_LICENSE("GPL");
> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
> index d52370cad0b6..407c56325e65 100644
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -123,7 +123,7 @@ static int simple_thread(void *arg)
>  		if (ret)
>  			continue;
>  		t ^= 1;
> -		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
> +		ret = modify_ftrace_direct(&direct, tramps[t]);
>  		if (!ret)
>  			my_tramp = tramps[t];
>  		WARN_ON_ONCE(ret);
> @@ -141,7 +141,7 @@ static int __init ftrace_direct_multi_init(void)
>  	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
>  	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
>  
> -	ret = register_ftrace_direct_multi(&direct, my_tramp);
> +	ret = register_ftrace_direct(&direct, my_tramp);
>  
>  	if (!ret)
>  		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
> @@ -151,12 +151,12 @@ static int __init ftrace_direct_multi_init(void)
>  static void __exit ftrace_direct_multi_exit(void)
>  {
>  	kthread_stop(simple_tsk);
> -	unregister_ftrace_direct_multi(&direct, my_tramp);
> +	unregister_ftrace_direct(&direct, my_tramp);
>  }
>  
>  module_init(ftrace_direct_multi_init);
>  module_exit(ftrace_direct_multi_exit);
>  
>  MODULE_AUTHOR("Jiri Olsa");
> -MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
> +MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
>  MODULE_LICENSE("GPL");
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> index ec1088922517..42a94806a446 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -73,17 +73,17 @@ static int __init ftrace_direct_multi_init(void)
>  	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
>  	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
>  
> -	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> +	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
>  }
>  
>  static void __exit ftrace_direct_multi_exit(void)
>  {
> -	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> +	unregister_ftrace_direct(&direct, (unsigned long) my_tramp);
>  }
>  
>  module_init(ftrace_direct_multi_init);
>  module_exit(ftrace_direct_multi_exit);
>  
>  MODULE_AUTHOR("Jiri Olsa");
> -MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
> +MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
>  MODULE_LICENSE("GPL");
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index 0e907092e2c0..7ee5dd3cc61d 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -76,17 +76,17 @@ static int __init ftrace_direct_init(void)
>  {
>  	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
>  
> -	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> +	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
>  }
>  
>  static void __exit ftrace_direct_exit(void)
>  {
> -	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
> +	unregister_ftrace_direct(&direct, (unsigned long)my_tramp);
>  }
>  
>  module_init(ftrace_direct_init);
>  module_exit(ftrace_direct_exit);
>  
>  MODULE_AUTHOR("Steven Rostedt");
> -MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct_multi()");
> +MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
>  MODULE_LICENSE("GPL");
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> index e446c38f6b58..5ffce87fa83e 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -69,17 +69,17 @@ static int __init ftrace_direct_init(void)
>  {
>  	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
>  
> -	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
> +	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
>  }
>  
>  static void __exit ftrace_direct_exit(void)
>  {
> -	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
> +	unregister_ftrace_direct(&direct, (unsigned long)my_tramp);
>  }
>  
>  module_init(ftrace_direct_init);
>  module_exit(ftrace_direct_exit);
>  
>  MODULE_AUTHOR("Steven Rostedt");
> -MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
> +MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
>  MODULE_LICENSE("GPL");
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 
