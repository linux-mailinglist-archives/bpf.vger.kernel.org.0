Return-Path: <bpf+bounces-41868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C633399CE23
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 16:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78896284691
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42871AB517;
	Mon, 14 Oct 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dugPc5QJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1A20EB;
	Mon, 14 Oct 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916833; cv=none; b=LI1gLhYdpNm8gWXq0DNefLYDhGTyDhoCmp/UrVplo6CWW0WyKaHcTeWibYvvMkGvi65ruDiqMp6FI+gu8ay5eQ2h+q5eSZyeyvGuvchiyFG11Bk2Xfuu0FrJ1NMWIFpbgXCNrRck7fGGi3yVGbbPd2A52fGlA1wQX3+QXowK4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916833; c=relaxed/simple;
	bh=TCs3xkXWgvME9Y1v/pXMkT+tacYIyXi39AFnDEF1W10=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dXEjuGVKWvxA1xL3cTctyu8yjCUOzHYRQ56vCuJY61UgnhidfQdTjt/XZ2b+exEexU6vI+x+snS888PZQuYl8nANtGuQ56tUHFCjgtbk4MSlvFkkC6s7GIG6OWSGcq9J5W7o1ZCseArDmY/GPwVB3e3rj1p75kkRiLrzJeFRV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dugPc5QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196A9C4AF0B;
	Mon, 14 Oct 2024 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728916833;
	bh=TCs3xkXWgvME9Y1v/pXMkT+tacYIyXi39AFnDEF1W10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dugPc5QJQCPBK3y9DLtRHTRnq3bcrdSeBO8i8X8Ib22XdBq1KZqSo2cjC08qED5iH
	 kifDeksp9tqS/BVeWD38HjkYkNvF4e9UkK+XALT4ngG66azDtFlEcOIzAvXtAAONyz
	 ijBushqozJy9L8T8RHx2ljCTbRsH/GHF9tGbBxqJsSM1A95/WGP+wNxhJtOR+4vGZh
	 z92WL3hk1nnMaRZIGK2wq2tUr2/o5llSOMVqvrvdAZi5v508Tl7JRffBfi1EGIfs2/
	 5GqEPw8HDJkcSL1NTGnn4WXPir1XQuHHrjSftCHftgunlChYyNQE40oRQ9FW/+0NLA
	 Xp7rfr/LLyhwA==
Date: Mon, 14 Oct 2024 23:40:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ma Qiao <mqaio@linux.alibaba.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, namhyung.kim@lge.com, oleg@redhat.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] uprobe: avoid out-of-bounds memory access of fetching
 args
Message-Id: <20241014234028.6dc14fe26dce74f2b90a8a4f@kernel.org>
In-Reply-To: <20241014061405.3139467-1-mqaio@linux.alibaba.com>
References: <20241014061405.3139467-1-mqaio@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 14:14:05 +0800
Ma Qiao <mqaio@linux.alibaba.com> wrote:

> From: Qiao Ma <mqaio@linux.alibaba.com>
> 
> Uprobe needs to fetch args into a percpu buffer, and then copy to ring
> buffer to avoid non-atomic context problem.
> 
> Sometimes user-space strings, arrays can be very large, but the size of
> percpu buffer is only page size. And store_trace_args() won't check
> whether these data exceeds a single page or not, caused out-of-bounds
> memory access.
> 
> It could be reproduced by following steps:
> 1. build kernel with CONFIG_KASAN enabled
> 2. save follow program as test.c
> 
> ```
> \#include <stdio.h>
> \#include <stdlib.h>
> \#include <string.h>
> 
> // If string length large than MAX_STRING_SIZE, the fetch_store_strlen()
> // will return 0, cause __get_data_size() return shorter size, and
> // store_trace_args() will not trigger out-of-bounds access.
> // So make string length less than 4096.
> \#define STRLEN 4093
> 
> void generate_string(char *str, int n)
> {
>     int i;
>     for (i = 0; i < n; ++i)
>     {
>         char c = i % 26 + 'a';
>         str[i] = c;
>     }
>     str[n-1] = '\0';
> }
> 
> void print_string(char *str)
> {
>     printf("%s\n", str);
> }
> 
> int main()
> {
>     char tmp[STRLEN];
> 
>     generate_string(tmp, STRLEN);
>     print_string(tmp);
> 
>     return 0;
> }
> ```
> 3. compile program
> `gcc -o test test.c`
> 
> 4. get the offset of `print_string()`
> ```
> objdump -t test | grep -w print_string
> 0000000000401199 g     F .text  000000000000001b              print_string
> ```
> 
> 5. configure uprobe with offset 0x1199
> ```
> off=0x1199
> 
> cd /sys/kernel/debug/tracing/
> echo "p /root/test:${off} arg1=+0(%di):ustring arg2=\$comm arg3=+0(%di):ustring"
>  > uprobe_events
> echo 1 > events/uprobes/enable
> echo 1 > tracing_on
> ```
> 
> 6. run `test`, and kasan will report error.
> ==================================================================
> BUG: KASAN: use-after-free in strncpy_from_user+0x1d6/0x1f0
> Write of size 8 at addr ffff88812311c004 by task test/499CPU: 0 UID: 0 PID: 499 Comm: test Not tainted 6.12.0-rc3+ #18
> Hardware name: Red Hat KVM, BIOS 1.16.0-4.al8 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x55/0x70
>  print_address_description.constprop.0+0x27/0x310
>  kasan_report+0x10f/0x120
>  ? strncpy_from_user+0x1d6/0x1f0
>  strncpy_from_user+0x1d6/0x1f0
>  ? rmqueue.constprop.0+0x70d/0x2ad0
>  process_fetch_insn+0xb26/0x1470
>  ? __pfx_process_fetch_insn+0x10/0x10
>  ? _raw_spin_lock+0x85/0xe0
>  ? __pfx__raw_spin_lock+0x10/0x10
>  ? __pte_offset_map+0x1f/0x2d0
>  ? unwind_next_frame+0xc5f/0x1f80
>  ? arch_stack_walk+0x68/0xf0
>  ? is_bpf_text_address+0x23/0x30
>  ? kernel_text_address.part.0+0xbb/0xd0
>  ? __kernel_text_address+0x66/0xb0
>  ? unwind_get_return_address+0x5e/0xa0
>  ? __pfx_stack_trace_consume_entry+0x10/0x10
>  ? arch_stack_walk+0xa2/0xf0
>  ? _raw_spin_lock_irqsave+0x8b/0xf0
>  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>  ? depot_alloc_stack+0x4c/0x1f0
>  ? _raw_spin_unlock_irqrestore+0xe/0x30
>  ? stack_depot_save_flags+0x35d/0x4f0
>  ? kasan_save_stack+0x34/0x50
>  ? kasan_save_stack+0x24/0x50
>  ? mutex_lock+0x91/0xe0
>  ? __pfx_mutex_lock+0x10/0x10
>  prepare_uprobe_buffer.part.0+0x2cd/0x500
>  uprobe_dispatcher+0x2c3/0x6a0
>  ? __pfx_uprobe_dispatcher+0x10/0x10
>  ? __kasan_slab_alloc+0x4d/0x90
>  handler_chain+0xdd/0x3e0
>  handle_swbp+0x26e/0x3d0
>  ? __pfx_handle_swbp+0x10/0x10
>  ? uprobe_pre_sstep_notifier+0x151/0x1b0
>  irqentry_exit_to_user_mode+0xe2/0x1b0
>  asm_exc_int3+0x39/0x40
> RIP: 0033:0x401199
> Code: 01 c2 0f b6 45 fb 88 02 83 45 fc 01 8b 45 fc 3b 45 e4 7c b7 8b 45 e4 48 98 48 8d 50 ff 48 8b 45 e8 48 01 d0 ce
> RSP: 002b:00007ffdf00576a8 EFLAGS: 00000206
> RAX: 00007ffdf00576b0 RBX: 0000000000000000 RCX: 0000000000000ff2
> RDX: 0000000000000ffc RSI: 0000000000000ffd RDI: 00007ffdf00576b0
> RBP: 00007ffdf00586b0 R08: 00007feb2f9c0d20 R09: 00007feb2f9c0d20
> R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000401040
> R13: 00007ffdf0058780 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> This commit enforces the buffer's maxlen less than a page-size to avoid
> store_trace_args() out-of-memory access.
> 
> Fixes: dcad1a204f72 ("tracing/uprobes: Fetch args before reserving a ring buffer")
> Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
> ---
>  kernel/trace/trace_probe_tmpl.h | 2 +-
>  kernel/trace/trace_uprobe.c     | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 2caf0d2afb322..0338d9468bb4d 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -269,7 +269,7 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec, void *edata,
>  		ret = process_fetch_insn(arg->code, rec, edata, dl, base);
>  		if (arg->dynamic && likely(ret > 0)) {
>  			dyndata += ret;
> -			maxlen -= ret;
> +			maxlen = max(maxlen - ret, 0);

Hmm, do you see this part does something wrong?
If this exceed maxlen here, that means a buffer overflow. Please make it WARN_ON_ONCE().

>  		}
>  	}
>  }
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c40531d2cbadd..e972855a5a6bf 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -875,6 +875,7 @@ struct uprobe_cpu_buffer {
>  };
>  static struct uprobe_cpu_buffer __percpu *uprobe_cpu_buffer;
>  static int uprobe_buffer_refcnt;
> +#define MAX_UCB_BUFFER_SIZE PAGE_SIZE
>  
>  static int uprobe_buffer_init(void)
>  {
> @@ -979,6 +980,11 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
>  	ucb = uprobe_buffer_get();
>  	ucb->dsize = tu->tp.size + dsize;
>  
> +	if (WARN_ON_ONCE(ucb->dsize > MAX_UCB_BUFFER_SIZE)) {
> +		ucb->dsize = MAX_UCB_BUFFER_SIZE;
> +		dsize = MAX_UCB_BUFFER_SIZE - tu->tp.size;
> +	}
> +

This part looks good to me.

Thank you!

>  	store_trace_args(ucb->buf, &tu->tp, regs, NULL, esize, dsize);
>  
>  	*ucbp = ucb;
> -- 
> 2.39.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

