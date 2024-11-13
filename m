Return-Path: <bpf+bounces-44689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A909C65BD
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778A91F24F5F
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 00:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41515A8;
	Wed, 13 Nov 2024 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY7qfarV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFEA50
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456572; cv=none; b=dhQRC6snzo5aEmRaKNe5pHr5wpj+vKrZm7zQZ/h7OBz+bdVNau3PSBDkfemkvjJT5tpjBTJGnVH6omJk9sg0D7FvV3gfO1ggO7jWwPcWVB6ZstIE7KC1Lalr+bNM6klEKV+8/oaNvu8KFiPEjTpHPHVODLPgWHPoxOCcUAwj3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456572; c=relaxed/simple;
	bh=Ablw7Gse4gqEM5zBCvV2YbLif5BYYYjqGWRJZGUzhjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFQPg3yn5dEjUUD/YkDBEivUSdXeMWYxtyJauzO0oVymq2mNbFeSLaN4I2oMBi3L3LFbeRfGdFEcujo1aQPmaM9H1iX9LP1UJ9zZcjP/ULyKJlnhoY4Cz2TY5P4uAg6WzxD3Umkl+BT9vX/4fZQN1jwShuOL1JnrTx0gXErABxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY7qfarV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso79174385e9.0
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731456569; x=1732061369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLpwu0pdNU0a/GRHTo5Cln80mVu/B4QEpILyMP5eIgc=;
        b=RY7qfarVPvfIF3UYCvnWyntYauUIIzLY80iq0h5BQLKqG2mLNu41LyQ/pZEQ4t2NKY
         mRiiKMBj0akV7/mNwnhN6upxS1eHPisFab3H2kQjVigKzuVxFwRUJmVLKczNrm/ARSN8
         iQT/Fwk30pstLU0E0IAgGofITqcojgVA3xv8hMCOEfCZN4wWHJy/A1w1yIjAHR4LIhXt
         Z7hY9kOyr7y9NccBAX+OtWkmh8qcwpmNnAHyKWPW9NGR864j90uQwsrQPWMJYmv1aP5i
         fXjRE/pFJUTqq3AFCekDe9r8MhGvfZkueKuxvxXe/Nw5UNoKo6YjqL9rC0yIw//YcIRy
         FDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731456569; x=1732061369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLpwu0pdNU0a/GRHTo5Cln80mVu/B4QEpILyMP5eIgc=;
        b=odKPZtHOR5YHdW5EqHZl2Qs4p+BPiMk8GLMbDQT/Ds14m2PTh4ygxFilZH6hjKb41J
         Gp7haw1vZQIDYe7aNCa1wemAoNQrd5wYzh3WgHk0zpL6LCON1+yaTRGLq5gHCUdku37i
         7BosbeTPDXsng4NVw9JFPzQFULSrAk+x2mssKnJv/ca0JBxTpZcb8r+qRHH+BpP6sccV
         eOqj7KaKFKZPQmgLX5xmUqBftia4sfzIoIp+lHISV2zftUs51DWFV4uAIjJRrEVt7DfI
         uVM6dbvkJMhH4oXxtGrKSE+iYFBlM+kILoCjkYsKla3ws9v9L1KWo2fUnd7QOABEN56x
         scRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDwnIbHZt3wVpCD03RqQ07lNc5IfERoTt79eMQhSKob0/5Y7CPxGKeTcAfqdS9UTVtzNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKqiaPr6pljowBEJuw9GX+7VwOfiEfGpGytwUdiVyhMOekX4j
	yDedgxPM2Blfz/AxI/ihlFqw58PfqghjquuN4uYgUNPUxtQwDDgn7tej9woz9ZcqZuA8gWsCV96
	DytS76HgrI1z5VlMm9L/z0Gx9eWc=
X-Google-Smtp-Source: AGHT+IGZVAwsi1iklIWmHpA6JjatdfZe2+svLgB80R7bGawyHWdYVj3ld0OVJmokdKlD+luymzmf40UTBu+k1D/Zetc=
X-Received: by 2002:a05:6000:20c3:b0:381:f603:ff62 with SMTP id
 ffacd0b85a97d-381f603ff95mr12810225f8f.20.1731456568840; Tue, 12 Nov 2024
 16:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109004158.2259301-1-vadfed@meta.com> <cd904b908d0d84c4f8454683495977f64d081004.camel@gmail.com>
 <03bcf4ca-5e6f-4523-9661-46102b4f02b0@linux.dev> <c2936ebf75e76c77b04dc88aed9dacf8e784214a.camel@gmail.com>
 <4d2ee96cc12bf4bd84aa3e9716ce84793800f2f6.camel@gmail.com>
 <CAADnVQ+bYuda8bWtY9vtxh9WGUOBz+5hvS6V9X00i5gtHhLt1Q@mail.gmail.com> <ee3362bd-316e-47e5-83d9-8e00651c122a@linux.dev>
In-Reply-To: <ee3362bd-316e-47e5-83d9-8e00651c122a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Nov 2024 16:09:17 -0800
Message-ID: <CAADnVQJ7dnmupD-WyV8oAVEgWBr0cHs9D5MXkDqoBXh+fyE9OQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Vadim Fedorenko <vadfed@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Mykola Lysenko <mykolal@fb.com>, 
	Jakub Kicinski <kuba@kernel.org>, X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:08=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 12/11/2024 22:27, Alexei Starovoitov wrote:
> > On Tue, Nov 12, 2024 at 2:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> >>
> >> On Tue, 2024-11-12 at 13:53 -0800, Eduard Zingerman wrote:
> >>> On Tue, 2024-11-12 at 21:39 +0000, Vadim Fedorenko wrote:
> >>>
> >>> [...]
> >>>
> >>>>>> +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_=
CALL &&
> >>>>>> +                           imm32 =3D=3D BPF_CALL_IMM(bpf_get_cpu_=
cycles)) {
> >>>>>> +                               /* Save RDX because RDTSC will use=
 EDX:EAX to return u64 */
> >>>>>> +                               emit_mov_reg(&prog, true, AUX_REG,=
 BPF_REG_3);
> >>>>>> +                               if (boot_cpu_has(X86_FEATURE_LFENC=
E_RDTSC))
> >>>>>> +                                       EMIT_LFENCE();
> >>>>>> +                               EMIT2(0x0F, 0x31);
> >>>>>> +
> >>>>>> +                               /* shl RDX, 32 */
> >>>>>> +                               maybe_emit_1mod(&prog, BPF_REG_3, =
true);
> >>>>>> +                               EMIT3(0xC1, add_1reg(0xE0, BPF_REG=
_3), 32);
> >>>>>> +                               /* or RAX, RDX */
> >>>>>> +                               maybe_emit_mod(&prog, BPF_REG_0, B=
PF_REG_3, true);
> >>>>>> +                               EMIT2(0x09, add_2reg(0xC0, BPF_REG=
_0, BPF_REG_3));
> >>>>>> +                               /* restore RDX from R11 */
> >>>>>> +                               emit_mov_reg(&prog, true, BPF_REG_=
3, AUX_REG);
> >>>>>
> >>>>> Note: The default implementation of this kfunc uses __arch_get_hw_c=
ounter(),
> >>>>>         which is implemented as `(u64)rdtsc_ordered() & S64_MAX`.
> >>>>>         Here we don't do `& S64_MAX`.
> >>>>>         The masking in __arch_get_hw_counter() was added by this co=
mmit:
> >>>>>         77750f78b0b3 ("x86/vdso: Fix gettimeofday masking").
> >>>>
> >>>> I think we already discussed it with Alexey in v1, we don't really n=
eed
> >>>> any masking here for BPF case. We can use values provided by CPU
> >>>> directly. It will never happen that within one BPF program we will h=
ave
> >>>> inlined and non-inlined implementation of this helper, hence the val=
ues
> >>>> to compare will be of the same source.
> >>>>
> >>>>>         Also, the default implementation does not issue `lfence`.
> >>>>>         Not sure if this makes any real-world difference.
> >>>>
> >>>> Well, it actually does. rdtsc_ordered is translated into `lfence; rd=
tsc`
> >>>> or `rdtscp` (which is rdtsc + lfence + u32 cookie) depending on the =
cpu
> >>>> features.
> >>>
> >>> I see the following disassembly:
> >>>
> >>> 0000000000008980 <bpf_get_cpu_cycles>:
> >>> ; {
> >>>      8980: f3 0f 1e fa                   endbr64
> >>>      8984: e8 00 00 00 00                callq   0x8989 <bpf_get_cpu_=
cycles+0x9>
> >>>                  0000000000008985:  R_X86_64_PLT32       __fentry__-0=
x4
> >>> ;       asm volatile(ALTERNATIVE_2("rdtsc",
> >>>      8989: 0f 31                         rdtsc
> >>>      898b: 90                            nop
> >>>      898c: 90                            nop
> >>>      898d: 90                            nop
> >>> ;       return EAX_EDX_VAL(val, low, high);
> >>>      898e: 48 c1 e2 20                   shlq    $0x20, %rdx
> >>>      8992: 48 09 d0                      orq     %rdx, %rax
> >>>      8995: 48 b9 ff ff ff ff ff ff ff 7f movabsq $0x7fffffffffffffff,=
 %rcx # imm =3D 0x7FFFFFFFFFFFFFFF
> >>> ;               return (u64)rdtsc_ordered() & S64_MAX;
> >>>      899f: 48 21 c8                      andq    %rcx, %rax
> >>> ;       return __arch_get_hw_counter(1, NULL);
> >>>      89a2: 2e e9 00 00 00 00             jmp     0x89a8 <bpf_get_cpu_=
cycles+0x28>
> >>>
> >>> Is it patched when kernel is loaded to replace nops with lfence?
> >>> By real-world difference I meant difference between default
> >>> implementation and inlined assembly.
> >>
> >> Talked with Vadim off-list, he explained that 'rttsc nop nop nop' is
> >> indeed patched at kernel load. Regarding S64_MAX patching we just hope
> >> this should never be an issue for BPF use-case.
> >> So, no more questions from my side.
> >
> > since s64 question came up twice it should be a comment.
>
> sure, will do it.
>
> >
> > nop nop as well.
>
> do you mean why there are nop;nop instructions in the kernel's assembly?

Explanation on why JITed matches __arch_get_hw_counter.

