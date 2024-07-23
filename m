Return-Path: <bpf+bounces-35342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A69398A3
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 05:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F15D1F22B71
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0E13BAFE;
	Tue, 23 Jul 2024 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRnaHAqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0158814
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721705233; cv=none; b=n8Iv2MjL5gZqpTgMyKRMoMutwfdW7ACB3kdNOfsDVmlC6oysEl0Pwk5SiUHxI6yQWvoU9uvWSVwlsNpGiaFz5efiaPIc2MQZxHEv5NT/S/ibtMA8w0S9J0VlJkiTcKJtligoL0pIYTb87ihv4E7KuqdqrOZyC6a1B/ZcfUF/LZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721705233; c=relaxed/simple;
	bh=4kTTU9+TKBtb4ma/Ui2p8o/UfszBTlXcNyy5udaC2l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ite+5p8Wx3SmHKTc8Fg4YgIGUw6XlsijybiM14FpG26tKRgB75hw/zcDbtUH94K9NnxMuZm92EyH82p96zZjIn2mQUQXfygaBe05m5h7rGwMJhXQxZpdFBOCScEC4DkMabTKkIcbeUHjXHUZxhbJ+N8dEAh/SiWPKMrF9bOMKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRnaHAqw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cd487b5470so956557a91.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 20:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721705231; x=1722310031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vcA+geHDsKKzreLfC1GZTDkvFjKRitKRSrjZOhYz7c=;
        b=TRnaHAqwx1fXX7/VVRTd9pbMulbavIEn7h+CR9v8iUn/VCfekLGm9tervSwoInm5h9
         NDOknqV7HJhCWmFE52WRgiOha7Vd8R7rS3GaPxKoq47c51D4N7xDpDXcRznxHptOWvPN
         rRAA0t8XN8D+xIfdCvS9TtE20xsmrSbG5HJKaA0xUC39Z1pP+HbiAd2zjzvRyyy3zNow
         EjwFsNGl48OU6Qg1jAEXVmXRONsTW87PMfJyJwwiunaOvmfY7AyL2Fx86WMX1Lmf8r+a
         PWEQdCI0RBPFKpAvxih/eLxrW6zvpRztX7i25UVgUNVcq/4E1Nb/OMjY0KZxZtrXPJKb
         NQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721705231; x=1722310031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vcA+geHDsKKzreLfC1GZTDkvFjKRitKRSrjZOhYz7c=;
        b=TVVVMVA6ChxmZjHKpDrT5WnXVJQ6k9mGaXwie9LT1K4cK9a9PD1m/i3wYladBzLm+a
         XkO79QmD9mqLpkgonGKvcL8Mft6+1TtP3g3K/Fepv/nCsN3A686St4Ns6fXhUfMf0ESx
         DbcTA8oVEYjpwasurtMvIHalGjxl/QohMI8AKalkzZHDSOcOyxKHHufPSG585h9AvVeY
         aVOyvl5u6JkhDC/XT8fVVIqL7D2camLb+mCNBZPo4kIN4s0Bdmx0uEGrF8Fg8H+Gvjcv
         3du1+TvkCGHBApkUas5MNNueQNF2JEL6RGyUjR+q6uknrWZFcUhpXvAkkOBt7iwB6fcd
         bVEg==
X-Forwarded-Encrypted: i=1; AJvYcCUXfXD2jzCpyRr753l72q0Rm+pfoz30utaHVOZ1shI2tjombOQSCb21aXw2M8s9WJ3O+a8XGtzVUqgpTwTmFB1fDEeE
X-Gm-Message-State: AOJu0YzTAu58yZOcLWNCaB+cT6hehqSFuAh7huK9WnDxF57di5/PGA56
	3faHMdYbUcW9dUGfMVG2ELM8AqcpY7tJpBm79l6MNCd/kXGI44D/0+UMOnNYqkhCQGti59y8C+h
	NQ/rj6BZcIojwUMp90gPLQMpgb74=
X-Google-Smtp-Source: AGHT+IFURJbvDO3QXlG6ImTNXu0X6K6E0t25GjL5AZ2UPGzNm1BeLb5Xmf80/bwA4FZ+TqyhgcS+HGyg+nw78HTYDFw=
X-Received: by 2002:a17:90a:6081:b0:2cd:2c4d:9345 with SMTP id
 98e67ed59e1d1-2cd85c25254mr1543413a91.6.1721705230626; Mon, 22 Jul 2024
 20:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com> <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com>
In-Reply-To: <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Jul 2024 20:26:58 -0700
Message-ID: <CAEf4BzbC0vORHOgKhrh6UAog227u+5x9Wpgp0D3aduka=gN4pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 6:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 22, 2024 at 1:58=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jul 19, 2024 at 8:28=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 1:52=E2=80=AFPM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> > > >
> > > > The main motivation for private stack comes from nested
> > > > scheduler in sched-ext from Tejun. The basic idea is that
> > > >  - each cgroup will its own associated bpf program,
> > > >  - bpf program with parent cgroup will call bpf programs
> > > >    in immediate child cgroups.
> > > >
> > > > Let us say we have the following cgroup hierarchy:
> > > >   root_cg (prog0):
> > > >     cg1 (prog1):
> > > >       cg11 (prog11):
> > > >         cg111 (prog111)
> > > >         cg112 (prog112)
> > > >       cg12 (prog12):
> > > >         cg121 (prog121)
> > > >         cg122 (prog122)
> > > >     cg2 (prog2):
> > > >       cg21 (prog21)
> > > >       cg22 (prog22)
> > > >       cg23 (prog23)
> > > >
> > > > In the above example, prog0 will call a kfunc which will
> > > > call prog1 and prog2 to get sched info for cg1 and cg2 and
> > > > then the information is summarized and sent back to prog0.
> > > > Similarly, prog11 and prog12 will be invoked in the kfunc
> > > > and the result will be summarized and sent back to prog1, etc.
> > > >
> > > > Currently, for each thread, the x86 kernel allocate 8KB stack.
> > > > The each bpf program (including its subprograms) has maximum
> > > > 512B stack size to avoid potential stack overflow.
> > > > And nested bpf programs increase the risk of stack overflow.
> > > > To avoid potential stack overflow caused by bpf programs,
> > > > this patch implemented a private stack so bpf program stack
> > > > space is allocated dynamically when the program is jited.
> > > > Such private stack is applied to tracing programs like
> > > > kprobe/uprobe, perf_event, tracepoint, raw tracepoint and
> > > > tracing.
> > > >
> > > > But more than one instance of the same bpf program may
> > > > run in the system. To make things simple, percpu private
> > > > stack is allocated for each program, so if the same program
> > > > is running on different cpus concurrently, we won't have
> > > > any issue. Note that the kernel already have logic to prevent
> > > > the recursion for the same bpf program on the same cpu
> > > > (kprobe, fentry, etc.).
> > > >
> > > > The patch implemented a percpu private stack based approach
> > > > for x86 arch.
> > > >   - The stack size will be 0 and any stack access is from
> > > >     jit-time allocated percpu storage.
> > > >   - In the beginning of jit, r9 is used to save percpu
> > > >     private stack pointer.
> > > >   - Each rbp in the bpf asm insn is replaced by r9.
> > > >   - For each call, push r9 before the call and pop r9
> > > >     after the call to preserve r9 value.
> > > >
> > > > Compared to previous RFC patch [1], this patch added
> > > > some conditions to enable private stack, e.g., verifier
> > > > calculated stack size, prog type, etc. The new patch
> > > > also added a performance test to compare private stack
> > > > vs. no private stack.
> > > >
> > > > The following are some code example to illustrate the idea
> > > > for selftest cgroup_skb_sk_lookup:
> > > >
> > > >    the existing code                        the private-stack appro=
ach code
> > > >    endbr64                                  endbr64
> > > >    nop    DWORD PTR [rax+rax*1+0x0]         nop    DWORD PTR [rax+r=
ax*1+0x0]
> > > >    xchg   ax,ax                             xchg   ax,ax
> > > >    push   rbp                               push   rbp
> > > >    mov    rbp,rsp                           mov    rbp,rsp
> > > >    endbr64                                  endbr64
> > > >    sub    rsp,0x68
> > > >    push   rbx                               push   rbx
> > > >    ...                                      ...
> > > >    ...                                      mov    r9d,0x8c1c860
> > > >    ...                                      add    r9,QWORD PTR gs:=
0x21a00
> > > >    ...                                      ...
> > > >    mov    rdx,rbp                           mov    rdx, r9
> > > >    add    rdx,0xffffffffffffffb4            rdx,0xffffffffffffffb4
> > > >    ...                                      ...
> > > >    mov    ecx,0x28                          mov    ecx,0x28
> > > >                                             push   r9
> > > >    call   0xffffffffe305e474                call   0xffffffffe305e5=
24
> > > >                                             pop    r9
> > > >    mov    rdi,rax                           mov    rdi,rax
> > > >    ...                                      ...
> > > >    movzx  rdi,BYTE PTR [rbp-0x46]           movzx  rdi,BYTE PTR [r9=
-0x46]
> > > >    ...                                      ...
> > > >
> > >
> > > Eduard nerd-sniped me today with this a bit... :)
> > >
> > > I have a few questions and suggestions.
> > >
> > > So it seems like each *subprogram* (not the entire BPF program) gets
> > > its own per-CPU private stack allocation. Is that intentional? That
> > > seems a bit unnecessary. It also prevents any sort of actual
> > > recursion. Not sure if it's possible to write recursive BPF subprogra=
m
> > > today, verifier seems to reject obvious limited recursion cases, but
> > > still, eventually we might need/want to support that, and this will b=
e
> > > just another hurdle to overcome (so it's best to avoid adding it in
> > > the first place).
> > >
> > > I'm sure Eduard is going to try something like below and it will
> > > probably break badly (I haven't tried, sorry):
> > >
> > > int entry(void *ctx);
> > >
> > > struct {
> > >         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> > >         __uint(max_entries, 1);
> > >         __uint(key_size, sizeof(__u32));
> > >         __array(values, int (void *));
> > > } prog_array_init SEC(".maps") =3D {
> > >         .values =3D {
> > >                 [0] =3D (void *)&entry,
> > >         },
> > > };
> > >
> > > static __noinline int subprog1(void)
> > > {
> > >     <some state on the stack>
> > >
> > >     /* here entry will replace subprog1, and so we'll have
> > >      * entry -> entry -> entry -> ..... <tail call limit> -> subprog1
> > >      */
> > >     bpf_tail_call(ctx, &prog_array_init, 0);
> > >
> > >     return 0;
> > > }
> > >
> > >
> > > SEC("raw_tp/sys_enter")
> > > int entry(void *ctx)
> > > {
> > >      <some state on the stack>
> > >
> > >      subprog1();
> > > }
> > >
> > > And we effectively have limited recursion where the entry's stack
> > > state is clobbered, no?
> > >
> > > So it seems like we need to support recursion.
> > >
> >
> > How come everyone just completely ignored the main point of my entire
> > email and a real problem that has to be solved?...
> >
> > Anyways, I did write a below program:
> >
> > $ cat minimal.bpf.c
> > // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > /* Copyright (c) 2020 Facebook */
> > #include <linux/bpf.h>
> > #include <bpf/bpf_helpers.h>
> >
> > char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
> >
> > int my_pid =3D 0;
> >
> > int handle_tp(void *ctx);
> >
> > struct {
> >         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> >         __uint(max_entries, 1);
> >         __uint(key_size, sizeof(__u32));
> >         __array(values, int (void *));
> > } prog_array_init SEC(".maps") =3D {
> >         .values =3D {
> >                 [0] =3D (void *)&handle_tp,
> >         },
> > };
> >
> > static __noinline int subprog(void *ctx)
> > {
> >         static int cnt;
> >
> >         cnt++;
> >
> >         bpf_printk("SUBPROG - BEFORE %d", cnt);
> >
> >         bpf_tail_call(ctx, &prog_array_init, 0);
> >
> >         bpf_printk("SUBPROG - AFTER %d", cnt);
> >
> >     return 0;
> > }
> >
> > SEC("tp/syscalls/sys_enter_write")
> > int handle_tp(void *ctx)
> > {
> >         static int cnt;
> >         int pid =3D bpf_get_current_pid_tgid() >> 32;
> >
> >         if (pid !=3D my_pid)
> >                 return 0;
> >
> >         cnt++;
> >
> >         bpf_printk("ENTRY - BEFORE %d", cnt);
> >
> >         subprog(ctx);
> >
> >         bpf_printk("ENTRY - AFTER %d", cnt);
> >
> >         return 0;
> > }
> >
> >
> > And triggered one write syscall, getting the log above. You can see
> > that only subprogs are replaced (we only get "SUBPROG - AFTER 34" due
> > to the tail call limit). And we do indeed get lots of entry program
> > recurrence.
> >
> > We *need to support recursion* is my main point.
>
> Not quite.
> It's not a recursion. The stack collapsed/gone/wiped out before tail_call=
.

Only of subprog(), not of handle_tp(). See all those "ENTRY - AFTER"
messages. We do return to all the nested handle_tp() calls and
continue just fine.

I put the log into [0] for a bit easier visual inspection.

  [0] https://gist.github.com/anakryiko/6ccdfc62188f8ad4991641fb637d954c

> static int cnt counts stuff because it's static.
>
> So we don't need to support recursion with private stack,
> but tail_calls and private stack are buggy indeed.
>
> emit_bpf_tail_call*() shouldn't be adjusting 'rsp' when the private
> stack is used.

