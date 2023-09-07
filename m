Return-Path: <bpf+bounces-9461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB5A797EE0
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 00:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41440281769
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 22:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12C14296;
	Thu,  7 Sep 2023 22:57:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962114271
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 22:57:19 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887C3CF3
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 15:57:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so23995391fa.3
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127436; x=1694732236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rmCgy9k65cDyyCUgZjWJRONOtRKSEpVK7j5rcM42b0=;
        b=Y2msG2FVwVPQQ7BFifbsp/jNGrpJJD/EO4q1sv2O5rowReJqjuEpXFsmAB9CwTlSJt
         lVjkZYrU4yJ3axcmQyIkG7f2ODoguhy3wzEtIcWaaQ1w6Piy6Sk0Wor/3uXgKIXYKEdB
         vdd1crCdxjgJGvWeqVrXkoWY84nabkP7WXSvbE+QyGnlLXCagh8lkdPdmj/zwHJTCJDq
         zXiPgRf66VUVOxQ6UXmu0/jKcYclfyR7kqg1+FmUcALVHSz8m6AgbLcoNra/3PAtvXvd
         LZFyS9vd53koARG3Pjai3K4SoopMf34eQqwbcIYxpIF2aoo7dbqt4PEY8b4p02RZDy6e
         0xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127436; x=1694732236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rmCgy9k65cDyyCUgZjWJRONOtRKSEpVK7j5rcM42b0=;
        b=Rc2HFimfPvjtYF/zhUvgd0kmGmKeqCRnTJVlmKrgVYrBekfjz74wBzMPlQdVCZXuDZ
         EkOaoL3eIY1yVN/hEL3dj/Rixc3/wXT2Ljs+DmicLeM96wPwbKJUjtUAjxkn43Mkz7nO
         qOFrdcE57x7K5jIhSGpuzh/MKopEFhotZi8qPJTIIQdpWUJ7Pfok1qwaPA2uiF3tkcYB
         SXuyFQoTqsH2Ka/X9ngiXFKU57unhq+mVqxD1I6fT0D16D+jeTVQuyWaorqLr/z0g6la
         yun/klIwYp9eXCc/YQU53ugNHoDpGnQhsSJBInybQDl/MKdooKC2Wohvl909ZK4erKCb
         1uNQ==
X-Gm-Message-State: AOJu0Yx19JMlTWqNdaYR0uGBnp3y0ZUaWFldTSOKl+Cdbe3l0UnZDO1y
	g5sonFSC0KTgRmXq49ed1bV4MbAQ0/lMhMrhhG8=
X-Google-Smtp-Source: AGHT+IELW6O7gRlesq279tV0/Xh0ouzelk74yvfFc3rvRbX6PRgYiG1Db5elIawxZvrT653KIkay7QjhY3/kwdnXres=
X-Received: by 2002:a2e:3815:0:b0:2bc:bc7e:e2df with SMTP id
 f21-20020a2e3815000000b002bcbc7ee2dfmr390686lja.33.1694127435388; Thu, 07 Sep
 2023 15:57:15 -0700 (PDT)
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
In-Reply-To: <CAADnVQ+ccoQrTcOZW_BZXMv2A+uYEYdHqx0tSVgXK31vGS=+gA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 8 Sep 2023 00:57:04 +0200
Message-ID: <CANk7y0j2f-gPgZwd+YfTL71-6wfvky+f=kBC_ccqsS0EHAysyA@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 12:45=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 7, 2023 at 9:39=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
> >
> > On Thu, Sep 07 2023, Alexei Starovoitov wrote:
> >
> > > On Thu, Sep 7, 2023 at 12:33=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > >>
> > >> On Wed, Sep 06 2023, Alexei Starovoitov wrote:
> > >>
> > >> > On Fri, Sep 1, 2023 at 7:57=E2=80=AFAM Puranjay Mohan <puranjay12@=
gmail.com> wrote:
> > >> >>
> > >> >> On Fri, Sep 01 2023, Puranjay Mohan wrote:
> > >> >>
> > >> >> > The problem here is that reg->subreg_def should be set as DEF_N=
OT_SUBREG for
> > >> >> > registers that are used as destination registers of BPF_LDX |
> > >> >> > BPF_MEMSX. I am seeing
> > >> >> > the same problem on ARM32 and was going to send a patch today.
> > >> >> >
> > >> >> > The problem is that is_reg64() returns false for destination re=
gisters
> > >> >> > of BPF_LDX | BPF_MEMSX.
> > >> >> > But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of =
the
> > >> >> > sign extension so
> > >> >> > is_reg64() should return true.
> > >> >> >
> > >> >> > I have written a patch that I will be sending as a reply to thi=
s.
> > >> >> > Please let me know if that makes sense.
> > >> >> >
> > >> >>
> > >> >> The check_reg_arg() function will mark reg->subreg_def =3D DEF_NO=
T_SUBREG for destination
> > >> >> registers if is_reg64() returns true for these registers. My patc=
h below make is_reg64()
> > >> >> return true for destination registers of BPF_LDX with mod =3D BPF=
_MEMSX. I feel this is the
> > >> >> correct way to fix this problem.
> > >> >>
> > >> >> Here is my patch:
> > >> >>
> > >> >> --- 8< ---
> > >> >> From cf1bf5282183cf721926ab14d968d3d4097b89b8 Mon Sep 17 00:00:00=
 2001
> > >> >> From: Puranjay Mohan <puranjay12@gmail.com>
> > >> >> Date: Fri, 1 Sep 2023 11:18:59 +0000
> > >> >> Subject: [PATCH bpf] bpf: verifier: mark destination of sign-exte=
nded load as
> > >> >>  64 bit
> > >> >>
> > >> >> The verifier can emit instructions to zero-extend destination reg=
isters
> > >> >> when the register is being used to keep 32 bit values. This behav=
iour is
> > >> >> enabled only when the JIT sets bpf_jit_needs_zext() -> true. In t=
he case
> > >> >> of a sign extended load instruction, the destination register alw=
ays has a
> > >> >> 64-bit value, therefore the verifier should not emit zero-extend
> > >> >> instructions for it.
> > >> >>
> > >> >> Change is_reg64() to return true if the register under considerat=
ion is a
> > >> >> destination register of LDX instruction with mode =3D BPF_MEMSX.
> > >> >>
> > >> >> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns"=
)
> > >> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > >> >> ---
> > >> >>  kernel/bpf/verifier.c | 2 +-
> > >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> >>
> > >> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> >> index bb78212fa5b2..93f84b868ccc 100644
> > >> >> --- a/kernel/bpf/verifier.c
> > >> >> +++ b/kernel/bpf/verifier.c
> > >> >> @@ -3029,7 +3029,7 @@ static bool is_reg64(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
> > >> >>
> > >> >>         if (class =3D=3D BPF_LDX) {
> > >> >>                 if (t !=3D SRC_OP)
> > >> >> -                       return BPF_SIZE(code) =3D=3D BPF_DW;
> > >> >> +                       return (BPF_SIZE(code) =3D=3D BPF_DW || B=
PF_MODE(code) =3D=3D BPF_MEMSX);
> > >> >
> > >> > Looks like we have a bug here for normal LDX too.
> > >> > This 'if' condition was inserting unnecessary zext for LDX.
> > >> > It was harmless for LDX and broken for LDSX.
> > >> > Both LDX and LDSX write all bits of 64-bit register.
> > >> >
> > >> > I think the proper fix is to remove above two lines.
> > >> > wdyt?
> > >>
> > >> For LDX this returns true only if it is with a BPF_DW, for others it=
 returns false.
> > >> This means a zext is inserted for BPF_LDX | BPF_B/H/W.
> > >>
> > >> This is not a bug because LDX writes 64 bits of the register only wi=
th BPF_DW.
> > >> With BPF_B/H/W It only writes the lower 32bits and needs zext for up=
per 32 bits.
> > >
> > > No. The interpreter writes all 64-bit for any LDX insn.
> > > All JITs must do it as well.
> > >
> > >> On 32 bit architectures where a 64-bit BPF register is simulated wit=
h two 32-bit registers,
> > >> explicit zext is required for BPF_LDX | BPF_B/H/W.
> > >
> > > zext JIT-aid done by the verifier has nothing to do with 32-bit archi=
tecture.
> > > It's necessary on 64-bit as well when HW doesn't automatically zero o=
ut
> > > upper 32-bit like it does on arm64 and x86-64
> >
> > Yes, I agree that zext JIT-aid is required for all 32-bit architectures=
 and some 64-bit architectures
> > that can't automatically zero out the upper 32-bits.
> > Basically any architecture that sets bpf_jit_needs_zext() -> true.
> >
> > >> So, we should not remove this.
> > >
> > > I still think we should.
> >
> > If we remove this then some JITs will not zero extend the upper 32-bits=
 for BPF_LDX | BPF_B/H/W.
> >
> > My understanding is that Verifier sets prog->aux->verifier_zext if it e=
mits zext instructions. If the verifier
> > doesn't emit zext for LDX but sets prog->aux->verifier_zext that would =
cause wrong behavior for some JITs:
> >
> > Example code from ARM32 jit doing BPF_LDX | BPF_MEM | BPF_B:
> >
> > case BPF_B:
> >                 /* Load a Byte */
> >                 emit(ARM_LDRB_I(rd[1], rm, off), ctx);
> >                 if (!ctx->prog->aux->verifier_zext)
> >                         emit_a32_mov_i(rd[0], 0, ctx);
> >                 break;
> >
> > Here if ctx->prog->aux->verifier_zext is set by the verifier, and zext =
was not emitted for LDX, JIT will not zero
> > the upper 32-bits.
> >
> > RISCV32, PowerPC32, x86-32 JITs have similar code paths. Only MIPS32 JI=
T zero-extends for LDX without checking
> > prog->aux->verifier_zext.
> >
> > So, if we want to stop emitting zext for LDX then we would need to modi=
fy all these JITs to always zext for LDX.
>
> I guess we never clearly defined what 'needs_zext' is supposed to be,
> so it wouldn't be fair to call 32-bit JITs buggy.
> But we better address this issue now.
> This 32-bit zeroing after LDX hurts mips64, s390, ppc64, riscv64.
> I believe all 4 JITs emit proper zero extension into 64-bit register
> by using single cpu instruction,
> but they also define bpf_jit_needs_zext() as true,
> so extra BPF_ZEXT_REG() is added by the verifier
> and it is a pure run-time overhead.
>
> It's better to remove
> if (t !=3D SRC_OP)
>     return BPF_SIZE(code) =3D=3D BPF_DW;
> from is_reg64() to avoid adding BPF_ZEXT_REG() insn
> and fix 32-bit JITs at the same time.
> RISCV32, PowerPC32, x86-32 JITs fixed in the first 3 patches
> to always zero upper 32-bit after LDX and
> then 4th patch to remove these two lines.
>
> > Let me know if my understanding has some gaps, also if we decide to rem=
ove it, I am happy to send patches for it
> > and fix the JITs that need modifications.
>
> Thank you for working on it!
>
> cc-ing JIT experts.

Thanks for the detailed explanation. I agree with this approach.
I will be sending the patches for this soon.

Thanks,
Puranjay

