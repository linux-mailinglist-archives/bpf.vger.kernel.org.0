Return-Path: <bpf+bounces-6227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CCE76729D
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44101C20CEB
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D5E156CD;
	Fri, 28 Jul 2023 16:58:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D113FEC
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:58:43 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B901B5
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:58:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31297125334so1628379f8f.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690563519; x=1691168319;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1rDph/ilI0FwAW+BQ2mqWWYLcbL4mKMHiE4xhFPgW7Q=;
        b=hQVYUUjo/WN9KOMOikMP189nEe9lGIqeHSWLkQf87f2b8ltNBeorTRUi2s5M9zI/nU
         tx1tJK0TCPj7Fut3Bq9XvA2K/2FcvATwf/GZvdU4kRxc9HXCajtgwSD7J27WmeNUAqPM
         s1TEWGmIWFwovvLW6PncOHlQoA9Qnbkw06ummQ2ZJo2ZNR8vXIHZAvQWX2CgAZHJOtb4
         xp44Ay7G/h69hmYmyPm4phzDKAjRixO6rwrTNqXC+UTDq9ZP/OTaLYc0ZPnWq7KnHYXR
         28LHVzIwklZgiDg78apIitRt1fQen03FFIO6mzpKi0A4BkE+ZWM2KEGK/8qWpFQ5j5gV
         ak7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690563519; x=1691168319;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rDph/ilI0FwAW+BQ2mqWWYLcbL4mKMHiE4xhFPgW7Q=;
        b=ON1AjY6d7mpZhlgH1iQTGu5bDIeA4B3P6tr7hG28WD617ATK7r4A5gtiJmDKDU3EI7
         WC1PPv3NV2fr17tP7DD/S0rlgXEE809bTJaVNGb/REny6tzDW5RYr94GlEvl6t1Bko9A
         A+sgggpy2H9Z/IWplXOZfVx/FqsaDF7kejJ7pwyDuCEzWCUmOFbrxnaPdCBRQdGcddhX
         ZLpDwWfEWTJv3Bn5aPcKXXA8m1wKjrUnBYUW+M6hYozF3S1CGp7cuYMQ5S7Hb9dj2xtg
         x79m7WkQoB/+9qT+78wqf14mwvQ42mTJKwwT3g/t1vDaZ0Hg2HyLvEMyPHZtyvACWvt0
         /95A==
X-Gm-Message-State: ABy/qLbia8bu8VmbAGod0OBVLyp+rh4MAnYCUZQydBAfPGqOQNLPsjKq
	HuXPdCPR6xF+9JNQ939Npnw=
X-Google-Smtp-Source: APBJJlEPxjGArDzcdaDY83+do02dct//a6tUJqqjmsOJsEsXLJvJsYSDqmrGTK4CahusUWaM+gZ9Ag==
X-Received: by 2002:adf:fdce:0:b0:317:5d76:1d1a with SMTP id i14-20020adffdce000000b003175d761d1amr2549930wrs.8.1690563519401;
        Fri, 28 Jul 2023 09:58:39 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d50c3000000b00317909f9985sm995362wrt.113.2023.07.28.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:58:38 -0700 (PDT)
Message-ID: <f8d9ec82dd2da5fc5d18228e70bfe68f959d7ed1.camel@gmail.com>
Subject: Re: Register encoding in assembly for load/store instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,  "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>
Date: Fri, 28 Jul 2023 19:58:37 +0300
In-Reply-To: <d10ca36d-7ae6-90bf-8c2a-671cafe8f5fb@linux.dev>
References: <87ila7dhmp.fsf@oracle.com>
	 <5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev>
	 <87o7jzbz0z.fsf@oracle.com>
	 <146bc14b-e15c-6e62-1fa0-4e9e67c974c9@linux.dev>
	 <87zg3jah2s.fsf@oracle.com>
	 <6a102de2-2bd4-6933-e901-de00cda10045@linux.dev>
	 <87v8e78w63.fsf@oracle.com>
	 <CAADnVQLDGUSSCkhxjgt6bxxN7hOh7L-86-wzESp2Oo8SQ91hOg@mail.gmail.com>
	 <a1371ac96bdca45a07366868d331410a9836204e.camel@gmail.com>
	 <d10ca36d-7ae6-90bf-8c2a-671cafe8f5fb@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 21:16 -0700, Yonghong Song wrote:
>=20
> On 7/25/23 5:39 PM, Eduard Zingerman wrote:
> > On Tue, 2023-07-25 at 17:31 -0700, Alexei Starovoitov wrote:
> > > On Tue, Jul 25, 2023 at 3:28=E2=80=AFPM Jose E. Marchesi
> > > <jose.marchesi@oracle.com> wrote:
> > > >=20
> > > >=20
> > > > > On 7/25/23 1:09 PM, Jose E. Marchesi wrote:
> > > > > >=20
> > > > > > > On 7/25/23 11:56 AM, Jose E. Marchesi wrote:
> > > > > > > >=20
> > > > > > > > > On 7/25/23 10:29 AM, Jose E. Marchesi wrote:
> > > > > > > > > > Hello Yonghong.
> > > > > > > > > > We have noticed that the llvm disassembler uses differe=
nt notations
> > > > > > > > > > for
> > > > > > > > > > registers in load and store instructions, depending som=
ehow on the width
> > > > > > > > > > of the data being loaded or stored.
> > > > > > > > > > For example, this is an excerpt from the assembler-disa=
ssembler.s
> > > > > > > > > > test
> > > > > > > > > > file in llvm:
> > > > > > > > > >       // Note: For the group below w1 is used as a dest=
ination for
> > > > > > > > > > sizes u8, u16, u32.
> > > > > > > > > >       //       This is disassembler quirk, but is techn=
ically not wrong, as there are
> > > > > > > > > >       //       no different encodings for 'r1 =3D load'=
 vs 'w1 =3D load'.
> > > > > > > > > >       //
> > > > > > > > > >       // CHECK: 71 21 2a 00 00 00 00 00   w1 =3D *(u8 *=
)(r2 + 0x2a)
> > > > > > > > > >       // CHECK: 69 21 2a 00 00 00 00 00   w1 =3D *(u16 =
*)(r2 + 0x2a)
> > > > > > > > > >       // CHECK: 61 21 2a 00 00 00 00 00   w1 =3D *(u32 =
*)(r2 + 0x2a)
> > > > > > > > > >       // CHECK: 79 21 2a 00 00 00 00 00   r1 =3D *(u64 =
*)(r2 + 0x2a)
> > > > > > > > > >       r1 =3D *(u8*)(r2 + 42)
> > > > > > > > > >       r1 =3D *(u16*)(r2 + 42)
> > > > > > > > > >       r1 =3D *(u32*)(r2 + 42)
> > > > > > > > > >       r1 =3D *(u64*)(r2 + 42)
> > > > > > > > > > The comment there clarifies that the usage of wN instea=
d of rN in
> > > > > > > > > > the
> > > > > > > > > > u8, u16 and u32 cases is a "disassembler quirk".
> > > > > > > > > > Anyway, the problem is that it seems that `clang -S' ac=
tually emits
> > > > > > > > > > these forms with wN.
> > > > > > > > > > Is that intended?
> > > > > > > > >=20
> > > > > > > > > Yes, this is intended since alu32 mode is enabled where
> > > > > > > > > w* registers are used for 8/16/32 bit load.
> > > > > > > > So then why suppporting 'r1 =3D 8948 8*9r2 + 0x2a)'?  The m=
ode is
> > > > > > > > still
> > > > > > > > alu32 mode.  Isn't the u{8,16,32} part enough to discrimina=
te?
> > > > > > >=20
> > > > > > > What does this 'r1 =3D 8948 8*9r2 + 0x2a)' mean?
> > > > > > >=20
> > > > > > > For u8/u16/u32 loads, if objdump with option to indicate alu3=
2 mode,
> > > > > > > then w* register is used. If no alu32 mode for objdump, then =
r* register
> > > > > > > is used. Basically the same insn, disasm is different dependi=
ng on
> > > > > > > alu32 mode or not. u8/u16/u32 is not enough to differentiate.
> > > > > > Ok, so the llvm objdump has a switch that tells when to use rN =
or wN
> > > > > > when printing these particular instructions.  Thats the "disass=
embler
> > > > > > quirk".  To what purpose?  Isnt the person passing the command =
line
> > > > > > switch the same person reading the disassembled program?  Is th=
is "alu32
> > > > > > mode" more than a cosmetic thing?
> > > > > > But what concern us is the assembler, not the disassembler.
> > > > > > clang -S (which is not objdump) seems to generate these instruc=
tions
> > > > > > with wN (see https://godbolt.org/z/5G433Yvrb for a store instru=
ction for
> > > > > > example) and we assume the output of clang -S is intended to be=
 passed
> > > > > > to an assembler, much like with gcc -S.
> > > > > > So, should we support both syntaxes as _input_ syntax in the
> > > > > > assembler?
> > > > >=20
> > > > > Considering -mcpu=3Dv3 is recommended cpu flavor (at least in bpf=
 mailing
> > > > > list), and -mcpu=3Dv3 has alu32 enabled by default. So I think
> > > > > gcc can start to emit insn assuming alu32 mode is on by default.
> > > > > So
> > > > >     w1 =3D *(u8 *)(r2 + 42)
> > > > > is preferred.
> > > >=20
> > > > We have V4 by default now.  So we can emit
> > > >=20
> > > >    w1 =3D *(u8 *)(r2 + 42)
> > > >=20
> > > > when -mcpu is v3 or higher, or if -malu32 is specified, and
> > > >=20
> > > >    r1 =3D *(u8 *)(r2 + 42)
> > > >=20
> > > > when -mcpu is v2 or lower, or if -mnoalu32 is specified.
> > > >=20
> > > > Sounds good?
> > > >=20
> > > > However this implies that the assembler should indeed recognize bot=
h
> > > > forms of instructions.  But note that it will assembly them to the
> > > > exactly same encoded instruction.  This includes inline asm (rememb=
er
> > > > GCC does not have an integrated assembler.)
> > >=20
> > > Good point.
> > > I think we made a mistake in clang.
> > > We shouldn't be printing
> > > w1 =3D *(u8 *)(r2 + 42)
> > > since such instruction doesn't exist in BPF ISA
> > > and it's confusing.
> > > There is only one instruction:
> > > r1 =3D *(u8 *)(r2 + 42)
> > > which is an 8-bit load that zero extends into 64-bit.
> > > x86 JIT actually implements it as 8-bit load that stores
> > > into a 32-bit subregister, so it kinda matches w1,
> > > but that's an implementation detail of the JIT.
> > >=20
> > > I think both gcc and clang should always print r1 =3D *(u8 *)(r2 + 42=
)
> > > regardless of alu32 or not.
> > > In gas and clang assembler we can support both w1=3D and r1=3D
> > > flavors for backward compat.
> > >=20
> >=20
> > I agree with Alexei (the ... disassembler quirk ... comment is left by =
me :).
> > Can dig into clang part of things if this is a consensus.
>=20
> For disassembler, we have stx as well may use w* registers with alu32.
> In llvm BPFDisassembler.cpp, we have
>=20
>    if ((InstClass =3D=3D BPF_LDX || InstClass =3D=3D BPF_STX) &&
>        getInstSize(Insn) !=3D BPF_DW &&
>        (InstMode =3D=3D BPF_MEM || InstMode =3D=3D BPF_ATOMIC) &&
>        STI.hasFeature(BPF::ALU32))
>      Result =3D decodeInstruction(DecoderTableBPFALU3264, Instr, Insn,=
=20
> Address,
>                                 this, STI);
>    else
>      Result =3D decodeInstruction(DecoderTableBPF64, Instr, Insn, Address=
,=20
> this,
>                                 STI);
>=20
> Maybe we should just do
>=20
>    Result =3D decodeInstruction(DecoderTableBPF64, Instr, Insn, Address,=
=20
> this, STI);
>=20
> So we already disassemble based on non-alu32 mode?
>=20

Yonghong, Alexei,

I have a prototype [1] that consolidates STW/STW32, LDW/LDW32 etc
instructions in LLVM BPF backend, thus removing the syntactic
difference. I think it simplifies BPFInstrInfo.td a bit but that's up
to debate.

Should I proceed with it?

[1] https://reviews.llvm.org/D156559

