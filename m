Return-Path: <bpf+bounces-9849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7E579DD19
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 02:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642391C20E74
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6CC37C;
	Wed, 13 Sep 2023 00:22:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5D7F
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 00:22:17 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351718D
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:22:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso592443e87.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694564535; x=1695169335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BsCQKUA6qU3btx/4cTRjBWc2Q0VmICXk1+9zMq4+YA=;
        b=WGwF45IW7m+c3zwUMnNx7eOIfhraWaGzdKDycwqnm6zUz0ocX7w26X6WUqm61zOgYn
         qKSCrlVY2xTcGTlofIFluJRrYAI10lv+8FEOx4O6ZxnEoU4BP810grywkESkF8YeXk9S
         2Q9s0dTjnjuJikMszyOER+FK9q9ndjvADntKFUgMLRIzyM23LGX/1dbMV3f6uV1qllTF
         1TJDk9nHYV648F0W/if7Qtn1j74U3lgDnMRivZD8uW/67o1bHMHwqICNiY1ydy60SE2A
         YQYcw8NaSfbEC4nAHETUqxDSHFvJoehZrXMJ4PLLUhoY9T/2OfTkHajqbEOLi8i5OvV6
         Xmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694564535; x=1695169335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BsCQKUA6qU3btx/4cTRjBWc2Q0VmICXk1+9zMq4+YA=;
        b=vIblpjgH4ieQLTz4CAAq+4BoQM4WDPj+WgaLAmdjoCNXpryNrr7D9N94IsDeTkUcmq
         +bhQ+6J7zkFASdp1WdXHE3Mllpb1qXDGzsW3sSvYIaxIkiuat9q2323X7IwM6Aky4wm9
         /X6B9VQQmMGdzsUSDHAhSPdJk1I30HLdMU/dLN/GuEXz8mphq/U0lXvRWI4mEZgtLcq7
         nvTa1X4GqKaL+t0V4f5mwEoaiAGGaeQxlvG9N5AXB6qnmufZi6h3jzg5uoXQVNQ1QmIk
         ZWO4XY9av7VT76s21ndPk+TTH0Z8AVt8va1mEesFzMoSSHai5ppe0cwyIRh/DZFlFgGy
         RmSQ==
X-Gm-Message-State: AOJu0YzQuosL6CjkwtHTtJmdZsRhbxt3PvO65c0KJrae3orh6ANZaYwx
	IxaBPGKXUHWxV3ea6XHwCM6YnqzwrkiyQmNc2Zs=
X-Google-Smtp-Source: AGHT+IF3qaUSeHTxFpyAJGMg/bqdBnvz5tpv4VMHNq2+6Bc/vJuAA4ti7SkJcXn7didSn1+UOhkWnhWbqTVZ6SIcOG4=
X-Received: by 2002:a05:6512:b93:b0:501:c232:ee8d with SMTP id
 b19-20020a0565120b9300b00501c232ee8dmr930456lfv.19.1694564534773; Tue, 12 Sep
 2023 17:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830011128.1415752-1-iii@linux.ibm.com> <20230830011128.1415752-2-iii@linux.ibm.com>
 <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
 <mb61p5y4u3ptd.fsf@amazon.com> <CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
 <mb61p4jk630a9.fsf@amazon.com> <CAADnVQJCc6t82H+iFXvhs=mfg1DMxZ-1PS3DP5h7mtbuCW79qQ@mail.gmail.com>
 <mb61pv8cm0wf9.fsf@amazon.com> <CAADnVQ+ccoQrTcOZW_BZXMv2A+uYEYdHqx0tSVgXK31vGS=+gA@mail.gmail.com>
 <CANk7y0hK9sQJ-kRx3nQpVJSxpP=NzzFaLitOYq8=Pb6Dvk9fpg@mail.gmail.com> <CAADnVQ+EpYBTGMJ0MBdK8=qKrYseicxpA1AE+BmHu1CFoOPUvQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+EpYBTGMJ0MBdK8=qKrYseicxpA1AE+BmHu1CFoOPUvQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 13 Sep 2023 02:22:03 +0200
Message-ID: <CANk7y0g73bZpikgHtV1Z=c+1msE8vzZx9ZWHjJd_6FBFOEZNXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 2:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 12, 2023 at 3:49=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > Hi Alexei,
> >
> > [...]
> >
> > > I guess we never clearly defined what 'needs_zext' is supposed to be,
> > > so it wouldn't be fair to call 32-bit JITs buggy.
> > > But we better address this issue now.
> > > This 32-bit zeroing after LDX hurts mips64, s390, ppc64, riscv64.
> > > I believe all 4 JITs emit proper zero extension into 64-bit register
> > > by using single cpu instruction,
> > > but they also define bpf_jit_needs_zext() as true,
> > > so extra BPF_ZEXT_REG() is added by the verifier
> > > and it is a pure run-time overhead.
> >
> > I just realised that these zext instructions will not be a runtime
> > overhead because the JITs ignore them.
> > Like
> > s390 does:
> > case BPF_LDX | BPF_MEM | BPF_B: /* dst =3D *(u8 *)(ul) (src + off) */
> > case BPF_LDX | BPF_PROBE_MEM | BPF_B:
> >         /* llgc %dst,0(off,%src) */
> >         EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg, REG_0, off)=
;
> >         jit->seen |=3D SEEN_MEM;
> >         if (insn_is_zext(&insn[1]))
> >                 insn_count =3D 2; /* this will skip the next zext instr=
uction */
> >         break;
> >
> > powerpc does after LDX:
> > if (size !=3D BPF_DW && insn_is_zext(&insn[i + 1]))
> >         addrs[++i] =3D ctx->idx * 4;
>
>
> I see. Indeed the 64-bit JITs ignore this special zext insn after LDX.
>
> > > It's better to remove
> > > if (t !=3D SRC_OP)
> > >     return BPF_SIZE(code) =3D=3D BPF_DW;
> > > from is_reg64() to avoid adding BPF_ZEXT_REG() insn
> > > and fix 32-bit JITs at the same time.
> > > RISCV32, PowerPC32, x86-32 JITs fixed in the first 3 patches
> > > to always zero upper 32-bit after LDX and
> > > then 4th patch to remove these two lines.
> >
> > I have sent the patches for above, although I think this optimization
> > is useful because
> > zero extension after LDX is only required when the loaded value is
> > later being used as
> > a 64-bit value. If it is not the case then the verifier will not emit
> > the zext and 32-bit JITs will emit
> > 1 less instruction because they expect the verifier to do the zext for
> > them where required.
>
> You're correct.
> Ok. Let's keep zext for LDX as-is.

Yes,
let's do
        if (class =3D=3D BPF_LDX) {
                if (t !=3D SRC_OP)
-                       return BPF_SIZE(code) =3D=3D BPF_DW;
+                       return (BPF_SIZE(code) =3D=3D BPF_DW ||
BPF_MODE(code) =3D=3D BPF_MEMSX);

Thanks,
Puranjay

