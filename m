Return-Path: <bpf+bounces-32151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8090802E
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 02:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DA0283B20
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A851854;
	Fri, 14 Jun 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwjMlSMB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85611372
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718325025; cv=none; b=mmHUwuAllSipvG36shNIAjgtm3WzHYBlGtiL36cLkPjCi35WXafCErABsxQQzeb1DxyLQpXCo3ksSw55+YtSvJPlnxIrZavucV3ucfqhuGT6E8iyek+ZIZ6eUC83uYhVCPGImxAaYH65vXOi2CBF+1WznUAInI7WU0iF8rZGStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718325025; c=relaxed/simple;
	bh=NboYpeFrS9/+N22bN3So3cGJhWvmUQv00N6/gLpJjXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJAAKe5Qkn464Pr1yDPo0WRtam/RZ9EMBOi6FLNHYlVWz3StKyNFJTpjTFXgbYnYH7MKYRKZ94z+5zj2W0MogvYJT8aO90pm+uy3yiUh0RPtMlR0Nfi1eeggPGJZpNs1EEgBxz81rPIjL2Rnt8XdJ60JdA8AI3U/kLEVhdEDdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwjMlSMB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f123bf735so1152756f8f.1
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718325022; x=1718929822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNFAzLdZdP6mTBtuOfiQ9XSMBhRos9nDLDzd0vu6t1A=;
        b=PwjMlSMBQpOuw8gsbSXh4SqkIM145xo3i72a8nnpscVR0xIH+CaKiIsKles11EYdKD
         QynnhRL2nv6BXTrT0uq9Tuj9XM9EcFjO7S6jSuAVSFvecR81Lds0TjXAz7DlIHjYRbW2
         yN6qVujsFcXQXofHzI96hLhDi2yTS650wqFW1DotcPxh/JnNeL4XlNsuEM1E6BIq4QOU
         AiQx7q0L69x7axalTtscy9GEHF0Yy4p2NAa45A/5+BdCRk5ojSE4xAqTyHJ86SkQyM4I
         Ng9tlHonmu59c9wDheRr8uE4Csn7u8ox5EtXcOi8YO5Xh4Mafi0cwr24V3ow+rAbrSDF
         FyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718325022; x=1718929822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNFAzLdZdP6mTBtuOfiQ9XSMBhRos9nDLDzd0vu6t1A=;
        b=Yo1eW4XqwJbe55yAeQ8yluXs2RdNTVxyQTYh7HGQmKZXvirFbDJODiDBaQwI9gKrrF
         RgQVN40ZJ3qT3kBJ6aJiH3G0+SGT5HfwoLPDCVU4bHYLXNT55ro36sAd3gSs6haDQyyG
         aIrhkg+i2E69ZKpY1NUh8Cob24SNYfmlerq00Kn7o/qWUEgq1uv8XAyDZfLdics8zchR
         40H+UIgzDbB7JIuuFKIUvDXRunqgIlrQi2qPgvr+0x6WbWQZDFxei75na6v9vrOXprY3
         alou/2Pg3yQ36pSCMXnl3V0mVapeSxBxRC4WquDbuMhXF6exI42iyJxZ59XFqwg3dbqe
         hs8g==
X-Gm-Message-State: AOJu0YxhyrXxsEn3UFKnSUpmbQ6EuJDc6LxRZU/R/RfhqRqwV1Diy6NM
	YQ+wYg7o7jkRrt/kpL7AGNIf2Wnpj1J2P6wYT2YidGHkOnh8byV5Aza+UDEXQlBjYHzWhIQv72b
	//tu8212ARe/ScyctxG1s7FtVjxs=
X-Google-Smtp-Source: AGHT+IFKO/rAXOwXF76SzlPYQAmrsO4hSDaPTRptQjeamvD9sV0JB2uPtHzWI016EhRZ2xBc7tygK2UlpaY1OJYp/oA=
X-Received: by 2002:a5d:4bc8:0:b0:360:6f56:ae10 with SMTP id
 ffacd0b85a97d-3607a7b9e90mr845195f8f.23.1718325021478; Thu, 13 Jun 2024
 17:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610051839.1296086-1-yonghong.song@linux.dev>
In-Reply-To: <20240610051839.1296086-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Jun 2024 17:30:09 -0700
Message-ID: <CAADnVQ+FwPAbeiiD78xnkRLZAiSDC4ObkKWV+x9bpSK9aM_GsA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Support shadow stack for bpf progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 10:18=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>

I think "shadow stack" already has at least two different meanings
in the kernel.
Let's avoid adding 3rd.
How about "divided stack" ?

> +static void emit_percpu_shadow_frame_ptr(u8 **pprog, void *shadow_frame_=
ptr)
> +{
> +       u8 *prog =3D *pprog;
> +
> +       /* movabs r9, shadow_frame_ptr */
> +       emit_mov_imm32(&prog, false, X86_REG_R9, (u32) (long) shadow_fram=
e_ptr);
> +
> +       /* add <r9>, gs:[<off>] */
> +       EMIT2(0x65, 0x4c);
> +       EMIT3(0x03, 0x0c, 0x25);
> +       EMIT((u32)(unsigned long)&this_cpu_off, 4);

I think this can be one insn:
lea r9, gs:[(u32)shadow_frame_ptr]

> +       if (stack_depth && enable_shadow_stack) {

I think enabling it for progs with small stack usage
is unnecessary.
The definition of "small" is complicated.
I feel stack_depth <=3D 64 can stay as-is and
all networking progs don't have to use it either,
since they're called from known places.
While tracing progs can be anywhere, so I'd enable
divided stack for
stack_depth > 64 && prog_type =3D=3D kprobe, tp, raw_tp, tracing, perf_even=
t.

> +               if (bpf_prog->percpu_shadow_stack_ptr) {
> +                       percpu_shadow_stack_ptr =3D bpf_prog->percpu_shad=
ow_stack_ptr;
> +               } else {
> +                       percpu_shadow_stack_ptr =3D __alloc_percpu_gfp(st=
ack_depth, 8, GFP_KERNEL);
> +                       if (!percpu_shadow_stack_ptr)
> +                               return -ENOMEM;
> +                       bpf_prog->percpu_shadow_stack_ptr =3D percpu_shad=
ow_stack_ptr;
> +               }
> +               shadow_frame_ptr =3D percpu_shadow_stack_ptr + round_up(s=
tack_depth, 8);
> +               stack_depth =3D 0;
> +       } else {
> +               enable_shadow_stack =3D 0;
> +       }
> +
>         arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->are=
na);
>         user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->aren=
a);
>
> @@ -1342,7 +1377,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
>         /* tail call's presence in current prog implies it is reachable *=
/
>         tail_call_reachable |=3D tail_call_seen;
>
> -       emit_prologue(&prog, bpf_prog->aux->stack_depth,
> +       emit_prologue(&prog, stack_depth,
>                       bpf_prog_was_classic(bpf_prog), tail_call_reachable=
,
>                       bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_=
cb);
>         /* Exception callback will clobber callee regs for its own use, a=
nd
> @@ -1364,6 +1399,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
>                 emit_mov_imm64(&prog, X86_REG_R12,
>                                arena_vm_start >> 32, (u32) arena_vm_start=
);
>
> +       if (enable_shadow_stack)
> +               emit_percpu_shadow_frame_ptr(&prog, shadow_frame_ptr);
> +
>         ilen =3D prog - temp;
>         if (rw_image)
>                 memcpy(rw_image + proglen, temp, ilen);
> @@ -1383,6 +1421,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
>                 u8 *func;
>                 int nops;
>
> +               if (enable_shadow_stack) {
> +                       if (src_reg =3D=3D BPF_REG_FP)
> +                               src_reg =3D X86_REG_R9;
> +
> +                       if (dst_reg =3D=3D BPF_REG_FP)
> +                               dst_reg =3D X86_REG_R9;

the verifier will reject a prog that attempts to write into R10.
So the above shouldn't be necessary.

> +               }
> +
>                 switch (insn->code) {
>                         /* ALU */
>                 case BPF_ALU | BPF_ADD | BPF_X:
> @@ -2014,6 +2060,7 @@ st:                       if (is_imm8(insn->off))
>                                 emit_mov_reg(&prog, is64, real_src_reg, B=
PF_REG_0);
>                                 /* Restore R0 after clobbering RAX */
>                                 emit_mov_reg(&prog, true, BPF_REG_0, BPF_=
REG_AX);
> +
>                                 break;
>                         }
>
> @@ -2038,14 +2085,20 @@ st:                     if (is_imm8(insn->off))
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
> -                               RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stac=
k_depth);
> +                               RESTORE_TAIL_CALL_CNT(stack_depth);
>                                 ip +=3D 7;
>                         }
>                         if (!imm32)
>                                 return -EINVAL;
> +                       if (enable_shadow_stack) {
> +                               EMIT2(0x41, 0x51);
> +                               ip +=3D 2;
> +                       }
>                         ip +=3D x86_call_depth_emit_accounting(&prog, fun=
c, ip);
>                         if (emit_call(&prog, func, ip))
>                                 return -EINVAL;
> +                       if (enable_shadow_stack)
> +                               EMIT2(0x41, 0x59);

push/pop around calls are load/store plus math on %rsp.
I think it's cheaper to reload r9 after the call with
a single insn.
The reload of r9 is effectively gs+const.
There is no memory access. So it should be faster.

Technically we can replace all uses of R10=3D=3Drbp with
'gs:' based instructions.
Like:
r1 =3D r10
can be jitted into
lea rdi, gs + (u32)shadow_frame_ptr

and r0 =3D *(u32 *)(r10 - 64)
can be jitted into:
mov rax, dword ptr gs:[(u32)shadow_frame_ptr - 64]

but that is probably a bunch of jit changes.
So I'd start with a simple reload of r9 after each call.

We need to micro-benchmark it to make sure there is no perf overhead.

