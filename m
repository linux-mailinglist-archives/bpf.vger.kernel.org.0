Return-Path: <bpf+bounces-4132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172F74921E
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 02:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF322811AA
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 00:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C215AF2;
	Wed,  5 Jul 2023 23:59:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92576156E0
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 23:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E861FC433C7;
	Wed,  5 Jul 2023 23:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688601594;
	bh=DHIRNBX13iCC8/JjXCLrk7kqMjmnnuGrMvA57hSWqdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S/cz9482QyzQkAuO2a2zJcUHnEQGqRKHU0imYli7KuJk4ryX7yfsr8qiGQatoIrXR
	 jctKlQ9m0v9B2/j2Sv98stJdRAuuIN/lrEDjcF4gzcavRUUEZopfaUOnJl/oIKLGmv
	 aUuZr+R1ZMDFlDbSHAK94v7v1nELQHlJl85Q1cCbFRYRscu0D5JwRUns4beo4FKMl4
	 jsaWDkrZcpdgN4FGTnCsBK0pBmKRyiLXbudflpOy6aAoT+vrr7fprAtaFrJM6XGVLJ
	 zn/L54BYNszBCaI2/7UGF1MC0w3t75cxFFYXehbqi1UwQTDRI4IS/+3U43C+ICUPEC
	 jAwsLYPnFeyYg==
Date: Thu, 6 Jul 2023 08:59:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mark
 Rutland <mark.rutland@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Ensure running fprobe_exit_handler() finished
 before calling rethook_free()
Message-Id: <20230706085949.846329012c99057ef99ea8ef@kernel.org>
In-Reply-To: <168796344232.46347.7947681068822514750.stgit@devnote2>
References: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
	<168796344232.46347.7947681068822514750.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
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
> RCU. But commit 5f81018753df ("fprobe: Release rethook after the ftrace_ops
> is unregistered") changed to call rethook_free() after
> unregister_ftrace_function(). So call rethook_stop() to make rethook
> disabled before unregister_ftrace_function() and ensure it again.
>

Steve, can you review this? without this fix, Jiri's patch may cause another
timing issue.

Thanks, 
 
> Fixes: 5f81018753df ("fprobe: Release rethook after the ftrace_ops is unregistered")
> Cc: stable@vger.kernel.org
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
> + * Stop using a rethook to prepare for freeing it. If you want to wait for
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
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

