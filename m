Return-Path: <bpf+bounces-64891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8ACB18433
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7161C6264DE
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE326E6E3;
	Fri,  1 Aug 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYkklHo/"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7F26D4F9
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059813; cv=none; b=HD8h9rcW5M+QMJX6sS4Mk2GRaHDZay7rI1YgoyUbqz3oiiEAneUnw2fyRn3YZ9Ci5Fqm08oJtszEfxeHlbZgVb4MBej3HRPNP+7SX3rq57wEQz9KuWLFjBgyQVW5HIImbltD+mmAS7giwlO6A5LhJ5FjqVrcI/iBfo9ac5b67tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059813; c=relaxed/simple;
	bh=3x2WSU5tShhnaeGf2R++yN8NTbuM1u7Sz8hBqev70/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZxhL6kysXeuWDq6hu/Qg+gxxM+qpwQemiLAU8s81WowRV+BvCbP+oUll9h8/QS+aVTC0h9WsmcinneJWVQAFgWBij+jy8vBHvrKjROFViaRy0AASFvDmZpeXgAz5wCwOwv5hxRdZRxAoNXQ+GuQXQKLqanzE1n5d4jjVguas1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYkklHo/; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9bfa8866-a90f-41bf-8b22-bf704c01a2e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754059798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kK5yweiPTMZrq6GkWQNhJfrmVEH0GQuE8rqp8Hc+11k=;
	b=HYkklHo/orcX7L1b93efOOUr9L5f8VGX6WzRJINCCLIfU8KTSoQBYkdgioQD6bjCsO2n2r
	22aMtxQ5IpaRct2qlZhmyJsz9LdCMHizpmOwGN+mCm6hjzSgyWqNK2baTEwK2XpxLh00aw
	6NDraVcYNGcDX5uiqd5o/zIyhz8m7Us=
Date: Fri, 1 Aug 2025 07:49:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tracing: Have unsigned int function args displayed as
 hexadecimal
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org,
 Douglas Raillard <douglas.raillard@arm.com>
References: <20250731193126.2eeb21c6@gandalf.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250731193126.2eeb21c6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/31/25 4:31 PM, Steven Rostedt wrote:
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
>      __create_object(ptr=-131387050520576, size=4096, min_count=1, gfp=3264, objflags=0) <-kmem_cache_alloc_noprof
>      stack_access_ok(state=0xffffc9000233fc98, _addr=-60473102566256, len=8) <-unwind_next_frame
>      __local_bh_disable_ip(ip=-2127311112, cnt=256) <-handle_softirqs
>
> Instead, by displaying unsigned as hexadecimal, they look more like this:
>
>      __create_object(ptr=0xffff8881028d2080, size=0x280, min_count=1, gfp=0x82820, objflags=0x0) <-kmem_cache_alloc_node_noprof
>      stack_access_ok(state=0xffffc90000003938, _addr=0xffffc90000003930, len=0x8) <-unwind_next_frame
>      __local_bh_disable_ip(ip=0xffffffff8133cef8, cnt=0x100) <-handle_softirqs
>
> Which is much easier to understand as most unsigned longs are usually just
> pointers. Even the "unsigned int cnt" in __local_bh_disable_ip() looks
> better as hexadecimal as a lot of flags are passed as unsigned.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

LGTM. But it seems some format issue. See below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/trace/trace_output.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 0b3db02030a7..b18393d66a7f 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -690,6 +690,12 @@ int trace_print_lat_context(struct trace_iterator *iter)
>   }
>   
>   #ifdef CONFIG_FUNCTION_TRACE_ARGS
> +
> +static u32 btf_type_int(const struct btf_type *t)
> +{
> +	return *(u32 *)(t + 1);
> +}
> +
>   void print_function_args(struct trace_seq *s, unsigned long *args,
>   			 unsigned long func)
>   {
> @@ -701,6 +707,8 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>   	struct btf *btf;
>   	s32 tid, nr = 0;
>   	int a, p, x;
> +	int int_data;
> +	u16 encode;
>   
>   	trace_seq_printf(s, "(");
>   
> @@ -744,7 +752,14 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>   			trace_seq_printf(s, "0x%lx", arg);
>   			break;
>   		case BTF_KIND_INT:
> -			trace_seq_printf(s, "%ld", arg);
> +			/* Get the INT encodoing */
> +			int_data = btf_type_int(t);
> +                        encode = BTF_INT_ENCODING(int_data);

See different identation between above 'int_data' and 'encode'. The same as below.

> +                        /* Print unsigned ints as hex */
> +                        if (encode & BTF_INT_SIGNED)
> +				trace_seq_printf(s, "%ld", arg);
> +                        else
> +                                trace_seq_printf(s, "0x%lx", arg);
>   			break;
>   		case BTF_KIND_ENUM:
>   			trace_seq_printf(s, "%ld", arg);


