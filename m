Return-Path: <bpf+bounces-4648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2A74E0DC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 00:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63F8281301
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91F1641D;
	Mon, 10 Jul 2023 22:04:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A815156CD
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 22:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA644C433C7;
	Mon, 10 Jul 2023 22:04:24 +0000 (UTC)
Date: Mon, 10 Jul 2023 18:04:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, lkml
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2] fprobe: Ensure running fprobe_exit_handler()
 finished before calling rethook_free()
Message-ID: <20230710180422.572d7c21@gandalf.local.home>
In-Reply-To: <168873859949.156157.13039240432299335849.stgit@devnote2>
References: <168873859949.156157.13039240432299335849.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jul 2023 23:03:19 +0900
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
> Here is the possible code flow that can call the exit handler after
> unregister_fprobe().
> 
> ------
>  CPU1                              CPU2
>  call unregister_fprobe(fp)
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
> ------
> 
> (*) At this point, the exit handler is called after returning from
> unregister_fprobe().
> 
> This fixes it as following;
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
> 
> Fixes: 5f81018753df ("fprobe: Release rethook after the ftrace_ops is unregistered")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Looks good.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>


> ---
>  Changes in v2:
>  - Update changelog to add a problematic code flow.

Nit, for making forensic analysis easier in the future, I now always add a
link to the previous version. That is:

Changes since v1: https://lore.kernel.org/linux-trace-kernel/168796344232.46347.7947681068822514750.stgit@devnote2/
- Update changelog to add a problematic code flow.

-- Steve


> ---
>  include/linux/rethook.h |    1 +
>  kernel/trace/fprobe.c   |    3 +++
>  kernel/trace/rethook.c  |   13 +++++++++++++
>  3 files changed, 17 insertions(+)
> 

