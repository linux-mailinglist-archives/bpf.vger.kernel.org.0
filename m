Return-Path: <bpf+bounces-27181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF88AA589
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 00:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8931F22ABF
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA7641A8F;
	Thu, 18 Apr 2024 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUpH7dla"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7339855;
	Thu, 18 Apr 2024 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480817; cv=none; b=fOqCmPOxvsX8fYhu83//3H7sR1/Eps0U5NbexJHZ2V05oa6/exmpzSv4dlnI/Kp5kndRzMDbQSpSmQnEKlLH/ceyzIVUHbcm4mOK0Y03umUeR4SEnjylpGIVD+7e+eYeaz/lSd3AOyfxRa9e/idhDMM3m/pvRogwUIT2Np5wKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480817; c=relaxed/simple;
	bh=XJKLoY5NTUWmbPndYQwRMgVnuD1gyGxJfLhRe0J1frQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM0pTSWGKwy1uQwk5Ednf6HdJQ3qDHwF6iZFO0AFhGY7QaDfwNY7KcarwSPHjHTmvBwKTiRmsKym/cWCQ8zVQdXF05O0q3u1I/G05YhdYOClUuF6dqPz6g52fsTXxygvgL0fA4JuQnZEWmIxLwdWAbhU8RpcaAALRjwslMplsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUpH7dla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9839AC113CC;
	Thu, 18 Apr 2024 22:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713480816;
	bh=XJKLoY5NTUWmbPndYQwRMgVnuD1gyGxJfLhRe0J1frQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TUpH7dlag0Ad37qfkEl6lfQUaYVFuANBmjtIoCkT4bj3MEr9buZi8e6/MWjN53DTi
	 1ZIIfXcVfpMpuCOb8tBSRvnz/akDa5riN2Fuv8a97JTvUZnkKWrSfugI/9d2Ck3XQR
	 mbEFEqLPuyfRCKCKoSYSnTaT6BZyYEkvl09pyX+GRRkTW5C4becz2w/Ch252P2PjsU
	 Sb2Ll8DR7O5i0I7ma7MN/oXd17ko2Yn8gpeQ6jfsgtzFucgAPOKRuq9TjC43sTOryc
	 o0asrJjDTTqHSEyX0/LUv4eoDlewgfjsaZzcopvicB6nEdpGbTVatbfPUwNldA3kvh
	 oApFIhtroA/tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2155FCE1578; Thu, 18 Apr 2024 15:53:34 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:53:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v4 2/2] rethook: honor
 CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING in rethook_try_get()
Message-ID: <2b9e2c11-c118-4518-8811-bf1be111fa4b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240418190909.704286-1-andrii@kernel.org>
 <20240418190909.704286-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418190909.704286-2-andrii@kernel.org>

On Thu, Apr 18, 2024 at 12:09:09PM -0700, Andrii Nakryiko wrote:
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

Acked-by: Paul E. McKenney <paulmck@kernel.org>

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

