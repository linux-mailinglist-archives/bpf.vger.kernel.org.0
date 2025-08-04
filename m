Return-Path: <bpf+bounces-65002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD1DB1A31A
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DC71625D6
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54BA26656D;
	Mon,  4 Aug 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcWcrSMk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798923C4F2;
	Mon,  4 Aug 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313603; cv=none; b=gmOYWjHHCKrxCNgLUPFdb4lkiYFJJnV6ZHP7aDAEoeGNutw70tZAmmsHrAYvpXvyrpnprjrEOW9SK6IzbmVUkD7F3iAOSwf4+bTgUL2H+MMsVk/sS6QruhGw0BYSP4BoatZv3vsTTlfexTWlmuJQkbusZPXmsMybMXtj0tiNpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313603; c=relaxed/simple;
	bh=w14/wXRv448wVL7ebjW5zOAoi4bWCfWJ7cL4AYxgg3I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o7ntVZapWsTv9dtcZYaFNaQNd1bZTqmMsbwAS409YWhT6PodThUAQryEFBSaSoPZNldBrXkPlKbYGkuTzPpTSSydidtLJpV9ldtujgxD+RhRJ1IQW0uajSzedZck8y4b8YSHgV/m2BNtm/Da5SdzzkpP9KeMh3f5CY7WbPdBGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcWcrSMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42E1C4CEE7;
	Mon,  4 Aug 2025 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754313602;
	bh=w14/wXRv448wVL7ebjW5zOAoi4bWCfWJ7cL4AYxgg3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hcWcrSMk88NzP1OxcvyrE/rxaTdGD0LEaK6tJy+PZMM85MYcSQm3wluQBY+0l+jqs
	 ONtBKx1W8/wIzUY/IncVfj1wAlIV38Q52oIdy2VJoB53Sl70blbWRRb7D5iYx6+Pm9
	 3dNFlN14Oc/iFDwgIqXXNU3MH0kF/jJOK22JiPjYMuEifffej9nh4NR/pfiyL4aUjf
	 gB9U/omDLAK/YEufWptVdr9imYEkGWN5WmHqMA2nkSrMlsLNSI1cb33GVYTC/OEnzQ
	 B3ocXxfGCxb9nWbzxK9zm7tcBv0HNoMOW01eGHKVvoL78RG86rN1nmn8/50JPuywLO
	 9ahcEopAnkBJw==
Date: Mon, 4 Aug 2025 22:19:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf@vger.kernel.org, Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Have unsigned int function args displayed as
 hexadecimal
Message-Id: <20250804221958.501b5573a0ceb9f8d33c8a1a@kernel.org>
In-Reply-To: <20250731193126.2eeb21c6@gandalf.local.home>
References: <20250731193126.2eeb21c6@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 19:31:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Most function arguments that are passed in as unsigned int or unsigned
> long are better displayed as hexadecimal than normal integer. For example,
> the functions:
> 
> static void __create_object(unsigned long ptr, size_t size,
> 				int min_count, gfp_t gfp, unsigned int objflags);
> 
> static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
> 			    size_t len);
> 
> void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
> 
> Show up in the trace as:
> 
>     __create_object(ptr=-131387050520576, size=4096, min_count=1, gfp=3264, objflags=0) <-kmem_cache_alloc_noprof
>     stack_access_ok(state=0xffffc9000233fc98, _addr=-60473102566256, len=8) <-unwind_next_frame
>     __local_bh_disable_ip(ip=-2127311112, cnt=256) <-handle_softirqs
> 
> Instead, by displaying unsigned as hexadecimal, they look more like this:
> 
>     __create_object(ptr=0xffff8881028d2080, size=0x280, min_count=1, gfp=0x82820, objflags=0x0) <-kmem_cache_alloc_node_noprof
>     stack_access_ok(state=0xffffc90000003938, _addr=0xffffc90000003930, len=0x8) <-unwind_next_frame
>     __local_bh_disable_ip(ip=0xffffffff8133cef8, cnt=0x100) <-handle_softirqs
> 
> Which is much easier to understand as most unsigned longs are usually just
> pointers. Even the "unsigned int cnt" in __local_bh_disable_ip() looks
> better as hexadecimal as a lot of flags are passed as unsigned.
> 

Looks good to me. Maybe this format is better for programers :)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_output.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 0b3db02030a7..b18393d66a7f 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -690,6 +690,12 @@ int trace_print_lat_context(struct trace_iterator *iter)
>  }
>  
>  #ifdef CONFIG_FUNCTION_TRACE_ARGS
> +
> +static u32 btf_type_int(const struct btf_type *t)
> +{
> +	return *(u32 *)(t + 1);
> +}
> +
>  void print_function_args(struct trace_seq *s, unsigned long *args,
>  			 unsigned long func)
>  {
> @@ -701,6 +707,8 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  	struct btf *btf;
>  	s32 tid, nr = 0;
>  	int a, p, x;
> +	int int_data;
> +	u16 encode;
>  
>  	trace_seq_printf(s, "(");
>  
> @@ -744,7 +752,14 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  			trace_seq_printf(s, "0x%lx", arg);
>  			break;
>  		case BTF_KIND_INT:
> -			trace_seq_printf(s, "%ld", arg);
> +			/* Get the INT encodoing */
> +			int_data = btf_type_int(t);
> +                        encode = BTF_INT_ENCODING(int_data);
> +                        /* Print unsigned ints as hex */
> +                        if (encode & BTF_INT_SIGNED)
> +				trace_seq_printf(s, "%ld", arg);
> +                        else
> +                                trace_seq_printf(s, "0x%lx", arg);
>  			break;
>  		case BTF_KIND_ENUM:
>  			trace_seq_printf(s, "%ld", arg);
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

