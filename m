Return-Path: <bpf+bounces-27193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E896C8AA666
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CFF282906
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DD5818;
	Fri, 19 Apr 2024 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oppxipOF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFD387;
	Fri, 19 Apr 2024 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713488447; cv=none; b=KSxucfK8OBovkd2HWVsldtGj1TEFVzN7TYXGxH4aK2LqzF5NxDaj3YEIUdvhoCuETFqzII9DlhZts5tkQwa1++8uyioQacS9W+CcINqHsWtoWOefqn25gdHSTFOfFOvsJh8Bd25aUtFbFANsuwxjmvBQjiTyW9WiLJbxYmGGmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713488447; c=relaxed/simple;
	bh=XFzhEyqV5YsqpLwt4BrqCkFpF2S281XGzoHpYGcHyHY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N3V9rSbSmUqVa7ofPar6l446WF44ZQasxs3+o3Z+/2sDh9A//pvCSGJJj2xBHsPLJ57Y/VOg8pBgm25OmwKHZc9hwA7kf5EvxwdXcIckUiWxdN5/u7uPI+auNow22D5CFGJXNx4rT+sVuEo+VaE812LJhDQaEDnL4kANYOJpDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oppxipOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3033C113CC;
	Fri, 19 Apr 2024 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713488445;
	bh=XFzhEyqV5YsqpLwt4BrqCkFpF2S281XGzoHpYGcHyHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oppxipOFse5GDwNE649jX4M8R55x4t+JEpvOcxdXYx0DVQEckHLqNjSM/MkzEJ+Jl
	 wlK0IXurU+kgpYBTUor4vMzemNj7lI7osK+42pSL/taipdQUZ7d5+1vV4+qL/p1Sgt
	 D3DGlkdBGu+LX1DoXZHuRmCrGm/YBqofwaNKraNm7wiXw+WJtVOfxM7vY8WrjMTsM+
	 +WSoNIfMHRUvxRUH4HDbXkdPnlfxuTWifw/xOU+aFgk0MSkzsS8ZvattAlZz/9PMcC
	 +Wvxh3JrY8GRz6qHo6RUIit0qXThziTPXFHdFhJCzFvdwF9YTqrbqeReRdi8pcMeOh
	 V7lZQ1Uv7NZQA==
Date: Fri, 19 Apr 2024 10:00:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>
Subject: Re: [PATCH v4 2/2] rethook: honor
 CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING in rethook_try_get()
Message-Id: <20240419100041.87152aa873cbf25e52b8bd4f@kernel.org>
In-Reply-To: <20240418190909.704286-2-andrii@kernel.org>
References: <20240418190909.704286-1-andrii@kernel.org>
	<20240418190909.704286-2-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 12:09:09 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Take into account CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING when validating
> that RCU is watching when trying to setup rethooko on a function entry.
> 
> One notable exception when we force rcu_is_watching() check is
> CONFIG_KPROBE_EVENTS_ON_NOTRACE=y case, in which case kretprobes will use
> old-style int3-based workflow instead of relying on ftrace, making RCU
> watching check important to validate.
> 
> This further (in addition to improvements in the previous patch)
> improves BPF multi-kretprobe (which rely on rethook) runtime throughput
> by 2.3%, according to BPF benchmarks ([0]).
> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>


Thanks for update! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/rethook.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index fa03094e9e69..a974605ad7a5 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -166,6 +166,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
>  	if (unlikely(!handler))
>  		return NULL;
>  
> +#if defined(CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING) || defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
>  	/*
>  	 * This expects the caller will set up a rethook on a function entry.
>  	 * When the function returns, the rethook will eventually be reclaimed
> @@ -174,6 +175,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
>  	 */
>  	if (unlikely(!rcu_is_watching()))
>  		return NULL;
> +#endif
>  
>  	return (struct rethook_node *)objpool_pop(&rh->pool);
>  }
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

