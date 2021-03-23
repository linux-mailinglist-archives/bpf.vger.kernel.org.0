Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE425345ECA
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 13:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCWM7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 08:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231553AbhCWM7D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 08:59:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD62D619A9;
        Tue, 23 Mar 2021 12:59:01 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:59:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf] bpf: Fix fexit trampoline.
Message-ID: <20210323085900.3bdc0002@gandalf.local.home>
In-Reply-To: <YFjnlqeqbkST7oPb@krava>
References: <20210316210007.38949-1-alexei.starovoitov@gmail.com>
        <YFfXcqnksPsSe0Bv@krava>
        <YFjEt42mrWejbzgJ@krava>
        <YFjnlqeqbkST7oPb@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Mar 2021 19:53:10 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Mon, Mar 22, 2021 at 05:24:26PM +0100, Jiri Olsa wrote:
> > On Mon, Mar 22, 2021 at 12:32:05AM +0100, Jiri Olsa wrote:  
> > > On Tue, Mar 16, 2021 at 02:00:07PM -0700, Alexei Starovoitov wrote:  
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > 
> > > > The fexit/fmod_ret programs can be attached to kernel functions that can sleep.
> > > > The synchronize_rcu_tasks() will not wait for such tasks to complete.
> > > > In such case the trampoline image will be freed and when the task
> > > > wakes up the return IP will point to freed memory causing the crash.
> > > > Solve this by adding percpu_ref_get/put for the duration of trampoline
> > > > and separate trampoline vs its image life times.
> > > > The "half page" optimization has to be removed, since
> > > > first_half->second_half->first_half transition cannot be guaranteed to
> > > > complete in deterministic time. Every trampoline update becomes a new image.
> > > > The image with fmod_ret or fexit progs will be freed via percpu_ref_kill and
> > > > call_rcu_tasks. Together they will wait for the original function and
> > > > trampoline asm to complete. The trampoline is patched from nop to jmp to skip
> > > > fexit progs. They are freed independently from the trampoline. The image with
> > > > fentry progs only will be freed via call_rcu_tasks_trace+call_rcu_tasks which
> > > > will wait for both sleepable and non-sleepable progs to complete.
> > > > 
> > > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>  # for RCU
> > > > ---
> > > > Without ftrace fix:
> > > > https://patchwork.kernel.org/project/netdevbpf/patch/20210316195815.34714-1-alexei.starovoitov@gmail.com/
> > > > this patch will trigger warn in ftrace.
> > > > 
> > > >  arch/x86/net/bpf_jit_comp.c |  26 ++++-
> > > >  include/linux/bpf.h         |  24 +++-
> > > >  kernel/bpf/bpf_struct_ops.c |   2 +-
> > > >  kernel/bpf/core.c           |   4 +-
> > > >  kernel/bpf/trampoline.c     | 218 +++++++++++++++++++++++++++---------
> > > >  5 files changed, 213 insertions(+), 61 deletions(-)
> > > >   
> > > 
> > > hi,
> > > I'm on bpf/master and I'm triggering warnings below when running together:
> > > 
> > >   # while :; do ./test_progs -t fentry_test ; done
> > >   # while :; do ./test_progs -t module_attach ; done  
> > 
> > hum, is it possible that we don't take module ref and it can get
> > unloaded even if there's trampoline attach to it..? I can't see
> > that in the code.. ftrace_release_mod can't fail ;-)  
> 
> when I get the module for each module trampoline,
> I can no longer see those warnings (link for Steven):
>   https://lore.kernel.org/bpf/YFfXcqnksPsSe0Bv@krava/
> 
> Steven,
> I might be missing something, but it looks like module
> can be unloaded even if the trampoline (direct function)
> is registered in it.. is that right?
> 

Not with your patch below ;-)

But yes, ftrace does not currently manage module text for direct calls,
it's assumed that whoever attaches to the module text would do that. But
I'm not adverse to the patch below.

-- Steve


> thanks,
> jirka
> 
> 
> ---
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b7e29db127fa..ab0b2c8df283 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5059,6 +5059,28 @@ static struct ftrace_direct_func *ftrace_alloc_direct_func(unsigned long addr)
>  	return direct;
>  }
>  
> +static struct module *ftrace_direct_module_get(unsigned long ip)
> +{
> +	struct module *mod;
> +	int err = 0;
> +
> +	preempt_disable();
> +	mod = __module_text_address(ip);
> +	if (mod && !try_module_get(mod))
> +		err = -ENOENT;
> +	preempt_enable();
> +	return err ? ERR_PTR(err) : mod;
> +}
> +
> +static void ftrace_direct_module_put(unsigned long ip)
> +{
> +	struct module *mod;
> +
> +	mod = __module_text_address(ip);
> +	if (mod)
> +		module_put(mod);
> +}
> +
>  /**
>   * register_ftrace_direct - Call a custom trampoline directly
>   * @ip: The address of the nop at the beginning of a function
> @@ -5081,6 +5103,7 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
>  	struct ftrace_direct_func *direct;
>  	struct ftrace_func_entry *entry;
>  	struct ftrace_hash *free_hash = NULL;
> +	struct module *mod = NULL;
>  	struct dyn_ftrace *rec;
>  	int ret = -EBUSY;
>  
> @@ -5095,6 +5118,13 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
>  	if (!rec)
>  		goto out_unlock;
>  
> +	mod = ftrace_direct_module_get(ip);
> +	if (IS_ERR(mod)) {
> +		ret = -ENOENT;
> +		mod = NULL;
> +		goto out_unlock;
> +	}
> +
>  	/*
>  	 * Check if the rec says it has a direct call but we didn't
>  	 * find one earlier?
> @@ -5172,6 +5202,8 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
>   out_unlock:
>  	mutex_unlock(&direct_mutex);
>  
> +	if (ret)
> +		module_put(mod);
>  	if (free_hash) {
>  		synchronize_rcu_tasks();
>  		free_ftrace_hash(free_hash);
> @@ -5242,6 +5274,8 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
>  			ftrace_direct_func_count--;
>  		}
>  	}
> +	ftrace_direct_module_put(ip);
> +
>   out_unlock:
>  	mutex_unlock(&direct_mutex);
>  

