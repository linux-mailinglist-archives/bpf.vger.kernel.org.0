Return-Path: <bpf+bounces-4140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0131E749312
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9FF1C20C61
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05988A35;
	Thu,  6 Jul 2023 01:27:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE57F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07823C433C7;
	Thu,  6 Jul 2023 01:26:59 +0000 (UTC)
Date: Wed, 5 Jul 2023 21:26:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, lkml
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Ensure running fprobe_exit_handler() finished
 before calling rethook_free()
Message-ID: <20230705212657.5968daf7@gandalf.local.home>
In-Reply-To: <168796344232.46347.7947681068822514750.stgit@devnote2>
References: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
	<168796344232.46347.7947681068822514750.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 23:44:02 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Ensure running fprobe_exit_handler() has finished before
> calling rethook_free() in the unregister_fprobe() so that caller can free
> the fprobe right after unregister_fprobe().
> 
> unregister_fprobe() ensured that all running fprobe_entry/exit_handler()
> have finished by calling unregister_ftrace_function() which synchronizes
> RCU. But commit 5f81018753df ("fprobe: Release rethook after the
> ftrace_ops is unregistered") changed to call rethook_free() after
> unregister_ftrace_function(). So call rethook_stop() to make rethook
> disabled before unregister_ftrace_function() and ensure it again.

I'm confused. I still don't understand why it is bad to call
unregister_ftrace_function() *before* rethook_free().

Can you show the race condition you are trying to avoid?

-- Steve



> 
> Fixes: 5f81018753df ("fprobe: Release rethook after the ftrace_ops is
> unregistered") Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/rethook.h |    1 +
>  kernel/trace/fprobe.c   |    3 +++
>  kernel/trace/rethook.c  |   13 +++++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/rethook.h b/include/linux/rethook.h
> index c8ac1e5afcd1..bdbe6717f45a 100644
> --- a/include/linux/rethook.h
> +++ b/include/linux/rethook.h
> @@ -59,6 +59,7 @@ struct rethook_node {
>  };
>  
>  struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
> +void rethook_stop(struct rethook *rh);
>  void rethook_free(struct rethook *rh);
>  void rethook_add_node(struct rethook *rh, struct rethook_node *node);
>  struct rethook_node *rethook_try_get(struct rethook *rh);
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 0121e8c0d54e..75517667b54f 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -364,6 +364,9 @@ int unregister_fprobe(struct fprobe *fp)
>  		    fp->ops.saved_func != fprobe_kprobe_handler))
>  		return -EINVAL;
>  
> +	if (fp->rethook)
> +		rethook_stop(fp->rethook);
> +
>  	ret = unregister_ftrace_function(&fp->ops);
>  	if (ret < 0)
>  		return ret;
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 60f6cb2b486b..468006cce7ca 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -53,6 +53,19 @@ static void rethook_free_rcu(struct rcu_head *head)
>  		kfree(rh);
>  }
>  
> +/**
> + * rethook_stop() - Stop using a rethook.
> + * @rh: the struct rethook to stop.
> + *
> + * Stop using a rethook to prepare for freeing it. If you want to wait
> for
> + * all running rethook handler before calling rethook_free(), you need to
> + * call this first and wait RCU, and call rethook_free().
> + */
> +void rethook_stop(struct rethook *rh)
> +{
> +	WRITE_ONCE(rh->handler, NULL);
> +}
> +
>  /**
>   * rethook_free() - Free struct rethook.
>   * @rh: the struct rethook to be freed.


