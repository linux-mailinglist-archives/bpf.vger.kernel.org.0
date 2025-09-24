Return-Path: <bpf+bounces-69578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB5B9AB3D
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E84718841EF
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF33115A0;
	Wed, 24 Sep 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHzkX9St"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96C307AFA;
	Wed, 24 Sep 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728057; cv=none; b=IX2aF39L7T4MnsfQijM/cED4rteJIZvoMbrjLIWjchdpzubFjS6ZZKiBWmEK/OVFJDFcbkI8i1IWdPDm+x6J5IF7jIcHqCI5fR8FFrR62ofnj7IKoeleh0oFJ/zXScrFirXHxRFHSZbXAniYEHzA7sUrN+r658/9FaN5hs2VwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728057; c=relaxed/simple;
	bh=lUZuxPLPBDGO00HWidrCHdCMvKz0T1VhhIVqtlgz3mo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fjmW5b6PzT1TeJJb5J2+5QPKX+Ix1MSkdki8YwNqBkbcVC1/ORqc6kCFisU6bJmMj5ddP623bc9FlVVUM2Ym5hTQxGnfJc3UAYUha6qi5ItfLTgcPaGYHgTjxXJqoLj57hB7KsJnkxpAPFobRPLAUhrp5jTLoNjpj5UgXJEOeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHzkX9St; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B435DC4CEE7;
	Wed, 24 Sep 2025 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758728056;
	bh=lUZuxPLPBDGO00HWidrCHdCMvKz0T1VhhIVqtlgz3mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHzkX9StnWCCLKEaIcwoJxUUnBQHkEaH22wijFJc9HcuqRmjkFS6LG3U4Tck2/M8w
	 nU2aahpaXY7vY7qxjp/hfBmnladUZ9x57PGdpz/FVI2O1PToRlhvvzRfGlqWcYYOAu
	 qu24BWmHQVwEyFiL1QaLcAYGpupSMHo8NIiwoh7Va9v3E02qXT71h8G60ZDb/IjtJA
	 ZuyJvkKMDOvOuRVgkRDSdrOexx/mnRul0TCfh77TK8jk1rT7hEgzZdW9jL5WPyUG18
	 KXJ7NKOGVEO+7BOXJOuDPKlj9et5M8gtCTRgG6R1O0mJlfr3BGVlZ/2VCj5H92N06e
	 +3d4Sd3jXY8Nw==
Date: Thu, 25 Sep 2025 00:34:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: fgraph: Protect return handler from
 recursion loop
Message-Id: <20250925003410.de2ef839f6ef3921ee08a955@kernel.org>
In-Reply-To: <175852292275.307379.9040117316112640553.stgit@devnote2>
References: <175852291163.307379.14414635977719513326.stgit@devnote2>
	<175852292275.307379.9040117316112640553.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

Can you pick this ? Or I will do?

Thanks,

On Mon, 22 Sep 2025 15:35:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> function_graph_enter_regs() prevents itself from recursion by
> ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
> which is called at the exit, does not prevent such recursion.
> Therefore, while it can prevent recursive calls from
> fgraph_ops::entryfunc(), it is not able to prevent recursive calls
> to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
> This can lead an unexpected recursion bug reported by Menglong.
> 
>  is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
>   -> kprobe_multi_link_exit_handler -> is_endbr.
> 
> To fix this issue, acquire ftrace_test_recursion_trylock() in the
> __ftrace_return_to_handler() after unwind the shadow stack to mark
> this section must prevent recursive call of fgraph inside user-defined
> fgraph_ops::retfunc().
> 
> This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
> fprobe on function-graph tracer"), because before that fgraph was
> only used from the function graph tracer. Fprobe allowed user to run
> any callbacks from fgraph after that commit.
> 
> Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  Changes in v2:
>   - Do not warn on failing ftrace_test_recursion_trylock() because it
>     allows one-level nest.
> ---
>  kernel/trace/fgraph.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 1e3b32b1e82c..484ad7a18463 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  	unsigned long bitmap;
>  	unsigned long ret;
>  	int offset;
> +	int bit;
>  	int i;
>  
>  	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> @@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  	if (fregs)
>  		ftrace_regs_set_instruction_pointer(fregs, ret);
>  
> +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> +	/*
> +	 * This can fail because ftrace_test_recursion_trylock() allows one nest
> +	 * call. If we are already in a nested call, then we don't probe this and
> +	 * just return the original return address.
> +	 */
> +	if (unlikely(bit < 0))
> +		goto out;
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>  	trace.retval = ftrace_regs_get_return_value(fregs);
>  #endif
> @@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  		}
>  	}
>  
> +	ftrace_test_recursion_unlock(bit);
> +out:
>  	/*
>  	 * The ftrace_graph_return() may still access the current
>  	 * ret_stack structure, we need to make sure the update of
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

