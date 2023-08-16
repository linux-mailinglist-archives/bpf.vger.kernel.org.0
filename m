Return-Path: <bpf+bounces-7928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0507377E943
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 21:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE551C21096
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CF917720;
	Wed, 16 Aug 2023 19:04:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED193D60
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 19:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F9BC433C7;
	Wed, 16 Aug 2023 19:04:03 +0000 (UTC)
Date: Wed, 16 Aug 2023 15:04:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, John Fastabend <john.fastabend@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kees Cook
 <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] [v3] kallsyms: rework symbol lookup return codes
Message-ID: <20230816150407.3d5dbc40@gandalf.local.home>
In-Reply-To: <20230726141333.3992790-1-arnd@kernel.org>
References: <20230726141333.3992790-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 16:12:23 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 05c0024815bf9..a949f903c9e66 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6965,7 +6965,7 @@ allocate_ftrace_mod_map(struct module *mod,
>  	return mod_map;
>  }
>  
> -static const char *
> +static int
>  ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  			   unsigned long addr, unsigned long *size,
>  			   unsigned long *off, char *sym)
> @@ -6986,21 +6986,18 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  			*size = found_func->size;
>  		if (off)
>  			*off = addr - found_func->ip;
> -		if (sym)
> -			strscpy(sym, found_func->name, KSYM_NAME_LEN);
> -
> -		return found_func->name;
> +		return strscpy(sym, found_func->name, KSYM_NAME_LEN);
>  	}
>  
> -	return NULL;
> +	return 0;
>  }
>  
> -const char *
> +int
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>  		   unsigned long *off, char **modname, char *sym)
>  {
>  	struct ftrace_mod_map *mod_map;
> -	const char *ret = NULL;
> +	int ret;
>  
>  	/* mod_map is freed via call_rcu() */
>  	preempt_disable();


Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

