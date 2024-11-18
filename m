Return-Path: <bpf+bounces-45074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC59D0AAA
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 09:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6645D281E89
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9E01552F5;
	Mon, 18 Nov 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBtJomjM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E93BBF2;
	Mon, 18 Nov 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917894; cv=none; b=gC5q6Xba02APbHY1mAyv8B+ACcpfdXZZzAZeJsdgt/cSosPFwaoBwLiYBRcgsPCdtu2N1m4ZdCqFcsnuBULTm8Xex4qwtm/gWgIfHArkIXa9HWmk1sl+v2sqw2CC4C7FG2m0/TUWcNd4Do7JSICybbIk7LRy7o3pBWxyy/Pl3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917894; c=relaxed/simple;
	bh=yB126og11Z2QbsbKhKtQEVuRANQlHW9pxdXRcHedxuE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=irONBb+oJBp7shpj7yzLsEgZha+LlM7QhplAWC/gVpUdRaprkJtqFKuYPJWH0+E7vJ/5RArx4IaRFdOJOIySvZjlUpAyVS3m+gOg+XqZtcco0t7GzYvcnig7cUkRFHTR3BrMIe4CIX5t1out4CcGZjILbOg9xWlaXlOkWu47kSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBtJomjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8851DC4CECC;
	Mon, 18 Nov 2024 08:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731917893;
	bh=yB126og11Z2QbsbKhKtQEVuRANQlHW9pxdXRcHedxuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bBtJomjMHghzWIATHwiIk2YXgtwldU82l6jNt8QDjLZCPhvAX6+N1E7uNKlx+MlUC
	 VaHffFMfxHuTftxDiX4OpN8oNqCzCueYAUJW5dmdrdPE+Xii7djebXY6k7yBrJw0Rf
	 vP4V+EVri/FPmftMZwUq8G9U8SHUkxzjjzAm18aL19oKtShJ7c2TgdkAIkYSe7B5q/
	 DDAgllYnE8HaWFTW9fP4jA6JENVpL4Meg5uQdLj9LNVnmlvJoVgKNlPKYXvqVZYgHk
	 aOgh8poRQKNfBM7sbrV8XB1YR7/DhByZG7f8jcwvx1KOw5l4DwrkJBNez/Qb9z3YiE
	 W2YDwcF95Xe8A==
Date: Mon, 18 Nov 2024 17:18:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 07/11] uprobes/x86: Add support to optimize
 uprobes
Message-Id: <20241118171808.316ae124cd57886e813cb98f@kernel.org>
In-Reply-To: <20241105133405.2703607-8-jolsa@kernel.org>
References: <20241105133405.2703607-1-jolsa@kernel.org>
	<20241105133405.2703607-8-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 14:34:01 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> Putting together all the previously added pieces to support optimized
> uprobes on top of 5-byte nop instruction.
> 
> The current uprobe execution goes through following:
>   - installs breakpoint instruction over original instruction
>   - exception handler hit and calls related uprobe consumers
>   - and either simulates original instruction or does out of line single step
>     execution of it
>   - returns to user space
> 
> The optimized uprobe path
> 
>   - checks the original instruction is 5-byte nop (plus other checks)
>   - adds (or uses existing) user space trampoline and overwrites original
>     instruction (5-byte nop) with call to user space trampoline
>   - the user space trampoline executes uprobe syscall that calls related uprobe
>     consumers
>   - trampoline returns back to next instruction
> 
> This approach won't speed up all uprobes as it's limited to using nop5 as
> original instruction, but we could use nop5 as USDT probe instruction (which
> uses single byte nop ATM) and speed up the USDT probes.
> 
> This patch overloads related arch functions in uprobe_write_opcode and
> set_orig_insn so they can install call instruction if needed.
> 
> The arch_uprobe_optimize triggers the uprobe optimization and is called after
> first uprobe hit. I originally had it called on uprobe installation but then
> it clashed with elf loader, because the user space trampoline was added in a
> place where loader might need to put elf segments, so I decided to do it after
> first uprobe hit when loading is done.
> 
> TODO release uprobe trampoline when it's no longer needed.. we might need to
> stop all cpus to make sure no user space thread is in the trampoline.. or we
> might just keep it, because there's just one 4GB memory region?
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/include/asm/uprobes.h |   7 ++
>  arch/x86/kernel/uprobes.c      | 130 +++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h        |   1 +
>  kernel/events/uprobes.c        |   3 +
>  4 files changed, 141 insertions(+)
> 
> diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
> index 678fb546f0a7..84a75ed748f0 100644
> --- a/arch/x86/include/asm/uprobes.h
> +++ b/arch/x86/include/asm/uprobes.h
> @@ -20,6 +20,11 @@ typedef u8 uprobe_opcode_t;
>  #define UPROBE_SWBP_INSN		0xcc
>  #define UPROBE_SWBP_INSN_SIZE		   1
>  
> +enum {
> +	ARCH_UPROBE_FLAG_CAN_OPTIMIZE	= 0,
> +	ARCH_UPROBE_FLAG_OPTIMIZED	= 1,
> +};
> +
>  struct uprobe_xol_ops;
>  
>  struct arch_uprobe {
> @@ -45,6 +50,8 @@ struct arch_uprobe {
>  			u8	ilen;
>  		}			push;
>  	};
> +
> +	unsigned long flags;
>  };
>  
>  struct arch_uprobe_task {
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 02aa4519b677..50ccf24ff42c 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -18,6 +18,7 @@
>  #include <asm/processor.h>
>  #include <asm/insn.h>
>  #include <asm/mmu_context.h>
> +#include <asm/nops.h>
>  
>  /* Post-execution fixups. */
>  
> @@ -877,6 +878,33 @@ static const struct uprobe_xol_ops push_xol_ops = {
>  	.emulate  = push_emulate_op,
>  };
>  
> +static int is_nop5_insns(uprobe_opcode_t *insn)
> +{
> +	return !memcmp(insn, x86_nops[5], 5);

Maybe better to use BYTES_NOP5 directly?

> +}
> +
> +static int is_call_insns(uprobe_opcode_t *insn)
> +{
> +	return *insn == 0xe8;

0xe8 -> CALL_INSN_OPCODE

Thank you,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

