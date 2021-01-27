Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB54E3066C0
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 22:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhA0VuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 16:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhA0VsT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 16:48:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CA6A6146D
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 21:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611784058;
        bh=rz+ZXUl4AWKbLQLbYhOknZTsE1d3migpF3nzAC77c4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DlgS1reo1p17/6R58wT4uRkCP5IFP/CP0WdsnXqCEkshYGVYicN8OEVpRDrPBI4hq
         BHkG9Sgkga+zgAQ2XVQtknM1PH2RAtldFX0mRbDPkNay8hlJ4gvKze9GBH0pSuwIUA
         iHt1QFXUfHDULzkXrHzzQBgIdyqKo95o+HC3EBLku67uxkJ/Ywut6PUOrtxTXIoQ5N
         1zXh6q02Bx9DivpjoZCVbou9qjFEVZxJgd+PU4kcMi9UtQaODDrIJTKdkdwqhNlqen
         czW0tejUjBecKMyzx+wwLsG8WYLjFiMYHYHP1g1c/lQkvnU4sHqSIuk33xM3QsVk91
         FgaaA/bz3bwBA==
Received: by mail-ej1-f42.google.com with SMTP id hs11so4815967ejc.1
        for <bpf@vger.kernel.org>; Wed, 27 Jan 2021 13:47:38 -0800 (PST)
X-Gm-Message-State: AOAM5327KBth5AeRMJnTqs1tZNMOKekd1oI76E30ePf3K9STMBDaxJ3m
        3vNSf1WftcMMOgLxQ0G6NOY3eCExEuXSP8oyYFbXjw==
X-Google-Smtp-Source: ABdhPJxRpCAXuwxnGSKHUcaYN5z4RdKAzxhWL/X2LSRJjs/C8dsKJsilB9kcz0BD9nxlpmr38w+lWXkVFUvB/LBzcVo=
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr8232786ejq.101.1611784056568;
 Wed, 27 Jan 2021 13:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com>
In-Reply-To: <20210126001219.845816-1-yhs@fb.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 27 Jan 2021 13:47:25 -0800
X-Gmail-Original-Message-ID: <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
Message-ID: <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Yonghong Song <yhs@fb.com>, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 4:12 PM Yonghong Song <yhs@fb.com> wrote:
>
> When reviewing patch ([1]), which adds a script to run bpf selftest
> through qemu at /sbin/init stage, I found the following kernel bug
> warning:
>
> [  112.118892] BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1351
> [  112.119805] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 354, name: new_name
> [  112.120512] 3 locks held by new_name/354:
> [  112.120868]  #0: ffff88800476e0a0 (&p->lock){+.+.}-{3:3}, at: bpf_seq_read+0x3a/0x3d0
> [  112.121573]  #1: ffffffff82d69800 (rcu_read_lock){....}-{1:2}, at: bpf_iter_run_prog+0x5/0x160
> [  112.122348]  #2: ffff8880061c2088 (&mm->mmap_lock#2){++++}-{3:3}, at: exc_page_fault+0x1a1/0x640
> [  112.123128] Preemption disabled at:
> [  112.123130] [<ffffffff8108f913>] migrate_disable+0x33/0x80
> [  112.123942] CPU: 0 PID: 354 Comm: new_name Tainted: G           O      5.11.0-rc4-00524-g6e66fbb
> 10597-dirty #1249
> [  112.124822] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.el7.centos 04/01
> /2014
> [  112.125614] Call Trace:
> [  112.125835]  dump_stack+0x77/0x97
> [  112.126137]  ___might_sleep.cold.119+0xf2/0x106
> [  112.126537]  exc_page_fault+0x1c1/0x640
> [  112.126888]  asm_exc_page_fault+0x1e/0x30
> [  112.127241] RIP: 0010:bpf_prog_0a182df2d34af188_dump_bpf_prog+0xf5/0xb3c
> [  112.127825] Code: 00 00 8b 7d f4 41 8b 76 44 48 39 f7 73 06 48 01 fb 49 89 df 4c 89 7d d8 49 8b
> bd 20 01 00 00 48 89 7d e0 49 8b bd e0 00 00 00 <48> 8b 7f 20 48 01 d7 48 89 7d e8 48 89 e9 48 83 c
> 1 d0 48 8b 7d c8
> [  112.129433] RSP: 0018:ffffc9000035fdc8 EFLAGS: 00010282
> [  112.129895] RAX: 0000000000000000 RBX: ffff888005a49458 RCX: 0000000000000024
> [  112.130509] RDX: 00000000000002f0 RSI: 0000000000000509 RDI: 0000000000000000
> [  112.131126] RBP: ffffc9000035fe20 R08: 0000000000000001 R09: 0000000000000000
> [  112.131737] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000400
> [  112.132355] R13: ffff888006085800 R14: ffff888004718540 R15: ffff888005a49458
> [  112.132990]  ? bpf_prog_0a182df2d34af188_dump_bpf_prog+0xc8/0xb3c
> [  112.133526]  bpf_iter_run_prog+0x75/0x160
> [  112.133880]  __bpf_prog_seq_show+0x39/0x40
> [  112.134258]  bpf_seq_read+0xf6/0x3d0
> [  112.134582]  vfs_read+0xa3/0x1b0
> [  112.134873]  ksys_read+0x4f/0xc0
> [  112.135166]  do_syscall_64+0x2d/0x40
> [  112.135482]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> To reproduce the issue, with patch [1] and use the following script:
>   tools/testing/selftests/bpf/run_in_vm.sh -- cat /sys/fs/bpf/progs.debug
>
> The reason of the above kernel warning is due to bpf program
> tries to dereference an address of 0 and which is not caught
> by bpf exception handling logic.
>
> ...
> SEC("iter/bpf_prog")
> int dump_bpf_prog(struct bpf_iter__bpf_prog *ctx)
> {
>         struct bpf_prog *prog = ctx->prog;
>         struct bpf_prog_aux *aux;
>         ...
>         if (!prog)
>                 return 0;
>         aux = prog->aux;
>         ...
>         ... aux->dst_prog->aux->name ...
>         return 0;
> }
>
> If the aux->dst_prog is NULL pointer, a fault will happen when trying
> to access aux->dst_prog->aux.
>

Which would be a bug in the bpf verifier, no?  This is a bpf program
that apparently passed verification, and it somehow dereferenced a
NULL pointer.

Let's enumerate some cases.

1. x86-like architecture, SMAP enabled.  The CPU determines that this
is bogus, and bpf gets lucky, because the x86 code runs the exception
handler instead of summarily OOPSing.  IMO it would be entirely
reasonable to OOPS.

2 x86-like architecture, SMAP disabled.  This looks like a valid user
access, and for all bpf knows, 0 might be an actual mapped address,
and it might have userfaultfd attached, etc.  And it's called from a
non-sleepable context.  The warning is entirely correct.

3. s390x-like architecture.  This is a dereference of a bad kernel
pointer.  OOPS, unless you get lucky.


This patch is totally bogus.  You can't work around this by some magic
exception handling.  Unless I'm missing something big, this is a bpf
bug.  The following is not a valid kernel code pattern:

label:
  dereference might-be-NULL kernel pointer
_EXHANDLER_...(label, ...); /* try to recover */

This appears to have been introduced by:

commit 3dec541b2e632d630fe7142ed44f0b3702ef1f8c
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Tue Oct 15 20:25:03 2019 -0700

    bpf: Add support for BTF pointers to x86 JIT

Alexei, this looks like a very long-winded and ultimately incorrect
way to remove the branch from:

if (ptr)
  val = *ptr;

Wouldn't it be better to either just emit the branch directly or to
make sure that the pointer is valid in the first place?

--Andy
