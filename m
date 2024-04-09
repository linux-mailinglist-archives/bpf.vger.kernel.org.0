Return-Path: <bpf+bounces-26329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4301489E5BB
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747861C21260
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 22:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53734158A2B;
	Tue,  9 Apr 2024 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQmmTz5z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CF433A6;
	Tue,  9 Apr 2024 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702903; cv=none; b=UW9XqG8R+gZv/OKOnm9IZDE0vbNc0BnZLcwdnPr4G8g2WaHcrQD1NTyT0isY6ItfievAYVod/YCGG1R/BYSiMR83/zBdZls2Gd1u0okjx2xjwuiVpQmqJnR4ERB3+lulOIRWS+yBGY3c/ea2XJw1QxG7S0amzWhRlMYF13tH3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702903; c=relaxed/simple;
	bh=RCIlyYs13xauidUvXK1OervIeHocqfIqEu2xfGP/MFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kXDWQxNs79t5ydEfG7KXQg7rBXBXDOi60f589mpQq0acQsAoFFaNeHINgSzFaWRvn6bDu04uF19edAWKXvtjkuLY/xfU4X2MfdCYs6ONVsP1zW/s57nepQtg2pn+LylvOcvEGIlJiTjm44WOG6HXdAg8A2SaCdVmHHFlCmiB4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQmmTz5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C2AC433F1;
	Tue,  9 Apr 2024 22:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712702903;
	bh=RCIlyYs13xauidUvXK1OervIeHocqfIqEu2xfGP/MFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bQmmTz5zPqyJULiUQ9BiwZ+XMniF3OFSrOdSpwW6cpiHthJtPg7DBMQzF5RgUIpOV
	 g/jBu3hZMnDdhHUBvC+1hKylxIreuZLEws2Uxh5DKTBsGUKVdlTnPOmr0EI33pqVqZ
	 iZoTrQikvQ6/LxCU/ocnB5HArXvk+l9W1mpu295pS4jFVGMXcS1OJlGy7ZVgn0D5H0
	 +BZIVVFOmEfoLXzN6HDUNWBrUNtW+ugmgJIgAevYCksc2mr2eX3XfERwIm+Z/jslTp
	 77tchKNAu1V0WbMJ6C4EWiVhwZzHGAliv+8j7gH2EU/+XDRDMkO+bk/XEkyJvFCrZJ
	 lI+/ARzOxEDkA==
Date: Wed, 10 Apr 2024 07:48:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>
Subject: Re: [PATCH v3 2/2] rethook: honor
 CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING in rethook_try_get()
Message-Id: <20240410074819.9b3a9a6d6a53d534b9915dc8@kernel.org>
In-Reply-To: <20240403220328.455786-2-andrii@kernel.org>
References: <20240403220328.455786-1-andrii@kernel.org>
	<20240403220328.455786-2-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 15:03:28 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Take into account CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING when validating
> that RCU is watching when trying to setup rethooko on a function entry.
> 
> This further (in addition to improvements in the previous patch)
> improves BPF multi-kretprobe (which rely on rethook) runtime throughput
> by 2.3%, according to BPF benchmarks ([0]).
> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com/
> 

Hi Andrii,

Can you make this part depends on !KPROBE_EVENTS_ON_NOTRACE (with this
option, kretprobes can be used without ftrace, but with original int3) ?
This option should be set N on production system because of safety,
just for testing raw kretprobes.

Thank you,

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/trace/rethook.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index fa03094e9e69..15b8aa4048d9 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -166,6 +166,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
>  	if (unlikely(!handler))
>  		return NULL;
>  
> +#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
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

