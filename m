Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD7C3FBCC1
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhH3TGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhH3TGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 15:06:02 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31102C061575;
        Mon, 30 Aug 2021 12:05:08 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v19so16617615ybv.9;
        Mon, 30 Aug 2021 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iq88rt+bkBOjHt9lnMugBUtWcA1Pi2Qr+AfgrTf4Tro=;
        b=mI7Z+EkcDZxptsnn+NdYNNruhnmO+15i71gU88do/cMT9RCxgouuSAxfaXpiwX+Iv7
         foEkwBDwm4Uu3hdUjSPpSd7aTenZoR7ZtF9eng9ayWEpOmctFWgDWNZPKLMtfZMyZSpD
         TkbDLgAb8SzdLIBTov7wAmwkYM5TlDr1lubOj1Q6uZ1D6l35ES/jJIY92QjyKTJ5vofT
         A62k8sMexGEvC9CGq4njL7i1zcl4xzdmo+9uP6q45idVtrxnmA+Kl+xymML2Dmhqm3RV
         zKmZXNZSkXogQzZnFMIbASzXh47dt7BrM+gqnOW1vZlm+va9IhY/qumhiDL+TKlLcEUJ
         36Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iq88rt+bkBOjHt9lnMugBUtWcA1Pi2Qr+AfgrTf4Tro=;
        b=gACMPsKtF4Sirvugc+IPuA4rAc8+2ePOYVW5eOukJ/Q2x6xK9R6AfVfZ4xsecMTxIX
         r5iYs6lEuMtD1YvHzakdB5fdULRxt5Zlt2RVsetiCvWGp+TPaigdyShKFZ6s6aaJHnaz
         m2vXtWdc9lBFqptDeaXzRSOARWS18dFM+uyWjLvaxYf60h4Jv6zHq3zvid06pMG510vz
         f1tRhGmYjFoaDcPUfa4Qj5yoyvZSJFyItleSq/uafH+hBSPWSdW8WgUqQ9x+rTIcPXja
         YWW8iahhj2xTgvm4SEkUegoSk3ZJhVRG3t/xvfPZ9Gbccuov6l8p6LXrUfg2VcxtXSdx
         qfXw==
X-Gm-Message-State: AOAM530nHOEsWN/WYhPT+JO+EJ1IPhyOeIcSKTo1QD78p7WMnaexWA6c
        UAwO9Yuob5DV0EiZpR9Wlo7ISM4K5HyVV5DyuKIfDCh/f4M=
X-Google-Smtp-Source: ABdhPJxMZEuIbVQ7KIIzLj0InJxIVVLpvXZyMG41cAigOqrmaFBgqH5biJ/zyZIOrh+xdguT51vlqy/bi6YqU3foX7Y=
X-Received: by 2002:a25:5e8a:: with SMTP id s132mr25477533ybb.510.1630350307295;
 Mon, 30 Aug 2021 12:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <162756755600.301564.4957591913842010341.stgit@devnote2> <163024693462.457128.1437820221831758047.stgit@devnote2>
In-Reply-To: <163024693462.457128.1437820221831758047.stgit@devnote2>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Aug 2021 12:04:56 -0700
Message-ID: <CAEf4BzbQZqtHAt5XMVxpeH2AmfaWmrqesB5fZavcwESudymR+g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Non stack-intrusive return probe event
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 29, 2021 at 7:22 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hello,
>
> For a long time, we tackled to fix some issues around kretprobe.
> One of the latest action was the stacktrace fix on x86 in this
> thread.
>
> https://lore.kernel.org/bpf/162756755600.301564.4957591913842010341.stgit@devnote2/
>
> However, there seems no progress/further discussion. So I would
> like to make another approach for this (and the other issues.)

v10 of kretprobe+stacktrace fixes ([0]) from Masami has received no
comment or objections in the last month, since it was posted. It fixes
the very real and very limiting problem of not being able to capture a
stack trace from BPF kretprobe programs. Masami, while I don't mind
your new approach, I think we shouldn't consider them as "either/or"
solutions. We have a fix that works for existing implementations, can
we please land it, and then work on further improvements
independently?

Ingo, Peter, Steven,

I'm not sure who and which kernel tree this has to go through, but
assuming it's one of you/yours, can you please take a look at [0] and
apply it where appropriate? The work has been going on since March and
it blocks development of some extremely useful tooling (retsnoop [1]
being one of them). There were also bpftrace users that were
completely surprised about the inability to use stack trace capturing
from kretprobe handlers, so it's not just me. I (and a bunch of other
BPF users) would greatly appreciate help with getting this problem
fixed. Thank you!

  [0] https://lore.kernel.org/bpf/162756755600.301564.4957591913842010341.stgit@devnote2/
  [1] https://github.com/anakryiko/retsnoop

>
> Here is my idea -- replace kretprobe with kprobe.
> In other words, put a kprobe on the "return instruction" directly
> instead of modifying the kernel stack. This can solve most
> of the kretprobe disadvantges. E.g.
>
> - Since it doesn't change the kernel stack, any special stack
>   unwinder fixup is not needed anymore.
> - No "max-instance" limitations anymore, because it will use
>   kprobes directly.
> - Scalability performance will be improved as same as kprobes.
>   No list-operation in probe-runtime.
>
> Here is a PoC code which introduces "retinsn_probe" event as a part
> of ftrace kprobe event. I don't think we need to replace the
> kretprobe. This should be a higher layer feature, because some
> kernel functions can have multiple "return instructions". Thus,
> the "retinsn_probe" must manage multiple kprobes. That means the
> "retinsn_probe" will be a user of kprobes. I decided to make it
> inside the ftrace "kprobe-event". This gives us another advantage
> for eBPF support. Because eBPF uses "kprobe-event" instead of
> "kprobe" directly, if the "retinsn_probe" is implemented in the
> "kprobe-event", eBPF can use it without any change.
> Anyway, this can be co-exist with kretprobe. So as far as any
> user uses kretprobe, we can keep it.
>
>
> Example
> =======
> For example, I ran a shell script, which was used in the
> stacktrace fix series.
>
> ----
> mount -t debugfs debugfs /sys/kernel/debug/
> cd /sys/kernel/debug/tracing
> echo > trace
> echo 1 > options/sym-offset
> echo r vfs_read >> kprobe_events
> echo r full_proxy_read >> kprobe_events
> echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
> echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
> echo 1 > events/kprobes/enable
> cat /sys/kernel/debug/kprobes/list
> echo 0 > events/kprobes/enable
> cat trace
> ----
>
> This is the result.
> ----
> ffffffff813b420e  k  full_proxy_read+0x6e
> ffffffff812b7c0a  k  vfs_read+0xda
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 3/3   #P:8
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| /     delay
> #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
> #              | |         |   ||||      |         |
>              cat-136     [007] d.Z.     8.038381: r_full_proxy_read_0: (vfs_read+0x9b/0x180 <- full_proxy_read)
>              cat-136     [007] d.Z.     8.038386: <stack trace>
>  => kretprobe_trace_func+0x209/0x300
>  => retinsn_dispatcher+0x7a/0xa0
>  => kprobe_post_process+0x28/0x80
>  => kprobe_int3_handler+0x166/0x1a0
>  => exc_int3+0x47/0x140
>  => asm_exc_int3+0x31/0x40
>  => vfs_read+0x9b/0x180
>  => ksys_read+0x68/0xe0
>  => do_syscall_64+0x3b/0x90
>  => entry_SYSCALL_64_after_hwframe+0x44/0xae
>              cat-136     [007] d.Z.     8.038387: r_vfs_read_0: (ksys_read+0x68/0xe0 <- vfs_read)
> ----
>
> You can see the return probe events are translated to kprobes
> instead of kretprobes. And also, on the stacktrace, we can see
> an int3 calls the kprobe and decode stacktrace correctly.
>
>
> TODO
> ====
> Of course, this is just an PoC code, there are many TODOs.
>
> - This PoC code only supports x86 at this moment. But I think this
>   can be done on the other architectures. What it needs is
>   to implement "find_return_instructions()".
> - Code cleanup is not enough. I have to remove "kretprobe" from
>  "trace_kprobe" data structure, rewrite related functions etc.
> - It has to handle "tail-call" optimized code, which replaces
>   a "call + return" into "jump". find_return_instruction() should
>   detect it and decode the jump destination too.
>
>
> Thank you,
>
>
> ---
>
> Masami Hiramatsu (1):
>       [PoC] tracing: kprobe: Add non-stack intrusion return probe event
>
>
>  arch/x86/kernel/kprobes/core.c |   59 +++++++++++++++++++++
>  kernel/trace/trace_kprobe.c    |  110 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 164 insertions(+), 5 deletions(-)
>
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
