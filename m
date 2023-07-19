Return-Path: <bpf+bounces-5238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2F758B75
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 04:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554B428188E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490D17F9;
	Wed, 19 Jul 2023 02:44:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD75518E
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:44:26 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3C1BC3
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 19:44:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso100929211fa.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689734663; x=1692326663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGybBNtaN90OXDNavf/2NzzTFkKAYuYOkz8qJob9tGM=;
        b=A8WhcfBbEkYcM1S+yJ9Lt1W90LmWDPHra4IprZPjS8wo7Q/0WlpN1b+zY2Y3PXHSkB
         Ugcu081gyf3tbnIvJ4yDDmm2X5vBRnvuwkvT2F9MwAOp6zO6QSzEKiJOUNqhUxb+3FrU
         USDFuFKdkINYqqdU9rqWTSWWFnzkldpj5DReQEIfk0PKaCI4K/owEgu/Rn5v/0OKaYaL
         RHHr2jfiliCXdu5VYCroaGhZxjID5lddM1b/GRYcL6KmbQElBq+PhjavQJ+AF86jDF6w
         /moQVNmCKm7RwebepvgFs+50Oq09LCJHcGR8dH+oxaGJ2yWyzVhMhOSotQ+SUuvLOdVZ
         27NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689734663; x=1692326663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGybBNtaN90OXDNavf/2NzzTFkKAYuYOkz8qJob9tGM=;
        b=JvOKfFK5a0/nl/5U2olqutNKcnIfihoU2LBXyleT8y5+W73WHHI9yTaIEpdTsW2899
         mzvR8nJjBQCMdZOlAZMFZ2S7/ct7n8V9FdzeE8cOT7T9c8AR4fuWfzdb9tFeVu4wLwLF
         qIkad2YE64aZVcceHTXw73ENZATUs75gyBRnUF2ABBnfZXjeaiQFpNb4Z5G71tyObjRK
         vbIHHfTCGoIH1SOpzsEiaxsF2UE1Ito/rBRISM6wYuca1ZTLsVgx0+9T1Mvxfi2QLZOL
         rrT1kcq52dbnMQU8GnHGbWNoZASDANv09lJuVFGza/8Rfhv9xkjuZk1tdIVvFUAFiECA
         TVUQ==
X-Gm-Message-State: ABy/qLaqzE6y4ejpu6bs5r7rAxOm+PjzA3Pdg6VdnHWR/uwQ7ffazn1l
	W5X9W7WYpF/x7rhpBFEJ70ZFfsc8fayNLvdjGoE=
X-Google-Smtp-Source: APBJJlE6PE72hAB5r3TGyXU21BJWLqCPjt1S+w/45IQmqBbLGkV5ZswhM+WlNPsYxzPdptMA0YSK9/EC0cPjnXLVY64=
X-Received: by 2002:a2e:700b:0:b0:2b6:cff1:cd1c with SMTP id
 l11-20020a2e700b000000b002b6cff1cd1cmr11748235ljc.34.1689734663165; Tue, 18
 Jul 2023 19:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713060718.388258-1-yhs@fb.com> <20230713060744.390929-1-yhs@fb.com>
 <b8a16850c0482bf64f30b41c7dcb8b33ea6a6f61.camel@gmail.com> <5cdd79d3-d4c7-b119-ebcb-b8b143c79a01@meta.com>
In-Reply-To: <5cdd79d3-d4c7-b119-ebcb-b8b143c79a01@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 19:44:11 -0700
Message-ID: <CAADnVQJr+PWxBJSima_wJY1iqWaA51DRo32ct07W9BzOh1HoHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Support new signed div/mod instructions.
To: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song <maskray@google.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 7:31=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 7/18/23 4:00 PM, Eduard Zingerman wrote:
> > On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
> >> Add interpreter/jit support for new signed div/mod insns.
> >> The new signed div/mod instructions are encoded with
> >> unsigned div/mod instructions plus insn->off =3D=3D 1.
> >> Also add basic verifier support to ensure new insns get
> >> accepted.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   arch/x86/net/bpf_jit_comp.c | 27 +++++++----
> >>   kernel/bpf/core.c           | 96 ++++++++++++++++++++++++++++++-----=
--
> >>   kernel/bpf/verifier.c       |  6 ++-
> >>   3 files changed, 103 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index adda5e7626b4..3176b60d25c7 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -1194,15 +1194,26 @@ static int do_jit(struct bpf_prog *bpf_prog, i=
nt *addrs, u8 *image, u8 *rw_image
> >>                              /* mov rax, dst_reg */
> >>                              emit_mov_reg(&prog, is64, BPF_REG_0, dst_=
reg);
> >>
> >> -                    /*
> >> -                     * xor edx, edx
> >> -                     * equivalent to 'xor rdx, rdx', but one byte les=
s
> >> -                     */
> >> -                    EMIT2(0x31, 0xd2);
> >> +                    if (insn->off =3D=3D 0) {
> >> +                            /*
> >> +                             * xor edx, edx
> >> +                             * equivalent to 'xor rdx, rdx', but one =
byte less
> >> +                             */
> >> +                            EMIT2(0x31, 0xd2);
> >>
> >> -                    /* div src_reg */
> >> -                    maybe_emit_1mod(&prog, src_reg, is64);
> >> -                    EMIT2(0xF7, add_1reg(0xF0, src_reg));
> >> +                            /* div src_reg */
> >> +                            maybe_emit_1mod(&prog, src_reg, is64);
> >> +                            EMIT2(0xF7, add_1reg(0xF0, src_reg));
> >> +                    } else {
> >> +                            if (BPF_CLASS(insn->code) =3D=3D BPF_ALU)
> >> +                                    EMIT1(0x99); /* cltd */
> >> +                            else
> >> +                                    EMIT2(0x48, 0x99); /* cqto */
> >
> > Nitpick: I can't find names cltd/cqto in the Intel instruction manual,
> >           instead it uses names cdq/cqo for these instructions.
> >           (See Vol. 2A pages 3-315 and 3-497)
>
> I got these asm names from
>    https://defuse.ca/online-x86-assembler.htm
> I will check the Intel insn manual and make the change
> accordingly.

Heh. I've been using the same.
Most of the comments in the x86 JIT code are from there :)

and it actually returns 99 -> cdq, 4899 -> cqo

cltd/cqto must be aliases ?

