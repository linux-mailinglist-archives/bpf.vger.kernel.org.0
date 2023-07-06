Return-Path: <bpf+bounces-4251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C6749E47
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE0D1C20D7D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BAA9454;
	Thu,  6 Jul 2023 13:56:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B49440
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC0AC433C8;
	Thu,  6 Jul 2023 13:56:26 +0000 (UTC)
Date: Thu, 6 Jul 2023 09:56:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, lkml
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Ensure running fprobe_exit_handler() finished
 before calling rethook_free()
Message-ID: <20230706095624.3a846b8e@gandalf.local.home>
In-Reply-To: <20230706141012.c1a0ae0901e0fdec7b3078c7@kernel.org>
References: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
	<168796344232.46347.7947681068822514750.stgit@devnote2>
	<20230705212657.5968daf7@gandalf.local.home>
	<20230706141012.c1a0ae0901e0fdec7b3078c7@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jul 2023 14:10:12 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> With only Jiri's patch, following flow can happen;
> 
> ------
>  CPU1                              CPU2
>  call unregister_fprobe()
>  ...
>                                    __fprobe_handler()
>                                    rethook_hook() on probed function
>  unregister_ftrace_function()
>                                    return from probed function
>                                    rethook hooks
>                                    find rh->handler == fprobe_exit_handler
>                                    call fprobe_exit_handler()
>  rethook_free():
>    set rh->handler = NULL;
>  return from unreigster_fprobe;
>                                    call fp->exit_handler() <- (*)
> 
> (*) In this point, the exit handler is called after returning from 
> unregister_fprobe().
> ------
> 
> So, this patch changes it as following;
> ------
>  CPU1                              CPU2
>  call unregister_fprobe()
>  ...
>  rethook_stop():
>    set rh->handler = NULL;
>                                    __fprobe_handler()
>                                    rethook_hook() on probed function
>  unregister_ftrace_function()
>                                    return from probed function
>                                    rethook hooks
>                                    find rh->handler == NULL
>                                    return from rethook
>  rethook_free()
>  return from unreigster_fprobe;
> ------
> 
> I can also just put a synchronize_sched_rcu() right after rethook_free()
> to wait for all running fprobe_exit_handler() too.
> 

This makes more sense. Can you please add the above to the change log.

Thanks,

-- Steve

