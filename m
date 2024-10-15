Return-Path: <bpf+bounces-42106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E7099FB6A
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 00:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661D5286433
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A01D0F42;
	Tue, 15 Oct 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMsoD6Ls"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3301B0F0F;
	Tue, 15 Oct 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729031073; cv=none; b=QEQUXblPnmXnO0QPnuP8U49aUIs7q95YKdXdynUUAroZ/GXZW/+LQ7hsDFMIoRtweo44tFibEYC+k+BHEXBcn2tCC4HSZt9aEZIOsqFuSYvVQwtRZ7Yw0SNipMKLV3tsQDupEGjPxq0/ia/075OY1Wc1ig6lcJZRVBLPID6AHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729031073; c=relaxed/simple;
	bh=tSAPdkBdHjG9+KNs4Rn2ppfn4xpMBH1qHfM0L+k/jxg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bpnfu8ME1tTwbbih3l351o3D6s+fs0eZu7eBYpLxvONZ60tPGB2hE5qPSlztNiR89gX2OFUjuSl/yHZ13hKloaDh4eajJoysbdJjn4Bw9EcvgVnaraL6JTMBOEAiu/1BOnBzWrnLWIOShVpoL4i7J5h/PwP5VC2bG1Ps+9pyRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMsoD6Ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71F1C4CEC6;
	Tue, 15 Oct 2024 22:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729031072;
	bh=tSAPdkBdHjG9+KNs4Rn2ppfn4xpMBH1qHfM0L+k/jxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMsoD6LsW2VTgsUXW+U4SX1+lVzBhyR49NI7EQsGUIe868usg+6KwGhVCBdvdjXeu
	 gEPsKwBEugHUaHtux2OFkYxlYfgCWMp+ycKmya54C5s38MmCMwW6qzItGv7W5+MZKQ
	 Vkj14bWCBjfK60TgH0mfSfltjbJZUQR+hl8sCERRwXVkvlzR1Z0X3WRiELBynmrmEU
	 LGnjeimQgbW/tNlfIchzX2v8Bh9cVSf/naKzAJIFfig92oWe4TgVnpTZzFg9Zap/sk
	 XmTvPpPxweKg3qOk6h59ZLvpU+zHFJ98F7GBUVoZFjHQPYVZjx0lrftgkcFEhONwzX
	 mP6rd82m59eZA==
Date: Wed, 16 Oct 2024 07:24:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv6 perf/core 01/16] uprobe: Add data pointer to consumer
 handlers
Message-Id: <20241016072426.c6f7b9572b946dd31c0c1fb8@kernel.org>
In-Reply-To: <20241010200957.2750179-2-jolsa@kernel.org>
References: <20241010200957.2750179-1-jolsa@kernel.org>
	<20241010200957.2750179-2-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 22:09:42 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding data pointer to both entry and exit consumer handlers and all
> its users. The functionality itself is coming in following change.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Alexei, please merge this series via bpf tree, since most of the patches
in this series are for bpf.

Thank you,

> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h                              |  4 ++--
>  kernel/events/uprobes.c                              |  4 ++--
>  kernel/trace/bpf_trace.c                             |  6 ++++--
>  kernel/trace/trace_uprobe.c                          | 12 ++++++++----
>  .../testing/selftests/bpf/bpf_testmod/bpf_testmod.c  |  2 +-
>  5 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 2b294bf1881f..bb265a632b91 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -37,10 +37,10 @@ struct uprobe_consumer {
>  	 * for the current process. If filter() is omitted or returns true,
>  	 * UPROBE_HANDLER_REMOVE is effectively ignored.
>  	 */
> -	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
> +	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
>  	int (*ret_handler)(struct uprobe_consumer *self,
>  				unsigned long func,
> -				struct pt_regs *regs);
> +				struct pt_regs *regs, __u64 *data);
>  	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
>  
>  	struct list_head cons_node;
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2a0059464383..6b44c386a5df 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2090,7 +2090,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  		int rc = 0;
>  
>  		if (uc->handler) {
> -			rc = uc->handler(uc, regs);
> +			rc = uc->handler(uc, regs, NULL);
>  			WARN(rc & ~UPROBE_HANDLER_MASK,
>  				"bad rc=0x%x from %ps()\n", rc, uc->handler);
>  		}
> @@ -2128,7 +2128,7 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
>  	rcu_read_lock_trace();
>  	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
>  		if (uc->ret_handler)
> -			uc->ret_handler(uc, ri->func, regs);
> +			uc->ret_handler(uc, ri->func, regs, NULL);
>  	}
>  	rcu_read_unlock_trace();
>  }
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a582cd25ca87..fdab7ecd8dfa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3244,7 +3244,8 @@ uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
>  }
>  
>  static int
> -uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
> +uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
> +			  __u64 *data)
>  {
>  	struct bpf_uprobe *uprobe;
>  
> @@ -3253,7 +3254,8 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
>  }
>  
>  static int
> -uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
> +uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs,
> +			      __u64 *data)
>  {
>  	struct bpf_uprobe *uprobe;
>  
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c40531d2cbad..5895eabe3581 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -89,9 +89,11 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
>  static int register_uprobe_event(struct trace_uprobe *tu);
>  static int unregister_uprobe_event(struct trace_uprobe *tu);
>  
> -static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
> +static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
> +			     __u64 *data);
>  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> -				unsigned long func, struct pt_regs *regs);
> +				unsigned long func, struct pt_regs *regs,
> +				__u64 *data);
>  
>  #ifdef CONFIG_STACK_GROWSUP
>  static unsigned long adjust_stack_addr(unsigned long addr, unsigned int n)
> @@ -1517,7 +1519,8 @@ trace_uprobe_register(struct trace_event_call *event, enum trace_reg type,
>  	}
>  }
>  
> -static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
> +static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs,
> +			     __u64 *data)
>  {
>  	struct trace_uprobe *tu;
>  	struct uprobe_dispatch_data udd;
> @@ -1548,7 +1551,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
>  }
>  
>  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> -				unsigned long func, struct pt_regs *regs)
> +				unsigned long func, struct pt_regs *regs,
> +				__u64 *data)
>  {
>  	struct trace_uprobe *tu;
>  	struct uprobe_dispatch_data udd;
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 8835761d9a12..12005e3dc3e4 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -461,7 +461,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
>  
>  static int
>  uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
> -		   struct pt_regs *regs)
> +		   struct pt_regs *regs, __u64 *data)
>  
>  {
>  	regs->ax  = 0x12345678deadbeef;
> -- 
> 2.46.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

