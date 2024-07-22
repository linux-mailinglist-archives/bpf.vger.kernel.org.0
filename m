Return-Path: <bpf+bounces-35272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420DC939502
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 22:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D656228242E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D238DC7;
	Mon, 22 Jul 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbHipz63"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10B1C6A8
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681880; cv=none; b=fMqenDF9RVStfE4XQ8DqL18JLF+TfgyKQyCrTczJEFG7Gno7eiZwbdgPsZZYn+1qVsgZeCKpOS0X7GfKzZll9kb6kf60lXLUGcGj6/1LGic1p8/bjcMzQsaubRzD+KmoRiqhC9Gi5SXQLKcaZi/0bj2TA9zF7pslI+gm6X9jHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681880; c=relaxed/simple;
	bh=W/9zQxnHQ+JWjmCaDNX14K0oZWtsWTurqxRaKunA4aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlDxyzomV9d2WwB8aH0Np71I+f0deOQLnUt1PiShsmK7ldL8SCTHAOIPLaa7ghKGl7JvvNjWWeJhtMRN/Hp9rWjiOswHTKk2y4N1IcG4AyWtaZbWTeO/2kUTYGiTd052Xh6eHp1rl6erXoJNfDKnK+FlKRPT8SLp2vHifvcO2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbHipz63; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so96994a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721681878; x=1722286678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWEuNq7SBmUl8ue/w4x1VAWXYbyYoaPuvWAQnBwcVnA=;
        b=PbHipz63mYZ0zeB8TSINajbaMXtiNzg3stG7N4eRhAQcF2dOET1IRkFRr6FvqQkogv
         7WxU/4GXux+ECIZYA+0SVkmFrrws4Fez0RI3IYI19krjF3yYSMJZ9C8bOaoF717jYpPj
         As5ZvBKye4BCl6/ofBW1mg91bv0xxdlJbqqZo9yFZ4k9guZKXugMfmIxwbJSjYz6yzqA
         2sG3OgMCsMqvi/EYc/lM4zyPw2B6nAkNh9qr7H5ucfBQHj0jkqooj7g1vE7I0u3pzSQ6
         CqWKu4ciqhEIYSM/pBas7+6/H3S/H1seUzZvCkH6pQqugi0+zxJqYAZp3ERTmquyMPFp
         HdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721681878; x=1722286678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWEuNq7SBmUl8ue/w4x1VAWXYbyYoaPuvWAQnBwcVnA=;
        b=grl9odNjFYrmCxL/rtBK1IQInEUhI11n09AMiT+4P/1NedXHw1C4RNR7uuFMYzrqcW
         IXoK41VKr/itI0CVE1xCzrNuslpTLmoTdJzPeAjyLvOnc9akvfPO3folQWnU9hsRhOWA
         D7ekbZwXJdNhqChkgDHoasahHMhX/GRDlgwj/m+QEl1BEgp42lwWMZXBMwFYudpgIVgI
         gK/XSHcluy8Gvvic9SiXymdwx72SyQ4sMR/lwAAP5vx/UPp79cMmQ1w2AWRu85mLCUec
         e/0MVDWpcnJGKlaI0h+YhpUEtez0GsZPLRpDR6ADQEtsgBTbpz0eRY0gdlOHuquTKgdS
         /MIQ==
X-Gm-Message-State: AOJu0YwgSLmoBmmWdv30PfFm7rhGHUK2yd+SapdFzfLAydaCYbWSHvyM
	lW1rc+AELe8T+LODKb9ReqDG/nmixMk4A8EzRZ24/V6VlTSy3AuouqOCsjm0+bLAgEH3/HsMu5k
	urvYs07mey7xBNrCQKKeeSArhS+d5kFsL
X-Google-Smtp-Source: AGHT+IFpugQLXc0msqEtnsll4oYVYzsswYvB6aWgBt+CA2dXvvxb2bNR+9PaV03w0r2PQSuUTgbYk7ryUZjNm8EWnOM=
X-Received: by 2002:a17:90b:1a90:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2cd8cd20422mr154849a91.3.1721681877943; Mon, 22 Jul 2024
 13:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev> <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Jul 2024 13:57:45 -0700
Message-ID: <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 8:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jul 18, 2024 at 1:52=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> > The main motivation for private stack comes from nested
> > scheduler in sched-ext from Tejun. The basic idea is that
> >  - each cgroup will its own associated bpf program,
> >  - bpf program with parent cgroup will call bpf programs
> >    in immediate child cgroups.
> >
> > Let us say we have the following cgroup hierarchy:
> >   root_cg (prog0):
> >     cg1 (prog1):
> >       cg11 (prog11):
> >         cg111 (prog111)
> >         cg112 (prog112)
> >       cg12 (prog12):
> >         cg121 (prog121)
> >         cg122 (prog122)
> >     cg2 (prog2):
> >       cg21 (prog21)
> >       cg22 (prog22)
> >       cg23 (prog23)
> >
> > In the above example, prog0 will call a kfunc which will
> > call prog1 and prog2 to get sched info for cg1 and cg2 and
> > then the information is summarized and sent back to prog0.
> > Similarly, prog11 and prog12 will be invoked in the kfunc
> > and the result will be summarized and sent back to prog1, etc.
> >
> > Currently, for each thread, the x86 kernel allocate 8KB stack.
> > The each bpf program (including its subprograms) has maximum
> > 512B stack size to avoid potential stack overflow.
> > And nested bpf programs increase the risk of stack overflow.
> > To avoid potential stack overflow caused by bpf programs,
> > this patch implemented a private stack so bpf program stack
> > space is allocated dynamically when the program is jited.
> > Such private stack is applied to tracing programs like
> > kprobe/uprobe, perf_event, tracepoint, raw tracepoint and
> > tracing.
> >
> > But more than one instance of the same bpf program may
> > run in the system. To make things simple, percpu private
> > stack is allocated for each program, so if the same program
> > is running on different cpus concurrently, we won't have
> > any issue. Note that the kernel already have logic to prevent
> > the recursion for the same bpf program on the same cpu
> > (kprobe, fentry, etc.).
> >
> > The patch implemented a percpu private stack based approach
> > for x86 arch.
> >   - The stack size will be 0 and any stack access is from
> >     jit-time allocated percpu storage.
> >   - In the beginning of jit, r9 is used to save percpu
> >     private stack pointer.
> >   - Each rbp in the bpf asm insn is replaced by r9.
> >   - For each call, push r9 before the call and pop r9
> >     after the call to preserve r9 value.
> >
> > Compared to previous RFC patch [1], this patch added
> > some conditions to enable private stack, e.g., verifier
> > calculated stack size, prog type, etc. The new patch
> > also added a performance test to compare private stack
> > vs. no private stack.
> >
> > The following are some code example to illustrate the idea
> > for selftest cgroup_skb_sk_lookup:
> >
> >    the existing code                        the private-stack approach =
code
> >    endbr64                                  endbr64
> >    nop    DWORD PTR [rax+rax*1+0x0]         nop    DWORD PTR [rax+rax*1=
+0x0]
> >    xchg   ax,ax                             xchg   ax,ax
> >    push   rbp                               push   rbp
> >    mov    rbp,rsp                           mov    rbp,rsp
> >    endbr64                                  endbr64
> >    sub    rsp,0x68
> >    push   rbx                               push   rbx
> >    ...                                      ...
> >    ...                                      mov    r9d,0x8c1c860
> >    ...                                      add    r9,QWORD PTR gs:0x21=
a00
> >    ...                                      ...
> >    mov    rdx,rbp                           mov    rdx, r9
> >    add    rdx,0xffffffffffffffb4            rdx,0xffffffffffffffb4
> >    ...                                      ...
> >    mov    ecx,0x28                          mov    ecx,0x28
> >                                             push   r9
> >    call   0xffffffffe305e474                call   0xffffffffe305e524
> >                                             pop    r9
> >    mov    rdi,rax                           mov    rdi,rax
> >    ...                                      ...
> >    movzx  rdi,BYTE PTR [rbp-0x46]           movzx  rdi,BYTE PTR [r9-0x4=
6]
> >    ...                                      ...
> >
>
> Eduard nerd-sniped me today with this a bit... :)
>
> I have a few questions and suggestions.
>
> So it seems like each *subprogram* (not the entire BPF program) gets
> its own per-CPU private stack allocation. Is that intentional? That
> seems a bit unnecessary. It also prevents any sort of actual
> recursion. Not sure if it's possible to write recursive BPF subprogram
> today, verifier seems to reject obvious limited recursion cases, but
> still, eventually we might need/want to support that, and this will be
> just another hurdle to overcome (so it's best to avoid adding it in
> the first place).
>
> I'm sure Eduard is going to try something like below and it will
> probably break badly (I haven't tried, sorry):
>
> int entry(void *ctx);
>
> struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 1);
>         __uint(key_size, sizeof(__u32));
>         __array(values, int (void *));
> } prog_array_init SEC(".maps") =3D {
>         .values =3D {
>                 [0] =3D (void *)&entry,
>         },
> };
>
> static __noinline int subprog1(void)
> {
>     <some state on the stack>
>
>     /* here entry will replace subprog1, and so we'll have
>      * entry -> entry -> entry -> ..... <tail call limit> -> subprog1
>      */
>     bpf_tail_call(ctx, &prog_array_init, 0);
>
>     return 0;
> }
>
>
> SEC("raw_tp/sys_enter")
> int entry(void *ctx)
> {
>      <some state on the stack>
>
>      subprog1();
> }
>
> And we effectively have limited recursion where the entry's stack
> state is clobbered, no?
>
> So it seems like we need to support recursion.
>

How come everyone just completely ignored the main point of my entire
email and a real problem that has to be solved?...

Anyways, I did write a below program:

$ cat minimal.bpf.c
// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
/* Copyright (c) 2020 Facebook */
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

char LICENSE[] SEC("license") =3D "Dual BSD/GPL";

int my_pid =3D 0;

int handle_tp(void *ctx);

struct {
        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
        __uint(max_entries, 1);
        __uint(key_size, sizeof(__u32));
        __array(values, int (void *));
} prog_array_init SEC(".maps") =3D {
        .values =3D {
                [0] =3D (void *)&handle_tp,
        },
};

static __noinline int subprog(void *ctx)
{
        static int cnt;

        cnt++;

        bpf_printk("SUBPROG - BEFORE %d", cnt);

        bpf_tail_call(ctx, &prog_array_init, 0);

        bpf_printk("SUBPROG - AFTER %d", cnt);

    return 0;
}

SEC("tp/syscalls/sys_enter_write")
int handle_tp(void *ctx)
{
        static int cnt;
        int pid =3D bpf_get_current_pid_tgid() >> 32;

        if (pid !=3D my_pid)
                return 0;

        cnt++;

        bpf_printk("ENTRY - BEFORE %d", cnt);

        subprog(ctx);

        bpf_printk("ENTRY - AFTER %d", cnt);

        return 0;
}


And triggered one write syscall, getting the log above. You can see
that only subprogs are replaced (we only get "SUBPROG - AFTER 34" due
to the tail call limit). And we do indeed get lots of entry program
recurrence.

We *need to support recursion* is my main point. rbp is a distraction, sorr=
y.

$ sudo cat /sys/kernel/tracing/trace_pipe
         minimal-1219321 [025] ....1 8119446.322300: bpf_trace_printk:
ENTRY - BEFORE 1
         minimal-1219321 [025] ....1 8119446.322303: bpf_trace_printk:
SUBPROG - BEFORE 1
         minimal-1219321 [025] ....1 8119446.322304: bpf_trace_printk:
ENTRY - BEFORE 2
         minimal-1219321 [025] ....1 8119446.322304: bpf_trace_printk:
SUBPROG - BEFORE 2
         minimal-1219321 [025] ....1 8119446.322304: bpf_trace_printk:
ENTRY - BEFORE 3
         minimal-1219321 [025] ....1 8119446.322305: bpf_trace_printk:
SUBPROG - BEFORE 3
         minimal-1219321 [025] ....1 8119446.322305: bpf_trace_printk:
ENTRY - BEFORE 4
         minimal-1219321 [025] ....1 8119446.322305: bpf_trace_printk:
SUBPROG - BEFORE 4
         minimal-1219321 [025] ....1 8119446.322305: bpf_trace_printk:
ENTRY - BEFORE 5
         minimal-1219321 [025] ....1 8119446.322306: bpf_trace_printk:
SUBPROG - BEFORE 5
         minimal-1219321 [025] ....1 8119446.322306: bpf_trace_printk:
ENTRY - BEFORE 6
         minimal-1219321 [025] ....1 8119446.322306: bpf_trace_printk:
SUBPROG - BEFORE 6
         minimal-1219321 [025] ....1 8119446.322307: bpf_trace_printk:
ENTRY - BEFORE 7
         minimal-1219321 [025] ....1 8119446.322307: bpf_trace_printk:
SUBPROG - BEFORE 7
         minimal-1219321 [025] ....1 8119446.322307: bpf_trace_printk:
ENTRY - BEFORE 8
         minimal-1219321 [025] ....1 8119446.322307: bpf_trace_printk:
SUBPROG - BEFORE 8
         minimal-1219321 [025] ....1 8119446.322308: bpf_trace_printk:
ENTRY - BEFORE 9
         minimal-1219321 [025] ....1 8119446.322308: bpf_trace_printk:
SUBPROG - BEFORE 9
         minimal-1219321 [025] ....1 8119446.322308: bpf_trace_printk:
ENTRY - BEFORE 10
         minimal-1219321 [025] ....1 8119446.322308: bpf_trace_printk:
SUBPROG - BEFORE 10
         minimal-1219321 [025] ....1 8119446.322309: bpf_trace_printk:
ENTRY - BEFORE 11
         minimal-1219321 [025] ....1 8119446.322309: bpf_trace_printk:
SUBPROG - BEFORE 11
         minimal-1219321 [025] ....1 8119446.322309: bpf_trace_printk:
ENTRY - BEFORE 12
         minimal-1219321 [025] ....1 8119446.322309: bpf_trace_printk:
SUBPROG - BEFORE 12
         minimal-1219321 [025] ....1 8119446.322310: bpf_trace_printk:
ENTRY - BEFORE 13
         minimal-1219321 [025] ....1 8119446.322310: bpf_trace_printk:
SUBPROG - BEFORE 13
         minimal-1219321 [025] ....1 8119446.322310: bpf_trace_printk:
ENTRY - BEFORE 14
         minimal-1219321 [025] ....1 8119446.322312: bpf_trace_printk:
SUBPROG - BEFORE 14
         minimal-1219321 [025] ....1 8119446.322313: bpf_trace_printk:
ENTRY - BEFORE 15
         minimal-1219321 [025] ....1 8119446.322313: bpf_trace_printk:
SUBPROG - BEFORE 15
         minimal-1219321 [025] ....1 8119446.322313: bpf_trace_printk:
ENTRY - BEFORE 16
         minimal-1219321 [025] ....1 8119446.322313: bpf_trace_printk:
SUBPROG - BEFORE 16
         minimal-1219321 [025] ....1 8119446.322314: bpf_trace_printk:
ENTRY - BEFORE 17
         minimal-1219321 [025] ....1 8119446.322314: bpf_trace_printk:
SUBPROG - BEFORE 17
         minimal-1219321 [025] ....1 8119446.322314: bpf_trace_printk:
ENTRY - BEFORE 18
         minimal-1219321 [025] ....1 8119446.322314: bpf_trace_printk:
SUBPROG - BEFORE 18
         minimal-1219321 [025] ....1 8119446.322315: bpf_trace_printk:
ENTRY - BEFORE 19
         minimal-1219321 [025] ....1 8119446.322315: bpf_trace_printk:
SUBPROG - BEFORE 19
         minimal-1219321 [025] ....1 8119446.322315: bpf_trace_printk:
ENTRY - BEFORE 20
         minimal-1219321 [025] ....1 8119446.322315: bpf_trace_printk:
SUBPROG - BEFORE 20
         minimal-1219321 [025] ....1 8119446.322316: bpf_trace_printk:
ENTRY - BEFORE 21
         minimal-1219321 [025] ....1 8119446.322316: bpf_trace_printk:
SUBPROG - BEFORE 21
         minimal-1219321 [025] ....1 8119446.322316: bpf_trace_printk:
ENTRY - BEFORE 22
         minimal-1219321 [025] ....1 8119446.322316: bpf_trace_printk:
SUBPROG - BEFORE 22
         minimal-1219321 [025] ....1 8119446.322316: bpf_trace_printk:
ENTRY - BEFORE 23
         minimal-1219321 [025] ....1 8119446.322317: bpf_trace_printk:
SUBPROG - BEFORE 23
         minimal-1219321 [025] ....1 8119446.322318: bpf_trace_printk:
ENTRY - BEFORE 24
         minimal-1219321 [025] ....1 8119446.322318: bpf_trace_printk:
SUBPROG - BEFORE 24
         minimal-1219321 [025] ....1 8119446.322319: bpf_trace_printk:
ENTRY - BEFORE 25
         minimal-1219321 [025] ....1 8119446.322319: bpf_trace_printk:
SUBPROG - BEFORE 25
         minimal-1219321 [025] ....1 8119446.322319: bpf_trace_printk:
ENTRY - BEFORE 26
         minimal-1219321 [025] ....1 8119446.322320: bpf_trace_printk:
SUBPROG - BEFORE 26
         minimal-1219321 [025] ....1 8119446.322321: bpf_trace_printk:
ENTRY - BEFORE 27
         minimal-1219321 [025] ....1 8119446.322321: bpf_trace_printk:
SUBPROG - BEFORE 27
         minimal-1219321 [025] ....1 8119446.322321: bpf_trace_printk:
ENTRY - BEFORE 28
         minimal-1219321 [025] ....1 8119446.322322: bpf_trace_printk:
SUBPROG - BEFORE 28
         minimal-1219321 [025] ....1 8119446.322322: bpf_trace_printk:
ENTRY - BEFORE 29
         minimal-1219321 [025] ....1 8119446.322323: bpf_trace_printk:
SUBPROG - BEFORE 29
         minimal-1219321 [025] ....1 8119446.322323: bpf_trace_printk:
ENTRY - BEFORE 30
         minimal-1219321 [025] ....1 8119446.322324: bpf_trace_printk:
SUBPROG - BEFORE 30
         minimal-1219321 [025] ....1 8119446.322324: bpf_trace_printk:
ENTRY - BEFORE 31
         minimal-1219321 [025] ....1 8119446.322324: bpf_trace_printk:
SUBPROG - BEFORE 31
         minimal-1219321 [025] ....1 8119446.322324: bpf_trace_printk:
ENTRY - BEFORE 32
         minimal-1219321 [025] ....1 8119446.322325: bpf_trace_printk:
SUBPROG - BEFORE 32
         minimal-1219321 [025] ....1 8119446.322325: bpf_trace_printk:
ENTRY - BEFORE 33
         minimal-1219321 [025] ....1 8119446.322326: bpf_trace_printk:
SUBPROG - BEFORE 33
         minimal-1219321 [025] ....1 8119446.322327: bpf_trace_printk:
ENTRY - BEFORE 34
         minimal-1219321 [025] ....1 8119446.322327: bpf_trace_printk:
SUBPROG - BEFORE 34
         minimal-1219321 [025] ....1 8119446.322327: bpf_trace_printk:
SUBPROG - AFTER 34
         minimal-1219321 [025] ....1 8119446.322328: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322328: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322328: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322328: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322329: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322329: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322329: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322329: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322329: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322330: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322330: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322330: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322330: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322331: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322331: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322331: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322331: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322331: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322332: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322332: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322332: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322332: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322332: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322333: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322333: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322333: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322333: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322334: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322334: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322334: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322334: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322334: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322335: bpf_trace_printk:
ENTRY - AFTER 34
         minimal-1219321 [025] ....1 8119446.322335: bpf_trace_printk:
ENTRY - AFTER 34


>
> So, the question I have is. Why not do the following:
> a) only setup r9 *once* in entry program's prologue (before tail call
> jump target)
> b) before each call we can adjust r9 with current prog/subprog's
> maximum *own* stack, something like:
>
> push r9;
> r9 +=3D 128; // 128 is subprog's stack usage
> call <some-subprog>
> pop r9;
>
> The idea being that on tail call or in subprog call we assume r9 is
> already pointing to the right place. We can probably also figure out
> how to avoid push/pop r9 if we make sure that subprogram always
> restores r9 (taking tail calls into account and all that, of course)?
>
> Is this feasible?
>
> Another question I have is whether it would be possible to just plain
> set rbp to private stack and keep using rbp in such a way that stack
> traces are preserved? I.e., save return address on private stack to
> unwinders can correctly jump back to kernel's stack?
>
> How stupid is what I propose above?
>
>
> > So the number of insns is increased by 1 + num_of_calls * 2.
> > Here the number of calls are those calls in the final jited binary.
> > Comparing function call itself, the push/pop overhead should be
> > minimum in most common cases.
> >
> > Our original use case is for sched-ext nested scheduler. This will be d=
one
> > in the future.
> >
> >   [1] https://lore.kernel.org/bpf/707970c5-6bba-450a-be08-adf24d8b9276@=
linux.dev/T/
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 63 ++++++++++++++++++++++++++++++++++---
> >  include/linux/bpf.h         |  2 ++
> >  kernel/bpf/core.c           | 20 ++++++++++++
> >  kernel/bpf/syscall.c        |  1 +
> >  4 files changed, 82 insertions(+), 4 deletions(-)
> >
>
> [...]

