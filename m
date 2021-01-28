Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A030821B
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 00:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA1XwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 18:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhA1XwH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 18:52:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 687B564DFC
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611877886;
        bh=p2Zk/Iq9h3uMLMz9iPWEKGMlq0c3AFt8yQCFk8gapB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CHLWx0/yYLXww8SepvkW056a/030tJRe7EuVTTk+qlrRRxC/wYPAQHyVV3vbs2bve
         wOhGNfLaroy8RolB00IWSl2I1p9ETg94gtkGlZ5NX77d0N67DlLfqpTL+Dgyf01TO1
         GKE0L/tA3p35pLYBXaGcSo3TsVd9T9P58YKb3i7/HrphfPaVNmYSW8+k/+WPaJWCaW
         9PKpgqohbObJko52vBoCs+jMQw8ku0gtmNUUXhxnO+CyUeld8D8Fkf29QwQKJTnifp
         jyWu0a9LsX1ZR2YwJLN44sIKDkTP3kYBewV3XfUjpXQmMnePxyAJJM1j3woaIZsoi6
         y5irXiih4FgxQ==
Received: by mail-ej1-f44.google.com with SMTP id hs11so10400562ejc.1
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 15:51:26 -0800 (PST)
X-Gm-Message-State: AOAM530tmTT9/xNEYE9msYe0U8P4SEeDDrpmkV4+fo5S8dtXU89EK/KN
        hGmiJPrvJ4VlLnC01unmUHYXj0R/Y/Nn3bsT2wnjqg==
X-Google-Smtp-Source: ABdhPJzvgkfdGo6eum9Cizb80JkTvEQnE2KpPWnO5RuY62vz/cdNzJ3rgDqhwUIK8Mcea5fmYm7CdFogaxt7qkDGrtI=
X-Received: by 2002:a17:906:17d3:: with SMTP id u19mr2047832eje.316.1611877884874;
 Thu, 28 Jan 2021 15:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
In-Reply-To: <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jan 2021 15:51:13 -0800
X-Gmail-Original-Message-ID: <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
Message-ID: <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 27, 2021 at 5:06 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/27/21 1:47 PM, Andy Lutomirski wrote:
> > On Mon, Jan 25, 2021 at 4:12 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> When reviewing patch ([1]), which adds a script to run bpf selftest
> >> through qemu at /sbin/init stage, I found the following kernel bug
> >> warning:
> >>
> >> [  112.118892] BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1351
> >> [  112.119805] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 354, name: new_name
> >> [  112.120512] 3 locks held by new_name/354:
> >> [  112.120868]  #0: ffff88800476e0a0 (&p->lock){+.+.}-{3:3}, at: bpf_seq_read+0x3a/0x3d0
> >> [  112.121573]  #1: ffffffff82d69800 (rcu_read_lock){....}-{1:2}, at: bpf_iter_run_prog+0x5/0x160
> >> [  112.122348]  #2: ffff8880061c2088 (&mm->mmap_lock#2){++++}-{3:3}, at: exc_page_fault+0x1a1/0x640
> >> [  112.123128] Preemption disabled at:
> >> [  112.123130] [<ffffffff8108f913>] migrate_disable+0x33/0x80
> >> [  112.123942] CPU: 0 PID: 354 Comm: new_name Tainted: G           O      5.11.0-rc4-00524-g6e66fbb
> >> 10597-dirty #1249
> >> [  112.124822] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.el7.centos 04/01
> >> /2014
> >> [  112.125614] Call Trace:
> >> [  112.125835]  dump_stack+0x77/0x97
> >> [  112.126137]  ___might_sleep.cold.119+0xf2/0x106
> >> [  112.126537]  exc_page_fault+0x1c1/0x640
> >> [  112.126888]  asm_exc_page_fault+0x1e/0x30
> >> [  112.127241] RIP: 0010:bpf_prog_0a182df2d34af188_dump_bpf_prog+0xf5/0xb3c
> >> [  112.127825] Code: 00 00 8b 7d f4 41 8b 76 44 48 39 f7 73 06 48 01 fb 49 89 df 4c 89 7d d8 49 8b
> >> bd 20 01 00 00 48 89 7d e0 49 8b bd e0 00 00 00 <48> 8b 7f 20 48 01 d7 48 89 7d e8 48 89 e9 48 83 c
> >> 1 d0 48 8b 7d c8
> >> [  112.129433] RSP: 0018:ffffc9000035fdc8 EFLAGS: 00010282
> >> [  112.129895] RAX: 0000000000000000 RBX: ffff888005a49458 RCX: 0000000000000024
> >> [  112.130509] RDX: 00000000000002f0 RSI: 0000000000000509 RDI: 0000000000000000
> >> [  112.131126] RBP: ffffc9000035fe20 R08: 0000000000000001 R09: 0000000000000000
> >> [  112.131737] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000400
> >> [  112.132355] R13: ffff888006085800 R14: ffff888004718540 R15: ffff888005a49458
> >> [  112.132990]  ? bpf_prog_0a182df2d34af188_dump_bpf_prog+0xc8/0xb3c
> >> [  112.133526]  bpf_iter_run_prog+0x75/0x160
> >> [  112.133880]  __bpf_prog_seq_show+0x39/0x40
> >> [  112.134258]  bpf_seq_read+0xf6/0x3d0
> >> [  112.134582]  vfs_read+0xa3/0x1b0
> >> [  112.134873]  ksys_read+0x4f/0xc0
> >> [  112.135166]  do_syscall_64+0x2d/0x40
> >> [  112.135482]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>
> >> To reproduce the issue, with patch [1] and use the following script:
> >>    tools/testing/selftests/bpf/run_in_vm.sh -- cat /sys/fs/bpf/progs.debug
> >>
> >> The reason of the above kernel warning is due to bpf program
> >> tries to dereference an address of 0 and which is not caught
> >> by bpf exception handling logic.
> >>
> >> ...
> >> SEC("iter/bpf_prog")
> >> int dump_bpf_prog(struct bpf_iter__bpf_prog *ctx)
> >> {
> >>          struct bpf_prog *prog = ctx->prog;
> >>          struct bpf_prog_aux *aux;
> >>          ...
> >>          if (!prog)
> >>                  return 0;
> >>          aux = prog->aux;
> >>          ...
> >>          ... aux->dst_prog->aux->name ...
> >>          return 0;
> >> }
> >>
> >> If the aux->dst_prog is NULL pointer, a fault will happen when trying
> >> to access aux->dst_prog->aux.
> >>
> >
> > Which would be a bug in the bpf verifier, no?  This is a bpf program
> > that apparently passed verification, and it somehow dereferenced a
> > NULL pointer.
> >
> > Let's enumerate some cases.
> >
> > 1. x86-like architecture, SMAP enabled.  The CPU determines that this
> > is bogus, and bpf gets lucky, because the x86 code runs the exception
> > handler instead of summarily OOPSing.  IMO it would be entirely
> > reasonable to OOPS.
> >
> > 2 x86-like architecture, SMAP disabled.  This looks like a valid user
> > access, and for all bpf knows, 0 might be an actual mapped address,
> > and it might have userfaultfd attached, etc.  And it's called from a
> > non-sleepable context.  The warning is entirely correct.
> >
> > 3. s390x-like architecture.  This is a dereference of a bad kernel
> > pointer.  OOPS, unless you get lucky.
> >
> >
> > This patch is totally bogus.  You can't work around this by some magic
> > exception handling.  Unless I'm missing something big, this is a bpf
> > bug.  The following is not a valid kernel code pattern:
> >
> > label:
> >    dereference might-be-NULL kernel pointer
> > _EXHANDLER_...(label, ...); /* try to recover */
> >
> > This appears to have been introduced by:
> >
> > commit 3dec541b2e632d630fe7142ed44f0b3702ef1f8c
> > Author: Alexei Starovoitov <ast@kernel.org>
> > Date:   Tue Oct 15 20:25:03 2019 -0700
> >
> >      bpf: Add support for BTF pointers to x86 JIT
> >
> > Alexei, this looks like a very long-winded and ultimately incorrect
> > way to remove the branch from:
> >
> > if (ptr)
> >    val = *ptr;
> >
> > Wouldn't it be better to either just emit the branch directly or to
> > make sure that the pointer is valid in the first place?
>
> Let me explain the motivation for this patch.
>
> Previously, for any kernel data structure access,
> people has to use bpf_probe_read() or bpf_probe_read_kernel()
> helper even most of these accesses are okay and will not
> fault. For example, for
>     int t = a->b->c->d
> three bpf_probe_read() will be needed, e.g.,
>     bpf_probe_read_kernel(&t1, sizeof(t1), &a->b);
>     bpf_probe_read_kernel(&t2, sizeof(t2), &t1->c);
>     bpf_probe_read_kernel(&t, sizeof(t), &t2->d);
>
> if there is a fault, bpf_probe_read_kernel() helper will
> suppress the exception and clears the dest buffer and
> return.
>
> The above usage of bpf_probe_read_kernel()
> is complicated and not C like and bpf developers
> does not like it.
>
> bcc (https://github.com/iovisor/bcc/) permits
> users to write "a->b->c->d" styles and then through
> clang rewriter to convert it to a series of
> bpf_probe_read_kernel()'s. But most users are
> directly using clang to compile their programs so
> they have to write bpf_probe_read_kernel()'s
> by themselves.
>
> The motivation here is to improve user experience so
> user can just write
>     int t = a->b->c->d
> some kernel will automatically take care of exceptions
> and maintain bpf_probe_read_kernel() semantics.
> So what the above patch essentially did is to check if the "regs->ip"
> is one of ips which try to a "bpf_probe_read_kernel()" (actually
> a direct access), it will fix up exception (clear the dest register)
> and returns.

Okay, so I guess you're trying to inline probe_read_kernel().  But
that means you have to inline a valid implementation.  In particular,
you need to check that you're accessing *kernel* memory.  Just like
how get_user() validates that the pointer points into user memory,
your helper should bounds check the pointer.  On x86, you could check
the high bit.

As an extra complication, we should really add logic to
get_kernel_nofault() to verify that the pointer points into actual
memory as opposed to MMIO space (or future incoherent MKTME space or
something like that, sigh).  This will severely complicate inlining
it.  And we should *really* make the same fix to get_kernel_nofault()
-- it should validate that the pointer is a kernel pointer.

Is this really worth inlining instead of having the BPF JIT generate
an out of line call to a real C function?  That would let us put in a
sane implementation.
