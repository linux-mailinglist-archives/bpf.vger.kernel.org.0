Return-Path: <bpf+bounces-35144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF241937ED3
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 05:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EBB2823D4
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3269449;
	Sat, 20 Jul 2024 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIzxBBUY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650DBE49
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721446153; cv=none; b=duEQo8YcHDT7Q6K24DZAM+ndxmwqpm7rkTcrYR5yRHdMGA+zBiThLEg9EuCuM6mECh1CVF1QAVqYD1oXEK4ryy+ucUgWZUgAMwBi5a2GX7Crpy1vM4oZfKRNHuZHqi+e5r2paCikt/JJpQqVVpLGG5+R1jmG7R8k5ZgeH9cjMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721446153; c=relaxed/simple;
	bh=0JC01lqGBb+NDJp/KxBpw3lcTnZUIeVnjAoVM55h1Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUb+VMRPUzMjHUY3N6HonkMGOdN4W+wbn9ESd71F/l6IALUcPrw+k8oHWcaSULbbYkXN16WW90gssTXozzisbWCowAqUkubvpd4H3iWHMOn0Txrwa0HcfaEI7vVK9iKhVjvzaPZsGdXrIBxuGK2LcbS9nEIGIf98VzEEiCiUwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIzxBBUY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso19402836d6.2
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 20:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721446150; x=1722050950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V0anzlalZR43L0txBZtPOzPe7Nh60FMb1l7NRkBgbo=;
        b=hIzxBBUYn6dFl/etbikE8jFASLZNBDENEjgtRH8D67TQCpWGPdy+vsFGkDD91ca33x
         mMiQuEpQd+fC8J9cv5+FHXxzigAVdXaxe/mzFJ1Zl0BkvVfSTgnTbX++Oh2WoWbfHwab
         cToNy7PMaZVE1E/ApoiemBGyAAN2bAIiY+sv0y4JwH+c/cAfg+0wVb7krXOobj5jw8nL
         aG13+CZ18EISjzxdp7kZBAevHqw1/C1YmJPcWclAysI9jrM5ksloho/Y5f8bYz7MTJ0b
         nxNqlt5mglHKyVDP3xoX3bKmASJfFoI+BrNyNmZQLvalLgPCgpaO1tZd+OgsTkAOfTCz
         4CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721446150; x=1722050950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V0anzlalZR43L0txBZtPOzPe7Nh60FMb1l7NRkBgbo=;
        b=shFKBbkC2T0XkU8EsXgyFN71GBYEu5W2B0G3EldgHC/nusMT8QiUySowAmt7OOIxg0
         V55GL/mjD6shso3+linSBi0sfz8WxYzQkbxmM1AWaTUalBsT7IOx7qor3y+oc9pFKDku
         YgYHC3EwobF7F9sf3qr/HZxoBmZbpCLR3xDTUH5c7dQCWd90izZchhM9nhqILMoM5goe
         lD4yB5fJZ9Rkz5xc12aKcUWKGV2K5B5mjcl8U0J9tYehFTsO9g5PScTpCNzo0BnWuqVw
         XJhEYha4iMily3eguVwc/3+NUjL3CxOcAn8tb+l9CEt2u0Hvv1Mka6+qeKvbxGtiPmyL
         00zw==
X-Gm-Message-State: AOJu0YyiCrfvk1OeWpx+dQh3dNeE3NBzXxM4V37LZ/HqFrAHGQsoTq70
	LBXwZNCGEUE+qMVcwkBoyB4uYLc2Wtr2YeiRvhy8u9WfVujDBsC0dRpdlp4aezsFxB9QbHecDqe
	+YrgJDxVHJEe9fFlWi3QI5rjA5XE=
X-Google-Smtp-Source: AGHT+IEVa7VeXTexcxV/3LrOUTZ/HJnZc4OT+z8gKgECrcwL7Pup/q20geS5QbA3EG2yA3bndKKvtkzt4m69GLlFGsI=
X-Received: by 2002:ad4:5f86:0:b0:6b0:86ab:feaf with SMTP id
 6a1803df08f44-6b95a6ff13cmr26729506d6.48.1721446150147; Fri, 19 Jul 2024
 20:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
In-Reply-To: <20240718205158.3651529-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 20:28:58 -0700
Message-ID: <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 1:52=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> The main motivation for private stack comes from nested
> scheduler in sched-ext from Tejun. The basic idea is that
>  - each cgroup will its own associated bpf program,
>  - bpf program with parent cgroup will call bpf programs
>    in immediate child cgroups.
>
> Let us say we have the following cgroup hierarchy:
>   root_cg (prog0):
>     cg1 (prog1):
>       cg11 (prog11):
>         cg111 (prog111)
>         cg112 (prog112)
>       cg12 (prog12):
>         cg121 (prog121)
>         cg122 (prog122)
>     cg2 (prog2):
>       cg21 (prog21)
>       cg22 (prog22)
>       cg23 (prog23)
>
> In the above example, prog0 will call a kfunc which will
> call prog1 and prog2 to get sched info for cg1 and cg2 and
> then the information is summarized and sent back to prog0.
> Similarly, prog11 and prog12 will be invoked in the kfunc
> and the result will be summarized and sent back to prog1, etc.
>
> Currently, for each thread, the x86 kernel allocate 8KB stack.
> The each bpf program (including its subprograms) has maximum
> 512B stack size to avoid potential stack overflow.
> And nested bpf programs increase the risk of stack overflow.
> To avoid potential stack overflow caused by bpf programs,
> this patch implemented a private stack so bpf program stack
> space is allocated dynamically when the program is jited.
> Such private stack is applied to tracing programs like
> kprobe/uprobe, perf_event, tracepoint, raw tracepoint and
> tracing.
>
> But more than one instance of the same bpf program may
> run in the system. To make things simple, percpu private
> stack is allocated for each program, so if the same program
> is running on different cpus concurrently, we won't have
> any issue. Note that the kernel already have logic to prevent
> the recursion for the same bpf program on the same cpu
> (kprobe, fentry, etc.).
>
> The patch implemented a percpu private stack based approach
> for x86 arch.
>   - The stack size will be 0 and any stack access is from
>     jit-time allocated percpu storage.
>   - In the beginning of jit, r9 is used to save percpu
>     private stack pointer.
>   - Each rbp in the bpf asm insn is replaced by r9.
>   - For each call, push r9 before the call and pop r9
>     after the call to preserve r9 value.
>
> Compared to previous RFC patch [1], this patch added
> some conditions to enable private stack, e.g., verifier
> calculated stack size, prog type, etc. The new patch
> also added a performance test to compare private stack
> vs. no private stack.
>
> The following are some code example to illustrate the idea
> for selftest cgroup_skb_sk_lookup:
>
>    the existing code                        the private-stack approach co=
de
>    endbr64                                  endbr64
>    nop    DWORD PTR [rax+rax*1+0x0]         nop    DWORD PTR [rax+rax*1+0=
x0]
>    xchg   ax,ax                             xchg   ax,ax
>    push   rbp                               push   rbp
>    mov    rbp,rsp                           mov    rbp,rsp
>    endbr64                                  endbr64
>    sub    rsp,0x68
>    push   rbx                               push   rbx
>    ...                                      ...
>    ...                                      mov    r9d,0x8c1c860
>    ...                                      add    r9,QWORD PTR gs:0x21a0=
0
>    ...                                      ...
>    mov    rdx,rbp                           mov    rdx, r9
>    add    rdx,0xffffffffffffffb4            rdx,0xffffffffffffffb4
>    ...                                      ...
>    mov    ecx,0x28                          mov    ecx,0x28
>                                             push   r9
>    call   0xffffffffe305e474                call   0xffffffffe305e524
>                                             pop    r9
>    mov    rdi,rax                           mov    rdi,rax
>    ...                                      ...
>    movzx  rdi,BYTE PTR [rbp-0x46]           movzx  rdi,BYTE PTR [r9-0x46]
>    ...                                      ...
>

Eduard nerd-sniped me today with this a bit... :)

I have a few questions and suggestions.

So it seems like each *subprogram* (not the entire BPF program) gets
its own per-CPU private stack allocation. Is that intentional? That
seems a bit unnecessary. It also prevents any sort of actual
recursion. Not sure if it's possible to write recursive BPF subprogram
today, verifier seems to reject obvious limited recursion cases, but
still, eventually we might need/want to support that, and this will be
just another hurdle to overcome (so it's best to avoid adding it in
the first place).

I'm sure Eduard is going to try something like below and it will
probably break badly (I haven't tried, sorry):

int entry(void *ctx);

struct {
        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
        __uint(max_entries, 1);
        __uint(key_size, sizeof(__u32));
        __array(values, int (void *));
} prog_array_init SEC(".maps") =3D {
        .values =3D {
                [0] =3D (void *)&entry,
        },
};

static __noinline int subprog1(void)
{
    <some state on the stack>

    /* here entry will replace subprog1, and so we'll have
     * entry -> entry -> entry -> ..... <tail call limit> -> subprog1
     */
    bpf_tail_call(ctx, &prog_array_init, 0);

    return 0;
}


SEC("raw_tp/sys_enter")
int entry(void *ctx)
{
     <some state on the stack>

     subprog1();
}

And we effectively have limited recursion where the entry's stack
state is clobbered, no?

So it seems like we need to support recursion.


So, the question I have is. Why not do the following:
a) only setup r9 *once* in entry program's prologue (before tail call
jump target)
b) before each call we can adjust r9 with current prog/subprog's
maximum *own* stack, something like:

push r9;
r9 +=3D 128; // 128 is subprog's stack usage
call <some-subprog>
pop r9;

The idea being that on tail call or in subprog call we assume r9 is
already pointing to the right place. We can probably also figure out
how to avoid push/pop r9 if we make sure that subprogram always
restores r9 (taking tail calls into account and all that, of course)?

Is this feasible?

Another question I have is whether it would be possible to just plain
set rbp to private stack and keep using rbp in such a way that stack
traces are preserved? I.e., save return address on private stack to
unwinders can correctly jump back to kernel's stack?

How stupid is what I propose above?


> So the number of insns is increased by 1 + num_of_calls * 2.
> Here the number of calls are those calls in the final jited binary.
> Comparing function call itself, the push/pop overhead should be
> minimum in most common cases.
>
> Our original use case is for sched-ext nested scheduler. This will be don=
e
> in the future.
>
>   [1] https://lore.kernel.org/bpf/707970c5-6bba-450a-be08-adf24d8b9276@li=
nux.dev/T/
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 63 ++++++++++++++++++++++++++++++++++---
>  include/linux/bpf.h         |  2 ++
>  kernel/bpf/core.c           | 20 ++++++++++++
>  kernel/bpf/syscall.c        |  1 +
>  4 files changed, 82 insertions(+), 4 deletions(-)
>

[...]

