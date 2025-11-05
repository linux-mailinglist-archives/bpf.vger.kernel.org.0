Return-Path: <bpf+bounces-73561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A740C33BE7
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 03:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 656094E759A
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 02:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D29C23536B;
	Wed,  5 Nov 2025 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRzYS1mG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FB13D891
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308741; cv=none; b=bZP0L5iWv767T4bOxfvEO+BM+eszXc8BXimfwy/mW7wo6Dr3x1U77mYUaqgk7dm4ox6c9yF2WtIFIzpIzTYo2lb/wHGlxk+ma+tX+jZv7B+RfV5/T/0PuazKnSG3PWU81jGzNVBSQdM3zON5XYE3kyU6fmhSAZd3PgpV8Jm7iZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308741; c=relaxed/simple;
	bh=7eA/3vG0PcmIQmRgKGUgsXiE3phsUjsTxr+CxM/I7rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb4zkIg6ZmYh7iZqAuB8k6Tanr4Vacv5yCaDu3CejM7wpwCckzZB/0mhQ5is4yNWRcF8BbopexoQPfczUR7GVx4bGeG6rrHeia+78BGZknJf/M8Advp2QwTuUEydU84pBHdFPGioxY2JtmKRWQiSICLfFrhpOO7eMcCojJq3O/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRzYS1mG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4774f41628bso1798055e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 18:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762308737; x=1762913537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ0WsV+Vo0V//iX7QovgrCvvgDIeYg0C3VimFpuBzQI=;
        b=GRzYS1mGpllGVLuF0ksBGTC7MM4BnXiRWW8vrv9quZEocbhFkZEc1EKoZKd35RLppQ
         g5BMr0bUcyHsqUXXTJs0NP+JzjXEXxjoqQcWwaLR4UrM5XCKOOPZiYaIuelTRqo7FA+B
         p2gwe7SWMaspOPuiyWSvn6ddc+aM+PkixPUw2kUkfIlCmYZEFjKfBYcF/kAFc+G4lpVR
         8wR4EwyRKD3MUeyxVxE++oT2nMqe3W6id6sd+s2UjP4P69k90vySbiS39GZbo+BnDHhy
         WvV+GPLQUrUWe+oZaB8B9bx1aBxoZvVzQiZVgx3Bt3j2s2/NWkyR6mG43ioyCIqqaIGZ
         e6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762308737; x=1762913537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ0WsV+Vo0V//iX7QovgrCvvgDIeYg0C3VimFpuBzQI=;
        b=O1YvqmREqPzBYwfpCEKJJjScuRiJjQcvKZIBpkgWCOGpIL213bvCr6gkSIoYw7qupu
         Ndm1bRSAGrdcNUxuALgrR50+B5lmlnh9q5126bovjm8xOmOh7ouMV2L0dHxctVdqOs2f
         jJvMVE/4GYtVzw2xEV1g4CFzEJaNpjy94bGubgEUPI2kRPGe66bfxz7eypD2Z4W948KK
         F7ZwgyhZ30UCQfDB1WptTJCqJ64pZM6bSHS1pSiyYzofeKAhmqmasjhAKlc/fFo5V5XL
         C4hZhuWb5M8zc2JL74Ot5GdUEkP78c/ngHLxwFZ7oMc3YVr0Axd4X12TjFoo+RtHNF37
         SIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoNmNe/aEurUyx4e4/PtXmSbPb4bRuVLfv5BIMEwUTjmzx4yejqMGq4ZnXsbeVR40YOcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuhgYmAagrkKpSDbUrhu/GGsMYYRwK1cnn5GjMaRmKKeZHWP2
	vDCNKgnBubhrDaPHNKWmGNBF5kgPFhQ91JRfxMUWMhg3cafjxcI2dN9p/I2dJ2pBfVJIGoF0KCg
	jtFWF8UbEFbupRnVtaUjBlFZHup6gsnE=
X-Gm-Gg: ASbGncvWtoi7PWI1yWIQzdr0n3p1QpFE6ru6uXSEnKgiUOn3wqiy1kmEXzFqg8+x3CX
	zE7vlF9rEy6GKdfBVLemBvAKo0Fu84C9XwC12fABsYSgsrNZ+8rqGs6KZRtPxZt4T7NlEB61xM6
	UFMz+XaDkGnIase8YWgQnzL9pyqz7gVzwRrjwNuM25l/xUR6Ph0aNS29XEqa69eOPf4TyD8ygGE
	56PVfV0OGQ9AMOmQ0H2V5acngB15diBYIGe2mip8DXHHMOzq0Qi075NpsEaoY7nju0Hma3gfi/w
	VKpaiERqkBl0Kmk+f32vf2MdKddb
X-Google-Smtp-Source: AGHT+IH+lDvd0mi/7GpgVyMxn6NFSpvfa6nkj0Qf0qlYYjwxwyfqHHTf9RzNftjcTVJhShJ9FeruogMUHiAjnKsZ3uQ=
X-Received: by 2002:a05:6000:3108:b0:429:cc35:7032 with SMTP id
 ffacd0b85a97d-429dbd10259mr4778141f8f.23.1762308737365; Tue, 04 Nov 2025
 18:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <CAADnVQJTOFjXe5=01KfOnBD86YU_Vy1YGezLQum3LnhFHAD+gg@mail.gmail.com> <5029485.GXAFRqVoOG@7950hx>
In-Reply-To: <5029485.GXAFRqVoOG@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 18:12:06 -0800
X-Gm-Features: AWmQ_bkWcRJ6UsCGlN1jtdmJ4s0ck4JlTIXOSJKFyKB9G7nSjmIqv_xP8d9h758
Message-ID: <CAADnVQKQXcUxjJ2uYNu1nvhFYt=KhN8QYAiGXrt_YwUsjMFOuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:30=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2025/11/5 02:56, Alexei Starovoitov wrote:
> > On Tue, Nov 4, 2025 at 2:49=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > In origin call case, we skip the "rip" directly before we return, whi=
ch
> > > break the RSB, as we have twice "call", but only once "ret".
> >
> > RSB meaning return stack buffer?
> >
> > and by "breaks RSB" you mean it makes the cpu less efficient?
>
> Yeah, I mean it makes the cpu less efficient. The RSB is used
> for the branch predicting, and it will push the "rip" to its hardware
> stack on "call", and pop it from the stack on "ret". In the origin
> call case, there are twice "call" but once "ret", will break its
> balance.

Yes. I'm aware, but your "mov [rbp + 8], rax" screws it up as well,
since RSB has to be updated/invalidated by this store.
The behavior depends on the microarchitecture, of course.
I think:
add rsp, 8
ret
will only screw up the return prediction, but won't invalidate RSB.

> Similar things happen in "return_to_handler" in ftrace_64.S,
> which has once "call", but twice "ret". And it pretend a "call"
> to make it balance.

This makes more sense to me. Let's try that approach instead
of messing with the return address on stack?

> I were wandering why the overhead of fexit is much higher
> than fentry. I added the percup-ref-get-and-put stuff to the
> fentry, and the performance of it still can be 130M/s. However,
> the fexit only has 76M/s. And the only difference is the origin
> call.
>
> The RSB balancing mitigate it, but there are still gap. I
> suspect it's still the branch predicting things.

If you have access to intel vtune profiler, check what is
actually happening. It can show micro arch details.
I don't think there is an open source alternative.

> > Or you mean call depth accounting that is done in sw ?
> >
> > > Do the RSB balance by pseudo a "ret". Instead of skipping the "rip", =
we
> > > modify it to the address of a "ret" insn that we generate.
> > >
> > > The performance of "fexit" increases from 76M/s to 84M/s. Before this
> > > optimize, the bench resulting of fexit is:
> > >
> > > fexit          :   76.494 =C2=B1 0.216M/s
> > > fexit          :   76.319 =C2=B1 0.097M/s
> > > fexit          :   70.680 =C2=B1 0.060M/s
> > > fexit          :   75.509 =C2=B1 0.039M/s
> > > fexit          :   76.392 =C2=B1 0.049M/s
> > >
> > > After this optimize:
> > >
> > > fexit          :   86.023 =C2=B1 0.518M/s
> > > fexit          :   83.388 =C2=B1 0.021M/s
> > > fexit          :   85.146 =C2=B1 0.058M/s
> > > fexit          :   85.646 =C2=B1 0.136M/s
> > > fexit          :   84.040 =C2=B1 0.045M/s
> >
> > This is with or without calldepth accounting?
>
> The CONFIG_MITIGATION_CALL_DEPTH_TRACKING is enabled, but
> I did the testing with "mitigations=3Doff" in the cmdline, so I guess
> "without"?

Pls benchmark both. It sounds like call_depth_tracking
miscounting stuff ?

> >
> > > Things become a little more complex, not sure if the benefits worth i=
t :/
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 32 +++++++++++++++++++++++++++++---
> > >  1 file changed, 29 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index d4c93d9e73e4..a9c2142a84d0 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -3185,6 +3185,7 @@ static int __arch_prepare_bpf_trampoline(struct=
 bpf_tramp_image *im, void *rw_im
> > >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY=
_RETURN];
> > >         void *orig_call =3D func_addr;
> > >         u8 **branches =3D NULL;
> > > +       u8 *rsb_pos;
> > >         u8 *prog;
> > >         bool save_ret;
> > >
> > > @@ -3431,17 +3432,42 @@ static int __arch_prepare_bpf_trampoline(stru=
ct bpf_tramp_image *im, void *rw_im
> > >                 LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
> > >         }
> > >
> > > +       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> > > +               u64 ret_addr =3D (u64)(image + (prog - (u8 *)rw_image=
));
> > > +
> > > +               rsb_pos =3D prog;
> > > +               /*
> > > +                * reserve the room to save the return address to rax=
:
> > > +                *   movabs rax, imm64
> > > +                *
> > > +                * this is used to do the RSB balance. For the SKIP_F=
RAME
> > > +                * case, we do the "call" twice, but only have one "r=
et",
> > > +                * which can break the RSB.
> > > +                *
> > > +                * Therefore, instead of skipping the "rip", we make =
it as
> > > +                * a pseudo return: modify the "rip" in the stack to =
the
> > > +                * second "ret" address that we build bellow.
> > > +                */
> > > +               emit_mov_imm64(&prog, BPF_REG_0, ret_addr >> 32, (u32=
)ret_addr);
> > > +               /* mov [rbp + 8], rax */
> > > +               EMIT4(0x48, 0x89, 0x45, 0x08);
> > > +       }
> > > +
> > >         /* restore return value of orig_call or fentry prog back into=
 RAX */
> > >         if (save_ret)
> > >                 emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
> > >
> > >         emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
> > >         EMIT1(0xC9); /* leave */
> > > +       emit_return(&prog, image + (prog - (u8 *)rw_image));
> > >         if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> > > -               /* skip our return address and return to parent */
> > > -               EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
> > > +               u64 ret_addr =3D (u64)(image + (prog - (u8 *)rw_image=
));
> > > +
> > > +               /* fix the return address to second return address */
> > > +               emit_mov_imm64(&rsb_pos, BPF_REG_0, ret_addr >> 32, (=
u32)ret_addr);
> >
> > So the first "movabs rax, imm64" is not needed ?
> > Why compute ret_addr there and everything ?
> > I mean it could have been prog +=3D sizeof(movabs), right?
>
> I did it before, but the thing is that the "sizeof(movabs)" in not
> fixed according to the definition of emit_mov_imm64():
>
> static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
>                            const u32 imm32_hi, const u32 imm32_lo)
> {
>         u64 imm64 =3D ((u64)imm32_hi << 32) | (u32)imm32_lo;
>         u8 *prog =3D *pprog;
>
>         if (is_uimm32(imm64)) {
>                 /*
>                  * For emitting plain u32, where sign bit must not be
>                  * propagated LLVM tends to load imm64 over mov32
>                  * directly, so save couple of bytes by just doing
>                  * 'mov %eax, imm32' instead.
>                  */
>                 emit_mov_imm32(&prog, false, dst_reg, imm32_lo);
>         } else if (is_simm32(imm64)) {
>                 emit_mov_imm32(&prog, true, dst_reg, imm32_lo);
>         } else {
>                 /* movabsq rax, imm64 */
>                 EMIT2(add_1mod(0x48, dst_reg), add_1reg(0xB8, dst_reg));
>                 EMIT(imm32_lo, 4);
>                 EMIT(imm32_hi, 4);

This part could be factored out as a separate helper.
Then sizeof(movabsq) will be constant.
Note, in the verifier we do:
#if defined(MODULES_VADDR)
                        u64 addr =3D MODULES_VADDR;
#else
                        u64 addr =3D VMALLOC_START;
#endif
                        /* jit (e.g. x86_64) may emit fewer instructions
                         * if it learns a u32 imm is the same as a u64 imm.
                         * Set close enough to possible prog address.
                         */
                        insn[0].imm =3D (u32)addr;
                        insn[1].imm =3D addr >> 32;

do mitigate this issue.
So you could have done:
emit_mov_imm64(&prog, BPF_REG_0, VMALLOC_START >> 32, 0);

since 'ret_addr' math is incorrect at that point anyway.
But prog +=3D sizeof is imo cleaner.
The whole thing might not be necessary with extra call approach.
I suspect it should be faster than this approach.

