Return-Path: <bpf+bounces-38416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B8964A91
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A7B1C2484D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712F1B3F0A;
	Thu, 29 Aug 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUs8ZMi7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039B1B3758
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946624; cv=none; b=XOgLT11Y1hnYz+aMaU19thYP9eRWNhV+PaSBH+s9pwoW8slXC7gDRR8djLA5ryR3b4C1QVw0LQINnIUBxIejciIz1NgCl8OZLy4aEMuAKx8hUhtxe6qwhlqDxiC3lNlVoHcMRn0CBM44aeF8bPz+w6Drf+OQDZaU1pSUsZuEx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946624; c=relaxed/simple;
	bh=Mt9oXi+cRCWoO6vQGhdRGWzq9CIvR1tzuQnaO9MknOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOHe7TMc7EKeLBbqhcSL8Cp2VrVikscJG8/RFLHILhyWZshtl/I7lsPuzsw1kyMaqJz46zQeivg4Gk5LyPK9+D4KEScV8fD7V1CfiYTm0PDYjONEU7xG8hxxPBMFtfXB5D/4mQ/gUk3owf73KfHVWQmpcRj3dXgumSWdQSoGXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUs8ZMi7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-427fc9834deso82035e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724946621; x=1725551421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLlpduslb3Nup0YapZ+XHfrA6gZyOTFlQOWFXdv5DXc=;
        b=gUs8ZMi7jXTd4cfM/PBUaLz8mz7C7e3reZdlerpK1iO7rHIPga2vd6Ssgn7nPx8zMS
         IV8CDwfH47dgml7+u3K+8puZIXGQTgKX1BjtneYVklIbxrpAzIprwptaRVIDqX7L99sV
         it/DBDNSdjGDwhepA1uy5z7IlaVqQJKjqom7dDQN+ueWmROMuHSjFUzUa8vykgX2CwfQ
         iUD6G/rPqap+8MABhmuXRwIYsBzHjwxBJmLK0IrcRfnPJbDa56O4rgpPG/SlMJFwU1U+
         idXClpcoDq/rNaeMw3xkGbyanMaLeqd1o9zoGkNtcbQ0STw2kCUCEfDWQfwj/HHnQtEo
         Rxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946621; x=1725551421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLlpduslb3Nup0YapZ+XHfrA6gZyOTFlQOWFXdv5DXc=;
        b=Ma0SMc1oknNzwa16+f4o9vosLunoE7wxQ4lJmu1EZsetPEaZ35DSTEFcHwqd8YaSMt
         4bruReTQGPWopI/An4bchf5h9Kqd5iharT5Be7C+DvCeAQXuB7+RJcG1PKu0ZAW759Kz
         5FV9+ir8NXiJ7xkpgxhyI+wPunAIiQ0pLZ+HJOHFY9kbfuKDjGSffyGarO98amNQbYgc
         BMCPex2iifc1wzYfJkqiCNxRs1AeHZ6J+Be8aNEtNOV2jPhau+jGrqYCA1D2H45ojBUC
         wItuvet0xChKqD0EqS+fw8/whzAGxgagvZuJeeFILzvyMdgtY0UDQj5mkabPSzxuktcD
         cxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIua1vNrI2HkS+Z+Jjm2DDSJdUbL6+Ye2i3jy4ChtH1KDUByaYWPumnQA7JeyMeyxWY18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7aTGddav3WZPJYQSAPr6Z+51CDJEHQAc3Zl4hs3QI/vUKZirf
	Ep5mtEn0CRGyqo85wmRfOtREmYAho/IcrrQO3EVxKJlIzLLRhmyZqiZW5vMRiEsXYq8dtGAoJSK
	A20Nv3mm6UaaQ8cABY8Dqs8HWL60GEF4D9DwK
X-Google-Smtp-Source: AGHT+IHQhDGF7YPprlvR4k07dqcjERElj7mv89A99GAbXZwAJdXs2wLoqYZVZqW9oM+scb9rMPKMaXRZYIrBdd69EVk=
X-Received: by 2002:a05:600c:3d16:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-42bb5fcc333mr1360945e9.1.1724946620213; Thu, 29 Aug 2024
 08:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANikGpeQuBKj89rTkaAs5ADrz0+YLQ54g-0CshYzE3h06G0U5g@mail.gmail.com>
 <202408281719.8BBA257@keescook>
In-Reply-To: <202408281719.8BBA257@keescook>
From: Jann Horn <jannh@google.com>
Date: Thu, 29 Aug 2024 17:49:42 +0200
Message-ID: <CAG48ez26ot6z0swcqrR7Z6Eho73BObz-5zO4ts=Qqtn78ZUBYQ@mail.gmail.com>
Subject: Re: BUG: null pointer dereference in seccomp
To: Kees Cook <kees@kernel.org>
Cc: Juefei Pu <juefei.pu@email.ucr.edu>, luto@amacapital.net, wad@chromium.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:38=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Tue, Aug 27, 2024 at 09:09:49PM -0700, Juefei Pu wrote:
> > Hello,
> > We found the following null-pointer-dereference issue using syzkaller
> > on Linux v6.10.
>
> In seccomp! Yikes.
>
> > Unfortunately, the syzkaller failed to generate a reproducer.
>
> That's a bummer.
>
> > But at least we have the report:
> >
> > Oops: general protection fault, probably for non-canonical address
> > 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
> > KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> > CPU: 0 PID: 4493 Comm: systemd-journal Not tainted 6.10.0 #13
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:__bpf_prog_run include/linux/filter.h:691 [inline]
>
> This doesn't look like a NULL deref, this looks like a corrupted
> pointer: 0xdffffc0000000006.

No, it really is a NULL deref - in a non-KASAN build, you'd see a page
fault at virtual address 0x30. KASAN builds with inline
instrumentation cause a GPF on NULL deref because they try to first
check the KASAN shadow mapping for that address, and applying the
shadow address calculation to NULL (or addresses in the low address
space half) gives non-canonical addresses.

This line directly below the oops message is supposed to point this
out (it works by decoding the faulting instruction, calculating the
effective address of the access, and then having KASAN calculate
backwards from the shadow address what the original address could have
been):

KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]

> Is prog bad or dfunc bad? I assume the
> former, as dfunc is hard-coded below...
>
>                 ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
>
> > RIP: 0010:bpf_prog_run include/linux/filter.h:698 [inline]
>
>         return __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
>
> > RIP: 0010:bpf_prog_run_pin_on_cpu include/linux/filter.h:715 [inline]
>
>         ret =3D bpf_prog_run(prog, ctx);
>
> > RIP: 0010:seccomp_run_filters+0x17a/0x3f0 kernel/seccomp.c:426
>
>                 u32 cur_ret =3D bpf_prog_run_pin_on_cpu(f->prog, sd);
>
> > Code: 00 00 e8 99 36 d2 ff 0f 1f 44 00 00 e8 cf 58 ff ff 48 8d 5d 48
> > 48 83 c5 30 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
> > 08 00 74 08 48 89 ef e8 c8 63 62 00 4c 8b 5d 00 48 8b 3c 24
> > RSP: 0018:ffffc90002cb7be0 EFLAGS: 00010206
> > RAX: 0000000000000006 RBX: 0000000000000048 RCX: dffffc0000000000
> > RDX: 0000000000000000 RSI: 00000000000002a4 RDI: ffffffff8b517360
> > RBP: 0000000000000030 R08: ffffffff8191f8eb R09: 1ffff11004039e86
> > R10: dffffc0000000000 R11: ffffffffa00016d0 R12: 000000007fff0000
> > R13: ffff88801f84a800 R14: ffffc90002cb7df0 R15: 000000007fff0000
> > FS:  00007f897e849900(0000) GS:ffff888063a00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f897d771b08 CR3: 00000000195fe000 CR4: 0000000000350ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __seccomp_filter+0x46f/0x1c70 kernel/seccomp.c:1222
> >  syscall_trace_enter+0xa4/0x140 kernel/entry/common.c:52
> >  syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [in=
line]
> >  syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
> >  do_syscall_64+0x5d/0x150 arch/x86/entry/common.c:79
> >  entry_SYSCALL_64_after_hwframe+0x67/0x6f
>
> Has anything changed in BPF in this area lately?
>
> > RIP: 0033:0x7f897ed171e4
> > Code: 84 00 00 00 00 00 44 89 54 24 0c e8 36 58 f9 ff 44 8b 54 24 0c
> > 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
> > 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 58 f9 ff 8b 44
> > RSP: 002b:00007ffd4ae74a60 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> > RAX: ffffffffffffffda RBX: 00005627cd785ed0 RCX: 00007f897ed171e4
> > RDX: 0000000000290000 RSI: 00007f897f010d0a RDI: 00000000ffffff9c
> > RBP: 00007f897f010d0a R08: 0000000000000000 R09: 0034353132303865
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000290000
> > R13: 00007ffd4ae74d20 R14: 0000000000000000 R15: 00007ffd4ae74e28
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:__bpf_prog_run include/linux/filter.h:691 [inline]
> > RIP: 0010:bpf_prog_run include/linux/filter.h:698 [inline]
> > RIP: 0010:bpf_prog_run_pin_on_cpu include/linux/filter.h:715 [inline]
> > RIP: 0010:seccomp_run_filters+0x17a/0x3f0 kernel/seccomp.c:426
> > Code: 00 00 e8 99 36 d2 ff 0f 1f 44 00 00 e8 cf 58 ff ff 48 8d 5d 48
> > 48 83 c5 30 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
> > 08 00 74 08 48 89 ef e8 c8 63 62 00 4c 8b 5d 00 48 8b 3c 24
> > RSP: 0018:ffffc90002cb7be0 EFLAGS: 00010206
> > RAX: 0000000000000006 RBX: 0000000000000048 RCX: dffffc0000000000
> > RDX: 0000000000000000 RSI: 00000000000002a4 RDI: ffffffff8b517360
> > RBP: 0000000000000030 R08: ffffffff8191f8eb R09: 1ffff11004039e86
> > R10: dffffc0000000000 R11: ffffffffa00016d0 R12: 000000007fff0000
> > R13: ffff88801f84a800 R14: ffffc90002cb7df0 R15: 000000007fff0000
> > FS:  00007f897e849900(0000) GS:ffff888063a00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f521f8ca000 CR3: 00000000195fe000 CR4: 0000000000350ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0: 00 00                 add    %al,(%rax)
> >    2: e8 99 36 d2 ff       call   0xffd236a0
> >    7: 0f 1f 44 00 00       nopl   0x0(%rax,%rax,1)
> >    c: e8 cf 58 ff ff       call   0xffff58e0
> >   11: 48 8d 5d 48           lea    0x48(%rbp),%rbx

This LEA looks like it's calculating the address of prog->insnsi.

> >   15: 48 83 c5 30           add    $0x30,%rbp
> >   19: 48 89 e8             mov    %rbp,%rax
> >   1c: 48 c1 e8 03           shr    $0x3,%rax
> >   20: 48 b9 00 00 00 00 00 movabs $0xdffffc0000000000,%rcx
> >   27: fc ff df
> > * 2a: 80 3c 08 00           cmpb   $0x0,(%rax,%rcx,1) <-- trapping inst=
ruction

Here you can see - the access happens at rax+rcx, which is
(rbp>>3)+0xdffffc0000000000. rbp is the actual pointer that will be
accessed; this shift-right-and-add-0xdffffc0000000000 pattern is how
inline KASAN instrumentation determines the shadow address.

> >   2e: 74 08                 je     0x38

Normally we jump over the next two instructions, if the KASAN shadow
is 0 (which means fully accessible)...

> >   30: 48 89 ef             mov    %rbp,%rdi
> >   33: e8 c8 63 62 00       call   0x626400

... continue here:

> >   38: 4c 8b 5d 00           mov    0x0(%rbp),%r11

And here's the actual access to rbp, which is probably loading the
prog->bpf_func.

> >   3c: 48 8b 3c 24           mov    (%rsp),%rdi
>
> What's the movabs? I don't have anything like that in my vmlinux binary
> output. Is this KASAN perhaps?

Yes, inline KASAN.


>
> Regardless, I don't see how prog could be NULL. :( It shouldn't be
> possible without some kind of major refcounting bug.

