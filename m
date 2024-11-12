Return-Path: <bpf+bounces-44676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4B9C6481
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 23:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1792B32824
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA9121A4D0;
	Tue, 12 Nov 2024 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDHK9jgJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01F2185AD
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450477; cv=none; b=B/HIqDFxb/rTnrtkENZQJBG7IETLJwSVihO60Uh2t1oD0Rn68NnGLH4wFXaoh95elv0VpcqdtjISRhpVpbjd+6Ear3i9dc3XFePyvfkR8APr6PQinIIGYZ6yrySLwpdRmm7ZBQYerN8GbaZEd0E20OqTriEuji+NvYq2VYrGOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450477; c=relaxed/simple;
	bh=D4lLHd0Lmv0IOPnLEFFLiye+Hj2afYCiK7pOHQIDgcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YD/pzboOa1CBTdqvyC92HK5JhmdQ3tWfCog6IX75aBrdfYFl/IRUxSvajCD/Lv3q0cWzra3CUisyWSpxD7T1I6U2FGX8EG2UoZqZYavVGD1wA4HBc0S6lrm9tBqAvKGdWKVXVvDzOJYPMkpea/9UVL7ffqJxtPYJWzL/UWKX0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDHK9jgJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314b316495so52137445e9.2
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731450474; x=1732055274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ7VtrPZeSJI0OiAxRUnJpgIWBYblRdvzFzdHuFGAt4=;
        b=DDHK9jgJci8JZGifflpgJ7meZw7FJLJhOp0r2dBzYurAYVsOLLUQSOfeqRJ1BoHWIV
         wPik0+3NIuusLyt/T3j6IxzoFr+uIexZDBf9+ZUCDTLvphvWLdjwkjd6ASfDRv/N7g37
         qR9g1y6L7Z9sSJt05E84Z423fDiloNjsfn1YFy62yqmnZkedYv4dSK5FVnuJV+LE7g7/
         L4a2vM3WS0tnrpk3vwiGgXw8KR5CuKu53VFkGOXr9NnxaWmNiDEATO1VZoKsLUOyR7j7
         /yNOUQex46MsFGFLnYGW1W/lCitWt5NXezzTF950DOOMzOohZk9Bve2A5hi5upKBcFsw
         aniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731450474; x=1732055274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ7VtrPZeSJI0OiAxRUnJpgIWBYblRdvzFzdHuFGAt4=;
        b=p0xc99OaT2+7+Q+fhT4Njb0Aj51AfHqLtZa65gnjKMA7p7IjQNufzGP32u+WBr7htV
         SXEQuTW/u31ByEvhZPSrMZrPJBrEYMPMKd8ptuR1+cNWoO3Fjme+l/ZB6ew94GJm1S/B
         JGfwc+d2ApqGHVbDg1qF8k4b7kWkTMF1mKj3DMCxlF2KtfX5/NDMayzx7R+cf+qo8xzM
         kgjpTExtd9ViaBjr5KhTRufNTqZexqzC22fSPqD1zCUg0z2jrELAmqe4yEMEmBpbs247
         1nphFaGPo6/4ZUVl14pt7lIiYm4oAsC78npBGfWehPTlC2p/9/KRIUzraBN7tcH5bugF
         M1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYGwQPtRF+u3Ywfb+lzV8KSTCo0MlbCvd7/dY5C3kbQn4ubwT+p1Kn7WGkFW+lzP0EhqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5eqQdzS45YfeJxtR0N4WKTwFJsSOyuTBrXUTfnyZNy54Xkc2d
	mOcGe++LO6R+S9z9JQZY+cawEuskEsYs79T8XuuivtE2ohgp9008wvjQOL8WdhaGG1f6oInC8NV
	Zc7uqHTvnsXybFItIYd3OVrNXhHo=
X-Google-Smtp-Source: AGHT+IF57p6OTcAzfIOm5v3c7peMYi6UzCzRxH2AvIZwrINlL6eOeNDBEbat0LP8WZfhwN9ILw4SD6RuAsuMD5g8pUE=
X-Received: by 2002:a05:600c:1f06:b0:431:6060:8b16 with SMTP id
 5b1f17b1804b1-432d4ad91acmr7013065e9.30.1731450473494; Tue, 12 Nov 2024
 14:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109004158.2259301-1-vadfed@meta.com> <cd904b908d0d84c4f8454683495977f64d081004.camel@gmail.com>
 <03bcf4ca-5e6f-4523-9661-46102b4f02b0@linux.dev> <c2936ebf75e76c77b04dc88aed9dacf8e784214a.camel@gmail.com>
 <4d2ee96cc12bf4bd84aa3e9716ce84793800f2f6.camel@gmail.com>
In-Reply-To: <4d2ee96cc12bf4bd84aa3e9716ce84793800f2f6.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Nov 2024 14:27:42 -0800
Message-ID: <CAADnVQ+bYuda8bWtY9vtxh9WGUOBz+5hvS6V9X00i5gtHhLt1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko <vadfed@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Mykola Lysenko <mykolal@fb.com>, 
	Jakub Kicinski <kuba@kernel.org>, X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 2:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-11-12 at 13:53 -0800, Eduard Zingerman wrote:
> > On Tue, 2024-11-12 at 21:39 +0000, Vadim Fedorenko wrote:
> >
> > [...]
> >
> > > > > +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC=
_CALL &&
> > > > > +                           imm32 =3D=3D BPF_CALL_IMM(bpf_get_cpu=
_cycles)) {
> > > > > +                               /* Save RDX because RDTSC will us=
e EDX:EAX to return u64 */
> > > > > +                               emit_mov_reg(&prog, true, AUX_REG=
, BPF_REG_3);
> > > > > +                               if (boot_cpu_has(X86_FEATURE_LFEN=
CE_RDTSC))
> > > > > +                                       EMIT_LFENCE();
> > > > > +                               EMIT2(0x0F, 0x31);
> > > > > +
> > > > > +                               /* shl RDX, 32 */
> > > > > +                               maybe_emit_1mod(&prog, BPF_REG_3,=
 true);
> > > > > +                               EMIT3(0xC1, add_1reg(0xE0, BPF_RE=
G_3), 32);
> > > > > +                               /* or RAX, RDX */
> > > > > +                               maybe_emit_mod(&prog, BPF_REG_0, =
BPF_REG_3, true);
> > > > > +                               EMIT2(0x09, add_2reg(0xC0, BPF_RE=
G_0, BPF_REG_3));
> > > > > +                               /* restore RDX from R11 */
> > > > > +                               emit_mov_reg(&prog, true, BPF_REG=
_3, AUX_REG);
> > > >
> > > > Note: The default implementation of this kfunc uses __arch_get_hw_c=
ounter(),
> > > >        which is implemented as `(u64)rdtsc_ordered() & S64_MAX`.
> > > >        Here we don't do `& S64_MAX`.
> > > >        The masking in __arch_get_hw_counter() was added by this com=
mit:
> > > >        77750f78b0b3 ("x86/vdso: Fix gettimeofday masking").
> > >
> > > I think we already discussed it with Alexey in v1, we don't really ne=
ed
> > > any masking here for BPF case. We can use values provided by CPU
> > > directly. It will never happen that within one BPF program we will ha=
ve
> > > inlined and non-inlined implementation of this helper, hence the valu=
es
> > > to compare will be of the same source.
> > >
> > > >        Also, the default implementation does not issue `lfence`.
> > > >        Not sure if this makes any real-world difference.
> > >
> > > Well, it actually does. rdtsc_ordered is translated into `lfence; rdt=
sc`
> > > or `rdtscp` (which is rdtsc + lfence + u32 cookie) depending on the c=
pu
> > > features.
> >
> > I see the following disassembly:
> >
> > 0000000000008980 <bpf_get_cpu_cycles>:
> > ; {
> >     8980: f3 0f 1e fa                   endbr64
> >     8984: e8 00 00 00 00                callq   0x8989 <bpf_get_cpu_cyc=
les+0x9>
> >                 0000000000008985:  R_X86_64_PLT32       __fentry__-0x4
> > ;       asm volatile(ALTERNATIVE_2("rdtsc",
> >     8989: 0f 31                         rdtsc
> >     898b: 90                            nop
> >     898c: 90                            nop
> >     898d: 90                            nop
> > ;       return EAX_EDX_VAL(val, low, high);
> >     898e: 48 c1 e2 20                   shlq    $0x20, %rdx
> >     8992: 48 09 d0                      orq     %rdx, %rax
> >     8995: 48 b9 ff ff ff ff ff ff ff 7f movabsq $0x7fffffffffffffff, %r=
cx # imm =3D 0x7FFFFFFFFFFFFFFF
> > ;               return (u64)rdtsc_ordered() & S64_MAX;
> >     899f: 48 21 c8                      andq    %rcx, %rax
> > ;       return __arch_get_hw_counter(1, NULL);
> >     89a2: 2e e9 00 00 00 00             jmp     0x89a8 <bpf_get_cpu_cyc=
les+0x28>
> >
> > Is it patched when kernel is loaded to replace nops with lfence?
> > By real-world difference I meant difference between default
> > implementation and inlined assembly.
>
> Talked with Vadim off-list, he explained that 'rttsc nop nop nop' is
> indeed patched at kernel load. Regarding S64_MAX patching we just hope
> this should never be an issue for BPF use-case.
> So, no more questions from my side.

since s64 question came up twice it should be a comment.

nop nop as well.

pw-bot: cr

