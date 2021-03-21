Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA03433F0
	for <lists+bpf@lfdr.de>; Sun, 21 Mar 2021 18:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCURwW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Mar 2021 13:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229979AbhCURwO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Mar 2021 13:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616349133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OUQcTLjkdYrw1qI1yr8Rlrjg67qksaZPFpUGmu0VlU4=;
        b=HlnhZazB/eV/9FsVeQxjD7B2yy37w1X19dyPku33pzQcfzMhVke7SnvbM9/CEt4M34Ga4z
        cRxrzu7EPCBO0MZ4pv+pKStk3ZCidkiXf8oMmPEr6Ekv/Wwp4PrjpE7bc3h1deYjOkQa/H
        N0OTs+c8ysqhpH2zfaGFS2TjjsW/C64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-TllxpVzxNtiF6eT2qcSJew-1; Sun, 21 Mar 2021 13:52:11 -0400
X-MC-Unique: TllxpVzxNtiF6eT2qcSJew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA1325B362;
        Sun, 21 Mar 2021 17:52:09 +0000 (UTC)
Received: from treble (ovpn-112-151.rdu2.redhat.com [10.10.112.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6827B62461;
        Sun, 21 Mar 2021 17:52:06 +0000 (UTC)
Date:   Sun, 21 Mar 2021 12:52:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH -tip v3 05/11] x86/kprobes: Add UNWIND_HINT_FUNC on
 kretprobe_trampoline code
Message-ID: <20210321175203.4kcptzgs6pwxh5oh@treble>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
 <161615655969.306069.4545805781593088526.stgit@devnote2>
 <20210320211616.a976fc66d0c51e13d3121e2f@kernel.org>
 <20210320220543.e1558ce3a351554c6be3ea26@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210320220543.e1558ce3a351554c6be3ea26@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 20, 2021 at 10:05:43PM +0900, Masami Hiramatsu wrote:
> On Sat, 20 Mar 2021 21:16:16 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Fri, 19 Mar 2021 21:22:39 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > > 
> > > Add UNWIND_HINT_FUNC on kretporbe_trampoline code so that ORC
> > > information is generated on the kretprobe_trampoline correctly.
> > > 
> > 
> > Test bot also found a new warning for this.
> > 
> > > >> arch/x86/kernel/kprobes/core.o: warning: objtool: kretprobe_trampoline()+0x25: call without frame pointer save/setup
> > 
> > With CONFIG_FRAME_POINTER=y.
> > 
> > Of course this can be fixed with additional "push %bp; mov %sp, %bp" before calling
> > trampoline_handler. But actually we know that this function has a bit special
> > stack frame too. 
> > 
> > Can I recover STACK_FRAME_NON_STANDARD(kretprobe_trampoline) when CONFIG_FRAME_POINTER=y ?
> 
> So something like this. Does it work?
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index b31058a152b6..651f337dc880 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -760,6 +760,10 @@ int kprobe_int3_handler(struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(kprobe_int3_handler);
>  
> +#ifdef CONFIG_FRAME_POINTER
> +#undef UNWIND_HINT_FUNC
> +#define UNWIND_HINT_FUNC
> +#endif

This hunk isn't necessary.  The unwind hints don't actually have an
effect with frame pointers.

>  /*
>   * When a retprobed function returns, this code saves registers and
>   * calls trampoline_handler() runs, which calls the kretprobe's handler.
> @@ -797,7 +801,14 @@ asm(
>  	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
>  );
>  NOKPROBE_SYMBOL(kretprobe_trampoline);
> -
> +#ifdef CONFIG_FRAME_POINTER
> +/*
> + * kretprobe_trampoline skips updating frame pointer. The frame pointer
> + * saved in trampoline_handler points to the real caller function's
> + * frame pointer.
> + */
> +STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
> +#endif
>  
>  /*
>   * Called from kretprobe_trampoline

Ack.

-- 
Josh

