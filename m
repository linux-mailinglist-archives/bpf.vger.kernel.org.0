Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322F56F0694
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbjD0N0e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjD0N0d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 09:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4103449E;
        Thu, 27 Apr 2023 06:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F0C63D68;
        Thu, 27 Apr 2023 13:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B31C4339B;
        Thu, 27 Apr 2023 13:26:29 +0000 (UTC)
Date:   Thu, 27 Apr 2023 09:26:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention
 mechanism
Message-ID: <20230427092628.21fd23e4@gandalf.local.home>
In-Reply-To: <20230417154737.12740-6-laoar.shao@gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
        <20230417154737.12740-6-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 17 Apr 2023 15:47:36 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index f61d513..3df39a5 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -842,15 +842,21 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
>  static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
>  	__acquires(RCU)

Because __bpf_prog_enter_recur() and __bpf_prog_exit_recur() can
legitimately nest (as you pointed out later in the thread), I think my
original plan is the way to go.



>  {
> -	rcu_read_lock();
> -	migrate_disable();
> -
> -	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> +	int bit;
>  
> -	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> +	rcu_read_lock();
> +	bit = test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
> +	run_ctx->recursion_bit = bit;
> +	if (bit < 0) {
> +		preempt_disable_notrace();
>  		bpf_prog_inc_misses_counter(prog);
> +		preempt_enable_notrace();
>  		return 0;
>  	}
> +
> +	migrate_disable();

Just encompass the migrate_disable/enable() with the recursion protection.

That is, here add:

	test_recursion_release(recursion_bit);

No need to save it in the run_ctx, as you can use a local variable.

As I mentioned, if it passes when checking migrate_disable() it will also
pass when checking around migrate_enable() so the two will still be paired
properly, even if only the migrate_enable() starts recursing.


  bit = test_recursion_try_acquire() // OK
  if (bit < 0)
	return;
  migrate_disable();
  test_recursion_release(bit);

  [..]

  bit = test_recursion_try_acquire() // OK
  migrate_enable() // traced and recurses...

    bit = test_recursion_try_acquire() // fails
    if (bit < 0)
          return; // returns here
    migrate_disable() // does not get called.

The recursion around migrate_disable/enable() is needed because it's done
before other checks. You can't attach the test_recursion logic to the
__bpf_prog_enter/exit() routines, because those can legitimately recurse.

-- Steve


> +
> +	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
>  	return bpf_prog_start_time();
>  }
