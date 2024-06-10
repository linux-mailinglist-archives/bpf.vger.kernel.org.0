Return-Path: <bpf+bounces-31753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935E7902B43
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 00:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0A91F22C17
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8E14F123;
	Mon, 10 Jun 2024 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyE3dy4S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87CC63D0;
	Mon, 10 Jun 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056939; cv=none; b=GbKF52FXBESLPWW3aeXctyIwnbMDqccDpdNj8OjfYnXv09RPuNOw5uc46PyWslnekv2dkjRrAFW0uhH3/mdNmqiVlKx0weeKuvZ2kjdf4WAKYSlHwsj1DhaZHQBdLaFukJd6esdTTEUl2UCjkVFC4txTNLIhJvm0NzEVFcyBzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056939; c=relaxed/simple;
	bh=MqAQpkevHGNOOFgJUiEdfPRWQVNm7nE45c3VrxEicIA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jMG1bhL1oXOCpb4kPQ/u42iFcjtr+Pg2h3+HSQcNXBVjl3H7LhfSAJlayds/w4YQqthgPGuHlJtfuf1yOaAVi1y2oavJQBDq6C5ZBdgne2z9WPwK7PjDBEoRNBjBTKyAEiDpWq7VyR/gkj10jxU0QuOqWWzE4ARSAGPFABi8Ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyE3dy4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3304FC2BBFC;
	Mon, 10 Jun 2024 22:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056939;
	bh=MqAQpkevHGNOOFgJUiEdfPRWQVNm7nE45c3VrxEicIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QyE3dy4SuC3VRsPWts6pHstZn3YX31KuhAybYrIPKs9yDsBuc8E2afjL4TWoup+Vx
	 fJ8TduCIsN4pgTs5G8dvxj/2xR6381diQc1Lrhwj6cfKuM6IOYtlX78K+4kfgpqtHy
	 Yzcdcz7SOyWhf/Yq0MmWmYGQorvieRfXhWUqQl2RpFTfRTceDYMTPWQWQASJqgI7Na
	 eabkoLgghbQ34Zbvh7bX7vknHTJjq8ZP/2e2eBg12DcGfnxmo77P2gxPQD0Y9XM/Gb
	 YzmSPHOIX8Wxe0rX3EhbLpRDku2W8ydGL+zRdEuE18kIUcKsrCnlxA0izqpKtrUyoc
	 lnVy4rK4tl4RA==
Date: Tue, 11 Jun 2024 07:02:12 +0900
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
Subject: Re: [PATCHv7 bpf-next 8/9] selftests/bpf: Add uretprobe shadow
 stack test
Message-Id: <20240611070212.79cef453d0615e3af5af1fb0@kernel.org>
In-Reply-To: <20240523121149.575616-9-jolsa@kernel.org>
References: <20240523121149.575616-1-jolsa@kernel.org>
	<20240523121149.575616-9-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 14:11:48 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding uretprobe shadow stack test that runs all existing
> uretprobe tests with shadow stack enabled if it's available.
> 

According to the document and sample code, this looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 3ef324c2db50..fda456401284 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -9,6 +9,9 @@
>  #include <linux/compiler.h>
>  #include <linux/stringify.h>
>  #include <sys/wait.h>
> +#include <sys/syscall.h>
> +#include <sys/prctl.h>
> +#include <asm/prctl.h>
>  #include "uprobe_syscall.skel.h"
>  #include "uprobe_syscall_executed.skel.h"
>  
> @@ -297,6 +300,56 @@ static void test_uretprobe_syscall_call(void)
>  	close(go[1]);
>  	close(go[0]);
>  }
> +
> +/*
> + * Borrowed from tools/testing/selftests/x86/test_shadow_stack.c.
> + *
> + * For use in inline enablement of shadow stack.
> + *
> + * The program can't return from the point where shadow stack gets enabled
> + * because there will be no address on the shadow stack. So it can't use
> + * syscall() for enablement, since it is a function.
> + *
> + * Based on code from nolibc.h. Keep a copy here because this can't pull
> + * in all of nolibc.h.
> + */
> +#define ARCH_PRCTL(arg1, arg2)					\
> +({								\
> +	long _ret;						\
> +	register long _num  asm("eax") = __NR_arch_prctl;	\
> +	register long _arg1 asm("rdi") = (long)(arg1);		\
> +	register long _arg2 asm("rsi") = (long)(arg2);		\
> +								\
> +	asm volatile (						\
> +		"syscall\n"					\
> +		: "=a"(_ret)					\
> +		: "r"(_arg1), "r"(_arg2),			\
> +		  "0"(_num)					\
> +		: "rcx", "r11", "memory", "cc"			\
> +	);							\
> +	_ret;							\
> +})
> +
> +#ifndef ARCH_SHSTK_ENABLE
> +#define ARCH_SHSTK_ENABLE	0x5001
> +#define ARCH_SHSTK_DISABLE	0x5002
> +#define ARCH_SHSTK_SHSTK	(1ULL <<  0)
> +#endif
> +
> +static void test_uretprobe_shadow_stack(void)
> +{
> +	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK)) {
> +		test__skip();
> +		return;
> +	}
> +
> +	/* Run all of the uretprobe tests. */
> +	test_uretprobe_regs_equal();
> +	test_uretprobe_regs_change();
> +	test_uretprobe_syscall_call();
> +
> +	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
> +}
>  #else
>  static void test_uretprobe_regs_equal(void)
>  {
> @@ -312,6 +365,11 @@ static void test_uretprobe_syscall_call(void)
>  {
>  	test__skip();
>  }
> +
> +static void test_uretprobe_shadow_stack(void)
> +{
> +	test__skip();
> +}
>  #endif
>  
>  void test_uprobe_syscall(void)
> @@ -322,4 +380,6 @@ void test_uprobe_syscall(void)
>  		test_uretprobe_regs_change();
>  	if (test__start_subtest("uretprobe_syscall_call"))
>  		test_uretprobe_syscall_call();
> +	if (test__start_subtest("uretprobe_shadow_stack"))
> +		test_uretprobe_shadow_stack();
>  }
> -- 
> 2.45.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

