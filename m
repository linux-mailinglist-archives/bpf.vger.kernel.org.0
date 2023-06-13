Return-Path: <bpf+bounces-2549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD772EE43
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 23:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B00E28115F
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9503ED8B;
	Tue, 13 Jun 2023 21:48:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC043D385
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 21:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F151C433C8;
	Tue, 13 Jun 2023 21:48:47 +0000 (UTC)
Date: Tue, 13 Jun 2023 17:48:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC] fprobe call of rethook_try_get faults
Message-ID: <20230613174844.4d50991d@gandalf.local.home>
In-Reply-To: <ZICzdpvp46Xk1rIv@krava>
References: <ZICzdpvp46Xk1rIv@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jun 2023 09:42:30 -0700
Jiri Olsa <olsajiri@gmail.com> wrote:

> I can't really reliable reproduce this, but while checking the code, I wonder
> we should call rethook_free only after we call unregister_ftrace_function like
> in the patch below

Yeah, I think you're right!

> 
> jirka
> 
> 
> ---
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 18d36842faf5..0121e8c0d54e 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -364,19 +364,13 @@ int unregister_fprobe(struct fprobe *fp)
>  		    fp->ops.saved_func != fprobe_kprobe_handler))
>  		return -EINVAL;
>  
> -	/*
> -	 * rethook_free() starts disabling the rethook, but the rethook handlers
> -	 * may be running on other processors at this point. To make sure that all
> -	 * current running handlers are finished, call unregister_ftrace_function()
> -	 * after this.
> -	 */
> -	if (fp->rethook)
> -		rethook_free(fp->rethook);

The above only waits for RCU to finish and then starts to free rethook.

This also means that something could be on the trampoline already and was
preempted. It could be that this code path gets preempted. Anyway, I don't
see how freeing rethook is safe before disabling all users.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> -
>  	ret = unregister_ftrace_function(&fp->ops);
>  	if (ret < 0)
>  		return ret;
>  
> +	if (fp->rethook)
> +		rethook_free(fp->rethook);
> +
>  	ftrace_free_filter(&fp->ops);
>  
>  	return ret;


