Return-Path: <bpf+bounces-59345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC569AC8869
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 08:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969114E2205
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A420A5E5;
	Fri, 30 May 2025 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAmrLdeh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252910F1;
	Fri, 30 May 2025 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587881; cv=none; b=A+zG3X7ee0hmVd0DwJBog9EiMJNZPqAp/QJGGhwnCzgMiJTjbeORdhjPHZhMVC30d7Fg1GMCu3Pz75olGNAoC41F2AnpHyLzsuwk3IkkjtNEGomGucX0+FWRWyhvSbCDr7ItTey50S7sy6bweQqE2ouC9n8ii3hkUMHPU3NPX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587881; c=relaxed/simple;
	bh=R43qNv5hYtdx0wl8Yox3EDv5SXHjIdsJuLZz8KOnAgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm28Yx8C5hmrLQ3i0wqjJuarT3JL+BBkUWZLy7eTj7f9U83veIFDp/2/FE4EFdyB7X4bDwW6qpi/PQCGxuwPp88oiM7vANVuqvyfvdtxkdCaThUZr7/Z31C525Lqh+v7ot5de8Jtel81GK9UO94H18azOd60YXV7+ignMoZFzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAmrLdeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C28C4CEE9;
	Fri, 30 May 2025 06:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748587877;
	bh=R43qNv5hYtdx0wl8Yox3EDv5SXHjIdsJuLZz8KOnAgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SAmrLdeh5DQ8tt5efpZKbFBIVTHDJjTrCcEl5jZ3sbU6F5GeAd2jpPlw2tpf+n6hW
	 2HUcKTsfapaX3wlL2x68fdy3kst4I71ixuXiHuCTJ/53ee1Ni6gMm0Xchg7cdn3tbw
	 exLjboJmUtSXhPlRttXDr1GDH2IH/E8OA/wKF7El3fDjZeY7KKvHdP6am9KCr9T6z2
	 0sUAqnuk49hlkwvu6BRlkCZaFgwzLuWTVGNTk4NZCQ6dVobp9DI9goGyFp0d+UQYUi
	 uyJqDT4QS4EPxuZnplf7xC3GvgnDOaihyTOYCoYlto0hxUFRndj8BIQmxns2CamdE6
	 Vd3CcsSkK6l1A==
Message-ID: <696364e6-5eb1-4543-b9f4-60fba10623fc@kernel.org>
Date: Fri, 30 May 2025 08:51:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdp: Remove unused mem_return_failed event
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250529160550.1f888b15@gandalf.local.home>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250529160550.1f888b15@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/05/2025 22.05, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The change to allow page_poll to handle its own page destruction instead
                            ^^^^
You miss-spelled page_pool as "page_poll"

> of relying on XDP removed the trace_mem_return_failed() tracepoint caller,
> but did not remove the mem_return_failed trace event. As trace events take
> up memory when they are created regardless of if they are used or not,
> having this unused event around wastes around 5K of memory.
> 
> Remove the unused event.
> 
> Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/
> 
> Fixes: c3f812cea0d7 ("page_pool: do not release pool until inflight == 0.")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   include/trace/events/xdp.h | 26 --------------------------
>   1 file changed, 26 deletions(-)

With above spelling fixed:

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
> index a7e5452b5d21..d3ef86c97ae3 100644
> --- a/include/trace/events/xdp.h
> +++ b/include/trace/events/xdp.h
> @@ -379,32 +379,6 @@ TRACE_EVENT(mem_connect,
>   	)
>   );
>   
> -TRACE_EVENT(mem_return_failed,
> -
> -	TP_PROTO(const struct xdp_mem_info *mem,
> -		 const struct page *page),
> -
> -	TP_ARGS(mem, page),
> -
> -	TP_STRUCT__entry(
> -		__field(const struct page *,	page)
> -		__field(u32,		mem_id)
> -		__field(u32,		mem_type)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->page		= page;
> -		__entry->mem_id		= mem->id;
> -		__entry->mem_type	= mem->type;
> -	),
> -
> -	TP_printk("mem_id=%d mem_type=%s page=%p",
> -		  __entry->mem_id,
> -		  __print_symbolic(__entry->mem_type, __MEM_TYPE_SYM_TAB),
> -		  __entry->page
> -	)
> -);
> -
>   TRACE_EVENT(bpf_xdp_link_attach_failed,
>   
>   	TP_PROTO(const char *msg),

