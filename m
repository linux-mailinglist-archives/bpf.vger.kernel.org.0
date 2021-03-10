Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2702F334039
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 15:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhCJOV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 09:21:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:51932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232712AbhCJOVD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 09:21:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8220AF05;
        Wed, 10 Mar 2021 14:21:01 +0000 (UTC)
Date:   Wed, 10 Mar 2021 15:21:01 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 3/5] kprobes: treewide: Remove trampoline_address
 from kretprobe_trampoline_handler()
In-Reply-To: <161495876994.346821.11468535974887762132.stgit@devnote2>
Message-ID: <alpine.LSU.2.21.2103101258070.18547@pobox.suse.cz>
References: <161495873696.346821.10161501768906432924.stgit@devnote2> <161495876994.346821.11468535974887762132.stgit@devnote2>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -205,15 +205,23 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				   struct pt_regs *regs);
>  extern int arch_trampoline_kprobe(struct kprobe *p);
>  
> +void kretprobe_trampoline(void);
> +/*
> + * Since some architecture uses structured function pointer,
> + * use arch_deref_entry_point() to get real function address.

s/arch_deref_entry_point/dereference_function_descriptor/ ?

> + */
> +static nokprobe_inline void *kretprobe_trampoline_addr(void)
> +{
> +	return dereference_function_descriptor(kretprobe_trampoline);
> +}
> +

Would it make sense to use this in s390 and powerpc reliable unwinders?

Both

arch/s390/kernel/stacktrace.c:arch_stack_walk_reliable()
arch/powerpc/kernel/stacktrace.c:__save_stack_trace_tsk_reliable()

have

	if (state.ip == (unsigned long)kretprobe_trampoline)
		return -EINVAL;

which you wanted to hide previously if I am not mistaken.

Miroslav
