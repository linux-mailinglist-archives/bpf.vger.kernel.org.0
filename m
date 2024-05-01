Return-Path: <bpf+bounces-28376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C598B8E75
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F63F1F233E2
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E29E542;
	Wed,  1 May 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2wqHq6S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06303FBE8;
	Wed,  1 May 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582029; cv=none; b=K1z/887els1TMEOiwRlgUFAjXIyIYbRK7IEbk0S14S9Yjhdyrkgf69ZAvOmqJwyoT1jaYLIKjsMf5ATq0HgR6ADsvPt8dySqSSUQvFUsTzMTfWvYpgeyU/gzKatM8OtrDxpEpJJLS6NjppEkpRHz91kztf3loc0gIjphApfb2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582029; c=relaxed/simple;
	bh=e536afwY25Ws7+stPkl0xnIZHsIsxrvz5kZMx58cUVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQnz2xefHr3DzBM2SshqNCEl47zhVgzaoHY/njhEhr6K62zaDnkUtpob4pl4PLtbU3/q+H36yleI7KIujR31Unmuf3HLag9Hy9s7O0/gH0VxIq3x1fk0bnsRi4eZhifQBGkeVAsEIDr/zSie/3CcH+J4y9vnA1A7mekVEHf6eCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2wqHq6S; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so5528344a12.3;
        Wed, 01 May 2024 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582027; x=1715186827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHP+c6lTfQ0DdbvCxrrnGweU4MtbNmvE+GdweOg/na4=;
        b=D2wqHq6S4pzFwT20TNIkmS1VyMuu7J+unRxWqJbN2PHS7QrPHsZ9wG/mGpZCIG4w7V
         DpMbiV+AXhTWJ66S95qPoAzyBtzedtXyyIT7Sk8lEryik2HVaAG4fBkmNNVReuwX5zLz
         3Y/IgD7i7Fc+GixstN0JGajIAfXobkRwlNrijgv80B5srBH1kjPA/rBJS3L2lCNBHPMX
         FhpdKiezvZIqx0KT9PMO3lbtd3aGWQUnqWh6CRFBw4T0zkqoyyAXDEhgJySLDW5vfEE8
         +ftGlHfYVolkuO1Wuzolaw5DE4FYBxfSE1DJHAxNHnXyPkVydrB6JvmNAoB4GrNSvmfu
         FsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582027; x=1715186827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHP+c6lTfQ0DdbvCxrrnGweU4MtbNmvE+GdweOg/na4=;
        b=PoHB1oqtU3XxJgK8pQST56HQ5BMzxrge2xZ1IGHg3AStbjvlU/Pu3YqID+5t6ii6eB
         7xvL+psgovYdQ0CSt3KSpA1W/QVeNrVyG/0y4y+gLBfq+U3VYwGmUj58TxXxThH10rGH
         aPwJI82crqFvIBwbC9v/f99J4q1tdLMjy64dVMUVgva5rEYf+NehtuWmLeOcBrGLguE7
         DTC/kVcafhTRWxuBH4Cd/dXcpSV7qv284pQ6X6T8XWauwWkFzto0MrUGKrdWrFzbqtWD
         RvWv7w7xuErWKPxItI5bWmVg/6cjZDZWAGEnFof+/SFm/0QWVrfb3wx6RR0Q7LPP2pPY
         dXHg==
X-Forwarded-Encrypted: i=1; AJvYcCUGcSBhqskbzKFgpIlGkglFrvGv6sPAjuAz22LeS2e6o7kfFasAUluuf28WZ5NkXFmkMZI8dyYJWJydbilp4BMMjxCpzm5fR15/aXsArRsZcCsKfIHgHYgLQ5Y7tFk+kvER
X-Gm-Message-State: AOJu0Ywp5xqsy6K12Oz0iN/SENt9CfjkGjKlqljj5u4Qyz3QlE/9IMWR
	5YHhLO6E7cM7CYQ1Wlv+d8zW5tHWgOxU/yc8a9Id0lSHnSNoNL+9Ro6TKtjaXsNTZJGxhaLYeF3
	T4NsIdx7yFkvg8tl/lw7koh0q+/IcYXUu
X-Google-Smtp-Source: AGHT+IGwZvvD0p+2Z6mLaoa8sRSkRBgrSZmXIA66DK3sIxVc4c4NQxjw1OhigG1oJW1AEdjmEDtneZbE29RaZfBKhME=
X-Received: by 2002:a17:90a:394c:b0:2ac:6355:c6dc with SMTP id
 n12-20020a17090a394c00b002ac6355c6dcmr2747597pjf.19.1714582027082; Wed, 01
 May 2024 09:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430175834.33152-1-puranjay@kernel.org> <20240430175834.33152-3-puranjay@kernel.org>
In-Reply-To: <20240430175834.33152-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 09:46:55 -0700
Message-ID: <CAEf4Bzb4FYVNjuoghCcDxLgQCOT9Mb=nbjgNktqDarPHkOsuog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] riscv, bpf: inline bpf_get_smp_processor_id()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huawei.com>, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:59=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> Inline the calls to bpf_get_smp_processor_id() in the riscv bpf jit.
>
> RISCV saves the pointer to the CPU's task_struct in the TP (thread
> pointer) register. This makes it trivial to get the CPU's processor id.
> As thread_info is the first member of task_struct, we can read the
> processor id from TP + offsetof(struct thread_info, cpu).
>
>           RISCV64 JIT output for `call bpf_get_smp_processor_id`
>           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>                 Before                           After
>                --------                         -------
>
>          auipc   t1,0x848c                  ld    a5,32(tp)
>          jalr    604(t1)
>          mv      a5,a0
>

Nice, great find! Would you be able to do similar inlining for x86-64
as well? Disassembling bpf_get_smp_processor_id for x86-64 shows this:

Dump of assembler code for function bpf_get_smp_processor_id:
   0xffffffff810f91a0 <+0>:     0f 1f 44 00 00  nopl   0x0(%rax,%rax,1)
   0xffffffff810f91a5 <+5>:     65 8b 05 60 79 f3 7e    mov
%gs:0x7ef37960(%rip),%eax        # 0x30b0c <pcpu_hot+12>
   0xffffffff810f91ac <+12>:    48 98   cltq
   0xffffffff810f91ae <+14>:    c3      ret
End of assembler dump.

We should be able to do the same in x86-64 BPF JIT. (it's actually how
I started initially, I had a dedicated instruction reading per-cpu
memory, but ended up with more general "calculate per-cpu address").

Anyways, great work, a small nit below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Benchmark using [1] on Qemu.
>
> ./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc
>
> +---------------+------------------+------------------+--------------+
> |      Name     |     Before       |       After      |   % change   |
> |---------------+------------------+------------------+--------------|
> | glob-arr-inc  | 1.077 =C2=B1 0.006M/s | 1.336 =C2=B1 0.010M/s |   + 24.=
04%   |
> | arr-inc       | 1.078 =C2=B1 0.002M/s | 1.332 =C2=B1 0.015M/s |   + 23.=
56%   |
> | hash-inc      | 0.494 =C2=B1 0.004M/s | 0.653 =C2=B1 0.001M/s |   + 32.=
18%   |
> +---------------+------------------+------------------+--------------+
>
> NOTE: This benchmark includes changes from this patch and the previous
>       patch that implemented the per-cpu insn.
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 26 ++++++++++++++++++++++++++
>  include/linux/filter.h          |  1 +
>  kernel/bpf/core.c               | 11 +++++++++++
>  kernel/bpf/verifier.c           |  2 ++
>  4 files changed, 40 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 99d7006f1420..5789b7afae47 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1493,6 +1493,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>                 bool fixed_addr;
>                 u64 addr;
>
> +               /* Inline calls to bpf_get_smp_processor_id()
> +                *
> +                * RV_REG_TP holds the address of the current CPU's task_=
struct and thread_info is
> +                * at offset 0 in task_struct.
> +                * Load cpu from thread_info:
> +                *     Set R0 to ((struct thread_info *)(RV_REG_TP))->cpu
> +                *
> +                * This replicates the implementation of raw_smp_processo=
r_id() on RISCV
> +                */
> +               if (insn->src_reg =3D=3D 0 && insn->imm =3D=3D BPF_FUNC_g=
et_smp_processor_id) {
> +                       /* Load current CPU number in R0 */
> +                       emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(s=
truct thread_info, cpu),
> +                               RV_REG_TP, ctx);
> +                       break;
> +               }
> +
>                 mark_call(ctx);
>                 ret =3D bpf_jit_get_func_addr(ctx->prog, insn, extra_pass=
,
>                                             &addr, &fixed_addr);
> @@ -2062,3 +2078,13 @@ bool bpf_jit_supports_percpu_insn(void)
>  {
>         return true;
>  }
> +
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +       switch (imm) {
> +       case BPF_FUNC_get_smp_processor_id:
> +               return true;
> +       }
> +
> +       return false;

nit: why not

default:
    return false;

to keep everything within the switch?

> +}
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 7a27f19bf44d..3e19bb62ed1a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -993,6 +993,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u=
64 r5);
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
>  void bpf_jit_compile(struct bpf_prog *prog);
>  bool bpf_jit_needs_zext(void);
> +bool bpf_jit_inlines_helper_call(s32 imm);
>  bool bpf_jit_supports_subprog_tailcalls(void);
>  bool bpf_jit_supports_percpu_insn(void);
>  bool bpf_jit_supports_kfunc_call(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 99b8b1c9a248..aa59af9f9bd9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2941,6 +2941,17 @@ bool __weak bpf_jit_needs_zext(void)
>         return false;
>  }
>
> +/* Return true if the JIT inlines the call to the helper corresponding t=
o
> + * the imm.
> + *
> + * The verifier will not patch the insn->imm for the call to the helper =
if
> + * this returns true.
> + */
> +bool __weak bpf_jit_inlines_helper_call(s32 imm)
> +{
> +       return false;
> +}
> +
>  /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls.=
 */
>  bool __weak bpf_jit_supports_subprog_tailcalls(void)
>  {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5d42db05315e..e78f766d7f91 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20013,6 +20013,8 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                         goto next_insn;
>                 }
>
> +               if (bpf_jit_inlines_helper_call(insn->imm))
> +                       goto next_insn;

It's nice to be able to allow BPF JIT to do a higher-performance
implementation. Let's add a short comment above to mention that this
is bypassing normal inlining because BPF JIT will do it better (I know
you have this description for the function definition, but a short
remark here would be helpful).

And please add an empty line after this check to logically separate it
from the rest of helper inlining logic in verifier, thanks!

pw-bot: cr

>                 if (insn->imm =3D=3D BPF_FUNC_get_route_realm)
>                         prog->dst_needed =3D 1;
>                 if (insn->imm =3D=3D BPF_FUNC_get_prandom_u32)
> --
> 2.40.1
>

