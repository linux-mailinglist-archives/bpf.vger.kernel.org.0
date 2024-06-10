Return-Path: <bpf+bounces-31754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A0902B55
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 00:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF03B21E76
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EDD14F9C4;
	Mon, 10 Jun 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2AXnLZX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834339FD9;
	Mon, 10 Jun 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057129; cv=none; b=n2fcAI21fHT3wmGaOR9doK4EdLXBdyqAWsTGFx+er5FDP+VBtC50z/+S+ogUnHSuSpmpC+eOChRAwlwwqmlLSbJTXIBZQ9x4lOowt7kH0l/WiuNn5f/EJjWDjP8wmKp3t/0MpA/hZUC8DCwOeUifPEW+QkHJGg+Gznn+B7nl5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057129; c=relaxed/simple;
	bh=Dd+yBPaESTKQx9vEdcOxtFwciiZjEqNGYLDlRuD6KxQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NQpQ6JWtWUVEBMj+fGtTDNE6Ui3atH2nviZnNdpJogz3VfxxXSE43IltH7M5n0vNsmjmgOaSLI+ZEbgvgdGqd4+p2DGfjMxE9/8h2Dylh5yxtOpo8iIx1Z9mxtQj+U21CVYj5rYL9eYpAsln6MhRIG9qSTOtojDu2AjMTwAZJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2AXnLZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2498C32789;
	Mon, 10 Jun 2024 22:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718057128;
	bh=Dd+yBPaESTKQx9vEdcOxtFwciiZjEqNGYLDlRuD6KxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P2AXnLZXOC5I2okLMJo1JIIFgI5VKbiGE1fFfaYlRtPtwd+nbLx07lh/QU1pruKH0
	 2SGZyzgTR52o6BOHLZQexSvj+i5B9BETcjYdXRMhR2B6YwRx78aYraqB7WrDe/rUE/
	 L64gvK3qRsfRzAtRjfLas5eYOJWFAvIYtmZ123lyrIJjwF/CVOwfr4Pkq7vpbLsz36
	 CZAOkonMoxiEeXvgkqKva38Dqx/ol9yyIj5B6tIiEKopxhGrgw2WRx6m6TqqIFxt3w
	 EMRG+nv6kpNRavLY6wr+hEtnp9pyhcaEnhEUlFGb9OWiWX926T6rWF7EJoDQ5oYM/9
	 Nx+yPILj3l3Eg==
Date: Tue, 11 Jun 2024 07:05:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org, x86@kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv7 bpf-next 2/9] uprobe: Wire up uretprobe system call
Message-Id: <20240611070521.82da62690e8865ff498327f7@kernel.org>
In-Reply-To: <20240523121149.575616-3-jolsa@kernel.org>
References: <20240523121149.575616-1-jolsa@kernel.org>
	<20240523121149.575616-3-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 14:11:42 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Wiring up uretprobe system call, which comes in following changes.
> We need to do the wiring before, because the uretprobe implementation
> needs the syscall number.
> 
> Note at the moment uretprobe syscall is supported only for native
> 64-bit process.
> 

BTW, this does not cleanly applied to probes/for-next, based on
6.10-rc1. Which version did you use?

Thank you,

> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  include/linux/syscalls.h               | 2 ++
>  include/uapi/asm-generic/unistd.h      | 5 ++++-
>  kernel/sys_ni.c                        | 2 ++
>  4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index cc78226ffc35..47dfea0a827c 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -383,6 +383,7 @@
>  459	common	lsm_get_self_attr	sys_lsm_get_self_attr
>  460	common	lsm_set_self_attr	sys_lsm_set_self_attr
>  461	common	lsm_list_modules	sys_lsm_list_modules
> +462	64	uretprobe		sys_uretprobe
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e619ac10cd23..5318e0e76799 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -972,6 +972,8 @@ asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);
>  /* x86 */
>  asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
>  
> +asmlinkage long sys_uretprobe(void);
> +
>  /* pciconfig: alpha, arm, arm64, ia64, sparc */
>  asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
>  				unsigned long off, unsigned long len,
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 75f00965ab15..8a747cd1d735 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
>  #define __NR_lsm_list_modules 461
>  __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>  
> +#define __NR_uretprobe 462
> +__SYSCALL(__NR_uretprobe, sys_uretprobe)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 462
> +#define __NR_syscalls 463
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index faad00cce269..be6195e0d078 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -391,3 +391,5 @@ COND_SYSCALL(setuid16);
>  
>  /* restartable sequence */
>  COND_SYSCALL(rseq);
> +
> +COND_SYSCALL(uretprobe);
> -- 
> 2.45.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

