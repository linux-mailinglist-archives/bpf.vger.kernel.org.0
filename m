Return-Path: <bpf+bounces-30619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA28CF6DF
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 01:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A966DB2133C
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B893613A3EC;
	Sun, 26 May 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhkSU46r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359EF2F46;
	Sun, 26 May 2024 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716767928; cv=none; b=obLl4FGX8hBfTYyP3XeKv4e1LXvMvS0kR61fBpKozdCrIXtDXZbPJYA2l7M2rmWRtUSWuBhOUgDB0O/toAj2/YrI7tNaol1Z/W+yXmqlBJ488uyK0pdDLXXzJy9IUo6OKxYxjAi59dnrN5mO+Zh6dKTSEmhsifpsdy5GvsLZ5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716767928; c=relaxed/simple;
	bh=b5DjLreslgkKOr9CzOVLysgDaJanR6GoFnpSSYrVds8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Uinj/T572ZhMG5s2kTSGAP+1tQJEC48ortG8BU4cGrFYfKSxL5BbyJWNA/Mzg+4UpbEeFFP+WOoosr+RKCsejDAVgx949uVKl8pb3r/8EQVYrJNyPLCEj6TXFzeQ9gKB5AB1+o9HGgVduo5Onzj9Fo939e8kNP67Pj371ymFNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhkSU46r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA695C2BD10;
	Sun, 26 May 2024 23:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716767927;
	bh=b5DjLreslgkKOr9CzOVLysgDaJanR6GoFnpSSYrVds8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FhkSU46roOIGOu8nIldG3jCi4RxCCFFDyPlOZyPQyxBDbhepVHZ2WLgQOdF8vz3mb
	 PW5sy69JxHdL4CbT0EG17DhGOe526wzeE8No3ViQmEjnkT1ySuAmyi8EiDeprm3WWe
	 UEwqadlcyyAWHkDvUPWsGmQINx2acb4ZUtFdpIMKNjzsAui7P2QKF39jifsB8eYwun
	 8H5FfVF2PNo/b7MHUkevltyd+FZ8TX338mHJ4ZFdzdiDspJnzQV6/wXQkK7AqGstGO
	 rNSolmr21+EE5BrSmTRHZjPbbEPojScl8UKv5FwOl62Vsr6HLHis//Zq+LMOx0KiTP
	 jNPTpY89nTgOQ==
Date: Mon, 27 May 2024 08:58:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 19/20] function_graph: Use for_each_set_bit() in
 __ftrace_return_to_handler()
Message-Id: <20240527085841.63b97b1b1926ff9c0a21fb46@kernel.org>
In-Reply-To: <20240525023744.231570357@goodmis.org>
References: <20240525023652.903909489@goodmis.org>
	<20240525023744.231570357@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 22:37:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of iterating through the entire fgraph_array[] and seeing if one
> of the bitmap bits are set to know to call the array's retfunc() function,
> use for_each_set_bit() on the bitmap itself. This will only iterate for
> the number of set bits.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 4d503b3e45ad..5e8e13ffcfb6 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -827,11 +827,10 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
>  #endif
>  
>  	bitmap = get_bitmap_bits(current, offset);
> -	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
> +
> +	for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
>  		struct fgraph_ops *gops = fgraph_array[i];
>  
> -		if (!(bitmap & BIT(i)))
> -			continue;
>  		if (gops == &fgraph_stub)
>  			continue;
>  
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

