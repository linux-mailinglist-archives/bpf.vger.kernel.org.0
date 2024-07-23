Return-Path: <bpf+bounces-35313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22289397B7
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB362829EF
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCF113210A;
	Tue, 23 Jul 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYTbwVMQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67493EA83
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721696766; cv=none; b=D7BP0J/1fnzcmdSE3g+FcKgx3E+gkVK7ocZ6NIL+sZA/skrhrOYgMqf2uKxANIyuXhD7ON+MOQbzltTcsBmnymYqb0yePH1cw7ht2sVNGeGeqgd7bMRtH5ZL7xOWrYRPKr47kZ4mbIqnQQO7Dxo9ON5L9+Vh53zqzcUIjFEaGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721696766; c=relaxed/simple;
	bh=fzk9LWIwh55EfJ8uiBqNgSktVkirQnaDxdGNAVsxJOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQZLSrVhN7mZ2jCwcWL5AC1xOrhiUj1RevgbZ3yKxiY5MyPVm+MTHUs7S80b16FnR93E3FElVcgVVqkQAJB8kIlHE4eSo/9OHTTJFDc8510CwEnjtQKhzop0M9rzUYiO4f4Ddx+fD/jEKxfMkrKUHTJT023F+1Yt1e79yMPPsU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYTbwVMQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367940c57ddso2506036f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721696763; x=1722301563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13R1hn8oS0v+bkPw5gh4746UIigICsLOTkIrMKlKkE8=;
        b=AYTbwVMQJJlHCj5QWv4PU/TFalnyvA0fU8S2pnq0nezH4uCfM/e390NhVxPxfOydsW
         Nr67V+g58AJ2qehLG8j1MvKHHI7NYjORAEZjDIpjJ4FzPqZqSfXIE5t4it8P8NiWURow
         cj7ooyZF2OUSA77viucLQJthw9jYPva3x7jUNWp5WK1V5jKWz4v9TYy6CCT8ITnxn3zh
         thirdSNuWpR5KWs5xfRtICMM9Cy0Bs80/c28PlZmRlE7ev0DchqVo99dZmoAe84eRLF4
         AolZEkefJ4jCOt7fHyoYTlpwhb3w7XWbPLm3PU9Gkphujill2p36Z5wWOjH9gC4yI/dg
         X19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721696763; x=1722301563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13R1hn8oS0v+bkPw5gh4746UIigICsLOTkIrMKlKkE8=;
        b=iW50DVf7xfCF5UGB7D3uEmCFziezBHftlVi2BexDdeJBA5gwmyb8GMMUbrlXnwGeX9
         f0H8of2R7EJnM5YWzsh7Kt39jjFrdfyoKDeojyIu9Yr9i807nkLkr320aPuIccxeJMTt
         UveC3H3C7HCgAeefIPsMnyYjAsF+fF9DSW6ekm6BwZAbN7K2PQ9/6VWhz2kWuwYPxWlQ
         sByTY3QeW1AkRIsZleUqTntD0rRXGJ0eKMyThPDBXK+JiBEEvsiaW6L4f6JogaZiyzhc
         x+Wd2/7OdOk94bwEPkOqcq23jvfdYpReHlcjitsDQJd3Arb7aROjoAcgTLSFNOPyRgGN
         g4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWve9rJj+rpofiP9pXwdOEWsWUpfLU4vhgPHoIeG6BUyBvxSQmnGU7hxYhjyv6rhg0EQNgHb+23/POVv7MuHMnWdPIi
X-Gm-Message-State: AOJu0YzdDc+F5dZGhfp4Uj6ifmKBbAWahNmdWYMYaPt5Kkj3lJkNDlWz
	4q7LJvLN2IkLKsfEfmV6PQpR5TCO9qgwnaLActKaDof00pvG8/1Z0OT9yZo2QLmmz+pZwyhgGe1
	0roVp4z+PYZwG8UaGbK3mqw5MN58=
X-Google-Smtp-Source: AGHT+IGeps64tWvVaxlexcpJW7Ptw+0LVr4L/j0LPOBfX2g9GvcJeaxDwN0cykPnnOjt2JDVYF/rrxiu6CMtE+izw4c=
X-Received: by 2002:a5d:4c83:0:b0:368:6650:fd16 with SMTP id
 ffacd0b85a97d-369bae252d7mr5148114f8f.38.1721696762844; Mon, 22 Jul 2024
 18:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com> <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com>
In-Reply-To: <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 18:05:51 -0700
Message-ID: <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 1:58=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jul 19, 2024 at 8:28=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jul 18, 2024 at 1:52=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> > >
> > > The main motivation for private stack comes from nested
> > > scheduler in sched-ext from Tejun. The basic idea is that
> > >  - each cgroup will its own associated bpf program,
> > >  - bpf program with parent cgroup will call bpf programs
> > >    in immediate child cgroups.
> > >
> > > Let us say we have the following cgroup hierarchy:
> > >   root_cg (prog0):
> > >     cg1 (prog1):
> > >       cg11 (prog11):
> > >         cg111 (prog111)
> > >         cg112 (prog112)
> > >       cg12 (prog12):
> > >         cg121 (prog121)
> > >         cg122 (prog122)
> > >     cg2 (prog2):
> > >       cg21 (prog21)
> > >       cg22 (prog22)
> > >       cg23 (prog23)
> > >
> > > In the above example, prog0 will call a kfunc which will
> > > call prog1 and prog2 to get sched info for cg1 and cg2 and
> > > then the information is summarized and sent back to prog0.
> > > Similarly, prog11 and prog12 will be invoked in the kfunc
> > > and the result will be summarized and sent back to prog1, etc.
> > >
> > > Currently, for each thread, the x86 kernel allocate 8KB stack.
> > > The each bpf program (including its subprograms) has maximum
> > > 512B stack size to avoid potential stack overflow.
> > > And nested bpf programs increase the risk of stack overflow.
> > > To avoid potential stack overflow caused by bpf programs,
> > > this patch implemented a private stack so bpf program stack
> > > space is allocated dynamically when the program is jited.
> > > Such private stack is applied to tracing programs like
> > > kprobe/uprobe, perf_event, tracepoint, raw tracepoint and
> > > tracing.
> > >
> > > But more than one instance of the same bpf program may
> > > run in the system. To make things simple, percpu private
> > > stack is allocated for each program, so if the same program
> > > is running on different cpus concurrently, we won't have
> > > any issue. Note that the kernel already have logic to prevent
> > > the recursion for the same bpf program on the same cpu
> > > (kprobe, fentry, etc.).
> > >
> > > The patch implemented a percpu private stack based approach
> > > for x86 arch.
> > >   - The stack size will be 0 and any stack access is from
> > >     jit-time allocated percpu storage.
> > >   - In the beginning of jit, r9 is used to save percpu
> > >     private stack pointer.
> > >   - Each rbp in the bpf asm insn is replaced by r9.
> > >   - For each call, push r9 before the call and pop r9
> > >     after the call to preserve r9 value.
> > >
> > > Compared to previous RFC patch [1], this patch added
> > > some conditions to enable private stack, e.g., verifier
> > > calculated stack size, prog type, etc. The new patch
> > > also added a performance test to compare private stack
> > > vs. no private stack.
> > >
> > > The following are some code example to illustrate the idea
> > > for selftest cgroup_skb_sk_lookup:
> > >
> > >    the existing code                        the private-stack approac=
h code
> > >    endbr64                                  endbr64
> > >    nop    DWORD PTR [rax+rax*1+0x0]         nop    DWORD PTR [rax+rax=
*1+0x0]
> > >    xchg   ax,ax                             xchg   ax,ax
> > >    push   rbp                               push   rbp
> > >    mov    rbp,rsp                           mov    rbp,rsp
> > >    endbr64                                  endbr64
> > >    sub    rsp,0x68
> > >    push   rbx                               push   rbx
> > >    ...                                      ...
> > >    ...                                      mov    r9d,0x8c1c860
> > >    ...                                      add    r9,QWORD PTR gs:0x=
21a00
> > >    ...                                      ...
> > >    mov    rdx,rbp                           mov    rdx, r9
> > >    add    rdx,0xffffffffffffffb4            rdx,0xffffffffffffffb4
> > >    ...                                      ...
> > >    mov    ecx,0x28                          mov    ecx,0x28
> > >                                             push   r9
> > >    call   0xffffffffe305e474                call   0xffffffffe305e524
> > >                                             pop    r9
> > >    mov    rdi,rax                           mov    rdi,rax
> > >    ...                                      ...
> > >    movzx  rdi,BYTE PTR [rbp-0x46]           movzx  rdi,BYTE PTR [r9-0=
x46]
> > >    ...                                      ...
> > >
> >
> > Eduard nerd-sniped me today with this a bit... :)
> >
> > I have a few questions and suggestions.
> >
> > So it seems like each *subprogram* (not the entire BPF program) gets
> > its own per-CPU private stack allocation. Is that intentional? That
> > seems a bit unnecessary. It also prevents any sort of actual
> > recursion. Not sure if it's possible to write recursive BPF subprogram
> > today, verifier seems to reject obvious limited recursion cases, but
> > still, eventually we might need/want to support that, and this will be
> > just another hurdle to overcome (so it's best to avoid adding it in
> > the first place).
> >
> > I'm sure Eduard is going to try something like below and it will
> > probably break badly (I haven't tried, sorry):
> >
> > int entry(void *ctx);
> >
> > struct {
> >         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> >         __uint(max_entries, 1);
> >         __uint(key_size, sizeof(__u32));
> >         __array(values, int (void *));
> > } prog_array_init SEC(".maps") =3D {
> >         .values =3D {
> >                 [0] =3D (void *)&entry,
> >         },
> > };
> >
> > static __noinline int subprog1(void)
> > {
> >     <some state on the stack>
> >
> >     /* here entry will replace subprog1, and so we'll have
> >      * entry -> entry -> entry -> ..... <tail call limit> -> subprog1
> >      */
> >     bpf_tail_call(ctx, &prog_array_init, 0);
> >
> >     return 0;
> > }
> >
> >
> > SEC("raw_tp/sys_enter")
> > int entry(void *ctx)
> > {
> >      <some state on the stack>
> >
> >      subprog1();
> > }
> >
> > And we effectively have limited recursion where the entry's stack
> > state is clobbered, no?
> >
> > So it seems like we need to support recursion.
> >
>
> How come everyone just completely ignored the main point of my entire
> email and a real problem that has to be solved?...
>
> Anyways, I did write a below program:
>
> $ cat minimal.bpf.c
> // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /* Copyright (c) 2020 Facebook */
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
>
> char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
>
> int my_pid =3D 0;
>
> int handle_tp(void *ctx);
>
> struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 1);
>         __uint(key_size, sizeof(__u32));
>         __array(values, int (void *));
> } prog_array_init SEC(".maps") =3D {
>         .values =3D {
>                 [0] =3D (void *)&handle_tp,
>         },
> };
>
> static __noinline int subprog(void *ctx)
> {
>         static int cnt;
>
>         cnt++;
>
>         bpf_printk("SUBPROG - BEFORE %d", cnt);
>
>         bpf_tail_call(ctx, &prog_array_init, 0);
>
>         bpf_printk("SUBPROG - AFTER %d", cnt);
>
>     return 0;
> }
>
> SEC("tp/syscalls/sys_enter_write")
> int handle_tp(void *ctx)
> {
>         static int cnt;
>         int pid =3D bpf_get_current_pid_tgid() >> 32;
>
>         if (pid !=3D my_pid)
>                 return 0;
>
>         cnt++;
>
>         bpf_printk("ENTRY - BEFORE %d", cnt);
>
>         subprog(ctx);
>
>         bpf_printk("ENTRY - AFTER %d", cnt);
>
>         return 0;
> }
>
>
> And triggered one write syscall, getting the log above. You can see
> that only subprogs are replaced (we only get "SUBPROG - AFTER 34" due
> to the tail call limit). And we do indeed get lots of entry program
> recurrence.
>
> We *need to support recursion* is my main point.

Not quite.
It's not a recursion. The stack collapsed/gone/wiped out before tail_call.
static int cnt counts stuff because it's static.

So we don't need to support recursion with private stack,
but tail_calls and private stack are buggy indeed.

emit_bpf_tail_call*() shouldn't be adjusting 'rsp' when the private
stack is used.

