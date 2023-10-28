Return-Path: <bpf+bounces-13534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF83D7DA4B0
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 03:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98ABF2827A3
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 01:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADFE7F0;
	Sat, 28 Oct 2023 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXa3SL6a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC3644;
	Sat, 28 Oct 2023 01:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B761C433C8;
	Sat, 28 Oct 2023 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698457308;
	bh=culIKFe+JSj9EHA864Ou39mlvl0u+Ctl5H8IvNqq8+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JXa3SL6auUCV66hDM1saY5rjnAQHKpCd8Lc86L4XaH53vvBsK1zjgNIOOgaPxfbaD
	 n6dxp9BV0VEcdnYBq1iXXYjwY+iqNDkNSaBQ3hB6C4CFQLaw9uZv2LDFQAmrDgiDry
	 mL8Z1QfLP0eySvoqWMCUfVG4ci2EMzCHHr6t88IbQUI+IIS52yZD28USV5XoQVRUBZ
	 ZnEW/sn34XwCO/yCWGBevsb3T+toptKWHLaCFg6IYL+8ywqDjw3P3fe9Jbi2c5B6jI
	 9R+gFPECRDUKtDRw1ebEFOBK5Sv+rU3kgES0M2gA3dJW4yqFnoN0m+H6XDX0QInQRa
	 owC5w0ALTLbkg==
Date: Sat, 28 Oct 2023 10:41:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Francis
 Laniel <flaniel@linux.microsoft.com>, <stable@vger.kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking
 at modules as well
Message-Id: <20231028104144.de23c2287281e9228ce92508@kernel.org>
In-Reply-To: <20231027233126.2073148-1-andrii@kernel.org>
References: <20231027233126.2073148-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 27 Oct 2023 16:31:26 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Recent changes to count number of matching symbols when creating
> a kprobe event failed to take into account kernel modules. As such, it
> breaks kprobes on kernel module symbols, by assuming there is no match.
> 
> Fix this my calling module_kallsyms_on_each_symbol() in addition to
> kallsyms_on_each_match_symbol() to perform a proper counting.
> 
> Cc: Francis Laniel <flaniel@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

This fixes "BPF" kprobe event, but not ftrace kprobe events.
ftrace kprobe events only checks this if it is in the vmlinux not
modules and that's why my selftest passed the original one.
Hmm, I need another enhancement like this for the events on offline
modules.

Thank you,

> ---
>  kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index effcaede4759..1efb27f35963 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
>  	return 0;
>  }
>  
> +struct sym_count_ctx {
> +	unsigned int count;
> +	const char *name;
> +};
> +
> +static int count_mod_symbols(void *data, const char *name, unsigned long unused)
> +{
> +	struct sym_count_ctx *ctx = data;
> +
> +	if (strcmp(name, ctx->name) == 0)
> +		ctx->count++;
> +
> +	return 0;
> +}
> +
>  static unsigned int number_of_same_symbols(char *func_name)
>  {
> -	unsigned int count;
> +	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
> +
> +	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>  
> -	count = 0;
> -	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> +	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
>  
> -	return count;
> +	return ctx.count;
>  }
>  
>  static int __trace_kprobe_create(int argc, const char *argv[])
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

