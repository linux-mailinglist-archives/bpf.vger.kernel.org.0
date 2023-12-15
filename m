Return-Path: <bpf+bounces-17902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49733813E8A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E581F210DB
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D40A651;
	Fri, 15 Dec 2023 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6BX3Yoc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2337E4;
	Fri, 15 Dec 2023 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so116264a12.1;
        Thu, 14 Dec 2023 16:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702598780; x=1703203580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLqNx1rorYBnNbXaAZk2be4QLk624tdRcgGiRLbinWY=;
        b=b6BX3YocYjbHkUkQ2TEESBpYKxgR+0yZiizUP1D8jyV8hJD3EjDh0hzMsJptSe505B
         4h8r5HJCDs7Jao0IAHr59zT5k8ESW9lB4bWltW7q2tvV4X1Hay5/KH6NZbktOKV6eqom
         /PMRJfS5+eSP+x13H3KtCFk5oDgwudcggJOtUNjW+oN/tRX8J4eVh+slhW5ob4X1dGfo
         3itr+7daXOB0kTANBm08HOYkRoriksqC0zHadf+19klGxFOFAOVKhka/txG5Qc3o+MWs
         nz6cUId0fuK1/Wn2uvOTpjwv6ioWrFGwwgCy9LXR0yAcFLQd7+DaL4gl9WoZV8oyOSjL
         WTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702598780; x=1703203580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLqNx1rorYBnNbXaAZk2be4QLk624tdRcgGiRLbinWY=;
        b=Z0kq2VEIhCaAn7UMI8ucuntOh7O3JnYiGRZxx2aTs+M79TeZ8W0jZtNvy47rBoX3FU
         r0zBneCJYi4CKK2Om20gdITdfDbU2HpH1CJwZEi/7WzAFE3Ynsjhyxysu1fIGzJh1hoE
         BbULiZHo42kB0YXPisAEDd6bInB97huQgFnsnXEv4NPrpTlA+NiplO5PIXeY7fuBPkq/
         LQoq5X8vwPANsoSFHgOlUJKC+hYb4vwv4hiWew89sSc+4g0VKh8TY7pRMn33orI+e2Mk
         tt86ui0UJAw3LSEZckyKOrj4OIKd1oWND4ZCZA5ZIECJf9h3FjFKG/DDaM4qEq1M+ZR2
         qERA==
X-Gm-Message-State: AOJu0Yy0izGKtwUSPlKFdwpkpqlOgh9f/yug06DyxGsL+eG2jDv5A56l
	ZYYRjXnMDsY2C1lCGhCA/5j4mJ4H8YjJecrdbhWbluyChUc=
X-Google-Smtp-Source: AGHT+IFgS5bkMGY/J0G9v5MyAMT2ZIeJnpe3Q7pwoy0/w0wNTENVP4Xo8cWkgis4HZLyuj1NpUnBhK74KJtdgk/Pn+k=
X-Received: by 2002:a50:d5ce:0:b0:54c:862c:3a2 with SMTP id
 g14-20020a50d5ce000000b0054c862c03a2mr5921461edj.31.1702598779973; Thu, 14
 Dec 2023 16:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com> <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
In-Reply-To: <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 16:06:07 -0800
Message-ID: <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:26=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-12-14 at 17:10 +0200, Eduard Zingerman wrote:
> > [...]
> > > The reason why retval checks fails is that the way you disable dead
> > > code removal pass is not complete. Disable opt_remove_dead_code()
> > > just prevent the instruction #30 from being removed, but also note
> > > opt_hard_wire_dead_code_branches(), which convert conditional jump
> > > into unconditional one, so #30 is still skipped.
> > >
> > > > Note that I tried this test with two functions:
> > > > - bpf_get_current_cgroup_id, with this function I get retval 2, not=
 4 :)
> > > > - bpf_get_prandom_u32, with this function I get a random retval eac=
h time.
> > > >
> > > > What is the expectation when 'bpf_get_current_cgroup_id' is used?
> > > > That it is some known (to us) number, but verifier treats it as unk=
nown scalar?
> > > >
> > >
> > > Either one would work, but to make #30 always taken, r0 should be
> > > non-zero.
> >
> > Oh, thank you, I made opt_hard_wire_dead_code_branches() a noop,
> > replaced r0 =3D 0x4 by r0 /=3D 0 and see "divide error: 0000 [#1] PREEM=
PT SMP NOPTI"
> > error in the kernel log on every second or third run of the test
> > (when using prandom).
> >
> > Working to minimize the test case will share results a bit later.
>
> Here is the minimized version of the test:
> https://gist.github.com/eddyz87/fb4d3c7d5aabdc2ae247ed73fefccd32
>
> If executed several times: ./test_progs -vvv -a verifier_and/pruning_test
> it eventually crashes VM with the following error:
>
> [    2.039066] divide error: 0000 [#1] PREEMPT SMP NOPTI
>                ...
> [    2.039987] Call Trace:
> [    2.039987]  <TASK>
> [    2.039987]  ? die+0x36/0x90
> [    2.039987]  ? do_trap+0xdb/0x100
> [    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
> [    2.039987]  ? do_error_trap+0x7d/0x110
> [    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
> [    2.039987]  ? exc_divide_error+0x38/0x50
> [    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
> [    2.039987]  ? asm_exc_divide_error+0x1a/0x20
> [    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
> [    2.039987]  bpf_test_run+0x1b5/0x350
> [    2.039987]  ? bpf_test_run+0x115/0x350
>                ...
>
> I'll continue debugging this a bit later today.
>

Great, thanks a lot, Eduard. Let's paste the program here for discussion:

$ cat progs/verifier_blah.c
// SPDX-License-Identifier: GPL-2.0
/* Copyright (C) 2023 SUSE LLC */
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include "bpf_misc.h"

SEC("socket")
__success
__flag(BPF_F_TEST_STATE_FREQ)
__retval(42)
__naked void pruning_test(void)
{
        asm volatile (
        "   call %[bpf_get_prandom_u32];\n"
        "   r7 =3D r0;\n"
        "   call %[bpf_get_prandom_u32];\n"
        "   r8 =3D 2;\n"
        "   if r0 > 1 goto 1f;\n"
        "   r8 =3D r7;\n"
        "1: r5 =3D r8;\n"
        "   if r8 >=3D r0 goto 2f;\n"
        "   r8 +=3D r8;\n"
        "   if r5 =3D=3D 0 goto 2f;\n"
        "   r0 /=3D 0;\n"
        "2: r0 =3D 42;\n"
        "   exit;\n"
        :
        : __imm(bpf_get_prandom_u32)
        : __clobber_all);
}

char _license[] SEC("license") =3D "GPL";


If we look at relevant portion of verifier log for `if r5 =3D=3D 0` we see =
this:

9: (15) if r5 =3D=3D 0x0 goto pc+1
mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1
mark_precise: frame0: regs=3Dr5,r7 stack=3D before 8: (0f) r8 +=3D r8
mark_precise: frame0: regs=3Dr5,r7 stack=3D before 7: (3d) if r8 >=3D r0 go=
to pc+3

^^ Note here that we only have r5 and r7, not r8.

mark_precise: frame0: parent state regs=3Dr5,r7 stack=3D:
R0_rw=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=
=3D(0x0;
0x1)) R5_rw=3DPscalar(id=3D1) R7_w=3DPscalar(id=3D1) R8_rw=3Dscalar(id=3D1)
R10=3Dfp0
mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx 7
mark_precise: frame0: regs=3Dr5,r7,r8 stack=3D before 6: (bf) r5 =3D r8
mark_precise: frame0: regs=3Dr7,r8 stack=3D before 5: (bf) r8 =3D r7
mark_precise: frame0: regs=3Dr7 stack=3D before 4: (25) if r0 > 0x1 goto pc=
+1
mark_precise: frame0: regs=3Dr7 stack=3D before 3: (b7) r8 =3D 2
mark_precise: frame0: regs=3Dr7 stack=3D before 2: (85) call bpf_get_prando=
m_u32#7
mark_precise: frame0: regs=3Dr7 stack=3D before 1: (bf) r7 =3D r0
mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_prando=
m_u32#7

Note above that r0 in `if r8 >=3D r0` is not marked as precise because
at that point we don't know that r8 should be precise (due to us
"forgetting" linked ID information).

Now, let's comment out the "r8 +=3D r8" instruction so that we preserve
linkage between r5 and r8 (and also r7, but that's less relevant
here).

8: (15) if r5 =3D=3D 0x0 goto pc+1
mark_precise: frame0: last_idx 8 first_idx 7 subseq_idx -1
mark_precise: frame0: regs=3Dr5,r7,r8 stack=3D before 7: (3d) if r8 >=3D r0=
 goto pc+2

^^ Here note how we seek for r5,r7, *and* r8 to be precise...

mark_precise: frame0: parent state regs=3Dr0,r5,r7,r8 stack=3D:

... which leads to us adding r0 to the set due to that `if r8 >=3D r0`
instruction.

(btw, I was wrong yesterday, we do have logic to mark *both* registers
of conditional jump if at least one of them is precise, so seems like
we handle that well)


 R0_rw=3DPscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_of=
f=3D(0x0;
0x1)) R5_rw=3DPscalar(id=3D1) R7_w=3DPscalar(id=3D1) R8_rw=3DPscalar(id=3D1=
)
R10=3Dfp0
mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx 7
mark_precise: frame0: regs=3Dr0,r5,r7,r8 stack=3D before 6: (bf) r5 =3D r8
mark_precise: frame0: regs=3Dr0,r7,r8 stack=3D before 5: (bf) r8 =3D r7
mark_precise: frame0: regs=3Dr0,r7 stack=3D before 4: (25) if r0 > 0x1 goto=
 pc+1
mark_precise: frame0: regs=3Dr0,r7 stack=3D before 3: (b7) r8 =3D 2
mark_precise: frame0: regs=3Dr0,r7 stack=3D before 2: (85) call
bpf_get_prandom_u32#7
mark_precise: frame0: regs=3Dr7 stack=3D before 1: (bf) r7 =3D r0
mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_prando=
m_u32#7


So all in all, I still think that the root cause is what I said
yesterday. We don't preserve information about linked registers at the
per-instruction level, but we should.


If you agree with the analysis, we can start discussing what's the
best way to fix this.

