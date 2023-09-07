Return-Path: <bpf+bounces-9460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A6797EC8
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 00:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C61C20B5C
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F314293;
	Thu,  7 Sep 2023 22:46:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9145C29A8
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 22:46:09 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0937A1BDB
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 15:45:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b962c226ceso24999531fa.3
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694126756; x=1694731556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gjDqeGMCVcU3UEZ+DVs12oWtiqlsqIbS1jpmV/i6ow=;
        b=dF5V33Qi0Ch0x/J1MhedG4IF7JUHDylPqlQ7ok+1fnH8+txD8TNyv+3mQDRpDjqP06
         MmnE6QLyyuornB+cLs9kpVTpsAjajONfbl951PrlmYlF81HaDU5GjcbVdOFu/RR6OWYQ
         cLKI9ZzLY35ry91UXqYh8d7htiwsdb6zNjcA7LziqNdK0KTgnzxKtw/2P+Kd1RnCBv+N
         wI/OPHVCnb4JfaaC3H7A1j8b75QtvxOZhZBG4qn4PR0Voa5yII6qsVwpD7M3AovPGzw2
         15Xxq6BHRLL7anWZyBWwb8XvvcBlHzvjiJt0G6Dot2dC1VhgVMDYrb0ZOWTq1nxnGfu9
         Kh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694126756; x=1694731556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gjDqeGMCVcU3UEZ+DVs12oWtiqlsqIbS1jpmV/i6ow=;
        b=qFZkcLWGtVJRAYdhAgcZPuR0WVCqFF5W9sPvAaiUee3hFgu1lcvqZ1IUuUto8aT4jR
         xmEYm8v/XEBwEy1zhEVUv75rFRXbY+fbYuK73xjNJPNvGdIlGCzSjR0rjhht7Grc2oEp
         cqOJTicqiDAs2EOv3irj8bYLXIpko1xoa/fOeg6KfevaNhOcnMieIQpTnvvVahYVB/zr
         ml21LI+gpQg6KEdUr9VE6Ij0pb54a2W7Q9rVb+WxZedKldvgtu4DL4sMpgRsBeuqW2W3
         d8POg7jDGV9VKu2q6ztYVPLSD6EmD+kh6jRLariQnLZjX5VuGdHT6WuYhmZ0qJapUHkX
         ABuA==
X-Gm-Message-State: AOJu0YyYJz95x0udkHrf1bq/aNf83fCKm9zmu4AaOSJMoxBvANeCFmUh
	EiHCxofRa6sGh94fhGl6laUf7GHBtDMYSK7VEgU=
X-Google-Smtp-Source: AGHT+IEvoQRhFLIgmNoxT0gg/27bCT7fQcGVIsQ9HuHFL0plUmNIBnsMTBXAw8Fydx0kRCUA5/mf/nu5oNra+Y8l/E4=
X-Received: by 2002:a2e:920d:0:b0:2bc:fd7b:8ded with SMTP id
 k13-20020a2e920d000000b002bcfd7b8dedmr456490ljg.20.1694126755952; Thu, 07 Sep
 2023 15:45:55 -0700 (PDT)
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
 <mb61pv8cm0wf9.fsf@amazon.com>
In-Reply-To: <mb61pv8cm0wf9.fsf@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Sep 2023 15:45:44 -0700
Message-ID: <CAADnVQ+ccoQrTcOZW_BZXMv2A+uYEYdHqx0tSVgXK31vGS=+gA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 9:39=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> On Thu, Sep 07 2023, Alexei Starovoitov wrote:
>
> > On Thu, Sep 7, 2023 at 12:33=E2=80=AFAM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
> >>
> >> On Wed, Sep 06 2023, Alexei Starovoitov wrote:
> >>
> >> > On Fri, Sep 1, 2023 at 7:57=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> >> >>
> >> >> On Fri, Sep 01 2023, Puranjay Mohan wrote:
> >> >>
> >> >> > The problem here is that reg->subreg_def should be set as DEF_NOT=
_SUBREG for
> >> >> > registers that are used as destination registers of BPF_LDX |
> >> >> > BPF_MEMSX. I am seeing
> >> >> > the same problem on ARM32 and was going to send a patch today.
> >> >> >
> >> >> > The problem is that is_reg64() returns false for destination regi=
sters
> >> >> > of BPF_LDX | BPF_MEMSX.
> >> >> > But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of th=
e
> >> >> > sign extension so
> >> >> > is_reg64() should return true.
> >> >> >
> >> >> > I have written a patch that I will be sending as a reply to this.
> >> >> > Please let me know if that makes sense.
> >> >> >
> >> >>
> >> >> The check_reg_arg() function will mark reg->subreg_def =3D DEF_NOT_=
SUBREG for destination
> >> >> registers if is_reg64() returns true for these registers. My patch =
below make is_reg64()
> >> >> return true for destination registers of BPF_LDX with mod =3D BPF_M=
EMSX. I feel this is the
> >> >> correct way to fix this problem.
> >> >>
> >> >> Here is my patch:
> >> >>
> >> >> --- 8< ---
> >> >> From cf1bf5282183cf721926ab14d968d3d4097b89b8 Mon Sep 17 00:00:00 2=
001
> >> >> From: Puranjay Mohan <puranjay12@gmail.com>
> >> >> Date: Fri, 1 Sep 2023 11:18:59 +0000
> >> >> Subject: [PATCH bpf] bpf: verifier: mark destination of sign-extend=
ed load as
> >> >>  64 bit
> >> >>
> >> >> The verifier can emit instructions to zero-extend destination regis=
ters
> >> >> when the register is being used to keep 32 bit values. This behavio=
ur is
> >> >> enabled only when the JIT sets bpf_jit_needs_zext() -> true. In the=
 case
> >> >> of a sign extended load instruction, the destination register alway=
s has a
> >> >> 64-bit value, therefore the verifier should not emit zero-extend
> >> >> instructions for it.
> >> >>
> >> >> Change is_reg64() to return true if the register under consideratio=
n is a
> >> >> destination register of LDX instruction with mode =3D BPF_MEMSX.
> >> >>
> >> >> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
> >> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >> >> ---
> >> >>  kernel/bpf/verifier.c | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> >> index bb78212fa5b2..93f84b868ccc 100644
> >> >> --- a/kernel/bpf/verifier.c
> >> >> +++ b/kernel/bpf/verifier.c
> >> >> @@ -3029,7 +3029,7 @@ static bool is_reg64(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
> >> >>
> >> >>         if (class =3D=3D BPF_LDX) {
> >> >>                 if (t !=3D SRC_OP)
> >> >> -                       return BPF_SIZE(code) =3D=3D BPF_DW;
> >> >> +                       return (BPF_SIZE(code) =3D=3D BPF_DW || BPF=
_MODE(code) =3D=3D BPF_MEMSX);
> >> >
> >> > Looks like we have a bug here for normal LDX too.
> >> > This 'if' condition was inserting unnecessary zext for LDX.
> >> > It was harmless for LDX and broken for LDSX.
> >> > Both LDX and LDSX write all bits of 64-bit register.
> >> >
> >> > I think the proper fix is to remove above two lines.
> >> > wdyt?
> >>
> >> For LDX this returns true only if it is with a BPF_DW, for others it r=
eturns false.
> >> This means a zext is inserted for BPF_LDX | BPF_B/H/W.
> >>
> >> This is not a bug because LDX writes 64 bits of the register only with=
 BPF_DW.
> >> With BPF_B/H/W It only writes the lower 32bits and needs zext for uppe=
r 32 bits.
> >
> > No. The interpreter writes all 64-bit for any LDX insn.
> > All JITs must do it as well.
> >
> >> On 32 bit architectures where a 64-bit BPF register is simulated with =
two 32-bit registers,
> >> explicit zext is required for BPF_LDX | BPF_B/H/W.
> >
> > zext JIT-aid done by the verifier has nothing to do with 32-bit archite=
cture.
> > It's necessary on 64-bit as well when HW doesn't automatically zero out
> > upper 32-bit like it does on arm64 and x86-64
>
> Yes, I agree that zext JIT-aid is required for all 32-bit architectures a=
nd some 64-bit architectures
> that can't automatically zero out the upper 32-bits.
> Basically any architecture that sets bpf_jit_needs_zext() -> true.
>
> >> So, we should not remove this.
> >
> > I still think we should.
>
> If we remove this then some JITs will not zero extend the upper 32-bits f=
or BPF_LDX | BPF_B/H/W.
>
> My understanding is that Verifier sets prog->aux->verifier_zext if it emi=
ts zext instructions. If the verifier
> doesn't emit zext for LDX but sets prog->aux->verifier_zext that would ca=
use wrong behavior for some JITs:
>
> Example code from ARM32 jit doing BPF_LDX | BPF_MEM | BPF_B:
>
> case BPF_B:
>                 /* Load a Byte */
>                 emit(ARM_LDRB_I(rd[1], rm, off), ctx);
>                 if (!ctx->prog->aux->verifier_zext)
>                         emit_a32_mov_i(rd[0], 0, ctx);
>                 break;
>
> Here if ctx->prog->aux->verifier_zext is set by the verifier, and zext wa=
s not emitted for LDX, JIT will not zero
> the upper 32-bits.
>
> RISCV32, PowerPC32, x86-32 JITs have similar code paths. Only MIPS32 JIT =
zero-extends for LDX without checking
> prog->aux->verifier_zext.
>
> So, if we want to stop emitting zext for LDX then we would need to modify=
 all these JITs to always zext for LDX.

I guess we never clearly defined what 'needs_zext' is supposed to be,
so it wouldn't be fair to call 32-bit JITs buggy.
But we better address this issue now.
This 32-bit zeroing after LDX hurts mips64, s390, ppc64, riscv64.
I believe all 4 JITs emit proper zero extension into 64-bit register
by using single cpu instruction,
but they also define bpf_jit_needs_zext() as true,
so extra BPF_ZEXT_REG() is added by the verifier
and it is a pure run-time overhead.

It's better to remove
if (t !=3D SRC_OP)
    return BPF_SIZE(code) =3D=3D BPF_DW;
from is_reg64() to avoid adding BPF_ZEXT_REG() insn
and fix 32-bit JITs at the same time.
RISCV32, PowerPC32, x86-32 JITs fixed in the first 3 patches
to always zero upper 32-bit after LDX and
then 4th patch to remove these two lines.

> Let me know if my understanding has some gaps, also if we decide to remov=
e it, I am happy to send patches for it
> and fix the JITs that need modifications.

Thank you for working on it!

cc-ing JIT experts.

