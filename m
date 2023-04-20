Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF026E8AA4
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 08:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjDTGvx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjDTGvw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 02:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76D1FE4;
        Wed, 19 Apr 2023 23:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFE4564557;
        Thu, 20 Apr 2023 06:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12DEC433EF;
        Thu, 20 Apr 2023 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681973510;
        bh=8aUhQHxP2OH7rnWWvgHTSZOrsTIfsKF0J85Hymzdvbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ahsFN66RabqGD8NhT4bISSgI0WVrH74WIIBgAJpxHOL7xIWiYJv3qAfExi2FcxgTJ
         vWPMnkgO5gPyOtDECtV8ULkCDSZV53ubCLlC7PiQSwY/K6f9AmHKIU6euTOR6ZpT8D
         7afMFNSaRzfjibny86M6OXTP3hEpWxupk0TP1loKA3wjPaXLgidWsEcIDpQAHv2wk8
         5oIOsr9pVoIVSqftO/ccouK+sasRu1koFpnfVsGUm5MKBEggjH8nzn52bNctovFKP+
         DNXUVKO1MsM0SZPpFfx5VOLG0IY+MuC1nUAEKdKYD4nXGhcgjo3gSSMolEghXKrRy5
         anN4afMjjRxhA==
Date:   Thu, 20 Apr 2023 15:51:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] tracing: Add generic
 test_recursion_try_acquire()
Message-Id: <20230420155146.56099afbc6c73fc2e1065c62@kernel.org>
In-Reply-To: <20230417154737.12740-3-laoar.shao@gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
        <20230417154737.12740-3-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 17 Apr 2023 15:47:33 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The ftrace_test_recursion_trylock() also disables preemption. This is not
> required, but was a clean up as every place that called it also disabled
> preemption, and making the two tightly coupled appeared to make the code
> simpler.
> 
> But the recursion protection can be used for other purposes that do not
> require disabling preemption. As the recursion bits are attached to the
> task_struct, it follows the task, so there's no need for preemption being
> disabled.
> 
> Add test_recursion_try_acquire/release() functions to be used generically,
> and separate it from being associated with ftrace. It also removes the
> "lock" name, as there is no lock happening. Keeping the "lock" for the
> ftrace version is better, as it at least differentiates that preemption is
> being disabled (hence, "locking the CPU").
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230321020103.13494-1-laoar.shao@gmail.com/
> 
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  include/linux/trace_recursion.h | 47 ++++++++++++++++++++++++++++++-----------
>  kernel/trace/ftrace.c           |  2 ++
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> index d48cd92..80de2ee 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -150,9 +150,6 @@ static __always_inline int trace_get_context_bit(void)
>  # define trace_warn_on_no_rcu(ip)	false
>  #endif
>  
> -/*
> - * Preemption is promised to be disabled when return bit >= 0.
> - */
>  static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
>  							int start)
>  {
> @@ -182,18 +179,11 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
>  	val |= 1 << bit;
>  	current->trace_recursion = val;
>  	barrier();
> -
> -	preempt_disable_notrace();
> -
>  	return bit;
>  }
>  
> -/*
> - * Preemption will be enabled (if it was previously enabled).
> - */
>  static __always_inline void trace_clear_recursion(int bit)
>  {
> -	preempt_enable_notrace();
>  	barrier();
>  	trace_recursion_clear(bit);
>  }
> @@ -205,12 +195,18 @@ static __always_inline void trace_clear_recursion(int bit)
>   * tracing recursed in the same context (normal vs interrupt),
>   *
>   * Returns: -1 if a recursion happened.
> - *           >= 0 if no recursion.
> + *           >= 0 if no recursion and preemption will be disabled.
>   */
>  static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
>  							 unsigned long parent_ip)
>  {
> -	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
> +	int bit;
> +
> +	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
> +	if (unlikely(bit < 0))
> +		return bit;
> +	preempt_disable_notrace();
> +	return bit;
>  }
>  
>  /**
> @@ -221,6 +217,33 @@ static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
>   */
>  static __always_inline void ftrace_test_recursion_unlock(int bit)
>  {
> +	preempt_enable_notrace();
> +	trace_clear_recursion(bit);
> +}
> +
> +/**
> + * test_recursion_try_acquire - tests for recursion in same context
> + *
> + * This will detect recursion of a function.
> + *
> + * Returns: -1 if a recursion happened.
> + *           >= 0 if no recursion
> + */
> +static __always_inline int test_recursion_try_acquire(unsigned long ip,
> +						      unsigned long parent_ip)
> +{
> +	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
> +}
> +
> +/**
> + * test_recursion_release - called after a success of test_recursion_try_acquire()
> + * @bit: The return of a successful test_recursion_try_acquire()
> + *
> + * This releases the recursion lock taken by a non-negative return call
> + * by test_recursion_try_acquire().
> + */
> +static __always_inline void test_recursion_release(int bit)
> +{
>  	trace_clear_recursion(bit);
>  }
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c67bcc8..8ad3ab4 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7647,6 +7647,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
>  	if (bit < 0)
>  		return;
>  
> +	preempt_disable();
>  	do_for_each_ftrace_op(op, ftrace_ops_list) {
>  		/* Stub functions don't need to be called nor tested */
>  		if (op->flags & FTRACE_OPS_FL_STUB)
> @@ -7668,6 +7669,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
>  		}
>  	} while_for_each_ftrace_op(op);
>  out:
> +	preempt_enable();
>  	trace_clear_recursion(bit);
>  }
>  
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
